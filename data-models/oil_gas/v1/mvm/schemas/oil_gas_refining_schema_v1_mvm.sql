-- Schema for Domain: refining | Business: Oil Gas | Version: v1_mvm
-- Generated on: 2026-05-04 09:29:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`refining` COMMENT 'Manages crude oil refining operations including CDU/VDU throughput, FCC unit performance, HDS operations, yield optimization, TAN and RON quality metrics, refinery scheduling, feedstock blending, and product slate planning. Owns process unit performance data and refinery configuration. Supports EPA emissions compliance and API refining standards. Integrates with Aspen HYSYS process simulation and DCS control systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`refinery` (
    `refinery_id` BIGINT COMMENT 'Unique identifier for the refinery facility. Primary key for the refinery master record.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Refinery master table must link to corporate asset register for asset management integration. Real business process: refinery-level asset tracking, depreciation calculation, asset retirement obligatio',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_certification. Business justification: Refineries hold facility-level compliance certifications (ISO 14001, OSHA VPP, API Q1, SEMS). Compliance teams track certification status, renewal dates, and audit cycles at the refinery level. Domain',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: A refinery is a fixed asset in the finance system with associated depreciation, impairment testing, and asset retirement obligations. The refinery-to-fixed-asset link is required for facility-level im',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Refineries operated under joint operating agreements require JOA linkage for partner cost allocation, overhead rate application, AFE approval thresholds, and JIB billing. JOA terms govern operational ',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Refineries require operating licenses from state/federal authorities authorizing petroleum refining operations. This is the master regulatory authorization that governs facility operations, distinct f',
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
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Process units in JV refineries need JOA linkage for unit-level capital project approvals, turnaround AFE authorization, and partner cost sharing. JOA voting thresholds apply to major unit modification',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Process units in PSA-operated refineries process PSA-sourced crude; unit-level throughput and yield data feed directly into PSA cost recovery and profit oil calculations. Linking process_unit to PSA e',
    `refinery_id` BIGINT COMMENT 'FK to refining.refinery.refinery_id — MUST-HAVE: Enables linking process units to their parent refinery for capacity planning, turnaround scheduling, and yield optimization. Fundamental parent-child relationship.',
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
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Crude assays are conducted by specialized external laboratories (Core Laboratories, Intertek). crude_assay.assay_laboratory is a denormalized vendor reference. A proper FK enables laboratory vendor qu',
    `crude_grade_id` BIGINT COMMENT 'Reference to the crude oil grade that this assay characterizes. Links to the crude grade master in the product domain.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Crude assays are routinely performed on lease-specific crude to characterize feedstock quality for refinery planning, crude valuation, and blend optimization. Lease-level assay traceability is standar',
    `pvt_analysis_id` BIGINT COMMENT 'Foreign key linking to reservoir.pvt_analysis. Business justification: Crude assay and PVT analysis are complementary fluid characterization studies on the same reservoir fluid. Refiners correlate assay distillation data with upstream PVT (GOR, shrinkage, bubble point) f',
    `refinery_id` BIGINT COMMENT 'Foreign key linking to refining.refinery. Business justification: A crude assay is conducted for a specific refinerys feedstock planning and CDU optimization. Linking crude_assay to refinery enables refinery-specific assay libraries and supports crude selection dec',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Crude assay characterizes fluid properties of crude sourced from a specific reservoir. Refiners use reservoir-linked assays for feedstock planning, crude compatibility studies, and integrated asset mo',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: In commingled or multi-zone production, crude assay properties vary by producing zone. Linking assay to reservoir zone enables zone-specific crude quality tracking, critical for refinery crude slate o',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Drill stem test (DST) samples from a specific drilling_well are sent to labs for crude assay to characterize feedstock before field development. Refiners use well-specific assays for LP optimization a',
    `field_id` BIGINT COMMENT 'Foreign key linking to production.field. Business justification: Field-level crude assays characterize the aggregate crude quality from a production field and are the primary reference used in refinery crude slate planning and blending optimization. Refiners mainta',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: Crude assays are performed on samples taken from specific production wells. Well-specific assay data is used for reservoir characterization, crude quality tracking, and refinery blending optimization.',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity of the crude oil, measured in degrees API. Key indicator of crude density and quality; higher API gravity indicates lighter, more valuable crude. Typical range 10-50 degrees API.',
    `aromatic_content_wt_pct` DECIMAL(18,2) COMMENT 'Aromatic hydrocarbon content of the crude oil, expressed as weight percent (from SARA analysis: Saturates, Aromatics, Resins, Asphaltenes). Aromatic content affects product quality (cetane, smoke point) and processing severity requirements.',
    `asphaltene_content_wt_pct` DECIMAL(18,2) COMMENT 'Asphaltene content of the crude oil, expressed as weight percent. Asphaltenes are heavy, polar molecules that cause fouling, coking, and stability issues. High asphaltene content affects crude compatibility for blending and requires careful processing.',
    `assay_date` DATE COMMENT 'Date when the crude oil sample was assayed or when the assay data was published. Used for assay currency and validity tracking.',
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
    `blending_recipe_id` BIGINT COMMENT 'Foreign key linking to refining.blending_recipe. Business justification: A feedstock blend is executed according to a blending recipe; the FK ties the blend to its recipe for quality and cost analysis.',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Feedstock blends specify crude grade composition for CDU feed optimization. Essential for crude procurement decisions, blend optimization models (Aspen PIMS), quality prediction, and margin analysis. ',
    `nomination_id` BIGINT COMMENT 'Foreign key linking to customer.nomination. Business justification: Feedstock blending decisions are driven by customer nominations specifying crude grade, API gravity, sulfur content, and delivery timing. Links blend optimization to contractual commitments and enable',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Feedstock blending operations are subject to specific regulatory obligations including Renewable Fuel Standard (RFS2) blending requirements and low-carbon fuel standards. Compliance teams track which ',
    `pipeline_nomination_id` BIGINT COMMENT 'Foreign key linking to logistics.pipeline_nomination. Business justification: Feedstock blends may include pipeline-delivered crudes. Nomination tracking, volume confirmation, and crude slate planning require linking blends to pipeline nominations for supply assurance and feeds',
    `process_unit_id` BIGINT COMMENT 'Identifier of the refinery process unit (CDU, VDU, FCC, HDS, or other) that will receive or has received this feedstock blend.',
    `product_specification_id` BIGINT COMMENT 'Foreign key linking to refining.product_specification. Business justification: Feedstock blending strategies must consider downstream product specification constraints (sulfur limits, octane targets, distillation curves) to ensure regulatory compliance. Links crude slate optimiz',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Under PSA regimes, feedstock blend composition determines cost oil vs. profit oil volume attribution. Refinery planners must reference the PSA to correctly allocate cost recovery crude within the blen',
    `pvt_analysis_id` BIGINT COMMENT 'Foreign key linking to reservoir.pvt_analysis. Business justification: PVT analysis (formation volume factor, GOR, shrinkage) directly informs feedstock blend optimization. Blend engineers use upstream PVT data to predict stock-tank volumes and blend behavior. This link ',
    `refinery_schedule_id` BIGINT COMMENT 'Foreign key linking to refining.refinery_schedule. Business justification: A feedstock blend is planned as part of a refinery production schedule. Linking feedstock_blend to refinery_schedule enables schedule-to-blend traceability, supporting LP model validation and schedule',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Feedstock arriving by vessel or truck corresponds to a shipment record. Feedstock quality traceability, crude supply chain reconciliation, and import documentation all require linking the feedstock bl',
    `field_id` BIGINT COMMENT 'Foreign key linking to production.field. Business justification: Feedstock blend optimization requires field-level crude origin tracking. Field-wide crude quality characteristics (API, sulfur, GOR) drive blending decisions and crude slate optimization. feedstock_bl',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Refineries track facility sources for feedstock blends to manage supply contracts, quality specifications, and integrated logistics. Critical for vertically integrated operators coordinating productio',
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
    `asset_facility_id` BIGINT COMMENT 'Reference to the refinery facility where this unit run occurred.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Operating runs generate costs (feedstock, utilities, catalyst, labor) that must be allocated to cost centers for run-level profitability analysis. Enables comparison of actual vs. planned costs and op',
    `equipment_id` BIGINT COMMENT 'Reference to the specific process unit equipment (CDU, VDU, FCC, HDS, etc.) that executed this run.',
    `feedstock_blend_id` BIGINT COMMENT 'Foreign key linking to refining.feedstock_blend. Business justification: A unit_run processes a specific feedstock blend through a CDU, FCC, or HDS unit. Linking unit_run to feedstock_blend is essential for yield accounting — the actual yields (captured in refining_yield_r',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Each unit run targets a primary product output for yield accounting and product costing. Essential for production variance analysis, unit economics calculation, and reconciliation with refinery schedu',
    `process_safety_event_id` BIGINT COMMENT 'Foreign key linking to hse.process_safety_event. Business justification: Process safety events (LOPC, overpressure) occur during unit operations. PSE investigations require operational context from unit runs (feed rates, temperatures, catalyst age) to identify causal facto',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to refining.process_unit. Business justification: unit_run is the transactional record of process unit operational performance. Currently links to equipment via equipment_id, but should also directly reference the process_unit master record. This nor',
    `refinery_schedule_id` BIGINT COMMENT 'Foreign key linking to refining.refinery_schedule. Business justification: A unit_run is executed as part of a planned refinery schedule. Linking unit_run to refinery_schedule enables actual vs. planned throughput variance analysis (throughput_variance_bbl) against the sched',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Unit runs process feedstock from specific production facilities. Tracking source production facility on unit runs enables feedstock quality traceability, yield analysis by crude origin, and supply cha',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.violation. Business justification: Specific unit runs may directly trigger compliance violations (emission exceedances, throughput limit breaches, temperature excursions beyond permit limits). Linking unit_run to violation enables root',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`yield_record` (
    `yield_record_id` BIGINT COMMENT 'Unique identifier for the refining yield record. Primary key for this entity.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key reference to the refinery facility where this yield was recorded.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Yield variances impact cost center performance through LVUF (liquid volume unaccounted for) and mass balance closure. Linking enables variance analysis, loss accounting, and reconciliation between ope',
    `feedstock_blend_id` BIGINT COMMENT 'Foreign key linking to refining.feedstock_blend. Business justification: A refining_yield_record captures actual output volumes for a unit_run, which processes a specific feedstock blend. Linking yield records directly to feedstock_blend enables comparison of actual yields',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Yield records track actual production volumes of specific petroleum products (gasoline, diesel, jet fuel, etc.). Fundamental to production accounting, mass balance reconciliation, SEC reserves reporti',
    `process_unit_id` BIGINT COMMENT 'Foreign key reference to the refinery process unit (CDU, VDU, FCC, HDS, etc.) that generated this yield record.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: PSA yield records are the primary basis for government profit oil split calculations and cost recovery reporting. Regulators and NOCs require yield records traceable to the specific PSA — a mandatory ',
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
    CONSTRAINT pk_yield_record PRIMARY KEY(`yield_record_id`)
) COMMENT 'Detailed yield accounting record for a process unit run, capturing actual output volumes and mass by product cut (LPG, naphtha, kerosene, diesel, gas oil, residue, etc.) against planned yield targets. Includes liquid volume unaccounted for (LVUF), mass balance closure percentage, BOE conversion, and variance to Aspen HYSYS simulation targets. Supports yield optimization, loss accounting, and refinery planning.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`product_quality_test` (
    `product_quality_test_id` BIGINT COMMENT 'Unique identifier for the laboratory quality test record. Primary key for the product quality test entity.',
    `blend_event_id` BIGINT COMMENT 'Foreign key linking to refining.blend_event. Business justification: Quality tests validate blended products. product_quality_test.batch_number (STRING) should be normalized to blend_event_id FK. This allows joining to blend_event to retrieve blend composition, blend r',
    `cargo_nomination_id` BIGINT COMMENT 'Foreign key linking to commercial.cargo_nomination. Business justification: Product quality tests generate Certificates of Quality (COQ) required for cargo nominations. Every cargo lifting requires a COQ tied to the specific nomination. Oil trading domain experts expect quali',
    `equipment_id` BIGINT COMMENT 'Identifier of the analytical instrument used to perform the test (e.g., gas chromatograph, spectrophotometer, viscometer). Enables instrument performance tracking, calibration management, and root cause analysis of anomalous results.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Product quality tests are routinely performed by third-party inspection vendors (SGS, Intertek, Bureau Veritas). Linking to the procurement vendor record enables vendor qualification verification, ins',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Product quality testing fulfills specific regulatory obligations (e.g., ASTM testing required by EPA Tier 3, CARB fuel quality testing, EU fuel quality directive). Linking tests to obligations enables',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Quality tests verify specific petroleum products meet specifications for custody transfer, regulatory compliance (EPA fuel standards), and customer contracts. Essential for product release certificati',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to refining.process_unit. Business justification: product_quality_test.process_unit_code (STRING) should be normalized to process_unit_id FK. This allows joining to process_unit master to retrieve unit_name, unit_type, operational_status, and design ',
    `product_specification_id` BIGINT COMMENT 'Foreign key linking to refining.product_specification. Business justification: Quality tests validate product against specifications. product_quality_test.product_grade (STRING) should be normalized to product_specification_id FK. This allows joining to product_specification to ',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to product.quality_spec. Business justification: Refinery lab tests are conducted against product-level regulatory quality specifications (product.quality_spec). Regulatory compliance reporting and customer product release require tracing each test ',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Quality tests certify cargo specifications for shipments. BOL certification, customer quality claims, and custody transfer validation require linking test results to shipments for product release auth',
    `tank_inventory_id` BIGINT COMMENT 'Foreign key linking to refining.tank_inventory. Business justification: Product quality tests are frequently performed on tank samples to certify product quality before release or transfer. Linking product_quality_test to tank_inventory enables quality certification track',
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
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Refinery production schedules are validated against and derived from annual/quarterly finance budgets. The planned_margin_usd and product volume targets in refinery_schedule must reconcile with financ',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Refinery production schedules are planned to meet term contract commitments. Essential for production planning, crude slate optimization, and ensuring contractual delivery obligations are met.',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Refinery turnarounds and major projects require AFE authorization. Schedule planning must reference the AFE for budget tracking, spend authorization, and variance reporting. Critical for capital proje',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Production schedules in JV refineries must align with JOA work programs, budget constraints, and partner approval requirements. Schedule deviations trigger JOA-mandated variance reporting and may requ',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Refinery production schedules must account for compliance obligations including emission testing windows, reporting deadlines, and regulatory inspection periods. Scheduling teams reference specific ob',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Refinery production schedules are built to fulfill offtake agreement volume and product commitments. Schedulers reference offtake agreements when planning crude slate and product slate. The offtake ag',
    `operating_committee_id` BIGINT COMMENT 'Foreign key linking to venture.operating_committee. Business justification: Major refinery schedule changes — crude slate, capacity, turnaround windows — in JOA-operated refineries require operating committee approval per JOA governance. Linking refinery_schedule to operating',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Refinery production schedules are optimized against customer offtake commitments, term contracts, and lifting schedules tied to specific accounts. Links planned product slate to contractual obligation',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Refinery schedules plan production of specific product slates based on market demand and margin optimization. Essential for LP model runs, commercial planning, crude slate optimization, and financial ',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Refinery production schedules are developed within the context of finance projects (e.g., capacity expansion projects, yield improvement initiatives). Linking schedule to project enables production pl',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Refinery scheduling under PSA contracts must account for domestic market obligation (DMO) volumes and cost recovery crude allocations. The schedule references the PSA to plan DMO-compliant product sla',
    `refinery_id` BIGINT COMMENT 'Foreign key linking to refining.refinery. Business justification: A refinery schedule belongs to a specific refinery; linking schedule to refinery enables schedule‑centric reporting and eliminates redundant refinery identifiers stored elsewhere.',
    `turnaround_id` BIGINT COMMENT 'Foreign key linking to refining.turnaround. Business justification: A refinery schedule must account for planned turnarounds that affect unit availability and throughput capacity. Linking refinery_schedule to turnaround enables schedule planners to directly reference ',
    `activated_timestamp` TIMESTAMP COMMENT 'Date and time when the schedule became the active operational plan. Marks the beginning of schedule execution.',
    `actual_crude_volume_bbl` DECIMAL(18,2) COMMENT 'Actual crude oil throughput volume in barrels achieved during the planning period. Used for planned versus actual variance analysis.',
    `approved_by` STRING COMMENT 'Name or identifier of the refinery manager or planning authority who approved this schedule for execution.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the schedule was formally approved for execution. Marks transition from planning to operational commitment.',
    `corrective_action_plan` STRING COMMENT 'Documented plan for addressing schedule deviations and preventing recurrence, including specific actions, responsibilities, and timelines.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule record was first created in the system. Audit trail for schedule lifecycle tracking.',
    `crude_slate_plan` STRING COMMENT 'Detailed description of the planned crude oil feedstock mix, including crude types, sources, volumes, and blending ratios for the planning period.',
    `deviation_description` STRING COMMENT 'Detailed narrative description of schedule deviations, including specific events, impacts, and contributing factors.',
    `deviation_root_cause_category` STRING COMMENT 'Primary classification of the root cause for schedule deviations. Supports systematic analysis of planning accuracy and operational reliability.. Valid values are `equipment_failure|feedstock_quality|market_demand|maintenance_overrun|operational_constraint|external_factor`',
    `deviation_tracking_enabled` BOOLEAN COMMENT 'Flag indicating whether planned versus actual variance tracking is active for this schedule. Enables performance monitoring and root cause analysis.',
    `diesel_target_volume_bbl` DECIMAL(18,2) COMMENT 'Planned production volume of diesel fuel products in barrels for the planning period. Includes all diesel grades and ultra-low sulfur diesel.',
    `financial_impact_usd` DECIMAL(18,2) COMMENT 'Estimated financial impact in US dollars of schedule deviations on refining margin and operational costs.',
    `fuel_oil_target_volume_bbl` DECIMAL(18,2) COMMENT 'Planned production volume of fuel oil products in barrels for the planning period. Includes residual fuel oil and heavy fuel oil grades.',
    `gasoline_target_volume_bbl` DECIMAL(18,2) COMMENT 'Planned production volume of gasoline products in barrels for the planning period. Includes all gasoline grades and blends.',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`blending_recipe` (
    `blending_recipe_id` BIGINT COMMENT 'Unique identifier for the blending recipe. Primary key for the blending recipe master record and single source of truth (SSOT) for petroleum product blending specifications.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Blending recipes specify additives (octane boosters, cetane improvers, lubricity agents, antioxidants) procured as materials. Real blending operations track material numbers for additive dosing calcul',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Blending recipes are designed for specific blending equipment (inline blenders, tank blending systems) with defined capacity and flow constraints. This link supports equipment capacity planning, PM sc',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Blending recipes must comply with air permit conditions specifying RVP limits, benzene content, and sulfur limits. Refiners reference specific permit conditions when formulating recipes for CARB, EPA ',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to refining.process_unit. Business justification: A blending recipe may be associated with a specific inline blending unit or process unit (the inline_blender_flag on blending_recipe indicates this use case). Linking blending_recipe to process_unit e',
    `product_specification_id` BIGINT COMMENT 'Foreign key linking to refining.product_specification. Business justification: blending_recipe.target_product_grade (STRING) should be normalized to product_specification_id FK. Blending recipes are designed to meet specific product specifications. This allows joining to product',
    `refined_product_id` BIGINT COMMENT 'Foreign key linking to product.refined_product. Business justification: A blending recipe is formulated to produce a specific refined product grade (e.g., 87-octane gasoline, Jet A-1). Recipe management, product approval, and quality assurance workflows require linking th',
    `refinery_id` BIGINT COMMENT 'Foreign key linking to refining.refinery. Business justification: A blending recipe is developed for a specific refinerys product slate and blending infrastructure. Different refineries have different blending capabilities, product specifications, and regulatory re',
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
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Blend events execute on specific blending equipment (inline blenders, additive injection skids). Linking to equipment supports utilization tracking, PM scheduling, and equipment-level quality traceabi',
    `blending_recipe_id` BIGINT COMMENT 'Reference to the blending recipe or formula that was used to guide this blend operation, defining target ratios and component specifications.',
    `cargo_nomination_id` BIGINT COMMENT 'Foreign key linking to commercial.cargo_nomination. Business justification: Blend events are executed to produce product batches meeting a specific cargo nominations quality spec and volume. Refiners blend-to-spec for nominated cargoes — the cargo nomination is the commercia',
    `certificate_of_quality_id` BIGINT COMMENT 'Foreign key linking to product.certificate_of_quality. Business justification: A blend event produces a finished product batch that requires a Certificate of Quality before product release and dispatch. blend_event.release_certificate_number is a denormalized reference. Product ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Blending operations incur costs (component streams, utilities, labor, additives) that must be charged to cost centers. Enables tracking of blending costs and calculation of finished product cost.',
    `product_specification_id` BIGINT COMMENT 'Foreign key linking to refining.product_specification. Business justification: blend_event.target_product_grade (STRING) should be normalized to product_specification_id FK. Blend events target specific product specifications (RON, sulfur, RVP limits). This allows joining to pro',
    `refinery_id` BIGINT COMMENT 'Reference to the refinery facility where this blend operation was executed.',
    `refinery_schedule_id` BIGINT COMMENT 'Foreign key linking to refining.refinery_schedule. Business justification: A blend event is executed as part of a planned refinery production schedule. Linking blend_event to refinery_schedule enables tracking of actual blending operations against the schedules product slat',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: A blend event produces a certified product batch loaded onto a specific shipment. Bill of lading documentation, quality certificate issuance, and cargo nomination confirmation all require linking the ',
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
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Tank inventory is frequently allocated to specific customer accounts for term contract fulfillment, consignment stock management, and product segregation. Customer-allocated inventory tracking is a st',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Tank inventory is allocated to specific sales orders for delivery planning. Critical for order fulfillment, available-to-promise calculations, and logistics scheduling in refined product distribution.',
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
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Turnaround capex and opex are tracked against approved finance budgets. The turnaround.capex_budget_usd and opex_budget_usd fields are denormalized from finance.budget; linking directly enables real-t',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Turnaround costs must be allocated to cost centers for financial reporting and variance analysis. Enables tracking of maintenance spend by organizational unit and comparison to budget.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Turnaround costs are capitalized against specific fixed assets under GAAP/IFRS (ASC 360, IAS 16). Finance requires the turnaround-to-fixed-asset link to determine which costs extend asset useful life ',
    `audit_id` BIGINT COMMENT 'Foreign key linking to hse.audit. Business justification: Major turnarounds require HSE compliance audits for pre-startup safety reviews (PSSR), contractor safety verification, and regulatory closure. Turnaround management systems link audits to turnaround s',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Major turnarounds in JV refineries require JOA partner approval, cost sharing per working interest percentages, and AFE authorization per JOA terms. Non-consent provisions and voting thresholds apply ',
    `operating_committee_id` BIGINT COMMENT 'Foreign key linking to venture.operating_committee. Business justification: JOA-operated refinery turnarounds require operating committee authorization for scope and budget approval. The operating committee vote and approval record must be traceable to the turnaround — a mand',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Turnarounds are major capital projects tracked in finance.project for capex/opex budget management, milestone tracking, and SEC capital expenditure reporting. Finance project managers expect every tur',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Turnaround costs at PSA-operated facilities are subject to PSA cost recovery rules and require NOC/government approval. Linking turnaround to PSA enables cost recovery treatment and AFE approval track',
    `refinery_id` BIGINT COMMENT 'Foreign key linking to refining.refinery. Business justification: A turnaround (TAR) event is always conducted at a specific refinery. This is a critical missing in-domain link — turnaround has asset_facility_id (cross-domain to asset) but no direct refinery_id with',
    `venture_afe_id` BIGINT COMMENT 'Foreign key linking to venture.venture_afe. Business justification: Every major turnaround project requires a venture AFE for partner approval, budget authorization, and cost allocation. AFE tracks partner elections, non-consent positions, and actual costs for JIB bil',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Turnarounds use WBS structures for granular cost tracking by work package, discipline, and phase. Finance requires turnaround.wbs_element_id to post actual costs to the correct WBS node, enabling earn',
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
    `equipment_id` BIGINT COMMENT 'Foreign key reference to the equipment master record in the asset management system.',
    `failure_report_id` BIGINT COMMENT 'Foreign key linking to asset.failure_report. Business justification: Corrective maintenance TAR work items are initiated from failure reports (equipment failures, inspection findings). Linking enables root cause analysis traceability, corrective action closure tracking',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Individual work items within turnarounds may be charged to specific AFEs for granular cost tracking. Enables detailed variance analysis and supports capitalization vs. expense decisions for individual',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Individual turnaround work items (e.g., heat exchanger bundle replacement, vessel re-lining) are capitalized to specific fixed assets. Finance requires work-item-level fixed asset assignment for granu',
    `inspection_event_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_event. Business justification: TAR work items include mandatory RBI and statutory inspection tasks (API 510/570). Linking to inspection_event records findings, remaining life assessments, and corrective actions — required for post-',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Turnaround work items consume specific materials (gaskets, bolts, valves, catalyst, refractory). Real turnaround planning specifies material numbers for bill-of-materials generation, procurement lead ',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to hse.permit_to_work. Business justification: Turnaround work items (inspections, repairs) require permits for hot work, confined space entry, and energy isolation. Work management systems link work items to permits for authorization tracking and',
    `predecessor_work_item_turnaround_work_item_id` BIGINT COMMENT 'Reference to another work item that must be completed before this work item can begin. Used for dependency management and critical path scheduling.',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to refining.process_unit. Business justification: turnaround_work_item.process_unit (STRING) should be normalized to process_unit_id FK. Turnaround work items are scoped to specific process units. This allows joining to process_unit master to retriev',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Individual turnaround work items consume materials and services ordered via specific POs. Real maintenance cost control requires PO linkage per work item for actual-vs-budget tracking, three-way match',
    `turnaround_id` BIGINT COMMENT 'Reference to the parent turnaround event that this work item belongs to. Links to the master turnaround schedule.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Individual turnaround work items map to specific WBS elements for granular cost accumulation and capitalization decisions. Finance requires work-item-level WBS assignment to distinguish capitalizable ',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Turnaround work items are executed via formal work orders in asset management systems (Maximo/SAP PM). This link enables cost roll-up, labor tracking, and permit-to-work management for TAR scope items',
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
    `work_package_code` STRING COMMENT 'Hierarchical work breakdown structure code that groups related work items into packages for planning and execution coordination.',
    `work_priority` STRING COMMENT 'Priority classification indicating the urgency and business criticality of this work item. Critical items may drive the turnaround duration.. Valid values are `critical|high|medium|low`',
    `work_status` STRING COMMENT 'Current lifecycle status of the work item within the turnaround execution. Tracks progression from planning through completion.. Valid values are `planned|approved|in_progress|on_hold|completed|cancelled`',
    `work_type` STRING COMMENT 'Classification of the type of work to be performed during the turnaround. Determines resource requirements and scheduling constraints. [ENUM-REF-CANDIDATE: inspection|repair|replacement|cleaning|catalyst_change|modification|upgrade|testing|calibration — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_turnaround_work_item PRIMARY KEY(`turnaround_work_item_id`)
) COMMENT 'Individual work scope item within a refinery turnaround, capturing work item description, process unit, equipment tag, work type (inspection, repair, replacement, cleaning, catalyst change), estimated and actual labor hours, estimated and actual cost, critical path flag, completion status, and inspection findings. Supports turnaround scope management, cost control, and Maximo work order integration.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`energy_consumption` (
    `energy_consumption_id` BIGINT COMMENT 'Unique identifier for the energy consumption record. Primary key for the energy consumption data product.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the refinery facility where energy consumption is measured.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Energy costs (electricity, fuel gas, steam) are budgeted line items in refinery operating budgets. Linking energy_consumption to finance.budget enables energy cost vs. budget variance reporting, energ',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Refinery utility supply (natural gas, electricity, hydrogen) is governed by long-term supply contracts with fixed pricing and volume commitments. Linking energy_consumption to the supply contract enab',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Energy costs (fuel gas, steam, electricity) must be allocated to cost centers for unit economics and benchmarking. Critical for calculating energy intensity, identifying efficiency opportunities, and ',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Refinery fuel gas is frequently sourced directly from upstream production facilities. Tracking the supplying production facility is required for energy accounting, intercompany transfer pricing, and G',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Energy costs in JV refineries are allocated to partners per JOA working interest percentages and overhead rate methods. Monthly JIB statements include energy consumption costs; JOA linkage enables acc',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Energy and GHG reporting obligations are facility-specific regulatory requirements. Compliance teams link energy consumption records to specific obligations (EPA Part 98, state GHG programs) to confir',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Energy intensity metrics are tracked per primary product type for carbon accounting, efficiency benchmarking, and GHG emissions reporting (Scope 1/2). Essential for EPA GHGRP reporting, carbon intensi',
    `process_unit_id` BIGINT COMMENT 'Reference to the specific process unit (CDU, VDU, FCC, HDS, hydrocracker, reformer, etc.) consuming energy.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Under PSA contracts, refinery energy consumption is a recoverable operating cost that must be attributed to the PSA for cost recovery calculations and government reporting. PSA auditors require energy',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Refinery energy purchases (natural gas, electricity, hydrogen) are executed via purchase orders. Linking energy_consumption records to the procuring PO enables three-way match validation, energy cost ',
    `refinery_id` BIGINT COMMENT 'Foreign key linking to refining.refinery. Business justification: Energy consumption is tracked at both the process unit level and the refinery level. Linking energy_consumption to refinery enables refinery-wide energy intensity reporting (energy_intensity_mmbtu_per',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_filing. Business justification: Energy consumption data is the primary source for GHG regulatory filings (EPA 40 CFR Part 98 mandatory GHG reporting, EU ETS). The compliance_reporting_flag and ghg_emissions_co2e_tonnes attributes co',
    `unit_run_id` BIGINT COMMENT 'Foreign key linking to refining.unit_run. Business justification: Energy consumption records should be traceable to the specific unit run during which the energy was consumed. Linking energy_consumption to unit_run enables per-run energy efficiency analysis (energy_',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`crude_receipt` (
    `crude_receipt_id` BIGINT COMMENT 'Unique identifier for the crude oil receipt transaction. Primary key for the crude receipt record.',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Crude receipts via pipeline must reference the pipeline asset for custody transfer reconciliation and tariff billing. Real business process: crude oil delivered via pipeline requires tracking which se',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Crude oil purchases are the largest single cost item for a refinery, budgeted annually by crude type and volume. Linking crude_receipt to finance.budget enables crude cost vs. budget variance reportin',
    `cargo_nomination_id` BIGINT COMMENT 'Foreign key linking to commercial.cargo_nomination. Business justification: Every crude receipt at a refinery is executed against a cargo nomination. The nomination is the commercial document authorizing the crude delivery — it specifies grade, volume, laycan, and pricing bas',
    `certificate_of_quality_id` BIGINT COMMENT 'Foreign key linking to product.certificate_of_quality. Business justification: Every crude receipt in oil and gas operations is accompanied by a Certificate of Quality issued at the loading port. Custody transfer acceptance, invoice reconciliation, and feedstock quality tracking',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Crude receipts often fulfill term contract purchase obligations. Essential for contract compliance tracking, volume reconciliation, and take-or-pay verification in crude procurement operations.',
    `contract_id` BIGINT COMMENT 'Identifier of the term contract or spot purchase agreement under which this crude oil was procured.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Crude purchases are charged to cost centers for feedstock cost accounting and margin calculation. Enables tracking of crude acquisition costs by organizational unit and supports crude slate optimizati',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Crude receipts are of specific crude grades for quality verification, supplier performance tracking, and crude accounting. Essential for custody transfer validation, quality claim resolution, and crud',
    `custody_transfer_id` BIGINT COMMENT 'Foreign key linking to logistics.custody_transfer. Business justification: Crude receipts involve custody transfer events at measurement points. Fiscal measurement, quality reconciliation, and commercial settlement require linking receipts to custody transfer records for vol',
    `delivery_point_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_point. Business justification: Crude receipts occur at a specific custody transfer point (pipeline receipt, marine berth, truck rack). Linking to delivery_point enables metering system validation, inspection scheduling, and regulat',
    `discovery_id` BIGINT COMMENT 'Foreign key linking to exploration.discovery. Business justification: Integrated O&G companies trace received crude back to its originating discovery for upstream-downstream integration reporting, PSA cost recovery calculations, production entitlement tracking, and rese',
    `jib_statement_id` BIGINT COMMENT 'Foreign key linking to venture.jib_statement. Business justification: In JOA-operated refineries, crude receipts generate joint account costs billed via COPAS JIB statements. Linking crude_receipt to jib_statement enables joint interest billing reconciliation — a core C',
    `lifting_entitlement_id` BIGINT COMMENT 'Foreign key linking to venture.lifting_entitlement. Business justification: In JOA/PSA operations, a crude receipt at the refinery physically fulfills a partners lifting entitlement. Linking crude_receipt to lifting_entitlement enables equity oil lifting reconciliation and o',
    `logistics_lifting_schedule_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_lifting_schedule. Business justification: Crude receipts at the refinery must be reconciled against the lifting schedule that authorized the cargo. JOA entitlement tracking, PSA compliance, and crude supply planning all require linking actual',
    `pipeline_nomination_id` BIGINT COMMENT 'Foreign key linking to logistics.pipeline_nomination. Business justification: Pipeline crude receipts at the refinery are executed against specific pipeline nominations. FERC/PHMSA reporting, pipeline imbalance reconciliation, and crude supply scheduling all require linking the',
    `pooling_unit_id` BIGINT COMMENT 'Foreign key linking to land.pooling_unit. Business justification: Crude received from pooled production units requires reference to the pooling unit for correct royalty allocation, production accounting, and regulatory reporting across pooled tract interests. In man',
    `product_quality_test_id` BIGINT COMMENT 'Reference to the laboratory quality test record performed on the crude oil sample at receipt.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Refineries processing crude under production sharing agreements must track cost recovery eligibility, profit oil calculations, and ring-fencing rules. PSA cost recovery ceilings and domestic market ob',
    `pvt_analysis_id` BIGINT COMMENT 'Foreign key linking to reservoir.pvt_analysis. Business justification: At crude receipt, refinery inspectors validate received crude quality against upstream PVT characterization (API gravity, GOR, fluid type). This link supports quality-at-receipt verification, custody ',
    `terminal_id` BIGINT COMMENT 'Foreign key linking to logistics.terminal. Business justification: Crude is received at a terminal before transfer to the refinery. Custody transfer documentation, SPCC reporting, and crude supply chain traceability require identifying the receiving terminal for each',
    `refinery_id` BIGINT COMMENT 'Identifier of the refinery facility receiving the crude oil shipment.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Crude oil imports require customs declarations (CBP Form 7501), Jones Act compliance certifications for domestic waterborne shipments, and EIA crude oil import reports. Each receipt must be traceable ',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Refineries track crude source reservoir for supply chain traceability, quality variance analysis (API/sulfur/TAN reconciliation against reservoir fluid properties), reserves booking validation, and fe',
    `run_ticket_id` BIGINT COMMENT 'Foreign key linking to production.run_ticket. Business justification: Run tickets are the custody transfer documents issued at the production/lease side that accompany crude oil to the refinery gate. Refiners match crude receipts to run tickets for custody transfer reco',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Every crude receipt at a refinery corresponds to a logistics shipment (vessel, truck, or rail). Volume and quality reconciliation between the shipment bill of lading and the refinery receipt record is',
    `field_id` BIGINT COMMENT 'Foreign key linking to production.field. Business justification: Refiners track crude origin at the field level for crude slate planning, quality management, and fiscal/regulatory origin reporting. Field-level origin is distinct from well/facility links already pre',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Integrated oil & gas operators tracking crude receipts from their own upstream production need to link receipts to source leases for: (1) crude quality variance analysis by lease, (2) royalty-in-kind ',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Refineries track source production facilities for custody transfer reconciliation, quality certification, and supply chain logistics. Essential for receipt variance resolution and integrated supply pl',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: Refineries track source wells for crude quality traceability, assay validation, and blending optimization. Critical for integrated operators managing upstream-downstream quality specifications and reg',
    `spot_trade_id` BIGINT COMMENT 'Foreign key linking to commercial.spot_trade. Business justification: Spot crude purchases generate physical receipts at refineries. Critical for trade settlement, invoice reconciliation, and matching physical delivery against trading book positions.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Crude receipts require formal counterparty tracking for custody transfer documentation, pricing settlement, credit management, and sanctions screening. Supplier_name is denormalized; FK enables KYC ve',
    `tank_inventory_id` BIGINT COMMENT 'Identifier of the crude oil storage tank to which this receipt was allocated upon arrival at the refinery.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the crude oil supplier in the enterprise vendor master system.',
    `vessel_id` BIGINT COMMENT 'Foreign key linking to logistics.vessel. Business justification: Crude receipts by vessel require vessel master data for demurrage calculations, laytime tracking, quality claims, and vetting compliance. Linking receipts to vessel records enables voyage cost reconci',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.violation. Business justification: Crude receipts with quality non-compliance (receiving crude exceeding permitted sulfur or metals levels) can trigger EPA or state violations. crude_receipt already has compliance_regulatory_filing_id;',
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
    `blend_event_id` BIGINT COMMENT 'Foreign key linking to refining.blend_event. Business justification: Product movements track transfers of blended products. product_movement.batch_number (STRING) should be normalized to blend_event_id FK to establish traceability from custody transfer back to the blen',
    `cargo_nomination_id` BIGINT COMMENT 'Foreign key linking to commercial.cargo_nomination. Business justification: Product movements (liftings, transfers) are executed against cargo nominations. The cargo nomination is the commercial authorization for the physical product movement. Every cargo lifting movement mus',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Product movements by truck, rail, or vessel are executed by a carrier. Freight cost allocation, carrier performance tracking, DOT/PHMSA compliance reporting, and demurrage claims all require linking t',
    `certificate_of_quality_id` BIGINT COMMENT 'Foreign key linking to product.certificate_of_quality. Business justification: Refined product movements for sale or inter-terminal transfer require a Certificate of Quality for custody transfer acceptance. Commercial contracts mandate CoQ issuance per shipment/movement. Linking',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Product movements fulfill term contract delivery obligations. Required for contract performance tracking, volume commitment verification, and deficiency payment calculations in long-term supply agreem',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Product transfers and sales must be allocated to cost centers for revenue recognition and transfer pricing. Supports internal margin calculation, inventory valuation, and intercompany reconciliation.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Product movements to/from external parties (sales, exchanges, swaps) require counterparty identification for commercial settlement, custody transfer validation, sanctions compliance, and revenue recog',
    `custody_transfer_id` BIGINT COMMENT 'Foreign key linking to logistics.custody_transfer. Business justification: Every product movement crossing a custody boundary generates a custody transfer record. Revenue recognition, royalty calculation, and commercial settlement all depend on linking the product movement t',
    `customer_lifting_schedule_id` BIGINT COMMENT 'Foreign key linking to customer.customer_lifting_schedule. Business justification: Product movements fulfill customer lifting schedules. Lifting schedule compliance reporting, over/underlift tracking, and bill-of-lading reconciliation require linking each physical movement to the sc',
    `nomination_id` BIGINT COMMENT 'Foreign key linking to customer.nomination. Business justification: Product movements physically execute against customer nominations in oil lifting operations. The nomination authorizes the volume and terms; the movement records execution. Cargo scheduling, demurrage',
    `delivery_order_id` BIGINT COMMENT 'Foreign key linking to logistics.delivery_order. Business justification: A product movement executes against a delivery order that authorizes volume, destination, and pricing terms. Order-to-execution reconciliation, invoice generation, and customer delivery confirmation a',
    `delivery_point_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_point. Business justification: Product movements must reference a structured delivery point for custody transfer, metering, and regulatory reporting. destination_location_code and destination_location_description are denormalized d',
    `lifting_program_id` BIGINT COMMENT 'Foreign key linking to commercial.lifting_program. Business justification: Product movements (liftings) are executed under lifting programs. The lifting program is the monthly commercial schedule authorizing specific product liftings. Overlift/underlift tracking and equity e',
    `offtake_entitlement_id` BIGINT COMMENT 'Foreign key linking to customer.offtake_entitlement. Business justification: Product movements fulfill customer offtake entitlements in equity lifting operations. Tracking which entitlement each movement draws against is essential for overlift/underlift balancing, profit oil a',
    `terminal_id` BIGINT COMMENT 'Foreign key linking to logistics.terminal. Business justification: Product movements originate from refinery terminals. Loading rack operations, terminal inventory management, and logistics dispatch planning require linking movements to origin terminals for operation',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Product movements may require transport or export permits (e.g., hazardous materials transport permits, export licenses for petroleum products). Compliance teams track which permit authorizes each pro',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Product movements transfer specific petroleum products between tanks, terminals, or customers. Essential for custody transfer documentation, logistics tracking, inventory reconciliation, and revenue r',
    `pipeline_nomination_id` BIGINT COMMENT 'Foreign key linking to logistics.pipeline_nomination. Business justification: Refined product movements via pipeline are executed against pipeline nominations. FERC tariff reporting, pipeline imbalance tracking, and product distribution scheduling require linking outbound produ',
    `product_quality_test_id` BIGINT COMMENT 'Foreign key linking to refining.product_quality_test. Business justification: A product movement requires quality certification before transfer. Linking product_movement to product_quality_test normalizes the quality_certificate_number string field — the quality test record con',
    `refinery_id` BIGINT COMMENT 'Reference to the refinery facility where the product movement originated or terminated.',
    `refinery_schedule_id` BIGINT COMMENT 'Foreign key linking to refining.refinery_schedule. Business justification: Product movements are scheduled as part of a refinery schedule; linking them enables alignment of physical movements with planned production.',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Product movements fulfill sales orders—core order-to-cash process. Essential for delivery confirmation, revenue recognition, customer billing, and logistics coordination in refined product sales.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Product movements out of refineries are logistics shipments. Loading operations, custody transfer, freight invoicing, and delivery confirmation require linking refinery dispatch records to logistics s',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Product movements originating from production facilities (condensate transfers, NGL movements from gas plants to refineries) must reference the source production facility for custody transfer, revenue',
    `tank_inventory_id` BIGINT COMMENT 'Foreign key linking to refining.tank_inventory. Business justification: A product movement involves a specific refinery storage tank as the source or destination. Linking product_movement to tank_inventory enables tank-level movement reconciliation (receipts_volume_bbl, d',
    `trade_confirmation_id` BIGINT COMMENT 'Foreign key linking to commercial.trade_confirmation. Business justification: Product movements settle against trade confirmations — the physical movement is the fulfillment of the confirmed trade. Trade settlement and P&L reporting require linking the physical product movement',
    `accounting_period` STRING COMMENT 'The financial accounting period to which this product movement is allocated for inventory and revenue recognition.',
    `actual_end_datetime` TIMESTAMP COMMENT 'The actual date and time when the physical product movement operation was completed.',
    `actual_start_datetime` TIMESTAMP COMMENT 'The actual date and time when the physical product movement operation began.',
    `api_gravity` DECIMAL(18,2) COMMENT 'The American Petroleum Institute gravity measurement of the product, indicating its density relative to water.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this product movement transaction was formally approved.',
    `comments` STRING COMMENT 'Free-text field for additional notes, special instructions, or operational remarks related to the product movement.',
    `contract_number` STRING COMMENT 'Reference to the commercial contract or agreement governing this product movement transaction.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this product movement record was first created in the system.',
    `custody_transfer_status` STRING COMMENT 'Status indicating whether custody transfer has been acknowledged and accepted by the receiving party for accounting purposes.. Valid values are `pending|accepted|disputed|reconciled`',
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
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Product specifications fulfill specific regulatory obligations (EPA Tier 3 sulfur standard, CARB fuel requirements, RFS renewable content). Compliance teams link specifications to obligations to confi',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to product.quality_spec. Business justification: Internal refinery product specifications must comply with and be traceable to the governing product-level quality_spec (regulatory/market standard). Specification management, regulatory audit, and pro',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Product specifications are set or approved by regulatory authorities (EPA for Tier 3 fuel standards, CARB for California fuels, EU for EN 590). The existing regulatory_basis column is a denormalized t',
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
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Catalyst purchases and replacements are often capitalized via AFEs. Lifecycle tracking requires AFE linkage for cost tracking, capitalization decisions, and depreciation calculation. Standard refining',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Catalyst regeneration and disposal require environmental permits (hazardous waste permits under RCRA, air permits for regeneration emissions). catalyst_lifecycle already has compliance_regulatory_fili',
    `previous_catalyst_lifecycle_id` BIGINT COMMENT 'Self-referencing FK on catalyst_lifecycle (previous_catalyst_lifecycle_id)',
    `process_unit_id` BIGINT COMMENT 'Reference to the specific process unit (FCC, HDS, reformer, alkylation, isomerization) where the catalyst is installed and operating.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Catalyst loads are high-value capital purchases requiring PO tracking for cost capitalization, delivery coordination with turnaround schedules, three-way match with goods receipt and invoice, and AFE ',
    `refinery_id` BIGINT COMMENT 'Reference to the refinery facility where the catalyst is deployed. Links to the refinery master data.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Spent catalyst is shipped out for regeneration or disposal; fresh catalyst arrives via inbound shipment. Hazmat shipping compliance (DOT/IATA), catalyst regeneration vendor logistics, and turnaround m',
    `turnaround_id` BIGINT COMMENT 'Reference to the turnaround event during which this catalyst was loaded or replaced. Links catalyst lifecycle to major maintenance events.',
    `unit_run_id` BIGINT COMMENT 'Foreign key linking to refining.unit_run. Business justification: Catalyst performance metrics (current_activity_level, catalyst_age_days, coke_content_wt_pct) are measured during specific unit runs. Linking catalyst_lifecycle to unit_run enables correlation of cata',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Catalyst batches are procured from specific vendors. Real catalyst management tracks vendor for warranty claims, performance guarantee validation, technical support escalation, regeneration services, ',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`crude_allocation` (
    `crude_allocation_id` BIGINT COMMENT 'Unique identifier for the crude allocation record. Primary key for the crude_allocation association product.',
    `crude_receipt_id` BIGINT COMMENT 'Foreign key linking to the crude oil receipt transaction being allocated to a feedstock blend.',
    `feedstock_blend_id` BIGINT COMMENT 'Foreign key linking to the feedstock blend receiving the allocated crude volume.',
    `allocated_by` STRING COMMENT 'The name or identifier of the crude scheduler, process engineer, or planning system user who created this allocation record.',
    `allocated_volume_bbl` DECIMAL(18,2) COMMENT 'The volume of crude oil in barrels allocated from this crude receipt to this feedstock blend. This is the portion of the crude_receipt.net_volume_bbl assigned to this specific blend.',
    `allocation_date` DATE COMMENT 'The date when this crude volume was allocated to the feedstock blend by the crude scheduler or refinery planning system.',
    `allocation_notes` STRING COMMENT 'Free-text notes recorded by the crude scheduler regarding the rationale for this allocation, quality considerations, or operational constraints.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the crude allocation. Planned indicates the allocation is part of a future blend plan. Confirmed indicates the allocation has been approved. Executed indicates the crude has been physically blended. Cancelled indicates the allocation was reversed.',
    `allocation_timestamp` TIMESTAMP COMMENT 'The precise date and time when this crude allocation record was created in the refinery scheduling system.',
    `volume_fraction_pct` DECIMAL(18,2) COMMENT 'The percentage of the feedstock blend total volume represented by this crude allocation. Used in blend recipe calculations and feedstock optimization.',
    CONSTRAINT pk_crude_allocation PRIMARY KEY(`crude_allocation_id`)
) COMMENT 'This association product represents the operational allocation of received crude oil volumes to planned feedstock blends in refinery crude scheduling and feedstock optimization workflows. It captures the explicit business decision to assign a portion of a crude receipt to a specific feedstock blend recipe, including allocated volume, volume fraction, allocation date, and status. Each record links one crude_receipt to one feedstock_blend with attributes that exist only in the context of this allocation decision.. Existence Justification: In refinery operations, a single crude receipt (e.g., a vessel delivery of 500,000 barrels) is routinely split and allocated across multiple feedstock blends targeting different process units or processing periods. Conversely, a single feedstock blend recipe typically draws from multiple crude receipts to achieve the desired quality profile (API gravity, sulfur content, TAN). Crude schedulers actively manage these allocations in refinery planning systems (Aspen PIMS, Spiral) as a distinct operational activity with its own data (allocated volumes, fractions, dates, status).';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`refining`.`schedule_unit_plan` (
    `schedule_unit_plan_id` BIGINT COMMENT 'Unique identifier for this schedule-unit planning record. Primary key.',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to the specific process unit being planned in this schedule.',
    `refinery_schedule_id` BIGINT COMMENT 'Foreign key linking to the refinery production schedule for which this unit plan applies.',
    `actual_throughput_bpd` DECIMAL(18,2) COMMENT 'Actual achieved throughput rate for this unit during this schedule period. Enables planned vs. actual variance analysis at the unit level.',
    `cdu_throughput_target_bpd` DECIMAL(18,2) COMMENT 'Planned daily throughput rate for the Crude Distillation Unit in barrels per day. Key operational target for primary refining capacity utilization. [Moved from refinery_schedule: This attribute represents a unit-specific throughput target (CDU = Crude Distillation Unit) that should be modeled as a schedule_unit_plan record for the CDU process unit, not as a schedule-level attribute. Moving to association enables proper normalization where each unit has its own plan record.]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule-unit plan record was created. Audit trail for planning activities.',
    `fcc_throughput_target_bpd` DECIMAL(18,2) COMMENT 'Planned daily throughput rate for the Fluid Catalytic Cracking unit in barrels per day. Critical for gasoline and light olefin production optimization. [Moved from refinery_schedule: This attribute represents a unit-specific throughput target (FCC = Fluid Catalytic Cracking) that should be modeled as a schedule_unit_plan record for the FCC process unit, not as a schedule-level attribute. Moving to association enables proper normalization.]',
    `hds_throughput_target_bpd` DECIMAL(18,2) COMMENT 'Planned daily throughput rate for the Hydrodesulfurization unit in barrels per day. Targets sulfur removal capacity to meet EPA emissions and product quality standards. [Moved from refinery_schedule: This attribute represents a unit-specific throughput target (HDS = Hydrodesulfurization) that should be modeled as a schedule_unit_plan record for the HDS process unit, not as a schedule-level attribute. Moving to association enables proper normalization.]',
    `maintenance_flag` BOOLEAN COMMENT 'Indicates whether this unit is scheduled for maintenance during this schedule period. Critical for coordinating turnarounds and managing refinery-wide capacity.',
    `operational_mode` STRING COMMENT 'Planned operational state for this process unit during this schedule period. Determines throughput expectations and resource allocation.',
    `planned_throughput_bpd` DECIMAL(18,2) COMMENT 'Target daily throughput rate for this specific process unit during this schedule period, measured in barrels per day. This is the core planning parameter that schedulers set per unit per schedule.',
    `scheduled_end_date` DATE COMMENT 'Date when this unit plan ends within the schedule period. Critical for planning maintenance windows and turnarounds.',
    `scheduled_start_date` DATE COMMENT 'Date when this unit plan becomes effective within the schedule period. Enables phased scheduling where different units ramp up at different times.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule-unit plan was last modified. Tracks replanning and schedule adjustments.',
    `variance_bpd` DECIMAL(18,2) COMMENT 'Calculated variance between planned and actual throughput for this unit in this schedule. Supports unit-level performance tracking.',
    CONSTRAINT pk_schedule_unit_plan PRIMARY KEY(`schedule_unit_plan_id`)
) COMMENT 'This association product represents the operational planning assignment between a refinery production schedule and a process unit. It captures the specific throughput targets, operational modes, and maintenance windows that refinery schedulers assign to each process unit within a given planning period. Each record links one refinery_schedule to one process_unit with planning parameters that exist only in the context of that schedule-unit combination, enabling detailed production planning and variance tracking per unit per schedule period.. Existence Justification: In refinery production planning operations, schedulers explicitly create unit-specific operating plans for each process unit within each schedule period. A single refinery schedule (e.g., Q1 2024 production plan) contains distinct throughput targets, operational modes, and maintenance windows for multiple process units (CDU, FCC, HDS, reformer, etc.). Conversely, each process unit participates in multiple schedules over time (monthly, quarterly, annual planning cycles). This is a recognized operational planning artifact in refinery scheduling systems like Aspen PIMS and Honeywell Refinery Planner.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ADD CONSTRAINT `fk_refining_process_unit_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ADD CONSTRAINT `fk_refining_crude_assay_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ADD CONSTRAINT `fk_refining_feedstock_blend_blending_recipe_id` FOREIGN KEY (`blending_recipe_id`) REFERENCES `oil_gas_ecm`.`refining`.`blending_recipe`(`blending_recipe_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ADD CONSTRAINT `fk_refining_feedstock_blend_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ADD CONSTRAINT `fk_refining_feedstock_blend_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `oil_gas_ecm`.`refining`.`product_specification`(`product_specification_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ADD CONSTRAINT `fk_refining_feedstock_blend_refinery_schedule_id` FOREIGN KEY (`refinery_schedule_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery_schedule`(`refinery_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ADD CONSTRAINT `fk_refining_unit_run_feedstock_blend_id` FOREIGN KEY (`feedstock_blend_id`) REFERENCES `oil_gas_ecm`.`refining`.`feedstock_blend`(`feedstock_blend_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ADD CONSTRAINT `fk_refining_unit_run_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ADD CONSTRAINT `fk_refining_unit_run_refinery_schedule_id` FOREIGN KEY (`refinery_schedule_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery_schedule`(`refinery_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ADD CONSTRAINT `fk_refining_yield_record_feedstock_blend_id` FOREIGN KEY (`feedstock_blend_id`) REFERENCES `oil_gas_ecm`.`refining`.`feedstock_blend`(`feedstock_blend_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ADD CONSTRAINT `fk_refining_yield_record_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ADD CONSTRAINT `fk_refining_yield_record_unit_run_id` FOREIGN KEY (`unit_run_id`) REFERENCES `oil_gas_ecm`.`refining`.`unit_run`(`unit_run_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_blend_event_id` FOREIGN KEY (`blend_event_id`) REFERENCES `oil_gas_ecm`.`refining`.`blend_event`(`blend_event_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `oil_gas_ecm`.`refining`.`product_specification`(`product_specification_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_tank_inventory_id` FOREIGN KEY (`tank_inventory_id`) REFERENCES `oil_gas_ecm`.`refining`.`tank_inventory`(`tank_inventory_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_unit_run_id` FOREIGN KEY (`unit_run_id`) REFERENCES `oil_gas_ecm`.`refining`.`unit_run`(`unit_run_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ADD CONSTRAINT `fk_refining_refinery_schedule_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ADD CONSTRAINT `fk_refining_refinery_schedule_turnaround_id` FOREIGN KEY (`turnaround_id`) REFERENCES `oil_gas_ecm`.`refining`.`turnaround`(`turnaround_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ADD CONSTRAINT `fk_refining_blending_recipe_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ADD CONSTRAINT `fk_refining_blending_recipe_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `oil_gas_ecm`.`refining`.`product_specification`(`product_specification_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ADD CONSTRAINT `fk_refining_blending_recipe_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ADD CONSTRAINT `fk_refining_blend_event_blending_recipe_id` FOREIGN KEY (`blending_recipe_id`) REFERENCES `oil_gas_ecm`.`refining`.`blending_recipe`(`blending_recipe_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ADD CONSTRAINT `fk_refining_blend_event_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `oil_gas_ecm`.`refining`.`product_specification`(`product_specification_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ADD CONSTRAINT `fk_refining_blend_event_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ADD CONSTRAINT `fk_refining_blend_event_refinery_schedule_id` FOREIGN KEY (`refinery_schedule_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery_schedule`(`refinery_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ADD CONSTRAINT `fk_refining_blend_event_tank_inventory_id` FOREIGN KEY (`tank_inventory_id`) REFERENCES `oil_gas_ecm`.`refining`.`tank_inventory`(`tank_inventory_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ADD CONSTRAINT `fk_refining_blend_event_unit_run_id` FOREIGN KEY (`unit_run_id`) REFERENCES `oil_gas_ecm`.`refining`.`unit_run`(`unit_run_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ADD CONSTRAINT `fk_refining_turnaround_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ADD CONSTRAINT `fk_refining_turnaround_work_item_predecessor_work_item_turnaround_work_item_id` FOREIGN KEY (`predecessor_work_item_turnaround_work_item_id`) REFERENCES `oil_gas_ecm`.`refining`.`turnaround_work_item`(`turnaround_work_item_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ADD CONSTRAINT `fk_refining_turnaround_work_item_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ADD CONSTRAINT `fk_refining_turnaround_work_item_turnaround_id` FOREIGN KEY (`turnaround_id`) REFERENCES `oil_gas_ecm`.`refining`.`turnaround`(`turnaround_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ADD CONSTRAINT `fk_refining_energy_consumption_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ADD CONSTRAINT `fk_refining_energy_consumption_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ADD CONSTRAINT `fk_refining_energy_consumption_unit_run_id` FOREIGN KEY (`unit_run_id`) REFERENCES `oil_gas_ecm`.`refining`.`unit_run`(`unit_run_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_product_quality_test_id` FOREIGN KEY (`product_quality_test_id`) REFERENCES `oil_gas_ecm`.`refining`.`product_quality_test`(`product_quality_test_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_tank_inventory_id` FOREIGN KEY (`tank_inventory_id`) REFERENCES `oil_gas_ecm`.`refining`.`tank_inventory`(`tank_inventory_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_blend_event_id` FOREIGN KEY (`blend_event_id`) REFERENCES `oil_gas_ecm`.`refining`.`blend_event`(`blend_event_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_product_quality_test_id` FOREIGN KEY (`product_quality_test_id`) REFERENCES `oil_gas_ecm`.`refining`.`product_quality_test`(`product_quality_test_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_refinery_schedule_id` FOREIGN KEY (`refinery_schedule_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery_schedule`(`refinery_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_tank_inventory_id` FOREIGN KEY (`tank_inventory_id`) REFERENCES `oil_gas_ecm`.`refining`.`tank_inventory`(`tank_inventory_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ADD CONSTRAINT `fk_refining_product_specification_superseded_by_specification_product_specification_id` FOREIGN KEY (`superseded_by_specification_product_specification_id`) REFERENCES `oil_gas_ecm`.`refining`.`product_specification`(`product_specification_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ADD CONSTRAINT `fk_refining_catalyst_lifecycle_previous_catalyst_lifecycle_id` FOREIGN KEY (`previous_catalyst_lifecycle_id`) REFERENCES `oil_gas_ecm`.`refining`.`catalyst_lifecycle`(`catalyst_lifecycle_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ADD CONSTRAINT `fk_refining_catalyst_lifecycle_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ADD CONSTRAINT `fk_refining_catalyst_lifecycle_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ADD CONSTRAINT `fk_refining_catalyst_lifecycle_turnaround_id` FOREIGN KEY (`turnaround_id`) REFERENCES `oil_gas_ecm`.`refining`.`turnaround`(`turnaround_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ADD CONSTRAINT `fk_refining_catalyst_lifecycle_unit_run_id` FOREIGN KEY (`unit_run_id`) REFERENCES `oil_gas_ecm`.`refining`.`unit_run`(`unit_run_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_allocation` ADD CONSTRAINT `fk_refining_crude_allocation_crude_receipt_id` FOREIGN KEY (`crude_receipt_id`) REFERENCES `oil_gas_ecm`.`refining`.`crude_receipt`(`crude_receipt_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_allocation` ADD CONSTRAINT `fk_refining_crude_allocation_feedstock_blend_id` FOREIGN KEY (`feedstock_blend_id`) REFERENCES `oil_gas_ecm`.`refining`.`feedstock_blend`(`feedstock_blend_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_unit_plan` ADD CONSTRAINT `fk_refining_schedule_unit_plan_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_unit_plan` ADD CONSTRAINT `fk_refining_schedule_unit_plan_refinery_schedule_id` FOREIGN KEY (`refinery_schedule_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery_schedule`(`refinery_schedule_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`refining` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `oil_gas_ecm`.`refining` SET TAGS ('dbx_domain' = 'refining');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Identifier');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `crude_assay_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Assay Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `pvt_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Pvt Analysis Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Source Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Source Field Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Source Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `aromatic_content_wt_pct` SET TAGS ('dbx_business_glossary_term' = 'Aromatic Content Weight Percent (wt%)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `asphaltene_content_wt_pct` SET TAGS ('dbx_business_glossary_term' = 'Asphaltene Content Weight Percent (wt%)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ALTER COLUMN `assay_date` SET TAGS ('dbx_business_glossary_term' = 'Assay Date');
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
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `feedstock_blend_id` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Blend Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `blending_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Blending Recipe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Driving Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `pipeline_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Target Process Unit Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `pvt_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Pvt Analysis Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `refinery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Schedule Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Source Field Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Source Production Facility Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `unit_run_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Run Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `feedstock_blend_id` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Blend Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `process_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `refinery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Schedule Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Source Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `yield_record_id` SET TAGS ('dbx_business_glossary_term' = 'Refining Yield Record Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `feedstock_blend_id` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Blend Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `unit_run_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Run Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `actual_mass_mt` SET TAGS ('dbx_business_glossary_term' = 'Actual Mass in Metric Tons (MT)');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `actual_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `boe_equivalent` SET TAGS ('dbx_business_glossary_term' = 'Barrel of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `dcs_data_source` SET TAGS ('dbx_business_glossary_term' = 'Distributed Control System (DCS) Data Source');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `epa_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Reporting Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `loss_category` SET TAGS ('dbx_business_glossary_term' = 'Loss Category');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `loss_category` SET TAGS ('dbx_value_regex' = 'normal|evaporation|spillage|measurement_error|theft|unknown');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `lvuf_bbl` SET TAGS ('dbx_business_glossary_term' = 'Liquid Volume Unaccounted For (LVUF) in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `mass_balance_closure_pct` SET TAGS ('dbx_business_glossary_term' = 'Mass Balance Closure Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `mass_variance_mt` SET TAGS ('dbx_business_glossary_term' = 'Mass Variance in Metric Tons (MT)');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'flow_meter|tank_gauging|mass_balance|simulation|manual');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `planned_mass_mt` SET TAGS ('dbx_business_glossary_term' = 'Planned Mass in Metric Tons (MT)');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `planned_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Planned Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Quality Grade');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `quality_grade` SET TAGS ('dbx_value_regex' = 'premium|standard|off_spec|blendstock|intermediate');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `reconciliation_notes` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Notes');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `ron_value` SET TAGS ('dbx_business_glossary_term' = 'Research Octane Number (RON) Value');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `simulation_target_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Simulation Target Volume in Barrels (BBL) from Aspen HYSYS');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `simulation_variance_bbl` SET TAGS ('dbx_business_glossary_term' = 'Simulation Variance in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `sulfur_content_pct` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `tan_value` SET TAGS ('dbx_business_glossary_term' = 'Total Acid Number (TAN) Value');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `volume_variance_bbl` SET TAGS ('dbx_business_glossary_term' = 'Volume Variance in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `yield_status` SET TAGS ('dbx_business_glossary_term' = 'Yield Record Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ALTER COLUMN `yield_status` SET TAGS ('dbx_value_regex' = 'validated|preliminary|reconciled|disputed|adjusted');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` SET TAGS ('dbx_subdomain' = 'product_quality');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `product_quality_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Test Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `blend_event_id` SET TAGS ('dbx_business_glossary_term' = 'Blend Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ALTER COLUMN `tank_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Tank Inventory Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `refinery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Schedule ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `operating_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Offtake Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `turnaround_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activated Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `actual_crude_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Actual Crude Volume (BBL - Barrels)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `actual_crude_volume_bbl` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
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
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `financial_impact_usd` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact (USD - United States Dollars)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `financial_impact_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `fuel_oil_target_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Fuel Oil Target Volume (BBL - Barrels)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `fuel_oil_target_volume_bbl` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `gasoline_target_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Gasoline Target Volume (BBL - Barrels)');
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ALTER COLUMN `gasoline_target_volume_bbl` SET TAGS ('dbx_confidential' = 'true');
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
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `blending_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Blending Recipe Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Additive Material Master Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Blending Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `refined_product_id` SET TAGS ('dbx_business_glossary_term' = 'Refined Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `blend_event_id` SET TAGS ('dbx_business_glossary_term' = 'Blend Event Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Blending Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `blending_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Blend Recipe Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `certificate_of_quality_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Quality Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `refinery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Schedule Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` SET TAGS ('dbx_subdomain' = 'product_quality');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `tank_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Tank Inventory ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Allocated Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `turnaround_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Audit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `operating_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `venture_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `turnaround_work_item_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Work Item Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `compliance_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `failure_report_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Report Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `predecessor_work_item_turnaround_work_item_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Work Item Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `turnaround_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `work_package_code` SET TAGS ('dbx_business_glossary_term' = 'Work Package Code');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `work_priority` SET TAGS ('dbx_business_glossary_term' = 'Work Priority Level');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `work_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `work_status` SET TAGS ('dbx_business_glossary_term' = 'Work Item Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `work_status` SET TAGS ('dbx_value_regex' = 'planned|approved|in_progress|on_hold|completed|cancelled');
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ALTER COLUMN `work_type` SET TAGS ('dbx_business_glossary_term' = 'Work Type Classification');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `energy_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Source Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ALTER COLUMN `unit_run_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Run Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `crude_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Receipt ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `certificate_of_quality_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Quality Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `custody_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Custody Transfer Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `discovery_id` SET TAGS ('dbx_business_glossary_term' = 'Discovery Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `jib_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Jib Statement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `lifting_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Entitlement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `logistics_lifting_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Lifting Schedule Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `pipeline_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `pooling_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Pooling Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `product_quality_test_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Test ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `pvt_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Pvt Analysis Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Receipt Terminal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `run_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Run Ticket Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Source Field Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Source Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Source Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Source Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `spot_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Trade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `tank_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Tank ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` SET TAGS ('dbx_subdomain' = 'product_quality');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `product_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Product Movement Identifier');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `blend_event_id` SET TAGS ('dbx_business_glossary_term' = 'Blend Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `certificate_of_quality_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Quality Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `custody_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Custody Transfer Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `customer_lifting_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifting Schedule Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `delivery_order_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Delivery Point Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `lifting_program_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Program Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `offtake_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Entitlement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Terminal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `pipeline_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `product_quality_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Test Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `refinery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Schedule Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Source Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `tank_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Tank Inventory Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `trade_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Confirmation Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `scheduled_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date and Time');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature in Celsius');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `transfer_mode` SET TAGS ('dbx_business_glossary_term' = 'Transfer Mode');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `transfer_mode` SET TAGS ('dbx_value_regex' = 'pipeline|truck|rail|marine|barge|inter_tank');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `variance_barrels` SET TAGS ('dbx_business_glossary_term' = 'Variance in Barrels');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `volume_barrels` SET TAGS ('dbx_business_glossary_term' = 'Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ALTER COLUMN `volume_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Volume in Metric Tons (MT)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` SET TAGS ('dbx_subdomain' = 'product_quality');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `catalyst_lifecycle_id` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Lifecycle Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `previous_catalyst_lifecycle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `turnaround_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `unit_run_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Run Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_allocation` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_allocation` SET TAGS ('dbx_association_edges' = 'refining.crude_receipt,refining.feedstock_blend');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_allocation` ALTER COLUMN `crude_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Allocation ID');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_allocation` ALTER COLUMN `crude_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Allocation - Crude Receipt Id');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_allocation` ALTER COLUMN `feedstock_blend_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Allocation - Feedstock Blend Id');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_allocation` ALTER COLUMN `allocated_by` SET TAGS ('dbx_business_glossary_term' = 'Allocated By');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_allocation` ALTER COLUMN `allocated_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Allocated Volume (BBL)');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_allocation` ALTER COLUMN `allocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_allocation` ALTER COLUMN `volume_fraction_pct` SET TAGS ('dbx_business_glossary_term' = 'Volume Fraction Percentage');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_unit_plan` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_unit_plan` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_unit_plan` SET TAGS ('dbx_association_edges' = 'refining.refinery_schedule,refining.process_unit');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_unit_plan` ALTER COLUMN `schedule_unit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Unit Plan Identifier');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_unit_plan` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Unit Plan - Process Unit Id');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_unit_plan` ALTER COLUMN `refinery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Unit Plan - Refinery Schedule Id');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_unit_plan` ALTER COLUMN `actual_throughput_bpd` SET TAGS ('dbx_business_glossary_term' = 'Actual Throughput Barrels Per Day');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_unit_plan` ALTER COLUMN `cdu_throughput_target_bpd` SET TAGS ('dbx_business_glossary_term' = 'Crude Distillation Unit (CDU) Throughput Target (BOPD - Barrels of Oil Per Day)');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_unit_plan` ALTER COLUMN `cdu_throughput_target_bpd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_unit_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_unit_plan` ALTER COLUMN `fcc_throughput_target_bpd` SET TAGS ('dbx_business_glossary_term' = 'Fluid Catalytic Cracking (FCC) Unit Throughput Target (BOPD - Barrels of Oil Per Day)');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_unit_plan` ALTER COLUMN `fcc_throughput_target_bpd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_unit_plan` ALTER COLUMN `hds_throughput_target_bpd` SET TAGS ('dbx_business_glossary_term' = 'Hydrodesulfurization (HDS) Unit Throughput Target (BOPD - Barrels of Oil Per Day)');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_unit_plan` ALTER COLUMN `hds_throughput_target_bpd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_unit_plan` ALTER COLUMN `maintenance_flag` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Flag');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_unit_plan` ALTER COLUMN `operational_mode` SET TAGS ('dbx_business_glossary_term' = 'Operational Mode');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_unit_plan` ALTER COLUMN `planned_throughput_bpd` SET TAGS ('dbx_business_glossary_term' = 'Planned Throughput Barrels Per Day');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_unit_plan` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_unit_plan` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_unit_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_unit_plan` ALTER COLUMN `variance_bpd` SET TAGS ('dbx_business_glossary_term' = 'Throughput Variance Barrels Per Day');
