-- Schema for Domain: refining | Business: Oil Gas | Version: v1_ecm
-- Generated on: 2026-05-04 05:08:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`refining` COMMENT 'Manages crude oil refining operations including CDU/VDU throughput, FCC unit performance, HDS operations, yield optimization, TAN and RON quality metrics, refinery scheduling, feedstock blending, and product slate planning. Owns process unit performance data and refinery configuration. Supports EPA emissions compliance and API refining standards. Integrates with Aspen HYSYS process simulation and DCS control systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`refinery` (
    `refinery_id` BIGINT COMMENT 'Unique identifier for the refinery facility. Primary key for the refinery master record.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Refineries execute capital projects (unit expansions, environmental upgrades, reliability improvements) under AFE authorization. Real capex governance requires AFE linkage at facility level for budget',
    `aspen_hysys_model_id` BIGINT COMMENT 'Unique identifier for the refinery process simulation model in Aspen HYSYS. Links the physical refinery to its digital twin for optimization and scenario planning.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Refinery master table must link to corporate asset register for asset management integration. Real business process: refinery-level asset tracking, depreciation calculation, asset retirement obligatio',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Refineries are cost centers in financial accounting. Every refinery must roll up operating costs to a cost center for P&L reporting, budget variance analysis, and management accounting. Standard pract',
    `objective_id` BIGINT COMMENT 'Foreign key linking to hse.objective. Business justification: HSE objectives (TRIR targets, emissions reductions) are set at facility level. Management systems require refinery-to-objective linkage for performance tracking, management review, and ESG reporting (',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Refineries operated under joint operating agreements require JOA linkage for partner cost allocation, overhead rate application, AFE approval thresholds, and JIB billing. JOA terms govern operational ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Refineries have designated operations managers accountable for facility performance, HSE compliance, regulatory reporting, and operational excellence. Critical for org charts, management reporting, in',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Refineries require operating licenses from state/federal authorities authorizing petroleum refining operations. This is the master regulatory authorization that governs facility operations, distinct f',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Refineries operate under multiple regulatory permits (Title V air permits, NPDES wastewater permits, RCRA hazardous waste permits). EPA facility IDs and state permit numbers are denormalized reference',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Refineries are configured and licensed to produce specific primary petroleum products (gasoline, diesel, jet fuel). Essential for regulatory compliance reporting, production planning, and commercial s',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Refineries are profit centers for segment reporting and margin analysis. SEC reporting, management dashboards, and investment decisions require linking refinery operations to profit center structure f',
    `alkylation_unit_count` STRING COMMENT 'Number of alkylation units installed at the refinery. Alkylation units combine light olefins with isobutane to produce high-octane gasoline blending components.',
    `api_facility_number` STRING COMMENT 'Facility registration number assigned by the American Petroleum Institute for industry reporting and standards compliance.',
    `cdu_unit_count` STRING COMMENT 'Number of crude distillation units installed at the refinery. CDUs perform the primary separation of crude oil into fractions based on boiling point ranges.',
    `city` STRING COMMENT 'City or municipality where the refinery facility is located.',
    `coker_unit_count` STRING COMMENT 'Number of delayed coking units installed at the refinery. Cokers thermally crack heavy residual oils into lighter products and petroleum coke.',
    `commissioning_date` DATE COMMENT 'Date when the refinery facility was officially commissioned and began commercial operations. Used for asset lifecycle tracking and depreciation calculations.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country where the refinery is located. Used for regulatory compliance, tax jurisdiction, and international reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this refinery master record was first created in the system. Used for data lineage and audit trail purposes.',
    `dcs_system_code` STRING COMMENT 'Unique identifier for the refinery distributed control system. Links the refinery master record to real-time process control and SCADA data.',
    `facility_type` STRING COMMENT 'Classification of the refinery based on its processing complexity and unit configuration. Integrated refineries have full conversion capabilities, hydroskimming refineries have basic distillation, conversion refineries focus on upgrading heavy crude, and specialty refineries produce niche products.. Valid values are `integrated_refinery|hydroskimming|conversion|specialty`',
    `fcc_unit_count` STRING COMMENT 'Number of fluid catalytic cracking units installed at the refinery. FCC units convert heavy gas oils into lighter, more valuable products such as gasoline and light olefins using catalytic cracking.',
    `hds_unit_count` STRING COMMENT 'Number of hydrodesulfurization units installed at the refinery. HDS units remove sulfur from petroleum fractions to meet environmental regulations and product specifications.',
    `hydrocracker_unit_count` STRING COMMENT 'Number of hydrocracking units installed at the refinery. Hydrocrackers use hydrogen and catalysts to break down heavy oils into lighter, higher-value products.',
    `is_tier_3_compliant` BOOLEAN COMMENT 'Indicates whether the refinery meets EPA Tier 3 gasoline sulfur standards requiring sulfur content below 10 ppm. Critical for regulatory compliance and product marketing.',
    `is_ulsd_capable` BOOLEAN COMMENT 'Indicates whether the refinery has the capability to produce ultra-low sulfur diesel with sulfur content below 15 ppm as required by EPA regulations.',
    `last_turnaround_date` DATE COMMENT 'Date of the most recent major turnaround or planned maintenance shutdown. Turnarounds are comprehensive maintenance events that occur every 3-5 years.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the refinery facility in decimal degrees. Used for mapping, logistics planning, and regulatory jurisdiction determination.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the refinery facility in decimal degrees. Used for mapping, logistics planning, and regulatory jurisdiction determination.',
    `nameplate_capacity_bopd` DECIMAL(18,2) COMMENT 'Maximum designed crude oil processing capacity of the refinery measured in barrels of oil per day under optimal operating conditions. This is the theoretical maximum throughput as designed by the engineering team.',
    `nelson_complexity_index` DECIMAL(18,2) COMMENT 'Industry-standard measure of refinery complexity based on the relative cost and sophistication of processing units. Higher values indicate more complex refineries with greater conversion and upgrading capabilities. Typical range is 1.0 to 15.0.',
    `next_turnaround_date` DATE COMMENT 'Planned date for the next major turnaround or maintenance shutdown. Used for maintenance planning, budgeting, and production forecasting.',
    `operational_status` STRING COMMENT 'Current operational state of the refinery facility. Operating indicates normal production, turnaround indicates scheduled maintenance shutdown, idle indicates temporary suspension, decommissioned indicates permanent closure, and under construction indicates facility is being built.. Valid values are `operating|turnaround|idle|decommissioned|under_construction`',
    `ownership_type` STRING COMMENT 'Legal ownership structure of the refinery facility. Wholly owned indicates 100% ownership by Oil Gas, joint venture indicates shared ownership with partners, leased indicates the facility is leased from another party, and operated indicates Oil Gas operates but does not own the facility.. Valid values are `wholly_owned|joint_venture|leased|operated`',
    `pi_system_site_name` STRING COMMENT 'Site name in the OSIsoft PI System historian that stores real-time and historical process data for this refinery. Used for data integration and analytics.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the refinery facility location.',
    `primary_feedstock_type` STRING COMMENT 'Predominant type of crude oil feedstock processed by the refinery. Light sweet crude has low sulfur and high API gravity, medium sour has moderate sulfur, heavy sour has high sulfur and low API gravity, synthetic is from oil sands, and blended is a mix of multiple crude types.. Valid values are `light_sweet|medium_sour|heavy_sour|synthetic|blended`',
    `refinery_code` STRING COMMENT 'Short alphanumeric code used to identify the refinery in operational systems, reports, and inter-facility communications. Typically 3-10 characters.. Valid values are `^[A-Z0-9]{3,10}$`',
    `refinery_name` STRING COMMENT 'Official business name of the refinery facility as registered with regulatory authorities and used in operational reporting.',
    `reformer_unit_count` STRING COMMENT 'Number of catalytic reforming units installed at the refinery. Reformers convert low-octane naphtha into high-octane gasoline blending components and produce hydrogen as a byproduct.',
    `renewable_diesel_capacity_bopd` DECIMAL(18,2) COMMENT 'Maximum production capacity for renewable diesel from bio-based feedstocks measured in barrels per day. Zero if the refinery does not have renewable diesel capability.',
    `state_province` STRING COMMENT 'State, province, or primary administrative division where the refinery facility is located. Used for regulatory jurisdiction and tax purposes.',
    `street_address` STRING COMMENT 'Physical street address of the refinery facility including street number, street name, and any building or unit identifiers.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the refinery location. Used for scheduling, shift management, and timestamp normalization in operational reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this refinery master record was last modified. Used for change tracking and data quality monitoring.',
    `vdu_unit_count` STRING COMMENT 'Number of vacuum distillation units installed at the refinery. VDUs further process atmospheric residue from CDUs under vacuum to extract additional valuable products.',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'Percentage of ownership interest held by Oil Gas in the refinery facility. Used for financial reporting, cost allocation, and revenue distribution in joint venture arrangements.',
    CONSTRAINT pk_refinery PRIMARY KEY(`refinery_id`)
) COMMENT 'Master record for each refinery facility operated by Oil Gas, capturing nameplate capacity (BOPD), Nelson Complexity Index, CDU/VDU/FCC/HDS unit counts, geographic location, regulatory registration numbers (EPA facility ID, state permits), operational status, and integration references to Aspen HYSYS and DCS control systems. Serves as the SSOT for refinery identity and configuration. All process units, schedules, turnarounds, and operational records reference this entity.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`process_unit` (
    `process_unit_id` BIGINT COMMENT 'Unique identifier for the refinery process unit. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the parent refinery facility where this process unit is located.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Process units (CDU, FCC, hydrocracker) are cost centers for activity-based costing. Unit-level cost tracking enables variance analysis, benchmarking, and optimization decisions. Standard refining acco',
    `hse_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.hse_risk_assessment. Business justification: Process hazard analysis (PHA) per OSHA PSM assesses unit-specific risks (HAZOP, LOPA). Risk registers are organized by process unit for management of change, pre-startup safety reviews, and revalidati',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Process units in JV refineries need JOA linkage for unit-level capital project approvals, turnaround AFE authorization, and partner cost sharing. JOA voting thresholds apply to major unit modification',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Individual process units (FCC, hydrocracker, coker) require specific air emission permits under EPA Title V and state regulations. Each unit has emission limits, monitoring requirements, and complianc',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to hse.permit_to_work. Business justification: Permits to work authorize maintenance and operations on specific process units. Operational safety management systems require linking permits to units for isolation verification, energy control, and s',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Process units are designed for specific product outputs (FCC→gasoline, HDS→low-sulfur diesel, hydrocracker→jet fuel). Critical for unit performance KPIs, production planning, LP optimization models, a',
    `refinery_id` BIGINT COMMENT 'FK to refining.refinery.refinery_id — MUST-HAVE: Enables linking process units to their parent refinery for capacity planning, turnaround scheduling, and yield optimization. Fundamental parent-child relationship.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each process unit (CDU, FCC, HDS, hydrocracker) has a designated shift supervisor responsible for safe operations, alarm response, and unit performance. Essential for shift handovers, incident investi',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this process unit record is currently active in the system.',
    `alarm_acknowledgment_status` STRING COMMENT 'Current acknowledgment state of the alarm indicating whether it has been seen and acted upon by an operator.. Valid values are `Unacknowledged|Acknowledged|Cleared|Shelved`',
    `alarm_priority` STRING COMMENT 'Priority level assigned to the alarm indicating urgency of operator response required.. Valid values are `Critical|High|Medium|Low`',
    `alarm_root_cause_classification` STRING COMMENT 'Categorization of the underlying cause of the alarm for trend analysis and continuous improvement (e.g., equipment malfunction, process upset, operator error, design issue).',
    `alarm_setpoint` DECIMAL(18,2) COMMENT 'Threshold value at which the alarm is triggered.',
    `alarm_shelving_expiry_timestamp` TIMESTAMP COMMENT 'Date and time when the alarm shelving will automatically expire and the alarm will be re-enabled.',
    `alarm_shelving_reason` STRING COMMENT 'Business justification for shelving the alarm, required for audit and compliance purposes.',
    `alarm_shelving_status` BOOLEAN COMMENT 'Indicates whether the alarm has been temporarily suppressed (shelved) to prevent nuisance alarms during abnormal operations.',
    `alarm_tag` STRING COMMENT 'Unique identifier for the process alarm in the DCS or alarm management system.',
    `alarm_type` STRING COMMENT 'Classification of the alarm based on the condition being monitored (high limit, low limit, deviation from setpoint, rate of change, equipment failure, or safety-critical event).. Valid values are `High|Low|Deviation|Rate-of-Change|Equipment-Failure|Safety-Critical`',
    `aspen_hysys_model_reference` STRING COMMENT 'Reference identifier to the Aspen HYSYS process simulation model for this unit used for optimization and planning.',
    `capacity_constraint_description` STRING COMMENT 'Description of any operational constraints that limit the unit from achieving design capacity (e.g., downstream bottleneck, feedstock quality, equipment degradation).',
    `capacity_unit` STRING COMMENT 'Unit of measure for the design capacity. BPD (Barrels Per Day), BOPD (Barrels of Oil Per Day), MCFD (Thousand Cubic Feet per Day), MMCFD (Million Cubic Feet per Day), MT/Day (Metric Tons per Day).. Valid values are `BPD|BOPD|MCFD|MMCFD|MT/Day`',
    `commissioning_date` DATE COMMENT 'Date when the process unit was commissioned and placed into service.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this process unit record was first created in the system.',
    `dcs_tag_prefix` STRING COMMENT 'Standard tag prefix used in the DCS for all control points and instruments associated with this process unit.',
    `design_capacity` DECIMAL(18,2) COMMENT 'Maximum throughput capacity of the process unit as designed, measured in barrels per day (BPD) for liquid units or thousand cubic feet per day (MCFD) for gas units.',
    `design_pressure_psi` DECIMAL(18,2) COMMENT 'Maximum operating pressure for which the process unit is designed, measured in pounds per square inch (PSI).',
    `design_temperature_f` DECIMAL(18,2) COMMENT 'Maximum operating temperature for which the process unit is designed, measured in degrees Fahrenheit.',
    `epa_reporting_required` BOOLEAN COMMENT 'Indicates whether this process unit is subject to EPA emissions reporting requirements.',
    `feed_type` STRING COMMENT 'Primary feedstock type processed by this unit (e.g., crude oil, vacuum gas oil, naphtha, heavy gas oil).',
    `last_turnaround_date` DATE COMMENT 'Date of the most recent planned shutdown for major maintenance, inspection, and equipment replacement.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this process unit record was last modified.',
    `next_turnaround_date` DATE COMMENT 'Scheduled date for the next planned turnaround maintenance event.',
    `operating_pressure_max_psi` DECIMAL(18,2) COMMENT 'Maximum safe operating pressure for the process unit in pounds per square inch (PSI).',
    `operating_pressure_min_psi` DECIMAL(18,2) COMMENT 'Minimum safe operating pressure for the process unit in pounds per square inch (PSI).',
    `operating_temperature_max_f` DECIMAL(18,2) COMMENT 'Maximum safe operating temperature for the process unit in degrees Fahrenheit.',
    `operating_temperature_min_f` DECIMAL(18,2) COMMENT 'Minimum safe operating temperature for the process unit in degrees Fahrenheit.',
    `operational_status` STRING COMMENT 'Current operational state of the process unit indicating whether it is actively processing, under maintenance, or offline.. Valid values are `Operating|Shutdown|Turnaround|Startup|Standby|Decommissioned`',
    `operator_response_action` STRING COMMENT 'Description of the corrective action taken by the operator in response to the alarm.',
    `operator_response_required` BOOLEAN COMMENT 'Indicates whether this alarm requires mandatory operator action or is informational only.',
    `operator_response_timestamp` TIMESTAMP COMMENT 'Date and time when the operator responded to the alarm.',
    `pi_historian_tag_group` STRING COMMENT 'OSIsoft PI System tag group identifier for real-time and historical process data collection from this unit.',
    `process_safety_management_tier` STRING COMMENT 'Classification of the process unit based on process safety risk and regulatory requirements under OSHA PSM standards.. Valid values are `Tier-1|Tier-2|Tier-3|Tier-4`',
    `unit_code` STRING COMMENT 'Standardized alphanumeric code for the process unit used across systems and documentation.',
    `unit_name` STRING COMMENT 'Business name of the process unit (e.g., CDU-1, FCC-A, HDS-North).',
    `unit_type` STRING COMMENT 'Classification of the refinery process unit. CDU (Crude Distillation Unit), VDU (Vacuum Distillation Unit), FCC (Fluid Catalytic Cracking), HDS (Hydrodesulfurization), and other major refining process types. [ENUM-REF-CANDIDATE: CDU|VDU|FCC|HDS|Hydrocracker|Reformer|Alkylation|Isomerization|Coker|Treating — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_process_unit PRIMARY KEY(`process_unit_id`)
) COMMENT 'Master record and SSOT for refinery process unit configuration and alarm management. Covers CDU, VDU, FCC, HDS, hydrocracker, reformer, alkylation, isomerization, coker, and treating units. Captures unit type, design capacity, feed type, operating pressure and temperature design limits, capacity constraints, DCS tag prefix, PI System historian tag group, Aspen HYSYS model reference, commissioning date, current operational status, and process alarm management including alarm tags, types (high/low/deviation/rate-of-change), priorities, acknowledgment and shelving status, operator response tracking, and root cause classification per ISA-18.2 alarm management standards and OSHA 29 CFR 1910.119 PSM requirements.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`crude_assay` (
    `crude_assay_id` BIGINT COMMENT 'Unique identifier for the crude assay record. Primary key for the crude assay master data product.',
    `crude_grade_id` BIGINT COMMENT 'Reference to the crude oil grade that this assay characterizes. Links to the crude grade master in the product domain.',
    `hazardous_substance_id` BIGINT COMMENT 'Foreign key linking to hse.hazardous_substance. Business justification: Crude assays identify H2S content, NORM levels, and hazardous components. Safety data sheets, Tier II reporting, and worker exposure assessments require assay-to-substance linkage for hazard classific',
    `price_differential_id` BIGINT COMMENT 'Foreign key linking to commercial.price_differential. Business justification: Crude assay properties (API gravity, sulfur content, TAN) directly determine price differentials versus benchmark. Essential for crude valuation, procurement pricing, and margin optimization.',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity of the crude oil, measured in degrees API. Key indicator of crude density and quality; higher API gravity indicates lighter, more valuable crude. Typical range 10-50 degrees API.',
    `aromatic_content_wt_pct` DECIMAL(18,2) COMMENT 'Aromatic hydrocarbon content of the crude oil, expressed as weight percent (from SARA analysis: Saturates, Aromatics, Resins, Asphaltenes). Aromatic content affects product quality (cetane, smoke point) and processing severity requirements.',
    `asphaltene_content_wt_pct` DECIMAL(18,2) COMMENT 'Asphaltene content of the crude oil, expressed as weight percent. Asphaltenes are heavy, polar molecules that cause fouling, coking, and stability issues. High asphaltene content affects crude compatibility for blending and requires careful processing.',
    `assay_date` DATE COMMENT 'Date when the crude oil sample was assayed or when the assay data was published. Used for assay currency and validity tracking.',
    `assay_laboratory` STRING COMMENT 'Name of the laboratory or organization that performed the crude assay analysis. Used for assay quality validation and traceability.',
    `assay_name` STRING COMMENT 'Business name or identifier for this crude assay, typically including crude grade name and source location (e.g., Brent North Sea 2023, WTI Cushing Q1).',
    `assay_report_reference` STRING COMMENT 'Reference number or document identifier for the detailed crude assay laboratory report. Links to the full assay documentation including all test results and distillation curves.',
    `assay_status` STRING COMMENT 'Current lifecycle status of the assay record. Active assays are used for refinery planning and optimization; superseded assays are retained for historical analysis.. Valid values are `draft|validated|active|superseded|archived`',
    `assay_version` STRING COMMENT 'Version identifier for this assay. Crude assays are updated periodically as crude quality varies; version tracks the iteration.',
    `carbon_residue_wt_pct` DECIMAL(18,2) COMMENT 'Conradson Carbon Residue (CCR) of the crude oil, expressed as weight percent. Indicates coke-forming tendency and asphaltene content. High CCR crude yields more residue and requires coking or residue upgrading capacity. Used for FCC feed quality assessment.',
    `cetane_index` DECIMAL(18,2) COMMENT 'Calculated cetane index of the diesel fraction from the crude assay. Indicates diesel ignition quality; higher cetane index means better diesel quality. Used for crude valuation and diesel blending optimization.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this crude assay record was first created in the system. Used for data lineage and audit trail.',
    `diesel_yield_vol_pct` DECIMAL(18,2) COMMENT 'Volume percent yield of diesel cut (typically 520-650°F / 271-343°C) from crude distillation. Diesel is a high-value middle distillate product; yield is a key crude valuation factor.',
    `distillation_method` STRING COMMENT 'Laboratory distillation method used to generate the crude assay distillation curve. TBP (True Boiling Point) provides the most detailed cut-by-cut yield data for refinery simulation. ASTM D86 is a simpler atmospheric distillation. ASTM D2892 and D5236 are standard crude assay distillation methods.. Valid values are `TBP|ASTM D86|ASTM D2892|ASTM D5236`',
    `flash_point_c` DECIMAL(18,2) COMMENT 'Flash point of the crude oil in degrees Celsius. Lowest temperature at which vapors ignite when exposed to an ignition source. Critical for HSE classification, storage tank design, and transportation safety (OSHA, NFPA, DOT regulations).',
    `freeze_point_c` DECIMAL(18,2) COMMENT 'Freeze point of the kerosene/jet fuel fraction, measured in degrees Celsius. Critical specification for jet fuel to prevent fuel system icing at high altitude. ASTM D1655 Jet A specification requires maximum -40°C freeze point.',
    `heavy_naphtha_yield_vol_pct` DECIMAL(18,2) COMMENT 'Volume percent yield of heavy naphtha cut (typically 180-380°F / 82-193°C) from crude distillation. Heavy naphtha is primary feedstock for catalytic reforming to produce high-octane reformate and hydrogen.',
    `hydrogen_content_wt_pct` DECIMAL(18,2) COMMENT 'Hydrogen content of the crude oil, expressed as weight percent. Higher hydrogen content indicates more paraffinic crude with better product quality potential. Used in refinery hydrogen balance calculations.',
    `iron_content_ppm` DECIMAL(18,2) COMMENT 'Iron (Fe) content in the crude oil, measured in parts per million (ppm). Iron indicates contamination from pipelines, storage tanks, or production equipment. High iron content can foul heat exchangers and poison catalysts.',
    `kerosene_yield_vol_pct` DECIMAL(18,2) COMMENT 'Volume percent yield of kerosene cut (typically 380-520°F / 193-271°C) from crude distillation. Kerosene is feedstock for jet fuel and heating oil production.',
    `light_naphtha_yield_vol_pct` DECIMAL(18,2) COMMENT 'Volume percent yield of light naphtha cut (typically C5-180°F / C5-82°C) from crude distillation. Light naphtha is feedstock for isomerization and reforming to produce high-octane gasoline blendstock.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this crude assay record was last modified. Used for change tracking and data quality monitoring.',
    `nickel_content_ppm` DECIMAL(18,2) COMMENT 'Nickel (Ni) content in the crude oil, measured in parts per million (ppm). Nickel and vanadium are catalyst poisons in FCC and hydroprocessing units. High-metal crudes require specialized processing or blending to reduce metal content.',
    `nitrogen_content_wt_ppm` DECIMAL(18,2) COMMENT 'Total nitrogen content of the crude oil, measured in weight ppm. Nitrogen compounds are catalyst poisons in hydrotreating and hydrocracking units and contribute to NOx emissions. High-nitrogen crudes require additional hydrotreating capacity.',
    `pour_point_c` DECIMAL(18,2) COMMENT 'Pour point of the crude oil in degrees Celsius. Lowest temperature at which the crude will flow under gravity. Critical for cold-weather storage, pipeline transport, and tank heating requirements.',
    `resin_content_wt_pct` DECIMAL(18,2) COMMENT 'Resin content of the crude oil, expressed as weight percent (from SARA analysis). Resins are polar compounds that contribute to crude stability and asphaltene solubility. High resin content can cause processing issues.',
    `rvp_psi` DECIMAL(18,2) COMMENT 'Reid Vapor Pressure (RVP) of the crude oil, measured in psi at 100°F. Indicates volatility and light-end content. High RVP crude requires vapor recovery systems and affects storage tank design. Also used for gasoline blending RVP compliance (EPA seasonal RVP limits).',
    `salt_content_ptb` DECIMAL(18,2) COMMENT 'Salt content of the crude oil, measured in pounds per thousand barrels (PTB). High salt content causes corrosion and fouling in crude distillation units. Crude desalting targets <1 PTB to protect downstream equipment.',
    `saturate_content_wt_pct` DECIMAL(18,2) COMMENT 'Saturate (paraffin and naphthene) content of the crude oil, expressed as weight percent (from SARA analysis). High saturate content indicates better quality crude with higher diesel and lube oil yield potential.',
    `smoke_point_mm` DECIMAL(18,2) COMMENT 'Smoke point of the kerosene fraction, measured in millimeters. Indicates aromatic content and combustion quality of jet fuel. Higher smoke point means lower aromatics and better jet fuel quality. ASTM D1655 jet fuel specification requires minimum 25mm smoke point.',
    `source_location` STRING COMMENT 'Geographic origin or production field of the crude oil sample (e.g., North Sea, Permian Basin, Saudi Arabia). Used for crude sourcing and logistics planning.',
    `specific_gravity` DECIMAL(18,2) COMMENT 'Specific gravity of the crude oil at 60°F/60°F (dimensionless ratio). Alternative density measure to API gravity, used in some international markets and process simulations.',
    `sulfur_content_wt_pct` DECIMAL(18,2) COMMENT 'Total sulfur content of the crude oil, expressed as weight percent. Critical for refinery processing (HDS unit sizing), product quality (diesel/gasoline sulfur specs), and environmental compliance (EPA Tier 3 standards). Sweet crude <0.5%, sour crude >0.5%.',
    `tan_mg_koh_per_g` DECIMAL(18,2) COMMENT 'Total Acid Number (TAN) measured in mg KOH/g. Indicates naphthenic acid content; high TAN crude (>0.5) causes corrosion in refinery units (CDU/VDU overhead systems, heat exchangers). Critical for metallurgy selection and corrosion management.',
    `vacuum_residue_yield_vol_pct` DECIMAL(18,2) COMMENT 'Volume percent yield of vacuum residue (typically 1050°F+ / 566°C+) from vacuum distillation. Vacuum residue is the heaviest fraction, used for asphalt, fuel oil, or fed to coking/residue upgrading units. High residue yield reduces refinery margin.',
    `vanadium_content_ppm` DECIMAL(18,2) COMMENT 'Vanadium (V) content in the crude oil, measured in parts per million (ppm). Vanadium is a catalyst poison and causes high-temperature corrosion in furnaces and boilers. Critical for FCC catalyst selection and residue upgrading economics.',
    `vgo_yield_vol_pct` DECIMAL(18,2) COMMENT 'Volume percent yield of vacuum gas oil (VGO) cut (typically 650-1050°F / 343-566°C) from vacuum distillation. VGO is primary feedstock for FCC and hydrocracking units to produce gasoline and diesel.',
    `viscosity_cst_at_100c` DECIMAL(18,2) COMMENT 'Kinematic viscosity of the crude oil at 100°C, measured in centistokes (cSt). Used for viscosity-temperature relationship modeling and high-temperature process unit design.',
    `viscosity_cst_at_40c` DECIMAL(18,2) COMMENT 'Kinematic viscosity of the crude oil at 40°C, measured in centistokes (cSt). Affects pumpability, pipeline transport, and heat exchanger design. Heavy crudes have higher viscosity.',
    `water_content_vol_pct` DECIMAL(18,2) COMMENT 'Water and sediment content of the crude oil, expressed as volume percent. Affects crude valuation (water is non-saleable), desalter performance, and corrosion risk. Custody transfer specifications typically require <0.5% water.',
    `wax_content_wt_pct` DECIMAL(18,2) COMMENT 'Paraffin wax content of the crude oil, expressed as weight percent. High wax content affects pour point, pipeline flow, and cold-weather operability. Waxy crudes may require heating or dewaxing for transportation and processing.',
    CONSTRAINT pk_crude_assay PRIMARY KEY(`crude_assay_id`)
) COMMENT 'Master reference record and SSOT for crude oil grade characterization, including API gravity, sulfur content (wt%), TAN (Total Acid Number), viscosity, pour point, distillation curve (TBP/ASTM D86), metal content (Ni, V, Fe), salt content, Reid Vapor Pressure (RVP), SARA fractions, and yield potential by cut. Linked to crude grade in the product domain. Used by Aspen HYSYS for feedstock blending optimization and CDU/VDU simulation. Each assay represents a specific crude grades quality profile used for crude valuation, blend optimization, and unit yield prediction.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` (
    `feedstock_blend_id` BIGINT COMMENT 'Unique identifier for the feedstock blend record. Primary key for the feedstock blend entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Feedstock blends are designed by process engineers who optimize crude slate for unit constraints, yield targets, and quality specifications. Essential for technical accountability, optimization tracki',
    `blending_recipe_id` BIGINT COMMENT 'Foreign key linking to refining.blending_recipe. Business justification: A feedstock blend is executed according to a blending recipe; the FK ties the blend to its recipe for quality and cost analysis.',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Feedstock blends specify crude grade composition for CDU feed optimization. Essential for crude procurement decisions, blend optimization models (Aspen PIMS), quality prediction, and margin analysis. ',
    `nomination_id` BIGINT COMMENT 'Foreign key linking to customer.nomination. Business justification: Feedstock blending decisions are driven by customer nominations specifying crude grade, API gravity, sulfur content, and delivery timing. Links blend optimization to contractual commitments and enable',
    `pipeline_nomination_id` BIGINT COMMENT 'Foreign key linking to logistics.pipeline_nomination. Business justification: Feedstock blends may include pipeline-delivered crudes. Nomination tracking, volume confirmation, and crude slate planning require linking blends to pipeline nominations for supply assurance and feeds',
    `process_unit_id` BIGINT COMMENT 'Identifier of the refinery process unit (CDU, VDU, FCC, HDS, or other) that will receive or has received this feedstock blend.',
    `product_specification_id` BIGINT COMMENT 'Foreign key linking to refining.product_specification. Business justification: Feedstock blending strategies must consider downstream product specification constraints (sulfur limits, octane targets, distillation curves) to ensure regulatory compliance. Links crude slate optimiz',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Refineries track facility sources for feedstock blends to manage supply contracts, quality specifications, and integrated logistics. Critical for vertically integrated operators coordinating productio',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: Integrated operators optimize feedstock blends using well-specific crude characteristics (API, sulfur, TAN) when sourcing directly from production. Enables upstream-downstream optimization and quality',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Feedstock blend optimization requires reservoir fluid characterization (API gravity, sulfur content, TAN, viscosity) to match processing unit capabilities and target product slate. Refiners reference ',
    `actual_total_volume_bbl` DECIMAL(18,2) COMMENT 'The actual total volume of the feedstock blend in barrels (BBL) that was processed through the target unit, measured upon completion or during operations.',
    `approved_by` STRING COMMENT 'The name or identifier of the refinery operations manager, process engineer, or authorized personnel who approved this feedstock blend for execution.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this feedstock blend was formally approved for execution by authorized refinery personnel.',
    `blend_api_gravity` DECIMAL(18,2) COMMENT 'The weighted average API gravity of the feedstock blend, a measure of petroleum liquid density relative to water. Higher API gravity indicates lighter, less dense crude oil. Calculated based on component crude grades and their volume fractions.',
    `blend_end_date` DATE COMMENT 'The date when the feedstock blend processing or feeding to the target unit was completed or is scheduled to complete.',
    `blend_flash_point_c` DECIMAL(18,2) COMMENT 'The weighted average flash point temperature of the feedstock blend in degrees Celsius, the lowest temperature at which vapors will ignite. Critical for HSE compliance and safe handling procedures.',
    `blend_metals_content_ppm` DECIMAL(18,2) COMMENT 'The weighted average total metals content (vanadium, nickel, iron) of the feedstock blend expressed in parts per million. Metals can cause catalyst deactivation and fouling in refinery process units.',
    `blend_name` STRING COMMENT 'Human-readable name or designation for this feedstock blend, used for operational identification and scheduling purposes.',
    `blend_nitrogen_content_ppm` DECIMAL(18,2) COMMENT 'The weighted average nitrogen content of the feedstock blend expressed in parts per million. Nitrogen compounds can poison catalysts in downstream units such as FCC and hydrotreating units.',
    `blend_number` STRING COMMENT 'Externally-known unique business identifier or code assigned to this feedstock blend for tracking and reference in refinery operations and scheduling systems.',
    `blend_pour_point_c` DECIMAL(18,2) COMMENT 'The weighted average pour point temperature of the feedstock blend in degrees Celsius, representing the lowest temperature at which the blend will flow. Important for storage and transportation planning.',
    `blend_salt_content_ptb` DECIMAL(18,2) COMMENT 'The weighted average salt content of the feedstock blend expressed in pounds per thousand barrels. High salt content can cause corrosion and fouling in crude distillation units and requires desalting operations.',
    `blend_sediment_content_vol_pct` DECIMAL(18,2) COMMENT 'The weighted average sediment content of the feedstock blend expressed as volume percentage. Sediment can cause fouling and operational issues in refinery equipment.',
    `blend_start_date` DATE COMMENT 'The date when the feedstock blend processing or feeding to the target unit began or is scheduled to begin.',
    `blend_status` STRING COMMENT 'Current lifecycle status of the feedstock blend. Planned indicates the blend recipe is designed but not yet approved, approved indicates ready for execution, in progress indicates currently being blended or fed to the unit, completed indicates the blend has been fully processed, cancelled indicates the blend was terminated before completion, and on hold indicates temporary suspension.. Valid values are `planned|approved|in_progress|completed|cancelled|on_hold`',
    `blend_sulfur_content_wt_pct` DECIMAL(18,2) COMMENT 'The weighted average sulfur content of the feedstock blend expressed as weight percentage. Critical for HDS unit planning, EPA emissions compliance, and product quality specifications.',
    `blend_tan` DECIMAL(18,2) COMMENT 'The weighted average Total Acid Number (TAN) of the feedstock blend, measured in milligrams of potassium hydroxide per gram of sample. TAN indicates the acidity and corrosivity of the crude oil, critical for refinery equipment integrity and corrosion management.',
    `blend_timestamp` TIMESTAMP COMMENT 'The precise date and time when the feedstock blend was initiated or executed in the refinery operations, representing the principal business event timestamp for this blend.',
    `blend_type` STRING COMMENT 'Classification of the feedstock blend based on its purpose and composition. Crude blend represents primary crude oil mixtures, intermediate blend represents processed stream mixtures, feedstock optimization represents cost or yield optimized recipes, emergency blend represents contingency blends, test blend represents experimental formulations, and standard recipe represents pre-approved recurring blends.. Valid values are `crude_blend|intermediate_blend|feedstock_optimization|emergency_blend|test_blend|standard_recipe`',
    `blend_viscosity_cst` DECIMAL(18,2) COMMENT 'The weighted average kinematic viscosity of the feedstock blend measured in centistokes at a standard temperature (typically 40°C or 100°C). Viscosity affects pumping, heating, and processing requirements.',
    `blend_water_content_vol_pct` DECIMAL(18,2) COMMENT 'The weighted average water content of the feedstock blend expressed as volume percentage. Water content affects processing efficiency and must be removed through desalting and dehydration operations.',
    `blending_rationale` STRING COMMENT 'The primary business driver or reason for creating this specific feedstock blend. Cost optimization indicates minimizing feedstock cost, yield optimization indicates maximizing valuable product yields, quality compliance indicates meeting product specifications, feedstock availability indicates working with available crude grades, contract obligation indicates fulfilling supply agreements, and operational constraint indicates adapting to refinery limitations.. Valid values are `cost_optimization|yield_optimization|quality_compliance|feedstock_availability|contract_obligation|operational_constraint`',
    `comments` STRING COMMENT 'Free-text field for operational notes, special instructions, quality observations, or other relevant information about this feedstock blend that may be useful for refinery operations and future reference.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this feedstock blend record was first created in the system, used for audit trail and data lineage tracking.',
    `estimated_margin_usd` DECIMAL(18,2) COMMENT 'The estimated gross margin in USD from processing this feedstock blend, calculated as estimated product value minus estimated processing cost. Key metric for blend selection and refinery profitability analysis.',
    `estimated_processing_cost_usd` DECIMAL(18,2) COMMENT 'The estimated total cost in USD to process this feedstock blend through the target unit, including feedstock acquisition cost, energy consumption, catalyst usage, and operational expenses. Used for economic evaluation and margin analysis.',
    `estimated_product_value_usd` DECIMAL(18,2) COMMENT 'The estimated total market value in USD of the refined products expected from processing this feedstock blend, based on current market prices and target yield slate. Used for margin calculation and economic optimization.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this feedstock blend record was last updated or modified, used for audit trail and change tracking.',
    `optimization_score` DECIMAL(18,2) COMMENT 'A calculated score (typically 0-100) representing how well this feedstock blend achieves the blending objectives (cost, yield, quality) compared to alternative blend recipes. Higher scores indicate better optimization performance.',
    `planned_total_volume_bbl` DECIMAL(18,2) COMMENT 'The total planned volume of the feedstock blend in barrels (BBL) to be processed through the target unit during the defined processing period.',
    `quality_compliance_status` STRING COMMENT 'Indicates whether the feedstock blend meets all required quality specifications and regulatory standards for processing in the target unit. Compliant indicates all specifications met, non-compliant indicates one or more specifications violated, pending review indicates awaiting quality assurance approval, conditionally approved indicates approved with operational restrictions, and requires adjustment indicates blend recipe needs modification.. Valid values are `compliant|non_compliant|pending_review|conditionally_approved|requires_adjustment`',
    `source_system` STRING COMMENT 'The name of the operational system that originated this feedstock blend record, such as Aspen HYSYS process simulation system, refinery planning system, or DCS control system.',
    `target_yield_distillates_pct` DECIMAL(18,2) COMMENT 'The target percentage yield of middle distillates (diesel, jet fuel, kerosene) expected from processing this feedstock blend, used for product slate planning.',
    `target_yield_light_ends_pct` DECIMAL(18,2) COMMENT 'The target percentage yield of light ends (LPG, propane, butane) expected from processing this feedstock blend, used for product slate planning and yield optimization.',
    `target_yield_naphtha_pct` DECIMAL(18,2) COMMENT 'The target percentage yield of naphtha expected from processing this feedstock blend, used for gasoline blending and petrochemical feedstock planning.',
    `target_yield_residue_pct` DECIMAL(18,2) COMMENT 'The target percentage yield of residue (heavy fuel oil, asphalt, vacuum residue) expected from processing this feedstock blend, used for downstream unit planning and product slate optimization.',
    `volume_variance_bbl` DECIMAL(18,2) COMMENT 'The difference between planned and actual total volume in barrels, calculated as actual minus planned. Positive values indicate over-processing, negative values indicate under-processing.',
    CONSTRAINT pk_feedstock_blend PRIMARY KEY(`feedstock_blend_id`)
) COMMENT 'Planned or actual blend of crude oil grades and intermediate feedstocks fed to a CDU or process unit during a defined processing period. Captures blend recipe (component crude grades, volume fractions, API gravity, sulfur, TAN), planned vs. actual volumes in barrels, blend date, target unit, blending rationale, and quality compliance status. Supports feedstock optimization and crude scheduling workflows.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`unit_run` (
    `unit_run_id` BIGINT COMMENT 'Unique identifier for the process unit operational run record. Primary key for unit run transactions.',
    `aspen_simulation_id` BIGINT COMMENT 'Reference identifier to the Aspen HYSYS process simulation model used for planning and variance analysis of this run.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the refinery facility where this unit run occurred.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Continuous emissions monitoring (CEMS) data from unit runs feeds EPA Part 75 reporting for NOx/SO2 emissions and state air quality reports. Each unit runs emissions must be traceable to quarterly/ann',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Operating runs generate costs (feedstock, utilities, catalyst, labor) that must be allocated to cost centers for run-level profitability analysis. Enables comparison of actual vs. planned costs and op',
    `equipment_id` BIGINT COMMENT 'Reference to the specific process unit equipment (CDU, VDU, FCC, HDS, etc.) that executed this run.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Incidents during unit runs require operational context (feed rates, temperatures, pressures) for investigation. Process safety analysis links incident timing to run conditions to identify causal facto',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Each unit run targets a primary product output for yield accounting and product costing. Essential for production variance analysis, unit economics calculation, and reconciliation with refinery schedu',
    `process_safety_event_id` BIGINT COMMENT 'Foreign key linking to hse.process_safety_event. Business justification: Process safety events (LOPC, overpressure) occur during unit operations. PSE investigations require operational context from unit runs (feed rates, temperatures, catalyst age) to identify causal facto',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to refining.process_unit. Business justification: unit_run is the transactional record of process unit operational performance. Currently links to equipment via equipment_id, but should also directly reference the process_unit master record. This nor',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each unit run occurs under a shift supervisors operational control. Critical for linking run performance to supervisory accountability, HSE incident investigation, alarm response evaluation, and perf',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity of the feedstock or product indicating density and quality classification per API standards.',
    `catalyst_activity_index` DECIMAL(18,2) COMMENT 'Measure of catalyst performance and activity level during the run, typically expressed as percentage of fresh catalyst activity.',
    `catalyst_age_days` STRING COMMENT 'Number of days the catalyst has been in service at the time of this run for catalyst lifecycle management.',
    `conversion_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of feedstock converted to lighter products during the run, key performance indicator for cracking units (FCC, hydrocracker).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this unit run record was first created in the data platform for audit trail purposes.',
    `dcs_historian_tag` STRING COMMENT 'Reference tag identifier in the DCS or PI System historian linking to real-time process data for this run.',
    `diesel_yield_bbl` DECIMAL(18,2) COMMENT 'Volume of diesel product cut produced during the run measured in barrels for yield accounting.',
    `electricity_consumption_mwh` DECIMAL(18,2) COMMENT 'Total electrical energy consumed during the run measured in megawatt hours for utility tracking.',
    `energy_consumption_mmbtu` DECIMAL(18,2) COMMENT 'Total energy consumed during the unit run measured in million British thermal units for energy efficiency analysis.',
    `feed_rate_bopd` DECIMAL(18,2) COMMENT 'Average feedstock processing rate during the run expressed in barrels of oil per day for throughput analysis.',
    `feedstock_mass_mt` DECIMAL(18,2) COMMENT 'Total mass of feedstock processed during the run measured in metric tons for mass balance calculations.',
    `feedstock_type` STRING COMMENT 'Classification of the crude oil or intermediate feedstock processed during this run (e.g., WTI, Brent, heavy sour, light sweet).',
    `feedstock_volume_bbl` DECIMAL(18,2) COMMENT 'Total volume of feedstock processed during the run measured in barrels at standard conditions.',
    `gas_oil_yield_bbl` DECIMAL(18,2) COMMENT 'Volume of gas oil product cut produced during the run measured in barrels for yield accounting.',
    `kerosene_yield_bbl` DECIMAL(18,2) COMMENT 'Volume of kerosene product cut produced during the run measured in barrels for yield accounting.',
    `liquid_volume_unaccounted_for_bbl` DECIMAL(18,2) COMMENT 'Difference between feedstock input volume and total product output volume, representing measurement uncertainty and losses.',
    `lpg_yield_bbl` DECIMAL(18,2) COMMENT 'Volume of LPG product cut produced during the run measured in barrels for yield accounting.',
    `mass_balance_closure_percent` DECIMAL(18,2) COMMENT 'Percentage representing the ratio of total product mass to feedstock mass, indicating accuracy of mass accounting (target: 99-101%).',
    `naphtha_yield_bbl` DECIMAL(18,2) COMMENT 'Volume of naphtha product cut produced during the run measured in barrels for yield accounting.',
    `operating_pressure_psi` DECIMAL(18,2) COMMENT 'Average operating pressure of the process unit during the run measured in pounds per square inch.',
    `operating_temperature_c` DECIMAL(18,2) COMMENT 'Average operating temperature of the process unit during the run measured in degrees Celsius.',
    `planned_throughput_bbl` DECIMAL(18,2) COMMENT 'Target feedstock volume planned for this run based on refinery scheduling and optimization models.',
    `residue_yield_bbl` DECIMAL(18,2) COMMENT 'Volume of residue product cut produced during the run measured in barrels for yield accounting.',
    `ron_value` DECIMAL(18,2) COMMENT 'Research octane number of gasoline product cuts indicating anti-knock quality and blending value.',
    `run_duration_hours` DECIMAL(18,2) COMMENT 'Total elapsed time of the unit run in hours, calculated from start to end timestamp for cycle time analysis.',
    `run_end_timestamp` TIMESTAMP COMMENT 'Date and time when the unit run processing period ended, marking the completion of the operational cycle.',
    `run_number` STRING COMMENT 'Business identifier for the unit run, typically formatted as facility-unit-date-sequence for operational tracking and reporting.',
    `run_start_timestamp` TIMESTAMP COMMENT 'Date and time when the unit run processing period began, marking the start of feedstock introduction to the unit.',
    `run_status` STRING COMMENT 'Current lifecycle status of the unit run indicating operational state and data completeness.. Valid values are `planned|in_progress|completed|aborted|suspended`',
    `run_type` STRING COMMENT 'Classification of the operational run mode indicating the nature of the processing period.. Valid values are `normal|startup|shutdown|turnaround|catalyst_regeneration|emergency`',
    `steam_consumption_mt` DECIMAL(18,2) COMMENT 'Total steam utility consumed during the run measured in metric tons for utility cost allocation.',
    `sulfur_content_ppm` DECIMAL(18,2) COMMENT 'Average sulfur content in the feedstock or product measured in parts per million for HDS unit performance and EPA compliance.',
    `tan_mg_koh_per_g` DECIMAL(18,2) COMMENT 'Total acid number of the feedstock or product measured in mg KOH per gram, indicating corrosivity and processing requirements.',
    `throughput_variance_bbl` DECIMAL(18,2) COMMENT 'Difference between actual and planned throughput volumes, indicating operational performance against plan.',
    `total_output_boe` DECIMAL(18,2) COMMENT 'Total production output normalized to barrel of oil equivalent for standardized reporting and comparison.',
    `total_product_mass_mt` DECIMAL(18,2) COMMENT 'Sum of all product cut masses produced during the run measured in metric tons for mass balance closure.',
    `total_product_volume_bbl` DECIMAL(18,2) COMMENT 'Sum of all product cut volumes produced during the run measured in barrels for overall yield verification.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this unit run record was last modified for change tracking and data lineage.',
    CONSTRAINT pk_unit_run PRIMARY KEY(`unit_run_id`)
) COMMENT 'Primary transactional record and SSOT for process unit operational performance and yield accounting. Covers a defined processing period (shift, day, or campaign) capturing actual throughput (BOPD or MCFD), feed rate, operating temperature, pressure, conversion rate, energy consumption (MMBtu), utility consumption, catalyst activity index, run length, DCS/PI System historian reference, and detailed yield accounting by product cut (LPG, naphtha, kerosene, diesel, gas oil, residue) including actual vs. planned output volumes and mass, liquid volume unaccounted for (LVUF), mass balance closure percentage, BOE conversion, and variance to Aspen HYSYS simulation targets. Supports yield optimization, loss accounting, and refinery planning.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` (
    `refining_yield_record_id` BIGINT COMMENT 'Unique identifier for the refining yield record. Primary key for this entity.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key reference to the refinery facility where this yield was recorded.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Yield variances impact cost center performance through LVUF (liquid volume unaccounted for) and mass balance closure. Linking enables variance analysis, loss accounting, and reconciliation between ope',
    `esg_report_id` BIGINT COMMENT 'Foreign key linking to compliance.esg_report. Business justification: Refining yield data calculates carbon intensity metrics (gCO2e/MJ fuel produced) required for ESG reporting under TCFD, CDP, and low-carbon fuel standards (LCFS, RFS). Yield records provide the denomi',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Yield records track actual production volumes of specific petroleum products (gasoline, diesel, jet fuel, etc.). Fundamental to production accounting, mass balance reconciliation, SEC reserves reporti',
    `process_unit_id` BIGINT COMMENT 'Foreign key reference to the refinery process unit (CDU, VDU, FCC, HDS, etc.) that generated this yield record.',
    `unit_run_id` BIGINT COMMENT 'Foreign key linking to refining.unit_run. Business justification: refining_yield_record is detailed yield accounting for a process unit run. Currently has run_number (STRING) but no FK to unit_run. Adding unit_run_id FK allows normalization of run-level attributes (',
    `actual_mass_mt` DECIMAL(18,2) COMMENT 'Actual mass of the product cut produced during the run, measured in metric tons. Used for mass balance closure calculations.',
    `actual_volume_bbl` DECIMAL(18,2) COMMENT 'Actual liquid volume of the product cut produced during the run, measured in barrels. Primary volumetric yield measurement.',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity of the product cut, a measure of petroleum liquid density relative to water. Higher values indicate lighter, less dense products.',
    `boe_equivalent` DECIMAL(18,2) COMMENT 'Conversion of the product cut volume to Barrel of Oil Equivalent for standardized energy content reporting and reserves accounting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this yield record was first created in the system. Audit trail field for data lineage tracking.',
    `dcs_data_source` STRING COMMENT 'Identifier of the DCS system or tag group that provided the real-time process data for this yield record. Supports data lineage and quality auditing.',
    `epa_reporting_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this yield record is included in EPA emissions compliance reporting. True if included, False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this yield record was last updated or modified. Audit trail field for change tracking.',
    `loss_category` STRING COMMENT 'Classification of any volume or mass losses identified in this yield record. Used for loss accounting and operational improvement.. Valid values are `normal|evaporation|spillage|measurement_error|theft|unknown`',
    `lvuf_bbl` DECIMAL(18,2) COMMENT 'Liquid volume unaccounted for in the yield reconciliation, measured in barrels. Represents measurement uncertainty, losses, or gains in the process unit.',
    `mass_balance_closure_pct` DECIMAL(18,2) COMMENT 'Percentage closure of the mass balance for this run. Calculated as (total output mass / total input mass) * 100. Values close to 100% indicate good measurement accuracy.',
    `mass_variance_mt` DECIMAL(18,2) COMMENT 'Difference between actual and planned mass (actual minus planned), measured in metric tons. Used for yield optimization and loss accounting.',
    `measurement_method` STRING COMMENT 'Method used to measure or calculate the yield volumes and masses. Impacts data quality and uncertainty levels.. Valid values are `flow_meter|tank_gauging|mass_balance|simulation|manual`',
    `planned_mass_mt` DECIMAL(18,2) COMMENT 'Planned or target mass for this product cut based on refinery scheduling and feedstock blending plan, measured in metric tons.',
    `planned_volume_bbl` DECIMAL(18,2) COMMENT 'Planned or target liquid volume for this product cut based on refinery scheduling and feedstock blending plan, measured in barrels.',
    `quality_grade` STRING COMMENT 'Quality classification of the product cut based on specification compliance. Determines marketability and pricing.. Valid values are `premium|standard|off_spec|blendstock|intermediate`',
    `reconciliation_notes` STRING COMMENT 'Free-text notes documenting any adjustments, corrections, or special circumstances related to yield reconciliation for this record.',
    `ron_value` DECIMAL(18,2) COMMENT 'Research Octane Number for gasoline/naphtha cuts. Measures the anti-knock properties of the fuel. Higher values indicate better performance.',
    `simulation_target_volume_bbl` DECIMAL(18,2) COMMENT 'Target volume for this product cut as predicted by Aspen HYSYS process simulation model, measured in barrels. Used for variance analysis against actual yields.',
    `simulation_variance_bbl` DECIMAL(18,2) COMMENT 'Difference between actual volume and Aspen HYSYS simulation target (actual minus simulation), measured in barrels. Used to calibrate simulation models and identify process deviations.',
    `sulfur_content_pct` DECIMAL(18,2) COMMENT 'Sulfur content of the product cut as a percentage by weight. Critical for HDS (Hydrodesulfurization) unit performance tracking and EPA emissions compliance.',
    `tan_value` DECIMAL(18,2) COMMENT 'Total Acid Number of the product cut, measured in mg KOH/g. Indicates the acidity level and corrosivity of the petroleum product.',
    `volume_variance_bbl` DECIMAL(18,2) COMMENT 'Difference between actual and planned volume (actual minus planned), measured in barrels. Positive values indicate over-production, negative values indicate under-production.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Percentage yield of this product cut relative to total feedstock input. Calculated as (product volume / feedstock volume) * 100.',
    `yield_status` STRING COMMENT 'Current lifecycle status of the yield record. Indicates the level of validation and reconciliation completed.. Valid values are `validated|preliminary|reconciled|disputed|adjusted`',
    CONSTRAINT pk_refining_yield_record PRIMARY KEY(`refining_yield_record_id`)
) COMMENT 'Detailed yield accounting record for a process unit run, capturing actual output volumes and mass by product cut (LPG, naphtha, kerosene, diesel, gas oil, residue, etc.) against planned yield targets. Includes liquid volume unaccounted for (LVUF), mass balance closure percentage, BOE conversion, and variance to Aspen HYSYS simulation targets. Supports yield optimization, loss accounting, and refinery planning.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`product_quality_test` (
    `product_quality_test_id` BIGINT COMMENT 'Unique identifier for the laboratory quality test record. Primary key for the product quality test entity.',
    `blend_event_id` BIGINT COMMENT 'Foreign key linking to refining.blend_event. Business justification: Quality tests validate blended products. product_quality_test.batch_number (STRING) should be normalized to blend_event_id FK. This allows joining to blend_event to retrieve blend composition, blend r',
    `blend_recipe_id` BIGINT COMMENT 'Identifier of the blending recipe or formula used to produce the tested product. Enables correlation of quality results with blend component ratios and optimization of blending strategies.',
    `complaint_id` BIGINT COMMENT 'Foreign key linking to customer.complaint. Business justification: Quality test results are directly referenced in customer complaint investigations for off-spec product claims. Links lab data to commercial dispute resolution, root cause analysis, and settlement calc',
    `employee_id` BIGINT COMMENT 'Identifier of the laboratory analyst who performed the test. Used for analyst performance tracking, training needs assessment, and quality control audits. Confidential business information.',
    `equipment_id` BIGINT COMMENT 'Identifier of the analytical instrument used to perform the test (e.g., gas chromatograph, spectrophotometer, viscometer). Enables instrument performance tracking, calibration management, and root cause analysis of anomalous results.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Quality tests verify specific petroleum products meet specifications for custody transfer, regulatory compliance (EPA fuel standards), and customer contracts. Essential for product release certificati',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to refining.process_unit. Business justification: product_quality_test.process_unit_code (STRING) should be normalized to process_unit_id FK. This allows joining to process_unit master to retrieve unit_name, unit_type, operational_status, and design ',
    `product_specification_id` BIGINT COMMENT 'Foreign key linking to refining.product_specification. Business justification: Quality tests validate product against specifications. product_quality_test.product_grade (STRING) should be normalized to product_specification_id FK. This allows joining to product_specification to ',
    `sample_id` BIGINT COMMENT 'Unique identifier for the physical sample collected from the refinery process stream, tank, or pipeline. Links the test result to the specific sample container and collection event.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Quality tests certify cargo specifications for shipments. BOL certification, customer quality claims, and custody transfer validation require linking test results to shipments for product release auth',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Laboratory quality tests consume reagents, solvents, and consumables tracked in material master. Real QC operations require material tracking for inventory replenishment, cost allocation per test meth',
    `unit_run_id` BIGINT COMMENT 'Foreign key linking to refining.unit_run. Business justification: Quality tests are performed on product streams produced by unit runs. Linking product_quality_test to unit_run establishes traceability from quality results back to the operational run that produced t',
    `certification_datetime` TIMESTAMP COMMENT 'Date and time when the test result was certified for product release. Used to track laboratory turnaround time and ensure timely product shipment.',
    `certification_status` STRING COMMENT 'Certification status indicating whether the test result has been reviewed and approved for product release. Certified indicates approved for shipment; Pending Certification indicates awaiting quality manager review; Rejected indicates product does not meet release criteria; Provisional indicates conditional release pending additional testing.. Valid values are `certified|pending_certification|rejected|provisional`',
    `certified_by` STRING COMMENT 'Name or identifier of the quality manager or authorized person who certified the test result for product release. Required for regulatory compliance and quality assurance audits. Confidential business information.',
    `comments` STRING COMMENT 'Free-text comments from the analyst or quality manager regarding unusual observations, test conditions, sample appearance, or other relevant notes. Supports quality investigation and root cause analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this quality test record was first created in the system. Used for data lineage, audit trail, and record lifecycle management.',
    `deviation_from_spec` DECIMAL(18,2) COMMENT 'Calculated deviation of the measured value from the specification limit (positive indicates above max or below min, negative indicates within spec with margin). Used for quality trending and early warning of specification drift.',
    `epa_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this test result is used for EPA regulatory compliance reporting (e.g., sulfur content for Clean Air Act compliance, benzene content for air toxics regulations). True indicates EPA-reportable test; False indicates internal quality control only.',
    `laboratory_code` STRING COMMENT 'Code identifying the laboratory that performed the test (e.g., refinery on-site lab, third-party contract lab, regional quality center). Used for lab performance tracking and inter-laboratory comparison.',
    `laboratory_name` STRING COMMENT 'Full name of the laboratory facility that performed the analysis. Supports laboratory accreditation tracking and quality assurance audits.',
    `measured_value` DECIMAL(18,2) COMMENT 'Numerical result of the laboratory test for the specified property. Precision varies by test method and property type. Used for specification compliance checking and quality trending.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this quality test record was last modified. Used for change tracking, audit trail, and data quality monitoring.',
    `quality_control_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this test record represents a quality control sample (e.g., blind duplicate, spiked sample, reference standard) rather than a production sample. True indicates QC sample; False indicates production sample.',
    `retest_reason` STRING COMMENT 'Explanation of why a retest was required, such as Result outside expected range, Instrument calibration failure, Sample contamination suspected, or Quality control check failed. Used for laboratory quality improvement.',
    `retest_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the sample requires retesting due to questionable results, instrument malfunction, or quality control failure. True indicates retest is required; False indicates result is accepted.',
    `sample_datetime` TIMESTAMP COMMENT 'Date and time when the physical sample was collected from the process unit, storage tank, or pipeline. Critical for correlating test results with production conditions and process parameters at the time of sampling.',
    `sample_point_code` STRING COMMENT 'Code identifying the physical location where the sample was collected, such as unit outlet, tank number, pipeline tap, or blending header. Enables spatial analysis of quality variation across the refinery.',
    `sample_point_description` STRING COMMENT 'Human-readable description of the sample collection location, including process unit name, equipment tag, and stream description (e.g., CDU Overhead Naphtha, FCC Gasoline Blending Header, Tank 101 Diesel Product).',
    `specification_max` DECIMAL(18,2) COMMENT 'Maximum acceptable value for the tested property per the product grade specification. Null if no maximum limit applies. Used for automated pass/fail determination.',
    `specification_min` DECIMAL(18,2) COMMENT 'Minimum acceptable value for the tested property per the product grade specification. Null if no minimum limit applies. Used for automated pass/fail determination.',
    `specification_target` DECIMAL(18,2) COMMENT 'Target or typical value for the tested property, representing the optimal quality aim for process control. May differ from regulatory limits to provide operating margin and reduce giveaway.',
    `test_datetime` TIMESTAMP COMMENT 'Date and time when the laboratory analysis was performed. Used to track laboratory turnaround time and ensure test results are within validity windows for time-sensitive properties.',
    `test_method_code` STRING COMMENT 'Standardized test method code used for the analysis (e.g., ASTM D2699 for RON, ASTM D86 for distillation, ASTM D4294 for sulfur, IP 365 for flash point). Ensures reproducibility and regulatory compliance.',
    `test_method_description` STRING COMMENT 'Full description of the test method standard, including the property being measured and the analytical technique (e.g., ASTM D2699 - Research Octane Number of Spark-Ignition Engine Fuel, ASTM D5453 - Sulfur by Ultraviolet Fluorescence).',
    `test_number` STRING COMMENT 'Business identifier for the quality test, typically assigned by the laboratory information management system (LIMS) or refinery quality control system. Used for external reference and tracking.',
    `test_precision` DECIMAL(18,2) COMMENT 'Repeatability or reproducibility precision of the test method as defined by the standard method (e.g., ASTM precision statement). Used to assess measurement uncertainty and determine if differences are statistically significant.',
    `test_property_name` STRING COMMENT 'Name of the physical or chemical property being measured (e.g., Research Octane Number, Sulfur Content, Flash Point, Viscosity, Density, Cloud Point, Pour Point, Reid Vapor Pressure, Total Acid Number).',
    `test_result_status` STRING COMMENT 'Overall pass/fail status of the test result against specification limits. Pass indicates all properties meet specifications; Fail indicates one or more properties are out of specification; Conditional indicates marginal results requiring review; Retest indicates sample requires re-analysis; Pending indicates test in progress; Cancelled indicates test was voided.. Valid values are `pass|fail|conditional|retest|pending|cancelled`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the test result (e.g., octane number for RON/MON, ppm for sulfur, deg C for flash point, cSt for viscosity, kg/m3 for density, psi for RVP, mg KOH/g for TAN). Essential for correct interpretation and comparison.',
    CONSTRAINT pk_product_quality_test PRIMARY KEY(`product_quality_test_id`)
) COMMENT 'Laboratory quality test result for a refined product stream or intermediate, capturing sample date/time, sample point (unit outlet, tank, pipeline), product grade, test method (ASTM, IP, ISO), measured properties (RON, MON, flash point, cloud point, pour point, viscosity, sulfur ppm, TAN, RVP, density, color), specification limits, pass/fail status, and certifying laboratory. Supports API refining standards compliance and product release decisions.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` (
    `refinery_schedule_id` BIGINT COMMENT 'Unique identifier for the refinery production schedule record. Primary key for the refinery schedule entity.',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the refinery facility for which this schedule applies. Links to the facility master data.',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Refinery production schedules are planned to meet term contract commitments. Essential for production planning, crude slate optimization, and ensuring contractual delivery obligations are met.',
    `consent_order_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_order. Business justification: Consent orders often mandate specific operational constraints (throughput limits, emission caps, product slate restrictions) that must be incorporated into refinery scheduling and LP optimization mode',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Refinery turnarounds and major projects require AFE authorization. Schedule planning must reference the AFE for budget tracking, spend authorization, and variance reporting. Critical for capital proje',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Production schedules in JV refineries must align with JOA work programs, budget constraints, and partner approval requirements. Schedule deviations trigger JOA-mandated variance reporting and may requ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Refinery schedules are created by planning engineers who optimize crude slates, product yields, and unit utilization using LP models. Critical for accountability, approval workflows, schedule change t',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Refinery production schedules are optimized against customer offtake commitments, term contracts, and lifting schedules tied to specific accounts. Links planned product slate to contractual obligation',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Refinery schedules plan production of specific product slates based on market demand and margin optimization. Essential for LP model runs, commercial planning, crude slate optimization, and financial ',
    `refinery_id` BIGINT COMMENT 'Foreign key linking to refining.refinery. Business justification: A refinery schedule belongs to a specific refinery; linking schedule to refinery enables schedule‑centric reporting and eliminates redundant refinery identifiers stored elsewhere.',
    `shipping_schedule_id` BIGINT COMMENT 'Foreign key linking to logistics.shipping_schedule. Business justification: Refinery production schedules drive logistics lifting schedules. Integrated planning, crude slate optimization, and product dispatch coordination require linking refinery schedules to shipping schedul',
    `activated_timestamp` TIMESTAMP COMMENT 'Date and time when the schedule became the active operational plan. Marks the beginning of schedule execution.',
    `actual_crude_volume_bbl` DECIMAL(18,2) COMMENT 'Actual crude oil throughput volume in barrels achieved during the planning period. Used for planned versus actual variance analysis.',
    `approved_by` STRING COMMENT 'Name or identifier of the refinery manager or planning authority who approved this schedule for execution.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the schedule was formally approved for execution. Marks transition from planning to operational commitment.',
    `cdu_throughput_target_bpd` DECIMAL(18,2) COMMENT 'Planned daily throughput rate for the Crude Distillation Unit in barrels per day. Key operational target for primary refining capacity utilization.',
    `corrective_action_plan` STRING COMMENT 'Documented plan for addressing schedule deviations and preventing recurrence, including specific actions, responsibilities, and timelines.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule record was first created in the system. Audit trail for schedule lifecycle tracking.',
    `crude_slate_plan` STRING COMMENT 'Detailed description of the planned crude oil feedstock mix, including crude types, sources, volumes, and blending ratios for the planning period.',
    `deviation_description` STRING COMMENT 'Detailed narrative description of schedule deviations, including specific events, impacts, and contributing factors.',
    `deviation_root_cause_category` STRING COMMENT 'Primary classification of the root cause for schedule deviations. Supports systematic analysis of planning accuracy and operational reliability.. Valid values are `equipment_failure|feedstock_quality|market_demand|maintenance_overrun|operational_constraint|external_factor`',
    `deviation_tracking_enabled` BOOLEAN COMMENT 'Flag indicating whether planned versus actual variance tracking is active for this schedule. Enables performance monitoring and root cause analysis.',
    `diesel_target_volume_bbl` DECIMAL(18,2) COMMENT 'Planned production volume of diesel fuel products in barrels for the planning period. Includes all diesel grades and ultra-low sulfur diesel.',
    `fcc_throughput_target_bpd` DECIMAL(18,2) COMMENT 'Planned daily throughput rate for the Fluid Catalytic Cracking unit in barrels per day. Critical for gasoline and light olefin production optimization.',
    `financial_impact_usd` DECIMAL(18,2) COMMENT 'Estimated financial impact in US dollars of schedule deviations on refining margin and operational costs.',
    `fuel_oil_target_volume_bbl` DECIMAL(18,2) COMMENT 'Planned production volume of fuel oil products in barrels for the planning period. Includes residual fuel oil and heavy fuel oil grades.',
    `gasoline_target_volume_bbl` DECIMAL(18,2) COMMENT 'Planned production volume of gasoline products in barrels for the planning period. Includes all gasoline grades and blends.',
    `hds_throughput_target_bpd` DECIMAL(18,2) COMMENT 'Planned daily throughput rate for the Hydrodesulfurization unit in barrels per day. Targets sulfur removal capacity to meet EPA emissions and product quality standards.',
    `inventory_drawdown_plan` STRING COMMENT 'Planned strategy for crude and product inventory utilization during the planning period, including target drawdown volumes and timing.',
    `jet_fuel_target_volume_bbl` DECIMAL(18,2) COMMENT 'Planned production volume of jet fuel products in barrels for the planning period. Critical for aviation fuel supply commitments.',
    `lp_model_run_reference` STRING COMMENT 'Reference identifier for the Aspen HYSYS Linear Programming optimization model run that generated this schedule. Links schedule to optimization analysis.',
    `lpg_target_volume_bbl` DECIMAL(18,2) COMMENT 'Planned production volume of Liquefied Petroleum Gas in barrels for the planning period. Includes propane and butane fractions.',
    `maintenance_scope_description` STRING COMMENT 'Detailed description of planned maintenance activities, including units affected, scope of work, and expected production impact.',
    `maintenance_window_end_date` DATE COMMENT 'Planned end date for scheduled maintenance activities that will impact production during the planning period.',
    `maintenance_window_start_date` DATE COMMENT 'Planned start date for scheduled maintenance activities that will impact production during the planning period.',
    `naphtha_target_volume_bbl` DECIMAL(18,2) COMMENT 'Planned production volume of naphtha products in barrels for the planning period. Key petrochemical feedstock and gasoline blending component.',
    `optimization_objective` STRING COMMENT 'Primary business objective used in the LP optimization model for this schedule. Defines the goal function for production planning.. Valid values are `maximize_margin|maximize_throughput|minimize_cost|meet_demand|balance_inventory|custom`',
    `planned_margin_usd` DECIMAL(18,2) COMMENT 'Forecasted gross refining margin in US dollars for the planning period based on the scheduled crude slate and product slate.',
    `planning_period_end_date` DATE COMMENT 'The last date of the planning period covered by this schedule. Defines the end of the operational window for which production is planned.',
    `planning_period_start_date` DATE COMMENT 'The first date of the planning period covered by this schedule. Defines the beginning of the operational window for which production is planned.',
    `product_slate_plan` STRING COMMENT 'Detailed description of the planned refined product output mix, including product grades, target volumes, and quality specifications for the planning period.',
    `resolution_status` STRING COMMENT 'Current status of corrective actions for schedule deviations. Tracks progress from identification through resolution.. Valid values are `open|in_progress|resolved|closed|deferred`',
    `schedule_number` STRING COMMENT 'Externally-known unique business identifier for the refinery production schedule, used for cross-system reference and communication with operations teams.. Valid values are `^SCH-[0-9]{8}-[A-Z0-9]{4}$`',
    `schedule_status` STRING COMMENT 'Current lifecycle state of the refinery schedule. Tracks progression from draft through approval to execution and eventual supersession.. Valid values are `draft|under_review|approved|active|superseded|cancelled`',
    `schedule_type` STRING COMMENT 'Classification of the schedule by planning horizon and frequency. Determines the granularity and scope of the production plan.. Valid values are `daily|weekly|monthly|quarterly|annual|ad_hoc`',
    `schedule_version` STRING COMMENT 'Version number of the schedule, incremented each time the schedule is revised. Supports tracking of schedule evolution and change management.',
    `superseded_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule was replaced by a newer version or subsequent schedule. Marks end of operational relevance.',
    `target_crude_tan` DECIMAL(18,2) COMMENT 'Planned average Total Acid Number for crude slate. Critical for corrosion management and equipment integrity in refining operations.',
    `target_gasoline_ron` DECIMAL(18,2) COMMENT 'Planned average Research Octane Number for gasoline production. Key quality metric for gasoline performance and market grade compliance.',
    `total_crude_volume_bbl` DECIMAL(18,2) COMMENT 'Total planned crude oil throughput volume in barrels for the planning period. Represents aggregate feedstock input across all crude types.',
    `variance_crude_volume_bbl` DECIMAL(18,2) COMMENT 'Difference between planned and actual crude throughput in barrels. Positive values indicate over-performance, negative values indicate under-performance.',
    `vdu_throughput_target_bpd` DECIMAL(18,2) COMMENT 'Planned daily throughput rate for the Vacuum Distillation Unit in barrels per day. Targets secondary distillation capacity for heavy residue processing.',
    CONSTRAINT pk_refinery_schedule PRIMARY KEY(`refinery_schedule_id`)
) COMMENT 'Master record and SSOT for short-to-medium term refinery production scheduling, defining planned crude slate, unit throughputs, product slate targets, maintenance windows, and deviation tracking for a scheduling horizon (daily, weekly, monthly). Captures schedule version, planning period, crude receipt plan, CDU/VDU throughput targets by unit, product volume targets by grade, inventory drawdown plan, schedule status (draft, approved, active, superseded), LP model run reference, and deviation records including planned vs. actual variances, root cause categories, financial impact estimates, corrective actions, and resolution status. Integrates with Aspen HYSYS LP optimization.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` (
    `schedule_deviation_id` BIGINT COMMENT 'Unique identifier for the schedule deviation record. Primary key for the schedule deviation entity.',
    `aspen_hysys_simulation_id` BIGINT COMMENT 'Reference identifier to the Aspen HYSYS process simulation case used to analyze the deviation and evaluate recovery scenarios.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Schedule deviations due to equipment issues trigger corrective maintenance work orders. Real business process: when throughput variance is caused by equipment failure, operators create work orders to ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Deviations from plan impact cost center performance through production loss, opex variance, and margin impact. Financial impact must be tracked for variance reporting and root cause analysis.',
    `process_unit_id` BIGINT COMMENT 'Identifier of the specific process unit affected by the deviation (CDU, VDU, FCC, HDS, etc.). Links to equipment master data.',
    `refinery_id` BIGINT COMMENT 'Identifier of the refinery where the schedule deviation occurred. Links to the facility master data.',
    `refinery_schedule_id` BIGINT COMMENT 'Foreign key linking to refining.refinery_schedule. Business justification: schedule_deviation records deviations from the approved refinery schedule. Must reference which refinery_schedule it deviates from to enable variance analysis (planned vs actual). This is a fundamenta',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Schedule deviations are logged by operations personnel (shift supervisors, unit operators) for root cause analysis, corrective action tracking, and performance reporting. Essential for incident manage',
    `unit_run_id` BIGINT COMMENT 'Foreign key linking to refining.unit_run. Business justification: Schedule deviations occur during specific unit runs. Linking schedule_deviation to unit_run establishes traceability from the deviation event to the actual operational run where the deviation occurred',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.violation. Business justification: Unplanned operational deviations (emergency shutdowns, upsets) often cause excess flaring/venting that violate air permit emission limits, triggering NOVs from EPA/state agencies. Schedule deviations ',
    `actual_throughput_bpd` DECIMAL(18,2) COMMENT 'The actual crude oil or feedstock throughput rate in barrels per day achieved during the deviation period.',
    `actual_yield_percentage` DECIMAL(18,2) COMMENT 'The actual product yield percentage achieved during the deviation period for the affected product stream.',
    `affected_product_stream` STRING COMMENT 'The specific product stream or intermediate stream impacted by the schedule deviation (e.g., gasoline, diesel, jet fuel, naphtha, residual fuel oil).',
    `corrective_action_completion_date` DATE COMMENT 'Actual date when all corrective actions were completed and verified, marking full resolution of the deviation.',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective actions taken to resolve the schedule deviation and prevent recurrence, including immediate response and long-term improvements.',
    `corrective_action_due_date` DATE COMMENT 'Target completion date for all corrective actions associated with this schedule deviation.',
    `corrective_action_owner` STRING COMMENT 'Name or identifier of the individual or team responsible for implementing and tracking the corrective actions.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the schedule deviation record was first created in the database.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all financial amounts in this deviation record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dcs_alarm_count` STRING COMMENT 'Number of DCS alarms triggered during the deviation period, indicating the severity and complexity of the operational upset.',
    `deviation_category` STRING COMMENT 'High-level classification of the schedule deviation type, used for trend analysis and root cause categorization.. Valid values are `equipment failure|feedstock quality|utility constraint|market demand change|planned maintenance overrun|unplanned shutdown`',
    `deviation_date` DATE COMMENT 'The date when the schedule deviation occurred or was first identified. Primary business event timestamp for the deviation.',
    `deviation_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule deviation was resolved and operations returned to planned schedule, or when the deviation was formally closed.',
    `deviation_number` STRING COMMENT 'Business identifier for the schedule deviation, typically following a refinery-specific numbering convention for tracking and reporting purposes.',
    `deviation_start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the schedule deviation began, capturing the exact moment operations diverged from the approved schedule.',
    `deviation_status` STRING COMMENT 'Current lifecycle status of the schedule deviation record, tracking progression from identification through resolution.. Valid values are `open|under investigation|corrective action in progress|resolved|closed`',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the schedule deviation in hours, calculated from deviation start to end timestamp.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Boolean indicator whether the schedule deviation resulted in any environmental impact such as emissions exceedance, flaring, or release events requiring EPA reporting.',
    `feedstock_quality_issue_flag` BOOLEAN COMMENT 'Boolean indicator whether the deviation was caused or influenced by feedstock quality issues such as high TAN, sulfur content, or contaminants.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the person who last updated the schedule deviation record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the schedule deviation record was last updated in the database.',
    `margin_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact on refining margin due to the schedule deviation, accounting for lost production value, product mix changes, and market price effects.',
    `opex_variance_amount` DECIMAL(18,2) COMMENT 'The incremental or avoided operating expenditure resulting from the schedule deviation, including additional utility costs, overtime labor, or expedited material costs.',
    `planned_throughput_bpd` DECIMAL(18,2) COMMENT 'The scheduled crude oil or feedstock throughput rate in barrels per day as per the approved refinery schedule before the deviation occurred.',
    `planned_yield_percentage` DECIMAL(18,2) COMMENT 'The scheduled product yield percentage for the affected product stream as per the approved refinery schedule and process optimization targets.',
    `production_loss_barrels` DECIMAL(18,2) COMMENT 'Total volume of production lost due to the schedule deviation, measured in barrels of the affected product stream.',
    `reported_to_management_flag` BOOLEAN COMMENT 'Boolean indicator whether this schedule deviation was escalated and formally reported to refinery management or corporate leadership due to severity or financial impact.',
    `root_cause_code` STRING COMMENT 'Standardized code identifying the specific root cause of the schedule deviation, aligned with refinery incident classification taxonomy.',
    `root_cause_description` STRING COMMENT 'Detailed narrative explanation of the root cause analysis findings, documenting why the deviation occurred and contributing factors.',
    `safety_incident_flag` BOOLEAN COMMENT 'Boolean indicator whether the schedule deviation was associated with or resulted in a safety incident requiring HSE investigation or OSHA reporting.',
    `schedule_recovery_plan` STRING COMMENT 'Description of the plan to recover lost production or return to the original schedule, including any adjustments to downstream operations or product slate.',
    `throughput_variance_bpd` DECIMAL(18,2) COMMENT 'The difference between planned and actual throughput in barrels per day, calculated as actual minus planned throughput.',
    `total_financial_impact_amount` DECIMAL(18,2) COMMENT 'Total estimated financial impact of the schedule deviation, combining OPEX variance and margin impact for comprehensive cost assessment.',
    `utility_constraint_type` STRING COMMENT 'Type of utility constraint that contributed to the schedule deviation, if applicable. Identifies which utility system limitation impacted operations. [ENUM-REF-CANDIDATE: steam|power|cooling water|fuel gas|hydrogen|nitrogen|instrument air|none — 8 candidates stripped; promote to reference product]',
    `yield_variance_percentage` DECIMAL(18,2) COMMENT 'The difference between planned and actual yield percentages, calculated as actual minus planned yield.',
    CONSTRAINT pk_schedule_deviation PRIMARY KEY(`schedule_deviation_id`)
) COMMENT 'Record of deviations from the approved refinery schedule, capturing deviation date, affected unit or product stream, planned vs. actual throughput or yield, root cause category (equipment failure, feedstock quality, utility constraint, market demand change), financial impact estimate (OPEX variance, margin impact), corrective action taken, and resolution status. Supports operational performance management and schedule optimization.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`blending_recipe` (
    `blending_recipe_id` BIGINT COMMENT 'Unique identifier for the blending recipe. Primary key for the blending recipe master record and single source of truth (SSOT) for petroleum product blending specifications.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Blending recipes specify additives (octane boosters, cetane improvers, lubricity agents, antioxidants) procured as materials. Real blending operations track material numbers for additive dosing calcul',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `product_specification_id` BIGINT COMMENT 'Foreign key linking to refining.product_specification. Business justification: blending_recipe.target_product_grade (STRING) should be normalized to product_specification_id FK. Blending recipes are designed to meet specific product specifications. This allows joining to product',
    `actual_component_volumes` STRING COMMENT 'Structured representation of the actual volumes (in barrels or cubic meters) of each component stream used in the blend execution. Used for blend loss accounting and variance analysis.',
    `approval_date` DATE COMMENT 'Date on which the blending recipe was formally approved for use in production operations.',
    `approval_status` STRING COMMENT 'Approval workflow status indicating whether the recipe has been reviewed and authorized for operational use by quality assurance and operations management.. Valid values are `pending|approved|rejected|under_review`',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved the blending recipe for operational use.',
    `blend_end_timestamp` TIMESTAMP COMMENT 'Date and time when the actual blending operation using this recipe was completed. Used for cycle time analysis and production reporting.',
    `blend_loss_bbl` DECIMAL(18,2) COMMENT 'Calculated volume loss in barrels (BBL) during the blending operation, representing the difference between total component input volumes and final blend output volume. Used for loss accounting and process efficiency analysis.',
    `blend_optimization_model` STRING COMMENT 'Reference to the mathematical optimization model or algorithm used in Aspen HYSYS or other process simulation software to calculate optimal component ratios for cost minimization and quality compliance.',
    `blend_start_timestamp` TIMESTAMP COMMENT 'Date and time when the actual blending operation using this recipe was initiated. Captured from DCS or SCADA (Supervisory Control and Data Acquisition) system for blend execution history.',
    `blend_tank_reference` STRING COMMENT 'Identifier or name of the storage tank or inline blender equipment where this recipe is executed. Links to asset management and facility configuration.',
    `component_streams` STRING COMMENT 'Comma-separated list or structured representation of the feedstock component streams (e.g., reformate, alkylate, FCC (Fluid Catalytic Cracking) gasoline, straight-run naphtha) that are blended together to produce the target product.',
    `component_volume_fractions` STRING COMMENT 'Structured representation of the target volume fraction or percentage for each component stream in the blend. Used by Aspen HYSYS blend optimizer to calculate optimal blend ratios.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this blending recipe record was first created in the system. Used for audit trail and data lineage tracking.',
    `effective_end_date` DATE COMMENT 'Date after which the blending recipe is no longer valid for use. Null indicates an open-ended recipe with no planned expiration.',
    `effective_start_date` DATE COMMENT 'Date from which the blending recipe becomes valid and available for use in production blending operations.',
    `final_blend_volume_bbl` DECIMAL(18,2) COMMENT 'Total volume of the final blended product in barrels (BBL). Used for inventory reconciliation, product release, and blend loss calculation.',
    `inline_blender_flag` BOOLEAN COMMENT 'Boolean indicator of whether this recipe is designed for inline blending (True) or batch tank blending (False). Affects process control strategy and DCS (Distributed Control System) configuration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this blending recipe record was last updated or modified. Used for audit trail and change tracking.',
    `measured_density_kg_m3` DECIMAL(18,2) COMMENT 'Actual measured density in kilograms per cubic meter (kg/m³) of the final blended product from laboratory analysis. Used for quality certification and volume-to-mass conversions.',
    `measured_ron` DECIMAL(18,2) COMMENT 'Actual measured Research Octane Number (RON) of the final blended product from laboratory analysis. Compared against target RON for quality compliance verification.',
    `measured_rvp_psi` DECIMAL(18,2) COMMENT 'Actual measured Reid Vapor Pressure (RVP) in pounds per square inch (psi) of the final blended product from laboratory analysis. Compared against target RVP for seasonal compliance.',
    `measured_sulfur_ppm` DECIMAL(18,2) COMMENT 'Actual measured sulfur content in parts per million (ppm) of the final blended product from laboratory analysis. Critical for EPA emissions compliance verification.',
    `operator_signoff_timestamp` TIMESTAMP COMMENT 'Date and time when the operator formally signed off on the completed blending operation, confirming process completion and handover to quality assurance.',
    `product_type` STRING COMMENT 'High-level classification of the petroleum product being blended. Used for regulatory reporting and product slate planning. [ENUM-REF-CANDIDATE: gasoline|diesel|jet_fuel|fuel_oil|kerosene|naphtha|lpg|other — 8 candidates stripped; promote to reference product]',
    `quality_certification_number` STRING COMMENT 'Unique certificate or batch release number issued by the quality assurance laboratory upon successful compliance verification. Required for product custody transfer.',
    `quality_compliance_status` STRING COMMENT 'Overall quality compliance status indicating whether the final blended product meets all target specifications and is approved for product release and distribution.. Valid values are `compliant|non_compliant|pending_test|conditional_release`',
    `recipe_code` STRING COMMENT 'Standardized alphanumeric code for the blending recipe used in Aspen HYSYS blend optimizer and Distributed Control System (DCS) blend controllers for automated reference.',
    `recipe_name` STRING COMMENT 'Business-friendly name or designation for the blending recipe used for identification and reference in operations and planning.',
    `recipe_status` STRING COMMENT 'Current lifecycle status of the blending recipe indicating whether it is available for use in production operations.. Valid values are `draft|approved|active|suspended|obsolete|archived`',
    `recipe_version` STRING COMMENT 'Version number of the blending recipe used for change tracking and Management of Change (MOC) compliance. Incremented with each approved modification to the recipe.',
    `target_api_gravity` DECIMAL(18,2) COMMENT 'Target API (American Petroleum Institute) gravity specification for the blended crude or refined product. Industry-standard measure of petroleum liquid density relative to water.',
    `target_cetane_number` DECIMAL(18,2) COMMENT 'Target cetane number specification for diesel fuel blends. Measures ignition quality and combustion performance in compression-ignition engines.',
    `target_density_kg_m3` DECIMAL(18,2) COMMENT 'Target density specification in kilograms per cubic meter (kg/m³) at a specified temperature for the blended product. Used for volume-to-mass conversions and quality control.',
    `target_flash_point_c` DECIMAL(18,2) COMMENT 'Target flash point specification in degrees Celsius for the blended product. Critical safety property for handling, storage, and transportation.',
    `target_freeze_point_c` DECIMAL(18,2) COMMENT 'Target freeze point specification in degrees Celsius for jet fuel blends. Critical for aviation fuel performance at high altitudes and cold climates.',
    `target_mon` DECIMAL(18,2) COMMENT 'Target Motor Octane Number (MON) specification for the blended gasoline product. Used in conjunction with RON to determine anti-knock index.',
    `target_ron` DECIMAL(18,2) COMMENT 'Target Research Octane Number (RON) specification for the blended gasoline product. Critical quality property for spark-ignition engine fuel performance.',
    `target_rvp_psi` DECIMAL(18,2) COMMENT 'Target Reid Vapor Pressure (RVP) specification in pounds per square inch (psi) for the blended gasoline product. Controls evaporative emissions and seasonal volatility requirements.',
    `target_sulfur_ppm` DECIMAL(18,2) COMMENT 'Target sulfur content specification in parts per million (ppm) for the blended product. Critical for Environmental Protection Agency (EPA) emissions compliance and Hydrodesulfurization (HDS) operations.',
    `target_viscosity_cst` DECIMAL(18,2) COMMENT 'Target kinematic viscosity specification in centistokes (cSt) at a specified temperature for the blended product. Important for fuel oils and lubricants.',
    CONSTRAINT pk_blending_recipe PRIMARY KEY(`blending_recipe_id`)
) COMMENT 'Master record and SSOT for petroleum product blending specifications and blending execution history. Captures recipe name, target product grade, component streams and volume fractions, target quality properties (RON, sulfur, RVP, flash point, viscosity, density), blend optimization model reference, approval status, effective date range, and actual blending event records including blend start/end datetime, actual component volumes, final blend volume, measured quality properties, quality compliance status, blend tank or inline blender reference, and operator sign-off. Used by Aspen HYSYS blend optimizer and DCS blend controllers. Supports product release, quality certification, and blend loss accounting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`blend_event` (
    `blend_event_id` BIGINT COMMENT 'Unique identifier for the blend event transaction. Primary key for the blend event record.',
    `blending_recipe_id` BIGINT COMMENT 'Reference to the blending recipe or formula that was used to guide this blend operation, defining target ratios and component specifications.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Blending operations incur costs (component streams, utilities, labor, additives) that must be charged to cost centers. Enables tracking of blending costs and calculation of finished product cost.',
    `employee_id` BIGINT COMMENT 'Reference to the refinery operator or technician who executed and supervised the blend operation.',
    `product_specification_id` BIGINT COMMENT 'Foreign key linking to refining.product_specification. Business justification: blend_event.target_product_grade (STRING) should be normalized to product_specification_id FK. Blend events target specific product specifications (RON, sulfur, RVP limits). This allows joining to pro',
    `refinery_id` BIGINT COMMENT 'Reference to the refinery facility where this blend operation was executed.',
    `tank_inventory_id` BIGINT COMMENT 'Reference to the storage tank or inline blender equipment where the blending operation took place.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Blend events produce specific finished petroleum products (premium gasoline, ULSD, jet A-1) for sale or transfer. Critical for inventory management, product release certification, quality compliance t',
    `unit_run_id` BIGINT COMMENT 'Foreign key linking to refining.unit_run. Business justification: Each blend event occurs during a unit run; linking the event to its unit run provides traceability of blending performance within the run.',
    `blend_duration_minutes` DECIMAL(18,2) COMMENT 'The total elapsed time in minutes from blend start to blend end, used for cycle time analysis and operational efficiency tracking.',
    `blend_end_timestamp` TIMESTAMP COMMENT 'The actual date and time when the blending operation was completed and final product was ready for quality testing.',
    `blend_loss_bbl` DECIMAL(18,2) COMMENT 'The volume difference between total component inputs and final blend output, representing evaporative losses, measurement errors, or process losses.',
    `blend_mode` STRING COMMENT 'The control mode used during the blend operation: automatic (DCS-controlled), manual (operator-controlled), or semi-automatic (operator-initiated with automated control).. Valid values are `automatic|manual|semi_automatic`',
    `blend_notes` STRING COMMENT 'Free-text field for operator or supervisor comments regarding unusual conditions, deviations, or observations during the blend operation.',
    `blend_number` STRING COMMENT 'Externally-known unique business identifier for the blend operation, used for tracking and audit purposes across refinery systems.. Valid values are `^BLD-[0-9]{8}-[A-Z0-9]{4}$`',
    `blend_start_timestamp` TIMESTAMP COMMENT 'The actual date and time when the blending operation commenced, marking the beginning of component mixing.',
    `blend_status` STRING COMMENT 'Current lifecycle status of the blend operation indicating its workflow state in the refinery blending process.. Valid values are `planned|in_progress|completed|aborted|on_hold|quality_hold`',
    `blend_temperature_f` DECIMAL(18,2) COMMENT 'The operating temperature at which the blending operation was conducted, critical for viscosity control and quality consistency.',
    `blend_type` STRING COMMENT 'Classification of the blending method used: inline (continuous blending), batch (tank blending), ratio (proportional blending), or sequential (staged component addition).. Valid values are `inline|batch|ratio|sequential`',
    `component_count` STRING COMMENT 'The total number of distinct feedstock components or blend stocks that were mixed in this blend operation.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this blend event record was first created in the database.',
    `dcs_batch_code` STRING COMMENT 'The batch identifier assigned by the Distributed Control System (DCS) for tracking and integration with process control systems.',
    `epa_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether the finished blend meets all applicable EPA emissions and environmental quality standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this blend event record was last updated or modified.',
    `measured_api_gravity` DECIMAL(18,2) COMMENT 'The actual API gravity of the finished blend, indicating the density and quality of the petroleum product relative to water.',
    `measured_flash_point_f` DECIMAL(18,2) COMMENT 'The actual flash point temperature of the finished blend, indicating the lowest temperature at which vapors will ignite, critical for safety classification.',
    `measured_mon` DECIMAL(18,2) COMMENT 'The actual Motor Octane Number measured in the final blended product, representing performance under high-speed engine conditions.',
    `measured_ron` DECIMAL(18,2) COMMENT 'The actual Research Octane Number measured in the final blended product, indicating the anti-knock quality of gasoline.',
    `measured_rvp_psi` DECIMAL(18,2) COMMENT 'The actual Reid Vapor Pressure of the finished blend, indicating volatility and evaporative emissions potential.',
    `measured_sulfur_ppm` DECIMAL(18,2) COMMENT 'The actual sulfur content measured in the final blended product, critical for EPA emissions compliance and environmental regulations.',
    `measured_tan` DECIMAL(18,2) COMMENT 'The actual Total Acid Number measured in the final blend, indicating the acidity level and corrosion potential of the product.',
    `measured_viscosity_cst` DECIMAL(18,2) COMMENT 'The actual kinematic viscosity of the finished blend measured at standard temperature, indicating flow characteristics.',
    `operator_signoff_timestamp` TIMESTAMP COMMENT 'The date and time when the operator formally signed off on the completed blend operation, confirming execution according to procedures.',
    `planned_volume_bbl` DECIMAL(18,2) COMMENT 'The originally planned or scheduled volume for this blend operation, used for variance analysis and blend loss accounting.',
    `product_release_status` STRING COMMENT 'The final disposition status of the blended product: released (approved for sale/transfer), held (awaiting further review), rejected (off-spec, requires reprocessing), or conditional (released with restrictions).. Valid values are `released|held|rejected|conditional`',
    `quality_compliance_status` STRING COMMENT 'Indicates whether the finished blend meets all target quality specifications: on-spec (meets all specs), off-spec (fails one or more specs), pending test (awaiting lab results), or conditional release (released with restrictions).. Valid values are `on_spec|off_spec|pending_test|conditional_release`',
    `quality_test_timestamp` TIMESTAMP COMMENT 'The date and time when quality testing of the finished blend was completed and results were recorded.',
    `release_certificate_number` STRING COMMENT 'The unique certificate or document number issued upon product release, used for quality traceability and customer certification.',
    `supervisor_approval_timestamp` TIMESTAMP COMMENT 'The date and time when the supervisor formally approved the blend operation for product release or further processing.',
    `target_ron` DECIMAL(18,2) COMMENT 'The intended Research Octane Number specification that the blend operation aimed to achieve.',
    `total_blend_volume_bbl` DECIMAL(18,2) COMMENT 'The total volume of finished blended product produced, measured in barrels at standard conditions.',
    CONSTRAINT pk_blend_event PRIMARY KEY(`blend_event_id`)
) COMMENT 'Transactional record of an actual product blending operation, capturing blend start/end datetime, target product grade, blending recipe used, actual component volumes blended, final blend volume, measured quality properties of finished blend, quality compliance status, blend tank or inline blender reference, and operator sign-off. Supports product release, quality certification, and blend loss accounting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`tank_inventory` (
    `tank_inventory_id` BIGINT COMMENT 'Unique identifier for the tank inventory snapshot record.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the refinery facility where the tank is located.',
    `blend_recipe_id` BIGINT COMMENT 'Identifier for the blending recipe or formula used if the tank contains a blended product.',
    `employee_id` BIGINT COMMENT 'Identifier of the operator or technician who recorded the manual measurement, if applicable.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Storage tanks are physical assets tracked in equipment master for integrity management and inspection scheduling. Real business process: tank inventory records must link to equipment master for API 65',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Tank inventory tracks specific petroleum products stored for production accounting, custody transfer, and logistics planning. Essential for inventory valuation, LIFO/FIFO accounting, loss/gain analysi',
    `release_report_id` BIGINT COMMENT 'Foreign key linking to compliance.release_report. Business justification: Unexplained tank inventory losses (LVUF exceeding thresholds) trigger release investigations and mandatory reporting under EPA SPCC regulations and OPA-90. Tank gauging discrepancies are primary indic',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Tank inventory is allocated to specific sales orders for delivery planning. Critical for order fulfillment, available-to-promise calculations, and logistics scheduling in refined product distribution.',
    `terminal_id` BIGINT COMMENT 'Foreign key linking to logistics.terminal. Business justification: Refinery tanks at marine or truck terminals track inventory available for logistics dispatch. Terminal operations planning, berth scheduling, and loading rack allocation require linking tank inventory',
    `batch_number` STRING COMMENT 'Unique batch or lot identifier for the product currently in the tank, used for quality traceability.. Valid values are `^[A-Z0-9-]{5,25}$`',
    `closing_volume_bbl` DECIMAL(18,2) COMMENT 'Tank inventory volume in barrels at the end of the measurement period.',
    `comments` STRING COMMENT 'Free-text field for operator notes, exceptions, or special conditions related to the inventory snapshot.',
    `custody_transfer_flag` BOOLEAN COMMENT 'Indicates whether this inventory measurement is used for custody transfer purposes (True) or internal accounting only (False).',
    `data_source_system` STRING COMMENT 'System or method from which the inventory data was captured (e.g., OSIsoft PI, DCS, SCADA, Manual Entry, ATG System).. Valid values are `OSIsoft PI|DCS|SCADA|Manual Entry|ATG System`',
    `deliveries_volume_bbl` DECIMAL(18,2) COMMENT 'Total volume delivered out of the tank during the measurement period, in barrels.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicates whether the tank inventory meets EPA emissions and environmental compliance requirements (True) or has compliance issues (False).',
    `fill_percentage` DECIMAL(18,2) COMMENT 'Percentage of tank capacity currently filled, calculated as (net_standard_volume_bbl / tank_capacity_bbl) * 100.',
    `free_water_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of free water present in the tank bottom, measured in barrels.',
    `gauge_method` STRING COMMENT 'Method used to measure tank level: ATG (Automatic Tank Gauge), Manual Dip, Radar, Servo, or Hybrid.. Valid values are `ATG|Manual Dip|Radar|Servo|Hybrid`',
    `gross_observed_volume_bbl` DECIMAL(18,2) COMMENT 'Total observed volume in the tank including free water and sediment, measured in barrels.',
    `last_calibration_date` DATE COMMENT 'Date when the tank gauging equipment was last calibrated or the tank strapping table was last verified.',
    `loss_gain_volume_bbl` DECIMAL(18,2) COMMENT 'Calculated inventory variance (loss if negative, gain if positive) from material balance reconciliation, in barrels.',
    `measurement_uncertainty_bbl` DECIMAL(18,2) COMMENT 'Estimated measurement uncertainty or tolerance for the volume measurement, in barrels, per API MPMS standards.',
    `net_standard_volume_bbl` DECIMAL(18,2) COMMENT 'Temperature-corrected net volume excluding free water and sediment, adjusted to standard conditions (60°F), measured in barrels.',
    `observed_density_api` DECIMAL(18,2) COMMENT 'Observed API gravity of the product at measurement temperature, used for volume correction calculations.',
    `observed_temperature_f` DECIMAL(18,2) COMMENT 'Measured temperature of the product in the tank at the time of observation, in degrees Fahrenheit.',
    `opening_volume_bbl` DECIMAL(18,2) COMMENT 'Tank inventory volume in barrels at the beginning of the measurement period.',
    `quality_certification_flag` BOOLEAN COMMENT 'Indicates whether the product in the tank has passed quality certification and is approved for delivery (True) or is pending certification (False).',
    `receipts_volume_bbl` DECIMAL(18,2) COMMENT 'Total volume received into the tank during the measurement period, in barrels.',
    `record_created_timestamp` TIMESTAMP COMMENT 'System timestamp when this inventory record was first created in the data platform.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this inventory record was last modified in the data platform.',
    `ron_value` DECIMAL(18,2) COMMENT 'Research Octane Number for gasoline products, indicating knock resistance and fuel quality.',
    `snapshot_timestamp` TIMESTAMP COMMENT 'Date and time when the inventory snapshot was recorded, typically at shift change or daily cutoff.',
    `standard_density_api` DECIMAL(18,2) COMMENT 'API gravity of the product corrected to standard temperature of 60°F for custody transfer and accounting.',
    `sulfur_content_ppm` DECIMAL(18,2) COMMENT 'Sulfur content of the product in parts per million, critical for EPA compliance and product specification.',
    `tan_value` DECIMAL(18,2) COMMENT 'Total Acid Number indicating the acidity of crude oil or product, measured in mg KOH/g, important for corrosion assessment.',
    `tank_capacity_bbl` DECIMAL(18,2) COMMENT 'Maximum working capacity of the storage tank in barrels.',
    `tank_gauge_height_ft` DECIMAL(18,2) COMMENT 'Measured liquid level height from tank datum reference point, in feet.',
    `tank_identifier` STRING COMMENT 'Unique alphanumeric identifier for the storage tank within the refinery (e.g., TK-101, CRUDE-A).. Valid values are `^[A-Z0-9]{3,20}$`',
    `tank_operational_status` STRING COMMENT 'Current operational state of the tank at the time of inventory snapshot.. Valid values are `In Service|Out of Service|Filling|Draining|Maintenance|Inspection`',
    `vapor_pressure_psi` DECIMAL(18,2) COMMENT 'Reid Vapor Pressure (RVP) of the product stored, measured in pounds per square inch, critical for volatile products.',
    CONSTRAINT pk_tank_inventory PRIMARY KEY(`tank_inventory_id`)
) COMMENT 'Daily or shift-level inventory snapshot for refinery storage tanks, capturing tank identifier, product grade stored, opening and closing volumes (barrels), temperature-corrected net volume, observed density, free water volume, tank gauge method (ATG, manual dip), custody transfer status, and tank operational status. Supports refinery material balance, crude and product scheduling, loss accounting, and custody transfer per API MPMS Chapter 12 standards.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`turnaround` (
    `turnaround_id` BIGINT COMMENT 'Unique identifier for the refinery turnaround event. Primary key.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Turnarounds are AFE-authorized capital events requiring budget approval before execution. Real turnaround financial control tracks AFE for capex/opex classification, budget-vs-actual variance reportin',
    `asset_facility_id` BIGINT COMMENT 'Reference to the refinery facility where the turnaround is taking place.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Turnarounds are executed under master service agreements covering scaffolding, inspection, catalyst replacement, mechanical services. Real turnaround management tracks governing contract for scope ver',
    `contractor_id` BIGINT COMMENT 'FK to workforce.contractor',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Turnaround costs must be allocated to cost centers for financial reporting and variance analysis. Enables tracking of maintenance spend by organizational unit and comparison to budget.',
    `emergency_drill_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_drill. Business justification: Major turnarounds require emergency preparedness drills for contractor orientation and muster station verification. Regulatory compliance (OSHA, EPA) requires turnaround-to-drill linkage for documenta',
    `audit_id` BIGINT COMMENT 'Foreign key linking to hse.audit. Business justification: Major turnarounds require HSE compliance audits for pre-startup safety reviews (PSSR), contractor safety verification, and regulatory closure. Turnaround management systems link audits to turnaround s',
    `integrity_program_id` BIGINT COMMENT 'Foreign key linking to asset.integrity_program. Business justification: Turnaround scope and timing are driven by integrity program inspection schedules and RBI intervals. Real business process: turnaround planning aligns with integrity program requirements to execute ins',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Major turnarounds in JV refineries require JOA partner approval, cost sharing per working interest percentages, and AFE authorization per JOA terms. Non-consent provisions and voting thresholds apply ',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Major turnarounds require temporary permits for activities like hot work, confined space entry, increased flaring/venting, and temporary emissions during startup/shutdown. These permits authorize devi',
    `venture_afe_id` BIGINT COMMENT 'Foreign key linking to venture.venture_afe. Business justification: Every major turnaround project requires a venture AFE for partner approval, budget authorization, and cost allocation. AFE tracks partner elections, non-consent positions, and actual costs for JIB bil',
    `actual_capex_usd` DECIMAL(18,2) COMMENT 'Actual capital expenditure incurred during the turnaround in US dollars.',
    `actual_duration_days` STRING COMMENT 'Actual duration of the turnaround in calendar days from shutdown to startup.',
    `actual_end_date` DATE COMMENT 'Actual date the turnaround was completed and unit returned to production.',
    `actual_opex_usd` DECIMAL(18,2) COMMENT 'Actual operating expenditure incurred during the turnaround in US dollars.',
    `actual_start_date` DATE COMMENT 'Actual date the turnaround work commenced (unit shutdown).',
    `affected_units` STRING COMMENT 'Comma-separated list or description of process units affected by the turnaround (e.g., CDU-1, VDU-2, HDS-3). Identifies which refinery units will be offline.',
    `capex_budget_usd` DECIMAL(18,2) COMMENT 'Approved capital expenditure budget for the turnaround in US dollars, covering equipment replacement and major upgrades.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Overall completion percentage of the turnaround scope (0.00 to 100.00), calculated as completed work orders divided by total planned work orders.',
    `contractor_mobilization_date` DATE COMMENT 'Date when the contractor mobilized personnel and equipment to the refinery site for turnaround preparation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the turnaround record was first created in the system.',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether this turnaround is on the critical path for refinery production capacity (True) or is non-critical (False).',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicates whether the turnaround met all Environmental Protection Agency (EPA) emissions and environmental compliance requirements (True) or had violations (False).',
    `hse_incident_count` STRING COMMENT 'Total number of Health, Safety, and Environment (HSE) incidents (recordable injuries, near misses, environmental releases) reported during the turnaround.',
    `inspection_findings_summary` STRING COMMENT 'Summary of key inspection findings from Non-Destructive Testing (NDT), corrosion monitoring, and integrity assessments conducted during the turnaround.',
    `lessons_learned_summary` STRING COMMENT 'Summary of key lessons learned and best practices identified during the turnaround for future planning and execution improvement.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified the turnaround record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the turnaround record was last modified or updated.',
    `opex_budget_usd` DECIMAL(18,2) COMMENT 'Approved operating expenditure budget for the turnaround in US dollars, covering maintenance, inspection, and contractor labor.',
    `permit_to_work_count` STRING COMMENT 'Total number of Permit to Work (PTW) permits issued during the turnaround for hot work, confined space entry, and other hazardous activities.',
    `planned_duration_days` STRING COMMENT 'Planned duration of the turnaround in calendar days from shutdown to startup.',
    `planned_end_date` DATE COMMENT 'Scheduled date for the turnaround to complete and unit to return to service.',
    `planned_start_date` DATE COMMENT 'Scheduled date for the turnaround to begin (unit shutdown initiation).',
    `post_turnaround_performance_notes` STRING COMMENT 'Notes on unit performance following turnaround completion, including throughput improvements, yield optimization results, and any startup issues encountered.',
    `production_deferral_boe` DECIMAL(18,2) COMMENT 'Estimated production loss in barrels of oil equivalent due to the turnaround shutdown period.',
    `project_manager_name` STRING COMMENT 'Name of the internal project manager responsible for overall turnaround planning, execution, and closeout.',
    `regulatory_inspection_flag` BOOLEAN COMMENT 'Indicates whether the turnaround included mandatory regulatory inspections by EPA, OSHA, or state authorities (True) or was purely internal (False).',
    `safety_case_reference` STRING COMMENT 'Reference identifier for the Health, Safety, and Environment (HSE) safety case or risk assessment document prepared for the turnaround.',
    `scope_summary` STRING COMMENT 'High-level narrative description of the turnaround scope, including major work packages (e.g., Heat exchanger bundle replacement, reactor catalyst change, piping integrity inspection, valve overhaul).',
    `startup_date` DATE COMMENT 'Date when the affected process units were restarted and brought back online following turnaround completion.',
    `total_labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours expended across all work scopes during the turnaround, including contractor and internal workforce.',
    `turnaround_code` STRING COMMENT 'Unique business identifier or code for the turnaround event used in scheduling and reporting systems.',
    `turnaround_name` STRING COMMENT 'Business name or designation for the turnaround event (e.g., CDU-1 Major TAR 2024, FCC Unit Catalyst Change Q2).',
    `turnaround_status` STRING COMMENT 'Current lifecycle status of the turnaround: planning (scope definition), approved (AFE authorized), mobilization (contractor setup), execution (work in progress), closeout (final documentation), completed (unit back online), cancelled. [ENUM-REF-CANDIDATE: planning|approved|mobilization|execution|closeout|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `turnaround_type` STRING COMMENT 'Classification of the turnaround scope and scale: major (full unit shutdown with extensive work), minor (limited scope), catalyst_change (FCC/HDS catalyst replacement), inspection (regulatory or integrity-driven), emergency (unplanned).. Valid values are `major|minor|catalyst_change|inspection|emergency`',
    `work_order_count` STRING COMMENT 'Total number of individual work orders issued and executed as part of the turnaround scope.',
    `created_by` STRING COMMENT 'User ID or name of the person who created the turnaround record.',
    CONSTRAINT pk_turnaround PRIMARY KEY(`turnaround_id`)
) COMMENT 'Master record and SSOT for planned refinery turnaround (TAR) and shutdown events, covering full turnaround lifecycle from planning through execution to closeout. Captures turnaround name, affected units, planned and actual start/end dates, scope of work summary, CAPEX/OPEX budget (AFE reference), contractor mobilization plan, safety case reference, production deferral estimate (BOE), turnaround status (planning, execution, closeout), and individual work scope items including equipment tags, work types (inspection, repair, replacement, cleaning, catalyst change), labor hours, costs, critical path flags, completion status, and inspection findings. Integrates with Maximo work order management and SAP PS project system.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` (
    `turnaround_work_item_id` BIGINT COMMENT 'Unique identifier for the turnaround work item. Primary key for this entity.',
    `compliance_corrective_action_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action. Business justification: Inspection findings during turnarounds (corrosion, mechanical integrity deficiencies, PSM gaps) generate corrective actions tracked in compliance management systems. Links turnaround inspection result',
    `contractor_id` BIGINT COMMENT 'FK to workforce.contractor',
    `equipment_id` BIGINT COMMENT 'Foreign key reference to the equipment master record in the asset management system.',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Individual work items within turnarounds may be charged to specific AFEs for granular cost tracking. Enables detailed variance analysis and supports capitalization vs. expense decisions for individual',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Turnaround work items consume specific materials (gaskets, bolts, valves, catalyst, refractory). Real turnaround planning specifies material numbers for bill-of-materials generation, procurement lead ',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to hse.permit_to_work. Business justification: Turnaround work items (inspections, repairs) require permits for hot work, confined space entry, and energy isolation. Work management systems link work items to permits for authorization tracking and',
    `predecessor_work_item_turnaround_work_item_id` BIGINT COMMENT 'Reference to another work item that must be completed before this work item can begin. Used for dependency management and critical path scheduling.',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to refining.process_unit. Business justification: turnaround_work_item.process_unit (STRING) should be normalized to process_unit_id FK. Turnaround work items are scoped to specific process units. This allows joining to process_unit master to retriev',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Individual turnaround work items consume materials and services ordered via specific POs. Real maintenance cost control requires PO linkage per work item for actual-vs-budget tracking, three-way match',
    `turnaround_id` BIGINT COMMENT 'Reference to the parent turnaround event that this work item belongs to. Links to the master turnaround schedule.',
    `actual_cost_usd` DECIMAL(18,2) COMMENT 'Total actual cost incurred for this work item upon completion. Includes all labor, materials, equipment, and services. Used for cost variance analysis and financial reporting.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when work on this item was completed. Used for duration analysis and turnaround performance metrics.',
    `actual_labor_hours` DECIMAL(18,2) COMMENT 'Actual total labor hours expended on this work item upon completion. Used for cost control, variance analysis, and future estimating.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when work on this item commenced. Used for schedule variance analysis and performance tracking.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of work completed for this item, ranging from 0.00 to 100.00. Used for progress tracking and earned value analysis during turnaround execution.',
    `craft_type` STRING COMMENT 'Primary craft or trade discipline required for this work item (e.g., mechanical, electrical, instrumentation, insulation, scaffolding, welding). Used for resource allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this work item record was first created in the system. Used for audit trail and data lineage.',
    `critical_path_flag` BOOLEAN COMMENT 'Boolean indicator whether this work item is on the critical path of the turnaround schedule. True indicates any delay will extend the overall turnaround duration.',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Total estimated cost for this work item including labor, materials, equipment rental, and contractor services. Used for Authorization for Expenditure (AFE) and budget control.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Planned total labor hours required to complete this work item, used for resource planning and scheduling. Includes all crafts and disciplines.',
    `hse_incident_flag` BOOLEAN COMMENT 'Boolean indicator whether a Health, Safety, or Environmental incident occurred during the execution of this work item. True triggers incident investigation workflow.',
    `inspection_findings` STRING COMMENT 'Summary of inspection results, observations, and findings discovered during the work execution. Critical for integrity management and future planning.',
    `inspection_result` STRING COMMENT 'Overall result classification of the inspection or testing performed. Determines whether equipment can return to service or requires additional work.. Valid values are `pass|fail|conditional|not_applicable`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this work item record was last updated. Used for change tracking and audit purposes.',
    `material_cost_usd` DECIMAL(18,2) COMMENT 'Total cost of materials, parts, and consumables used for this work item. Subset of actual cost used for detailed cost analysis.',
    `notes` STRING COMMENT 'Additional notes, comments, or observations related to the work item execution, lessons learned, or special conditions encountered.',
    `planned_end_date` DATE COMMENT 'Scheduled date when work on this item is planned to be completed. Used for turnaround duration planning and critical path analysis.',
    `planned_start_date` DATE COMMENT 'Scheduled date when work on this item is planned to begin. Used for turnaround scheduling and resource coordination.',
    `quality_hold_flag` BOOLEAN COMMENT 'Boolean indicator whether this work item is currently on quality hold pending inspection, testing, or rework. True prevents progression to next phase.',
    `responsible_supervisor` STRING COMMENT 'Name of the supervisor or work package owner responsible for overseeing the execution of this work item. Accountable for safety, quality, and schedule.',
    `safety_permit_number` STRING COMMENT 'Permit to Work number issued for this work item. Required for high-risk activities and ensures proper safety controls are in place.',
    `scope_change_flag` BOOLEAN COMMENT 'Boolean indicator whether the work scope was modified after initial approval. True indicates variance from original plan requiring Management of Change (MOC) review.',
    `scope_change_reason` STRING COMMENT 'Explanation of why the work scope was changed, including justification and impact assessment. Required when scope_change_flag is true.',
    `work_item_description` STRING COMMENT 'Detailed description of the work scope, including the specific task, objective, and any special instructions or safety considerations.',
    `work_order_number` STRING COMMENT 'External work order number from the CMMS system (Maximo) that tracks this work item. Used for integration and cross-system reconciliation.',
    `work_package_code` STRING COMMENT 'Hierarchical work breakdown structure code that groups related work items into packages for planning and execution coordination.',
    `work_priority` STRING COMMENT 'Priority classification indicating the urgency and business criticality of this work item. Critical items may drive the turnaround duration.. Valid values are `critical|high|medium|low`',
    `work_status` STRING COMMENT 'Current lifecycle status of the work item within the turnaround execution. Tracks progression from planning through completion.. Valid values are `planned|approved|in_progress|on_hold|completed|cancelled`',
    `work_type` STRING COMMENT 'Classification of the type of work to be performed during the turnaround. Determines resource requirements and scheduling constraints. [ENUM-REF-CANDIDATE: inspection|repair|replacement|cleaning|catalyst_change|modification|upgrade|testing|calibration — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_turnaround_work_item PRIMARY KEY(`turnaround_work_item_id`)
) COMMENT 'Individual work scope item within a refinery turnaround, capturing work item description, process unit, equipment tag, work type (inspection, repair, replacement, cleaning, catalyst change), estimated and actual labor hours, estimated and actual cost, critical path flag, completion status, and inspection findings. Supports turnaround scope management, cost control, and Maximo work order integration.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`energy_consumption` (
    `energy_consumption_id` BIGINT COMMENT 'Unique identifier for the energy consumption record. Primary key for the energy consumption data product.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the refinery facility where energy consumption is measured.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Energy costs (fuel gas, steam, electricity) must be allocated to cost centers for unit economics and benchmarking. Critical for calculating energy intensity, identifying efficiency opportunities, and ',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Energy costs in JV refineries are allocated to partners per JOA working interest percentages and overhead rate methods. Monthly JIB statements include energy consumption costs; JOA linkage enables acc',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Energy intensity metrics are tracked per primary product type for carbon accounting, efficiency benchmarking, and GHG emissions reporting (Scope 1/2). Essential for EPA GHGRP reporting, carbon intensi',
    `process_unit_id` BIGINT COMMENT 'Reference to the specific process unit (CDU, VDU, FCC, HDS, hydrocracker, reformer, etc.) consuming energy.',
    `benchmark_category` STRING COMMENT 'Solomon complexity category for the refinery or process unit used for energy intensity benchmarking (simple: atmospheric distillation only, moderate: includes vacuum distillation, complex: includes cracking units, very complex: includes coking and advanced conversion).. Valid values are `simple|moderate|complex|very_complex`',
    `compliance_reporting_flag` BOOLEAN COMMENT 'Indicates whether this energy consumption record is included in regulatory compliance reporting (EPA Subpart Y GHG reporting, state energy reporting, etc.).',
    `cooling_water_usage_m3` DECIMAL(18,2) COMMENT 'Volume of cooling water consumed by the process unit measured in cubic meters (m³). Used for heat exchangers, condensers, and cooling towers.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this energy consumption record was first created in the system. Audit trail field for data lineage.',
    `crude_throughput_bpd` DECIMAL(18,2) COMMENT 'Volume of crude oil processed through the refinery measured in barrels per day (BPD). Used as denominator for energy intensity calculations.',
    `data_quality_flag` STRING COMMENT 'Indicator of data quality and reliability (verified: validated by operations, estimated: calculated or interpolated, suspect: questionable accuracy, missing: data gap filled with default).. Valid values are `verified|estimated|suspect|missing`',
    `data_source_system` STRING COMMENT 'Name of the source system that provided the energy consumption data (e.g., OSIsoft PI System, Aspen HYSYS, DCS, SCADA, manual entry).',
    `electricity_consumption_mwh` DECIMAL(18,2) COMMENT 'Electrical energy consumed by the process unit measured in megawatt hours (MWh). Includes power for motors, compressors, pumps, and instrumentation.',
    `energy_efficiency_index` DECIMAL(18,2) COMMENT 'Normalized energy efficiency index comparing actual energy consumption to industry benchmark. Values below 100 indicate better-than-average efficiency, values above 100 indicate below-average efficiency.',
    `energy_intensity_mmbtu_per_bbl` DECIMAL(18,2) COMMENT 'Total energy consumed per barrel of crude throughput measured in million British Thermal Units per barrel (MMBtu/bbl). Key performance indicator for refinery energy efficiency.',
    `energy_source_type` STRING COMMENT 'Primary type of energy consumed by the process unit. Used for energy source segmentation and analysis.. Valid values are `fuel_gas|steam|electricity|hydrogen|cooling_water|mixed`',
    `fuel_gas_consumption_mmscfd` DECIMAL(18,2) COMMENT 'Volume of fuel gas consumed by the process unit measured in million standard cubic feet per day (MMSCFD). Used for combustion in furnaces, heaters, and boilers.',
    `ghg_emissions_co2e_tonnes` DECIMAL(18,2) COMMENT 'Total greenhouse gas emissions associated with energy consumption measured in tonnes of carbon dioxide equivalent (CO2e). Calculated using EPA emission factors.',
    `hydrogen_consumption_mmscfd` DECIMAL(18,2) COMMENT 'Volume of hydrogen consumed by the process unit measured in million standard cubic feet per day (MMSCFD). Used primarily in HDS, hydrocracker, and isomerization units.',
    `hydrogen_export_mmscfd` DECIMAL(18,2) COMMENT 'Volume of hydrogen exported to external customers or other facilities measured in million standard cubic feet per day (MMSCFD).',
    `hydrogen_import_mmscfd` DECIMAL(18,2) COMMENT 'Volume of hydrogen imported from external sources or other facilities measured in million standard cubic feet per day (MMSCFD).',
    `hydrogen_network_pressure_psig` DECIMAL(18,2) COMMENT 'Operating pressure of the hydrogen distribution network measured in pounds per square inch gauge (psig). Critical for hydrogen balance and distribution optimization.',
    `hydrogen_production_mmscfd` DECIMAL(18,2) COMMENT 'Volume of hydrogen produced by the refinery hydrogen plant (reformer, SMR) measured in million standard cubic feet per day (MMSCFD).',
    `hydrogen_purity_percent` DECIMAL(18,2) COMMENT 'Purity of hydrogen measured as percentage by volume. Typical refinery hydrogen purity ranges from 70% to 99.9% depending on source (reformer, SMR, purification unit).',
    `hydrogen_source` STRING COMMENT 'Primary source of hydrogen consumed by the process unit (reformer: catalytic reformer, SMR: steam methane reformer, purification: pressure swing adsorption unit, import: external supply, mixed: multiple sources).. Valid values are `reformer|smr|purification|import|mixed`',
    `hydrogen_surplus_deficit_mmscfd` DECIMAL(18,2) COMMENT 'Net hydrogen balance calculated as production plus import minus consumption minus export, measured in million standard cubic feet per day (MMSCFD). Positive values indicate surplus, negative values indicate deficit.',
    `measurement_date` DATE COMMENT 'Date when the energy consumption was measured or recorded. Primary business event timestamp for the consumption record.',
    `measurement_method` STRING COMMENT 'Method used to determine energy consumption (direct meter: flow meter or energy meter, calculated: derived from process parameters, estimated: engineering estimate, allocated: proportional allocation from facility total).. Valid values are `direct_meter|calculated|estimated|allocated`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the energy consumption measurement was captured from the DCS or SCADA system.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this energy consumption record was last modified. Audit trail field for change tracking.',
    `notes` STRING COMMENT 'Free-text field for operational notes, data quality comments, or explanations of anomalies in energy consumption patterns.',
    `operational_status` STRING COMMENT 'Operating state of the process unit during the measurement period. Affects energy consumption patterns and benchmarking validity.. Valid values are `normal_operation|startup|shutdown|turnaround|reduced_rate|emergency`',
    `reporting_period` STRING COMMENT 'Time aggregation period for the energy consumption record (hourly, shift, daily, weekly, monthly, quarterly, annual). [ENUM-REF-CANDIDATE: hourly|shift|daily|weekly|monthly|quarterly|annual — 7 candidates stripped; promote to reference product]',
    `steam_consumption_klb_per_hr` DECIMAL(18,2) COMMENT 'Mass flow rate of steam consumed by the process unit measured in thousand pounds per hour (klb/hr). Includes low-pressure, medium-pressure, and high-pressure steam.',
    `steam_pressure_level` STRING COMMENT 'Classification of steam pressure level consumed (low pressure: <50 psig, medium pressure: 50-250 psig, high pressure: >250 psig, mixed: combination of levels).. Valid values are `low_pressure|medium_pressure|high_pressure|mixed`',
    `total_energy_consumption_mmbtu` DECIMAL(18,2) COMMENT 'Total energy consumed across all energy types (fuel gas, steam, electricity, hydrogen) converted to a common unit of million British Thermal Units (MMBtu).',
    CONSTRAINT pk_energy_consumption PRIMARY KEY(`energy_consumption_id`)
) COMMENT 'Periodic record and SSOT for refinery energy and utility consumption, including fuel gas (MMSCFD), steam (klb/hr), electricity (MWh), cooling water usage, energy intensity (MMBtu/bbl throughput), energy efficiency index, and hydrogen network balance covering hydrogen production (reformer, SMR), consumption by unit (HDS, hydrocracker, isomerization), import/export volumes, hydrogen purity by source, network pressure, and hydrogen surplus/deficit. Supports refinery energy management, hydrogen optimization, EPA Subpart Y GHG reporting, and Solomon Energy Intensity Index benchmarking.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` (
    `hydrogen_balance_id` BIGINT COMMENT 'Unique identifier for the hydrogen balance record.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Hydrogen balance is refinery-wide material balance tracked at facility level for mass balance closure and regulatory reporting. Real business process: daily hydrogen network balancing across all proce',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to hse.emission_source. Business justification: Hydrogen production units (SMR, reformer) are major emission sources. GHG inventory and Title V permit compliance require hydrogen system identification as emission sources for NOx, CO2, and VOC quant',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Hydrogen consumption varies significantly by product slate (diesel requires more HDS than gasoline). Essential for hydrogen network optimization, hydrogen plant capacity planning, and product-specific',
    `refinery_id` BIGINT COMMENT 'Identifier of the refinery for which this hydrogen balance is recorded.',
    `approved_by` STRING COMMENT 'Name or identifier of the refinery operations manager or engineer who approved this hydrogen balance record.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this hydrogen balance record was approved.',
    `balance_date` DATE COMMENT 'The calendar date for which this hydrogen balance is reported, typically the end date of the balance period.',
    `balance_period_end` TIMESTAMP COMMENT 'End timestamp of the hydrogen balance reporting period.',
    `balance_period_start` TIMESTAMP COMMENT 'Start timestamp of the hydrogen balance reporting period.',
    `balance_reconciliation_notes` STRING COMMENT 'Free-text notes explaining any significant variances, adjustments, or reconciliation actions taken for this hydrogen balance period.',
    `balance_status` STRING COMMENT 'Current status of the hydrogen balance record in its lifecycle.. Valid values are `draft|preliminary|final|revised|cancelled`',
    `balance_variance_percent` DECIMAL(18,2) COMMENT 'Percentage variance between expected and actual hydrogen balance, used to assess measurement accuracy and identify losses or gains in the hydrogen network.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hydrogen balance record was first created in the system.',
    `dcs_system_source` STRING COMMENT 'Identifier of the Distributed Control System (DCS) or SCADA system from which the hydrogen balance data was extracted.',
    `hydrogen_consumption_hds_volume` DECIMAL(18,2) COMMENT 'Volume of hydrogen consumed by hydrodesulfurization (HDS) units during the balance period, measured in standard cubic feet (SCF) or cubic meters.',
    `hydrogen_consumption_hydrocracker_volume` DECIMAL(18,2) COMMENT 'Volume of hydrogen consumed by hydrocracker units during the balance period, measured in standard cubic feet (SCF) or cubic meters.',
    `hydrogen_consumption_isomerization_volume` DECIMAL(18,2) COMMENT 'Volume of hydrogen consumed by isomerization units during the balance period, measured in standard cubic feet (SCF) or cubic meters.',
    `hydrogen_consumption_other_volume` DECIMAL(18,2) COMMENT 'Volume of hydrogen consumed by other process units (e.g., hydrotreating, dewaxing) during the balance period, measured in standard cubic feet (SCF) or cubic meters.',
    `hydrogen_consumption_total_volume` DECIMAL(18,2) COMMENT 'Total volume of hydrogen consumed by all process units during the balance period, measured in standard cubic feet (SCF) or cubic meters.',
    `hydrogen_export_volume` DECIMAL(18,2) COMMENT 'Volume of hydrogen exported to external customers or other facilities during the balance period, measured in standard cubic feet (SCF) or cubic meters.',
    `hydrogen_import_volume` DECIMAL(18,2) COMMENT 'Volume of hydrogen imported from external sources or other facilities during the balance period, measured in standard cubic feet (SCF) or cubic meters.',
    `hydrogen_production_other_volume` DECIMAL(18,2) COMMENT 'Volume of hydrogen produced by other sources (e.g., partial oxidation, electrolysis) during the balance period, measured in standard cubic feet (SCF) or cubic meters.',
    `hydrogen_production_reformer_volume` DECIMAL(18,2) COMMENT 'Volume of hydrogen produced by the catalytic reformer unit during the balance period, measured in standard cubic feet (SCF) or cubic meters.',
    `hydrogen_production_smr_volume` DECIMAL(18,2) COMMENT 'Volume of hydrogen produced by the steam methane reformer (SMR) unit during the balance period, measured in standard cubic feet (SCF) or cubic meters.',
    `hydrogen_production_total_volume` DECIMAL(18,2) COMMENT 'Total volume of hydrogen produced from all sources during the balance period, measured in standard cubic feet (SCF) or cubic meters.',
    `hydrogen_purity_import_percent` DECIMAL(18,2) COMMENT 'Purity percentage of imported hydrogen, typically expressed as mole percent or volume percent.',
    `hydrogen_purity_reformer_percent` DECIMAL(18,2) COMMENT 'Purity percentage of hydrogen produced by the catalytic reformer unit, typically expressed as mole percent or volume percent.',
    `hydrogen_purity_smr_percent` DECIMAL(18,2) COMMENT 'Purity percentage of hydrogen produced by the steam methane reformer (SMR) unit, typically expressed as mole percent or volume percent.',
    `hydrogen_surplus_deficit_volume` DECIMAL(18,2) COMMENT 'Net hydrogen surplus (positive) or deficit (negative) for the balance period, calculated as total production plus imports minus total consumption minus exports, measured in standard cubic feet (SCF) or cubic meters.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this hydrogen balance record was last modified.',
    `network_pressure_average_psi` DECIMAL(18,2) COMMENT 'Average pressure of the hydrogen network during the balance period, measured in pounds per square inch (PSI) or bar.',
    `network_pressure_max_psi` DECIMAL(18,2) COMMENT 'Maximum pressure of the hydrogen network during the balance period, measured in pounds per square inch (PSI) or bar.',
    `network_pressure_min_psi` DECIMAL(18,2) COMMENT 'Minimum pressure of the hydrogen network during the balance period, measured in pounds per square inch (PSI) or bar.',
    `pressure_unit_of_measure` STRING COMMENT 'Unit of measure for all hydrogen pressure quantities in this balance record (e.g., PSI for pounds per square inch, bar, kPa for kilopascals, MPa for megapascals).. Valid values are `PSI|bar|kPa|MPa`',
    `process_simulation_model` STRING COMMENT 'Name or identifier of the process simulation model (e.g., Aspen HYSYS model) used to validate or optimize the hydrogen balance.',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure for all hydrogen volume quantities in this balance record (e.g., SCF for standard cubic feet, MSCF for thousand standard cubic feet, MMSCF for million standard cubic feet, m3 for cubic meters, Nm3 for normal cubic meters).. Valid values are `SCF|MSCF|MMSCF|m3|Nm3`',
    CONSTRAINT pk_hydrogen_balance PRIMARY KEY(`hydrogen_balance_id`)
) COMMENT 'Periodic hydrogen balance record for the refinery hydrogen network, capturing hydrogen production (reformer, SMR), hydrogen consumption by unit (HDS, hydrocracker, isomerization), hydrogen import/export volumes, hydrogen purity by source, network pressure, and hydrogen surplus or deficit. Critical for HDS and hydrocracker operations and refinery hydrogen optimization.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`process_alarm` (
    `process_alarm_id` BIGINT COMMENT 'Unique identifier for the process alarm record. Primary key for the process alarm entity.',
    `equipment_id` BIGINT COMMENT 'Reference to the specific equipment or asset that generated the alarm. Links to equipment master data.',
    `moc_request_id` BIGINT COMMENT 'Foreign key linking to asset.moc_request. Business justification: Recurring nuisance alarms or safety-critical alarm patterns trigger Management of Change requests to modify setpoints or equipment. Real business process: alarm rationalization programs identify alarm',
    `process_unit_id` BIGINT COMMENT 'FK to refining.process_unit',
    `refinery_id` BIGINT COMMENT 'Reference to the refinery facility where the alarm originated. Links to the refinery master data.',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.violation. Business justification: Safety-critical alarm failures (H2S detection, pressure relief, ESD systems) can result in OSHA PSM violations and EPA RMP non-compliance citations. Alarm rationalization and management-of-change docu',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order created in response to this alarm, if applicable. Links alarm to corrective maintenance activities in CMMS (e.g., Maximo).',
    `acknowledged_by_operator` STRING COMMENT 'Username or operator ID of the person who acknowledged the alarm. Used for accountability and training purposes. Links to workforce/operator records.',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Date and time when the alarm was acknowledged by an operator. Null if alarm has not been acknowledged. Used to calculate operator response time.',
    `actual_value` DECIMAL(18,2) COMMENT 'The actual measured value of the process variable at the time the alarm was triggered. Used to calculate deviation from setpoint.',
    `alarm_duration_seconds` STRING COMMENT 'Total duration the alarm remained in active state, measured in seconds from alarm timestamp to cleared timestamp. Used for alarm performance analysis and ISA-18.2 KPI reporting.',
    `alarm_group` STRING COMMENT 'Logical grouping or category for the alarm used for filtering and reporting (e.g., temperature-alarms, pressure-alarms, safety-alarms). Supports alarm management and operator display organization.',
    `alarm_message` STRING COMMENT 'Human-readable alarm message displayed to operators describing the abnormal condition. Provides context and guidance for operator response per ISA-18.2 best practices.',
    `alarm_priority` STRING COMMENT 'Priority classification of the alarm indicating the urgency and required response time. Critical alarms require immediate action, high within minutes, medium within hours, low for information only.. Valid values are `critical|high|medium|low`',
    `alarm_state` STRING COMMENT 'Current state of the alarm in its lifecycle. Active indicates alarm condition exists, acknowledged means operator has seen it, cleared means condition resolved, suppressed/shelved means temporarily disabled, out-of-service means permanently disabled.. Valid values are `active|acknowledged|cleared|suppressed|shelved|out-of-service`',
    `alarm_tag` STRING COMMENT 'Unique tag identifier for the alarm point in the DCS or SCADA system. Follows plant instrumentation naming convention (e.g., FIC-101.HI, TI-205.LO).',
    `alarm_timestamp` TIMESTAMP COMMENT 'Date and time when the alarm condition first occurred and was triggered in the DCS/SCADA system. Represents the actual process event time.',
    `alarm_type` STRING COMMENT 'Classification of the alarm based on the type of abnormal condition detected. Includes limit alarms (high/low), critical alarms (high-high/low-low), deviation from setpoint, rate-of-change, and system alarms. [ENUM-REF-CANDIDATE: high|low|high-high|low-low|deviation|rate-of-change|bad-quality|communication-failure — 8 candidates stripped; promote to reference product]',
    `cleared_timestamp` TIMESTAMP COMMENT 'Date and time when the alarm condition was resolved and the alarm returned to normal state. Null if alarm is still active. Used to calculate alarm duration.',
    `corrective_action_taken` STRING COMMENT 'Free-text description of the corrective action taken by the operator or maintenance team to resolve the alarm condition. Documents response for compliance and knowledge management.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this alarm record was first created in the data system. Used for data lineage and audit trail purposes.',
    `dcs_system_name` STRING COMMENT 'Name or identifier of the DCS or SCADA system that generated the alarm. Used to track alarm source and integrate with multiple control systems.',
    `deviation_value` DECIMAL(18,2) COMMENT 'Calculated difference between actual value and setpoint value. Positive or negative depending on alarm type. Indicates severity of the abnormal condition.',
    `is_environmental_alarm` BOOLEAN COMMENT 'Boolean flag indicating whether this alarm is related to environmental compliance (emissions, effluent, spills). True if environmental, False if operational. Environmental alarms require EPA reporting per 40 CFR.',
    `is_nuisance_alarm` BOOLEAN COMMENT 'Boolean flag indicating whether this alarm has been classified as a nuisance or chattering alarm. True if nuisance, False if legitimate. Used for alarm rationalization and reduction programs per ISA-18.2.',
    `is_safety_critical` BOOLEAN COMMENT 'Boolean flag indicating whether this alarm is classified as safety-critical per process safety management (PSM) requirements. True if safety-critical, False if operational. Safety-critical alarms require special handling per OSHA 29 CFR 1910.119.',
    `is_shelved` BOOLEAN COMMENT 'Boolean flag indicating whether the alarm has been temporarily shelved (suppressed) by an operator. True if shelved, False if active. Shelving requires management of change approval per ISA-18.2.',
    `last_rationalized_date` DATE COMMENT 'Date when this alarm was last reviewed and rationalized as part of the alarm management program. Used to ensure periodic review per ISA-18.2 requirements (typically annual or biennial).',
    `operator_notes` STRING COMMENT 'Free-text notes entered by operators regarding the alarm, actions taken, or observations. Supports shift handover, troubleshooting, and knowledge capture.',
    `pi_point_name` STRING COMMENT 'OSIsoft PI System point name or tag associated with this alarm. Used for integration with PI historian and time-series data retrieval for trend analysis.',
    `process_variable` STRING COMMENT 'Name of the process variable being monitored (e.g., temperature, pressure, flow, level, composition). Describes what physical parameter triggered the alarm.',
    `rationalization_status` STRING COMMENT 'Status of this alarm in the alarm rationalization program. Indicates whether the alarm has been reviewed, approved, or flagged for modification/removal per ISA-18.2 alarm management lifecycle.. Valid values are `approved|under-review|pending-modification|pending-removal|archived`',
    `response_time_seconds` STRING COMMENT 'Time elapsed between alarm occurrence and operator acknowledgment, measured in seconds. Key performance indicator for alarm management and operator effectiveness per ISA-18.2.',
    `root_cause_category` STRING COMMENT 'High-level classification of the root cause of the alarm condition. Used for trend analysis, reliability improvement, and process safety management per OSHA 29 CFR 1910.119. [ENUM-REF-CANDIDATE: equipment-failure|process-upset|operator-error|instrument-malfunction|design-issue|maintenance-activity|external-event|unknown — 8 candidates stripped; promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed free-text description of the identified root cause of the alarm. Populated during alarm investigation and analysis. Supports continuous improvement and lessons learned.',
    `setpoint_value` DECIMAL(18,2) COMMENT 'The configured threshold value that triggers the alarm condition. Represents the limit or target value for the process variable.',
    `shelved_by_operator` STRING COMMENT 'Username or operator ID of the person who shelved the alarm. Null if alarm is not shelved. Required for audit trail and compliance with alarm rationalization programs.',
    `shelved_timestamp` TIMESTAMP COMMENT 'Date and time when the alarm was shelved. Null if alarm is not shelved. Used to track duration of shelving and ensure time-limited suppression per ISA-18.2.',
    `shelving_reason` STRING COMMENT 'Free-text explanation for why the alarm was shelved. Required documentation for alarm suppression per ISA-18.2 and PSM requirements. Supports audit and rationalization reviews.',
    `unit_of_measure` STRING COMMENT 'Engineering unit of measure for the process variable and setpoint (e.g., degF, degC, PSI, barg, GPM, BPD, percent). Ensures proper interpretation of values.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this alarm record was last modified in the data system. Used for data lineage, audit trail, and change tracking purposes.',
    CONSTRAINT pk_process_alarm PRIMARY KEY(`process_alarm_id`)
) COMMENT 'Record of process alarms and abnormal operating conditions from DCS/SCADA systems for refinery process units. Captures alarm tag, type (high/low/deviation/rate-of-change), process variable, setpoint, actual value, priority (critical/high/medium/low), acknowledgment status, shelving status, duration, operator response, and root cause classification. Supports ISA-18.2 alarm management, process safety management (PSM) per OSHA 29 CFR 1910.119, and alarm rationalization programs.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`crude_receipt` (
    `crude_receipt_id` BIGINT COMMENT 'Unique identifier for the crude oil receipt transaction. Primary key for the crude receipt record.',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Crude receipts via pipeline must reference the pipeline asset for custody transfer reconciliation and tariff billing. Real business process: crude oil delivered via pipeline requires tracking which se',
    `blend_recipe_id` BIGINT COMMENT 'Identifier of the feedstock blend recipe into which this crude receipt will be incorporated for refinery processing optimization.',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Crude receipts often fulfill term contract purchase obligations. Essential for contract compliance tracking, volume reconciliation, and take-or-pay verification in crude procurement operations.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Crude oil imports require customs declarations (CBP Form 7501), Jones Act compliance certifications for domestic waterborne shipments, and EIA crude oil import reports. Each receipt must be traceable ',
    `contract_id` BIGINT COMMENT 'Identifier of the term contract or spot purchase agreement under which this crude oil was procured.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Crude purchases are charged to cost centers for feedstock cost accounting and margin calculation. Enables tracking of crude acquisition costs by organizational unit and supports crude slate optimizati',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Crude receipts are of specific crude grades for quality verification, supplier performance tracking, and crude accounting. Essential for custody transfer validation, quality claim resolution, and crud',
    `custody_transfer_id` BIGINT COMMENT 'Foreign key linking to logistics.custody_transfer. Business justification: Crude receipts involve custody transfer events at measurement points. Fiscal measurement, quality reconciliation, and commercial settlement require linking receipts to custody transfer records for vol',
    `employee_id` BIGINT COMMENT 'Employee identifier of the refinery inspector who verified and accepted the crude oil receipt.',
    `product_quality_test_id` BIGINT COMMENT 'Reference to the laboratory quality test record performed on the crude oil sample at receipt.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Refineries processing crude under production sharing agreements must track cost recovery eligibility, profit oil calculations, and ring-fencing rules. PSA cost recovery ceilings and domestic market ob',
    `rail_waybill_id` BIGINT COMMENT 'Foreign key linking to logistics.rail_waybill. Business justification: Crude receipts by rail car are documented via waybills. Rail operations tracking, car demurrage, and freight invoice reconciliation require linking receipts to waybills for custody transfer validation',
    `refinery_id` BIGINT COMMENT 'Identifier of the refinery facility receiving the crude oil shipment.',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Refineries track crude source reservoir for supply chain traceability, quality variance analysis (API/sulfur/TAN reconciliation against reservoir fluid properties), reserves booking validation, and fe',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Integrated oil & gas operators tracking crude receipts from their own upstream production need to link receipts to source leases for: (1) crude quality variance analysis by lease, (2) royalty-in-kind ',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Refineries track source production facilities for custody transfer reconciliation, quality certification, and supply chain logistics. Essential for receipt variance resolution and integrated supply pl',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: Refineries track source wells for crude quality traceability, assay validation, and blending optimization. Critical for integrated operators managing upstream-downstream quality specifications and reg',
    `spill_event_id` BIGINT COMMENT 'Foreign key linking to hse.spill_event. Business justification: Crude unloading from vessels/pipelines is high-risk for spills. Spill investigations trace root cause to receipt operations (overfill, hose failure, valve error). Environmental incident reports requir',
    `spot_trade_id` BIGINT COMMENT 'Foreign key linking to commercial.spot_trade. Business justification: Spot crude purchases generate physical receipts at refineries. Critical for trade settlement, invoice reconciliation, and matching physical delivery against trading book positions.',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Crude receipts require formal counterparty tracking for custody transfer documentation, pricing settlement, credit management, and sanctions screening. Supplier_name is denormalized; FK enables KYC ve',
    `tank_inventory_id` BIGINT COMMENT 'Identifier of the crude oil storage tank to which this receipt was allocated upon arrival at the refinery.',
    `tertiary_crude_updated_by_user_employee_id` BIGINT COMMENT 'User identifier of the person or system account that last modified this crude receipt record.',
    `truck_ticket_id` BIGINT COMMENT 'Foreign key linking to logistics.truck_ticket. Business justification: Crude receipts by truck are documented via truck tickets. Ticket reconciliation, driver verification, and volume variance analysis require linking receipts to truck tickets for custody transfer valida',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the crude oil supplier in the enterprise vendor master system.',
    `vessel_id` BIGINT COMMENT 'Foreign key linking to logistics.vessel. Business justification: Crude receipts by vessel require vessel master data for demurrage calculations, laytime tracking, quality claims, and vetting compliance. Linking receipts to vessel records enables voyage cost reconci',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity of the crude oil measured at receipt, indicating the density and quality of the crude. Higher API gravity indicates lighter, more valuable crude.',
    `bsw_percent` DECIMAL(18,2) COMMENT 'Percentage of basic sediment and water content in the crude oil. Used to calculate net volume and assess crude quality.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this crude receipt record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `gross_volume_bbl` DECIMAL(18,2) COMMENT 'Total volume of crude oil received in barrels before adjustments for temperature, pressure, and impurities. Measured at observed conditions.',
    `inspection_notes` STRING COMMENT 'Free-text notes recorded by the receiving inspector regarding the condition, quality observations, or any issues noted during the crude oil receipt inspection.',
    `loss_in_transit_bbl` DECIMAL(18,2) COMMENT 'Volume difference between the crude oil shipped from origin and the volume received at the refinery, measured in barrels. Used for reconciliation and loss accounting.',
    `net_volume_bbl` DECIMAL(18,2) COMMENT 'Net standard volume of crude oil received in barrels after correction to standard conditions (60°F, 14.696 psia) and deduction of basic sediment and water (BS&W).',
    `origin_type` STRING COMMENT 'Type of source location from which the crude oil was received.. Valid values are `field|terminal|pipeline|vessel|rail|truck`',
    `price_basis` STRING COMMENT 'Benchmark crude oil price index used as the basis for pricing this receipt (e.g., WTI, Brent, Dubai). Determines the reference price for differential calculations. [ENUM-REF-CANDIDATE: WTI|Brent|Dubai|OPEC|LLS|Mars|WCS|Urals — 8 candidates stripped; promote to reference product]',
    `price_differential_usd_per_bbl` DECIMAL(18,2) COMMENT 'Price differential (premium or discount) applied to the benchmark price basis for this crude grade and delivery location, expressed in USD per barrel.',
    `purchase_order_number` STRING COMMENT 'Purchase order number from the ERP system authorizing the procurement of this crude oil shipment.',
    `quality_compliance_status` STRING COMMENT 'Status indicating whether the received crude oil meets the quality specifications and acceptance criteria defined in the purchase contract and refinery feedstock standards.. Valid values are `compliant|non_compliant|pending_review|conditional_acceptance`',
    `receipt_date` DATE COMMENT 'Date when the crude oil was physically received at the refinery. This is the business event date for inventory and accounting purposes.',
    `receipt_number` STRING COMMENT 'Business identifier for the crude receipt transaction, typically generated by the custody transfer system or ERP.. Valid values are `^RCP-[0-9]{8}-[A-Z0-9]{6}$`',
    `receipt_status` STRING COMMENT 'Current lifecycle status of the crude receipt transaction in the inventory and accounting workflow.. Valid values are `draft|confirmed|reconciled|disputed|closed`',
    `receipt_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the crude oil receipt was recorded in the custody transfer system, including time zone information.',
    `sulfur_content_percent` DECIMAL(18,2) COMMENT 'Sulfur content of the crude oil measured as weight percentage. Critical for determining processing requirements and environmental compliance (sweet vs. sour crude classification).',
    `tan_mg_koh_per_g` DECIMAL(18,2) COMMENT 'Total Acid Number measured in milligrams of potassium hydroxide per gram of crude oil. Indicates the acidity and corrosiveness of the crude, affecting refinery equipment selection and processing costs.',
    `target_process_unit` STRING COMMENT 'Refinery process unit for which this crude receipt is designated (e.g., Crude Distillation Unit, Vacuum Distillation Unit, Fluid Catalytic Cracking).. Valid values are `CDU|VDU|FCC|HDS|Coker|Hydrocracker`',
    `temperature_f` DECIMAL(18,2) COMMENT 'Temperature of the crude oil at the time of receipt measurement in degrees Fahrenheit. Used for volume correction calculations.',
    `total_cost_usd` DECIMAL(18,2) COMMENT 'Total acquisition cost for this crude oil receipt in US dollars, including base price, differentials, transportation, and other charges.',
    `transportation_mode` STRING COMMENT 'Primary mode of transportation used to deliver the crude oil to the refinery.. Valid values are `pipeline|vessel|rail|truck|barge`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this crude receipt record was last modified in the system.',
    CONSTRAINT pk_crude_receipt PRIMARY KEY(`crude_receipt_id`)
) COMMENT 'Transactional record and SSOT for crude oil receipts and feedstock blend composition at a refinery. Captures receipt date, crude grade, origin (field, terminal, vessel name), volume received (barrels, gross and net), API gravity and sulfur measured at receipt, BS&W, custody transfer meter ticket reference, supplier, price basis (WTI/Brent/Dubai differential), tank allocation, and feedstock blend details including component crude grades, volume fractions, blend quality (API, sulfur, TAN), target CDU/process unit, and quality compliance status. Supports crude inventory management, feedstock cost accounting, crude scheduling, feedstock optimization, and loss-in-transit reconciliation.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`product_movement` (
    `product_movement_id` BIGINT COMMENT 'Primary key for product_movement',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Product movements via pipeline must reference the pipeline asset for custody transfer and PHMSA reporting. Real business process: pipeline operators track which segment was used for each movement for ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Product movements (custody transfers, pipeline shipments, truck loadings) require authorization by operations supervisors for inventory control, loss prevention, and regulatory compliance (EPA, DOT). ',
    `blend_event_id` BIGINT COMMENT 'Foreign key linking to refining.blend_event. Business justification: Product movements track transfers of blended products. product_movement.batch_number (STRING) should be normalized to blend_event_id FK to establish traceability from custody transfer back to the blen',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Product movements fulfill term contract delivery obligations. Required for contract performance tracking, volume commitment verification, and deficiency payment calculations in long-term supply agreem',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Product transfers and sales must be allocated to cost centers for revenue recognition and transfer pricing. Supports internal margin calculation, inventory valuation, and intercompany reconciliation.',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Product movements to/from external parties (sales, exchanges, swaps) require counterparty identification for commercial settlement, custody transfer validation, sanctions compliance, and revenue recog',
    `terminal_id` BIGINT COMMENT 'Foreign key linking to logistics.terminal. Business justification: Product movements originate from refinery terminals. Loading rack operations, terminal inventory management, and logistics dispatch planning require linking movements to origin terminals for operation',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Product movements transfer specific petroleum products between tanks, terminals, or customers. Essential for custody transfer documentation, logistics tracking, inventory reconciliation, and revenue r',
    `pipeline_batch_id` BIGINT COMMENT 'Foreign key linking to logistics.pipeline_batch. Business justification: Product movements via pipeline are tracked as batches. Injection/delivery reconciliation, line loss accounting, and custody transfer validation require linking movements to pipeline batches for volume',
    `refinery_id` BIGINT COMMENT 'Reference to the refinery facility where the product movement originated or terminated.',
    `refinery_schedule_id` BIGINT COMMENT 'Foreign key linking to refining.refinery_schedule. Business justification: Product movements are scheduled as part of a refinery schedule; linking them enables alignment of physical movements with planned production.',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Product movements fulfill sales orders—core order-to-cash process. Essential for delivery confirmation, revenue recognition, customer billing, and logistics coordination in refined product sales.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Product movements out of refineries are logistics shipments. Loading operations, custody transfer, freight invoicing, and delivery confirmation require linking refinery dispatch records to logistics s',
    `spill_event_id` BIGINT COMMENT 'Foreign key linking to hse.spill_event. Business justification: Product transfers (loading, pipeline movements) are common spill scenarios. Environmental compliance requires movement-to-spill linkage for volume reconciliation, custody transfer disputes, and regula',
    `truck_ticket_id` BIGINT COMMENT 'Foreign key linking to logistics.truck_ticket. Business justification: Product movements by truck generate truck tickets at loading racks. Loading operations, seal verification, and driver signoff require linking movements to truck tickets for operational tracking and cu',
    `accounting_period` STRING COMMENT 'The financial accounting period to which this product movement is allocated for inventory and revenue recognition.',
    `actual_end_datetime` TIMESTAMP COMMENT 'The actual date and time when the physical product movement operation was completed.',
    `actual_start_datetime` TIMESTAMP COMMENT 'The actual date and time when the physical product movement operation began.',
    `api_gravity` DECIMAL(18,2) COMMENT 'The American Petroleum Institute gravity measurement of the product, indicating its density relative to water.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this product movement transaction was formally approved.',
    `comments` STRING COMMENT 'Free-text field for additional notes, special instructions, or operational remarks related to the product movement.',
    `contract_number` STRING COMMENT 'Reference to the commercial contract or agreement governing this product movement transaction.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this product movement record was first created in the system.',
    `custody_transfer_status` STRING COMMENT 'Status indicating whether custody transfer has been acknowledged and accepted by the receiving party for accounting purposes.. Valid values are `pending|accepted|disputed|reconciled`',
    `destination_location_code` STRING COMMENT 'Code identifying the destination location of the product movement, such as storage tank, pipeline, truck rack, or marine terminal.',
    `destination_location_description` STRING COMMENT 'Human-readable description of the destination location for the product movement.',
    `gross_volume` DECIMAL(18,2) COMMENT 'The total observed volume at actual conditions before temperature and pressure corrections are applied.',
    `inspection_company` STRING COMMENT 'Name of the independent inspection or surveying company that provided third-party verification of the movement.',
    `inspector_name` STRING COMMENT 'Name of the inspector or surveyor who witnessed and verified the product movement and measurements.',
    `loading_rate_bph` DECIMAL(18,2) COMMENT 'The average flow rate during the loading or unloading operation, measured in barrels per hour.',
    `meter_ticket_number` STRING COMMENT 'Reference number of the meter ticket or measurement document that records the physical measurement at the custody transfer point.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this product movement record was last updated or modified.',
    `movement_datetime` TIMESTAMP COMMENT 'The date and time when the physical product movement occurred or was recorded at the custody transfer point.',
    `movement_number` STRING COMMENT 'Externally-known unique business identifier for this product movement transaction, used for tracking and reconciliation across systems.',
    `movement_status` STRING COMMENT 'Current lifecycle status of the product movement transaction in the custody transfer and accounting workflow.. Valid values are `pending|in_progress|completed|cancelled|reconciled`',
    `movement_type` STRING COMMENT 'Classification of the movement transaction indicating the direction and nature of the product flow.. Valid values are `receipt|dispatch|transfer|injection|withdrawal`',
    `net_volume` DECIMAL(18,2) COMMENT 'The corrected volume at standard conditions after applying temperature, pressure, and sediment/water corrections for custody transfer.',
    `quality_certificate_number` STRING COMMENT 'Reference number of the quality certificate or certificate of analysis documenting the product specifications at the time of movement.',
    `scheduled_datetime` TIMESTAMP COMMENT 'The planned or scheduled date and time for the product movement, used for logistics coordination and planning.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'The measured temperature of the product at the time of movement, used for volume correction calculations.',
    `transfer_mode` STRING COMMENT 'The physical transportation method or infrastructure used to execute the product movement.. Valid values are `pipeline|truck|rail|marine|barge|inter_tank`',
    `variance_barrels` DECIMAL(18,2) COMMENT 'The difference between expected and actual volume, used for inventory reconciliation and loss accounting.',
    `variance_reason` STRING COMMENT 'Explanation or classification of the cause of any volume variance identified during the movement transaction.',
    `volume_barrels` DECIMAL(18,2) COMMENT 'The quantity of refined product moved, measured in barrels at standard conditions for custody transfer accounting.',
    `volume_metric_tons` DECIMAL(18,2) COMMENT 'The mass quantity of refined product moved, measured in metric tons for international trade and marine terminal operations.',
    CONSTRAINT pk_product_movement PRIMARY KEY(`product_movement_id`)
) COMMENT 'Transactional record of refined product movements into or out of refinery storage, including pipeline injections, truck rack loadings, marine terminal transfers, and inter-refinery transfers. Captures movement date/time, product grade, volume (barrels or MT), origin and destination, movement type (receipt, dispatch, transfer), meter ticket reference, quality certificate reference, and custody transfer status. Supports product inventory accounting and logistics coordination.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`product_specification` (
    `product_specification_id` BIGINT COMMENT 'Unique identifier for the product specification record. Primary key for the product specification master reference.',
    `superseded_by_specification_product_specification_id` BIGINT COMMENT 'Reference to the specification that supersedes this one. Nullable for active specifications. Used to maintain specification lineage and version history.',
    `api_gravity_max` DECIMAL(18,2) COMMENT 'Maximum API gravity. Upper limit ensures product meets grade specifications and handling characteristics.',
    `api_gravity_min` DECIMAL(18,2) COMMENT 'Minimum API gravity. Inverse measure of petroleum liquid density relative to water. Higher API gravity indicates lighter products. Typical range is 45-70 for gasoline, 30-42 for diesel.',
    `applicable_standard` STRING COMMENT 'Primary industry or regulatory standard governing this specification. Examples include ASTM D4814 for gasoline, ASTM D975 for diesel, EN 228 for European gasoline, ISO 8217 for marine fuels, API gravity standards.',
    `approval_date` DATE COMMENT 'Date when this specification was formally approved for operational use. Part of quality management audit trail.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this specification for use. Part of quality management audit trail.',
    `aromatics_max_vol_pct` DECIMAL(18,2) COMMENT 'Maximum aromatic hydrocarbon content by volume percent. Regulated to control emissions and combustion characteristics. EPA and CARB set limits (typically 25-35% for gasoline).',
    `benzene_max_vol_pct` DECIMAL(18,2) COMMENT 'Maximum benzene content by volume percent. Strictly regulated carcinogen. EPA Mobile Source Air Toxics limit is 0.62% average, CARB limit is 0.7% maximum.',
    `cetane_index_min` DECIMAL(18,2) COMMENT 'Minimum cetane index for diesel fuel. Indicates ignition quality and combustion performance. Typical minimum is 40 for automotive diesel, 47 for premium grades.',
    `cetane_number_min` DECIMAL(18,2) COMMENT 'Minimum cetane number measured by engine test. Direct measure of diesel ignition quality. More accurate than cetane index but more expensive to determine.',
    `cloud_point_max_c` DECIMAL(18,2) COMMENT 'Maximum cloud point temperature in degrees Celsius. Defines low-temperature operability for diesel fuels. Varies by season and geographic market (e.g., -10°C for winter diesel).',
    `comments` STRING COMMENT 'Free-text comments or notes about this specification. May include special handling instructions, seasonal applicability notes, or references to supporting documentation.',
    `copper_strip_corrosion_max` STRING COMMENT 'Maximum allowable copper strip corrosion rating. Indicates presence of corrosive sulfur compounds. Typical maximum is 1 for gasoline and diesel, 1 for jet fuel.. Valid values are `1a|1b|2a|2b|3a|3b`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this specification record was first created in the system. Part of data lineage and audit trail.',
    `density_max_kg_m3` DECIMAL(18,2) COMMENT 'Maximum density in kilograms per cubic meter at 15°C. Upper limit ensures product meets grade specifications and combustion characteristics.',
    `density_min_kg_m3` DECIMAL(18,2) COMMENT 'Minimum density in kilograms per cubic meter at 15°C. Used for mass-volume conversions and quality control. Typical range is 720-775 kg/m³ for gasoline, 820-845 kg/m³ for diesel.',
    `distillation_fbp_max_c` DECIMAL(18,2) COMMENT 'Maximum final boiling point temperature during distillation. Ensures complete vaporization and limits heavy-end components that contribute to deposits and emissions.',
    `distillation_t10_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature at which 10% of the sample is recovered during distillation. Controls front-end volatility for gasoline and diesel. Affects cold start performance.',
    `distillation_t50_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature at which 50% of the sample is recovered during distillation. Indicates mid-range volatility and affects warm-up performance and vapor lock tendency.',
    `distillation_t90_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature at which 90% of the sample is recovered during distillation. Controls back-end volatility. Affects combustion completeness and deposit formation.',
    `effective_date` DATE COMMENT 'Date when this specification becomes binding for quality testing and product release. Used to manage specification version transitions and regulatory compliance cutover dates.',
    `ethanol_max_vol_pct` DECIMAL(18,2) COMMENT 'Maximum ethanol content by volume percent. Common blends are E10 (10% ethanol) and E15 (15% ethanol). Affects vapor pressure, phase separation, and materials compatibility.',
    `expiration_date` DATE COMMENT 'Date when this specification is no longer valid for quality testing and product release. Nullable for specifications without a defined end date. Used to manage specification supersession and regulatory phase-outs.',
    `flash_point_min_c` DECIMAL(18,2) COMMENT 'Minimum flash point temperature in degrees Celsius. Safety-critical specification for distillate fuels. Typical minimum is 38°C for diesel and 40°C for jet fuel.',
    `freeze_point_max_c` DECIMAL(18,2) COMMENT 'Maximum freeze point temperature in degrees Celsius. Critical specification for jet fuel to prevent fuel system icing at altitude. Typical maximum is -40°C for Jet A and -47°C for Jet A-1.',
    `geographic_market` STRING COMMENT 'Geographic region or market where this specification applies. Examples include US Gulf Coast, California CARB, European Union, Singapore, specific state markets. Supports regional specification management for products with varying quality requirements by jurisdiction.',
    `lubricity_max_microns` DECIMAL(18,2) COMMENT 'Maximum wear scar diameter in microns measured by High-Frequency Reciprocating Rig (HFRR) test. Critical for ULSD to prevent fuel injection system wear. Typical maximum is 520 microns at 60°C.',
    `mon_min` DECIMAL(18,2) COMMENT 'Minimum Motor Octane Number required for gasoline products. Used in conjunction with RON to determine anti-knock index (AKI). Typical values range from 82 to 92 MON.',
    `olefins_max_vol_pct` DECIMAL(18,2) COMMENT 'Maximum olefin content by volume percent. Affects oxidation stability and deposit formation. CARB limits olefins to 10% for reformulated gasoline.',
    `oxygen_max_wt_pct` DECIMAL(18,2) COMMENT 'Maximum oxygen content by weight percent. Typically from ethanol or MTBE blending. EPA allows up to 3.7% oxygen by weight for conventional gasoline, 2.7% for reformulated gasoline.',
    `particulate_max_mg_l` DECIMAL(18,2) COMMENT 'Maximum particulate contamination in milligrams per liter. Critical for fuel injection system protection. Typical limit is 24 mg/L for diesel.',
    `pour_point_max_c` DECIMAL(18,2) COMMENT 'Maximum pour point temperature in degrees Celsius. Defines the lowest temperature at which the product remains pourable. Critical for fuel oils and lubricants.',
    `product_category` STRING COMMENT 'Classification of the product type. Distinguishes between finished refined products ready for market, intermediate streams within the refinery, blendstocks used in blending operations, and feedstocks entering process units.. Valid values are `finished_product|intermediate_stream|blendstock|feedstock`',
    `product_grade` STRING COMMENT 'Commercial grade designation of the refined product or intermediate stream. Examples include Regular Unleaded 87, Premium 93, ULSD 15ppm, Jet A-1, RBOB, Reformate, FCC Gasoline.',
    `product_type` STRING COMMENT 'Specific type of petroleum product. Defines the primary product family for quality control and market positioning. [ENUM-REF-CANDIDATE: gasoline|diesel|jet_fuel|kerosene|fuel_oil|lpg|naphtha|reformate|fcc_gasoline|alkylate|other — 11 candidates stripped; promote to reference product]',
    `regulatory_basis` STRING COMMENT 'Regulatory framework or mandate driving the specification requirements. Examples include EPA Tier 3 sulfur limits, CARB gasoline specifications, IMO 2020 marine fuel sulfur cap, state-specific winter oxygenate requirements.',
    `ron_min` DECIMAL(18,2) COMMENT 'Minimum Research Octane Number required for gasoline products. Critical quality parameter for gasoline blending and anti-knock performance. Typical values range from 87 to 98 RON.',
    `rvp_max_psi` DECIMAL(18,2) COMMENT 'Maximum Reid Vapor Pressure in pounds per square inch. Controls gasoline volatility and evaporative emissions. EPA and CARB set seasonal and geographic RVP limits (typically 7.0-9.0 psi summer, 13.5-15.0 psi winter).',
    `specification_name` STRING COMMENT 'Human-readable name of the product specification. Describes the product grade and quality standard in business terms.',
    `specification_number` STRING COMMENT 'Business identifier for the product specification. Externally-known unique code used in quality testing, blending operations, and product release documentation.. Valid values are `^[A-Z0-9]{6,20}$`',
    `specification_status` STRING COMMENT 'Current lifecycle status of the product specification. Active specifications are used for quality testing and product release decisions. Superseded specifications are retained for historical reference.. Valid values are `active|inactive|draft|superseded|pending_approval`',
    `sulfur_max_ppm` DECIMAL(18,2) COMMENT 'Maximum allowable sulfur content in parts per million. Critical for EPA Tier 3 compliance (10 ppm gasoline), ULSD requirements (15 ppm diesel), and IMO 2020 marine fuel limits (0.5% or 5000 ppm). Drives HDS unit performance requirements.',
    `tan_max_mg_koh_per_g` DECIMAL(18,2) COMMENT 'Maximum Total Acid Number in milligrams of potassium hydroxide per gram of sample. Measures acidity and corrosivity of crude oil and intermediate streams. High TAN crudes require special metallurgy and processing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this specification record was last modified. Part of data lineage and audit trail.',
    `version_number` STRING COMMENT 'Version number of this specification. Incremented when specification is revised. Supports specification change management and historical tracking.',
    `viscosity_max_cst` DECIMAL(18,2) COMMENT 'Maximum kinematic viscosity in centistokes at specified temperature (typically 40°C). Upper limit ensures proper fuel system operation and combustion efficiency.',
    `viscosity_min_cst` DECIMAL(18,2) COMMENT 'Minimum kinematic viscosity in centistokes at specified temperature (typically 40°C). Defines flow characteristics and atomization performance. Critical for diesel and fuel oils.',
    `water_content_max_ppm` DECIMAL(18,2) COMMENT 'Maximum water content in parts per million. Critical for jet fuel (50 ppm max) and diesel to prevent microbial growth, corrosion, and ice formation.',
    CONSTRAINT pk_product_specification PRIMARY KEY(`product_specification_id`)
) COMMENT 'Master reference record and SSOT for finished refined product and intermediate stream quality specifications. Captures product grade, applicable standard (ASTM, EN, ISO, API), required property limits (RON min, sulfur max ppm, flash point min, cloud point max, viscosity range, density range, RVP max), regulatory basis (EPA Tier 3, CARB, IMO 2020), effective date, and geographic market applicability. Used as the authoritative quality target for product blending, quality testing pass/fail determination, and product release certification.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` (
    `catalyst_lifecycle_id` BIGINT COMMENT 'Unique identifier for the catalyst lifecycle record. Primary key for tracking individual catalyst batches through their operational lifecycle in refinery process units.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Spent catalyst disposal requires RCRA hazardous waste manifests (EPA Form 8700-22), biennial reports, and land disposal restriction notifications. Each catalyst disposal event must be traceable to reg',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Catalyst purchases and replacements are often capitalized via AFEs. Lifecycle tracking requires AFE linkage for cost tracking, capitalization decisions, and depreciation calculation. Standard refining',
    `process_unit_id` BIGINT COMMENT 'Reference to the specific process unit (FCC, HDS, reformer, alkylation, isomerization) where the catalyst is installed and operating.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Catalyst loads are high-value capital purchases requiring PO tracking for cost capitalization, delivery coordination with turnaround schedules, three-way match with goods receipt and invoice, and AFE ',
    `refinery_id` BIGINT COMMENT 'Reference to the refinery facility where the catalyst is deployed. Links to the refinery master data.',
    `turnaround_id` BIGINT COMMENT 'Reference to the turnaround event during which this catalyst was loaded or replaced. Links catalyst lifecycle to major maintenance events.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Catalyst batches are procured from specific vendors. Real catalyst management tracks vendor for warranty claims, performance guarantee validation, technical support escalation, regeneration services, ',
    `waste_manifest_id` BIGINT COMMENT 'Foreign key linking to hse.waste_manifest. Business justification: Spent catalyst is RCRA hazardous waste requiring manifested disposal. Waste tracking systems require catalyst batch-to-manifest linkage for EPA compliance, disposal cost allocation, and metals content',
    `previous_catalyst_lifecycle_id` BIGINT COMMENT 'Self-referencing FK on catalyst_lifecycle (previous_catalyst_lifecycle_id)',
    `activity_measurement_date` DATE COMMENT 'Date when the current activity level was last measured or calculated. Used to assess the freshness of activity data and schedule next measurement.',
    `actual_replacement_date` DATE COMMENT 'Actual date when the catalyst batch was fully replaced and unloaded from the unit. Marks the end of the catalyst lifecycle. Null if still in service.',
    `addition_withdrawal_count` STRING COMMENT 'Total number of catalyst addition or withdrawal events since initial load. Tracks the frequency of catalyst inventory adjustments and partial replacements.',
    `catalyst_age_days` STRING COMMENT 'Number of days since initial load date. Used to track catalyst lifecycle progression and compare against expected service life.',
    `catalyst_batch_number` STRING COMMENT 'Unique batch or lot number assigned by the manufacturer for traceability and quality control. Critical for tracking performance and warranty claims.',
    `catalyst_grade` STRING COMMENT 'Manufacturer-specific grade or formulation designation indicating the catalyst composition, activity level, and intended application specifications.',
    `catalyst_type` STRING COMMENT 'Classification of catalyst by the primary refining process it supports. Determines the chemical reactions and performance characteristics expected. [ENUM-REF-CANDIDATE: fcc|hds|reformer|alkylation|isomerization|hydrocracker|hydrotreater — 7 candidates stripped; promote to reference product]',
    `coke_content_wt_pct` DECIMAL(18,2) COMMENT 'Weight percentage of coke deposits on the catalyst surface. High coke content reduces activity and indicates need for regeneration. Measured during catalyst sampling.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this catalyst lifecycle record was first created in the system. Used for data lineage and audit trail purposes.',
    `cumulative_throughput_bbl` DECIMAL(18,2) COMMENT 'Total volume of feedstock processed by this catalyst batch since initial load, measured in barrels. Key metric for catalyst performance evaluation and replacement planning.',
    `current_activity_level` DECIMAL(18,2) COMMENT 'Current catalytic activity level expressed as a percentage of fresh catalyst performance. Declines over time due to fouling, poisoning, and thermal degradation. Critical for determining regeneration or replacement timing.',
    `current_mass` DECIMAL(18,2) COMMENT 'Current mass of active catalyst in the process unit after accounting for additions, withdrawals, and attrition. Used for material balance and performance calculations.',
    `current_volume` DECIMAL(18,2) COMMENT 'Current volume of active catalyst in the process unit after accounting for additions, withdrawals, and attrition. Updated after each catalyst movement event.',
    `disposal_date` DATE COMMENT 'Date when spent catalyst was disposed of or transferred to a disposal vendor. Used for environmental compliance reporting and waste tracking.',
    `disposal_method` STRING COMMENT 'Method used for disposal of spent catalyst after replacement. Critical for environmental compliance and tracking of hazardous waste containing metals.. Valid values are `reclamation|landfill|incineration|recycling|vendor_return`',
    `disposal_vendor_name` STRING COMMENT 'Name of the vendor or facility that received the spent catalyst for disposal or reclamation. Required for hazardous waste manifest documentation.',
    `expected_service_life_days` STRING COMMENT 'Manufacturer-specified or historically-derived expected service life for this catalyst type under normal operating conditions. Used for replacement planning and budgeting.',
    `initial_load_date` DATE COMMENT 'Date when the catalyst batch was first loaded into the process unit. Marks the beginning of the catalyst lifecycle and is used to calculate age and replacement schedules.',
    `initial_load_mass` DECIMAL(18,2) COMMENT 'Mass of catalyst loaded at initial installation, measured in pounds or kilograms. Used for material balance calculations and cost tracking.',
    `initial_load_volume` DECIMAL(18,2) COMMENT 'Volume of catalyst loaded at initial installation, measured in cubic feet or cubic meters. Baseline for tracking additions, withdrawals, and inventory levels.',
    `last_addition_date` DATE COMMENT 'Date when fresh catalyst was last added to the unit. Used for continuous catalyst replacement (CCR) units and periodic top-up operations.',
    `last_addition_volume` DECIMAL(18,2) COMMENT 'Volume of catalyst added during the most recent addition event. Used to track catalyst consumption rates and inventory management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this catalyst lifecycle record was last updated. Used for change tracking and data quality monitoring.',
    `last_regeneration_date` DATE COMMENT 'Date of the most recent catalyst regeneration event. Used to track time since last regeneration and plan next regeneration cycle.',
    `last_withdrawal_date` DATE COMMENT 'Date when spent catalyst was last withdrawn from the unit. Used for continuous catalyst replacement (CCR) units and partial unloading operations.',
    `last_withdrawal_volume` DECIMAL(18,2) COMMENT 'Volume of spent catalyst withdrawn during the most recent withdrawal event. Used to track catalyst disposal rates and replacement planning.',
    `lifecycle_status` STRING COMMENT 'Current operational status of the catalyst batch in its lifecycle. Tracks progression from active service through regeneration, replacement, and disposal.. Valid values are `active|regenerating|scheduled_replacement|replaced|disposed`',
    `manufacturer_product_code` STRING COMMENT 'Manufacturers internal product code or SKU for the catalyst formulation. Used for procurement, technical documentation, and reordering.',
    `mass_unit_of_measure` STRING COMMENT 'Unit of measure for all mass-related catalyst quantities in this record. Ensures consistent interpretation of mass data.. Valid values are `pounds|kilograms|metric_tons`',
    `metals_content_analysis` STRING COMMENT 'Laboratory analysis results showing metal contaminants (nickel, vanadium, iron) deposited on the catalyst from feedstock. Used to assess catalyst poisoning and disposal classification.',
    `next_regeneration_date` DATE COMMENT 'Scheduled date for the next catalyst regeneration based on activity decline projections and operational planning. Subject to change based on actual performance.',
    `performance_notes` STRING COMMENT 'Free-text field for capturing operational observations, performance anomalies, lessons learned, and technical notes about catalyst behavior during its lifecycle.',
    `planned_replacement_date` DATE COMMENT 'Scheduled date for full catalyst replacement based on expected service life, activity decline trends, and turnaround planning. Aligned with refinery maintenance schedules.',
    `procurement_cost_usd` DECIMAL(18,2) COMMENT 'Total cost paid to acquire this catalyst batch, including purchase price, freight, and handling. Used for cost tracking, budgeting, and economic analysis of catalyst performance.',
    `regeneration_count` STRING COMMENT 'Number of times the catalyst has been regenerated to restore activity. Regeneration involves burning off coke deposits and restoring active sites. Excessive regenerations can degrade catalyst structure.',
    `surface_area_m2_per_g` DECIMAL(18,2) COMMENT 'Specific surface area of the catalyst measured in square meters per gram. Declines over time due to sintering and pore collapse. Key indicator of catalyst health.',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure for all volume-related catalyst quantities in this record. Ensures consistent interpretation of volume data.. Valid values are `cubic_feet|cubic_meters|liters`',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty for this catalyst batch expires. Used for warranty claim management and vendor performance tracking.',
    CONSTRAINT pk_catalyst_lifecycle PRIMARY KEY(`catalyst_lifecycle_id`)
) COMMENT 'Master and transactional record for catalyst lifecycle management in refinery process units (FCC, HDS, reformer, alkylation, isomerization). Captures catalyst type, grade, manufacturer, batch number, initial load date, current activity level, regeneration history, addition/withdrawal events, spent catalyst disposal, and replacement scheduling.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`supply_agreement` (
    `supply_agreement_id` BIGINT COMMENT 'Unique identifier for the refinery-petrochemical supply agreement. Primary key for the association.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to the petrochemical plant that receives feedstock under this agreement',
    `quality_spec_id` BIGINT COMMENT 'Reference identifier to the detailed quality specification document that defines acceptable feedstock properties (density, sulfur content, distillation range, etc.) for this supply agreement. Links to quality management system.',
    `refinery_id` BIGINT COMMENT 'Foreign key linking to the refinery facility that supplies feedstock under this agreement',
    `contract_end_date` DATE COMMENT 'Expiration or termination date of the supply agreement. Used for contract renewal planning and supply continuity management.',
    `contract_start_date` DATE COMMENT 'Effective start date of the supply agreement. Marks the beginning of the contractual supply obligation.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the supply agreement. ACTIVE (currently in force), SUSPENDED (temporarily halted), EXPIRED (past end date), TERMINATED (cancelled before end date), UNDER_NEGOTIATION (being renewed or amended).',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this supply agreement record was created in the system.',
    `delivery_point` STRING COMMENT 'Physical location or pipeline interconnection point where custody transfer of the feedstock occurs from refinery to petrochemical plant. Examples: pipeline meter station, tank farm, over-the-fence connection.',
    `feedstock_type` STRING COMMENT 'Type of intermediate hydrocarbon product supplied from the refinery to the petrochemical plant under this agreement. Examples: NAPHTHA (steam cracker feed), PROPYLENE (polypropylene feed), BENZENE (aromatics feed).',
    `force_majeure_clause` STRING COMMENT 'Text or reference to the force majeure provisions in the supply agreement that define conditions under which supply obligations may be suspended (turnarounds, natural disasters, regulatory shutdowns).',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this supply agreement record was last updated in the system.',
    `minimum_offtake_obligation` DECIMAL(18,2) COMMENT 'Minimum volume in barrels per day that the petrochemical plant commits to take from the refinery under take-or-pay provisions. Used for refinery production planning and revenue assurance.',
    `pricing_basis` STRING COMMENT 'Pricing mechanism used to determine the transfer price or sale price of the feedstock. COST_PLUS (refinery cost plus margin), MARKET_INDEX (linked to published index like Platts), FIXED_PRICE (negotiated fixed rate), NETBACK (based on petrochemical product value), TRANSFER_PRICE (internal corporate transfer pricing).',
    `volume_contracted_bpd` DECIMAL(18,2) COMMENT 'Contracted daily supply volume in barrels per day (BPD) that the refinery commits to deliver to the petrochemical plant under this agreement. Used for production planning and capacity allocation.',
    CONSTRAINT pk_supply_agreement PRIMARY KEY(`supply_agreement_id`)
) COMMENT 'This association product represents the contractual supply relationship between a refinery facility and a petrochemical plant. It captures feedstock supply agreements where refineries provide intermediate products (naphtha, propylene, benzene, etc.) to petrochemical manufacturing facilities. Each record links one refinery to one petrochemical plant with contract terms, volume commitments, pricing basis, quality specifications, and delivery logistics that exist only in the context of this bilateral supply relationship.. Existence Justification: In integrated oil and gas operations, refineries and petrochemical plants have genuine many-to-many supply relationships. A single refinery commonly supplies naphtha, propylene, or other intermediate products to multiple downstream petrochemical facilities (e.g., one refinery feeding three crackers), while a single petrochemical plant routinely sources feedstock from multiple refineries to ensure supply security and optimize feedstock quality/cost. These are not analytical correlations but operational supply agreements that commercial teams actively negotiate, manage, and track with contract-specific terms.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`refinery_interest` (
    `refinery_interest_id` BIGINT COMMENT 'Primary key for the refinery working interest record',
    `refinery_id` BIGINT COMMENT 'Foreign key linking to the refinery facility that is subject to joint venture ownership',
    `partner_id` BIGINT COMMENT 'Foreign key linking to the joint venture partner holding an interest in the refinery',
    `cost_allocation_method` STRING COMMENT 'The method used to allocate operating costs and capital expenditures to this partner for this refinery. WI_Proportional = costs allocated by working interest percentage; Fixed_Fee = partner pays fixed amount; Hybrid = combination; Custom = special arrangement per JOA.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this working interest record was created in the system.',
    `effective_date` DATE COMMENT 'The date when this working interest arrangement became effective. Used for temporal tracking of ownership changes, acquisitions, and farm-ins/farm-outs.',
    `expiry_date` DATE COMMENT 'The date when this working interest arrangement expires or was terminated. Null for currently active interests. Used to track historical ownership structures.',
    `interest_status` STRING COMMENT 'Current lifecycle status of this working interest. Active = partner is currently participating; Suspended = temporarily not participating; Terminated = interest has ended; Pending = interest not yet effective.',
    `joa_agreement_number` STRING COMMENT 'Reference to the specific Joint Operating Agreement or Production Sharing Agreement governing this partners interest in this refinery.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this working interest record was last updated.',
    `net_revenue_interest_percentage` DECIMAL(18,2) COMMENT 'The partners proportional share of revenue from refinery operations after deducting royalties, overriding interests, and other burdens. NRI is typically less than or equal to WI.',
    `operator_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this partner serves as the designated operator for this specific refinery. The operator manages day-to-day operations and bills non-operators for their proportional share of costs.',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'The partners proportional share of capital costs and operating expenses for the refinery. Working interest holders bear costs proportional to their interest and receive revenue after royalties and other burdens.',
    CONSTRAINT pk_refinery_interest PRIMARY KEY(`refinery_interest_id`)
) COMMENT 'This association product represents the working interest ownership between a refinery facility and a joint venture partner. It captures the partners financial stake, operational role, and cost allocation method for a specific refinery asset. Each record links one refinery to one partner with attributes that exist only in the context of this ownership relationship, including working interest percentage, net revenue interest, operator designation, and effective dates.. Existence Justification: In oil and gas joint ventures, a single refinery facility can have multiple partners holding different working interest percentages (e.g., Partner A holds 40% WI, Partner B holds 35% WI, Partner C holds 25% WI in Refinery X). Conversely, a single partner can hold working interests in multiple refinery facilities across the portfolio. This is the fundamental ownership structure for joint venture refining assets, where each partner-refinery combination has unique financial terms (WI%, NRI%, cost allocation method) and operational roles (operator designation).';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`sample` (
    `sample_id` BIGINT COMMENT 'Primary key for sample',
    `parent_sample_id` BIGINT COMMENT 'Self-referencing FK on sample (parent_sample_id)',
    `sample_category` STRING COMMENT 'Logical grouping of the sample (e.g., raw material, derived metric, standard reference, custom definition).',
    `sample_code` STRING COMMENT 'Short alphanumeric code used to identify the sample in operational systems.',
    `confidentiality_level` STRING COMMENT 'Data classification indicating the sensitivity of the sample definition.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sample record was first inserted into the lakehouse.',
    `default_value` DECIMAL(18,2) COMMENT 'Typical or baseline numeric value associated with the sample when no measurement is recorded.',
    `sample_description` STRING COMMENT 'Detailed textual description of the sample purpose or characteristics.',
    `effective_from` DATE COMMENT 'Date on which the sample becomes valid for use.',
    `effective_until` DATE COMMENT 'Date after which the sample is no longer valid (null if open‑ended).',
    `is_deprecated` BOOLEAN COMMENT 'Indicates whether the sample definition is retired and should no longer be used.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp when the sample definition was last reviewed for accuracy.',
    `sample_name` STRING COMMENT 'Human‑readable name or title of the sample.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the sample.',
    `reviewed_by` STRING COMMENT 'Name or identifier of the data steward who performed the last review.',
    `source_system` STRING COMMENT 'Name of the upstream operational system that originated the sample (e.g., Aspen HYSYS, DCS).',
    `sample_status` STRING COMMENT 'Current lifecycle status of the sample record.',
    `sample_type` STRING COMMENT 'Technical type of the sample measurement or reference (e.g., temperature, pressure, flow, composition, quality).',
    `unit_of_measure` STRING COMMENT 'Standard unit used for the samples quantitative value.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the sample record.',
    `version_number` STRING COMMENT 'Incremental version of the sample definition for change tracking.',
    CONSTRAINT pk_sample PRIMARY KEY(`sample_id`)
) COMMENT 'Master reference table for sample. Referenced by sample_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`aspen_hysys_model` (
    `aspen_hysys_model_id` BIGINT COMMENT 'Primary key for aspen_hysys_model',
    `parent_aspen_hysys_model_id` BIGINT COMMENT 'Self-referencing FK on aspen_hysys_model (parent_aspen_hysys_model_id)',
    `capacity_bpd` DECIMAL(18,2) COMMENT 'Primary quantitative capacity of the model expressed in barrels per day.',
    `catalyst_type` STRING COMMENT 'Type of catalyst specified in the model, if applicable.',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard the model adheres to.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the model record was first created.',
    `data_source_system` STRING COMMENT 'Originating system that supplied the model data.',
    `effective_from` DATE COMMENT 'Date from which the model is considered valid for operational use.',
    `effective_until` DATE COMMENT 'Date after which the model is no longer valid (nullable for open‑ended).',
    `emission_factor_kg_per_bbl` DOUBLE COMMENT 'Estimated emissions per barrel of product, used for EPA compliance.',
    `input_feedstock` STRING COMMENT 'Description of the crude or feedstock input to the model.',
    `last_run_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent simulation execution.',
    `max_pressure_bar` DOUBLE COMMENT 'Highest pressure condition modeled, in bar.',
    `max_temperature_c` DOUBLE COMMENT 'Highest temperature condition modeled, in degrees Celsius.',
    `min_pressure_bar` DOUBLE COMMENT 'Lowest pressure condition modeled, in bar.',
    `min_temperature_c` DOUBLE COMMENT 'Lowest temperature condition modeled, in degrees Celsius.',
    `model_approval_date` DATE COMMENT 'Date when the model received its latest approval.',
    `model_approval_status` STRING COMMENT 'Current approval state of the model.',
    `model_author` STRING COMMENT 'Name of the engineer or team that authored the model.',
    `model_category` STRING COMMENT 'High‑level category of the model.',
    `model_change_reason` STRING COMMENT 'Narrative explaining why the model was revised.',
    `model_checksum` STRING COMMENT 'SHA‑256 checksum of the model file for integrity verification.',
    `model_code` STRING COMMENT 'Business identifier or code assigned to the model.',
    `model_deprecated_date` DATE COMMENT 'Date on which the model was marked as deprecated.',
    `model_deprecated_flag` BOOLEAN COMMENT 'Indicates whether the model has been deprecated.',
    `model_description` STRING COMMENT 'Detailed textual description of the models purpose and scope.',
    `model_file_path` STRING COMMENT 'File system or storage path where the model file resides.',
    `model_name` STRING COMMENT 'Human‑readable name of the HYSYS model.',
    `model_revision_number` STRING COMMENT 'Sequential revision number of the model.',
    `model_subcategory` STRING COMMENT 'More specific sub‑category within the model category.',
    `model_tags` STRING COMMENT 'Free‑form tags for search and classification.',
    `model_type` STRING COMMENT 'Classification of the simulation type (e.g., steady‑state, dynamic).',
    `model_version` STRING COMMENT 'Version identifier of the model (e.g., v1.2).',
    `model_version_notes` STRING COMMENT 'Free‑form notes describing changes in this version.',
    `organization` STRING COMMENT 'Business unit or subsidiary that owns the model.',
    `output_product` STRING COMMENT 'Primary product(s) generated by the model (e.g., gasoline, diesel).',
    `simulation_runtime_seconds` BIGINT COMMENT 'Duration of the last simulation run in seconds.',
    `simulation_software_version` STRING COMMENT 'Version of Aspen HYSYS used to build the model.',
    `aspen_hysys_model_status` STRING COMMENT 'Current lifecycle status of the model.',
    `unit_of_measure` STRING COMMENT 'Unit used for the principal capacity measurement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the model record.',
    `validation_date` DATE COMMENT 'Date when the model was last validated.',
    `validation_status` STRING COMMENT 'Result of the most recent validation run.',
    CONSTRAINT pk_aspen_hysys_model PRIMARY KEY(`aspen_hysys_model_id`)
) COMMENT 'Master reference table for aspen_hysys_model. Referenced by aspen_hysys_model_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`aspen_hysys_simulation` (
    `aspen_hysys_simulation_id` BIGINT COMMENT 'Primary key for aspen_hysys_simulation',
    `parent_aspen_hysys_simulation_id` BIGINT COMMENT 'Self-referencing FK on aspen_hysys_simulation (parent_aspen_hysys_simulation_id)',
    `api_gravity` DECIMAL(18,2) COMMENT 'American Petroleum Institute gravity of the crude or product, indicating density.',
    `co2_emissions_kg` DECIMAL(18,2) COMMENT 'Carbon dioxide emissions generated during the simulation, measured in kilograms.',
    `convergence_iterations` STRING COMMENT 'Number of iterations the solver performed before reaching convergence or termination.',
    `energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Total energy consumed by the simulated unit, expressed in megawatt‑hours.',
    `feedstock_rate_kg_per_hr` DECIMAL(18,2) COMMENT 'Mass flow rate of the feedstock entering the refinery unit in kilograms per hour.',
    `feedstock_type` STRING COMMENT 'Primary feedstock category used in the simulation.',
    `model_file_path` STRING COMMENT 'File system or object store path to the Aspen HYSYS model file used for the simulation.',
    `nitrogen_content_ppm` DECIMAL(18,2) COMMENT 'Nitrogen concentration in the product stream measured in parts per million.',
    `notes` STRING COMMENT 'Free‑form comments or observations captured by the engineer.',
    `pressure_bar` DECIMAL(18,2) COMMENT 'Average pressure of the process unit during the simulation.',
    `product_yield_percent` DECIMAL(18,2) COMMENT 'Overall mass yield of the target product expressed as a percentage of feedstock.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the simulation record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the simulation record.',
    `ron` DECIMAL(18,2) COMMENT 'Octane rating of gasoline product as measured by the research method.',
    `scenario_description` STRING COMMENT 'Narrative description of the operating scenario represented by the simulation.',
    `simulation_code` STRING COMMENT 'External code used to reference the simulation in reporting and downstream systems.',
    `simulation_duration_minutes` STRING COMMENT 'Wall‑clock time taken to run the simulation.',
    `simulation_name` STRING COMMENT 'Human‑readable name of the simulation model or scenario.',
    `simulation_status` STRING COMMENT 'Current execution state of the simulation run.',
    `simulation_type` STRING COMMENT 'Category of the simulation indicating its purpose and calculation mode.',
    `solver_converged` BOOLEAN COMMENT 'Indicates whether the numerical solver successfully converged for the simulation.',
    `aspen_hysys_simulation_status` STRING COMMENT 'Current lifecycle state of the simulation record.',
    `sulfur_content_ppm` DECIMAL(18,2) COMMENT 'Sulfur concentration in the product stream measured in parts per million.',
    `tan_mg_per_kg` DECIMAL(18,2) COMMENT 'Total acid number of the product, indicating acidity level.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Average temperature of the process unit during the simulation.',
    `version` STRING COMMENT 'Version identifier for the simulation model (e.g., v1.0, v2.3).',
    `viscosity_cst` DECIMAL(18,2) COMMENT 'Kinematic viscosity of the product in centistokes.',
    CONSTRAINT pk_aspen_hysys_simulation PRIMARY KEY(`aspen_hysys_simulation_id`)
) COMMENT 'Master reference table for aspen_hysys_simulation. Referenced by aspen_hysys_simulation_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`aspen_simulation` (
    `aspen_simulation_id` BIGINT COMMENT 'Primary key for aspen_simulation',
    `parent_aspen_simulation_id` BIGINT COMMENT 'Self-referencing FK on aspen_simulation (parent_aspen_simulation_id)',
    `author` STRING COMMENT 'Name of the engineer or analyst who created the simulation.',
    `author_email` STRING COMMENT 'Contact email of the simulation author.',
    `catalyst_loading_kg` DECIMAL(18,2) COMMENT 'Mass of catalyst assumed in the process unit, in kilograms.',
    `catalyst_type` STRING COMMENT 'Type of catalyst modeled in the simulation (e.g., zeolite, metal‑based).',
    `compliance_status` STRING COMMENT 'Indicates whether the simulation meets EPA and API regulatory constraints.',
    `cost_estimate_usd` DECIMAL(18,2) COMMENT 'Financial estimate of operating cost for the simulated scenario, in US dollars.',
    `aspen_simulation_description` STRING COMMENT 'Detailed free‑text description of the simulation purpose, assumptions, and scope.',
    `economic_indicator` STRING COMMENT 'Key economic metric used to evaluate the simulation outcome.',
    `effective_end_date` DATE COMMENT 'Date after which the simulation results are no longer applicable (nullable).',
    `effective_start_date` DATE COMMENT 'Date from which the simulation results are considered valid for planning.',
    `emissions_co2_tons` DECIMAL(18,2) COMMENT 'Estimated carbon dioxide emissions from the simulated operation, in metric tons.',
    `energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Total energy consumed by the refinery units in the simulation, measured in megawatt‑hours.',
    `feedstock_quantity_bbl` DECIMAL(18,2) COMMENT 'Quantity of feedstock input to the simulation, measured in barrels.',
    `feedstock_type` STRING COMMENT 'Primary crude or feedstock category used in the simulation (e.g., light crude, heavy crude).',
    `heat_duty_mw` DECIMAL(18,2) COMMENT 'Total heat duty required by the simulated units, in megawatts.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent technical review of the simulation.',
    `model_version` STRING COMMENT 'Version identifier of the Aspen HYSYS model used.',
    `nitrogen_content_ppm` DECIMAL(18,2) COMMENT 'Predicted nitrogen concentration in the product, expressed in parts per million.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or observations.',
    `pressure_bar` DECIMAL(18,2) COMMENT 'Average operating pressure used in the simulation, in bar.',
    `primary_metric_value` DECIMAL(18,2) COMMENT 'Key quantitative outcome of the simulation (e.g., overall yield percent).',
    `product_yield_bbl` DECIMAL(18,2) COMMENT 'Total volume of refined product output predicted by the simulation.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the simulation record was first created in the data lake.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the simulation record.',
    `recycle_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of recycle stream returned to the unit in the simulation.',
    `risk_level` STRING COMMENT 'Qualitative risk rating associated with the simulation assumptions.',
    `simulation_code` STRING COMMENT 'External code or identifier used by engineering teams to reference the simulation.',
    `simulation_duration_minutes` STRING COMMENT 'Total wall‑clock time taken to run the simulation.',
    `simulation_name` STRING COMMENT 'Human‑readable name identifying the simulation scenario.',
    `simulation_run_date` DATE COMMENT 'Calendar date on which the simulation was executed.',
    `simulation_scenario` STRING COMMENT 'Descriptive label of the scenario (e.g., "Base Case", "High Yield").',
    `simulation_type` STRING COMMENT 'Category of simulation indicating its purpose or methodology.',
    `software_version` STRING COMMENT 'Version of the Aspen HYSYS software executing the simulation.',
    `aspen_simulation_status` STRING COMMENT 'Current lifecycle status of the simulation record.',
    `steam_consumption_tph` DECIMAL(18,2) COMMENT 'Steam consumption rate in tons per hour.',
    `sulfur_content_ppm` DECIMAL(18,2) COMMENT 'Predicted sulfur concentration in the product, expressed in parts per million.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Average operating temperature used in the simulation, in degrees Celsius.',
    `validation_status` STRING COMMENT 'Result of the internal review process for the simulation outputs.',
    `version_number` STRING COMMENT 'Incremental version of the simulation model.',
    `waste_generated_tons` DECIMAL(18,2) COMMENT 'Estimated solid waste generated in the simulated operation, in metric tons.',
    `water_usage_m3` DECIMAL(18,2) COMMENT 'Total water usage forecast by the simulation, in cubic meters.',
    CONSTRAINT pk_aspen_simulation PRIMARY KEY(`aspen_simulation_id`)
) COMMENT 'Master reference table for aspen_simulation. Referenced by aspen_simulation_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ADD CONSTRAINT `fk_refining_refinery_aspen_hysys_model_id` FOREIGN KEY (`aspen_hysys_model_id`) REFERENCES `oil_gas_ecm`.`refining`.`aspen_hysys_model`(`aspen_hysys_model_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ADD CONSTRAINT `fk_refining_process_unit_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ADD CONSTRAINT `fk_refining_feedstock_blend_blending_recipe_id` FOREIGN KEY (`blending_recipe_id`) REFERENCES `oil_gas_ecm`.`refining`.`blending_recipe`(`blending_recipe_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ADD CONSTRAINT `fk_refining_feedstock_blend_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ADD CONSTRAINT `fk_refining_feedstock_blend_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `oil_gas_ecm`.`refining`.`product_specification`(`product_specification_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ADD CONSTRAINT `fk_refining_unit_run_aspen_simulation_id` FOREIGN KEY (`aspen_simulation_id`) REFERENCES `oil_gas_ecm`.`refining`.`aspen_simulation`(`aspen_simulation_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ADD CONSTRAINT `fk_refining_unit_run_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ADD CONSTRAINT `fk_refining_refining_yield_record_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ADD CONSTRAINT `fk_refining_refining_yield_record_unit_run_id` FOREIGN KEY (`unit_run_id`) REFERENCES `oil_gas_ecm`.`refining`.`unit_run`(`unit_run_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_blend_event_id` FOREIGN KEY (`blend_event_id`) REFERENCES `oil_gas_ecm`.`refining`.`blend_event`(`blend_event_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `oil_gas_ecm`.`refining`.`product_specification`(`product_specification_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_sample_id` FOREIGN KEY (`sample_id`) REFERENCES `oil_gas_ecm`.`refining`.`sample`(`sample_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_unit_run_id` FOREIGN KEY (`unit_run_id`) REFERENCES `oil_gas_ecm`.`refining`.`unit_run`(`unit_run_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ADD CONSTRAINT `fk_refining_refinery_schedule_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ADD CONSTRAINT `fk_refining_schedule_deviation_aspen_hysys_simulation_id` FOREIGN KEY (`aspen_hysys_simulation_id`) REFERENCES `oil_gas_ecm`.`refining`.`aspen_hysys_simulation`(`aspen_hysys_simulation_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ADD CONSTRAINT `fk_refining_schedule_deviation_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ADD CONSTRAINT `fk_refining_schedule_deviation_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ADD CONSTRAINT `fk_refining_schedule_deviation_refinery_schedule_id` FOREIGN KEY (`refinery_schedule_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery_schedule`(`refinery_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ADD CONSTRAINT `fk_refining_schedule_deviation_unit_run_id` FOREIGN KEY (`unit_run_id`) REFERENCES `oil_gas_ecm`.`refining`.`unit_run`(`unit_run_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ADD CONSTRAINT `fk_refining_blending_recipe_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `oil_gas_ecm`.`refining`.`product_specification`(`product_specification_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ADD CONSTRAINT `fk_refining_blend_event_blending_recipe_id` FOREIGN KEY (`blending_recipe_id`) REFERENCES `oil_gas_ecm`.`refining`.`blending_recipe`(`blending_recipe_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ADD CONSTRAINT `fk_refining_blend_event_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `oil_gas_ecm`.`refining`.`product_specification`(`product_specification_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ADD CONSTRAINT `fk_refining_blend_event_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ADD CONSTRAINT `fk_refining_blend_event_tank_inventory_id` FOREIGN KEY (`tank_inventory_id`) REFERENCES `oil_gas_ecm`.`refining`.`tank_inventory`(`tank_inventory_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ADD CONSTRAINT `fk_refining_blend_event_unit_run_id` FOREIGN KEY (`unit_run_id`) REFERENCES `oil_gas_ecm`.`refining`.`unit_run`(`unit_run_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ADD CONSTRAINT `fk_refining_turnaround_work_item_predecessor_work_item_turnaround_work_item_id` FOREIGN KEY (`predecessor_work_item_turnaround_work_item_id`) REFERENCES `oil_gas_ecm`.`refining`.`turnaround_work_item`(`turnaround_work_item_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ADD CONSTRAINT `fk_refining_turnaround_work_item_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ADD CONSTRAINT `fk_refining_turnaround_work_item_turnaround_id` FOREIGN KEY (`turnaround_id`) REFERENCES `oil_gas_ecm`.`refining`.`turnaround`(`turnaround_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ADD CONSTRAINT `fk_refining_energy_consumption_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ADD CONSTRAINT `fk_refining_hydrogen_balance_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ADD CONSTRAINT `fk_refining_process_alarm_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ADD CONSTRAINT `fk_refining_process_alarm_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_product_quality_test_id` FOREIGN KEY (`product_quality_test_id`) REFERENCES `oil_gas_ecm`.`refining`.`product_quality_test`(`product_quality_test_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_tank_inventory_id` FOREIGN KEY (`tank_inventory_id`) REFERENCES `oil_gas_ecm`.`refining`.`tank_inventory`(`tank_inventory_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_blend_event_id` FOREIGN KEY (`blend_event_id`) REFERENCES `oil_gas_ecm`.`refining`.`blend_event`(`blend_event_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_refinery_schedule_id` FOREIGN KEY (`refinery_schedule_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery_schedule`(`refinery_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ADD CONSTRAINT `fk_refining_product_specification_superseded_by_specification_product_specification_id` FOREIGN KEY (`superseded_by_specification_product_specification_id`) REFERENCES `oil_gas_ecm`.`refining`.`product_specification`(`product_specification_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ADD CONSTRAINT `fk_refining_catalyst_lifecycle_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ADD CONSTRAINT `fk_refining_catalyst_lifecycle_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ADD CONSTRAINT `fk_refining_catalyst_lifecycle_turnaround_id` FOREIGN KEY (`turnaround_id`) REFERENCES `oil_gas_ecm`.`refining`.`turnaround`(`turnaround_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ADD CONSTRAINT `fk_refining_catalyst_lifecycle_previous_catalyst_lifecycle_id` FOREIGN KEY (`previous_catalyst_lifecycle_id`) REFERENCES `oil_gas_ecm`.`refining`.`catalyst_lifecycle`(`catalyst_lifecycle_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`supply_agreement` ADD CONSTRAINT `fk_refining_supply_agreement_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_interest` ADD CONSTRAINT `fk_refining_refinery_interest_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`sample` ADD CONSTRAINT `fk_refining_sample_parent_sample_id` FOREIGN KEY (`parent_sample_id`) REFERENCES `oil_gas_ecm`.`refining`.`sample`(`sample_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`aspen_hysys_model` ADD CONSTRAINT `fk_refining_aspen_hysys_model_parent_aspen_hysys_model_id` FOREIGN KEY (`parent_aspen_hysys_model_id`) REFERENCES `oil_gas_ecm`.`refining`.`aspen_hysys_model`(`aspen_hysys_model_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`aspen_hysys_simulation` ADD CONSTRAINT `fk_refining_aspen_hysys_simulation_parent_aspen_hysys_simulation_id` FOREIGN KEY (`parent_aspen_hysys_simulation_id`) REFERENCES `oil_gas_ecm`.`refining`.`aspen_hysys_simulation`(`aspen_hysys_simulation_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`aspen_simulation` ADD CONSTRAINT `fk_refining_aspen_simulation_parent_aspen_simulation_id` FOREIGN KEY (`parent_aspen_simulation_id`) REFERENCES `oil_gas_ecm`.`refining`.`aspen_simulation`(`aspen_simulation_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`refining` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `oil_gas_ecm`.`refining` SET TAGS ('dbx_domain' = 'refining');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` SET TAGS ('dbx_subdomain' = 'refinery_operations');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Identifier');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `aspen_hysys_model_id` SET TAGS ('dbx_business_glossary_term' = 'Aspen HYSYS Model Identifier');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `objective_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Objective Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Manager Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `alkylation_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Alkylation Unit Count');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `api_facility_number` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Facility Number');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `cdu_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Crude Distillation Unit (CDU) Count');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `coker_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Coker Unit Count');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `dcs_system_code` SET TAGS ('dbx_business_glossary_term' = 'Distributed Control System (DCS) Identifier');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'integrated_refinery|hydroskimming|conversion|specialty');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `fcc_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Fluid Catalytic Cracking (FCC) Unit Count');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `hds_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Hydrodesulfurization (HDS) Unit Count');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `hydrocracker_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Hydrocracker Unit Count');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `is_tier_3_compliant` SET TAGS ('dbx_business_glossary_term' = 'EPA Tier 3 Compliance Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `is_ulsd_capable` SET TAGS ('dbx_business_glossary_term' = 'Ultra-Low Sulfur Diesel (ULSD) Capability Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `last_turnaround_date` SET TAGS ('dbx_business_glossary_term' = 'Last Turnaround Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `nameplate_capacity_bopd` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Capacity in Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `nelson_complexity_index` SET TAGS ('dbx_business_glossary_term' = 'Nelson Complexity Index (NCI)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `next_turnaround_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Turnaround Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operating|turnaround|idle|decommissioned|under_construction');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'wholly_owned|joint_venture|leased|operated');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `pi_system_site_name` SET TAGS ('dbx_business_glossary_term' = 'OSIsoft PI System Site Name');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `primary_feedstock_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Feedstock Type');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `primary_feedstock_type` SET TAGS ('dbx_value_regex' = 'light_sweet|medium_sour|heavy_sour|synthetic|blended');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `refinery_code` SET TAGS ('dbx_business_glossary_term' = 'Refinery Code');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `refinery_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `refinery_name` SET TAGS ('dbx_business_glossary_term' = 'Refinery Name');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `reformer_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Catalytic Reformer Unit Count');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `renewable_diesel_capacity_bopd` SET TAGS ('dbx_business_glossary_term' = 'Renewable Diesel Capacity in Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Street Address');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `vdu_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Vacuum Distillation Unit (VDU) Count');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `hse_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Risk Assessment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Supervisor Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `alarm_acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Alarm Acknowledgment Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `alarm_acknowledgment_status` SET TAGS ('dbx_value_regex' = 'Unacknowledged|Acknowledged|Cleared|Shelved');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `alarm_priority` SET TAGS ('dbx_business_glossary_term' = 'Alarm Priority');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `alarm_priority` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `alarm_root_cause_classification` SET TAGS ('dbx_business_glossary_term' = 'Alarm Root Cause Classification');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `alarm_setpoint` SET TAGS ('dbx_business_glossary_term' = 'Alarm Setpoint Value');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `alarm_shelving_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alarm Shelving Expiry Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `alarm_shelving_reason` SET TAGS ('dbx_business_glossary_term' = 'Alarm Shelving Reason');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `alarm_shelving_status` SET TAGS ('dbx_business_glossary_term' = 'Alarm Shelving Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `alarm_tag` SET TAGS ('dbx_business_glossary_term' = 'Alarm Tag Identifier');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `alarm_type` SET TAGS ('dbx_business_glossary_term' = 'Alarm Type');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `alarm_type` SET TAGS ('dbx_value_regex' = 'High|Low|Deviation|Rate-of-Change|Equipment-Failure|Safety-Critical');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `aspen_hysys_model_reference` SET TAGS ('dbx_business_glossary_term' = 'Aspen HYSYS Model Reference');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `capacity_constraint_description` SET TAGS ('dbx_business_glossary_term' = 'Capacity Constraint Description');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_value_regex' = 'BPD|BOPD|MCFD|MMCFD|MT/Day');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `dcs_tag_prefix` SET TAGS ('dbx_business_glossary_term' = 'Distributed Control System (DCS) Tag Prefix');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `design_capacity` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `design_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Design Pressure (PSI)');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `design_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Design Temperature (Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `epa_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Reporting Required Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `feed_type` SET TAGS ('dbx_business_glossary_term' = 'Feed Type');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `last_turnaround_date` SET TAGS ('dbx_business_glossary_term' = 'Last Turnaround Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `next_turnaround_date` SET TAGS ('dbx_business_glossary_term' = 'Next Turnaround Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `operating_pressure_max_psi` SET TAGS ('dbx_business_glossary_term' = 'Operating Pressure Maximum (PSI)');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `operating_pressure_min_psi` SET TAGS ('dbx_business_glossary_term' = 'Operating Pressure Minimum (PSI)');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `operating_temperature_max_f` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Maximum (Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `operating_temperature_min_f` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Minimum (Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'Operating|Shutdown|Turnaround|Startup|Standby|Decommissioned');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `operator_response_action` SET TAGS ('dbx_business_glossary_term' = 'Operator Response Action');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `operator_response_required` SET TAGS ('dbx_business_glossary_term' = 'Operator Response Required Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `operator_response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Operator Response Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `pi_historian_tag_group` SET TAGS ('dbx_business_glossary_term' = 'PI System Historian Tag Group');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `process_safety_management_tier` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Management (PSM) Tier');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `process_safety_management_tier` SET TAGS ('dbx_value_regex' = 'Tier-1|Tier-2|Tier-3|Tier-4');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Code');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Name');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Type');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `crude_assay_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Assay Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `hazardous_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Substance Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `price_differential_id` SET TAGS ('dbx_business_glossary_term' = 'Price Differential Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `aromatic_content_wt_pct` SET TAGS ('dbx_business_glossary_term' = 'Aromatic Content Weight Percent (wt%)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `asphaltene_content_wt_pct` SET TAGS ('dbx_business_glossary_term' = 'Asphaltene Content Weight Percent (wt%)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `assay_date` SET TAGS ('dbx_business_glossary_term' = 'Assay Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `assay_laboratory` SET TAGS ('dbx_business_glossary_term' = 'Assay Laboratory');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `assay_name` SET TAGS ('dbx_business_glossary_term' = 'Assay Name');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `assay_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Assay Report Reference');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `assay_status` SET TAGS ('dbx_business_glossary_term' = 'Assay Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `assay_status` SET TAGS ('dbx_value_regex' = 'draft|validated|active|superseded|archived');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `assay_version` SET TAGS ('dbx_business_glossary_term' = 'Assay Version');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `carbon_residue_wt_pct` SET TAGS ('dbx_business_glossary_term' = 'Conradson Carbon Residue Weight Percent (wt%)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `cetane_index` SET TAGS ('dbx_business_glossary_term' = 'Cetane Index');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `diesel_yield_vol_pct` SET TAGS ('dbx_business_glossary_term' = 'Diesel Yield Volume Percent (vol%)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `distillation_method` SET TAGS ('dbx_business_glossary_term' = 'Distillation Method');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `distillation_method` SET TAGS ('dbx_value_regex' = 'TBP|ASTM D86|ASTM D2892|ASTM D5236');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `flash_point_c` SET TAGS ('dbx_business_glossary_term' = 'Flash Point in Degrees Celsius (°C)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `freeze_point_c` SET TAGS ('dbx_business_glossary_term' = 'Freeze Point in Degrees Celsius (°C)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `heavy_naphtha_yield_vol_pct` SET TAGS ('dbx_business_glossary_term' = 'Heavy Naphtha Yield Volume Percent (vol%)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `hydrogen_content_wt_pct` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Content Weight Percent (wt%)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `iron_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Iron Content in Parts Per Million (ppm)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `kerosene_yield_vol_pct` SET TAGS ('dbx_business_glossary_term' = 'Kerosene Yield Volume Percent (vol%)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `light_naphtha_yield_vol_pct` SET TAGS ('dbx_business_glossary_term' = 'Light Naphtha Yield Volume Percent (vol%)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `nickel_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Nickel Content in Parts Per Million (ppm)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `nitrogen_content_wt_ppm` SET TAGS ('dbx_business_glossary_term' = 'Nitrogen Content in Weight Parts Per Million (wt ppm)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `pour_point_c` SET TAGS ('dbx_business_glossary_term' = 'Pour Point in Degrees Celsius (°C)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `resin_content_wt_pct` SET TAGS ('dbx_business_glossary_term' = 'Resin Content Weight Percent (wt%)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `rvp_psi` SET TAGS ('dbx_business_glossary_term' = 'Reid Vapor Pressure (RVP) in Pounds per Square Inch (psi)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `salt_content_ptb` SET TAGS ('dbx_business_glossary_term' = 'Salt Content in Pounds per Thousand Barrels (PTB)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `saturate_content_wt_pct` SET TAGS ('dbx_business_glossary_term' = 'Saturate Content Weight Percent (wt%)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `smoke_point_mm` SET TAGS ('dbx_business_glossary_term' = 'Smoke Point in Millimeters (mm)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `source_location` SET TAGS ('dbx_business_glossary_term' = 'Source Location');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `specific_gravity` SET TAGS ('dbx_business_glossary_term' = 'Specific Gravity');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `sulfur_content_wt_pct` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Weight Percent (wt%)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `tan_mg_koh_per_g` SET TAGS ('dbx_business_glossary_term' = 'Total Acid Number (TAN) in Milligrams Potassium Hydroxide per Gram (mg KOH/g)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `vacuum_residue_yield_vol_pct` SET TAGS ('dbx_business_glossary_term' = 'Vacuum Residue Yield Volume Percent (vol%)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `vanadium_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Vanadium Content in Parts Per Million (ppm)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `vgo_yield_vol_pct` SET TAGS ('dbx_business_glossary_term' = 'Vacuum Gas Oil (VGO) Yield Volume Percent (vol%)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `viscosity_cst_at_100c` SET TAGS ('dbx_business_glossary_term' = 'Kinematic Viscosity at 100 Degrees Celsius (cSt)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `viscosity_cst_at_40c` SET TAGS ('dbx_business_glossary_term' = 'Kinematic Viscosity at 40 Degrees Celsius (cSt)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `water_content_vol_pct` SET TAGS ('dbx_business_glossary_term' = 'Water Content Volume Percent (vol%)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `wax_content_wt_pct` SET TAGS ('dbx_business_glossary_term' = 'Wax Content Weight Percent (wt%)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `feedstock_blend_id` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Blend Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Blend Engineer Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `blending_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Blending Recipe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Driving Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `pipeline_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Target Process Unit Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Source Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Source Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Source Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `actual_total_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Actual Total Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `blend_api_gravity` SET TAGS ('dbx_business_glossary_term' = 'Blend American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `blend_end_date` SET TAGS ('dbx_business_glossary_term' = 'Blend End Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `blend_flash_point_c` SET TAGS ('dbx_business_glossary_term' = 'Blend Flash Point in Celsius (C)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `blend_metals_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Blend Metals Content in Parts Per Million (PPM)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `blend_name` SET TAGS ('dbx_business_glossary_term' = 'Blend Name');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `blend_nitrogen_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Blend Nitrogen Content in Parts Per Million (PPM)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `blend_number` SET TAGS ('dbx_business_glossary_term' = 'Blend Number');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `blend_pour_point_c` SET TAGS ('dbx_business_glossary_term' = 'Blend Pour Point in Celsius (C)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `blend_salt_content_ptb` SET TAGS ('dbx_business_glossary_term' = 'Blend Salt Content in Pounds per Thousand Barrels (PTB)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `blend_sediment_content_vol_pct` SET TAGS ('dbx_business_glossary_term' = 'Blend Sediment Content in Volume Percent (VOL%)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `blend_start_date` SET TAGS ('dbx_business_glossary_term' = 'Blend Start Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `blend_status` SET TAGS ('dbx_business_glossary_term' = 'Blend Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `blend_status` SET TAGS ('dbx_value_regex' = 'planned|approved|in_progress|completed|cancelled|on_hold');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `blend_sulfur_content_wt_pct` SET TAGS ('dbx_business_glossary_term' = 'Blend Sulfur Content in Weight Percent (WT%)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `blend_tan` SET TAGS ('dbx_business_glossary_term' = 'Blend Total Acid Number (TAN)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `blend_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Blend Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `blend_type` SET TAGS ('dbx_business_glossary_term' = 'Blend Type');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `blend_type` SET TAGS ('dbx_value_regex' = 'crude_blend|intermediate_blend|feedstock_optimization|emergency_blend|test_blend|standard_recipe');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `blend_viscosity_cst` SET TAGS ('dbx_business_glossary_term' = 'Blend Viscosity in Centistokes (CST)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `blend_water_content_vol_pct` SET TAGS ('dbx_business_glossary_term' = 'Blend Water Content in Volume Percent (VOL%)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `blending_rationale` SET TAGS ('dbx_business_glossary_term' = 'Blending Rationale');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `blending_rationale` SET TAGS ('dbx_value_regex' = 'cost_optimization|yield_optimization|quality_compliance|feedstock_availability|contract_obligation|operational_constraint');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `estimated_margin_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Margin in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `estimated_margin_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `estimated_processing_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Processing Cost in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `estimated_processing_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `estimated_product_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Product Value in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `estimated_product_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `optimization_score` SET TAGS ('dbx_business_glossary_term' = 'Optimization Score');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `planned_total_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Planned Total Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `quality_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Compliance Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `quality_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|conditionally_approved|requires_adjustment');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `target_yield_distillates_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Distillates Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `target_yield_light_ends_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Light Ends Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `target_yield_naphtha_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Naphtha Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `target_yield_residue_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Residue Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `volume_variance_bbl` SET TAGS ('dbx_business_glossary_term' = 'Volume Variance in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` SET TAGS ('dbx_subdomain' = 'refinery_operations');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `unit_run_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Run Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `aspen_simulation_id` SET TAGS ('dbx_business_glossary_term' = 'Aspen HYSYS Simulation Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `process_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Supervisor Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `catalyst_activity_index` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Activity Index');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `catalyst_age_days` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Age Days');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `conversion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `dcs_historian_tag` SET TAGS ('dbx_business_glossary_term' = 'Distributed Control System (DCS) Historian Tag');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `diesel_yield_bbl` SET TAGS ('dbx_business_glossary_term' = 'Diesel Yield Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `electricity_consumption_mwh` SET TAGS ('dbx_business_glossary_term' = 'Electricity Consumption Megawatt Hours (MWh)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `energy_consumption_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Million British Thermal Units (MMBtu)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `feed_rate_bopd` SET TAGS ('dbx_business_glossary_term' = 'Feed Rate Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `feedstock_mass_mt` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Mass Metric Tons (MT)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `feedstock_type` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Type');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `feedstock_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Volume Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `gas_oil_yield_bbl` SET TAGS ('dbx_business_glossary_term' = 'Gas Oil Yield Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `kerosene_yield_bbl` SET TAGS ('dbx_business_glossary_term' = 'Kerosene Yield Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `liquid_volume_unaccounted_for_bbl` SET TAGS ('dbx_business_glossary_term' = 'Liquid Volume Unaccounted For (LVUF) Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `lpg_yield_bbl` SET TAGS ('dbx_business_glossary_term' = 'Liquefied Petroleum Gas (LPG) Yield Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `mass_balance_closure_percent` SET TAGS ('dbx_business_glossary_term' = 'Mass Balance Closure Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `naphtha_yield_bbl` SET TAGS ('dbx_business_glossary_term' = 'Naphtha Yield Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `operating_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Operating Pressure Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `operating_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Celsius (C)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `planned_throughput_bbl` SET TAGS ('dbx_business_glossary_term' = 'Planned Throughput Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `residue_yield_bbl` SET TAGS ('dbx_business_glossary_term' = 'Residue Yield Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `ron_value` SET TAGS ('dbx_business_glossary_term' = 'Research Octane Number (RON) Value');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `run_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Run Duration Hours');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `run_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run End Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `run_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|aborted|suspended');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Run Type');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'normal|startup|shutdown|turnaround|catalyst_regeneration|emergency');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `steam_consumption_mt` SET TAGS ('dbx_business_glossary_term' = 'Steam Consumption Metric Tons (MT)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `sulfur_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Parts Per Million (PPM)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `tan_mg_koh_per_g` SET TAGS ('dbx_business_glossary_term' = 'Total Acid Number (TAN) Milligrams Potassium Hydroxide per Gram (mg KOH/g)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `throughput_variance_bbl` SET TAGS ('dbx_business_glossary_term' = 'Throughput Variance Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `total_output_boe` SET TAGS ('dbx_business_glossary_term' = 'Total Output Barrel of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `total_product_mass_mt` SET TAGS ('dbx_business_glossary_term' = 'Total Product Mass Metric Tons (MT)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `total_product_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Total Product Volume Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` SET TAGS ('dbx_subdomain' = 'refinery_operations');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `refining_yield_record_id` SET TAGS ('dbx_business_glossary_term' = 'Refining Yield Record Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `esg_report_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Report Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `unit_run_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Run Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `actual_mass_mt` SET TAGS ('dbx_business_glossary_term' = 'Actual Mass in Metric Tons (MT)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `actual_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `boe_equivalent` SET TAGS ('dbx_business_glossary_term' = 'Barrel of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `dcs_data_source` SET TAGS ('dbx_business_glossary_term' = 'Distributed Control System (DCS) Data Source');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `epa_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Reporting Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `loss_category` SET TAGS ('dbx_business_glossary_term' = 'Loss Category');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `loss_category` SET TAGS ('dbx_value_regex' = 'normal|evaporation|spillage|measurement_error|theft|unknown');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `lvuf_bbl` SET TAGS ('dbx_business_glossary_term' = 'Liquid Volume Unaccounted For (LVUF) in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `mass_balance_closure_pct` SET TAGS ('dbx_business_glossary_term' = 'Mass Balance Closure Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `mass_variance_mt` SET TAGS ('dbx_business_glossary_term' = 'Mass Variance in Metric Tons (MT)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'flow_meter|tank_gauging|mass_balance|simulation|manual');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `planned_mass_mt` SET TAGS ('dbx_business_glossary_term' = 'Planned Mass in Metric Tons (MT)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `planned_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Planned Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Quality Grade');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `quality_grade` SET TAGS ('dbx_value_regex' = 'premium|standard|off_spec|blendstock|intermediate');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `reconciliation_notes` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Notes');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `ron_value` SET TAGS ('dbx_business_glossary_term' = 'Research Octane Number (RON) Value');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `simulation_target_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Simulation Target Volume in Barrels (BBL) from Aspen HYSYS');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `simulation_variance_bbl` SET TAGS ('dbx_business_glossary_term' = 'Simulation Variance in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `sulfur_content_pct` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `tan_value` SET TAGS ('dbx_business_glossary_term' = 'Total Acid Number (TAN) Value');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `volume_variance_bbl` SET TAGS ('dbx_business_glossary_term' = 'Volume Variance in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `yield_status` SET TAGS ('dbx_business_glossary_term' = 'Yield Record Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ALTER COLUMN `yield_status` SET TAGS ('dbx_value_regex' = 'validated|preliminary|reconciled|disputed|adjusted');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `product_quality_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Test Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `blend_event_id` SET TAGS ('dbx_business_glossary_term' = 'Blend Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `blend_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Blend Recipe Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Related Complaint Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Test Material Master Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `unit_run_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Run Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `certification_datetime` SET TAGS ('dbx_business_glossary_term' = 'Certification Date and Time');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending_certification|rejected|provisional');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `certified_by` SET TAGS ('dbx_business_glossary_term' = 'Certified By');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `certified_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Test Comments');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `deviation_from_spec` SET TAGS ('dbx_business_glossary_term' = 'Deviation from Specification');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `epa_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Compliance Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `laboratory_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Code');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `laboratory_name` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Name');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `quality_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `retest_reason` SET TAGS ('dbx_business_glossary_term' = 'Retest Reason');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `retest_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Retest Required Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `sample_datetime` SET TAGS ('dbx_business_glossary_term' = 'Sample Date and Time');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `sample_point_code` SET TAGS ('dbx_business_glossary_term' = 'Sample Point Code');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `sample_point_description` SET TAGS ('dbx_business_glossary_term' = 'Sample Point Description');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `specification_max` SET TAGS ('dbx_business_glossary_term' = 'Specification Maximum');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `specification_min` SET TAGS ('dbx_business_glossary_term' = 'Specification Minimum');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `specification_target` SET TAGS ('dbx_business_glossary_term' = 'Specification Target');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `test_datetime` SET TAGS ('dbx_business_glossary_term' = 'Test Date and Time');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `test_method_code` SET TAGS ('dbx_business_glossary_term' = 'Test Method Code');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `test_method_description` SET TAGS ('dbx_business_glossary_term' = 'Test Method Description');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `test_number` SET TAGS ('dbx_business_glossary_term' = 'Test Number');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `test_precision` SET TAGS ('dbx_business_glossary_term' = 'Test Precision');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `test_property_name` SET TAGS ('dbx_business_glossary_term' = 'Test Property Name');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `test_result_status` SET TAGS ('dbx_business_glossary_term' = 'Test Result Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `test_result_status` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|retest|pending|cancelled');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` SET TAGS ('dbx_subdomain' = 'refinery_operations');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `refinery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Schedule ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `consent_order_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Planner Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Offtake Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `shipping_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Schedule Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activated Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `actual_crude_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Actual Crude Volume (BBL - Barrels)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `actual_crude_volume_bbl` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `cdu_throughput_target_bpd` SET TAGS ('dbx_business_glossary_term' = 'Crude Distillation Unit (CDU) Throughput Target (BOPD - Barrels of Oil Per Day)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `cdu_throughput_target_bpd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `crude_slate_plan` SET TAGS ('dbx_business_glossary_term' = 'Crude Slate Plan');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `crude_slate_plan` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Deviation Description');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `deviation_root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Deviation Root Cause Category');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `deviation_root_cause_category` SET TAGS ('dbx_value_regex' = 'equipment_failure|feedstock_quality|market_demand|maintenance_overrun|operational_constraint|external_factor');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `deviation_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Deviation Tracking Enabled');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `diesel_target_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Diesel Target Volume (BBL - Barrels)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `diesel_target_volume_bbl` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `fcc_throughput_target_bpd` SET TAGS ('dbx_business_glossary_term' = 'Fluid Catalytic Cracking (FCC) Unit Throughput Target (BOPD - Barrels of Oil Per Day)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `fcc_throughput_target_bpd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `financial_impact_usd` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact (USD - United States Dollars)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `financial_impact_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `fuel_oil_target_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Fuel Oil Target Volume (BBL - Barrels)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `fuel_oil_target_volume_bbl` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `gasoline_target_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Gasoline Target Volume (BBL - Barrels)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `gasoline_target_volume_bbl` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `hds_throughput_target_bpd` SET TAGS ('dbx_business_glossary_term' = 'Hydrodesulfurization (HDS) Unit Throughput Target (BOPD - Barrels of Oil Per Day)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `hds_throughput_target_bpd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `inventory_drawdown_plan` SET TAGS ('dbx_business_glossary_term' = 'Inventory Drawdown Plan');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `inventory_drawdown_plan` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `jet_fuel_target_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Jet Fuel Target Volume (BBL - Barrels)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `jet_fuel_target_volume_bbl` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `lp_model_run_reference` SET TAGS ('dbx_business_glossary_term' = 'Linear Programming (LP) Model Run Reference');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `lpg_target_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Liquefied Petroleum Gas (LPG) Target Volume (BBL - Barrels)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `lpg_target_volume_bbl` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `maintenance_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Scope Description');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `maintenance_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window End Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `maintenance_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Start Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `naphtha_target_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Naphtha Target Volume (BBL - Barrels)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `naphtha_target_volume_bbl` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `optimization_objective` SET TAGS ('dbx_business_glossary_term' = 'Optimization Objective');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `optimization_objective` SET TAGS ('dbx_value_regex' = 'maximize_margin|maximize_throughput|minimize_cost|meet_demand|balance_inventory|custom');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `planned_margin_usd` SET TAGS ('dbx_business_glossary_term' = 'Planned Margin (USD - United States Dollars)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `planned_margin_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `product_slate_plan` SET TAGS ('dbx_business_glossary_term' = 'Product Slate Plan');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `product_slate_plan` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|deferred');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Number');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_value_regex' = '^SCH-[0-9]{8}-[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|cancelled');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|ad_hoc');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `schedule_version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `superseded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Superseded Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `target_crude_tan` SET TAGS ('dbx_business_glossary_term' = 'Target Crude Total Acid Number (TAN)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `target_gasoline_ron` SET TAGS ('dbx_business_glossary_term' = 'Target Gasoline Research Octane Number (RON)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `total_crude_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Total Crude Volume (BBL - Barrels)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `total_crude_volume_bbl` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `variance_crude_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Variance Crude Volume (BBL - Barrels)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `variance_crude_volume_bbl` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `vdu_throughput_target_bpd` SET TAGS ('dbx_business_glossary_term' = 'Vacuum Distillation Unit (VDU) Throughput Target (BOPD - Barrels of Oil Per Day)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `vdu_throughput_target_bpd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` SET TAGS ('dbx_subdomain' = 'refinery_operations');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `schedule_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Deviation Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `aspen_hysys_simulation_id` SET TAGS ('dbx_business_glossary_term' = 'Aspen HYSYS Simulation Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Work Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `refinery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Schedule Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `unit_run_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Run Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `actual_throughput_bpd` SET TAGS ('dbx_business_glossary_term' = 'Actual Throughput Barrels Per Day (BPD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `actual_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `affected_product_stream` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Stream');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `corrective_action_owner` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Owner');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `dcs_alarm_count` SET TAGS ('dbx_business_glossary_term' = 'Distributed Control System (DCS) Alarm Count');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `deviation_category` SET TAGS ('dbx_business_glossary_term' = 'Deviation Category');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `deviation_category` SET TAGS ('dbx_value_regex' = 'equipment failure|feedstock quality|utility constraint|market demand change|planned maintenance overrun|unplanned shutdown');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `deviation_date` SET TAGS ('dbx_business_glossary_term' = 'Deviation Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `deviation_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deviation End Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `deviation_number` SET TAGS ('dbx_business_glossary_term' = 'Deviation Number');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `deviation_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deviation Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `deviation_status` SET TAGS ('dbx_business_glossary_term' = 'Deviation Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `deviation_status` SET TAGS ('dbx_value_regex' = 'open|under investigation|corrective action in progress|resolved|closed');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `feedstock_quality_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Quality Issue Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `margin_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Margin Impact Amount');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `margin_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `opex_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Variance Amount');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `opex_variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `planned_throughput_bpd` SET TAGS ('dbx_business_glossary_term' = 'Planned Throughput Barrels Per Day (BPD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `planned_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Planned Yield Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `production_loss_barrels` SET TAGS ('dbx_business_glossary_term' = 'Production Loss Barrels');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `reported_to_management_flag` SET TAGS ('dbx_business_glossary_term' = 'Reported to Management Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `schedule_recovery_plan` SET TAGS ('dbx_business_glossary_term' = 'Schedule Recovery Plan');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `throughput_variance_bpd` SET TAGS ('dbx_business_glossary_term' = 'Throughput Variance Barrels Per Day (BPD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `total_financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Financial Impact Amount');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `total_financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `utility_constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Utility Constraint Type');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ALTER COLUMN `yield_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Variance Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `blending_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Blending Recipe Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Additive Material Master Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `actual_component_volumes` SET TAGS ('dbx_business_glossary_term' = 'Actual Component Volumes');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `blend_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Blend End Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `blend_loss_bbl` SET TAGS ('dbx_business_glossary_term' = 'Blend Loss in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `blend_optimization_model` SET TAGS ('dbx_business_glossary_term' = 'Blend Optimization Model Reference');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `blend_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Blend Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `blend_tank_reference` SET TAGS ('dbx_business_glossary_term' = 'Blend Tank Reference');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `component_streams` SET TAGS ('dbx_business_glossary_term' = 'Component Streams');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `component_volume_fractions` SET TAGS ('dbx_business_glossary_term' = 'Component Volume Fractions');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `final_blend_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Final Blend Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `inline_blender_flag` SET TAGS ('dbx_business_glossary_term' = 'Inline Blender Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `measured_density_kg_m3` SET TAGS ('dbx_business_glossary_term' = 'Measured Density in Kilograms per Cubic Meter (kg/m³)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `measured_ron` SET TAGS ('dbx_business_glossary_term' = 'Measured Research Octane Number (RON)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `measured_rvp_psi` SET TAGS ('dbx_business_glossary_term' = 'Measured Reid Vapor Pressure (RVP) in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `measured_sulfur_ppm` SET TAGS ('dbx_business_glossary_term' = 'Measured Sulfur Content (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `operator_signoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Operator Sign-Off Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `quality_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Number');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `quality_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Compliance Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `quality_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_test|conditional_release');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `recipe_code` SET TAGS ('dbx_business_glossary_term' = 'Recipe Code');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `recipe_name` SET TAGS ('dbx_business_glossary_term' = 'Recipe Name');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `recipe_status` SET TAGS ('dbx_business_glossary_term' = 'Recipe Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `recipe_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|suspended|obsolete|archived');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `recipe_version` SET TAGS ('dbx_business_glossary_term' = 'Recipe Version Number');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `target_api_gravity` SET TAGS ('dbx_business_glossary_term' = 'Target American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `target_cetane_number` SET TAGS ('dbx_business_glossary_term' = 'Target Cetane Number');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `target_density_kg_m3` SET TAGS ('dbx_business_glossary_term' = 'Target Density in Kilograms per Cubic Meter (kg/m³)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `target_flash_point_c` SET TAGS ('dbx_business_glossary_term' = 'Target Flash Point in Celsius (C)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `target_freeze_point_c` SET TAGS ('dbx_business_glossary_term' = 'Target Freeze Point in Celsius (C)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `target_mon` SET TAGS ('dbx_business_glossary_term' = 'Target Motor Octane Number (MON)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `target_ron` SET TAGS ('dbx_business_glossary_term' = 'Target Research Octane Number (RON)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `target_rvp_psi` SET TAGS ('dbx_business_glossary_term' = 'Target Reid Vapor Pressure (RVP) in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `target_sulfur_ppm` SET TAGS ('dbx_business_glossary_term' = 'Target Sulfur Content (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `target_viscosity_cst` SET TAGS ('dbx_business_glossary_term' = 'Target Kinematic Viscosity in Centistokes (cSt)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `blend_event_id` SET TAGS ('dbx_business_glossary_term' = 'Blend Event Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `blending_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Blend Recipe Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Blend Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `tank_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Blend Tank Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Target Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `unit_run_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Run Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `blend_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Blend Duration in Minutes');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `blend_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Blend End Date and Time');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `blend_loss_bbl` SET TAGS ('dbx_business_glossary_term' = 'Blend Loss Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `blend_mode` SET TAGS ('dbx_business_glossary_term' = 'Blend Control Mode');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `blend_mode` SET TAGS ('dbx_value_regex' = 'automatic|manual|semi_automatic');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `blend_notes` SET TAGS ('dbx_business_glossary_term' = 'Blend Operation Notes');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `blend_number` SET TAGS ('dbx_business_glossary_term' = 'Blend Operation Number');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `blend_number` SET TAGS ('dbx_value_regex' = '^BLD-[0-9]{8}-[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `blend_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Blend Start Date and Time');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `blend_status` SET TAGS ('dbx_business_glossary_term' = 'Blend Event Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `blend_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|aborted|on_hold|quality_hold');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `blend_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Blend Temperature in Fahrenheit (F)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `blend_type` SET TAGS ('dbx_business_glossary_term' = 'Blend Operation Type');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `blend_type` SET TAGS ('dbx_value_regex' = 'inline|batch|ratio|sequential');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `component_count` SET TAGS ('dbx_business_glossary_term' = 'Component Count');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `dcs_batch_code` SET TAGS ('dbx_business_glossary_term' = 'Distributed Control System (DCS) Batch Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `epa_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Compliance Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `measured_api_gravity` SET TAGS ('dbx_business_glossary_term' = 'Measured American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `measured_flash_point_f` SET TAGS ('dbx_business_glossary_term' = 'Measured Flash Point in Fahrenheit (F)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `measured_mon` SET TAGS ('dbx_business_glossary_term' = 'Measured Motor Octane Number (MON)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `measured_ron` SET TAGS ('dbx_business_glossary_term' = 'Measured Research Octane Number (RON)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `measured_rvp_psi` SET TAGS ('dbx_business_glossary_term' = 'Measured Reid Vapor Pressure (RVP) in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `measured_sulfur_ppm` SET TAGS ('dbx_business_glossary_term' = 'Measured Sulfur Content in Parts Per Million (PPM)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `measured_tan` SET TAGS ('dbx_business_glossary_term' = 'Measured Total Acid Number (TAN)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `measured_viscosity_cst` SET TAGS ('dbx_business_glossary_term' = 'Measured Viscosity in Centistokes (cSt)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `operator_signoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Operator Sign-Off Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `planned_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Planned Blend Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `product_release_status` SET TAGS ('dbx_business_glossary_term' = 'Product Release Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `product_release_status` SET TAGS ('dbx_value_regex' = 'released|held|rejected|conditional');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `quality_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Compliance Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `quality_compliance_status` SET TAGS ('dbx_value_regex' = 'on_spec|off_spec|pending_test|conditional_release');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `quality_test_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Test Completion Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `release_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Product Release Certificate Number');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `supervisor_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Approval Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `target_ron` SET TAGS ('dbx_business_glossary_term' = 'Target Research Octane Number (RON)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `total_blend_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Total Blend Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` SET TAGS ('dbx_subdomain' = 'refinery_operations');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `tank_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Tank Inventory ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `blend_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Blend Recipe ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `release_report_id` SET TAGS ('dbx_business_glossary_term' = 'Release Report Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,25}$');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `closing_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Closing Volume (Barrels)');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `custody_transfer_flag` SET TAGS ('dbx_business_glossary_term' = 'Custody Transfer Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'OSIsoft PI|DCS|SCADA|Manual Entry|ATG System');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `deliveries_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Deliveries Volume (Barrels)');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `fill_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fill Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `free_water_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Free Water Volume (Barrels)');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `gauge_method` SET TAGS ('dbx_business_glossary_term' = 'Gauge Method');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `gauge_method` SET TAGS ('dbx_value_regex' = 'ATG|Manual Dip|Radar|Servo|Hybrid');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `gross_observed_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Gross Observed Volume (Barrels)');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `loss_gain_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Loss or Gain Volume (Barrels)');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `measurement_uncertainty_bbl` SET TAGS ('dbx_business_glossary_term' = 'Measurement Uncertainty (Barrels)');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `net_standard_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Net Standard Volume (Barrels)');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `observed_density_api` SET TAGS ('dbx_business_glossary_term' = 'Observed Density (API Gravity)');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `observed_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Observed Temperature (Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `opening_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Opening Volume (Barrels)');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `quality_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `receipts_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Receipts Volume (Barrels)');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `ron_value` SET TAGS ('dbx_business_glossary_term' = 'Research Octane Number (RON) Value');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `standard_density_api` SET TAGS ('dbx_business_glossary_term' = 'Standard Density (API Gravity at 60°F)');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `sulfur_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `tan_value` SET TAGS ('dbx_business_glossary_term' = 'Total Acid Number (TAN) Value');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `tank_capacity_bbl` SET TAGS ('dbx_business_glossary_term' = 'Tank Capacity (Barrels)');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `tank_gauge_height_ft` SET TAGS ('dbx_business_glossary_term' = 'Tank Gauge Height (Feet)');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `tank_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tank Identifier');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `tank_identifier` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `tank_operational_status` SET TAGS ('dbx_business_glossary_term' = 'Tank Operational Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `tank_operational_status` SET TAGS ('dbx_value_regex' = 'In Service|Out of Service|Filling|Draining|Maintenance|Inspection');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `vapor_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Vapor Pressure (PSI)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` SET TAGS ('dbx_subdomain' = 'asset_integrity');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `turnaround_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `contractor_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `emergency_drill_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Drill Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Audit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `integrity_program_id` SET TAGS ('dbx_business_glossary_term' = 'Integrity Program Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `venture_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `actual_capex_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Capital Expenditure (CAPEX) (USD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `actual_capex_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `actual_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration (Days)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `actual_opex_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Operating Expenditure (OPEX) (USD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `actual_opex_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `affected_units` SET TAGS ('dbx_business_glossary_term' = 'Affected Process Units');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `capex_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Budget (USD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `capex_budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `contractor_mobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Contractor Mobilization Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `hse_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Incident Count');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `inspection_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Inspection Findings Summary');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `lessons_learned_summary` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned Summary');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `opex_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Budget (USD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `opex_budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `permit_to_work_count` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Count');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `planned_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Duration (Days)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `post_turnaround_performance_notes` SET TAGS ('dbx_business_glossary_term' = 'Post-Turnaround Performance Notes');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `production_deferral_boe` SET TAGS ('dbx_business_glossary_term' = 'Production Deferral (Barrel of Oil Equivalent - BOE)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `production_deferral_boe` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `project_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Name');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `regulatory_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `safety_case_reference` SET TAGS ('dbx_business_glossary_term' = 'Safety Case Reference');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `scope_summary` SET TAGS ('dbx_business_glossary_term' = 'Scope of Work Summary');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `startup_date` SET TAGS ('dbx_business_glossary_term' = 'Unit Startup Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `total_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Labor Hours');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `turnaround_code` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Code');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `turnaround_name` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Name');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `turnaround_status` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `turnaround_type` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Type');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `turnaround_type` SET TAGS ('dbx_value_regex' = 'major|minor|catalyst_change|inspection|emergency');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `work_order_count` SET TAGS ('dbx_business_glossary_term' = 'Work Order Count');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` SET TAGS ('dbx_subdomain' = 'asset_integrity');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `turnaround_work_item_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Work Item Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `compliance_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `contractor_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `predecessor_work_item_turnaround_work_item_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Work Item Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `turnaround_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `actual_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Hours');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `craft_type` SET TAGS ('dbx_business_glossary_term' = 'Craft Type Classification');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `hse_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Incident Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `inspection_findings` SET TAGS ('dbx_business_glossary_term' = 'Inspection Findings Summary');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result Classification');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|not_applicable');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `material_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Material Cost in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `material_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Work Item Notes');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `quality_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `responsible_supervisor` SET TAGS ('dbx_business_glossary_term' = 'Responsible Supervisor Name');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `safety_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Permit to Work (PTW) Number');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `scope_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Scope Change Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `scope_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Scope Change Reason Description');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `work_item_description` SET TAGS ('dbx_business_glossary_term' = 'Work Item Description');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `work_package_code` SET TAGS ('dbx_business_glossary_term' = 'Work Package Code');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `work_priority` SET TAGS ('dbx_business_glossary_term' = 'Work Priority Level');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `work_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `work_status` SET TAGS ('dbx_business_glossary_term' = 'Work Item Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `work_status` SET TAGS ('dbx_value_regex' = 'planned|approved|in_progress|on_hold|completed|cancelled');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `work_type` SET TAGS ('dbx_business_glossary_term' = 'Work Type Classification');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` SET TAGS ('dbx_subdomain' = 'refinery_operations');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `energy_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `benchmark_category` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Category');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `benchmark_category` SET TAGS ('dbx_value_regex' = 'simple|moderate|complex|very_complex');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `compliance_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reporting Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `cooling_water_usage_m3` SET TAGS ('dbx_business_glossary_term' = 'Cooling Water Usage Cubic Meters (m³)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `crude_throughput_bpd` SET TAGS ('dbx_business_glossary_term' = 'Crude Throughput Barrels per Day (BPD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'verified|estimated|suspect|missing');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `electricity_consumption_mwh` SET TAGS ('dbx_business_glossary_term' = 'Electricity Consumption Megawatt Hours (MWh)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `energy_efficiency_index` SET TAGS ('dbx_business_glossary_term' = 'Energy Efficiency Index (EEI)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `energy_intensity_mmbtu_per_bbl` SET TAGS ('dbx_business_glossary_term' = 'Energy Intensity Million British Thermal Units per Barrel (MMBtu/bbl)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `energy_source_type` SET TAGS ('dbx_business_glossary_term' = 'Energy Source Type');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `energy_source_type` SET TAGS ('dbx_value_regex' = 'fuel_gas|steam|electricity|hydrogen|cooling_water|mixed');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `fuel_gas_consumption_mmscfd` SET TAGS ('dbx_business_glossary_term' = 'Fuel Gas Consumption Million Standard Cubic Feet per Day (MMSCFD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `ghg_emissions_co2e_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emissions Carbon Dioxide Equivalent Tonnes (CO2e)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `hydrogen_consumption_mmscfd` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Consumption Million Standard Cubic Feet per Day (MMSCFD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `hydrogen_export_mmscfd` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Export Million Standard Cubic Feet per Day (MMSCFD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `hydrogen_import_mmscfd` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Import Million Standard Cubic Feet per Day (MMSCFD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `hydrogen_network_pressure_psig` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Network Pressure Pounds per Square Inch Gauge (psig)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `hydrogen_production_mmscfd` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Production Million Standard Cubic Feet per Day (MMSCFD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `hydrogen_purity_percent` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Purity Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `hydrogen_source` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Source');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `hydrogen_source` SET TAGS ('dbx_value_regex' = 'reformer|smr|purification|import|mixed');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `hydrogen_surplus_deficit_mmscfd` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Surplus or Deficit Million Standard Cubic Feet per Day (MMSCFD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'direct_meter|calculated|estimated|allocated');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'normal_operation|startup|shutdown|turnaround|reduced_rate|emergency');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `steam_consumption_klb_per_hr` SET TAGS ('dbx_business_glossary_term' = 'Steam Consumption Thousand Pounds per Hour (klb/hr)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `steam_pressure_level` SET TAGS ('dbx_business_glossary_term' = 'Steam Pressure Level');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `steam_pressure_level` SET TAGS ('dbx_value_regex' = 'low_pressure|medium_pressure|high_pressure|mixed');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `total_energy_consumption_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Total Energy Consumption Million British Thermal Units (MMBtu)');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` SET TAGS ('dbx_subdomain' = 'refinery_operations');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `hydrogen_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Balance ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `balance_date` SET TAGS ('dbx_business_glossary_term' = 'Balance Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `balance_period_end` SET TAGS ('dbx_business_glossary_term' = 'Balance Period End Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `balance_period_start` SET TAGS ('dbx_business_glossary_term' = 'Balance Period Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `balance_reconciliation_notes` SET TAGS ('dbx_business_glossary_term' = 'Balance Reconciliation Notes');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_business_glossary_term' = 'Balance Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|revised|cancelled');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `balance_variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Balance Variance Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `dcs_system_source` SET TAGS ('dbx_business_glossary_term' = 'Distributed Control System (DCS) Source');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `hydrogen_consumption_hds_volume` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Consumption Hydrodesulfurization (HDS) Volume');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `hydrogen_consumption_hydrocracker_volume` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Consumption Hydrocracker Volume');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `hydrogen_consumption_isomerization_volume` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Consumption Isomerization Volume');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `hydrogen_consumption_other_volume` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Consumption Other Units Volume');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `hydrogen_consumption_total_volume` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Consumption Total Volume');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `hydrogen_export_volume` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Export Volume');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `hydrogen_import_volume` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Import Volume');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `hydrogen_production_other_volume` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Production Other Sources Volume');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `hydrogen_production_reformer_volume` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Production Reformer Volume');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `hydrogen_production_smr_volume` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Production Steam Methane Reformer (SMR) Volume');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `hydrogen_production_total_volume` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Production Total Volume');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `hydrogen_purity_import_percent` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Purity Import Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `hydrogen_purity_reformer_percent` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Purity Reformer Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `hydrogen_purity_smr_percent` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Purity Steam Methane Reformer (SMR) Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `hydrogen_surplus_deficit_volume` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Surplus or Deficit Volume');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `network_pressure_average_psi` SET TAGS ('dbx_business_glossary_term' = 'Network Pressure Average Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `network_pressure_max_psi` SET TAGS ('dbx_business_glossary_term' = 'Network Pressure Maximum Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `network_pressure_min_psi` SET TAGS ('dbx_business_glossary_term' = 'Network Pressure Minimum Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `pressure_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Pressure Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `pressure_unit_of_measure` SET TAGS ('dbx_value_regex' = 'PSI|bar|kPa|MPa');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `process_simulation_model` SET TAGS ('dbx_business_glossary_term' = 'Process Simulation Model');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_value_regex' = 'SCF|MSCF|MMSCF|m3|Nm3');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` SET TAGS ('dbx_subdomain' = 'refinery_operations');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `process_alarm_id` SET TAGS ('dbx_business_glossary_term' = 'Process Alarm Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `moc_request_id` SET TAGS ('dbx_business_glossary_term' = 'Moc Request Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `acknowledged_by_operator` SET TAGS ('dbx_business_glossary_term' = 'Acknowledging Operator Name');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alarm Acknowledgment Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Process Value');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `alarm_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Alarm Duration in Seconds');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `alarm_group` SET TAGS ('dbx_business_glossary_term' = 'Alarm Group Classification');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `alarm_message` SET TAGS ('dbx_business_glossary_term' = 'Alarm Message Text');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `alarm_priority` SET TAGS ('dbx_business_glossary_term' = 'Alarm Priority Level');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `alarm_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `alarm_state` SET TAGS ('dbx_business_glossary_term' = 'Alarm State Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `alarm_state` SET TAGS ('dbx_value_regex' = 'active|acknowledged|cleared|suppressed|shelved|out-of-service');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `alarm_tag` SET TAGS ('dbx_business_glossary_term' = 'Alarm Tag Identifier');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `alarm_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alarm Occurrence Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `alarm_type` SET TAGS ('dbx_business_glossary_term' = 'Alarm Type Classification');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `cleared_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alarm Cleared Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `dcs_system_name` SET TAGS ('dbx_business_glossary_term' = 'Distributed Control System (DCS) Name');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `deviation_value` SET TAGS ('dbx_business_glossary_term' = 'Deviation from Setpoint Value');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `is_environmental_alarm` SET TAGS ('dbx_business_glossary_term' = 'Environmental Alarm Indicator');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `is_nuisance_alarm` SET TAGS ('dbx_business_glossary_term' = 'Nuisance Alarm Indicator');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `is_safety_critical` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical Alarm Indicator');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `is_shelved` SET TAGS ('dbx_business_glossary_term' = 'Alarm Shelved Indicator');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `last_rationalized_date` SET TAGS ('dbx_business_glossary_term' = 'Last Rationalization Review Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `operator_notes` SET TAGS ('dbx_business_glossary_term' = 'Operator Notes');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `pi_point_name` SET TAGS ('dbx_business_glossary_term' = 'Plant Information (PI) System Point Name');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `process_variable` SET TAGS ('dbx_business_glossary_term' = 'Process Variable Name');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `rationalization_status` SET TAGS ('dbx_business_glossary_term' = 'Alarm Rationalization Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `rationalization_status` SET TAGS ('dbx_value_regex' = 'approved|under-review|pending-modification|pending-removal|archived');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `response_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Operator Response Time in Seconds');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category Classification');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `setpoint_value` SET TAGS ('dbx_business_glossary_term' = 'Alarm Setpoint Value');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `shelved_by_operator` SET TAGS ('dbx_business_glossary_term' = 'Shelving Operator Name');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `shelved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alarm Shelved Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `shelving_reason` SET TAGS ('dbx_business_glossary_term' = 'Alarm Shelving Reason');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` SET TAGS ('dbx_subdomain' = 'supply_management');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `crude_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Receipt ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `blend_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Blend Recipe ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `custody_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Custody Transfer Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Inspector ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `product_quality_test_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Test ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `rail_waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Rail Waybill Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Source Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Source Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Source Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `spill_event_id` SET TAGS ('dbx_business_glossary_term' = 'Spill Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `spot_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Trade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `tank_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Tank ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `tertiary_crude_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `tertiary_crude_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `tertiary_crude_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `truck_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Truck Ticket Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `bsw_percent` SET TAGS ('dbx_business_glossary_term' = 'Basic Sediment and Water (BS&W) Percent');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `gross_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Gross Volume Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `loss_in_transit_bbl` SET TAGS ('dbx_business_glossary_term' = 'Loss in Transit Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `net_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Net Volume Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `origin_type` SET TAGS ('dbx_business_glossary_term' = 'Origin Type');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `origin_type` SET TAGS ('dbx_value_regex' = 'field|terminal|pipeline|vessel|rail|truck');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `price_basis` SET TAGS ('dbx_business_glossary_term' = 'Price Basis');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `price_differential_usd_per_bbl` SET TAGS ('dbx_business_glossary_term' = 'Price Differential United States Dollars (USD) per Barrel (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `price_differential_usd_per_bbl` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `quality_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Compliance Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `quality_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|conditional_acceptance');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_value_regex' = '^RCP-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'draft|confirmed|reconciled|disputed|closed');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `sulfur_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percent');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `tan_mg_koh_per_g` SET TAGS ('dbx_business_glossary_term' = 'Total Acid Number (TAN) Milligrams Potassium Hydroxide (KOH) per Gram');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `target_process_unit` SET TAGS ('dbx_business_glossary_term' = 'Target Process Unit');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `target_process_unit` SET TAGS ('dbx_value_regex' = 'CDU|VDU|FCC|HDS|Coker|Hydrocracker');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature Fahrenheit');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `total_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Cost United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `total_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_value_regex' = 'pipeline|vessel|rail|truck|barge');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` SET TAGS ('dbx_subdomain' = 'refinery_operations');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `product_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Product Movement Identifier');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `blend_event_id` SET TAGS ('dbx_business_glossary_term' = 'Blend Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Terminal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `pipeline_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Batch Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `refinery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Schedule Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `spill_event_id` SET TAGS ('dbx_business_glossary_term' = 'Spill Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `truck_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Truck Ticket Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `actual_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date and Time');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `actual_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date and Time');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'API Gravity');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `custody_transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Custody Transfer Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `custody_transfer_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|disputed|reconciled');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `destination_location_description` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Description');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `gross_volume` SET TAGS ('dbx_business_glossary_term' = 'Gross Volume');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `inspection_company` SET TAGS ('dbx_business_glossary_term' = 'Inspection Company');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `loading_rate_bph` SET TAGS ('dbx_business_glossary_term' = 'Loading Rate in Barrels Per Hour (BPH)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `meter_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Meter Ticket Number');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `movement_datetime` SET TAGS ('dbx_business_glossary_term' = 'Movement Date and Time');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `movement_number` SET TAGS ('dbx_business_glossary_term' = 'Movement Transaction Number');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `movement_status` SET TAGS ('dbx_business_glossary_term' = 'Movement Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `movement_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|cancelled|reconciled');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = 'receipt|dispatch|transfer|injection|withdrawal');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `net_volume` SET TAGS ('dbx_business_glossary_term' = 'Net Volume');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `quality_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Certificate Number');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `scheduled_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date and Time');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature in Celsius');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `transfer_mode` SET TAGS ('dbx_business_glossary_term' = 'Transfer Mode');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `transfer_mode` SET TAGS ('dbx_value_regex' = 'pipeline|truck|rail|marine|barge|inter_tank');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `variance_barrels` SET TAGS ('dbx_business_glossary_term' = 'Variance in Barrels');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `volume_barrels` SET TAGS ('dbx_business_glossary_term' = 'Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `volume_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Volume in Metric Tons (MT)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `superseded_by_specification_product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Specification Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `api_gravity_max` SET TAGS ('dbx_business_glossary_term' = 'API Gravity Maximum');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `api_gravity_min` SET TAGS ('dbx_business_glossary_term' = 'API Gravity Minimum');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `applicable_standard` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standard');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `aromatics_max_vol_pct` SET TAGS ('dbx_business_glossary_term' = 'Aromatic Content Maximum (Volume Percent)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `benzene_max_vol_pct` SET TAGS ('dbx_business_glossary_term' = 'Benzene Content Maximum (Volume Percent)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `cetane_index_min` SET TAGS ('dbx_business_glossary_term' = 'Cetane Index Minimum');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `cetane_number_min` SET TAGS ('dbx_business_glossary_term' = 'Cetane Number Minimum');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `cloud_point_max_c` SET TAGS ('dbx_business_glossary_term' = 'Cloud Point Maximum (Celsius)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `copper_strip_corrosion_max` SET TAGS ('dbx_business_glossary_term' = 'Copper Strip Corrosion Maximum Rating');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `copper_strip_corrosion_max` SET TAGS ('dbx_value_regex' = '1a|1b|2a|2b|3a|3b');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `density_max_kg_m3` SET TAGS ('dbx_business_glossary_term' = 'Density Maximum (Kilograms per Cubic Meter)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `density_min_kg_m3` SET TAGS ('dbx_business_glossary_term' = 'Density Minimum (Kilograms per Cubic Meter)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `distillation_fbp_max_c` SET TAGS ('dbx_business_glossary_term' = 'Distillation Final Boiling Point (FBP) Maximum (Celsius)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `distillation_t10_max_c` SET TAGS ('dbx_business_glossary_term' = 'Distillation Temperature 10% Recovered Maximum (Celsius)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `distillation_t50_max_c` SET TAGS ('dbx_business_glossary_term' = 'Distillation Temperature 50% Recovered Maximum (Celsius)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `distillation_t90_max_c` SET TAGS ('dbx_business_glossary_term' = 'Distillation Temperature 90% Recovered Maximum (Celsius)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `ethanol_max_vol_pct` SET TAGS ('dbx_business_glossary_term' = 'Ethanol Content Maximum (Volume Percent)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `flash_point_min_c` SET TAGS ('dbx_business_glossary_term' = 'Flash Point Minimum (Celsius)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `freeze_point_max_c` SET TAGS ('dbx_business_glossary_term' = 'Freeze Point Maximum (Celsius)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `lubricity_max_microns` SET TAGS ('dbx_business_glossary_term' = 'Lubricity Maximum Wear Scar Diameter (Microns)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `mon_min` SET TAGS ('dbx_business_glossary_term' = 'Motor Octane Number (MON) Minimum');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `olefins_max_vol_pct` SET TAGS ('dbx_business_glossary_term' = 'Olefin Content Maximum (Volume Percent)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `oxygen_max_wt_pct` SET TAGS ('dbx_business_glossary_term' = 'Oxygen Content Maximum (Weight Percent)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `particulate_max_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Particulate Matter Maximum (Milligrams per Liter)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `pour_point_max_c` SET TAGS ('dbx_business_glossary_term' = 'Pour Point Maximum (Celsius)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'finished_product|intermediate_stream|blendstock|feedstock');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `product_grade` SET TAGS ('dbx_business_glossary_term' = 'Product Grade');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `ron_min` SET TAGS ('dbx_business_glossary_term' = 'Research Octane Number (RON) Minimum');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `rvp_max_psi` SET TAGS ('dbx_business_glossary_term' = 'Reid Vapor Pressure (RVP) Maximum (Pounds per Square Inch)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `specification_name` SET TAGS ('dbx_business_glossary_term' = 'Specification Name');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `specification_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Number');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `specification_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|superseded|pending_approval');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `sulfur_max_ppm` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Maximum (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `tan_max_mg_koh_per_g` SET TAGS ('dbx_business_glossary_term' = 'Total Acid Number (TAN) Maximum (Milligrams Potassium Hydroxide per Gram)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Version Number');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `viscosity_max_cst` SET TAGS ('dbx_business_glossary_term' = 'Kinematic Viscosity Maximum (Centistokes)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `viscosity_min_cst` SET TAGS ('dbx_business_glossary_term' = 'Kinematic Viscosity Minimum (Centistokes)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `water_content_max_ppm` SET TAGS ('dbx_business_glossary_term' = 'Water Content Maximum (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` SET TAGS ('dbx_subdomain' = 'asset_integrity');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `catalyst_lifecycle_id` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Lifecycle Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `turnaround_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `waste_manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Manifest Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `previous_catalyst_lifecycle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `activity_measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Activity Measurement Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `actual_replacement_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Replacement Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `addition_withdrawal_count` SET TAGS ('dbx_business_glossary_term' = 'Addition and Withdrawal Event Count');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `catalyst_age_days` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Age in Days');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `catalyst_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Batch Number');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `catalyst_grade` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Grade');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `catalyst_type` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Type');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `coke_content_wt_pct` SET TAGS ('dbx_business_glossary_term' = 'Coke Content Weight Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `cumulative_throughput_bbl` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Throughput in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `current_activity_level` SET TAGS ('dbx_business_glossary_term' = 'Current Activity Level Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `current_mass` SET TAGS ('dbx_business_glossary_term' = 'Current Catalyst Mass');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `current_volume` SET TAGS ('dbx_business_glossary_term' = 'Current Catalyst Volume');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Spent Catalyst Disposal Method');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'reclamation|landfill|incineration|recycling|vendor_return');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `disposal_vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Disposal Vendor Name');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `expected_service_life_days` SET TAGS ('dbx_business_glossary_term' = 'Expected Service Life in Days');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `initial_load_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Load Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `initial_load_mass` SET TAGS ('dbx_business_glossary_term' = 'Initial Load Mass');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `initial_load_volume` SET TAGS ('dbx_business_glossary_term' = 'Initial Load Volume');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `last_addition_date` SET TAGS ('dbx_business_glossary_term' = 'Last Addition Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `last_addition_volume` SET TAGS ('dbx_business_glossary_term' = 'Last Addition Volume');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `last_regeneration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Regeneration Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `last_withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Withdrawal Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `last_withdrawal_volume` SET TAGS ('dbx_business_glossary_term' = 'Last Withdrawal Volume');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Lifecycle Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|regenerating|scheduled_replacement|replaced|disposed');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `manufacturer_product_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Product Code');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `mass_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Mass Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `mass_unit_of_measure` SET TAGS ('dbx_value_regex' = 'pounds|kilograms|metric_tons');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `metals_content_analysis` SET TAGS ('dbx_business_glossary_term' = 'Metals Content Analysis');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `next_regeneration_date` SET TAGS ('dbx_business_glossary_term' = 'Next Planned Regeneration Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `performance_notes` SET TAGS ('dbx_business_glossary_term' = 'Performance Notes');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `planned_replacement_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Replacement Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `procurement_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Procurement Cost in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `procurement_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `regeneration_count` SET TAGS ('dbx_business_glossary_term' = 'Regeneration Count');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `surface_area_m2_per_g` SET TAGS ('dbx_business_glossary_term' = 'Surface Area in Square Meters per Gram (m²/g)');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_value_regex' = 'cubic_feet|cubic_meters|liters');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`supply_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`supply_agreement` SET TAGS ('dbx_subdomain' = 'supply_management');
ALTER TABLE `oil_gas_ecm`.`refining`.`supply_agreement` SET TAGS ('dbx_association_edges' = 'refining.refinery,petrochemical.plant');
ALTER TABLE `oil_gas_ecm`.`refining`.`supply_agreement` ALTER COLUMN `supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement Identifier');
ALTER TABLE `oil_gas_ecm`.`refining`.`supply_agreement` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement - Petchem Plant Id');
ALTER TABLE `oil_gas_ecm`.`refining`.`supply_agreement` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Reference');
ALTER TABLE `oil_gas_ecm`.`refining`.`supply_agreement` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement - Refinery Id');
ALTER TABLE `oil_gas_ecm`.`refining`.`supply_agreement` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`supply_agreement` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`supply_agreement` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`supply_agreement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`supply_agreement` ALTER COLUMN `delivery_point` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point');
ALTER TABLE `oil_gas_ecm`.`refining`.`supply_agreement` ALTER COLUMN `feedstock_type` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Type');
ALTER TABLE `oil_gas_ecm`.`refining`.`supply_agreement` ALTER COLUMN `force_majeure_clause` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Clause');
ALTER TABLE `oil_gas_ecm`.`refining`.`supply_agreement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`supply_agreement` ALTER COLUMN `minimum_offtake_obligation` SET TAGS ('dbx_business_glossary_term' = 'Minimum Offtake Obligation');
ALTER TABLE `oil_gas_ecm`.`refining`.`supply_agreement` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis');
ALTER TABLE `oil_gas_ecm`.`refining`.`supply_agreement` ALTER COLUMN `volume_contracted_bpd` SET TAGS ('dbx_business_glossary_term' = 'Contracted Volume');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_interest` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_interest` SET TAGS ('dbx_subdomain' = 'supply_management');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_interest` SET TAGS ('dbx_association_edges' = 'refining.refinery,venture.partner');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_interest` ALTER COLUMN `refinery_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Interest Identifier');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_interest` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Interest - Refinery Id');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_interest` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Interest - Venture Partner Id');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_interest` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_interest` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_interest` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Interest Effective Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_interest` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Interest Expiry Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_interest` ALTER COLUMN `interest_status` SET TAGS ('dbx_business_glossary_term' = 'Interest Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_interest` ALTER COLUMN `joa_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement Number');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_interest` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_interest` ALTER COLUMN `net_revenue_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_interest` ALTER COLUMN `operator_flag` SET TAGS ('dbx_business_glossary_term' = 'Operator Designation');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_interest` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`sample` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `oil_gas_ecm`.`refining`.`sample` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identifier');
ALTER TABLE `oil_gas_ecm`.`refining`.`sample` ALTER COLUMN `parent_sample_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`aspen_hysys_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`aspen_hysys_model` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `oil_gas_ecm`.`refining`.`aspen_hysys_model` ALTER COLUMN `aspen_hysys_model_id` SET TAGS ('dbx_business_glossary_term' = 'Aspen Hysys Model Identifier');
ALTER TABLE `oil_gas_ecm`.`refining`.`aspen_hysys_model` ALTER COLUMN `parent_aspen_hysys_model_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`aspen_hysys_simulation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`aspen_hysys_simulation` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `oil_gas_ecm`.`refining`.`aspen_hysys_simulation` ALTER COLUMN `aspen_hysys_simulation_id` SET TAGS ('dbx_business_glossary_term' = 'Aspen Hysys Simulation Identifier');
ALTER TABLE `oil_gas_ecm`.`refining`.`aspen_hysys_simulation` ALTER COLUMN `parent_aspen_hysys_simulation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`aspen_simulation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`aspen_simulation` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `oil_gas_ecm`.`refining`.`aspen_simulation` ALTER COLUMN `aspen_simulation_id` SET TAGS ('dbx_business_glossary_term' = 'Aspen Simulation Identifier');
ALTER TABLE `oil_gas_ecm`.`refining`.`aspen_simulation` ALTER COLUMN `parent_aspen_simulation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`aspen_simulation` ALTER COLUMN `author_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`aspen_simulation` ALTER COLUMN `author_email` SET TAGS ('dbx_pii_email' = 'true');
