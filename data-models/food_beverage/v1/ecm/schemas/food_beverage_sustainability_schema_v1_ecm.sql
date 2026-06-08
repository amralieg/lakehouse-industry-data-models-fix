-- Schema for Domain: sustainability | Business: Food Beverage | Version: v1_ecm
-- Generated on: 2026-05-05 21:26:26

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `food_beverage_ecm`.`sustainability` COMMENT 'Environmental, social, and governance (ESG) data including carbon footprint per SKU, water usage in production, waste reduction, packaging recyclability metrics, responsible sourcing certifications (Rainforest Alliance, Fair Trade), Scope 1/2/3 emissions, renewable energy usage, circular economy programs, and ESG disclosures aligned with GRI and CDP frameworks.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` (
    `esg_disclosure_id` BIGINT COMMENT 'Unique system-generated identifier for the ESG disclosure record.',
    `packaging_profile_id` BIGINT COMMENT 'Foreign key linking to sustainability.packaging_profile. Business justification: ESG disclosure references the packaging profile used for the SKU; packaging details are stored in packaging_profile, so a FK removes the redundant recyclability percent column.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: ESG disclosures are prepared by a responsible employee; the FK enables responsibility tracking for regulatory filings.',
    `approval_date` DATE COMMENT 'Date the disclosure was formally approved by internal governance.',
    `approved_by` STRING COMMENT 'Name or identifier of the approver.',
    `assurance_level` STRING COMMENT 'Level of assurance applied to the disclosed data (None, Limited, Reasonable, Full).. Valid values are `None|Limited|Reasonable|Full`',
    `carbon_footprint_kg_co2e` DECIMAL(18,2) COMMENT 'Total greenhouse‑gas emissions for the reporting period expressed in kilograms of CO₂ equivalent.',
    `cdp_score` DECIMAL(18,2) COMMENT 'Score assigned by CDP for climate change performance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ESG disclosure record was first created in the system.',
    `data_gap_description` STRING COMMENT 'Narrative description of any data gaps or missing information.',
    `data_gap_flag` BOOLEAN COMMENT 'True if the disclosure contains material data gaps identified during review.',
    `disclosure_name` STRING COMMENT 'Human‑readable name of the ESG disclosure (e.g., FY2023 Sustainability Report).',
    `disclosure_number` STRING COMMENT 'Business identifier or reference number assigned to the disclosure by the organization.',
    `disclosure_status` STRING COMMENT 'Current lifecycle status of the disclosure (draft, submitted, approved, published, retracted).',
    `environmental_score` DECIMAL(18,2) COMMENT 'Environmental pillar score (0‑100) from the rating agency.',
    `external_rating_agency` STRING COMMENT 'Third‑party ESG rating provider that issued a rating for the disclosed period.. Valid values are `MSCI|Sustainalytics|ISS ESG|CDP|DJSI|FTSE4Good`',
    `framework` STRING COMMENT 'The ESG reporting framework used for this disclosure.. Valid values are `GRI|CDP|TCFD|CSRD|ESRS`',
    `framework_version` STRING COMMENT 'Version of the reporting framework (e.g., GRI Standards 2021).',
    `governance_score` DECIMAL(18,2) COMMENT 'Governance pillar score (0‑100) from the rating agency.',
    `gri_disclosure_topic` STRING COMMENT 'Specific GRI topic(s) covered in the disclosure (e.g., Energy, Water, Waste).',
    `index_membership_status` STRING COMMENT 'Indicates whether the company is included in ESG indices (e.g., DJSI).. Valid values are `included|excluded|pending`',
    `investor_inquiry_count` STRING COMMENT 'Number of investor inquiries received regarding this ESG disclosure.',
    `overall_score` DECIMAL(18,2) COMMENT 'Aggregated ESG score (0‑100) provided by the rating agency.',
    `publication_date` DATE COMMENT 'Date the ESG disclosure was made publicly available.',
    `publication_url` STRING COMMENT 'Web address where the published ESG disclosure can be accessed.',
    `rating_category` STRING COMMENT 'Qualitative rating tier (e.g., AAA, AA, A, BBB, etc.) assigned by the agency.',
    `rating_date` DATE COMMENT 'Date the external ESG rating was published.',
    `rating_methodology_version` STRING COMMENT 'Version identifier of the rating agencys methodology used for this assessment.',
    `renewable_energy_usage_percent` DECIMAL(18,2) COMMENT 'Share of total energy consumption sourced from renewable energy.',
    `reporting_period_end` DATE COMMENT 'End date of the reporting period covered by the disclosure.',
    `reporting_period_start` DATE COMMENT 'Start date of the reporting period covered by the disclosure.',
    `responsible_sourcing_certifications` STRING COMMENT 'List of sustainability certifications held for raw material sourcing.. Valid values are `Rainforest Alliance|Fair Trade|UTZ|Organic`',
    `scope` STRING COMMENT 'Scope of emissions reported (Scope 1, Scope 2, Scope 3, or Combined).. Valid values are `Scope 1|Scope 2|Scope 3|Combined`',
    `score_detractor_summary` STRING COMMENT 'Key factors that negatively impacted the ESG score.',
    `score_driver_summary` STRING COMMENT 'Key factors that positively influenced the ESG score.',
    `social_score` DECIMAL(18,2) COMMENT 'Social pillar score (0‑100) from the rating agency.',
    `submission_date` DATE COMMENT 'Date the ESG disclosure was submitted to the reporting platform or regulator.',
    `submission_method` STRING COMMENT 'Channel used to submit the disclosure (portal, email, API, manual upload).. Valid values are `portal|email|api|manual`',
    `submitted_by` STRING COMMENT 'Name or identifier of the internal stakeholder who submitted the disclosure.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the ESG disclosure record.',
    `verification_status` STRING COMMENT 'Indicates whether the disclosure has been externally verified, assured, or remains unverified.. Valid values are `unverified|verified|assured`',
    `waste_generated_kg` DECIMAL(18,2) COMMENT 'Total waste generated (non‑recyclable) in kilograms for the reporting period.',
    `water_usage_m3` DECIMAL(18,2) COMMENT 'Total volume of water consumed in production processes during the reporting period.',
    CONSTRAINT pk_esg_disclosure PRIMARY KEY(`esg_disclosure_id`)
) COMMENT 'Master record for the complete ESG reporting lifecycle — from disclosure preparation through submission to external rating receipt and peer benchmarking. Captures formal ESG disclosure submissions (reporting period, framework version for GRI, CDP, TCFD, CSRD/ESRS, disclosure scope, verification status, assurance level, submission metadata) and external ESG ratings received from third-party agencies (MSCI, Sustainalytics, ISS ESG, CDP scores, DJSI/FTSE4Good index membership), including rating methodology version, overall score and pillar sub-scores (E/S/G), rating category or tier, assessment date, prior period comparison, score drivers/detractors, data gaps flagged, index inclusion/exclusion status, and investor inquiry tracking. Provides unified ownership of the disclose-rate-benchmark cycle for investor relations and targeted ESG improvement planning.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` (
    `carbon_footprint_id` BIGINT COMMENT 'Unique system-generated identifier for each carbon footprint record.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to maintenance.asset. Business justification: Regulatory GHG reporting requires emissions per equipment; linking carbon_footprint to asset enables asset‑level Scope 1 accounting.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing or distribution facility where emissions were generated.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Carbon footprint reporting for R&D projects is required for internal sustainability KPIs and external ESG disclosures.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Carbon footprint data is compiled and reported by a designated employee; linking supports internal reporting and audit.',
    `sku_id` BIGINT COMMENT 'Identifier of the Stock Keeping Unit (SKU) to which the carbon footprint applies.',
    `allocation_method` STRING COMMENT 'Method used to allocate emissions to the SKU (by mass, energy consumption, economic value, or process step).. Valid values are `mass|energy|economic|process`',
    `calculation_date` DATE COMMENT 'Date on which the carbon footprint was calculated.',
    `carbon_footprint_status` STRING COMMENT 'Current lifecycle state of the carbon footprint record.. Valid values are `active|inactive|archived`',
    `carbon_intensity_per_unit` DECIMAL(18,2) COMMENT 'Emission intensity expressed as CO2e per unit of product (e.g., kg CO2e per kg product).',
    `carbon_offset_quantity` DECIMAL(18,2) COMMENT 'Amount of carbon offsets (tonnes CO2e) applied against the recorded emissions.',
    `confidence_interval_high` DECIMAL(18,2) COMMENT 'Upper bound of the statistical confidence interval for the emission amount.',
    `confidence_interval_low` DECIMAL(18,2) COMMENT 'Lower bound of the statistical confidence interval for the emission amount.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the carbon footprint record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Score (0‑100) reflecting confidence in the data quality of the record.',
    `data_source_type` STRING COMMENT 'Nature of the source data – whether it is directly measured, estimated, or model‑derived.. Valid values are `measured|estimated|modeled`',
    `emission_amount` DECIMAL(18,2) COMMENT 'Total greenhouse gas emissions expressed in metric tonnes of CO2 equivalent.',
    `emission_factor_source` STRING COMMENT 'Reference for the emission factor used (e.g., EPA, EU ETS, company‑specific database).',
    `emission_type` STRING COMMENT 'Type of greenhouse gas measured (CO2 equivalent, methane, nitrous oxide, sulfur hexafluoride).. Valid values are `CO2e|CH4|N2O|SF6`',
    `footprint_code` STRING COMMENT 'Human‑readable business code assigned to the carbon footprint record.',
    `footprint_type` STRING COMMENT 'Classification of the footprint based on its origin within the value chain.. Valid values are `direct|indirect|upstream|downstream`',
    `footprint_version` STRING COMMENT 'Version identifier for the calculation methodology or data set.',
    `is_boundary_crossing` BOOLEAN COMMENT 'Indicates whether the emissions cross geographic or operational boundaries.',
    `is_renewable` BOOLEAN COMMENT 'True if the energy used for the emissions is sourced from renewable resources.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last updated the record.',
    `methodology` STRING COMMENT 'Methodology or standard used to calculate the emissions.. Valid values are `GHG Protocol|ISO 14064|Company Specific`',
    `notes` STRING COMMENT 'Free‑form comments or observations about the carbon footprint record.',
    `offset_type` STRING COMMENT 'Category of offset used (e.g., project‑based, purchased credits, internal reductions).. Valid values are `project|purchase|internal`',
    `offset_verification_status` STRING COMMENT 'Verification state of the carbon offsets applied.. Valid values are `verified|pending`',
    `record_name` STRING COMMENT 'Descriptive name for the carbon footprint entry (e.g., "2023 Q2 SKU‑12345 Facility‑A").',
    `renewable_energy_percentage` DECIMAL(18,2) COMMENT 'Share of renewable energy used in the facility expressed as a percentage of total energy consumption.',
    `reporting_period` STRING COMMENT 'Period within the reporting year (quarter or annual) covered by the record.. Valid values are `Q1|Q2|Q3|Q4|Annual`',
    `reporting_standard` STRING COMMENT 'External sustainability reporting framework to which this record aligns.. Valid values are `CDP|GRI|SASB|TCFD`',
    `reporting_year` STRING COMMENT 'Calendar year for which the carbon emissions are reported.',
    `scope` STRING COMMENT 'Scope classification of emissions per the GHG Protocol (direct, indirect, value‑chain).. Valid values are `Scope 1|Scope 2|Scope 3`',
    `source_data_reference` STRING COMMENT 'Reference to the underlying data (e.g., energy bills, material usage) used for the calculation.',
    `source_system` STRING COMMENT 'Originating system that supplied the underlying data for the carbon calculation.. Valid values are `MES|ERP|Manual`',
    `unit_of_measure` STRING COMMENT 'Unit used for the emission amount (tonnes or kilograms).. Valid values are `tonnes|kg`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    `verification_date` DATE COMMENT 'Date when the emissions data was verified.',
    `verification_status` STRING COMMENT 'Current verification state of the emissions figure.. Valid values are `verified|pending|rejected`',
    `verified_by` STRING COMMENT 'Name of the internal auditor or external verifier who approved the emissions data.',
    CONSTRAINT pk_carbon_footprint PRIMARY KEY(`carbon_footprint_id`)
) COMMENT 'SKU-level and facility-level carbon footprint records capturing Scope 1 (direct emissions from owned/controlled sources), Scope 2 (indirect emissions from purchased energy), and Scope 3 (value chain emissions including raw material sourcing, transportation, and end-of-life) greenhouse gas emissions measured in CO2-equivalent tonnes. Aligned with GHG Protocol methodology and CDP reporting requirements.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sustainability`.`water_usage` (
    `water_usage_id` BIGINT COMMENT 'Unique identifier for each water usage measurement record.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to maintenance.asset. Business justification: Water stewardship program tracks water consumption per machine; asset link provides equipment‑level usage for permit compliance.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant or facility where the water measurement was recorded.',
    `production_line_id` BIGINT COMMENT 'Identifier of the specific production line or equipment group within the facility.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Water usage measurements are entered by plant operators; the FK records the employee responsible for each entry.',
    `sku_id` BIGINT COMMENT 'Identifier of the product SKU associated with the water consumption measurement.',
    `compliance_status` STRING COMMENT 'Current compliance status of the facility with water usage regulations and permits.. Valid values are `compliant|non_compliant|pending`',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date and time when the water measurement was captured at the source.',
    `measurement_unit` STRING COMMENT 'Unit used for all water volume measurements (cubic meters).. Valid values are `cubic_meters`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the water usage record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the water usage record.',
    `reporting_period` DATE COMMENT 'Calendar date (typically the day) for which the water usage data is reported.',
    `source_system` STRING COMMENT 'Name of the operational system that generated the water usage record.',
    `water_consumption` DECIMAL(18,2) COMMENT 'Volume of water actually consumed in the manufacturing process, measured in cubic meters.',
    `water_discharge` DECIMAL(18,2) COMMENT 'Volume of water discharged (e.g., effluent) after use, measured in cubic meters.',
    `water_intensity_per_unit` DECIMAL(18,2) COMMENT 'Water consumption normalized to the produced SKU quantity (cubic meters per unit of product).',
    `water_recycled` DECIMAL(18,2) COMMENT 'Volume of water that is captured and reused within the facility, measured in cubic meters.',
    `water_source_type` STRING COMMENT 'Classification of the water source for the recorded usage.. Valid values are `municipal|groundwater|rainwater|recycled`',
    `water_stress_risk` STRING COMMENT 'Risk classification of water availability at the facility location based on local water stress indices.. Valid values are `low|medium|high`',
    `water_withdrawal` DECIMAL(18,2) COMMENT 'Total volume of water withdrawn from the source for production activities, measured in cubic meters.',
    CONSTRAINT pk_water_usage PRIMARY KEY(`water_usage_id`)
) COMMENT 'Operational water consumption records at the plant and production line level, capturing total water withdrawal, water consumption, water discharge, and water recycled/reused volumes in cubic meters. Tracks water stress risk by facility location, water intensity per unit of production, and compliance with local water stewardship targets. Supports GRI 303 and CDP Water Security disclosures.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` (
    `energy_consumption_id` BIGINT COMMENT 'System‑generated unique identifier for each energy consumption record.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to maintenance.asset. Business justification: Energy‑efficiency initiatives (ISO 50001) require energy data per equipment; FK ties consumption to the specific asset.',
    `plant_id` BIGINT COMMENT 'Unique identifier of the manufacturing or processing facility where the energy measurement was taken.',
    `production_line_id` BIGINT COMMENT 'Unique identifier of the specific production line or equipment group within the facility.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Energy consumption logs are captured by a responsible employee; linking enables accountability and energy efficiency initiatives.',
    `carbon_emission_kg` DECIMAL(18,2) COMMENT 'Scope‑based CO₂ equivalent emissions associated with the energy consumption, expressed in kilograms.',
    `carbon_intensity_kg_per_mwh` DECIMAL(18,2) COMMENT 'Carbon emissions per megawatt‑hour of energy consumed, enabling GHG intensity reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the lakehouse.',
    `data_source_system` STRING COMMENT 'Originating system that supplied the measurement (e.g., MES, ERP, EMS).',
    `electricity_mwh` DECIMAL(18,2) COMMENT 'Energy drawn from the electrical grid, measured in megawatt‑hours.',
    `emission_scope` STRING COMMENT 'GHG accounting scope applicable to the emission figure (Scope 1, Scope 2, or Scope 3).. Valid values are `scope1|scope2|scope3`',
    `energy_intensity_mwh_per_tonne` DECIMAL(18,2) COMMENT 'Energy used per metric tonne of product produced, supporting efficiency analysis.',
    `energy_total_mwh` DECIMAL(18,2) COMMENT 'Aggregate energy consumption for the reporting period expressed in megawatt‑hours.',
    `fuel_oil_mwh` DECIMAL(18,2) COMMENT 'Energy from fuel oil used in the facility, expressed in megawatt‑hours.',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date‑time when the energy consumption reading was recorded (ISO‑8601).',
    `measurement_type` STRING COMMENT 'Indicates whether the energy data follows location‑based (physical consumption) or market‑based (purchased electricity) methodology.. Valid values are `location_based|market_based`',
    `natural_gas_mwh` DECIMAL(18,2) COMMENT 'Energy derived from natural gas combustion, expressed in megawatt‑hours.',
    `production_quantity_tonnes` DECIMAL(18,2) COMMENT 'Total weight of product manufactured during the reporting period, in metric tonnes.',
    `record_status` STRING COMMENT 'Current lifecycle state of the record for data governance.. Valid values are `active|inactive|archived`',
    `renewable_energy_mwh` DECIMAL(18,2) COMMENT 'Portion of total energy sourced from renewable generation (solar, wind, biomass) in megawatt‑hours.',
    `renewable_percentage` DECIMAL(18,2) COMMENT 'Share of renewable energy relative to total consumption, expressed as a percentage.',
    `reporting_date` DATE COMMENT 'Calendar date for which the energy data is reported (used for daily/weekly/monthly aggregation).',
    `steam_mwh` DECIMAL(18,2) COMMENT 'Energy supplied as steam, converted to megawatt‑hours for consistency.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    CONSTRAINT pk_energy_consumption PRIMARY KEY(`energy_consumption_id`)
) COMMENT 'Facility and production-line level energy consumption records tracking total energy use (MWh), energy source breakdown (natural gas, electricity, steam, fuel oil), renewable energy percentage, and energy intensity per tonne of product manufactured. Captures on-site renewable generation (solar, wind) and purchased renewable energy certificates (RECs). Supports Scope 2 market-based and location-based emissions calculations and GRI 302 disclosures.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` (
    `waste_generation_id` BIGINT COMMENT 'Primary key for waste_generation',
    `asset_id` BIGINT COMMENT 'Foreign key linking to maintenance.asset. Business justification: Waste reduction targets are measured per equipment; linking waste records to asset supports landfill‑diversion reporting.',
    `inbound_shipment_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_shipment. Business justification: Waste tracking process ties waste generated to the inbound shipment that delivered the material, enabling waste per shipment analysis.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing or distribution facility where waste was generated.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Waste Management Reporting requires the employee who logged the waste record; linking waste_generation to employee enables accountability and audit trails.',
    `carbon_footprint_kg_co2e` DECIMAL(18,2) COMMENT 'Estimated greenhouse gas emissions associated with the waste generation, expressed in kilograms of CO₂ equivalent.',
    `cdpi_disclosure_flag` BOOLEAN COMMENT 'Indicates whether the waste data is included in the CDP climate disclosure submission.',
    `certification_body` STRING COMMENT 'Organization that issued the waste certification.',
    `certification_status` STRING COMMENT 'Current status of any waste-related certification (e.g., zero-waste, ISO 14001).. Valid values are `certified|not_certified|pending`',
    `disposal_method` STRING COMMENT 'Method used to dispose or treat the waste.. Valid values are `landfill|incineration|composting|recycling|anaerobic_digestion`',
    `gri_section` STRING COMMENT 'GRI standard section code that this waste record maps to (e.g., 306-1).',
    `notes` STRING COMMENT 'Free-text field for additional comments or observations about the waste record.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the waste record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the waste record.',
    `reporting_period` STRING COMMENT 'Fiscal or calendar period for which the waste data is reported (e.g., FY2025 Q1).',
    `responsible_department` STRING COMMENT 'Internal department accountable for the waste generation and reporting.',
    `source_process` STRING COMMENT 'Production or operational process that generated the waste (e.g., mixing, cleaning, packaging).',
    `waste_amount_kg` DECIMAL(18,2) COMMENT 'Total weight of waste generated, measured in kilograms.',
    `waste_date` DATE COMMENT 'Calendar date on which the waste was generated.',
    `waste_diversion_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of waste diverted from landfill to recycling or other recovery methods.',
    `waste_generation_status` STRING COMMENT 'Current lifecycle status of the waste record.. Valid values are `recorded|verified|rejected|closed`',
    `waste_record_number` STRING COMMENT 'Business-visible sequential number assigned to the waste record for tracking and reporting.',
    `waste_timestamp` TIMESTAMP COMMENT 'Exact timestamp of waste generation event.',
    `waste_type` STRING COMMENT 'Classification of waste by material composition.. Valid values are `organic|plastic|paper|hazardous|non_hazardous|metal`',
    `waste_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of waste generated, measured in cubic meters.',
    `zero_waste_to_landfill` BOOLEAN COMMENT 'Indicates whether the facility achieved zero waste to landfill for the reporting period.',
    CONSTRAINT pk_waste_generation PRIMARY KEY(`waste_generation_id`)
) COMMENT 'Manufacturing and facility waste generation records capturing total waste by type (organic, plastic, paper, hazardous, non-hazardous), disposal method (landfill, incineration, composting, recycling, anaerobic digestion), waste diversion rate, and zero-waste-to-landfill certification status. Tracks food waste separately per USDA/EPA food waste reduction hierarchy. Supports GRI 306 Waste disclosures and circular economy program tracking.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` (
    `packaging_profile_id` BIGINT COMMENT 'System-generated unique identifier for the packaging profile record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Packaging designs are created by a packaging engineer (employee); the FK ties packaging profiles to their designer for change management.',
    `barcode` STRING COMMENT 'Global Trade Item Number or UPC associated with the packaging configuration.',
    `carbon_footprint_kg_co2e` DECIMAL(18,2) COMMENT 'Scope 3 greenhouse‑gas emissions associated with producing the packaging, expressed in kilograms CO₂‑equivalent.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the packaging profile record was first created in the system.',
    `effective_from` DATE COMMENT 'Date from which the packaging profile becomes valid for use.',
    `effective_until` DATE COMMENT 'Date after which the packaging profile is no longer valid (null if open‑ended).',
    `epr_compliance_flag` BOOLEAN COMMENT 'True if the packaging meets applicable Extended Producer Responsibility regulatory requirements.',
    `epr_regulation` STRING COMMENT 'Specific EPR law or program applicable (e.g., "EU Packaging Waste Directive").',
    `height_cm` DECIMAL(18,2) COMMENT 'External height dimension of the packaging component in centimeters.',
    `length_cm` DECIMAL(18,2) COMMENT 'External length dimension of the packaging component in centimeters.',
    `lightweighting_initiative_flag` BOOLEAN COMMENT 'Indicates whether the packaging is part of a lightweighting program aimed at reducing material usage.',
    `material` STRING COMMENT 'Primary material of the packaging component (e.g., PET, HDPE, glass).. Valid values are `PET|HDPE|GLASS|ALUMINUM|PAPERBOARD|BIO_BASED`',
    `material_composition` STRING COMMENT 'Detailed description of material layers or blends (e.g., "70% PET / 30% recycled PET").',
    `packaging_profile_code` STRING COMMENT 'Business code or SKU‑level identifier used in ERP and supply‑chain systems.',
    `packaging_profile_name` STRING COMMENT 'Human‑readable name describing the packaging configuration (e.g., "12‑oz PET Bottle").',
    `packaging_profile_status` STRING COMMENT 'Current lifecycle status of the packaging profile.. Valid values are `active|inactive|discontinued`',
    `packaging_type` STRING COMMENT 'Classification of the packaging level: primary (direct container), secondary (carton), or tertiary (pallet/ship‑per).. Valid values are `primary|secondary|tertiary`',
    `packaging_weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the packaging component in kilograms.',
    `recyclability_rating` STRING COMMENT 'Standardized rating indicating how easily the packaging can be recycled under typical municipal programs.. Valid values are `non_recyclable|recyclable|recyclable_with_caution|highly_recyclable`',
    `recycled_content_pct` DECIMAL(18,2) COMMENT 'Percentage of the packaging weight that consists of post‑consumer or post‑industrial recycled material.',
    `shelf_life_days` STRING COMMENT 'Maximum number of days the packaged product can remain on shelf before quality degrades.',
    `source_system` STRING COMMENT 'Originating operational system of record for this packaging data (e.g., "SAP S/4HANA MM").',
    `sustainability_target_year` STRING COMMENT 'Fiscal year by which the packaging target (e.g., 100% recyclable) is intended to be achieved.',
    `target_recyclable_by_year` STRING COMMENT 'Calendar year by which this packaging is expected to be fully recyclable according to corporate goals.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the packaging profile record.',
    `volume_liters` DECIMAL(18,2) COMMENT 'Internal volume capacity of the packaging, useful for logistics and shelf‑space calculations.',
    `waste_reduction_kg` DECIMAL(18,2) COMMENT 'Weight of waste avoided through design improvements or material substitution.',
    `water_usage_liters` DECIMAL(18,2) COMMENT 'Total volume of water consumed in the manufacturing of the packaging component.',
    `width_cm` DECIMAL(18,2) COMMENT 'External width dimension of the packaging component in centimeters.',
    CONSTRAINT pk_packaging_profile PRIMARY KEY(`packaging_profile_id`)
) COMMENT 'Master data for packaging materials used across the F&B SKU portfolio, capturing packaging type (primary, secondary, tertiary), material composition (PET, HDPE, glass, aluminum, paperboard, bio-based), recyclability rating, recycled content percentage, packaging weight, lightweighting initiatives, and compliance with extended producer responsibility (EPR) regulations. Tracks progress against packaging sustainability targets (e.g., 100% recyclable by 2025).';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` (
    `sourcing_certification_id` BIGINT COMMENT 'Primary key for sourcing_certification',
    `raw_material_id` BIGINT COMMENT 'Unique identifier of the ingredient or raw material covered by the certification.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier or farm providing the ingredient.',
    `audit_date` DATE COMMENT 'Date of the most recent audit that validated the certification.',
    `audit_result` STRING COMMENT 'Outcome of the most recent audit.. Valid values are `pass|fail|conditional|not_applicable`',
    `audit_scope` STRING COMMENT 'Description of the audit coverage (e.g., farm level, processing facility).',
    `certificate_number` STRING COMMENT 'External identifier assigned by the certification body to the certification.',
    `certification_body` STRING COMMENT 'Organization that issued the certification (e.g., Rainforest Alliance, Fair Trade USA).',
    `certification_type` STRING COMMENT 'Category of responsible sourcing certification (e.g., Rainforest Alliance, Fair Trade).. Valid values are `Rainforest Alliance|Fair Trade|RSPO|UTZ|Organic|Non-GMO`',
    `comments` STRING COMMENT 'Free‑text field for additional notes or observations.',
    `coverage_percentage` DECIMAL(18,2) COMMENT 'Portion of total ingredient volume covered by the certification, expressed as a percent.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification record was first created in the system.',
    `documentation_url` STRING COMMENT 'Link to the digital copy of the certification document.',
    `effective_from` DATE COMMENT 'Date from which the certification is considered effective for compliance reporting.',
    `effective_until` DATE COMMENT 'Date until which the certification remains effective; null if open‑ended.',
    `expiry_date` DATE COMMENT 'Date the certification expires unless renewed.',
    `issue_date` DATE COMMENT 'Date the certification was originally issued.',
    `renewal_date` DATE COMMENT 'Planned date for certification renewal.',
    `renewal_required` BOOLEAN COMMENT 'Indicates whether the certification is due for renewal.',
    `sourcing_certification_status` STRING COMMENT 'Current lifecycle status of the certification.. Valid values are `active|expired|revoked|pending`',
    `total_volume_certified` DECIMAL(18,2) COMMENT 'Total quantity of the ingredient (in unit_of_measure) that is certified.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for total_volume_certified (e.g., kilogram, pound).. Valid values are `kg|lb|ton`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certification record.',
    CONSTRAINT pk_sourcing_certification PRIMARY KEY(`sourcing_certification_id`)
) COMMENT 'Certification records for responsibly sourced ingredients and raw materials, capturing certification type (Rainforest Alliance, Fair Trade, RSPO for palm oil, UTZ, organic, non-GMO), certified supplier or farm, certification body, certificate number, issue date, expiry date, audit scope, and coverage percentage of total ingredient volume. Links to procurement and ingredient domains for traceability from farm to finished product. Supports GRI 308 Supplier Environmental Assessment and GRI 414 Supplier Social Assessment disclosures.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` (
    `supplier_esg_score_id` BIGINT COMMENT 'System-generated unique identifier for each ESG assessment record.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier being assessed.',
    `anti_corruption_score` DECIMAL(18,2) COMMENT 'Score assessing anti-corruption policies and practices.',
    `assessment_methodology` STRING COMMENT 'Methodology used to assess ESG performance.. Valid values are `EcoVadis|Sedex|Proprietary`',
    `assessment_number` STRING COMMENT 'Business identifier for the ESG assessment, e.g., ESG-000123.',
    `assessment_timestamp` TIMESTAMP COMMENT 'Date and time when the ESG assessment was performed.',
    `assessor_contact` STRING COMMENT 'Email address of the assessor for follow‑up communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `assessor_name` STRING COMMENT 'Name of the individual or organization conducting the ESG assessment.',
    `carbon_emissions_kg_co2e` DECIMAL(18,2) COMMENT 'Total carbon emissions attributable to the supplier, expressed in kilograms of CO2 equivalent.',
    `community_impact_score` DECIMAL(18,2) COMMENT 'Score reflecting the suppliers contributions to local communities.',
    `environmental_score` DECIMAL(18,2) COMMENT 'Composite environmental performance score (0-100) for the supplier.',
    `governance_score` DECIMAL(18,2) COMMENT 'Composite governance performance score (0-100) for the supplier.',
    `human_rights_score` DECIMAL(18,2) COMMENT 'Score measuring compliance with human rights standards.',
    `improvement_action_plan_status` STRING COMMENT 'Current status of the suppliers ESG improvement action plan.. Valid values are `not_started|in_progress|completed|deferred`',
    `labor_practices_score` DECIMAL(18,2) COMMENT 'Score evaluating labor standards, wages, and working conditions.',
    `next_assessment_due_date` DATE COMMENT 'Planned date for the next ESG assessment of the supplier.',
    `notes` STRING COMMENT 'Free‑form notes captured during the ESG assessment.',
    `overall_esg_rating` STRING COMMENT 'Overall ESG rating derived from component scores. [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|CCC|CC|C — promote to reference product]',
    `packaging_recyclability_percent` DECIMAL(18,2) COMMENT 'Percentage of the suppliers packaging that is recyclable.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this assessment record was first captured in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to this assessment record.',
    `renewable_energy_percent` DECIMAL(18,2) COMMENT 'Proportion of the suppliers energy consumption sourced from renewable resources.',
    `scope1_emissions_kg` DECIMAL(18,2) COMMENT 'Direct greenhouse gas emissions (Scope 1) from the supplier, in kilograms CO2e.',
    `scope2_emissions_kg` DECIMAL(18,2) COMMENT 'Indirect emissions from purchased electricity, heat, or steam (Scope 2), in kilograms CO2e.',
    `scope3_emissions_kg` DECIMAL(18,2) COMMENT 'All other indirect emissions (Scope 3) associated with the suppliers value chain, in kilograms CO2e.',
    `social_score` DECIMAL(18,2) COMMENT 'Composite social performance score (0-100) for the supplier.',
    `supplier_esg_score_status` STRING COMMENT 'Current lifecycle status of the ESG assessment.. Valid values are `pending|completed|reviewed|rejected`',
    `transparency_score` DECIMAL(18,2) COMMENT 'Score evaluating the transparency of the suppliers operations and reporting.',
    `waste_generated_kg` DECIMAL(18,2) COMMENT 'Quantity of waste produced by the supplier, measured in kilograms.',
    `water_usage_liters` DECIMAL(18,2) COMMENT 'Total water consumption associated with the suppliers operations, measured in liters.',
    CONSTRAINT pk_supplier_esg_score PRIMARY KEY(`supplier_esg_score_id`)
) COMMENT 'Periodic sustainability performance assessment records for ingredient and packaging suppliers, capturing environmental score (carbon, water, waste), social score (labor practices, community impact, human rights), governance score (anti-corruption, transparency), overall ESG rating, assessment methodology (EcoVadis, Sedex, proprietary), assessment date, and improvement action plan status. Drives responsible sourcing decisions and supplier development programs.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sustainability`.`target` (
    `target_id` BIGINT COMMENT 'Unique system-generated identifier for the sustainability target record.',
    `initiative_id` BIGINT COMMENT 'FK to sustainability.sustainability_initiative',
    `actual_impact_co2e` DECIMAL(18,2) COMMENT 'Measured CO2e reduction (metric tons) achieved to date.',
    `actual_value` DECIMAL(18,2) COMMENT 'Most recent measured value for the metric during the reporting period.',
    `baseline_value` DECIMAL(18,2) COMMENT 'Measured value of the metric in the baseline year.',
    `baseline_year` STRING COMMENT 'Calendar year representing the starting point for the target baseline.',
    `capital_investment` DECIMAL(18,2) COMMENT 'Capital spend allocated to the initiative (currency units).',
    `contributing_factors` STRING COMMENT 'Narrative description of key drivers influencing performance (e.g., process changes, regulatory impacts).',
    `effective_from` DATE COMMENT 'Date when the sustainability target becomes active.',
    `effective_until` DATE COMMENT 'Date when the sustainability target expires or is superseded (nullable).',
    `esg_pillar` STRING COMMENT 'High‑level ESG pillar to which the target belongs.. Valid values are `environment|social|governance`',
    `implementation_status` STRING COMMENT 'Current execution status of the linked initiative.. Valid values are `planned|in_progress|completed|on_hold|cancelled`',
    `interim_milestone_value` DECIMAL(18,2) COMMENT 'Metric value expected at the interim milestone year.',
    `interim_milestone_year` STRING COMMENT 'Year of an intermediate milestone toward the final target.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the target record.. Valid values are `draft|active|suspended|completed|retired`',
    `measurement_period` STRING COMMENT 'Frequency at which actual performance is measured against the target.. Valid values are `annual|quarterly|monthly`',
    `metric_type` STRING COMMENT 'The measurement type used for the target (e.g., CO2e, liters, kilograms, percent, units).. Valid values are `co2e|liters|kg|percent|units`',
    `narrative_commentary` STRING COMMENT 'Free‑text commentary for quarterly ESG board reporting.',
    `operating_cost_savings` DECIMAL(18,2) COMMENT 'Annual operating cost savings realized from the initiative.',
    `owning_business_unit` STRING COMMENT 'Code of the business unit responsible for the target and its initiatives.',
    `payback_period_months` STRING COMMENT 'Number of months required to recoup the capital investment.',
    `percent_of_target_met` DECIMAL(18,2) COMMENT 'Percentage of the target value achieved to date (e.g., 78.45%).',
    `phase_gate` STRING COMMENT 'Current phase‑gate milestone within the initiative lifecycle.. Valid values are `gate1|gate2|gate3`',
    `projected_impact_co2e` DECIMAL(18,2) COMMENT 'Estimated CO2e reduction (metric tons) expected from the initiative.',
    `public_disclosure` BOOLEAN COMMENT 'Indicates whether the target is publicly disclosed in ESG reports (true/false).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the target record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the target record.',
    `roi_percent` DECIMAL(18,2) COMMENT 'ROI expressed as a percentage.',
    `sbti_validation_status` STRING COMMENT 'Status of external validation by the Science‑Based Targets initiative.. Valid values are `validated|pending|rejected`',
    `scope` STRING COMMENT 'Greenhouse gas emission scope covered by the target (Scope 1, 2, 3, or combinations).. Valid values are `scope1|scope2|scope3|scope1_2|scope1_2_3`',
    `target_category` STRING COMMENT 'High‑level category of the target such as carbon emissions, water usage, waste reduction, energy efficiency, packaging recyclability, or social impact.. Valid values are `carbon|water|waste|energy|packaging|social`',
    `target_name` STRING COMMENT 'Descriptive name of the sustainability target (e.g., "2025 Carbon Emission Reduction").',
    `target_value` DECIMAL(18,2) COMMENT 'Desired metric value to be reached by the target year.',
    `unit_of_measure` STRING COMMENT 'Specific unit associated with the metric (e.g., metric tons CO2e, cubic meters, kilograms).',
    `variance` DECIMAL(18,2) COMMENT 'Difference between actual performance and the projected trajectory, expressed as a percentage.',
    `year` STRING COMMENT 'Calendar year by which the sustainability target is intended to be achieved.',
    CONSTRAINT pk_target PRIMARY KEY(`target_id`)
) COMMENT 'Comprehensive record of corporate and facility-level sustainability commitments, science-based targets, progress tracking, and implementation initiatives. Captures target definition (category, baseline year/value, target year/value, interim milestones, SBTi validation status, public commitment disclosure), periodic progress measurements (measurement period, actual value achieved, percentage of target met, variance from trajectory, contributing factors, narrative commentary for quarterly ESG board reporting), and linked improvement initiatives/projects (initiative name, ESG pillar, category, owning business unit, implementation status, phase gates, projected and actual environmental impact in CO2e/water/waste, capital investment, operating cost savings, payback period, ROI). Enables end-to-end portfolio management of ESG commitments from goal-setting through project execution to outcome reporting for quarterly board reviews, annual CDP/GRI disclosures, and investor communications.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sustainability`.`target_progress` (
    `target_progress_id` BIGINT COMMENT 'Unique identifier for each sustainability target progress record.',
    `plant_id` BIGINT COMMENT 'Identifier of the plant or facility where the measurement originated.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Target progress tracks sustainability metrics per SKU; FK provides reliable linkage.',
    `target_id` BIGINT COMMENT 'Identifier of the sustainability target to which this progress record relates.',
    `actual_value` DECIMAL(18,2) COMMENT 'The actual observed value for the sustainability metric (e.g., kg CO2e, m3 water).',
    `carbon_intensity` DECIMAL(18,2) COMMENT 'Carbon emissions per unit of product (e.g., kg CO2e per kg product).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this progress record was first created in the system.',
    `data_quality_flag` BOOLEAN COMMENT 'Indicates whether the measurement passed data quality validation (true=valid).',
    `initiative_contributions` STRING COMMENT 'Narrative of initiatives that contributed to the measured performance.',
    `measurement_period_end` DATE COMMENT 'End date of the reporting period for which the measurement applies.',
    `measurement_period_start` DATE COMMENT 'Start date of the reporting period for which the measurement applies.',
    `measurement_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the measurement was recorded.',
    `measurement_type` STRING COMMENT 'Category of sustainability metric (e.g., Scope 1 emissions, water usage).. Valid values are `scope1|scope2|scope3|energy|water|waste`',
    `percent_of_target_met` DECIMAL(18,2) COMMENT 'Percentage of the target achieved (actual / target * 100).',
    `region` STRING COMMENT 'Three‑letter ISO country code representing the region of the measurement.. Valid values are `^[A-Z]{3}$`',
    `reporting_framework` STRING COMMENT 'External reporting framework used for disclosure of this metric.. Valid values are `GRI|CDP|SASB|TCFD|ISSB`',
    `source_system` STRING COMMENT 'System of record that supplied the measurement data.. Valid values are `SAP_IBP|MES|TraceGains|ERP`',
    `target_progress_status` STRING COMMENT 'Current status of progress toward the target for the period.. Valid values are `on_track|behind|exceeded|not_started|completed`',
    `target_value` DECIMAL(18,2) COMMENT 'The predefined target value for the metric for the same period.',
    `unit_of_measure` STRING COMMENT 'Unit in which the metric is expressed (e.g., kg CO2e, m3, %).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this progress record.',
    `variance` DECIMAL(18,2) COMMENT 'Numeric difference between actual value and target value.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage difference between actual and target values.',
    `waste_reduction_percent` DECIMAL(18,2) COMMENT 'Percentage reduction in waste generated compared to baseline.',
    `water_intensity` DECIMAL(18,2) COMMENT 'Water usage per unit of product (e.g., liters per kg product).',
    CONSTRAINT pk_target_progress PRIMARY KEY(`target_progress_id`)
) COMMENT 'Periodic progress measurement records tracking actual performance against each sustainability target, capturing measurement period, actual value achieved, percentage of target met, variance from trajectory, contributing initiatives, and narrative commentary. Supports quarterly ESG board reporting and annual CDP/GRI disclosure progress sections.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sustainability`.`circular_program` (
    `circular_program_id` BIGINT COMMENT 'Unique system-generated identifier for the circular economy program.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_initiative. Business justification: Circular economy programs are implemented as sustainability initiatives; linking program to its initiative provides hierarchy.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Circular Economy Program Management assigns a program manager employee; the link supports program governance and performance reporting.',
    `activity_cost_usd` DECIMAL(18,2) COMMENT 'Direct cost incurred for the activity, expressed in US dollars.',
    `activity_date` DATE COMMENT 'Date of a specific circular activity (collection, recovery, etc.).',
    `activity_type` STRING COMMENT 'Category of the circular activity performed.. Valid values are `collection|recovery|redistribution|composting|recycling`',
    `activity_volume_kg` DECIMAL(18,2) COMMENT 'Quantity of material processed in the activity, measured in kilograms.',
    `actual_diversion_volume_kg` DECIMAL(18,2) COMMENT 'Measured amount of material actually diverted in the reporting period.',
    `certification` STRING COMMENT 'Responsible sourcing or sustainability certification associated with the program.. Valid values are `rainforest_alliance|fair_trade|none`',
    `circular_program_status` STRING COMMENT 'Current lifecycle status of the program.. Valid values are `active|inactive|completed|suspended|planned`',
    `classification` STRING COMMENT 'Business classification indicating the maturity or rollout stage of the program.. Valid values are `pilot|full|closed`',
    `co2e_avoided_kg` DECIMAL(18,2) COMMENT 'Estimated carbon dioxide equivalent emissions avoided due to the activity, in kilograms.',
    `effective_from` DATE COMMENT 'Date the program becomes effective for operational tracking.',
    `effective_until` DATE COMMENT 'Date the program ends or is scheduled to expire; null if open‑ended.',
    `geographic_scope` STRING COMMENT 'Geographic coverage of the program.. Valid values are `global|regional|national|local`',
    `landfill_diverted_ton` DECIMAL(18,2) COMMENT 'Weight of material diverted from landfill, expressed in metric tonnes.',
    `launch_date` DATE COMMENT 'Date the program was officially launched.',
    `notes` STRING COMMENT 'Free‑form field for additional remarks or observations.',
    `partner_contact_name` STRING COMMENT 'Primary contact person at the partner organization.',
    `partner_organization` STRING COMMENT 'Name of the external partner involved in the program (e.g., recycler, NGO, logistics provider).',
    `partner_type` STRING COMMENT 'Classification of the partner organization.. Valid values are `nonprofit|supplier|logistics|government|retailer`',
    `program_budget_usd` DECIMAL(18,2) COMMENT 'Allocated budget for the program, expressed in US dollars.',
    `program_code` STRING COMMENT 'External business identifier or code for the program, used in reporting and contracts.',
    `program_description` STRING COMMENT 'Detailed description of the programs purpose, scope, and activities.',
    `program_manager` STRING COMMENT 'Name of the internal manager responsible for the program.',
    `program_name` STRING COMMENT 'Human‑readable name of the circular program.',
    `program_type` STRING COMMENT 'Classification of the circular initiative (e.g., take‑back scheme, refillable packaging pilot, post‑consumer recycled content, composting, or food waste redistribution).. Valid values are `take_back|refillable|pcr|composting|redistribution`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the program record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the program record.',
    `reporting_framework` STRING COMMENT 'ESG reporting framework used for program disclosure.. Valid values are `GRI|CDP|Circulytics`',
    `sustainability_metric` STRING COMMENT 'Primary ESG metric used to evaluate program performance.. Valid values are `circularity|waste_reduction|carbon_reduction`',
    `target_diversion_volume_kg` DECIMAL(18,2) COMMENT 'Planned amount of material to divert from landfill, expressed in kilograms.',
    `target_year` STRING COMMENT 'Fiscal year for which the target diversion volume applies.',
    CONSTRAINT pk_circular_program PRIMARY KEY(`circular_program_id`)
) COMMENT 'Master and transactional data for circular economy and waste reduction programs operated by Food Beverage, including take-back schemes, refillable packaging pilots, post-consumer recycled (PCR) content programs, composting partnerships, and food waste redistribution initiatives. Captures program definition (name, type, geographic scope, partner organizations, launch date, target diversion volume, status) and granular operational activity records (activity date, activity type — collection event, material recovery, redistribution, composting run — volume of material diverted in kg/tonnes, participating locations or retail partners, cost per activity, and environmental benefit realized in CO2e avoided and landfill tonnes diverted). Provides operational evidence for circular economy claims in ESG disclosures and supports Ellen MacArthur Foundation Circulytics reporting.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` (
    `circular_activity_id` BIGINT COMMENT 'Unique system-generated identifier for each circular activity record.',
    `plant_id` BIGINT COMMENT 'Identifier of the physical location (plant, warehouse, store) where the activity took place.',
    `supplier_id` BIGINT COMMENT 'Identifier of the external partner (e.g., retailer, collection agency) involved in the activity.',
    `activity_code` STRING COMMENT 'Business identifier or code assigned to the circular activity, used for external reporting and tracking.',
    `activity_description` STRING COMMENT 'Free‑text description providing context or details about the activity.',
    `activity_timestamp` TIMESTAMP COMMENT 'Date and time when the circular activity actually occurred.',
    `activity_type` STRING COMMENT 'Category of the circular activity, e.g., collection, material recovery, redistribution, composting, or recycling.. Valid values are `collection|recovery|redistribution|composting|recycling`',
    `circular_activity_status` STRING COMMENT 'Current lifecycle status of the activity.. Valid values are `planned|in_progress|completed|cancelled`',
    `cost_adjustment` DECIMAL(18,2) COMMENT 'Any cost adjustments (e.g., subsidies, rebates) applied to the gross cost.',
    `cost_gross` DECIMAL(18,2) COMMENT 'Total gross cost incurred for the activity before any adjustments.',
    `cost_net` DECIMAL(18,2) COMMENT 'Net cost after adjustments, representing the final expense of the activity.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the cost amounts.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `environmental_benefit_co2_kg` DECIMAL(18,2) COMMENT 'Estimated CO2 emissions avoided as a result of the activity, measured in kilograms.',
    `environmental_benefit_type` STRING COMMENT 'Type of environmental benefit realized by the activity.. Valid values are `co2_avoided|landfill_diverted|energy_saved`',
    `measurement_method` STRING COMMENT 'Method used to determine volume and environmental benefit (e.g., weighed, estimated).. Valid values are `weighed|estimated`',
    `notes` STRING COMMENT 'Optional free‑form notes or comments about the activity.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the activity record was first created in the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the activity record.',
    `reporting_period` DATE COMMENT 'Calendar period (typically month) for which the activity is reported.',
    `source_system` STRING COMMENT 'Originating operational system that recorded the activity (e.g., SAP S/4HANA, MES).',
    `volume_diverted_kg` DECIMAL(18,2) COMMENT 'Quantity of material diverted from landfill, expressed in kilograms.',
    CONSTRAINT pk_circular_activity PRIMARY KEY(`circular_activity_id`)
) COMMENT 'Transactional records of activities and outcomes within circular economy programs, capturing activity date, activity type (collection event, material recovery, redistribution, composting run), volume of material diverted (kg/tonnes), participating locations or retail partners, cost of activity, and environmental benefit realized (CO2 avoided, landfill diverted). Provides operational evidence for circular economy claims in ESG disclosures.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` (
    `lifecycle_assessment_id` BIGINT COMMENT 'Primary key for lifecycle_assessment',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Lifecycle assessments are conducted by a specific assessor employee; the FK supports traceability of assessment results.',
    `formulation_version_id` BIGINT COMMENT 'Foreign key linking to research.formulation_version. Business justification: LCA results are tied to a specific formulation version; link allows traceability of environmental impact per formulation.',
    `raw_material_id` BIGINT COMMENT 'Foreign key to a key ingredient when the assessment is performed at ingredient level.',
    `sku_id` BIGINT COMMENT 'Foreign key to the finished‑goods SKU that the assessment applies to.',
    `acidification_kg_so2_eq` DECIMAL(18,2) COMMENT 'Potential for acid rain formation.',
    `approved_by` STRING COMMENT 'User who approved the LCA after review.',
    `assessment_date` DATE COMMENT 'Calendar date when the LCA was completed.',
    `assessment_name` STRING COMMENT 'Human‑readable name or title of the LCA study.',
    `carbon_footprint_per_unit` DECIMAL(18,2) COMMENT 'Carbon intensity normalized to the functional unit.',
    `circular_economy_program` STRING COMMENT 'Indicates participation in a circular‑economy initiative.. Valid values are `yes|no`',
    `conducting_organization` STRING COMMENT 'Name of the internal or external organization that performed the LCA.',
    `data_source` STRING COMMENT 'Origin of the primary data used in the assessment.. Valid values are `internal|external|literature`',
    `energy_use_mj` DECIMAL(18,2) COMMENT 'Total energy consumption for the functional unit.',
    `esg_disclosure_framework` STRING COMMENT 'Framework used for ESG reporting of the LCA results.. Valid values are `GRI|CDP|SASB|TCFD`',
    `eutrophication_kg_n_eq` DECIMAL(18,2) COMMENT 'Potential for nutrient enrichment of water bodies.',
    `functional_unit` STRING COMMENT 'Quantitative reference unit for the LCA (e.g., 1 kg product, 1 L beverage).',
    `gwp_kg_co2e` DECIMAL(18,2) COMMENT 'Total greenhouse‑gas emissions expressed in kilograms CO₂‑equivalent.',
    `land_use_m2_year` DECIMAL(18,2) COMMENT 'Land occupation over the assessment period.',
    `lifecycle_assessment_status` STRING COMMENT 'Current lifecycle status of the LCA record.. Valid values are `draft|in_review|approved|rejected`',
    `methodology` STRING COMMENT 'Standard methodology or database used for the assessment.. Valid values are `ISO 14040|ISO 14044|ELCD|Ecoinvent`',
    `notes` STRING COMMENT 'Free‑form comments or observations from the assessor.',
    `ozone_depletion_kg_cfc11_eq` DECIMAL(18,2) COMMENT 'Potential impact on stratospheric ozone layer.',
    `packaging_recyclability` STRING COMMENT 'Recyclability classification of the product packaging.. Valid values are `recyclable|non_recyclable|compostable|unknown`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the LCA record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the LCA record.',
    `renewable_energy_percent` DECIMAL(18,2) COMMENT 'Share of renewable energy used, expressed as a percentage.',
    `renewable_energy_usage_mj` DECIMAL(18,2) COMMENT 'Absolute amount of renewable energy consumed.',
    `resource_use_mj` DECIMAL(18,2) COMMENT 'Total primary energy resources consumed.',
    `responsible_sourcing_certification` STRING COMMENT 'Certification status for responsible sourcing of ingredients.. Valid values are `rainforest_alliance|fair_trade|none`',
    `scope` STRING COMMENT 'GHG emission scope covered by the assessment.. Valid values are `scope1|scope2|scope3`',
    `system_boundary` STRING COMMENT 'Scope of the LCA study defining start and end points.. Valid values are `cradle-to-gate|cradle-to-grave|cradle-to-cradle`',
    `version` STRING COMMENT 'Version identifier for the LCA record, supporting revisions.',
    `waste_generated_kg` DECIMAL(18,2) COMMENT 'Total solid waste generated.',
    `water_intensity_l_per_kg` DECIMAL(18,2) COMMENT 'Water consumption per kilogram of product.',
    `water_use_liters` DECIMAL(18,2) COMMENT 'Total volume of water withdrawn for the functional unit.',
    `created_by` STRING COMMENT 'User or system that created the LCA record.',
    CONSTRAINT pk_lifecycle_assessment PRIMARY KEY(`lifecycle_assessment_id`)
) COMMENT 'Life Cycle Assessment (LCA) records for finished goods SKUs and key ingredients, capturing functional unit, system boundary (cradle-to-gate, cradle-to-grave, cradle-to-cradle), impact categories assessed (global warming potential, water depletion, land use, eutrophication, acidification), LCA methodology (ISO 14040/14044), conducting organization, assessment date, and key hotspot findings. Supports eco-design decisions and environmental product declarations (EPDs).';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` (
    `environmental_instrument_id` BIGINT COMMENT 'Primary key for environmental_instrument',
    `sku_id` BIGINT COMMENT 'Identifier of the SKU whose Scope 2/3 emissions are covered by this instrument.',
    `plant_id` BIGINT COMMENT 'Identifier of the facility or site to which the instrument is allocated.',
    `allocation_scope` STRING COMMENT 'Scope (2 or 3) to which the instrument is allocated for emissions reporting.. Valid values are `scope_2|scope_3`',
    `certificate_number` STRING COMMENT 'External certificate or serial number assigned by the registry or issuing body.',
    `compliance_status` STRING COMMENT 'Indicates whether the instrument meets internal ESG and external regulatory compliance requirements.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the lakehouse.',
    `environmental_instrument_description` STRING COMMENT 'Free‑form description providing additional context about the instrument.',
    `environmental_instrument_status` STRING COMMENT 'Current lifecycle status of the instrument.. Valid values are `active|retired|pending|cancelled`',
    `instrument_type` STRING COMMENT 'Category of the environmental market instrument (Renewable Energy Certificate, Guarantee of Origin, Power Purchase Agreement, or Carbon Offset).. Valid values are `REC|GO|PPA|offset`',
    `issue_date` DATE COMMENT 'Date the instrument was issued or became effective.',
    `project_name` STRING COMMENT 'Descriptive name of the renewable energy or offset project.',
    `project_type` STRING COMMENT 'Underlying generation or mitigation project type associated with the instrument.. Valid values are `solar|wind|hydro|reforestation|methane_capture`',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of energy (MWh) or emissions reduction (tCO2e) represented by the instrument.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the quantity field.. Valid values are `MWh|tCO2e`',
    `registry` STRING COMMENT 'Registry or tracking system where the instrument is recorded.. Valid values are `ERCOT|M-RETS|TIGR|Gold_Standard|Verra`',
    `registry_code` STRING COMMENT 'Unique identifier assigned by the registry for this instrument.',
    `retirement_date` DATE COMMENT 'Date the instrument was retired or cancelled, if applicable.',
    `source_country` STRING COMMENT 'Three‑letter ISO country code of the project location.. Valid values are `^[A-Z]{3}$`',
    `source_system` STRING COMMENT 'Operational system of record that supplied the instrument data (e.g., SAP S/4HANA, Oracle Cloud ERP).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `vintage_year` STRING COMMENT 'Year in which the renewable energy was generated or the offset project was active.',
    CONSTRAINT pk_environmental_instrument PRIMARY KEY(`environmental_instrument_id`)
) COMMENT 'Records of environmental market instruments procured or retired by Food Beverage, including Renewable Energy Certificates (RECs), Guarantees of Origin (GOs), Power Purchase Agreements (PPAs), and carbon offset credits (Gold Standard, VCS/Verra, ACR). Captures instrument type (REC, GO, PPA, offset), underlying project type (solar, wind, hydro, reforestation, methane capture), generating facility or project location, vintage year, quantity (MWh or tCO2e), registry (ERCOT, M-RETS, TIGR, Gold Standard Registry, Verra Registry), serial numbers, retirement date, and allocation to facilities or Scope 2/3 categories. Supports RE100 commitment tracking, Scope 2 market-based emissions reporting, and net-zero residual offset claims for CDP disclosure.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` (
    `biodiversity_impact_id` BIGINT COMMENT 'Unique surrogate key for each biodiversity impact assessment record.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing or processing facility where the impact was measured.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Biodiversity impact events are recorded by field staff; linking to employee captures who entered the data for verification.',
    `area_hectares` DECIMAL(18,2) COMMENT 'Total land area affected, expressed in hectares.',
    `assessment_method` STRING COMMENT 'Methodology used to derive the biodiversity impact metrics.. Valid values are `satellite_imagery|ground_survey|third_party_audit`',
    `assessor_contact` STRING COMMENT 'Primary email address of the assessor for follow‑up.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `assessor_name` STRING COMMENT 'Full legal name of the person or organization performing the assessment.',
    `biodiversity_score` DECIMAL(18,2) COMMENT 'Composite score reflecting overall biodiversity impact, on a 0‑100 scale.',
    `carbon_footprint_kg_per_hectare` DECIMAL(18,2) COMMENT 'Estimated greenhouse‑gas emissions per hectare of land affected.',
    `certification_status` STRING COMMENT 'Current status of any biodiversity‑related certification.. Valid values are `certified|not_certified|in_progress`',
    `certification_type` STRING COMMENT 'Type of sustainability certification held, if any.. Valid values are `rainforest_alliance|fair_trade|none`',
    `commodity_type` STRING COMMENT 'Primary commodity associated with the impact assessment.. Valid values are `palm_oil|soy|cocoa|beef|coffee|rubber`',
    `compliance_status` STRING COMMENT 'Current compliance status with biodiversity‑free commitments and standards.. Valid values are `compliant|non_compliant|pending|exempt`',
    `confidence_score` DECIMAL(18,2) COMMENT 'Statistical confidence of the assessment result, expressed as a percentage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the lakehouse.',
    `data_source` STRING COMMENT 'Source system or application that supplied the raw data (e.g., TraceGains, MES).',
    `deforestation_free_commitment` BOOLEAN COMMENT 'Indicates whether the sourcing is pledged to be deforestation‑free.',
    `deforestation_risk_rating` STRING COMMENT 'Risk rating for potential deforestation associated with the land area.. Valid values are `low|medium|high|critical`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the biodiversity impact observation was recorded.',
    `event_type` STRING COMMENT 'Category of the event; fixed to biodiversity assessment.. Valid values are `biodiversity_assessment`',
    `impact_description` STRING COMMENT 'Narrative description of the observed biodiversity impact.',
    `land_use_type` STRING COMMENT 'Classification of land use where the sourcing or production occurs.. Valid values are `agricultural|forest|wetland|grassland|other`',
    `last_monitoring_date` DATE COMMENT 'Date of the most recent monitoring activity.',
    `mitigation_measures` STRING COMMENT 'Planned or implemented actions to mitigate negative biodiversity impacts.',
    `monitoring_frequency` STRING COMMENT 'How often the biodiversity impact is monitored.. Valid values are `annual|biannual|quarterly|monthly`',
    `notes` STRING COMMENT 'Free‑form comments or observations recorded by the assessor.',
    `protected_area_name` STRING COMMENT 'Name of the nearest protected area or Key Biodiversity Area, if applicable.',
    `proximity_to_protected_areas_km` DECIMAL(18,2) COMMENT 'Distance in kilometres from the nearest protected area or KBA.',
    `record_status` STRING COMMENT 'Lifecycle status of the record within the data lake.. Valid values are `active|archived|deleted`',
    `renewable_energy_percentage` DECIMAL(18,2) COMMENT 'Proportion of energy used in the associated facility that is from renewable sources.',
    `reporting_period` DATE COMMENT 'Calendar period (typically month) for which the impact data is reported.',
    `risk_assessment_date` DATE COMMENT 'Date when the deforestation risk rating was evaluated.',
    `sourcing_region` STRING COMMENT 'Three‑letter country code of the region where the ingredient or raw material is sourced.. Valid values are `^[A-Z]{3}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `version_number` STRING COMMENT 'Incremental version of the record for audit purposes.',
    `waste_generated_tonnes` DECIMAL(18,2) COMMENT 'Total waste generated from the land area during the reporting period.',
    `water_usage_liters_per_hectare` DECIMAL(18,2) COMMENT 'Average water consumption per hectare associated with the impact area.',
    CONSTRAINT pk_biodiversity_impact PRIMARY KEY(`biodiversity_impact_id`)
) COMMENT 'Records assessing biodiversity impact and land use associated with ingredient sourcing and manufacturing facility footprints. Captures land use type (agricultural, forest, wetland), area affected (hectares), deforestation risk rating, proximity to protected areas or Key Biodiversity Areas (KBAs), sourcing region, commodity type (palm oil, soy, cocoa, beef), and deforestation-free commitment compliance status. Supports TNFD (Taskforce on Nature-related Financial Disclosures) reporting.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` (
    `social_impact_program_id` BIGINT COMMENT 'Unique system-generated identifier for the social impact program.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_initiative. Business justification: Social impact programs are aligned with sustainability initiatives; linking provides governance and reporting linkage.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Social Impact Programs are overseen by a designated manager employee; linking enables tracking of program ownership and outcomes.',
    `beneficiary_population` STRING COMMENT 'Description of the target beneficiary group (e.g., smallholder farmers, children under 5).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the program record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the investment amount.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `end_date` DATE COMMENT 'Date when the program is scheduled to conclude; null if open‑ended.',
    `geographic_focus` STRING COMMENT 'Primary country or region(s) targeted by the program (ISO‑3 country codes, comma‑separated).',
    `geographic_reach` STRING COMMENT 'Description of the geographic extent reached (e.g., number of districts, regions).',
    `investment_amount` DECIMAL(18,2) COMMENT 'Total monetary investment allocated to the program, expressed in the specified currency.',
    `measurement_methodology` STRING COMMENT 'Methodology used to collect and verify outcome data.',
    `measurement_period` STRING COMMENT 'Reporting period for outcome measurement (e.g., 2023-Q1, FY2023).',
    `outcome_quantity` BIGINT COMMENT 'Numeric count of the measured outcome (e.g., number of farmers trained).',
    `outcome_type` STRING COMMENT 'Category of the measured outcome for the program.. Valid values are `farmers_trained|income_uplift|meals_donated|women_empowered|children_reached`',
    `partner_ngo` STRING COMMENT 'Name of the non‑governmental organization partnering on the program.',
    `program_code` STRING COMMENT 'External or business reference code for the program, used in reporting and communications.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `program_description` STRING COMMENT 'Detailed narrative describing the programs objectives and activities.',
    `program_manager` STRING COMMENT 'Name of the internal manager responsible for the program.',
    `program_manager_email` STRING COMMENT 'Email address of the program manager.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `program_manager_phone` STRING COMMENT 'Contact phone number of the program manager.. Valid values are `^+?[0-9]{7,15}$`',
    `program_name` STRING COMMENT 'Human‑readable name of the social impact program.',
    `program_status_reason` STRING COMMENT 'Explanation for the current status, especially when not active.',
    `program_type` STRING COMMENT 'Classification of the program by its primary social impact focus.. Valid values are `farmer_livelihood|community_nutrition|gender_equity|employee_volunteering|capacity_building`',
    `reporting_frequency` STRING COMMENT 'How often program outcomes are reported.. Valid values are `annual|semi_annual|quarterly|monthly`',
    `sdg_contribution_evidence` STRING COMMENT 'Reference or link to documentation evidencing SDG contribution.',
    `social_impact_program_status` STRING COMMENT 'Current lifecycle status of the program.. Valid values are `active|inactive|planned|completed|suspended`',
    `start_date` DATE COMMENT 'Date when the program becomes effective.',
    `sustainability_focus_area` STRING COMMENT 'Primary ESG focus area of the program.. Valid values are `carbon|water|waste|energy|circular_economy|social`',
    `target_beneficiaries` BIGINT COMMENT 'Planned number of beneficiaries the program aims to reach.',
    `third_party_verification_status` STRING COMMENT 'Status of external verification of program outcomes.. Valid values are `verified|pending|rejected`',
    `un_sdg_alignment` STRING COMMENT 'UN Sustainable Development Goal(s) that the program supports (e.g., SDG 2, SDG 5). [ENUM-REF-CANDIDATE: 1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17 — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the program record.',
    CONSTRAINT pk_social_impact_program PRIMARY KEY(`social_impact_program_id`)
) COMMENT 'Master and outcome measurement data for social responsibility and community investment programs operated by Food Beverage, including farmer livelihood programs, community nutrition initiatives, smallholder capacity building, gender equity programs, and employee volunteering schemes. Captures program definition (name, social impact category, geographic focus, beneficiary population, partner NGOs, investment amount, UN SDG alignment) and periodic measured outcomes (measurement period, outcome type — farmers trained, income uplift, meals donated, women empowered, children reached — number of beneficiaries, geographic reach, measurement methodology, third-party verification status, and SDG contribution evidence). Supports GRI 413 Local Communities, GRI 203 Indirect Economic Impacts, and ESG investor reporting.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` (
    `social_impact_outcome_id` BIGINT COMMENT 'Unique identifier for the social impact outcome record. _canonical_skip_reason: This entity records measured program outcomes and does not fit standard entity roles.',
    `social_impact_program_id` BIGINT COMMENT 'Identifier of the social responsibility program associated with this outcome.',
    `beneficiary_count` BIGINT COMMENT 'Total number of individuals or entities that benefited from the program.',
    `carbon_footprint_kg` DECIMAL(18,2) COMMENT 'Estimated carbon emissions associated with the outcome, expressed in kilograms CO2e.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the outcome record was first created.',
    `data_source_system` STRING COMMENT 'Source system or application that supplied the outcome data.',
    `geographic_region` STRING COMMENT 'Specific region, country, or market where the outcome was realized. [ENUM-REF-CANDIDATE: list of ISO country codes — promote to reference product]',
    `geographic_scope` STRING COMMENT 'Level of geographic coverage for the outcome.. Valid values are `global|regional|national|local`',
    `impact_metric_unit` STRING COMMENT 'Unit of measurement for the primary impact metric.. Valid values are `people|kg|meals|hours|liters`',
    `impact_metric_value` DECIMAL(18,2) COMMENT 'Quantitative value of the primary impact metric.',
    `measurement_methodology` STRING COMMENT 'Method or approach used to measure the outcome, including any standards or tools applied.',
    `measurement_period_end` DATE COMMENT 'End date of the reporting period for the outcome measurement.',
    `measurement_period_start` DATE COMMENT 'Start date of the reporting period for the outcome measurement.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the outcome.',
    `outcome_description` STRING COMMENT 'Narrative description of the outcome achieved.',
    `outcome_type` STRING COMMENT 'Category of social impact outcome measured.. Valid values are `farmers_trained|income_uplift|meals_donated|women_empowered|children_reached`',
    `packaging_recyclability_percent` DECIMAL(18,2) COMMENT 'Proportion of packaging that is recyclable or made from recycled material, expressed as a percentage.',
    `record_status` STRING COMMENT 'Current lifecycle status of the outcome record.. Valid values are `active|inactive|archived`',
    `renewable_energy_usage_percent` DECIMAL(18,2) COMMENT 'Percentage of renewable energy used in activities linked to the outcome.',
    `reporting_date` DATE COMMENT 'Date when the outcome was formally reported to stakeholders.',
    `sdg_contribution` STRING COMMENT 'UN SDG(s) that the outcome supports. [ENUM-REF-CANDIDATE: SDG1|SDG2|SDG3|SDG4|SDG5|SDG6|SDG7|SDG8|SDG9|SDG10|SDG11|SDG12|SDG13|SDG14|SDG15|SDG16|SDG17 — promote to reference product]',
    `sdg_target` STRING COMMENT 'Specific SDG target identifier (e.g., 1.2, 5.a) linked to the outcome.',
    `third_party_verification_status` STRING COMMENT 'Status of external verification of the reported outcome.. Valid values are `verified|pending|rejected`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the outcome record.',
    `verification_body` STRING COMMENT 'Name of the third‑party organization that performed verification.',
    `waste_reduction_kg` DECIMAL(18,2) COMMENT 'Amount of waste reduced as a result of the program, measured in kilograms.',
    CONSTRAINT pk_social_impact_outcome PRIMARY KEY(`social_impact_outcome_id`)
) COMMENT 'Measured outcomes and beneficiary impact records for social responsibility programs, capturing measurement period, outcome type (farmers trained, income uplift, meals donated, women empowered, children reached), number of beneficiaries, geographic reach, measurement methodology, third-party verification status, and SDG contribution evidence. Supports GRI social disclosures and ESG investor reporting.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` (
    `esg_rating_id` BIGINT COMMENT 'System-generated unique identifier for each ESG rating record.',
    `esg_disclosure_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_disclosure. Business justification: Each ESG rating is produced for a specific ESG disclosure; linking rating to its disclosure enables traceability.',
    `assessment_date` DATE COMMENT 'Date on which the ESG rating was issued.',
    `carbon_emission_kg` DECIMAL(18,2) COMMENT 'Total reported carbon emissions in kilograms for the reporting period.',
    `cdp_score` DECIMAL(18,2) COMMENT 'Score assigned by CDP for climate change disclosure.',
    `data_gaps_flagged` BOOLEAN COMMENT 'Indicates whether the agency identified missing or incomplete data in the ESG submission.',
    `effective_from` DATE COMMENT 'Date from which the rating is considered effective.',
    `effective_until` DATE COMMENT 'Date until which the rating remains effective; null if open‑ended.',
    `environment_score` DECIMAL(18,2) COMMENT 'Score for the environmental pillar of the ESG assessment.',
    `governance_score` DECIMAL(18,2) COMMENT 'Score for the governance pillar of the ESG assessment.',
    `gri_report_reference` STRING COMMENT 'Identifier of the GRI sustainability report linked to this rating.',
    `index_inclusion_status` STRING COMMENT 'Current status of inclusion in a sustainability index (e.g., FTSE4Good, DJSI).. Valid values are `Included|Excluded|Pending`',
    `index_name` STRING COMMENT 'Name of the sustainability index where the rating is (or may be) included.',
    `investor_inquiry_count` STRING COMMENT 'Number of investor inquiries received regarding this ESG rating period.',
    `notes` STRING COMMENT 'Free‑text field for additional comments or observations about the rating.',
    `overall_score` DECIMAL(18,2) COMMENT 'Composite ESG score representing the overall performance across environmental, social, and governance pillars.',
    `packaging_recyclability_percent` DECIMAL(18,2) COMMENT 'Proportion of packaging material that is recyclable or made from recycled content.',
    `prior_period_score` DECIMAL(18,2) COMMENT 'Overall ESG score from the previous reporting period for trend analysis.',
    `rating_agency` STRING COMMENT 'Name of the third‑party ESG rating agency (e.g., MSCI ESG, Sustainalytics, ISS ESG, CDP, FTSE4Good, DJSI).',
    `rating_category` STRING COMMENT 'Qualitative tier assigned by the agency (e.g., Leader, Average, Laggard).. Valid values are `Leader|Average|Laggard|Below_Average|Above_Average`',
    `rating_methodology_version` STRING COMMENT 'Version identifier of the rating methodology used by the agency for this assessment.',
    `rating_scope` STRING COMMENT 'Scope of emissions covered by the rating (Scope 1, Scope 2, Scope 3, or All).. Valid values are `Scope1|Scope2|Scope3|All`',
    `rating_status` STRING COMMENT 'Current lifecycle status of the rating record.. Valid values are `Active|Superseded|Retired`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the ESG rating record was first created in the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the ESG rating record.',
    `renewable_energy_usage_percent` DECIMAL(18,2) COMMENT 'Percentage of total energy consumption derived from renewable sources.',
    `responsible_sourcing_certifications` STRING COMMENT 'List of sustainability certifications held by suppliers (e.g., Rainforest Alliance, Fair Trade).',
    `score_change` DECIMAL(18,2) COMMENT 'Numeric difference between the current overall score and the prior period score.',
    `score_detractors` STRING COMMENT 'Key weaknesses or issues identified by the agency that negatively impacted the rating.',
    `score_drivers` STRING COMMENT 'Key factors or initiatives highlighted by the agency that positively influenced the rating.',
    `social_score` DECIMAL(18,2) COMMENT 'Score for the social pillar of the ESG assessment.',
    `source_system` STRING COMMENT 'System of record that supplied the ESG rating data (e.g., ESG Data Lake, third‑party API).',
    `sustainability_target_alignment` STRING COMMENT 'Alignment of the rating with external sustainability targets (e.g., UN SDGs).',
    `waste_reduction_percent` DECIMAL(18,2) COMMENT 'Percentage reduction in waste generated compared to the baseline period.',
    `water_usage_intensity` DECIMAL(18,2) COMMENT 'Water consumption per unit of production (e.g., cubic meters per tonne).',
    CONSTRAINT pk_esg_rating PRIMARY KEY(`esg_rating_id`)
) COMMENT 'Records of external ESG ratings, scores, and index memberships assigned to Food Beverage by third-party rating agencies and sustainability indices. Captures rating agency (MSCI ESG, Sustainalytics, ISS ESG, CDP score, FTSE4Good, DJSI), rating methodology version, overall score and pillar sub-scores (E/S/G), rating category or tier (Leader/Average/Laggard), assessment date, prior period comparison, score drivers and detractors cited by the agency, data gaps flagged, index inclusion/exclusion status, and investor inquiry tracking. Supports investor relations, peer benchmarking, and targeted improvement of weak-scoring areas.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sustainability`.`initiative` (
    `initiative_id` BIGINT COMMENT 'Unique surrogate key for the sustainability initiative.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand-level ESG reporting requires linking each sustainability initiative to its owning brand for the Brand Sustainability Scorecard.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each sustainability initiative has an owner employee responsible for execution; the FK supports initiative dashboards and resource allocation.',
    `actual_co2e_tonnes_avoided` DECIMAL(18,2) COMMENT 'Measured CO₂‑equivalent emissions avoided (tonnes) to date.',
    `actual_end_date` DATE COMMENT 'Date when the initiative was actually completed.',
    `actual_waste_kg_diverted` DECIMAL(18,2) COMMENT 'Measured amount of waste diverted from landfill (kilograms) to date.',
    `actual_water_m3_saved` DECIMAL(18,2) COMMENT 'Measured volume of water saved (cubic metres) to date.',
    `capital_investment_required_usd` DECIMAL(18,2) COMMENT 'Total capital expenditure required to implement the initiative (USD).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the lakehouse.',
    `data_quality_status` STRING COMMENT 'Current data quality validation status for the record.. Valid values are `pending|validated|rejected`',
    `esg_pillar` STRING COMMENT 'Top‑level ESG pillar to which the initiative belongs.. Valid values are `environmental|social|governance`',
    `implementation_status` STRING COMMENT 'Progress status of implementation activities.. Valid values are `not_started|started|midway|completed`',
    `initiative_category` STRING COMMENT 'Specific sustainability category (e.g., energy efficiency, water reduction, waste elimination, sustainable sourcing, fleet electrification, circular economy). [ENUM-REF-CANDIDATE: energy_efficiency|water_reduction|waste_elimination|sustainable_sourcing|fleet_electrification|circular_economy|other — promote to reference product]',
    `initiative_code` STRING COMMENT 'Business identifier or code used to reference the initiative in external systems.',
    `initiative_description` STRING COMMENT 'Narrative description of the initiative, objectives, and scope.',
    `initiative_name` STRING COMMENT 'Human‑readable name of the sustainability initiative.',
    `initiative_status` STRING COMMENT 'Current lifecycle status of the initiative.. Valid values are `planned|in_progress|completed|on_hold|cancelled`',
    `linked_sustainability_target` STRING COMMENT 'Reference code of the corporate sustainability target that this initiative supports.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `operating_cost_savings_usd` DECIMAL(18,2) COMMENT 'Annual operating cost savings realized (USD).',
    `owning_business_unit` STRING COMMENT 'Business unit or department responsible for the initiative.',
    `packaging_recyclability_percent` DECIMAL(18,2) COMMENT 'Share of packaging material that is recyclable or recycled.',
    `payback_period_years` DECIMAL(18,2) COMMENT 'Estimated number of years to recoup the capital investment.',
    `phase_gate` STRING COMMENT 'Current phase gate of the initiative lifecycle.. Valid values are `concept|design|pilot|scale|full`',
    `projected_co2e_tonnes_avoided` DECIMAL(18,2) COMMENT 'Estimated CO₂‑equivalent emissions avoided (tonnes) if the initiative meets its target.',
    `projected_end_date` DATE COMMENT 'Planned completion date for the initiative.',
    `projected_waste_kg_diverted` DECIMAL(18,2) COMMENT 'Estimated amount of waste diverted from landfill (kilograms).',
    `projected_water_m3_saved` DECIMAL(18,2) COMMENT 'Estimated volume of water saved (cubic metres) by the initiative.',
    `renewable_energy_usage_percent` DECIMAL(18,2) COMMENT 'Percentage of total energy consumption sourced from renewable resources.',
    `reporting_period_end` DATE COMMENT 'End date of the reporting period for initiative metrics.',
    `reporting_period_start` DATE COMMENT 'Start date of the reporting period for initiative metrics.',
    `responsible_sourcing_certifications` STRING COMMENT 'Comma‑separated list of certifications (e.g., Rainforest Alliance, Fair Trade) associated with the initiative.',
    `roi_percent` DECIMAL(18,2) COMMENT 'Projected return on investment expressed as a percentage.',
    `source_system` STRING COMMENT 'Operational system of record where the initiative originated (e.g., SAP S/4HANA, Oracle Cloud ERP).',
    `stakeholder_engagement_score` DECIMAL(18,2) COMMENT 'Score (0‑100) reflecting stakeholder engagement and satisfaction.',
    `start_date` DATE COMMENT 'Date when the initiative officially started.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_initiative PRIMARY KEY(`initiative_id`)
) COMMENT 'Master data for internal sustainability improvement projects and capital investments across manufacturing, sourcing, packaging, logistics, and corporate operations. Captures initiative name, ESG pillar (environmental, social, governance), category (energy efficiency, water reduction, waste elimination, sustainable sourcing, fleet electrification), owning business unit, implementation status and phase gates, projected environmental impact (CO2e tonnes avoided, water m3 saved, waste kg diverted), actual impact realized to date, capital investment required, operating cost savings, payback period, and linkage to corporate sustainability targets. Enables portfolio management of ESG investments and ROI tracking.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` (
    `carbon_offset_id` BIGINT COMMENT 'Unique system-generated identifier for each carbon offset credit record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brands purchase carbon offsets to achieve carbon‑neutral claims; linking offsets to brand supports brand‑level carbon accounting.',
    `supplier_id` BIGINT COMMENT 'Identifier of the offset project supplier or provider.',
    `allocation_category` STRING COMMENT 'Business category or product line to which the offset credit is assigned (e.g., specific SKU, product family).',
    `allocation_scope` STRING COMMENT 'GHG accounting scope to which the offset is allocated (Scope 1, 2, or 3).. Valid values are `Scope 1|Scope 2|Scope 3`',
    `carbon_offset_status` STRING COMMENT 'Current lifecycle status of the offset credit (e.g., purchased, retired, pending, cancelled).. Valid values are `purchased|retired|pending|cancelled`',
    `cost_usd` DECIMAL(18,2) COMMENT 'Total monetary cost paid for the offset credit in US dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the carbon offset record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the transaction (e.g., USD, EUR).',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the offset transaction.',
    `offset_reference_number` STRING COMMENT 'External reference number or code assigned to the carbon offset transaction by the registry or internal system.',
    `offset_type` STRING COMMENT 'Category of the carbon offset project (e.g., reforestation, soil carbon, methane capture, cookstoves).. Valid values are `reforestation|soil_carbon|methane_capture|cookstoves`',
    `price_per_tco2e` DECIMAL(18,2) COMMENT 'Unit price paid per metric tonne of CO₂e.',
    `project_location` STRING COMMENT 'Geographic location (city, region, country) where the offset project is implemented.',
    `project_name` STRING COMMENT 'Official name of the carbon offset project.',
    `quantity_tco2e` DECIMAL(18,2) COMMENT 'Amount of carbon dioxide equivalent (in metric tonnes) represented by the offset credit.',
    `record_status` STRING COMMENT 'Current status of the record in the data lake (active, inactive, archived).. Valid values are `active|inactive|archived`',
    `registry_serial_number` STRING COMMENT 'Unique serial number assigned by the carbon registry for tracking the credit.',
    `retirement_date` DATE COMMENT 'Date on which the offset credit was retired or applied to a scope.',
    `source_system` STRING COMMENT 'Name of the source operational system where the record originated (e.g., SAP S/4HANA, TraceGains).',
    `standard` STRING COMMENT 'Certification standard under which the offset credit is issued (e.g., Gold Standard, Verified Carbon Standard, American Carbon Registry).. Valid values are `Gold Standard|VCS|ACR`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the carbon offset transaction was executed or recorded.',
    `unit_of_measure` STRING COMMENT 'Unit used for the quantity field; fixed as metric tonnes of CO₂e.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the carbon offset record.',
    `verification_body` STRING COMMENT 'Organization that performed the verification of the offset project.',
    `verification_status` STRING COMMENT 'Current verification status of the offset credit.. Valid values are `verified|pending|rejected`',
    `vintage_year` STRING COMMENT 'Calendar year in which the carbon offset was generated.',
    CONSTRAINT pk_carbon_offset PRIMARY KEY(`carbon_offset_id`)
) COMMENT 'Records of carbon offset credits purchased or retired by Food Beverage to compensate for residual GHG emissions, capturing offset project type (reforestation, soil carbon, methane capture, cookstoves), project location, standard (Gold Standard, VCS/Verra, ACR), vintage year, quantity (tCO2e), registry serial numbers, retirement date, and allocation to specific Scope 3 categories or product lines. Supports net-zero claims and CDP disclosure.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sustainability`.`audit` (
    `audit_id` BIGINT COMMENT 'Unique system-generated identifier for the sustainability audit record.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to maintenance.asset. Business justification: Audits often assess specific machines; FK allows audit findings and corrective actions to be tied to the audited asset.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Internal sustainability audits are performed by auditors who are employees; linking audit records to employee enables audit trail and compliance reporting.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_initiative. Business justification: Sustainability audits assess specific initiatives; linking audit to initiative enables drill‑down.',
    `assurance_level` STRING COMMENT 'Level of assurance provided (e.g., limited, reasonable, high).. Valid values are `limited|reasonable|high`',
    `assurance_provider` STRING COMMENT 'Entity that performed the assurance engagement.',
    `audit_date` DATE COMMENT 'Date on which the audit was performed.',
    `audit_number` STRING COMMENT 'Business-assigned audit number used for external reference and tracking.. Valid values are `^AUD-[0-9]{8}$`',
    `audit_scope` STRING COMMENT 'Scope of the audit covering facilities, suppliers, distribution centers, or corporate operations.. Valid values are `facility|supplier|distribution_center|corporate|multiple`',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit.. Valid values are `planned|in_progress|completed|cancelled`',
    `audit_type` STRING COMMENT 'Classification of the audit based on the standard or focus area.. Valid values are `iso_14001|social_compliance|esg_assurance|packaging_recyclability|deforestation_free|other`',
    `audited_entity_name` STRING COMMENT 'Name of the organization, facility, or supplier being audited.',
    `auditor_name` STRING COMMENT 'Name of the individual who performed the audit.',
    `auditor_organization` STRING COMMENT 'Organization or firm providing the audit service.',
    `carbon_footprint_kg` DECIMAL(18,2) COMMENT 'Total carbon emissions measured for the audited entity, expressed in kilograms CO₂e.',
    `cdp_score` DECIMAL(18,2) COMMENT 'Score assigned by CDP for climate-related performance.',
    `certification` STRING COMMENT 'Certification result issued after the audit.. Valid values are `passed|failed|conditional|not_applicable`',
    `certification_date` DATE COMMENT 'Date the certification was granted.',
    `certification_number` STRING COMMENT 'Unique identifier for the certification document.. Valid values are `^CERT-[A-Z0-9]{6}$`',
    `corrective_action_due_date` DATE COMMENT 'Target date for completion of corrective actions.',
    `corrective_action_plan` STRING COMMENT 'Detailed plan to address audit findings.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action plan.. Valid values are `open|in_progress|closed`',
    `data_source` STRING COMMENT 'Source system or tool from which audit data was imported.',
    `duration_days` STRING COMMENT 'Number of calendar days the audit spanned.',
    `emission_scope` STRING COMMENT 'Greenhouse gas emission scope covered by the audit.. Valid values are `scope1|scope2|scope3|all`',
    `findings_severity` STRING COMMENT 'Highest severity level among findings identified.. Valid values are `critical|major|minor|observation|none`',
    `gri_disclosure_topic` STRING COMMENT 'GRI reporting topic(s) addressed by the audit.',
    `location` STRING COMMENT 'Identifier of the primary facility or site audited.',
    `notes` STRING COMMENT 'Additional free-text observations captured by the auditor.',
    `outcome` STRING COMMENT 'Result of the audit after evaluation.. Valid values are `passed|failed|conditional|not_applicable`',
    `packaging_recyclability_percent` DECIMAL(18,2) COMMENT 'Share of packaging material that is recyclable or recycled.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the audit record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the audit record.',
    `region` STRING COMMENT 'Three-letter country code where the audit took place.. Valid values are `^[A-Z]{3}$`',
    `renewable_energy_percent` DECIMAL(18,2) COMMENT 'Percentage of total energy consumption sourced from renewable resources.',
    `report_url` STRING COMMENT 'Link to the digital audit report document.',
    `responsible_sourcing_certifications` STRING COMMENT 'List of certifications (e.g., Rainforest Alliance, Fair Trade) held by the audited entity.',
    `scope_boundary` STRING COMMENT 'Narrative description of the geographic and operational boundaries covered.',
    `standard` STRING COMMENT 'Specific standard applied during the audit (e.g., ISO 14001, GFSI, ISAE 3000).',
    `verification_date` DATE COMMENT 'Date the verification was completed.',
    `verification_status` STRING COMMENT 'Status of third‑party verification of audit results.. Valid values are `verified|unverified|pending`',
    `waste_generated_kg` DECIMAL(18,2) COMMENT 'Total waste generated, measured in kilograms.',
    `water_usage_m3` DECIMAL(18,2) COMMENT 'Volume of water withdrawn/consumed during the reporting period.',
    CONSTRAINT pk_audit PRIMARY KEY(`audit_id`)
) COMMENT 'Records of internal and third-party sustainability audits and assurance engagements conducted at manufacturing plants, supplier facilities, distribution centers, and corporate offices. Captures audit type (ISO 14001 surveillance, social compliance, limited/reasonable assurance for ESG data, packaging recyclability verification, deforestation-free supply chain), audit standard applied, audit date and duration, auditing body or assurance provider, scope boundaries, findings by severity (critical, major, minor, observation), corrective action plans with due dates, closure status, and certification or assurance statement outcome. Supports ISAE 3000 assurance, GFSI benchmarked schemes, and responsible sourcing verification.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` (
    `materiality_assessment_id` BIGINT COMMENT 'System‑generated unique identifier for the materiality assessment record. _canonical_skip_reason: Entity does not fit standard role; treated as OTHER.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Materiality assessments are led by a specific employee; linking captures who authored the assessment for governance and audit.',
    `target_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_target. Business justification: Materiality assessments evaluate particular sustainability targets; FK creates the needed relationship.',
    `previous_materiality_assessment_id` BIGINT COMMENT 'Self-referencing FK on materiality_assessment (previous_materiality_assessment_id)',
    `approved_by` STRING COMMENT 'Name of the board member or executive who approved the assessment.',
    `assessment_conducted_date` DATE COMMENT 'Date on which the materiality assessment was completed.',
    `assessment_methodology` STRING COMMENT 'Methodology used to conduct the materiality assessment, aligned with recognized frameworks.. Valid values are `GRI|ESRS|CSRD|Other`',
    `assessment_name` STRING COMMENT 'Descriptive name given to the assessment (e.g., FY2025 Double Materiality Review).',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the materiality assessment.. Valid values are `draft|in_progress|completed|approved|archived`',
    `assessment_type` STRING COMMENT 'Specifies whether the assessment follows a double‑materiality or single‑materiality approach.. Valid values are `double_materiality|single_materiality`',
    `board_approval_date` DATE COMMENT 'Date the board formally approved the materiality assessment results.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Overall data quality rating for the assessment record (0‑100).',
    `disclosure_scope` STRING COMMENT 'Scope of ESG disclosures considered (e.g., Scope 1‑3 emissions).. Valid values are `scope1|scope2|scope3|all`',
    `effective_from` DATE COMMENT 'Date from which the assessment results are considered effective.',
    `effective_until` DATE COMMENT 'Date until which the assessment results remain valid (null if ongoing).',
    `environmental_impact_score` DECIMAL(18,2) COMMENT 'Quantitative score reflecting the environmental significance of material topics.',
    `esg_pillar` STRING COMMENT 'Primary ESG pillar(s) addressed by the assessment.. Valid values are `environmental|social|governance`',
    `external_reference_code` STRING COMMENT 'Identifier linking to external ESG disclosure or regulatory filing.',
    `final_material_topics` STRING COMMENT 'Comma‑separated list of ESG topics deemed material after scoring.',
    `financial_impact_score` DECIMAL(18,2) COMMENT 'Quantitative score reflecting the financial significance of material topics.',
    `governance_impact_score` DECIMAL(18,2) COMMENT 'Quantitative score reflecting the governance significance of material topics.',
    `materiality_score_threshold` DECIMAL(18,2) COMMENT 'Numeric threshold value that separates material from non‑material topics.',
    `materiality_threshold_criteria` STRING COMMENT 'Criteria and numeric thresholds used to determine materiality (e.g., score > 0.6).',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the assessment.',
    `overall_materiality_score` DECIMAL(18,2) COMMENT 'Aggregated score representing the overall materiality of the assessment.',
    `reassessment_frequency_months` STRING COMMENT 'Number of months between required reassessments of materiality.',
    `regulatory_framework` STRING COMMENT 'Regulatory or reporting framework governing the assessment.. Valid values are `GRI|CDP|SASB|TCFD|EU CSRD`',
    `reporting_period_end` DATE COMMENT 'End date of the reporting period covered by the assessment.',
    `reporting_period_start` DATE COMMENT 'Start date of the reporting period covered by the assessment.',
    `responsible_business_unit` STRING COMMENT 'Organizational unit accountable for the assessment execution and outcomes.',
    `source_system` STRING COMMENT 'Originating system of record for the assessment data.. Valid values are `SAP|Oracle|Salesforce|Custom`',
    `stakeholder_engagement_score` DECIMAL(18,2) COMMENT 'Score measuring the level of stakeholder concern for each material topic.',
    `stakeholder_groups_consulted` STRING COMMENT 'Comma‑separated list of stakeholder groups (e.g., investors, employees, NGOs) consulted during the assessment.',
    `topic_universe_evaluated` STRING COMMENT 'Full set of ESG topics considered for materiality scoring.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assessment record.',
    `verification_status` STRING COMMENT 'Status of internal or external verification of the assessment.. Valid values are `pending|verified|rejected`',
    `verified_by` STRING COMMENT 'Name of the individual or entity that performed verification.',
    `version_number` STRING COMMENT 'Sequential version identifier for the assessment record.',
    CONSTRAINT pk_materiality_assessment PRIMARY KEY(`materiality_assessment_id`)
) COMMENT 'Records of double materiality assessments conducted to identify and prioritize ESG topics that are material to Food Beverage from both impact and financial perspectives. Captures assessment methodology (GRI, ESRS/CSRD double materiality), stakeholder groups consulted, topic universe evaluated, materiality threshold criteria, scoring results, final material topics list, board approval date, and reassessment frequency. Required by GRI Universal Standards 2021 and EU CSRD for determining ESG disclosure scope.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ADD CONSTRAINT `fk_sustainability_esg_disclosure_packaging_profile_id` FOREIGN KEY (`packaging_profile_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`packaging_profile`(`packaging_profile_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ADD CONSTRAINT `fk_sustainability_target_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ADD CONSTRAINT `fk_sustainability_target_progress_target_id` FOREIGN KEY (`target_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ADD CONSTRAINT `fk_sustainability_circular_program_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ADD CONSTRAINT `fk_sustainability_social_impact_program_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ADD CONSTRAINT `fk_sustainability_social_impact_outcome_social_impact_program_id` FOREIGN KEY (`social_impact_program_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`social_impact_program`(`social_impact_program_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ADD CONSTRAINT `fk_sustainability_esg_rating_esg_disclosure_id` FOREIGN KEY (`esg_disclosure_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`esg_disclosure`(`esg_disclosure_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ADD CONSTRAINT `fk_sustainability_audit_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ADD CONSTRAINT `fk_sustainability_materiality_assessment_target_id` FOREIGN KEY (`target_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ADD CONSTRAINT `fk_sustainability_materiality_assessment_previous_materiality_assessment_id` FOREIGN KEY (`previous_materiality_assessment_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`materiality_assessment`(`materiality_assessment_id`);

-- ========= TAGS =========
ALTER SCHEMA `food_beverage_ecm`.`sustainability` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `food_beverage_ecm`.`sustainability` SET TAGS ('dbx_domain' = 'sustainability');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` SET TAGS ('dbx_subdomain' = 'environmental_reporting');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `esg_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'ESG Disclosure Identifier');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `packaging_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Profile Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `assurance_level` SET TAGS ('dbx_business_glossary_term' = 'Assurance Level');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `assurance_level` SET TAGS ('dbx_value_regex' = 'None|Limited|Reasonable|Full');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `carbon_footprint_kg_co2e` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint (kg CO₂e)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `cdp_score` SET TAGS ('dbx_business_glossary_term' = 'CDP Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `data_gap_description` SET TAGS ('dbx_business_glossary_term' = 'Data Gap Description');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `data_gap_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Gap Flag');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `disclosure_name` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Name');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `disclosure_number` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Number');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `environmental_score` SET TAGS ('dbx_business_glossary_term' = 'Environmental ESG Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `external_rating_agency` SET TAGS ('dbx_business_glossary_term' = 'External Rating Agency');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `external_rating_agency` SET TAGS ('dbx_value_regex' = 'MSCI|Sustainalytics|ISS ESG|CDP|DJSI|FTSE4Good');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `framework` SET TAGS ('dbx_business_glossary_term' = 'Reporting Framework (GRI, CDP, TCFD, CSRD, ESRS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `framework` SET TAGS ('dbx_value_regex' = 'GRI|CDP|TCFD|CSRD|ESRS');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `framework_version` SET TAGS ('dbx_business_glossary_term' = 'Framework Version');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `governance_score` SET TAGS ('dbx_business_glossary_term' = 'Governance ESG Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `gri_disclosure_topic` SET TAGS ('dbx_business_glossary_term' = 'GRI Disclosure Topic');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `index_membership_status` SET TAGS ('dbx_business_glossary_term' = 'Index Membership Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `index_membership_status` SET TAGS ('dbx_value_regex' = 'included|excluded|pending');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `investor_inquiry_count` SET TAGS ('dbx_business_glossary_term' = 'Investor Inquiry Count');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall ESG Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `publication_url` SET TAGS ('dbx_business_glossary_term' = 'Publication URL');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `rating_category` SET TAGS ('dbx_business_glossary_term' = 'Rating Category');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `rating_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `rating_methodology_version` SET TAGS ('dbx_business_glossary_term' = 'Rating Methodology Version');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `renewable_energy_usage_percent` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Usage (%)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `responsible_sourcing_certifications` SET TAGS ('dbx_business_glossary_term' = 'Responsible Sourcing Certifications');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `responsible_sourcing_certifications` SET TAGS ('dbx_value_regex' = 'Rainforest Alliance|Fair Trade|UTZ|Organic');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Emission Scope');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `scope` SET TAGS ('dbx_value_regex' = 'Scope 1|Scope 2|Scope 3|Combined');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `score_detractor_summary` SET TAGS ('dbx_business_glossary_term' = 'Score Detractor Summary');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `score_driver_summary` SET TAGS ('dbx_business_glossary_term' = 'Score Driver Summary');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `social_score` SET TAGS ('dbx_business_glossary_term' = 'Social ESG Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'portal|email|api|manual');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `submitted_by` SET TAGS ('dbx_business_glossary_term' = 'Submitted By');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|verified|assured');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `waste_generated_kg` SET TAGS ('dbx_business_glossary_term' = 'Waste Generated (kg)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `water_usage_m3` SET TAGS ('dbx_business_glossary_term' = 'Water Usage (m³)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` SET TAGS ('dbx_subdomain' = 'resource_efficiency');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `carbon_footprint_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint Record ID');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'SKU Identifier');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'mass|energy|economic|process');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Calculation Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `carbon_footprint_status` SET TAGS ('dbx_business_glossary_term' = 'Record Lifecycle Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `carbon_footprint_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `carbon_intensity_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Carbon Intensity per Unit');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `carbon_offset_quantity` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Quantity');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `confidence_interval_high` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval High');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `confidence_interval_low` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Low');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `data_source_type` SET TAGS ('dbx_business_glossary_term' = 'Data Source Type');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `data_source_type` SET TAGS ('dbx_value_regex' = 'measured|estimated|modeled');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `emission_amount` SET TAGS ('dbx_business_glossary_term' = 'Emission Amount (tonnes CO2e)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `emission_factor_source` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Source');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `emission_type` SET TAGS ('dbx_business_glossary_term' = 'Emission Type');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `emission_type` SET TAGS ('dbx_value_regex' = 'CO2e|CH4|N2O|SF6');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `footprint_code` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint Code');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `footprint_type` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint Type');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `footprint_type` SET TAGS ('dbx_value_regex' = 'direct|indirect|upstream|downstream');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `footprint_version` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint Version');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `is_boundary_crossing` SET TAGS ('dbx_business_glossary_term' = 'Boundary Crossing Indicator');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `is_renewable` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Indicator');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Carbon Accounting Methodology');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `methodology` SET TAGS ('dbx_value_regex' = 'GHG Protocol|ISO 14064|Company Specific');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `offset_type` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Type');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `offset_type` SET TAGS ('dbx_value_regex' = 'project|purchase|internal');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `offset_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Offset Verification Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `offset_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `record_name` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint Record Name');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `renewable_energy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Percentage');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `reporting_period` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4|Annual');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_business_glossary_term' = 'Reporting Standard');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_value_regex' = 'CDP|GRI|SASB|TCFD');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas Scope');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `scope` SET TAGS ('dbx_value_regex' = 'Scope 1|Scope 2|Scope 3');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `source_data_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Data Reference');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'MES|ERP|Manual');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'tonnes|kg');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|rejected');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` SET TAGS ('dbx_subdomain' = 'resource_efficiency');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Water Usage Record Identifier');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Identifier');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Water Usage Recorded By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit Identifier');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'cubic_meters');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_consumption` SET TAGS ('dbx_business_glossary_term' = 'Water Consumption (Cubic Meters)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_discharge` SET TAGS ('dbx_business_glossary_term' = 'Water Discharge (Cubic Meters)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_intensity_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Water Intensity per Unit (Cubic Meters per SKU)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_recycled` SET TAGS ('dbx_business_glossary_term' = 'Water Recycled (Cubic Meters)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_source_type` SET TAGS ('dbx_business_glossary_term' = 'Water Source Type');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_source_type` SET TAGS ('dbx_value_regex' = 'municipal|groundwater|rainwater|recycled');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_stress_risk` SET TAGS ('dbx_business_glossary_term' = 'Water Stress Risk Level');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_stress_risk` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_withdrawal` SET TAGS ('dbx_business_glossary_term' = 'Water Withdrawal (Cubic Meters)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` SET TAGS ('dbx_subdomain' = 'resource_efficiency');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Record Identifier (ENERGY_CONSUMPTION_ID)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (FACILITY_ID)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Identifier (PRODUCTION_LINE_ID)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Recorded By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `carbon_emission_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission (KG)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `carbon_intensity_kg_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Carbon Intensity (KG/MWH)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `electricity_mwh` SET TAGS ('dbx_business_glossary_term' = 'Electricity Consumption (MWH)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `emission_scope` SET TAGS ('dbx_business_glossary_term' = 'Emission Scope (SCOPE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `emission_scope` SET TAGS ('dbx_value_regex' = 'scope1|scope2|scope3');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_intensity_mwh_per_tonne` SET TAGS ('dbx_business_glossary_term' = 'Energy Intensity (MWH/TONNE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_total_mwh` SET TAGS ('dbx_business_glossary_term' = 'Total Energy Consumed (MWH)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `fuel_oil_mwh` SET TAGS ('dbx_business_glossary_term' = 'Fuel Oil Energy Consumption (MWH)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'location_based|market_based');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `natural_gas_mwh` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Energy Consumption (MWH)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `production_quantity_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Production Quantity (TONNES)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `renewable_energy_mwh` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Consumed (MWH)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `renewable_percentage` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Percentage (%)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `reporting_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `steam_mwh` SET TAGS ('dbx_business_glossary_term' = 'Steam Energy Consumption (MWH)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` SET TAGS ('dbx_subdomain' = 'resource_efficiency');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `waste_generation_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Generation Identifier');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `carbon_footprint_kg_co2e` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint (kg CO₂e)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `cdpi_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'CDP Disclosure Flag');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|not_certified|pending');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'landfill|incineration|composting|recycling|anaerobic_digestion');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `gri_section` SET TAGS ('dbx_business_glossary_term' = 'GRI Section');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `source_process` SET TAGS ('dbx_business_glossary_term' = 'Source Process');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `waste_amount_kg` SET TAGS ('dbx_business_glossary_term' = 'Waste Amount (kg)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `waste_date` SET TAGS ('dbx_business_glossary_term' = 'Waste Generation Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `waste_diversion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Waste Diversion Rate (%)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `waste_generation_status` SET TAGS ('dbx_business_glossary_term' = 'Waste Record Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `waste_generation_status` SET TAGS ('dbx_value_regex' = 'recorded|verified|rejected|closed');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `waste_record_number` SET TAGS ('dbx_business_glossary_term' = 'Waste Record Number');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `waste_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Waste Generation Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `waste_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Type');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `waste_type` SET TAGS ('dbx_value_regex' = 'organic|plastic|paper|hazardous|non_hazardous|metal');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `waste_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Waste Volume (m³)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ALTER COLUMN `zero_waste_to_landfill` SET TAGS ('dbx_business_glossary_term' = 'Zero Waste to Landfill Flag');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` SET TAGS ('dbx_subdomain' = 'resource_efficiency');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `packaging_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Profile Identifier');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Designer Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Barcode (GTIN/UPC)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `carbon_footprint_kg_co2e` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint (kg CO₂e)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `epr_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'EPR Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `epr_regulation` SET TAGS ('dbx_business_glossary_term' = 'EPR Regulation Reference');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Packaging Height (cm)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Packaging Length (cm)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `lightweighting_initiative_flag` SET TAGS ('dbx_business_glossary_term' = 'Lightweighting Initiative Flag');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `material` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `material` SET TAGS ('dbx_value_regex' = 'PET|HDPE|GLASS|ALUMINUM|PAPERBOARD|BIO_BASED');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `material_composition` SET TAGS ('dbx_business_glossary_term' = 'Material Composition Details');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `packaging_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Packaging Profile Code');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `packaging_profile_name` SET TAGS ('dbx_business_glossary_term' = 'Packaging Profile Name');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `packaging_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Packaging Profile Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `packaging_profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `packaging_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `packaging_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Packaging Weight (kg)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `recyclability_rating` SET TAGS ('dbx_business_glossary_term' = 'Recyclability Rating');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `recyclability_rating` SET TAGS ('dbx_value_regex' = 'non_recyclable|recyclable|recyclable_with_caution|highly_recyclable');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `recycled_content_pct` SET TAGS ('dbx_business_glossary_term' = 'Recycled Content Percentage');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (days)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `sustainability_target_year` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Year');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `target_recyclable_by_year` SET TAGS ('dbx_business_glossary_term' = 'Target Recyclable By Year');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `volume_liters` SET TAGS ('dbx_business_glossary_term' = 'Packaging Volume (liters)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `waste_reduction_kg` SET TAGS ('dbx_business_glossary_term' = 'Waste Reduction (kg)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `water_usage_liters` SET TAGS ('dbx_business_glossary_term' = 'Water Usage (liters)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Packaging Width (cm)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `sourcing_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Certification Identifier');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient ID');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `audit_result` SET TAGS ('dbx_business_glossary_term' = 'Audit Result');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `audit_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|not_applicable');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'Rainforest Alliance|Fair Trade|RSPO|UTZ|Organic|Non-GMO');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coverage Percentage');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `sourcing_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `sourcing_certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|revoked|pending');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `total_volume_certified` SET TAGS ('dbx_business_glossary_term' = 'Total Volume Certified');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|ton');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `supplier_esg_score_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ESG Score ID');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `anti_corruption_score` SET TAGS ('dbx_business_glossary_term' = 'Anti-Corruption Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_business_glossary_term' = 'Assessment Methodology');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_value_regex' = 'EcoVadis|Sedex|Proprietary');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assessment Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `assessor_contact` SET TAGS ('dbx_business_glossary_term' = 'Assessor Contact Email');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `assessor_contact` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `assessor_contact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `assessor_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `carbon_emissions_kg_co2e` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emissions (kg CO2e)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `community_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Community Impact Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `environmental_score` SET TAGS ('dbx_business_glossary_term' = 'Environmental Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `governance_score` SET TAGS ('dbx_business_glossary_term' = 'Governance Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `human_rights_score` SET TAGS ('dbx_business_glossary_term' = 'Human Rights Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `improvement_action_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Improvement Action Plan Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `improvement_action_plan_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|deferred');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `labor_practices_score` SET TAGS ('dbx_business_glossary_term' = 'Labor Practices Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `overall_esg_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall ESG Rating');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `packaging_recyclability_percent` SET TAGS ('dbx_business_glossary_term' = 'Packaging Recyclability (%)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `renewable_energy_percent` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Usage (%)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `scope1_emissions_kg` SET TAGS ('dbx_business_glossary_term' = 'Scope 1 Emissions (kg)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `scope2_emissions_kg` SET TAGS ('dbx_business_glossary_term' = 'Scope 2 Emissions (kg)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `scope3_emissions_kg` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Emissions (kg)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `social_score` SET TAGS ('dbx_business_glossary_term' = 'Social Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `supplier_esg_score_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `supplier_esg_score_status` SET TAGS ('dbx_value_regex' = 'pending|completed|reviewed|rejected');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `transparency_score` SET TAGS ('dbx_business_glossary_term' = 'Transparency Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `waste_generated_kg` SET TAGS ('dbx_business_glossary_term' = 'Waste Generated (kg)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ALTER COLUMN `water_usage_liters` SET TAGS ('dbx_business_glossary_term' = 'Water Usage (Liters)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` SET TAGS ('dbx_subdomain' = 'environmental_reporting');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Identifier');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `initiative_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `actual_impact_co2e` SET TAGS ('dbx_business_glossary_term' = 'Actual CO2e Impact');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Measured Value');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `baseline_year` SET TAGS ('dbx_business_glossary_term' = 'Baseline Year');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `capital_investment` SET TAGS ('dbx_business_glossary_term' = 'Capital Investment');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factors');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `esg_pillar` SET TAGS ('dbx_business_glossary_term' = 'ESG Pillar');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `esg_pillar` SET TAGS ('dbx_value_regex' = 'environment|social|governance');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `implementation_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|on_hold|cancelled');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `interim_milestone_value` SET TAGS ('dbx_business_glossary_term' = 'Interim Milestone Value');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `interim_milestone_year` SET TAGS ('dbx_business_glossary_term' = 'Interim Milestone Year');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|completed|retired');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `measurement_period` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `measurement_period` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `metric_type` SET TAGS ('dbx_business_glossary_term' = 'Metric Type (METRIC_TYPE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `metric_type` SET TAGS ('dbx_value_regex' = 'co2e|liters|kg|percent|units');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `narrative_commentary` SET TAGS ('dbx_business_glossary_term' = 'Narrative Commentary');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `operating_cost_savings` SET TAGS ('dbx_business_glossary_term' = 'Operating Cost Savings');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `owning_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Owning Business Unit');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `payback_period_months` SET TAGS ('dbx_business_glossary_term' = 'Payback Period (Months)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `percent_of_target_met` SET TAGS ('dbx_business_glossary_term' = 'Percent of Target Met');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `phase_gate` SET TAGS ('dbx_business_glossary_term' = 'Phase Gate');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `phase_gate` SET TAGS ('dbx_value_regex' = 'gate1|gate2|gate3');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `projected_impact_co2e` SET TAGS ('dbx_business_glossary_term' = 'Projected CO2e Impact');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `public_disclosure` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `roi_percent` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Percent');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `sbti_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Science‑Based Targets initiative (SBTi) Validation Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `sbti_validation_status` SET TAGS ('dbx_value_regex' = 'validated|pending|rejected');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'GHG Emission Scope');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `scope` SET TAGS ('dbx_value_regex' = 'scope1|scope2|scope3|scope1_2|scope1_2_3');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `target_category` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Category');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `target_category` SET TAGS ('dbx_value_regex' = 'carbon|water|waste|energy|packaging|social');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `target_name` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Name');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `variance` SET TAGS ('dbx_business_glossary_term' = 'Variance from Target Trajectory');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target` ALTER COLUMN `year` SET TAGS ('dbx_business_glossary_term' = 'Target Year');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` SET TAGS ('dbx_subdomain' = 'environmental_reporting');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `target_progress_id` SET TAGS ('dbx_business_glossary_term' = 'Target Progress Record ID (TPR_ID)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Plant ID (PLANT_ID)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target ID (ST_ID)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Measured Value (ACT_VAL)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `carbon_intensity` SET TAGS ('dbx_business_glossary_term' = 'Carbon Intensity (CARB_INTENSITY)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag (DATA_QUAL_FLAG)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `initiative_contributions` SET TAGS ('dbx_business_glossary_term' = 'Initiative Contributions Description (INIT_CONTRIB)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `measurement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date (MP_END)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `measurement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date (MP_START)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp (MEAS_TS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type (MEAS_TYPE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'scope1|scope2|scope3|energy|water|waste');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `percent_of_target_met` SET TAGS ('dbx_business_glossary_term' = 'Percent of Target Met (PCT_TGT_MET)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code (REGION_CD)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_business_glossary_term' = 'Reporting Framework (REPORT_FRAME)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_value_regex' = 'GRI|CDP|SASB|TCFD|ISSB');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (SRC_SYS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_IBP|MES|TraceGains|ERP');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `target_progress_status` SET TAGS ('dbx_business_glossary_term' = 'Progress Status (PROG_STATUS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `target_progress_status` SET TAGS ('dbx_value_regex' = 'on_track|behind|exceeded|not_started|completed');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value (TGT_VAL)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `variance` SET TAGS ('dbx_business_glossary_term' = 'Variance Between Actual and Target (VARIANCE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage (VAR_PCT)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `waste_reduction_percent` SET TAGS ('dbx_business_glossary_term' = 'Waste Reduction Percentage (WASTE_RED_PCT)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ALTER COLUMN `water_intensity` SET TAGS ('dbx_business_glossary_term' = 'Water Intensity (WATER_INTENSITY)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` SET TAGS ('dbx_subdomain' = 'social_impact');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `circular_program_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Program ID');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Initiative Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `activity_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Activity Cost (USD)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `activity_date` SET TAGS ('dbx_business_glossary_term' = 'Activity Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'collection|recovery|redistribution|composting|recycling');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `activity_volume_kg` SET TAGS ('dbx_business_glossary_term' = 'Activity Volume (KG)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `actual_diversion_volume_kg` SET TAGS ('dbx_business_glossary_term' = 'Actual Diversion Volume (KG)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `certification` SET TAGS ('dbx_business_glossary_term' = 'Certification');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `certification` SET TAGS ('dbx_value_regex' = 'rainforest_alliance|fair_trade|none');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `circular_program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `circular_program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|completed|suspended|planned');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Program Classification');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'pilot|full|closed');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `co2e_avoided_kg` SET TAGS ('dbx_business_glossary_term' = 'CO2e Avoided (KG)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|national|local');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `landfill_diverted_ton` SET TAGS ('dbx_business_glossary_term' = 'Landfill Diverted (TON)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `partner_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Name');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `partner_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `partner_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `partner_organization` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Type');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `partner_type` SET TAGS ('dbx_value_regex' = 'nonprofit|supplier|logistics|government|retailer');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `program_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Program Budget (USD)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `program_manager` SET TAGS ('dbx_business_glossary_term' = 'Program Manager');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'take_back|refillable|pcr|composting|redistribution');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_business_glossary_term' = 'Reporting Framework');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_value_regex' = 'GRI|CDP|Circulytics');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `sustainability_metric` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Metric');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `sustainability_metric` SET TAGS ('dbx_value_regex' = 'circularity|waste_reduction|carbon_reduction');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `target_diversion_volume_kg` SET TAGS ('dbx_business_glossary_term' = 'Target Diversion Volume (KG)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ALTER COLUMN `target_year` SET TAGS ('dbx_business_glossary_term' = 'Target Year');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` SET TAGS ('dbx_subdomain' = 'social_impact');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `circular_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Activity Identifier (ACT_ID)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (LOCATION_ID)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (PARTNER_ID)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `activity_code` SET TAGS ('dbx_business_glossary_term' = 'Circular Activity Code (ACT_CODE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Description (ACT_DESC)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `activity_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activity Event Timestamp (ACT_TS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Circular Activity Type (ACT_TYPE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'collection|recovery|redistribution|composting|recycling');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `circular_activity_status` SET TAGS ('dbx_business_glossary_term' = 'Circular Activity Status (ACT_STATUS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `circular_activity_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `cost_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Cost Adjustment Amount (COST_ADJ)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `cost_adjustment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `cost_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Cost Amount (COST_GROSS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `cost_gross` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `cost_net` SET TAGS ('dbx_business_glossary_term' = 'Net Cost Amount (COST_NET)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `cost_net` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CODE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `environmental_benefit_co2_kg` SET TAGS ('dbx_business_glossary_term' = 'CO2 Emission Avoided (KG) (CO2_AVOIDED_KG)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `environmental_benefit_type` SET TAGS ('dbx_business_glossary_term' = 'Environmental Benefit Type (BENEFIT_TYPE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `environmental_benefit_type` SET TAGS ('dbx_value_regex' = 'co2_avoided|landfill_diverted|energy_saved');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method (MEAS_METHOD)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'weighed|estimated');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (REC_UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period (DATE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name (SRC_SYS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ALTER COLUMN `volume_diverted_kg` SET TAGS ('dbx_business_glossary_term' = 'Diverted Material Volume (KG) (VOLUME_DIVERTED_KG)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` SET TAGS ('dbx_subdomain' = 'environmental_reporting');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `lifecycle_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Assessment Identifier');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `formulation_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Version Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Identifier (INGREDIENT_ID)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'SKU Identifier (SKU_ID)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `acidification_kg_so2_eq` SET TAGS ('dbx_business_glossary_term' = 'Acidification Potential (ACID) kg SO₂‑eq');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (APPROVER)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date (DATE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `assessment_name` SET TAGS ('dbx_business_glossary_term' = 'Assessment Name (NAME)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `carbon_footprint_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint per Unit (CF_UNIT) kg CO₂e');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `circular_economy_program` SET TAGS ('dbx_business_glossary_term' = 'Circular Economy Program Participation (CIRC_ECON)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `circular_economy_program` SET TAGS ('dbx_value_regex' = 'yes|no');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `conducting_organization` SET TAGS ('dbx_business_glossary_term' = 'Conducting Organization (ORG)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source (SRC)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'internal|external|literature');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `energy_use_mj` SET TAGS ('dbx_business_glossary_term' = 'Energy Use (ENERGY_USE) MJ');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `esg_disclosure_framework` SET TAGS ('dbx_business_glossary_term' = 'ESG Disclosure Framework (ESG_FRAME)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `esg_disclosure_framework` SET TAGS ('dbx_value_regex' = 'GRI|CDP|SASB|TCFD');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `eutrophication_kg_n_eq` SET TAGS ('dbx_business_glossary_term' = 'Eutrophication Potential (EUTRO) kg N‑eq');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `functional_unit` SET TAGS ('dbx_business_glossary_term' = 'Functional Unit (FUNC_UNIT)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `gwp_kg_co2e` SET TAGS ('dbx_business_glossary_term' = 'Global Warming Potential (GWP) kg CO₂e');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `land_use_m2_year` SET TAGS ('dbx_business_glossary_term' = 'Land Use (LAND_USE) m²·year');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `lifecycle_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status (STATUS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `lifecycle_assessment_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'LCA Methodology (METH)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `methodology` SET TAGS ('dbx_value_regex' = 'ISO 14040|ISO 14044|ELCD|Ecoinvent');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes (NOTES)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `ozone_depletion_kg_cfc11_eq` SET TAGS ('dbx_business_glossary_term' = 'Ozone Depletion Potential (ODP) kg CFC‑11‑eq');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `packaging_recyclability` SET TAGS ('dbx_business_glossary_term' = 'Packaging Recyclability (PACK_REC)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `packaging_recyclability` SET TAGS ('dbx_value_regex' = 'recyclable|non_recyclable|compostable|unknown');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `renewable_energy_percent` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Share (RE_NEW) %');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `renewable_energy_usage_mj` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Usage (RE_USE) MJ');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `resource_use_mj` SET TAGS ('dbx_business_glossary_term' = 'Resource Use (RES_USE) MJ');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `responsible_sourcing_certification` SET TAGS ('dbx_business_glossary_term' = 'Responsible Sourcing Certification (SRC_CERT)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `responsible_sourcing_certification` SET TAGS ('dbx_value_regex' = 'rainforest_alliance|fair_trade|none');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Emission Scope (SCOPE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `scope` SET TAGS ('dbx_value_regex' = 'scope1|scope2|scope3');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `system_boundary` SET TAGS ('dbx_business_glossary_term' = 'System Boundary (SYS_BOUND)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `system_boundary` SET TAGS ('dbx_value_regex' = 'cradle-to-gate|cradle-to-grave|cradle-to-cradle');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Assessment Version (VER)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `waste_generated_kg` SET TAGS ('dbx_business_glossary_term' = 'Waste Generated (WASTE) kg');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `water_intensity_l_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Water Intensity (WATER_INT) L/kg');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `water_use_liters` SET TAGS ('dbx_business_glossary_term' = 'Water Use (WATER_USE) liters');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (CREATOR)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` SET TAGS ('dbx_subdomain' = 'resource_efficiency');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `environmental_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Instrument Identifier');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Allocated SKU Identifier (SKU_ID)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Allocated Facility Identifier (FAC_ID)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `allocation_scope` SET TAGS ('dbx_business_glossary_term' = 'Allocation Scope (ALLOC_SCOPE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `allocation_scope` SET TAGS ('dbx_value_regex' = 'scope_2|scope_3');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number (CERT_NO)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPL_STATUS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `environmental_instrument_description` SET TAGS ('dbx_business_glossary_term' = 'Instrument Description (DESC)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `environmental_instrument_status` SET TAGS ('dbx_business_glossary_term' = 'Instrument Status (STATUS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `environmental_instrument_status` SET TAGS ('dbx_value_regex' = 'active|retired|pending|cancelled');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type (INST_TYPE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_value_regex' = 'REC|GO|PPA|offset');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date (ISSUE_DT)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name (PROJ_NAME)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type (PROJ_TYPE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'solar|wind|hydro|reforestation|methane_capture');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity (QTY)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit (QTY_UNIT)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'MWh|tCO2e');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `registry` SET TAGS ('dbx_business_glossary_term' = 'Registry (REGISTRY)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `registry` SET TAGS ('dbx_value_regex' = 'ERCOT|M-RETS|TIGR|Gold_Standard|Verra');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `registry_code` SET TAGS ('dbx_business_glossary_term' = 'Registry Identifier (REG_ID)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date (RETIRE_DT)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `source_country` SET TAGS ('dbx_business_glossary_term' = 'Source Country (SRC_COUNTRY)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `source_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ALTER COLUMN `vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year (VINTAGE_YR)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` SET TAGS ('dbx_subdomain' = 'resource_efficiency');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `biodiversity_impact_id` SET TAGS ('dbx_business_glossary_term' = 'Biodiversity Impact Identifier');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `area_hectares` SET TAGS ('dbx_business_glossary_term' = 'Area (Hectares)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'satellite_imagery|ground_survey|third_party_audit');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessor_contact` SET TAGS ('dbx_business_glossary_term' = 'Assessor Email Contact');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessor_contact` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessor_contact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessor_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Full Name');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `biodiversity_score` SET TAGS ('dbx_business_glossary_term' = 'Biodiversity Impact Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `carbon_footprint_kg_per_hectare` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint (kg/ha)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|not_certified|in_progress');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'rainforest_alliance|fair_trade|none');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `commodity_type` SET TAGS ('dbx_value_regex' = 'palm_oil|soy|cocoa|beef|coffee|rubber');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|exempt');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score (%)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `deforestation_free_commitment` SET TAGS ('dbx_business_glossary_term' = 'Deforestation‑Free Commitment');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `deforestation_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Deforestation Risk Rating');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `deforestation_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp (UTC)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'biodiversity_assessment');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `impact_description` SET TAGS ('dbx_business_glossary_term' = 'Impact Description');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `land_use_type` SET TAGS ('dbx_business_glossary_term' = 'Land Use Type');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `land_use_type` SET TAGS ('dbx_value_regex' = 'agricultural|forest|wetland|grassland|other');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `last_monitoring_date` SET TAGS ('dbx_business_glossary_term' = 'Last Monitoring Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `mitigation_measures` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Measures');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'annual|biannual|quarterly|monthly');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `protected_area_name` SET TAGS ('dbx_business_glossary_term' = 'Protected Area Name');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `proximity_to_protected_areas_km` SET TAGS ('dbx_business_glossary_term' = 'Proximity to Protected Areas (km)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|archived|deleted');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `renewable_energy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Percentage');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `risk_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `sourcing_region` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Region (ISO Country Code)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `sourcing_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `waste_generated_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Waste Generated (tonnes)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `water_usage_liters_per_hectare` SET TAGS ('dbx_business_glossary_term' = 'Water Usage (L/ha)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` SET TAGS ('dbx_subdomain' = 'social_impact');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `social_impact_program_id` SET TAGS ('dbx_business_glossary_term' = 'Social Impact Program Identifier');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Initiative Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `beneficiary_population` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Population Description');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `geographic_focus` SET TAGS ('dbx_business_glossary_term' = 'Geographic Focus');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `geographic_reach` SET TAGS ('dbx_business_glossary_term' = 'Geographic Reach');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `investment_amount` SET TAGS ('dbx_business_glossary_term' = 'Program Investment Amount');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `measurement_period` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `outcome_quantity` SET TAGS ('dbx_business_glossary_term' = 'Outcome Quantity');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `outcome_type` SET TAGS ('dbx_business_glossary_term' = 'Outcome Type');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `outcome_type` SET TAGS ('dbx_value_regex' = 'farmers_trained|income_uplift|meals_donated|women_empowered|children_reached');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `partner_ngo` SET TAGS ('dbx_business_glossary_term' = 'Partner NGO');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_manager` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Name');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Email');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_manager_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Phone');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_manager_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Program Status Reason');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'farmer_livelihood|community_nutrition|gender_equity|employee_volunteering|capacity_building');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `sdg_contribution_evidence` SET TAGS ('dbx_business_glossary_term' = 'SDG Contribution Evidence');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `social_impact_program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `social_impact_program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|completed|suspended');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `sustainability_focus_area` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Focus Area');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `sustainability_focus_area` SET TAGS ('dbx_value_regex' = 'carbon|water|waste|energy|circular_economy|social');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `target_beneficiaries` SET TAGS ('dbx_business_glossary_term' = 'Target Beneficiaries');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `third_party_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Third‑Party Verification Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `third_party_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|rejected');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `un_sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'UN SDG Alignment');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` SET TAGS ('dbx_subdomain' = 'social_impact');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `social_impact_outcome_id` SET TAGS ('dbx_business_glossary_term' = 'Social Impact Outcome Identifier (SIO_ID)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `social_impact_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (PROGRAM_ID)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Beneficiaries (BENEFICIARY_COUNT)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `carbon_footprint_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint (KG CO2e) (CARBON_FOOTPRINT_KG)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System (DATA_SOURCE_SYS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region (GEOGRAPHIC_REGION)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope (GEOGRAPHIC_SCOPE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|national|local');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `impact_metric_unit` SET TAGS ('dbx_business_glossary_term' = 'Impact Metric Unit (IMPACT_UNIT)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `impact_metric_unit` SET TAGS ('dbx_value_regex' = 'people|kg|meals|hours|liters');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `impact_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Impact Metric Value (IMPACT_VALUE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology (MEASUREMENT_METHOD)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `measurement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date (MP_END_DATE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `measurement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date (MP_START_DATE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `outcome_description` SET TAGS ('dbx_business_glossary_term' = 'Outcome Description (OUTCOME_DESC)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `outcome_type` SET TAGS ('dbx_business_glossary_term' = 'Outcome Type (OUTCOME_TYPE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `outcome_type` SET TAGS ('dbx_value_regex' = 'farmers_trained|income_uplift|meals_donated|women_empowered|children_reached');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `packaging_recyclability_percent` SET TAGS ('dbx_business_glossary_term' = 'Packaging Recyclability Percentage (PACKAGING_RECYC_PCT)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status (RECORD_STATUS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `renewable_energy_usage_percent` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Usage Percentage (RENEWABLE_ENERGY_PCT)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `reporting_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Date (REPORTING_DATE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `sdg_contribution` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal Contribution (SDG_CONTRIB)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `sdg_target` SET TAGS ('dbx_business_glossary_term' = 'SDG Target (SDG_TARGET)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `third_party_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Verification Status (VERIFICATION_STATUS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `third_party_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|rejected');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `verification_body` SET TAGS ('dbx_business_glossary_term' = 'Verification Body (VERIFICATION_BODY)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_outcome` ALTER COLUMN `waste_reduction_kg` SET TAGS ('dbx_business_glossary_term' = 'Waste Reduction (KG) (WASTE_REDUCTION_KG)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` SET TAGS ('dbx_subdomain' = 'environmental_reporting');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `esg_rating_id` SET TAGS ('dbx_business_glossary_term' = 'ESG Rating ID');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `esg_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Disclosure Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `carbon_emission_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission (kg)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `cdp_score` SET TAGS ('dbx_business_glossary_term' = 'CDP Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `data_gaps_flagged` SET TAGS ('dbx_business_glossary_term' = 'Data Gaps Flagged');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `environment_score` SET TAGS ('dbx_business_glossary_term' = 'Environmental ESG Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `governance_score` SET TAGS ('dbx_business_glossary_term' = 'Governance ESG Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `gri_report_reference` SET TAGS ('dbx_business_glossary_term' = 'GRI Report Reference');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `index_inclusion_status` SET TAGS ('dbx_business_glossary_term' = 'Index Inclusion Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `index_inclusion_status` SET TAGS ('dbx_value_regex' = 'Included|Excluded|Pending');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `index_name` SET TAGS ('dbx_business_glossary_term' = 'Index Name');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `investor_inquiry_count` SET TAGS ('dbx_business_glossary_term' = 'Investor Inquiry Count');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall ESG Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `packaging_recyclability_percent` SET TAGS ('dbx_business_glossary_term' = 'Packaging Recyclability (%)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `prior_period_score` SET TAGS ('dbx_business_glossary_term' = 'Prior Period ESG Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `rating_agency` SET TAGS ('dbx_business_glossary_term' = 'Rating Agency');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `rating_category` SET TAGS ('dbx_business_glossary_term' = 'Rating Category');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `rating_category` SET TAGS ('dbx_value_regex' = 'Leader|Average|Laggard|Below_Average|Above_Average');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `rating_methodology_version` SET TAGS ('dbx_business_glossary_term' = 'Rating Methodology Version');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `rating_scope` SET TAGS ('dbx_business_glossary_term' = 'Rating Scope');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `rating_scope` SET TAGS ('dbx_value_regex' = 'Scope1|Scope2|Scope3|All');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `rating_status` SET TAGS ('dbx_business_glossary_term' = 'Rating Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `rating_status` SET TAGS ('dbx_value_regex' = 'Active|Superseded|Retired');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `renewable_energy_usage_percent` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Usage (%)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `responsible_sourcing_certifications` SET TAGS ('dbx_business_glossary_term' = 'Responsible Sourcing Certifications');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `score_change` SET TAGS ('dbx_business_glossary_term' = 'Score Change');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `score_detractors` SET TAGS ('dbx_business_glossary_term' = 'Score Detractors');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `score_drivers` SET TAGS ('dbx_business_glossary_term' = 'Score Drivers');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `social_score` SET TAGS ('dbx_business_glossary_term' = 'Social ESG Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `sustainability_target_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Alignment');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `waste_reduction_percent` SET TAGS ('dbx_business_glossary_term' = 'Waste Reduction (%)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_rating` ALTER COLUMN `water_usage_intensity` SET TAGS ('dbx_business_glossary_term' = 'Water Usage Intensity');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Initiative ID (INIT_ID)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Owner Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `actual_co2e_tonnes_avoided` SET TAGS ('dbx_business_glossary_term' = 'Actual CO2e Emissions Avoided (TONNES_CO2E_ACT)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date (ACTUAL_END_DATE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `actual_waste_kg_diverted` SET TAGS ('dbx_business_glossary_term' = 'Actual Waste Diverted (KG_WASTE_ACT)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `actual_water_m3_saved` SET TAGS ('dbx_business_glossary_term' = 'Actual Water Saved (M3_WATER_ACT)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `capital_investment_required_usd` SET TAGS ('dbx_business_glossary_term' = 'Capital Investment Required (USD_CAPITAL_INVEST)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Status (DATA_QUAL_STATUS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_value_regex' = 'pending|validated|rejected');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `esg_pillar` SET TAGS ('dbx_business_glossary_term' = 'Environmental, Social, and Governance Pillar (ESG_PILLAR)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `esg_pillar` SET TAGS ('dbx_value_regex' = 'environmental|social|governance');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status (IMPL_STATUS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `implementation_status` SET TAGS ('dbx_value_regex' = 'not_started|started|midway|completed');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_category` SET TAGS ('dbx_business_glossary_term' = 'Initiative Category (INIT_CATEGORY)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_code` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Initiative Code (INIT_CODE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_description` SET TAGS ('dbx_business_glossary_term' = 'Initiative Description (DESC)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_name` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Initiative Name (INIT_NAME)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_status` SET TAGS ('dbx_business_glossary_term' = 'Initiative Lifecycle Status (INIT_STATUS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|on_hold|cancelled');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `linked_sustainability_target` SET TAGS ('dbx_business_glossary_term' = 'Linked Corporate Sustainability Target (TARGET_CODE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `operating_cost_savings_usd` SET TAGS ('dbx_business_glossary_term' = 'Operating Cost Savings (USD_OP_COST_SAV)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `owning_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Owning Business Unit (BUS_UNIT)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `packaging_recyclability_percent` SET TAGS ('dbx_business_glossary_term' = 'Packaging Recyclability Percent (PACK_RECYCL_PCT)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `payback_period_years` SET TAGS ('dbx_business_glossary_term' = 'Payback Period (YEARS_PAYBACK)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `phase_gate` SET TAGS ('dbx_business_glossary_term' = 'Phase Gate (PHASE_GATE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `phase_gate` SET TAGS ('dbx_value_regex' = 'concept|design|pilot|scale|full');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `projected_co2e_tonnes_avoided` SET TAGS ('dbx_business_glossary_term' = 'Projected CO2e Emissions Avoided (TONNES_CO2E_PROJ)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `projected_end_date` SET TAGS ('dbx_business_glossary_term' = 'Projected End Date (PROJECTED_END_DATE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `projected_waste_kg_diverted` SET TAGS ('dbx_business_glossary_term' = 'Projected Waste Diverted (KG_WASTE_PROJ)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `projected_water_m3_saved` SET TAGS ('dbx_business_glossary_term' = 'Projected Water Saved (M3_WATER_PROJ)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `renewable_energy_usage_percent` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Usage Percent (RENEW_ENERGY_PCT)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date (REPORT_END)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date (REPORT_START)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `responsible_sourcing_certifications` SET TAGS ('dbx_business_glossary_term' = 'Responsible Sourcing Certifications (CERTIFICATIONS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `roi_percent` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment Percent (ROI_PCT)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Record (SRC_SYSTEM)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `stakeholder_engagement_score` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Engagement Score (ENGAGE_SCORE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Initiative Start Date (START_DATE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` SET TAGS ('dbx_subdomain' = 'resource_efficiency');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `carbon_offset_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Record Identifier');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `allocation_category` SET TAGS ('dbx_business_glossary_term' = 'Allocation Category');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `allocation_scope` SET TAGS ('dbx_business_glossary_term' = 'Allocation Scope');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `allocation_scope` SET TAGS ('dbx_value_regex' = 'Scope 1|Scope 2|Scope 3');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `carbon_offset_status` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `carbon_offset_status` SET TAGS ('dbx_value_regex' = 'purchased|retired|pending|cancelled');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Offset Cost (USD)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `offset_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Offset Reference Number');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `offset_type` SET TAGS ('dbx_business_glossary_term' = 'Offset Project Type');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `offset_type` SET TAGS ('dbx_value_regex' = 'reforestation|soil_carbon|methane_capture|cookstoves');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `price_per_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Price per tCO₂e');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `project_location` SET TAGS ('dbx_business_glossary_term' = 'Project Location');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `quantity_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Quantity (tCO₂e)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `registry_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Registry Serial Number');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `standard` SET TAGS ('dbx_business_glossary_term' = 'Offset Standard');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `standard` SET TAGS ('dbx_value_regex' = 'Gold Standard|VCS|ACR');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `verification_body` SET TAGS ('dbx_business_glossary_term' = 'Verification Body');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|rejected');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` SET TAGS ('dbx_subdomain' = 'environmental_reporting');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Audit ID');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Initiative Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `assurance_level` SET TAGS ('dbx_business_glossary_term' = 'Audit Assurance Level (AUD_ASSURANCE_LEVEL)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `assurance_level` SET TAGS ('dbx_value_regex' = 'limited|reasonable|high');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `assurance_provider` SET TAGS ('dbx_business_glossary_term' = 'Audit Assurance Provider (AUD_ASSURANCE_PROVIDER)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date (AUD_DATE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number (AUD_NO)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_value_regex' = '^AUD-[0-9]{8}$');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope (AUD_SCOPE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_value_regex' = 'facility|supplier|distribution_center|corporate|multiple');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status (AUD_STATUS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type (AUD_TYPE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'iso_14001|social_compliance|esg_assurance|packaging_recyclability|deforestation_free|other');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `audited_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Audited Entity Name (AUDITED_ENTITY_NAME)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Full Name (AUDITOR_NAME)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `auditor_organization` SET TAGS ('dbx_business_glossary_term' = 'Auditing Organization (AUDITOR_ORG)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `carbon_footprint_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint (kg CO2e) (CARB_FOOTPRINT_KG)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `cdp_score` SET TAGS ('dbx_business_glossary_term' = 'CDP Score (CDP_SCORE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `certification` SET TAGS ('dbx_business_glossary_term' = 'Audit Certification Outcome (AUD_CERT_OUTCOME)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `certification` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional|not_applicable');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Certification Date (AUD_CERT_DATE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Certification Number (AUD_CERT_NO)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `certification_number` SET TAGS ('dbx_value_regex' = '^CERT-[A-Z0-9]{6}$');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date (CAP_DUE_DATE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status (CAP_STATUS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Audit Data Source System (AUD_DATA_SRC)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Audit Duration (Days) (AUD_DUR_DAYS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `emission_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Emission Scope (AUD_EMISS_SCOPE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `emission_scope` SET TAGS ('dbx_value_regex' = 'scope1|scope2|scope3|all');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `findings_severity` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Severity (AUD_FIND_SEV)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `findings_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|observation|none');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `gri_disclosure_topic` SET TAGS ('dbx_business_glossary_term' = 'GRI Disclosure Topic (GRI_TOPIC)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Audit Location Identifier (AUD_LOCATION_ID)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes (AUD_NOTES)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Audit Outcome (AUD_OUTCOME)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional|not_applicable');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `packaging_recyclability_percent` SET TAGS ('dbx_business_glossary_term' = 'Packaging Recyclability Percent (PACK_RECYCLABILITY_PCT)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (REC_UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Audit Region (ISO 3166-1 Alpha-3 Country Code) (AUD_REGION)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `renewable_energy_percent` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Usage Percent (RENEWABLE_ENERGY_PCT)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `report_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Report URL (AUD_REPORT_URL)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `responsible_sourcing_certifications` SET TAGS ('dbx_business_glossary_term' = 'Responsible Sourcing Certifications (RESP_SOURCING_CERTS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `scope_boundary` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope Boundary Description (AUD_SCOPE_BOUNDARY)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `standard` SET TAGS ('dbx_business_glossary_term' = 'Audit Standard (AUD_STD)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Verification Date (AUD_VERIF_DATE)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Verification Status (AUD_VERIF_STATUS)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `waste_generated_kg` SET TAGS ('dbx_business_glossary_term' = 'Waste Generated (kg) (WASTE_GEN_KG)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ALTER COLUMN `water_usage_m3` SET TAGS ('dbx_business_glossary_term' = 'Water Usage (cubic meters) (WATER_USAGE_M3)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` SET TAGS ('dbx_subdomain' = 'environmental_reporting');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `materiality_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Materiality Assessment ID');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Assessor Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `previous_materiality_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `approved_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `assessment_conducted_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Conducted Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_business_glossary_term' = 'Assessment Methodology');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_value_regex' = 'GRI|ESRS|CSRD|Other');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `assessment_name` SET TAGS ('dbx_business_glossary_term' = 'Materiality Assessment Name');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|completed|approved|archived');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'double_materiality|single_materiality');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `board_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Board Approval Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `disclosure_scope` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Scope');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `disclosure_scope` SET TAGS ('dbx_value_regex' = 'scope1|scope2|scope3|all');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `environmental_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `esg_pillar` SET TAGS ('dbx_business_glossary_term' = 'ESG Pillar');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `esg_pillar` SET TAGS ('dbx_value_regex' = 'environmental|social|governance');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `final_material_topics` SET TAGS ('dbx_business_glossary_term' = 'Final Material Topics');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `financial_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `governance_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Governance Impact Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `materiality_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Materiality Score Threshold');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `materiality_threshold_criteria` SET TAGS ('dbx_business_glossary_term' = 'Materiality Threshold Criteria');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `overall_materiality_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Materiality Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `reassessment_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Reassessment Frequency (Months)');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'GRI|CDP|SASB|TCFD|EU CSRD');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `responsible_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Responsible Business Unit');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP|Oracle|Salesforce|Custom');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `stakeholder_engagement_score` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Engagement Score');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `stakeholder_groups_consulted` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Groups Consulted');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `topic_universe_evaluated` SET TAGS ('dbx_business_glossary_term' = 'Topic Universe Evaluated');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|rejected');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `verified_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `verified_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
