-- Schema for Domain: sustainability | Business: Apparel Fashion | Version: v1_ecm
-- Generated on: 2026-05-05 15:54:39

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `apparel_fashion_ecm`.`sustainability` COMMENT 'Manages ESG reporting, carbon footprint tracking, circular economy programs, sustainable material certifications, and environmental impact assessments across the apparel supply chain';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` (
    `esg_report_id` BIGINT COMMENT 'Unique identifier for the ESG report record. Primary key.',
    `previous_report_esg_report_id` BIGINT COMMENT 'Reference to the prior period ESG report for year-over-year comparison and trend analysis.',
    `prior_period_esg_report_id` BIGINT COMMENT 'Self-referencing FK on esg_report (prior_period_esg_report_id)',
    `approval_date` DATE COMMENT 'Date on which the ESG report received final approval from executive leadership or board of directors.',
    `approved_by` STRING COMMENT 'Name and title of the executive or board member who provided final approval for the ESG report.',
    `assurance_provider` STRING COMMENT 'Name of the external third-party organization that provided assurance services for this ESG report.',
    `assurance_standard` STRING COMMENT 'Specific assurance standard or methodology applied by the assurance provider (e.g., ISAE 3000, AA1000AS).',
    `assurance_status` STRING COMMENT 'Level of external third-party assurance obtained for this ESG report.. Valid values are `Not Assured|Limited Assurance|Reasonable Assurance|In Progress`',
    `consolidation_approach` STRING COMMENT 'Method used to determine which entities and operations are included in the ESG report scope.. Valid values are `Operational Control|Financial Control|Equity Share|Full Consolidation`',
    `contact_email` STRING COMMENT 'Email address for stakeholder inquiries and feedback regarding this ESG report.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_person_name` STRING COMMENT 'Name of the individual responsible for inquiries related to this ESG report.',
    `contact_phone` STRING COMMENT 'Phone number for stakeholder inquiries regarding this ESG report.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ESG report record was first created in the system.',
    `disclosure_level` STRING COMMENT 'Extent and depth of ESG disclosures included in this report relative to framework requirements.. Valid values are `Core|Comprehensive|Partial|Voluntary|Mandatory`',
    `document_format` STRING COMMENT 'Primary file format in which the ESG report is published and distributed.. Valid values are `PDF|HTML|XBRL|Interactive|Multi-Format`',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this ESG report corresponds, typically four-digit year (e.g., 2024).',
    `gri_content_index_included` BOOLEAN COMMENT 'Indicates whether the report includes a GRI content index mapping disclosures to GRI standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ESG report record was last updated in the system.',
    `materiality_assessment_conducted` BOOLEAN COMMENT 'Indicates whether a formal materiality assessment was performed to identify significant ESG topics for this report.',
    `notes` STRING COMMENT 'Additional notes, disclaimers, or contextual information relevant to this ESG report.',
    `page_count` STRING COMMENT 'Total number of pages in the published ESG report document.',
    `publication_date` DATE COMMENT 'Date on which the ESG report was officially published and made available to stakeholders.',
    `report_language` STRING COMMENT 'Primary language in which the ESG report is published, using ISO 639-2 three-letter language code.. Valid values are `^[A-Z]{3}$`',
    `report_number` STRING COMMENT 'Externally-known unique identifier for the ESG report, typically following format ESG-YYYY-####.. Valid values are `^ESG-[0-9]{4}-[0-9]{4}$`',
    `report_status` STRING COMMENT 'Current lifecycle status of the ESG report in the publication workflow.. Valid values are `Draft|Under Review|Approved|Published|Archived|Withdrawn`',
    `report_title` STRING COMMENT 'Official title of the ESG report as published to stakeholders.',
    `report_type` STRING COMMENT 'Classification of the report based on publication frequency and purpose.. Valid values are `Annual|Biannual|Quarterly|Ad-Hoc|Integrated`',
    `report_url` STRING COMMENT 'Web address where the published ESG report can be accessed by stakeholders.. Valid values are `^https?://.*`',
    `reporting_framework` STRING COMMENT 'Primary sustainability reporting framework used for this report. GRI=Global Reporting Initiative, SASB=Sustainability Accounting Standards Board, TCFD=Task Force on Climate-related Financial Disclosures, CDP=Carbon Disclosure Project, ISSB=International Sustainability Standards Board, CSRD=Corporate Sustainability Reporting Directive. [ENUM-REF-CANDIDATE: GRI|SASB|TCFD|CDP|ISSB|CSRD|Integrated — 7 candidates stripped; promote to reference product]',
    `reporting_period_end_date` DATE COMMENT 'Last day of the period covered by this ESG report.',
    `reporting_period_start_date` DATE COMMENT 'First day of the period covered by this ESG report.',
    `restatement_explanation` STRING COMMENT 'Detailed explanation of any restatements made to previously reported ESG data, including reasons and impact.',
    `restatement_flag` BOOLEAN COMMENT 'Indicates whether this report includes restatements of information from previous reporting periods.',
    `sasb_index_included` BOOLEAN COMMENT 'Indicates whether the report includes a SASB index mapping disclosures to SASB standards for the apparel industry.',
    `scope_boundary_description` STRING COMMENT 'Detailed description of organizational and operational boundaries included in this ESG report (e.g., which subsidiaries, geographies, business units are covered).',
    `stakeholder_engagement_conducted` BOOLEAN COMMENT 'Indicates whether formal stakeholder engagement activities were conducted as part of the report preparation process.',
    `submission_date` DATE COMMENT 'Date on which the ESG report was submitted to regulatory bodies, rating agencies, or disclosure platforms.',
    `target_audience` STRING COMMENT 'Primary intended audience or stakeholder group for this ESG report. [ENUM-REF-CANDIDATE: Investors|Regulators|Customers|Employees|NGOs|General Public|Multi-Stakeholder — 7 candidates stripped; promote to reference product]',
    `tcfd_alignment` BOOLEAN COMMENT 'Indicates whether the report is aligned with TCFD recommendations for climate-related financial disclosures.',
    `un_sdg_alignment` STRING COMMENT 'Comma-separated list of UN Sustainable Development Goal numbers that this report addresses (e.g., 8,12,13 for Decent Work, Responsible Consumption, Climate Action).',
    `version_number` STRING COMMENT 'Version identifier for this ESG report, typically in format major.minor (e.g., 1.0, 1.1, 2.0).. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_esg_report PRIMARY KEY(`esg_report_id`)
) COMMENT 'Master record for periodic ESG (Environmental, Social, Governance) disclosure reports published by Apparel Fashion, covering reporting period, framework (GRI, SASB, TCFD, CDP), scope boundaries, assurance status, and publication metadata. Serves as the authoritative header for all ESG disclosures submitted to investors, regulators, and rating agencies.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` (
    `carbon_emission_id` BIGINT COMMENT 'Unique identifier for the carbon emission record. Primary key for the carbon emission transactional event.',
    `carbon_target_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_target. Business justification: Carbon emissions should be tracked against specific reduction targets for progress monitoring and SBTi reporting. Enables attribution of emissions to targets for gap analysis. N:1 relationship (many e',
    `concept_id` BIGINT COMMENT 'Foreign key linking to design.concept. Business justification: Concept-level carbon footprint estimation guides design decisions during early-stage development. Real process: early-stage LCA at concept phase using Higg MSI or similar tools to inform material/cons',
    `esg_report_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_report. Business justification: Emissions data must be associated with the ESG report period in which they are disclosed. Critical for audit trail, period-specific reporting, and CDP disclosure. N:1 relationship (many emissions in o',
    `production_factory_id` BIGINT COMMENT 'Foreign key reference to the facility where the emission occurred, if applicable (factory, warehouse, store, office).',
    `scope3_category_id` BIGINT COMMENT 'Foreign key linking to sustainability.scope3_category. Business justification: Scope 3 carbon emissions must be classified into one of the 15 GHG Protocol Scope 3 categories (purchased goods, business travel, employee commuting, etc.). The carbon_emission table has emission_scop',
    `vendor_id` BIGINT COMMENT 'Foreign key reference to the supplier responsible for the emission, applicable for Scope 3 upstream emissions.',
    `corrected_carbon_emission_id` BIGINT COMMENT 'Self-referencing FK on carbon_emission (corrected_carbon_emission_id)',
    `activity_data_unit` STRING COMMENT 'Unit of measure for the activity data value, standardized for carbon accounting calculations. [ENUM-REF-CANDIDATE: kWh|MWh|liters|gallons|kg|tonnes|tonne-km|passenger-km|m3|GJ — 10 candidates stripped; promote to reference product]',
    `activity_data_value` DECIMAL(18,2) COMMENT 'Quantitative measure of the activity that generated the emission (e.g., 1500 kWh electricity, 250 liters diesel, 1200 tonne-km freight).',
    `activity_type` STRING COMMENT 'Type of business activity that generated the emission, used to link emission to operational processes. [ENUM-REF-CANDIDATE: Energy Consumption|Fuel Combustion|Freight Transport|Air Travel|Waste Generation|Material Processing|Refrigerant Leakage|Water Treatment — 8 candidates stripped; promote to reference product]',
    `biogenic_emission_flag` BOOLEAN COMMENT 'Indicates whether the emission is biogenic (from biomass/biological sources) and should be reported separately per GHG Protocol guidance.',
    `calculation_method` STRING COMMENT 'Method used to calculate the emission quantity, indicating the level of accuracy and data quality.. Valid values are `Direct Measurement|Emission Factor|Mass Balance|Supplier-Specific|Industry Average|Spend-Based`',
    `cdp_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this emission record is included in CDP climate change disclosure reporting.',
    `ch4_quantity_kg` DECIMAL(18,2) COMMENT 'Quantity of methane emitted in kilograms, reported separately for detailed gas composition analysis.',
    `co2_quantity_kg` DECIMAL(18,2) COMMENT 'Quantity of carbon dioxide emitted in kilograms, reported separately for detailed gas composition analysis.',
    `co2e_quantity_kg` DECIMAL(18,2) COMMENT 'Total greenhouse gas emission calculated in kilograms of CO2 equivalent, representing the global warming potential of all GHGs emitted.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this emission record was first created in the system, used for audit trail and data lineage.',
    `data_quality_score` STRING COMMENT 'Quality score (1-5) indicating the reliability and accuracy of the emission data, with 5 being highest quality (direct measurement) and 1 being lowest (estimated/modeled).',
    `emission_date` DATE COMMENT 'Date when the emission event occurred or was recorded, used for temporal analysis and reporting period allocation.',
    `emission_event_number` STRING COMMENT 'Business identifier for the emission event, used for external reporting and audit trails. Format: CE-XXXXXXXXXX.. Valid values are `^CE-[0-9]{10}$`',
    `emission_factor_source` STRING COMMENT 'Source database or standard from which the emission factor was obtained (e.g., IPCC 2021, DEFRA 2023, EPA eGRID).',
    `emission_factor_value` DECIMAL(18,2) COMMENT 'Emission factor applied to convert activity data to CO2 equivalent emissions, expressed as kg CO2e per unit of activity.',
    `emission_factor_version` STRING COMMENT 'Version or publication year of the emission factor database used, ensuring traceability and consistency in carbon accounting.',
    `emission_scope` STRING COMMENT 'GHG Protocol scope classification: Scope 1 (direct emissions from owned/controlled sources), Scope 2 (indirect emissions from purchased energy), Scope 3 (all other indirect emissions in value chain).. Valid values are `Scope 1|Scope 2|Scope 3`',
    `emission_source_identifier` STRING COMMENT 'Unique identifier of the specific source entity (facility code, vehicle ID, material batch, logistics route) that generated the emission.',
    `emission_source_name` STRING COMMENT 'Human-readable name or description of the emission source (e.g., Vietnam Factory A, NYC Distribution Center, Cotton Supplier X).',
    `emission_source_type` STRING COMMENT 'Type of physical or operational source generating the emission within the apparel supply chain. [ENUM-REF-CANDIDATE: Factory|Distribution Center|Retail Store|Warehouse|Office|Logistics Leg|Raw Material|Packaging Material|Finished Goods|Waste Stream|Energy Grid — 11 candidates stripped; promote to reference product]',
    `geographic_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the emission occurred, used for geographic segmentation and regional reporting.. Valid values are `^[A-Z]{3}$`',
    `geographic_region` STRING COMMENT 'Business-defined geographic region (e.g., North America, EMEA, APAC) for regional carbon footprint analysis.',
    `n2o_quantity_kg` DECIMAL(18,2) COMMENT 'Quantity of nitrous oxide emitted in kilograms, reported separately for detailed gas composition analysis.',
    `notes` STRING COMMENT 'Free-text field for additional context, assumptions, or explanations related to the emission calculation or data source.',
    `offset_applied_flag` BOOLEAN COMMENT 'Indicates whether a carbon offset or credit has been applied to neutralize this emission.',
    `offset_project_identifier` STRING COMMENT 'Unique identifier of the carbon offset project or credit registry (e.g., Verra VCS project ID, Gold Standard ID) used to offset this emission.',
    `offset_quantity_kg` DECIMAL(18,2) COMMENT 'Quantity of carbon offsets applied to this emission in kilograms CO2e, if offset_applied_flag is true.',
    `other_ghg_quantity_kg` DECIMAL(18,2) COMMENT 'Quantity of other greenhouse gases (HFCs, PFCs, SF6, NF3) emitted in kilograms CO2e, aggregated for reporting.',
    `renewable_energy_flag` BOOLEAN COMMENT 'Indicates whether the energy source for this emission was from renewable sources (solar, wind, hydro), relevant for Scope 2 market-based accounting.',
    `reporting_period_end_date` DATE COMMENT 'End date of the reporting period to which this emission is allocated, used for annual and periodic carbon accounting.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the reporting period to which this emission is allocated (e.g., fiscal year, calendar year, quarter).',
    `reporting_year` STRING COMMENT 'Calendar or fiscal year for which the emission is reported, facilitating year-over-year trend analysis and regulatory compliance.',
    `science_based_target_alignment` BOOLEAN COMMENT 'Indicates whether this emission is tracked against the companys Science-Based Targets initiative commitments.',
    `source_system` STRING COMMENT 'Name of the operational system or data source from which this emission record originated (e.g., SAP ERP, IoT sensor platform, supplier portal).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this emission record was last modified, used for audit trail and change tracking.',
    `verification_date` DATE COMMENT 'Date when the emission data was verified or audited, applicable for third-party verified or certified records.',
    `verification_status` STRING COMMENT 'Status indicating whether the emission data has been verified or audited by internal or external parties.. Valid values are `Unverified|Internal Review|Third-Party Verified|Certified`',
    `verifier_organization` STRING COMMENT 'Name of the third-party organization that verified the emission data, if applicable.',
    CONSTRAINT pk_carbon_emission PRIMARY KEY(`carbon_emission_id`)
) COMMENT 'Transactional record of greenhouse gas (GHG) emission events across Scope 1, Scope 2, and Scope 3 categories for Apparel Fashion operations and supply chain. Captures emission source (factory, DC, retail store, logistics leg, raw material), activity data (energy kWh, fuel liters, freight tonne-km), emission factor applied, CO2e quantity calculated, and reporting period. Supports GHG Protocol and CDP carbon accounting.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` (
    `carbon_target_id` BIGINT COMMENT 'Unique identifier for the carbon reduction target record.',
    `esg_report_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_report. Business justification: Carbon targets are disclosed in ESG reports. Need to link targets to the report where they were first published or updated for disclosure tracking and stakeholder communication. N:1 relationship. No b',
    `superseded_carbon_target_id` BIGINT COMMENT 'Self-referencing FK on carbon_target (superseded_carbon_target_id)',
    `assurance_level` STRING COMMENT 'Level of assurance provided by the third-party verifier: limited (moderate assurance), reasonable (high assurance), or none (no external verification).. Valid values are `limited|reasonable|none`',
    `assurance_provider` STRING COMMENT 'Name of the third-party organization providing independent verification and assurance of emissions data and target progress (e.g., Deloitte, EY, Bureau Veritas).',
    `baseline_emissions_mt_co2e` DECIMAL(18,2) COMMENT 'Total greenhouse gas emissions in the baseline year expressed in metric tons of carbon dioxide equivalent (MT CO2e). Represents the starting point for measuring reduction progress.',
    `baseline_intensity_value` DECIMAL(18,2) COMMENT 'Emissions intensity in the baseline year (e.g., MT CO2e per million USD revenue). Null for absolute targets.',
    `baseline_year` STRING COMMENT 'The reference year against which carbon reduction progress is measured (e.g., 2019, 2020). Typically aligned with the most recent complete emissions inventory prior to target setting.',
    `board_approval_date` DATE COMMENT 'Date on which the Board of Directors or equivalent governance body formally approved this carbon reduction target.',
    `boundary_description` STRING COMMENT 'Textual description of the organizational and operational boundaries covered by this target (e.g., Global operations including all owned facilities, leased warehouses, and corporate offices; excludes franchised stores).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this carbon target record was first created in the system.',
    `current_emissions_mt_co2e` DECIMAL(18,2) COMMENT 'Most recent annual emissions measurement in metric tons CO2e for the scopes covered by this target. Used to track progress toward the target.',
    `current_year` STRING COMMENT 'The reporting year for the current emissions measurement. Tracks the most recent progress data point.',
    `disclosure_date` DATE COMMENT 'Date on which this target was first publicly disclosed or announced.',
    `external_assurance_flag` BOOLEAN COMMENT 'Indicates whether emissions data and progress toward this target have been verified by an independent third-party assurance provider.',
    `intensity_metric` STRING COMMENT 'The denominator used for intensity-based targets (e.g., emissions per million USD revenue, per garment produced, per square meter of retail space, per employee). Set to none for absolute targets.. Valid values are `revenue|unit_produced|square_meter|employee|none`',
    `last_assurance_date` DATE COMMENT 'Date of the most recent third-party assurance or verification of emissions data related to this target.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of target progress and validity by management or sustainability governance committee.',
    `methodology_notes` STRING COMMENT 'Additional notes on calculation methodology, assumptions, exclusions, or special considerations applied in setting or tracking this target.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of target progress and validity.',
    `on_track_flag` BOOLEAN COMMENT 'Boolean indicator of whether the target is on track to be achieved by the target year based on current progress trajectory and linear reduction pathway.',
    `progress_percentage` DECIMAL(18,2) COMMENT 'Percentage of the target reduction achieved to date, calculated as (baseline emissions - current emissions) / (baseline emissions - target emissions) * 100. Values over 100 indicate over-achievement.',
    `public_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this target has been publicly disclosed in sustainability reports, CDP submissions, or other external communications.',
    `responsible_executive` STRING COMMENT 'Name or title of the executive accountable for achieving this target (e.g., Chief Sustainability Officer, VP Supply Chain).',
    `sbti_approval_date` DATE COMMENT 'Date on which the Science Based Targets initiative formally approved this target as science-based and aligned with the 1.5°C pathway.',
    `sbti_commitment_letter_date` DATE COMMENT 'Date on which Apparel Fashion submitted its commitment letter to the Science Based Targets initiative, pledging to set science-based targets within 24 months.',
    `sbti_validation_status` STRING COMMENT 'Current status of third-party validation by the Science Based Targets initiative. Approved targets are aligned with climate science to limit global warming to 1.5°C.. Valid values are `not_submitted|under_review|approved|rejected|expired`',
    `scope_3_category_coverage` STRING COMMENT 'Comma-separated list of GHG Protocol Scope 3 categories included in this target (e.g., Category 1: Purchased Goods and Services, Category 4: Upstream Transportation, Category 11: Use of Sold Products). Null if target does not cover Scope 3.',
    `scope_coverage` STRING COMMENT 'GHG Protocol emission scopes covered by this target: Scope 1 (direct emissions), Scope 2 (purchased energy), Scope 3 (value chain), or combinations thereof.. Valid values are `scope_1|scope_2|scope_3|scope_1_2|scope_1_2_3`',
    `target_emissions_mt_co2e` DECIMAL(18,2) COMMENT 'Absolute emissions level in metric tons CO2e that must be achieved by the target year to meet the reduction commitment. Calculated as baseline emissions minus the reduction percentage.',
    `target_intensity_value` DECIMAL(18,2) COMMENT 'Target emissions intensity to be achieved by the target year (e.g., MT CO2e per million USD revenue). Null for absolute targets.',
    `target_name` STRING COMMENT 'Business-friendly name or label for the carbon reduction target (e.g., 2030 Scope 1+2 Absolute Reduction, Supply Chain Intensity Target).',
    `target_reduction_percentage` DECIMAL(18,2) COMMENT 'The percentage reduction in emissions committed to achieve by the target year, relative to the baseline year (e.g., 50.00 represents a 50% reduction commitment).',
    `target_status` STRING COMMENT 'Current lifecycle status of the carbon target: draft (under development), active (in force), achieved (met ahead of schedule), expired (target year passed), retired (no longer pursued), superseded (replaced by new target).. Valid values are `draft|active|achieved|expired|retired|superseded`',
    `target_type` STRING COMMENT 'Classification of the carbon target methodology: absolute (total emissions reduction in metric tons CO2e) or intensity (emissions per unit of activity such as revenue, production volume, or square footage).. Valid values are `absolute|intensity`',
    `target_year` STRING COMMENT 'The year by which the carbon reduction target must be achieved (e.g., 2030, 2050). Defines the time horizon for the commitment.',
    `temperature_alignment` STRING COMMENT 'The global warming scenario that this target is aligned with, based on climate science (e.g., 1.5°C pathway per Paris Agreement ambition).. Valid values are `1_5_degrees|well_below_2_degrees|2_degrees|not_aligned`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this carbon target record was last modified in the system.',
    CONSTRAINT pk_carbon_target PRIMARY KEY(`carbon_target_id`)
) COMMENT 'Master record defining Apparel Fashions science-based and internal carbon reduction targets, including target type (absolute, intensity), baseline year, target year, baseline emissions, target reduction percentage, SBTi validation status, and progress tracking. Covers Scope 1, 2, and 3 targets aligned to 1.5°C pathway commitments.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` (
    `sustainable_material_id` BIGINT COMMENT 'Unique identifier for the sustainable material record. Primary key for the sustainable material master catalog.',
    `vendor_id` BIGINT COMMENT 'Reference to the preferred supplier for this sustainable material. Links to supplier master data for sourcing and procurement.',
    `derived_from_sustainable_material_id` BIGINT COMMENT 'Self-referencing FK on sustainable_material (derived_from_sustainable_material_id)',
    `approval_date` DATE COMMENT 'Date when the sustainable material was approved for use in Apparel Fashion products. Null if material is pending approval.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the sustainable material for use. Used for audit trail and governance.',
    `biodegradable_flag` BOOLEAN COMMENT 'Indicates whether the material is biodegradable under standard environmental conditions. True if biodegradable, False otherwise.',
    `carbon_footprint_kg_co2e` DECIMAL(18,2) COMMENT 'Carbon footprint of the material per kilogram in CO2 equivalent emissions. Used for environmental impact assessment and ESG reporting.',
    `certification_expiry_date` DATE COMMENT 'Date when the sustainability certification expires. Null if certification does not expire or material is not certified. Critical for compliance monitoring.',
    `certification_number` STRING COMMENT 'Unique certification identifier or license number issued by the certifying body. Required for traceability and audit compliance.',
    `certification_type` STRING COMMENT 'Primary sustainability certification held by the material. GOTS (Global Organic Textile Standard), GRS (Global Recycled Standard), OEKO-TEX Standard 100, bluesign, BCI (Better Cotton Initiative), FSC (Forest Stewardship Council), Cradle to Cradle, Fair Trade, RCS (Recycled Claim Standard), OCS (Organic Content Standard). [ENUM-REF-CANDIDATE: gots|grs|oeko_tex|bluesign|bci|fsc|cradle_to_cradle|fair_trade|rcs|ocs — 10 candidates stripped; promote to reference product]',
    `chemical_compliance_status` STRING COMMENT 'Status of material compliance with restricted substance lists (RSL) and manufacturing restricted substance lists (MRSL). Indicates whether material meets chemical safety standards.. Valid values are `compliant|non_compliant|pending_review|restricted`',
    `circular_economy_eligible_flag` BOOLEAN COMMENT 'Indicates whether the material is eligible for circular economy programs (take-back, recycling, upcycling). True if eligible, False otherwise.',
    `color_fastness_rating` STRING COMMENT 'Color fastness rating indicating resistance to fading (Grade 1 poor to Grade 5 excellent). Critical quality metric for apparel materials.. Valid values are `grade_1|grade_2|grade_3|grade_4|grade_5`',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost per unit of measure for the sustainable material. Used for COGS calculation and product costing. Business-confidential pricing data.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the material is produced. Required for trade compliance and customs documentation.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sustainable material record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost per unit (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `esg_score` DECIMAL(18,2) COMMENT 'Composite ESG score for the material based on environmental impact, social responsibility, and governance criteria (0.00 to 100.00). Used for sustainability reporting and material selection.',
    `fiber_composition` STRING COMMENT 'Detailed fiber composition breakdown with percentages (e.g., 80% Organic Cotton, 20% Recycled Polyester). Required for FTC labeling compliance.',
    `fiber_type` STRING COMMENT 'Primary fiber type of the material. Indicates the base fiber composition category. [ENUM-REF-CANDIDATE: cotton|polyester|nylon|wool|linen|hemp|bamboo|tencel|modal|elastane|silk|rayon|acrylic|blended — 14 candidates stripped; promote to reference product]',
    `hs_code` STRING COMMENT 'Harmonized System code for customs classification of the material. Required for international trade and duty calculation.. Valid values are `^[0-9]{6,10}$`',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person who last modified the sustainable material record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the sustainable material record was last updated. Used for change tracking and audit compliance.',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time in days from order placement to delivery. Used for production planning and inventory management.',
    `material_code` STRING COMMENT 'Unique business identifier for the sustainable material used across PLM, sourcing, and production systems. Externally-known code for material catalog reference.. Valid values are `^[A-Z0-9]{8,12}$`',
    `material_description` STRING COMMENT 'Detailed description of the sustainable material including composition, texture, weight, and intended use cases.',
    `material_name` STRING COMMENT 'Human-readable name of the sustainable material (e.g., Organic Cotton Jersey, Recycled Polyester Twill, BCI Cotton Denim).',
    `material_status` STRING COMMENT 'Current lifecycle status of the sustainable material in the catalog. Active materials are approved for use in product development and sourcing.. Valid values are `active|inactive|pending_approval|discontinued|restricted`',
    `material_weight_gsm` DECIMAL(18,2) COMMENT 'Weight of the material in grams per square meter (GSM). Standard textile weight measurement used in product specifications and tech packs.',
    `material_width_cm` DECIMAL(18,2) COMMENT 'Standard width of the material in centimeters. Used for yield calculations and pattern making.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required by suppliers for this sustainable material. Expressed in the material unit of measure.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the sustainable material. Free-text field for supplementary information.',
    `organic_content_percentage` DECIMAL(18,2) COMMENT 'Percentage of organic fiber content in the material (0.00 to 100.00). Null if material is not organic. Required for GOTS certification compliance.',
    `recycled_content_percentage` DECIMAL(18,2) COMMENT 'Percentage of recycled content in the material (0.00 to 100.00). Null if material is not recycled. Critical for circular economy reporting and ESG metrics.',
    `renewable_source_flag` BOOLEAN COMMENT 'Indicates whether the material is derived from renewable sources (plant-based, bio-based). True if renewable, False otherwise.',
    `shrinkage_percentage` DECIMAL(18,2) COMMENT 'Expected shrinkage percentage after washing. Used for pattern grading and quality specifications.',
    `sustainability_attribute` STRING COMMENT 'Primary sustainability characteristic of the material (organic, recycled, bio-based, regenerative agriculture, low-impact dye, bluesign certified, Better Cotton Initiative cotton, fair trade). [ENUM-REF-CANDIDATE: organic|recycled|bio_based|regenerative|low_impact|bluesign|bci_cotton|fair_trade — 8 candidates stripped; promote to reference product]',
    `traceability_tier` STRING COMMENT 'Level of supply chain traceability for the material. Tier 1 (finished goods supplier), Tier 2 (fabric mill), Tier 3 (yarn spinner), Tier 4 (raw material producer), Full Chain (end-to-end traceability).. Valid values are `tier_1|tier_2|tier_3|tier_4|full_chain`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for ordering and inventory management of the material (kilogram, meter, yard, square meter, roll, piece).. Valid values are `kg|meter|yard|square_meter|roll|piece`',
    `water_consumption_liters` DECIMAL(18,2) COMMENT 'Water consumption per kilogram of material during production. Critical metric for water stewardship and environmental impact reporting.',
    CONSTRAINT pk_sustainable_material PRIMARY KEY(`sustainable_material_id`)
) COMMENT 'Master reference catalog of sustainable, recycled, organic, and responsibly sourced materials approved for use in Apparel Fashion products. Captures material name, fiber type, sustainability attribute (organic, recycled, bio-based, bluesign, BCI cotton), certification requirements, minimum recycled content percentage, traceability tier, and preferred supplier linkage. SSOT for sustainable material definitions used in product development and sourcing.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` (
    `material_certification_id` BIGINT COMMENT 'Unique identifier for the material certification record. Primary key.',
    `material_id` BIGINT COMMENT 'Reference to the specific material, fabric, or trim that holds this certification.',
    `production_factory_id` BIGINT COMMENT 'Reference to the specific manufacturing facility or processing site where the certified material was produced or processed.',
    `sustainable_material_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainable_material. Business justification: Material certifications should link to the sustainable material master catalog. A certification applies to a specific sustainable material. Enables tracking certification history and status for materi',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor who provided the certified material and holds the certification.',
    `renewed_material_certification_id` BIGINT COMMENT 'Self-referencing FK on material_certification (renewed_material_certification_id)',
    `audit_date` DATE COMMENT 'The date on which the on-site audit or assessment was conducted by the certifying body to verify compliance with the certification standard.',
    `audit_report_reference` STRING COMMENT 'Reference number or identifier for the audit report document that contains detailed findings and verification results.',
    `certificate_number` STRING COMMENT 'The unique certificate or license number issued by the certifying body for this material certification.',
    `certification_cost_amount` DECIMAL(18,2) COMMENT 'The total cost incurred to obtain and maintain this material certification, including audit fees, testing fees, and annual license fees.',
    `certification_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the certification cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `certification_document_url` STRING COMMENT 'URL or file path to the digital copy of the official certification document or certificate.',
    `certification_level` STRING COMMENT 'The tier or level of certification achieved, if the standard has multiple levels (e.g., GOTS Organic vs GOTS Made with Organic, Cradle to Cradle Bronze/Silver/Gold/Platinum).',
    `certification_scope` STRING COMMENT 'Detailed description of what is covered under this certification, including material type, processing stages, product categories, and any limitations or exclusions.',
    `certification_standard_code` STRING COMMENT 'The sustainability or safety certification standard under which the material is certified. Examples include GOTS (Global Organic Textile Standard), OEKO-TEX STANDARD 100, bluesign, GRS (Global Recycled Standard), BCI (Better Cotton Initiative), FSC (Forest Stewardship Council), C2C (Cradle to Cradle), REACH, RCS (Recycled Claim Standard), OCS (Organic Content Standard), RWS (Responsible Wool Standard), RDS (Responsible Down Standard), LWG (Leather Working Group), ZDHC (Zero Discharge of Hazardous Chemicals). [ENUM-REF-CANDIDATE: GOTS|OEKO-TEX-100|BLUESIGN|GRS|BCI|FSC|C2C|OEKO-TEX-LEATHER|REACH|RCS|OCS|RWS|RDS|LWG|ZDHC|STANDARD-100 — 16 candidates stripped; promote to reference product]',
    `certification_status` STRING COMMENT 'Current lifecycle status of the material certification indicating whether it is active, expired, suspended, revoked, pending renewal, or under review.. Valid values are `active|expired|suspended|revoked|pending_renewal|under_review`',
    `certification_version` STRING COMMENT 'The version number of the certification standard under which this material was certified (e.g., GOTS Version 6.0, OEKO-TEX STANDARD 100 2023 edition).',
    `certified_content_percentage` DECIMAL(18,2) COMMENT 'The percentage of certified material content in the product or material composition (e.g., 95% organic cotton, 50% recycled polyester).',
    `certified_product_category` STRING COMMENT 'The product category or categories for which this material certification is valid (e.g., apparel, home textiles, accessories, footwear).',
    `certifying_body_accreditation_number` STRING COMMENT 'The accreditation number or license identifier of the certifying body, validating their authority to issue the certification.',
    `certifying_body_name` STRING COMMENT 'The name of the independent third-party organization or accredited body that issued the certification (e.g., Control Union, ECOCERT, TÜV, SGS, Intertek).',
    `chain_of_custody_tc_number` STRING COMMENT 'The transaction certificate number that tracks the certified material through the supply chain, ensuring traceability from source to finished product.',
    `compliance_verification_method` STRING COMMENT 'The method used by the certifying body to verify compliance with the certification standard (e.g., on-site audit, document review, laboratory testing, remote assessment, hybrid approach).. Valid values are `on_site_audit|document_review|laboratory_testing|remote_assessment|hybrid`',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this material certification record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this material certification record was first created in the system.',
    `effective_date` DATE COMMENT 'The date from which the certification becomes valid and the material can be marketed as certified.',
    `expiry_date` DATE COMMENT 'The date on which the certification expires and must be renewed or re-certified to maintain valid status.',
    `geographic_scope` STRING COMMENT 'The geographic regions or countries where this certification is recognized and valid for marketing and compliance purposes.',
    `is_multi_site_certification` BOOLEAN COMMENT 'Boolean flag indicating whether this certification covers multiple production sites or facilities under a single certificate.',
    `issue_date` DATE COMMENT 'The date on which the certification was officially issued by the certifying body.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this material certification record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this material certification record was last updated or modified.',
    `material_origin_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the country of origin where the certified material was sourced or produced.. Valid values are `^[A-Z]{3}$`',
    `non_compliance_notes` STRING COMMENT 'Notes documenting any non-compliance issues, corrective actions required, or conditions attached to the certification.',
    `public_verification_url` STRING COMMENT 'URL to the certifying bodys public database or verification portal where the certification can be independently verified by customers or stakeholders.',
    `renewal_date` DATE COMMENT 'The scheduled date by which the certification must be renewed to maintain continuous valid status.',
    `responsible_party_email` STRING COMMENT 'Email address of the responsible party for certification management and renewal coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_party_name` STRING COMMENT 'Name of the individual or department within Apparel Fashion responsible for managing and maintaining this material certification.',
    `test_report_number` STRING COMMENT 'Reference number for laboratory test reports that verify material composition, chemical safety, or other technical requirements of the certification standard.',
    CONSTRAINT pk_material_certification PRIMARY KEY(`material_certification_id`)
) COMMENT 'Transactional record tracking active and historical sustainability certifications held by specific materials, fabrics, or trims used in Apparel Fashion products. Captures certification standard (GOTS, OEKO-TEX STANDARD 100, bluesign, GRS, BCI, FSC, Cradle to Cradle), certifying body, certificate number, issue date, expiry date, certified scope, and chain-of-custody transaction certificate reference. Links sustainable materials to their verified certification status.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` (
    `circular_program_id` BIGINT COMMENT 'Unique identifier for the circular economy program. Primary key.',
    `esg_report_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_report. Business justification: Circular economy programs are key ESG initiatives disclosed in reports. Need linkage for reporting program performance, customer participation, and material diversion rates. N:1 relationship. No bidir',
    `predecessor_circular_program_id` BIGINT COMMENT 'Self-referencing FK on circular_program (predecessor_circular_program_id)',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Annual budget allocated for operating and marketing the circular program. Currency determined by business operating currency.',
    `carbon_reduction_target_kg` DECIMAL(18,2) COMMENT 'Target carbon dioxide equivalent reduction in kilograms expected from this circular program over its lifecycle.',
    `certification_standard` STRING COMMENT 'Environmental or sustainability certification standard that the circular program adheres to (e.g., Cradle to Cradle, Global Recycle Standard, OEKO-TEX).',
    `circular_program_description` STRING COMMENT 'Detailed description of the circular program objectives, mechanics, and value proposition for customers and the business.',
    `collection_method` STRING COMMENT 'Method by which items are collected from customers for the circular program (in-store drop-off, mail-in, home pickup, partner locations, digital trade-in).. Valid values are `in-store_dropoff|mail-in|home_pickup|partner_location|digital_trade-in`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the circular program record was first created in the system.',
    `customer_eligibility_criteria` STRING COMMENT 'Description of customer eligibility requirements for program participation (e.g., loyalty member, original purchaser, any customer).',
    `customer_participation_target` STRING COMMENT 'Target number of unique customers expected to participate in the circular program within the reporting period.',
    `diversion_target_quantity` DECIMAL(18,2) COMMENT 'Target quantity of items or materials to be diverted from landfill through this circular program, measured in units or weight.',
    `diversion_target_unit` STRING COMMENT 'Unit of measure for the diversion target quantity (units, kilograms, tonnes, pounds).. Valid values are `units|kg|tonnes|lbs`',
    `eligible_product_categories` STRING COMMENT 'Comma-separated list of product categories eligible for participation in the circular program (e.g., footwear, outerwear, denim, accessories).',
    `end_date` DATE COMMENT 'Date when the circular program was discontinued or is scheduled to end. Null for ongoing programs.',
    `esg_alignment_goals` STRING COMMENT 'Description of how the circular program aligns with and contributes to the organizations broader ESG commitments and sustainability goals.',
    `geographic_scope` STRING COMMENT 'Geographic regions or countries where the circular program is available, using ISO 3166-1 alpha-3 country codes separated by commas.',
    `incentive_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary incentives (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `incentive_type` STRING COMMENT 'Type of incentive offered to customers for participating in the circular program.. Valid values are `discount_voucher|loyalty_points|store_credit|cash_refund|donation|none`',
    `incentive_value` DECIMAL(18,2) COMMENT 'Monetary value or points value of the incentive offered to customers. Currency context determined by business operating currency.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the circular program is currently active and accepting customer participation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the circular program record was last updated or modified.',
    `launch_date` DATE COMMENT 'Date when the circular program was officially launched and made available to customers.',
    `marketing_campaign_code` STRING COMMENT 'Code linking the circular program to associated marketing campaigns and promotional activities.',
    `material_recovery_rate_target_pct` DECIMAL(18,2) COMMENT 'Target percentage of collected materials that will be successfully recovered and reused or recycled rather than sent to landfill.',
    `minimum_item_condition` STRING COMMENT 'Minimum acceptable condition of items for participation in the circular program.. Valid values are `any|gently_used|good|like_new`',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified the circular program record.',
    `participating_channels` STRING COMMENT 'Comma-separated list of sales and distribution channels where the circular program is available (e.g., retail stores, e-commerce, wholesale, mobile app).',
    `processing_partner` STRING COMMENT 'Name of the third-party partner or internal facility responsible for processing collected items (recycling, refurbishment, resale preparation).',
    `program_code` STRING COMMENT 'Unique business identifier code for the circular program used across systems and external communications.. Valid values are `^[A-Z0-9]{6,12}$`',
    `program_name` STRING COMMENT 'Official marketing and operational name of the circular economy program.',
    `program_owner` STRING COMMENT 'Name or identifier of the business unit, department, or individual responsible for managing the circular program.',
    `program_status` STRING COMMENT 'Current lifecycle status of the circular program indicating operational state.. Valid values are `planning|pilot|active|paused|discontinued`',
    `program_type` STRING COMMENT 'Classification of the circular economy program model: take-back schemes, resale/recommerce, rental programs, repair services, upcycling initiatives, or recycling programs.. Valid values are `take-back|resale|rental|repair|upcycling|recycling`',
    `reporting_frequency` STRING COMMENT 'Frequency at which program performance and environmental impact metrics are reported to stakeholders.. Valid values are `monthly|quarterly|semi-annual|annual`',
    `terms_and_conditions_url` STRING COMMENT 'Web URL where customers can access the full terms and conditions governing participation in the circular program.. Valid values are `^https?://.*$`',
    CONSTRAINT pk_circular_program PRIMARY KEY(`circular_program_id`)
) COMMENT 'Master record defining Apparel Fashions circular economy programs including take-back schemes, garment recycling initiatives, resale/recommerce programs, rental programs, and repair services. Captures program name, program type (take-back, resale, rental, repair, upcycling), launch date, participating channels, eligible product categories, incentive structure (discount voucher, loyalty points), and circular diversion targets.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` (
    `circular_enrollment_id` BIGINT COMMENT 'Unique identifier for the circular economy program enrollment event. Primary key for the circular enrollment transaction.',
    `circular_program_id` BIGINT COMMENT 'Foreign key linking to sustainability.circular_program. Business justification: Each circular enrollment event is FOR a specific circular program (take-back, garment repair, resale). This is a standard N:1 child-to-parent relationship. The circular_enrollment table currently has ',
    `production_factory_id` BIGINT COMMENT 'Reference to the warehouse, distribution center, or processing facility where the submitted items were received and sorted for diversion outcome.',
    `profile_id` BIGINT COMMENT 'Reference to the retail customer who enrolled in the circular program. Null if enrollment is by a wholesale account or partner organization.',
    `retail_store_id` BIGINT COMMENT 'Reference to the retail store location where the enrollment occurred. Populated only when enrollment_channel is in-store.',
    `wholesale_account_id` BIGINT COMMENT 'Reference to the wholesale partner or B2B account that enrolled in the circular program. Null if enrollment is by a retail customer.',
    `renewed_circular_enrollment_id` BIGINT COMMENT 'Self-referencing FK on circular_enrollment (renewed_circular_enrollment_id)',
    `carbon_offset_kg` DECIMAL(18,2) COMMENT 'Estimated carbon dioxide equivalent (CO2e) offset in kilograms achieved through this circular enrollment, calculated based on diversion outcome and material type. Used for ESG carbon footprint reporting.',
    `certification_reference` STRING COMMENT 'Reference number or identifier for any sustainability certification or third-party verification associated with this enrollment (e.g., GOTS certificate, BCI tracking number). Free-text field for traceability.',
    `collection_method` STRING COMMENT 'Method by which items were collected from the participant: drop-off (customer brought to store), mail-in (shipped by customer), pickup (courier collected), event (collected at activation), partner-site (collected at third-party location).. Valid values are `drop-off|mail-in|pickup|event|partner-site`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was first created in the system. Used for audit trail and data lineage.',
    `customer_consent_flag` BOOLEAN COMMENT 'Indicates whether the customer provided explicit consent for their enrollment data to be used in sustainability reporting and marketing communications. True if consent given, False otherwise.',
    `diversion_outcome` STRING COMMENT 'Final disposition outcome of the submitted items: recycled (material recovery), resold (second-hand sale), repaired (restored for reuse), upcycled (creatively transformed), donated (charitable distribution), disposed (landfill or incineration as last resort).. Valid values are `recycled|resold|repaired|upcycled|donated|disposed`',
    `enrollment_channel` STRING COMMENT 'Channel through which the enrollment was initiated: in-store (retail location), online (e-commerce site), mobile-app (branded app), call-center (customer service), partner-location (third-party drop-off), event (pop-up or activation).. Valid values are `in-store|online|mobile-app|call-center|partner-location|event`',
    `enrollment_number` STRING COMMENT 'Business-facing unique enrollment reference number assigned to the circular program participation event. Format: CE-XXXXXXXXXX.. Valid values are `^CE-[0-9]{10}$`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the circular enrollment: pending (awaiting confirmation), confirmed (accepted into program), completed (items processed and outcome recorded), cancelled (customer withdrew), rejected (did not meet program criteria).. Valid values are `pending|confirmed|completed|cancelled|rejected`',
    `enrollment_timestamp` TIMESTAMP COMMENT 'Date and time when the customer or partner enrolled in the circular economy program. Represents the principal business event time for this transaction.',
    `esg_reporting_period` STRING COMMENT 'Reporting period (quarter or month) to which this enrollment is attributed for ESG and sustainability reporting. Format: YYYY-QN for quarterly or YYYY-MM for monthly.. Valid values are `^[0-9]{4}-Q[1-4]$|^[0-9]{4}-[0-9]{2}$`',
    `incentive_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the incentive value (e.g., USD, EUR, GBP). Null if incentive is non-monetary (e.g., loyalty points) or none.. Valid values are `^[A-Z]{3}$`',
    `incentive_expiry_date` DATE COMMENT 'Date when the issued incentive expires and can no longer be redeemed. Null if incentive has no expiration or was not issued.',
    `incentive_issued_date` DATE COMMENT 'Date when the incentive (voucher, credit, points) was issued to the customer or partner. Null if no incentive was issued.',
    `incentive_type` STRING COMMENT 'Type of incentive issued to the customer or partner for participating in the circular program: discount-voucher (percentage or fixed discount), loyalty-points (added to loyalty account), store-credit (monetary credit), donation (charitable contribution on behalf of participant), none (no incentive).. Valid values are `discount-voucher|loyalty-points|store-credit|donation|none`',
    `incentive_value` DECIMAL(18,2) COMMENT 'Monetary value or points value of the incentive issued. Currency is implied by the business operating currency (USD). Null if incentive_type is none.',
    `items_submitted_count` STRING COMMENT 'Total number of garments or products submitted by the customer or partner as part of this enrollment event.',
    `material_composition` STRING COMMENT 'Aggregated or predominant material composition of submitted items (e.g., cotton, polyester, blended). Free-text field capturing material type for circular economy material flow analysis.',
    `notes` STRING COMMENT 'Free-text notes or comments recorded by staff or system regarding the enrollment event, item condition, special handling, or other relevant observations.',
    `partner_organization_name` STRING COMMENT 'Name of the third-party partner organization facilitating the circular program (e.g., recycling vendor, resale platform, charity partner). Null if managed internally.',
    `processing_completed_date` DATE COMMENT 'Date when the processing of submitted items was completed and the diversion outcome was finalized. Null if processing is still pending.',
    `source_system` STRING COMMENT 'Name of the operational system or application that originated this enrollment record (e.g., Salesforce Commerce Cloud, SAP Customer Activity Repository, partner API).',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total weight in kilograms of all items submitted in this enrollment. Used for material recovery volume tracking and ESG reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_circular_enrollment PRIMARY KEY(`circular_enrollment_id`)
) COMMENT 'Transactional record capturing each customer or wholesale partner enrollment event in a circular economy program such as garment take-back, resale, or repair. Captures enrollment date, program, customer or account reference, channel (in-store, online), items submitted or enrolled, incentive issued, and diversion outcome (recycled, resold, repaired, upcycled). Tracks circular economy participation and material recovery volumes.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` (
    `environmental_impact_id` BIGINT COMMENT 'Unique identifier for the environmental impact assessment record. Primary key for lifecycle environmental impact assessments conducted for styles, materials, or supply chain nodes.',
    `material_id` BIGINT COMMENT 'Reference to the specific material or fabric for which this environmental impact assessment was conducted. Links assessment to material master data in PLM material libraries.',
    `print_design_id` BIGINT COMMENT 'Foreign key linking to design.print_design. Business justification: Print designs have specific environmental impacts (water consumption, chemical usage) that are assessed separately. Real process: print sustainability scoring for ZDHC compliance and water stewardship',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: LCA assessments are conducted on design sketches during gate reviews to evaluate carbon/water footprint before production commitment. Real process: sustainability teams score sketches using Higg MSI o',
    `style_id` BIGINT COMMENT 'Reference to the apparel style for which this environmental impact assessment was conducted. Links assessment to specific product design in the Product Lifecycle Management (PLM) system.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or manufacturing facility for which this environmental impact assessment was conducted. Links assessment to supply chain node for facility-level impact tracking.',
    `revised_environmental_impact_id` BIGINT COMMENT 'Self-referencing FK on environmental_impact (revised_environmental_impact_id)',
    `acidification_potential_kg_so2e` DECIMAL(18,2) COMMENT 'Measure of acid rain and soil acidification potential, expressed as kilograms of sulfur dioxide equivalent per functional unit. Results from sulfur oxides, nitrogen oxides, and ammonia emissions from energy generation and chemical processing.',
    `assessment_date` DATE COMMENT 'Date when the environmental impact assessment was completed and results finalized. Used for temporal tracking and regulatory reporting timelines.',
    `assessment_number` STRING COMMENT 'Business identifier for the environmental impact assessment, formatted as LCA- followed by 8 digits. Used for external reporting and cross-system reference.. Valid values are `^LCA-[0-9]{8}$`',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the environmental impact assessment. Draft indicates initial data collection; in-progress indicates active modeling; peer-review indicates validation phase; completed indicates finalized results; published indicates externally disclosed; archived indicates superseded by newer assessment.. Valid values are `draft|in_progress|peer_review|completed|published|archived`',
    `assessment_type` STRING COMMENT 'Scope and boundary of the environmental impact assessment. Cradle-to-gate covers raw material extraction through factory gate; cradle-to-grave includes end-of-life; gate-to-gate covers a single process; cradle-to-cradle includes recycling loop; hotspot identifies key impact areas; comparative benchmarks multiple options.. Valid values are `cradle_to_gate|cradle_to_grave|gate_to_gate|cradle_to_cradle|hotspot_analysis|comparative`',
    `assessor_name` STRING COMMENT 'Name of the individual or organization that conducted the environmental impact assessment. Used for accountability, peer review, and third-party verification processes.',
    `assessor_organization` STRING COMMENT 'Name of the consulting firm, certification body, or internal department that performed the assessment. Used for credibility evaluation and third-party verification tracking.',
    `certification_level` STRING COMMENT 'Achievement tier or grade within the certification standard, if applicable. Examples: Cradle to Cradle Bronze/Silver/Gold/Platinum, Higg Index score bands. Not applicable if no tiered certification exists. [ENUM-REF-CANDIDATE: bronze|silver|gold|platinum|basic|advanced|not_certified — 7 candidates stripped; promote to reference product]',
    `certification_standard` STRING COMMENT 'Name of the third-party environmental certification or standard against which this assessment was validated. Examples: OEKO-TEX Standard 100, Global Organic Textile Standard (GOTS), Cradle to Cradle Certified, bluesign. [ENUM-REF-CANDIDATE: oeko_tex_100|gots|cradle_to_cradle|bluesign|better_cotton|higg_verified|carbon_neutral|eu_ecolabel|nordic_swan — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this environmental impact assessment record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Composite score (0.00 to 5.00) assessing the reliability, completeness, temporal relevance, and geographic representativeness of the LCA data sources. Higher scores indicate higher quality per ISO 14044 data quality requirements. Used for uncertainty analysis.',
    `disclosure_date` DATE COMMENT 'Date when this environmental impact assessment was first publicly disclosed. Null if not yet disclosed. Used for transparency tracking and regulatory reporting timelines.',
    `ecotoxicity_potential_kg_1_4_dbe` DECIMAL(18,2) COMMENT 'Measure of potential ecosystem harm from toxic chemical discharge, expressed as kilograms of 1,4-dichlorobenzene equivalent per functional unit. Covers aquatic toxicity, terrestrial toxicity, and sediment toxicity from chemical effluents.',
    `energy_consumption_mj` DECIMAL(18,2) COMMENT 'Total primary energy consumed per functional unit, measured in megajoules. Includes fossil fuels, electricity, and renewable energy sources. Used for energy efficiency benchmarking and renewable energy transition planning.',
    `eutrophication_potential_kg_po4e` DECIMAL(18,2) COMMENT 'Measure of nutrient enrichment potential in aquatic and terrestrial ecosystems, expressed as kilograms of phosphate equivalent per functional unit. Caused by nitrogen and phosphorus discharge from dyeing, finishing, and agricultural runoff.',
    `functional_unit` STRING COMMENT 'The reference unit to which all environmental impact results are normalized. Examples: one garment, one kilogram of fabric, one production batch. Enables comparability across assessments per ISO 14040 requirements.',
    `functional_unit_quantity` DECIMAL(18,2) COMMENT 'Numeric quantity of the functional unit for this assessment. Used to scale impact results to different production volumes or product quantities.',
    `global_warming_potential_kg_co2e` DECIMAL(18,2) COMMENT 'Total greenhouse gas emissions expressed as kilograms of carbon dioxide equivalent per functional unit. Aggregates CO2, methane, nitrous oxide, and other GHGs using IPCC conversion factors. Primary metric for carbon footprint reporting.',
    `hazardous_waste_kg` DECIMAL(18,2) COMMENT 'Total hazardous waste generated per functional unit, measured in kilograms. Includes chemical sludge, contaminated materials, and regulated waste streams requiring special handling per EPA or local regulations.',
    `human_toxicity_potential_kg_1_4_dbe` DECIMAL(18,2) COMMENT 'Measure of potential human health impact from toxic chemical exposure, expressed as kilograms of 1,4-dichlorobenzene equivalent per functional unit. Aggregates carcinogens, respiratory irritants, and endocrine disruptors from dyes, finishes, and processing chemicals.',
    `land_use_square_meters` DECIMAL(18,2) COMMENT 'Total land area occupied or transformed per functional unit, measured in square meters. Includes agricultural land for natural fibers, facility footprint, and mining/extraction areas. Relevant for biodiversity impact assessment.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this environmental impact assessment record was most recently modified. Tracks data currency for reporting and compliance purposes.',
    `methodology` STRING COMMENT 'The standardized methodology or software tool used to conduct the environmental impact assessment. ISO 14040/14044 is the international standard; Higg MSI is apparel-industry specific; PEF is EU Product Environmental Footprint; GaBi, SimaPro, and Ecoinvent are LCA databases and tools. [ENUM-REF-CANDIDATE: iso_14040_14044|higg_msi|pef|gabi|simapro|ecoinvent|custom — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text field for additional context, assumptions, limitations, or special considerations related to this environmental impact assessment. Used for documentation of non-standard scenarios or data quality caveats.',
    `ozone_depletion_potential_kg_cfc11e` DECIMAL(18,2) COMMENT 'Measure of stratospheric ozone layer depletion potential, expressed as kilograms of CFC-11 equivalent per functional unit. Relevant for refrigerants, solvents, and legacy chemical processes.',
    `peer_review_completed` BOOLEAN COMMENT 'Boolean flag indicating whether this environmental impact assessment has undergone independent peer review by qualified LCA practitioners per ISO 14044 critical review requirements. True indicates peer-reviewed; false indicates not reviewed.',
    `peer_review_date` DATE COMMENT 'Date when the independent peer review of this environmental impact assessment was completed. Null if peer review has not been conducted. Used for quality assurance tracking and regulatory compliance.',
    `photochemical_ozone_creation_potential_kg_c2h4e` DECIMAL(18,2) COMMENT 'Measure of ground-level smog formation potential, expressed as kilograms of ethylene equivalent per functional unit. Results from volatile organic compounds and nitrogen oxides reacting in sunlight. Relevant for solvent-based processes.',
    `public_disclosure_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this environmental impact assessment has been publicly disclosed in sustainability reports, product labels, or regulatory filings. True indicates publicly available; false indicates internal use only.',
    `recycled_content_percentage` DECIMAL(18,2) COMMENT 'Percentage of the product or material composed of pre-consumer or post-consumer recycled content. Used for circular economy reporting and sustainable material sourcing claims per Federal Trade Commission (FTC) Green Guides.',
    `renewable_content_percentage` DECIMAL(18,2) COMMENT 'Percentage of the product or material derived from renewable biological resources (organic cotton, Tencel, bio-based polyester). Used for bio-based content claims and sustainable sourcing metrics.',
    `reporting_year` STRING COMMENT 'Calendar year or fiscal year for which this environmental impact assessment is reported. Used for year-over-year trend analysis and annual sustainability reporting aggregation.',
    `system_boundary_description` STRING COMMENT 'Detailed textual description of the processes, stages, and geographic boundaries included in this environmental impact assessment. Defines what is in-scope and out-of-scope per ISO 14044 requirements.',
    `uncertainty_percentage` DECIMAL(18,2) COMMENT 'Estimated percentage uncertainty or confidence interval around the primary impact results. Reflects data gaps, modeling assumptions, and variability in supply chain processes. Used for sensitivity analysis and risk-adjusted decision making.',
    `waste_generated_kg` DECIMAL(18,2) COMMENT 'Total solid waste generated per functional unit, measured in kilograms. Includes fabric cutting waste, packaging waste, and end-of-life disposal. Used for circular economy metrics and waste diversion rate calculation.',
    `water_consumption_liters` DECIMAL(18,2) COMMENT 'Total freshwater consumed (withdrawn and not returned to source) per functional unit, measured in liters. Includes process water, cooling water, and embedded water in materials. Critical metric for water-scarce regions.',
    `water_pollution_index` DECIMAL(18,2) COMMENT 'Composite index measuring water quality degradation from chemical discharge, thermal pollution, and suspended solids. Normalized score per functional unit. Higher values indicate greater aquatic ecosystem impact.',
    CONSTRAINT pk_environmental_impact PRIMARY KEY(`environmental_impact_id`)
) COMMENT 'Transactional record of lifecycle environmental impact assessments (LCA) conducted for Apparel Fashion styles, materials, or supply chain nodes. Captures assessment scope (cradle-to-gate, cradle-to-grave, hotspot), impact categories (global warming potential, water consumption, land use, eutrophication, chemical toxicity), functional unit, methodology (ISO 14040/14044, Higg MSI), and impact values per unit. Enables product-level environmental footprint benchmarking.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` (
    `water_usage_id` BIGINT COMMENT 'Unique identifier for the water usage transaction record.',
    `facility_id` BIGINT COMMENT 'Identifier of the facility, factory, warehouse, or supply chain node where water usage occurred.',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or manufacturing partner reporting water usage, if applicable.',
    `corrected_water_usage_id` BIGINT COMMENT 'Self-referencing FK on water_usage (corrected_water_usage_id)',
    `audit_date` DATE COMMENT 'Date when the third-party audit or verification of water usage data was conducted.',
    `compliance_status` STRING COMMENT 'Compliance status of the water usage and discharge against regulatory limits and internal commitments: compliant, non-compliant, under review, or exempted.. Valid values are `compliant|non_compliant|under_review|exempted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the water usage record was first created in the system.',
    `data_collection_method` STRING COMMENT 'Method used to collect water usage data: automated meter reading, manual meter reading, estimation, or supplier-reported data.. Valid values are `automated_meter|manual_meter|estimated|supplier_reported`',
    `data_verification_status` STRING COMMENT 'Verification status of the water usage data: verified internally, unverified, third-party audited, or pending verification.. Valid values are `verified|unverified|third_party_audited|pending`',
    `discharge_destination_type` STRING COMMENT 'Destination to which wastewater is discharged: municipal sewer system, surface water body, groundwater, third-party treatment facility, or on-site treatment.. Valid values are `municipal_sewer|surface_water|groundwater|third_party|on_site`',
    `facility_type` STRING COMMENT 'Type of facility reporting water usage: manufacturing plant, warehouse, distribution center, retail store, office, or dyeing/finishing facility.. Valid values are `manufacturing|warehouse|distribution_center|retail_store|office|dyeing_facility`',
    `geographic_region` STRING COMMENT 'Geographic region or country where the facility reporting water usage is located, using 3-letter ISO country codes (e.g., USA, CHN, IND).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the water usage record was last modified or updated.',
    `measurement_timestamp` TIMESTAMP COMMENT 'Precise date and time when the water usage measurement was recorded or meter reading was taken.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the water usage record, including explanations for anomalies or special circumstances.',
    `permit_expiration_date` DATE COMMENT 'Expiration date of the regulatory permit for water usage and discharge.',
    `production_volume_units` DECIMAL(18,2) COMMENT 'Total production volume at the facility during the reporting period, measured in units relevant to the facility type (e.g., garments produced, square meters of fabric processed).',
    `regulatory_permit_number` STRING COMMENT 'Government-issued permit or license number authorizing water withdrawal and wastewater discharge at the facility.',
    `reporting_period_end_date` DATE COMMENT 'End date of the reporting period for which water usage is measured.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the reporting period for which water usage is measured.',
    `third_party_auditor_name` STRING COMMENT 'Name of the third-party auditor or verification body that validated the water usage data, if applicable.',
    `total_water_intake_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of water withdrawn or consumed during the reporting period, measured in cubic meters.',
    `wastewater_discharged_volume_m3` DECIMAL(18,2) COMMENT 'Volume of wastewater discharged from the facility during the reporting period, measured in cubic meters.',
    `wastewater_treatment_method` STRING COMMENT 'Method used to treat wastewater before discharge: primary, secondary, tertiary, biological, chemical, Zero Liquid Discharge (ZLD), or none. [ENUM-REF-CANDIDATE: primary|secondary|tertiary|biological|chemical|zld|none — 7 candidates stripped; promote to reference product]',
    `water_consumption_per_unit_produced` DECIMAL(18,2) COMMENT 'Water intensity metric representing cubic meters of water consumed per unit of product manufactured during the reporting period.',
    `water_quality_bod_mg_per_l` DECIMAL(18,2) COMMENT 'Biochemical Oxygen Demand (BOD) level of discharged wastewater, measured in milligrams per liter, indicating organic pollution level.',
    `water_quality_cod_mg_per_l` DECIMAL(18,2) COMMENT 'Chemical Oxygen Demand (COD) level of discharged wastewater, measured in milligrams per liter, indicating chemical pollution level.',
    `water_quality_ph_level` DECIMAL(18,2) COMMENT 'pH level of discharged wastewater, indicating acidity or alkalinity on a scale of 0 to 14.',
    `water_quality_tss_mg_per_l` DECIMAL(18,2) COMMENT 'Total Suspended Solids (TSS) concentration in discharged wastewater, measured in milligrams per liter.',
    `water_recycled_volume_m3` DECIMAL(18,2) COMMENT 'Volume of water recycled or reused within the facility during the reporting period, measured in cubic meters.',
    `water_reduction_achieved_m3` DECIMAL(18,2) COMMENT 'Actual volume of water reduction achieved by the facility during the reporting period, measured in cubic meters.',
    `water_reduction_target_m3` DECIMAL(18,2) COMMENT 'Target volume of water reduction committed by the facility for the reporting period, measured in cubic meters.',
    `water_source_type` STRING COMMENT 'Type of water source from which water was withdrawn: municipal supply, groundwater well, rainwater harvesting, surface water, recycled water, or desalinated water.. Valid values are `municipal|groundwater|rainwater|surface_water|recycled|desalinated`',
    `water_stewardship_certification` STRING COMMENT 'Name of the water stewardship certification or standard achieved by the facility, if applicable (e.g., AWS Platinum, AWS Gold).',
    `water_stewardship_program_enrolled` BOOLEAN COMMENT 'Indicates whether the facility is enrolled in a recognized water stewardship or conservation program (e.g., Alliance for Water Stewardship, CEO Water Mandate).',
    `water_stress_basin_classification` STRING COMMENT 'Water stress level of the basin where the facility is located, based on WRI Aqueduct classification: low, low-to-medium, medium-to-high, high, or extremely high.. Valid values are `low|low_to_medium|medium_to_high|high|extremely_high`',
    `zld_commitment_status` STRING COMMENT 'Status of the facilitys commitment to Zero Liquid Discharge: committed, in progress, achieved, or not applicable.. Valid values are `committed|in_progress|achieved|not_applicable`',
    CONSTRAINT pk_water_usage PRIMARY KEY(`water_usage_id`)
) COMMENT 'Transactional record capturing water consumption and wastewater discharge events at Apparel Fashion facilities, factories, and supply chain nodes. Captures location, reporting period, water source type (municipal, groundwater, rainwater), total water intake volume, water recycled volume, wastewater discharged volume, water stress basin classification (WRI Aqueduct), and compliance with Zero Liquid Discharge (ZLD) commitments. Supports water stewardship reporting.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` (
    `energy_consumption_id` BIGINT COMMENT 'Unique identifier for the energy consumption transaction record. Primary key for the energy consumption data product.',
    `facility_id` BIGINT COMMENT 'Identifier of the facility where energy was consumed (retail store, distribution center, corporate office, or manufacturing plant).',
    `renewable_energy_certificate_id` BIGINT COMMENT 'The identifier of the Renewable Energy Certificate or Guarantee of Origin associated with renewable energy consumption. Used for RE100 compliance and renewable energy claims substantiation.',
    `corrected_energy_consumption_id` BIGINT COMMENT 'Self-referencing FK on energy_consumption (corrected_energy_consumption_id)',
    `consumption_date` DATE COMMENT 'The date on which the energy consumption occurred or was recorded. Primary business event timestamp for the energy consumption transaction.',
    `consumption_quantity` DECIMAL(18,2) COMMENT 'The quantity of energy consumed during the reporting period. Measured in the unit specified in the unit_of_measure field.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the facility location. Used for country-level energy and emissions reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this energy consumption record was first created in the system. Used for data lineage and audit trail purposes.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the energy cost (e.g., USD, EUR, GBP). Enables multi-currency energy cost tracking across global operations.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Assessment of the quality and reliability of the energy consumption data (high for actual meter readings, medium for utility bills, low for estimates). Used for ESG reporting assurance and data governance.. Valid values are `high|medium|low`',
    `data_source` STRING COMMENT 'The source system or process from which the energy consumption data was captured (e.g., building management system, utility invoice, manual entry, IoT sensor). Provides data lineage for audit and quality purposes.',
    `emission_factor` DECIMAL(18,2) COMMENT 'The emission factor used to convert energy consumption to CO2 equivalent emissions (kg CO2e per unit of energy). Varies by energy source and geographic location.',
    `emission_factor_source` STRING COMMENT 'The authoritative source of the emission factor used in GHG calculations (e.g., EPA eGRID, IEA, DEFRA, local utility provider). Ensures traceability and auditability of emissions calculations.',
    `energy_cost` DECIMAL(18,2) COMMENT 'The total cost of the energy consumed during the reporting period in the currency specified. Used for energy cost analysis and budgeting.',
    `energy_intensity_metric` DECIMAL(18,2) COMMENT 'Energy intensity calculated as energy consumption per unit of activity (e.g., kWh per square foot for retail stores, kWh per unit produced for manufacturing facilities). Enables benchmarking and efficiency tracking.',
    `energy_source` STRING COMMENT 'The type of energy source consumed. Distinguishes between fossil fuels, grid electricity, and renewable sources for Scope 1 and Scope 2 GHG emissions calculations.. Valid values are `grid_electricity|natural_gas|renewable_energy|solar|diesel|fuel_oil`',
    `facility_type` STRING COMMENT 'The type of facility where the energy was consumed. Enables segmentation of energy consumption and intensity metrics by facility category.. Valid values are `retail_store|distribution_center|corporate_office|manufacturing_plant`',
    `geographic_region` STRING COMMENT 'The geographic region or market where the facility is located. Used for regional energy performance analysis and regulatory reporting by jurisdiction.',
    `intensity_denominator` STRING COMMENT 'The denominator used to calculate the energy intensity metric (e.g., square feet for retail stores, units produced for manufacturing, revenue for corporate offices).. Valid values are `square_feet|square_meters|units_produced|revenue_usd|employee_count`',
    `invoice_number` STRING COMMENT 'The invoice number from the utility provider associated with this energy consumption record. Links energy data to financial accounts payable records.',
    `meter_code` STRING COMMENT 'The identifier of the physical or virtual meter that recorded the energy consumption. Links consumption data to specific metering infrastructure.',
    `meter_reading_type` STRING COMMENT 'Indicates whether the consumption quantity is based on an actual meter reading, an estimated value, or a billed amount from the utility provider.. Valid values are `actual|estimated|billed`',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this energy consumption record was last modified. Used for data lineage, audit trail, and change tracking purposes.',
    `notes` STRING COMMENT 'Free-text field for additional context, anomalies, or explanations related to the energy consumption record (e.g., facility closure, equipment malfunction, seasonal variation).',
    `renewable_energy_percentage` DECIMAL(18,2) COMMENT 'The percentage of the total energy consumption that came from renewable sources. Used for RE100 renewable energy commitment tracking and reporting.',
    `reporting_period` STRING COMMENT 'The reporting period for the energy consumption record (e.g., 2024-Q1, 2024-M03, 2024-W12). Used for aggregation and ESG reporting alignment.. Valid values are `^[0-9]{4}-(Q[1-4]|M(0[1-9]|1[0-2])|W(0[1-9]|[1-4][0-9]|5[0-3]))$`',
    `scope_1_emissions_kg_co2e` DECIMAL(18,2) COMMENT 'Calculated Scope 1 greenhouse gas emissions in kilograms of carbon dioxide equivalent resulting from direct energy consumption (natural gas, diesel, fuel oil). Derived using emission factors from the energy source.',
    `scope_2_emissions_kg_co2e` DECIMAL(18,2) COMMENT 'Calculated Scope 2 greenhouse gas emissions in kilograms of carbon dioxide equivalent resulting from purchased electricity consumption. Derived using grid emission factors for the facility location.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the energy consumption quantity (kilowatt-hours, megawatt-hours, gigajoules, megajoules, therms, or million British thermal units).. Valid values are `kWh|MWh|GJ|MJ|therms|MMBtu`',
    `utility_account_number` STRING COMMENT 'The account number assigned by the utility provider for billing purposes. Confidential business information used for invoice reconciliation.',
    `utility_provider` STRING COMMENT 'The name of the utility company or energy provider that supplied the energy. Used for invoice reconciliation and supplier engagement tracking.',
    `verification_date` DATE COMMENT 'The date on which the energy consumption data was verified by an auditor. Used for ESG reporting assurance and compliance tracking.',
    `verification_status` STRING COMMENT 'Indicates whether the energy consumption data has been verified by an internal or external auditor for ESG reporting purposes.. Valid values are `verified|unverified|pending_verification`',
    CONSTRAINT pk_energy_consumption PRIMARY KEY(`energy_consumption_id`)
) COMMENT 'Transactional record of energy consumption events at Apparel Fashion retail stores, DCs, corporate offices, and owned manufacturing facilities. Captures energy source (grid electricity, natural gas, renewable energy, solar, diesel), consumption quantity (kWh, GJ), renewable energy percentage, energy intensity metric (kWh per sqft, kWh per unit produced), and reporting period. Feeds Scope 1 and Scope 2 GHG calculations and RE100 renewable energy commitments.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` (
    `waste_record_id` BIGINT COMMENT 'Unique identifier for the waste record transaction. Primary key for waste generation, diversion, and disposal events.',
    `production_factory_id` BIGINT COMMENT 'Reference to the facility, warehouse, store, or supply chain node where the waste was generated.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or manufacturing partner facility if waste originated from supply chain operations.',
    `initiative_id` BIGINT COMMENT 'Reference to a specific waste reduction or circular economy initiative that this waste record is associated with for program effectiveness tracking.',
    `corrected_waste_record_id` BIGINT COMMENT 'Self-referencing FK on waste_record (corrected_waste_record_id)',
    `carbon_footprint_kg_co2e` DECIMAL(18,2) COMMENT 'Estimated carbon emissions in kg CO2e associated with the waste disposal method. Used for Scope 3 emissions reporting and environmental impact assessments.',
    `certification_standard` STRING COMMENT 'Environmental certification or standard applicable to the waste handling process (e.g., ISO 14001, Zero Waste certification, Cradle to Cradle).',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for waste collection, transportation, and disposal for this transaction. Used for waste cost analysis and circular economy ROI calculations.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the waste disposal cost amount.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this waste record was first created in the system. Part of standard audit trail for data governance.',
    `data_source_system` STRING COMMENT 'Source operational system that captured this waste record (e.g., SAP EHS, WMS, facility management system, third-party waste tracking platform).',
    `disposal_facility_location` STRING COMMENT 'Geographic location (city, state, country) of the disposal or recovery facility for supply chain transparency and carbon footprint analysis.',
    `disposal_facility_name` STRING COMMENT 'Name of the final disposal, recycling, or recovery facility where the waste was processed.',
    `disposal_method` STRING COMMENT 'Method used to dispose of or divert the waste material. Critical for calculating diversion rates and Zero Waste to Landfill compliance. [ENUM-REF-CANDIDATE: landfill|incineration|recycling|composting|reuse|donation|energy_recovery — 7 candidates stripped; promote to reference product]',
    `disposal_timestamp` TIMESTAMP COMMENT 'Date and time when the waste was finally disposed of or diverted through the specified disposal method.',
    `diversion_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of waste diverted from landfill through recycling, composting, reuse, or energy recovery. Key metric for Zero Waste to Landfill (ZWTL) programs.',
    `hazardous_waste_manifest_number` STRING COMMENT 'Regulatory manifest or tracking number for hazardous waste shipments, required for compliance with environmental regulations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this waste record was last updated. Supports change tracking and data quality monitoring.',
    `material_composition` STRING COMMENT 'Primary material composition of the waste (e.g., cotton, polyester, leather, mixed fiber, plastic, cardboard) for material-specific diversion tracking.',
    `notes` STRING COMMENT 'Free-text notes providing additional context about the waste transaction, special handling requirements, or unusual circumstances.',
    `product_category` STRING COMMENT 'Product category associated with the waste generation (e.g., apparel, footwear, accessories) for waste intensity analysis by product line.',
    `record_status` STRING COMMENT 'Current lifecycle status of the waste record in the data management workflow, indicating validation and approval state.. Valid values are `draft|submitted|verified|approved|rejected|archived`',
    `reporting_period` STRING COMMENT 'Fiscal reporting period (year-quarter or year-month format) for aggregating waste data in sustainability reports and GRI disclosures.. Valid values are `^[0-9]{4}-(Q[1-4]|M(0[1-9]|1[0-2]))$`',
    `revenue_from_recycling` DECIMAL(18,2) COMMENT 'Revenue generated from selling recyclable waste materials (e.g., fabric scraps, metal, cardboard) to recycling partners. Supports circular economy business case.',
    `verification_timestamp` TIMESTAMP COMMENT 'Date and time when the waste record was verified for accuracy and compliance, supporting audit trail requirements.',
    `verified_by` STRING COMMENT 'Name or identifier of the person or system that verified the accuracy of the waste record data for compliance reporting.',
    `volume_cubic_meters` DECIMAL(18,2) COMMENT 'Volume of waste material in cubic meters, used for bulky or low-density waste where volume is a key operational metric.',
    `waste_collection_timestamp` TIMESTAMP COMMENT 'Precise date and time when the waste was collected for disposal or diversion. Critical for operational tracking and compliance documentation.',
    `waste_generation_date` DATE COMMENT 'Date when the waste was generated at the facility or supply chain node. Used for temporal analysis and reporting period aggregation.',
    `waste_handler_license_number` STRING COMMENT 'Regulatory license or permit number of the waste handler, required for hazardous waste tracking and compliance.',
    `waste_handler_name` STRING COMMENT 'Name of the third-party waste management company or handler responsible for collection and disposal.',
    `waste_source_process` STRING COMMENT 'Business process or operational activity that generated the waste (e.g., cutting room operations, packaging line, quality control rejection, store operations).',
    `waste_stream_classification` STRING COMMENT 'Regulatory classification of the waste stream indicating handling requirements and environmental risk level.. Valid values are `hazardous|non_hazardous|recyclable|compostable|special_handling`',
    `waste_transaction_number` STRING COMMENT 'Business-readable unique identifier for the waste transaction event, used for tracking and audit purposes.. Valid values are `^WR-[0-9]{8}-[A-Z0-9]{6}$`',
    `waste_type` STRING COMMENT 'Classification of the waste material generated. Includes fabric offcuts, packaging, chemical waste, e-waste, and general waste categories. [ENUM-REF-CANDIDATE: fabric_offcuts|packaging_material|chemical_waste|electronic_waste|general_waste|textile_waste|plastic_waste|cardboard|metal_scrap|organic_waste — 10 candidates stripped; promote to reference product]',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of waste material in kilograms for this transaction. Primary measurement for waste intensity calculations and GRI 306 reporting.',
    `zwtl_compliant_flag` BOOLEAN COMMENT 'Indicates whether this waste transaction meets Zero Waste to Landfill compliance criteria (typically 90%+ diversion rate).',
    CONSTRAINT pk_waste_record PRIMARY KEY(`waste_record_id`)
) COMMENT 'Transactional record of waste generation, diversion, and disposal events at Apparel Fashion facilities and supply chain nodes. Captures waste type (fabric offcuts, packaging, chemical waste, e-waste, general waste), waste stream classification (hazardous, non-hazardous), disposal method (landfill, incineration, recycling, composting, reuse), weight in kg, diversion rate, and Zero Waste to Landfill (ZWTL) compliance status. Supports GRI 306 waste reporting.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` (
    `supplier_esg_assessment_id` BIGINT COMMENT 'Unique identifier for the supplier ESG assessment record.',
    `esg_report_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_report. Business justification: Supplier ESG assessment results are aggregated and disclosed in corporate ESG reports. Need linkage for reporting supplier sustainability performance and risk management. N:1 relationship. No bidirect',
    `facility_id` BIGINT COMMENT 'Foreign key linking to sustainability.facility. Business justification: ESG assessments are conducted at specific facilities. facility_name and facility_location are text fields that should be normalized to facility FK for data consistency and to enable linking assessment',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or factory being assessed for ESG performance.',
    `prior_supplier_esg_assessment_id` BIGINT COMMENT 'Self-referencing FK on supplier_esg_assessment (prior_supplier_esg_assessment_id)',
    `areas_for_improvement` STRING COMMENT 'Description of areas where the supplier needs to improve ESG performance to meet standards or best practices.',
    `assessment_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for conducting the ESG assessment, including auditor fees, travel, and administrative expenses.',
    `assessment_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the assessment cost.. Valid values are `^[A-Z]{3}$`',
    `assessment_date` DATE COMMENT 'Date when the ESG assessment was conducted or completed.',
    `assessment_number` STRING COMMENT 'Business identifier for the ESG assessment, used for external tracking and reporting.',
    `assessment_report_url` STRING COMMENT 'URL or file path to the detailed assessment report document stored in the document management system.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the ESG assessment. [ENUM-REF-CANDIDATE: scheduled|in_progress|completed|under_review|approved|failed|remediation_required — 7 candidates stripped; promote to reference product]',
    `assessment_type` STRING COMMENT 'Type of ESG assessment conducted. Higg FEM (Facility Environmental Module) is a standardized supply chain tool. SMETA (Sedex Members Ethical Trade Audit) is a widely used social audit format. BSCI (Business Social Compliance Initiative) is a European supply chain management system. WRAP (Worldwide Responsible Accredited Production) is an independent certification program. SA8000 is a social accountability standard. [ENUM-REF-CANDIDATE: self_assessment|third_party_audit|higg_fem|smeta|bsci|wrap|sa8000|other — 8 candidates stripped; promote to reference product]',
    `assessor_accreditation` STRING COMMENT 'Professional accreditation or certification held by the assessor (e.g., APSCA, SAAS, ISO lead auditor).',
    `assessor_name` STRING COMMENT 'Name of the individual or organization that conducted the ESG assessment.',
    `assessor_organization` STRING COMMENT 'Name of the third-party auditing firm or certification body that performed the assessment.',
    `certification_achieved` BOOLEAN COMMENT 'Indicates whether the supplier achieved formal certification as a result of this assessment (e.g., WRAP certified, SA8000 certified).',
    `certification_name` STRING COMMENT 'Name of the ESG certification or standard achieved by the supplier through this assessment.',
    `corrective_action_plan_approved` BOOLEAN COMMENT 'Indicates whether the submitted corrective action plan has been reviewed and approved by Apparel Fashion.',
    `corrective_action_plan_submitted` BOOLEAN COMMENT 'Indicates whether the supplier has submitted a formal corrective action plan in response to assessment findings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this assessment record was first created in the system.',
    `critical_findings_count` STRING COMMENT 'Number of critical non-conformances or zero-tolerance violations identified during the assessment that require immediate corrective action.',
    `environmental_score` DECIMAL(18,2) COMMENT 'Numerical score representing the suppliers environmental performance across metrics such as energy use, water consumption, waste management, emissions, and chemical management. Scale and methodology depend on assessment type.',
    `facility_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the facility location.. Valid values are `^[A-Z]{3}$`',
    `follow_up_assessment_date` DATE COMMENT 'Scheduled date for the follow-up assessment to verify corrective action completion.',
    `follow_up_assessment_required` BOOLEAN COMMENT 'Indicates whether a follow-up assessment is required to verify implementation of corrective actions.',
    `governance_score` DECIMAL(18,2) COMMENT 'Numerical score representing the suppliers governance and ethical business practices including anti-corruption, transparency, management systems, and compliance with laws and regulations. Scale and methodology depend on assessment type.',
    `key_findings_summary` STRING COMMENT 'Textual summary of the most significant findings, violations, and observations from the ESG assessment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this assessment record was last updated or modified.',
    `major_findings_count` STRING COMMENT 'Number of major non-conformances identified during the assessment that require corrective action within a defined timeframe.',
    `minor_findings_count` STRING COMMENT 'Number of minor non-conformances or opportunities for improvement identified during the assessment.',
    `notes` STRING COMMENT 'Additional notes, comments, or context related to the ESG assessment.',
    `overall_rating` STRING COMMENT 'Categorical rating summarizing the suppliers overall ESG performance. Zero tolerance indicates critical violations requiring immediate action or termination of business relationship.. Valid values are `excellent|good|acceptable|needs_improvement|unacceptable|zero_tolerance`',
    `overall_score` DECIMAL(18,2) COMMENT 'Composite numerical score representing the suppliers overall ESG performance, typically calculated as a weighted average of environmental, social, and governance scores.',
    `remediation_deadline` DATE COMMENT 'Target date by which the supplier must complete all required corrective actions and remediation measures.',
    `remediation_required` BOOLEAN COMMENT 'Indicates whether the supplier is required to implement corrective actions or remediation measures based on assessment findings.',
    `risk_level` STRING COMMENT 'Risk classification based on the assessment results, indicating the level of ESG-related business risk posed by continuing to work with this supplier.. Valid values are `low|medium|high|critical`',
    `scheduled_date` DATE COMMENT 'Date when the ESG assessment was originally scheduled to occur.',
    `social_score` DECIMAL(18,2) COMMENT 'Numerical score representing the suppliers social and labor performance across metrics such as working conditions, wages, working hours, health and safety, freedom of association, and non-discrimination. Scale and methodology depend on assessment type.',
    `strengths_identified` STRING COMMENT 'Description of positive practices, strengths, and areas of excellence identified during the assessment.',
    `supplier_tier` STRING COMMENT 'Supply chain tier classification of the assessed supplier. Tier 1 are direct suppliers (cut-make-trim factories), Tier 2 are fabric mills and material processors, Tier 3 are raw material suppliers (fiber, yarn), Tier 4 are commodity suppliers.. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `valid_from_date` DATE COMMENT 'Date from which the assessment results are considered valid and effective.',
    `valid_until_date` DATE COMMENT 'Date until which the assessment results remain valid, after which reassessment is required.',
    CONSTRAINT pk_supplier_esg_assessment PRIMARY KEY(`supplier_esg_assessment_id`)
) COMMENT 'Transactional record of ESG and sustainability assessments conducted on Apparel Fashions Tier 1, Tier 2, and Tier 3 suppliers and factories. Captures assessment date, assessment type (self-assessment, third-party audit, Higg FEM, SMETA), supplier tier, environmental score, social score, governance score, overall rating, key findings, and remediation requirements. Distinct from quality audits — focuses on ESG performance rather than product quality.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` (
    `traceability_record_id` BIGINT COMMENT 'Unique identifier for the traceability record capturing a supply chain event in the product journey from raw material to finished good.',
    `lot_batch_id` BIGINT COMMENT 'Reference to the specific material batch or lot being traced, enabling batch-level traceability.',
    `print_design_id` BIGINT COMMENT 'Foreign key linking to design.print_design. Business justification: Print designs are traced through supply chain for organic/certified textile compliance. Real process: GOTS/OCS traceability requires print design documentation with transaction certificates.',
    `production_factory_id` BIGINT COMMENT 'Reference to the manufacturing facility, supplier site, or processing location where this traceability event occurred.',
    `rfid_tag_id` BIGINT COMMENT 'The unique identifier of the RFID tag attached to the material or product batch, enabling automated tracking and traceability.',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: Traceability systems link materials back to original design intent for sustainability reporting and certification audits. Real process: blockchain/QR codes reference design specifications for chain-of',
    `style_id` BIGINT COMMENT 'Reference to the finished product or material being traced through the supply chain.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor responsible for this stage of the supply chain.',
    `prior_traceability_record_id` BIGINT COMMENT 'Self-referencing FK on traceability_record (prior_traceability_record_id)',
    `audit_trail_reference` STRING COMMENT 'Reference to the audit report or inspection record associated with this traceability event, linking to compliance and quality assurance documentation.',
    `blockchain_hash` STRING COMMENT 'The cryptographic hash or transaction identifier if this traceability record is anchored on a blockchain platform for immutable supply chain transparency.',
    `carbon_footprint_kg_co2e` DECIMAL(18,2) COMMENT 'The calculated carbon footprint for this stage of the supply chain, measured in kilograms of carbon dioxide equivalent (kg CO2e), supporting environmental impact reporting.',
    `certification_standard` STRING COMMENT 'The sustainability or quality certification standard applicable to this traceability event. GOTS (Global Organic Textile Standard), OCS (Organic Content Standard), GRS (Global Recycled Standard), RCS (Recycled Claim Standard), BCI (Better Cotton Initiative), FSC (Forest Stewardship Council), OEKO-TEX (textile safety). [ENUM-REF-CANDIDATE: GOTS|OCS|GRS|RCS|BCI|FSC|OEKO-TEX — 7 candidates stripped; promote to reference product]',
    `chain_of_custody_method` STRING COMMENT 'The method used to track and verify the material through the supply chain. Identity Preserved maintains physical separation of certified material throughout. Segregated keeps certified material separate but may mix sources. Mass Balance allows mixing with tracking of certified content percentage. Book and Claim uses administrative credits without physical traceability.. Valid values are `Identity Preserved|Segregated|Mass Balance|Book and Claim`',
    `chemical_usage_kg` DECIMAL(18,2) COMMENT 'The total weight of chemicals used in this processing stage (e.g., dyes, finishes, treatments), measured in kilograms, supporting chemical management and ZDHC compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this traceability record was first created in the system.',
    `energy_consumption_kwh` DECIMAL(18,2) COMMENT 'The energy consumed during this manufacturing or processing stage, measured in kilowatt hours (kWh), supporting energy efficiency and renewable energy reporting.',
    `fair_trade_certified` BOOLEAN COMMENT 'Boolean flag indicating whether this supply chain stage is Fair Trade certified, ensuring fair labor practices and community development.',
    `geographic_coordinates` STRING COMMENT 'The latitude and longitude coordinates of the facility or farm where this traceability event occurred, enabling precise geographic traceability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this traceability record was last updated or modified.',
    `material_composition` STRING COMMENT 'The fiber composition or blend of the material at this traceability stage, including percentages of each fiber type (e.g., 100% Organic Cotton, 60% Recycled Polyester 40% Cotton).',
    `material_type` STRING COMMENT 'The type or category of material being traced at this stage (e.g., organic cotton fiber, recycled polyester yarn, dyed fabric, finished garment).',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, or contextual information about this traceability event that may be relevant for transparency or compliance purposes.',
    `organic_content_percentage` DECIMAL(18,2) COMMENT 'The percentage of organic material content in the product or material at this traceability stage, supporting organic certification claims.',
    `origin_country_code` STRING COMMENT 'The three-letter ISO country code representing the country of origin for the material or product at this traceability stage.. Valid values are `^[A-Z]{3}$`',
    `process_stage` STRING COMMENT 'The specific manufacturing or processing stage captured in this traceability record (e.g., Spinning, Weaving, Knitting, Dyeing, Printing, Cutting, Sewing, Finishing, Packaging).',
    `purchase_order_number` STRING COMMENT 'The purchase order number associated with this supply chain transaction, linking traceability to procurement records.',
    `qr_code_data` STRING COMMENT 'The encoded data string from the QR code associated with this traceability record, enabling consumer-facing transparency and product authentication.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of material or product units involved in this traceability event.',
    `record_status` STRING COMMENT 'The current status of this traceability record. Active indicates the record is current and valid. Archived indicates the record is historical but retained for audit purposes. Disputed indicates the record accuracy is under review. Corrected indicates the record has been amended after initial creation.. Valid values are `Active|Archived|Disputed|Corrected`',
    `recycled_content_percentage` DECIMAL(18,2) COMMENT 'The percentage of recycled material content in the product or material at this traceability stage, supporting recycled content claims and circular economy goals.',
    `shipping_document_number` STRING COMMENT 'The shipping document, bill of lading, or delivery note number associated with the physical movement of material in this traceability event.',
    `traceability_tier` STRING COMMENT 'The supply chain tier level of this traceability event. Tier 1 represents final assembly or Cut-Make-Trim (CMT), Tier 2 represents fabric mills or dyeing facilities, Tier 3 represents spinning or weaving facilities, Tier 4 represents raw fiber origin.. Valid values are `Tier 1|Tier 2|Tier 3|Tier 4|Raw Material`',
    `transaction_certificate_reference` STRING COMMENT 'The unique reference number of the transaction certificate (TC) issued by the certification body for this supply chain transaction, enabling verification of certified material transfer.',
    `transaction_date` DATE COMMENT 'The date when this supply chain transaction or traceability event occurred.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity field. KG (kilograms), LB (pounds), M (meters), YD (yards), PCS (pieces), ROLL (rolls), BALE (bales). [ENUM-REF-CANDIDATE: KG|LB|M|YD|PCS|ROLL|BALE — 7 candidates stripped; promote to reference product]',
    `verification_date` DATE COMMENT 'The date when this traceability record was verified by a certification body or auditor.',
    `verification_status` STRING COMMENT 'The verification status of this traceability record. Verified indicates the chain of custody has been validated by a certification body or third-party auditor. Pending indicates verification is in progress. Failed indicates verification issues were identified. Not Required indicates this stage does not require third-party verification.. Valid values are `Verified|Pending|Failed|Not Required`',
    `verifier_organization` STRING COMMENT 'The name of the certification body, auditor, or third-party organization that verified this traceability record.',
    `waste_generated_kg` DECIMAL(18,2) COMMENT 'The weight of waste material generated during this manufacturing stage, measured in kilograms, supporting circular economy and waste reduction initiatives.',
    `water_consumption_liters` DECIMAL(18,2) COMMENT 'The volume of water consumed during this manufacturing or processing stage, measured in liters, supporting water stewardship reporting.',
    CONSTRAINT pk_traceability_record PRIMARY KEY(`traceability_record_id`)
) COMMENT 'Transactional record capturing supply chain traceability events for Apparel Fashion products, tracking the journey of materials and finished goods from raw fiber origin through spinning, weaving/knitting, dyeing, CMT, and final product. Captures traceability tier (Tier 1–4), facility, material batch, transaction certificate reference, chain-of-custody method (identity preserved, segregated, mass balance, book and claim), and verification status. Enables fiber-to-finished-product traceability for transparency commitments.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` (
    `packaging_sustainability_id` BIGINT COMMENT 'Unique identifier for the packaging sustainability record.',
    `replacement_packaging_packaging_sustainability_id` BIGINT COMMENT 'Reference to the more sustainable packaging type that will replace this one during phase-out. Null if no replacement identified.',
    `superseded_packaging_sustainability_id` BIGINT COMMENT 'Self-referencing FK on packaging_sustainability (superseded_packaging_sustainability_id)',
    `annual_volume_units` BIGINT COMMENT 'Estimated annual usage volume of this packaging type across all channels. Used to calculate total environmental impact and cost.',
    `baseline_year` STRING COMMENT 'Reference year for measuring packaging reduction progress and sustainability improvements (e.g., 2020). Used in conjunction with reduction targets.',
    `biodegradability_certification` STRING COMMENT 'Third-party certification for biodegradable or compostable packaging: ok_compost_home (home composting), ok_compost_industrial (industrial composting), astm_d6400 (US standard), en_13432 (EU standard), not_certified.. Valid values are `ok_compost_home|ok_compost_industrial|astm_d6400|en_13432|not_certified`',
    `carbon_footprint_kg_co2e` DECIMAL(18,2) COMMENT 'Estimated carbon footprint of the packaging unit expressed in kilograms of carbon dioxide equivalent (CO2e), covering raw material extraction, manufacturing, and end-of-life. Supports Scope 3 emissions reporting.',
    `channel_applicability` STRING COMMENT 'Sales channel(s) where this packaging type is used: retail (brick-and-mortar stores), e_commerce (online orders), wholesale (B2B distribution), all_channels (universal use).. Valid values are `retail|e_commerce|wholesale|all_channels`',
    `cost_per_unit_usd` DECIMAL(18,2) COMMENT 'Standard cost per packaging unit in US dollars. Used for cost-benefit analysis of sustainable packaging alternatives.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this packaging sustainability record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this packaging type was discontinued or phased out. Null if still active.',
    `effective_start_date` DATE COMMENT 'Date when this packaging type was first introduced into production and distribution. Supports historical tracking and sustainability progress measurement.',
    `energy_consumption_mj` DECIMAL(18,2) COMMENT 'Total energy consumption in megajoules (MJ) required to produce one unit of packaging, covering raw material extraction, manufacturing, and transportation to distribution center.',
    `epr_compliance_status` STRING COMMENT 'Compliance status with Extended Producer Responsibility regulations requiring producers to manage end-of-life packaging: compliant (meets all EPR requirements), non_compliant (violations identified), exempt (not subject to EPR), pending_review (under assessment).. Valid values are `compliant|non_compliant|exempt|pending_review`',
    `epr_registration_number` STRING COMMENT 'Official registration number with EPR compliance schemes (e.g., PRN in UK, Green Dot in EU). Null if not registered or exempt.. Valid values are `^[A-Z]{2,3}-[A-Z0-9]{6,15}$`',
    `fsc_certificate_number` STRING COMMENT 'Official FSC chain-of-custody certificate number for paper-based packaging (e.g., FSC-C123456). Null if not FSC-certified.. Valid values are `^FSC-[A-Z0-9]{6,12}$`',
    `fsc_certification_status` STRING COMMENT 'FSC certification level for paper/cardboard packaging: fsc_100 (100% FSC-certified forests), fsc_mix (mix of FSC and controlled sources), fsc_recycled (100% recycled fiber), not_certified, pending (certification in progress).. Valid values are `fsc_100|fsc_mix|fsc_recycled|not_certified|pending`',
    `hazardous_substance_indicator` BOOLEAN COMMENT 'Indicates whether the packaging contains hazardous substances restricted under REACH, RoHS, or similar regulations (e.g., heavy metals, phthalates, PFAS). True if hazardous substances present, False if compliant.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this packaging sustainability record was last updated, reflecting changes to certifications, compliance status, or environmental metrics.',
    `lifecycle_stage` STRING COMMENT 'Current lifecycle stage of the packaging type: active (in production and use), phasing_out (being replaced by more sustainable alternative), discontinued (no longer used), under_development (pilot or testing phase).. Valid values are `active|phasing_out|discontinued|under_development`',
    `material_composition` STRING COMMENT 'Detailed description of the materials used in the packaging (e.g., 100% recycled polyethylene, FSC-certified kraft paper, biodegradable cornstarch film, virgin polypropylene). May include multiple materials separated by semicolons.',
    `microplastic_shedding_risk` STRING COMMENT 'Assessment of the risk that the packaging will shed microplastics during use or degradation: high (significant shedding expected), medium (moderate risk), low (minimal risk), none (no plastic content or non-shedding material).. Valid values are `high|medium|low|none`',
    `packaging_category` STRING COMMENT 'Classification of packaging by usage context: primary (direct product contact), secondary (retail display), tertiary (shipping/distribution), point_of_sale (in-store), e_commerce (online fulfillment), wholesale (B2B distribution).. Valid values are `primary|secondary|tertiary|point_of_sale|e_commerce|wholesale`',
    `packaging_reduction_target_percentage` DECIMAL(18,2) COMMENT 'Target percentage reduction in packaging weight or volume compared to baseline year, aligned with corporate sustainability commitments (e.g., 25.00 for 25% reduction target).',
    `packaging_type_code` STRING COMMENT 'Unique code identifying the packaging type (e.g., PBAG001 for polybag, HTAG002 for hang tag, SBAG003 for shopping bag, MAIL004 for mailer, CRTN005 for carton).. Valid values are `^[A-Z0-9]{4,12}$`',
    `packaging_type_name` STRING COMMENT 'Human-readable name of the packaging type (e.g., Polybag, Hang Tag, Shopping Bag, Mailer, Carton, Box, Tissue Paper, Ribbon).',
    `phase_out_target_date` DATE COMMENT 'Target date for discontinuing this packaging type as part of sustainability roadmap. Null if no phase-out planned.',
    `plastic_weight_grams` DECIMAL(18,2) COMMENT 'Total weight of plastic content per packaging unit in grams. Critical for tracking plastic reduction targets and Extended Producer Responsibility (EPR) reporting.',
    `post_consumer_recycled_percentage` DECIMAL(18,2) COMMENT 'Percentage of post-consumer recycled content specifically (material recovered from consumer waste streams), as distinct from post-industrial recycled content. Critical for ESG reporting and sustainability claims.',
    `primary_material_type` STRING COMMENT 'The dominant material category of the packaging: plastic, paper, cardboard, textile, metal, glass, bioplastic (plant-based), or composite (mixed materials). [ENUM-REF-CANDIDATE: plastic|paper|cardboard|textile|metal|glass|bioplastic|composite — 8 candidates stripped; promote to reference product]',
    `reach_compliance_status` STRING COMMENT 'Compliance status with EU REACH regulation restricting hazardous substances in packaging materials: compliant (meets all REACH requirements), non_compliant (violations identified), under_review (assessment in progress), not_applicable (outside EU scope).. Valid values are `compliant|non_compliant|under_review|not_applicable`',
    `recyclability_rating` STRING COMMENT 'Assessment of how easily the packaging can be recycled in standard municipal recycling systems: fully_recyclable (accepted everywhere), widely_recyclable (accepted in most programs), limited_recyclability (specialty facilities only), not_recyclable, compostable (industrial composting), biodegradable (natural decomposition).. Valid values are `fully_recyclable|widely_recyclable|limited_recyclability|not_recyclable|compostable|biodegradable`',
    `recycled_content_percentage` DECIMAL(18,2) COMMENT 'Percentage of post-consumer or post-industrial recycled material in the packaging, expressed as a decimal (e.g., 75.00 for 75% recycled content). Supports circular economy and plastic reduction commitments.',
    `renewable_content_percentage` DECIMAL(18,2) COMMENT 'Percentage of packaging material derived from renewable resources (e.g., plant-based bioplastics, sustainably harvested paper). Distinct from recycled content.',
    `reusability_indicator` BOOLEAN COMMENT 'Indicates whether the packaging is designed for multiple uses (e.g., reusable shopping bags, returnable shipping containers). True if reusable, False if single-use.',
    `reuse_cycle_count` STRING COMMENT 'Expected number of reuse cycles for reusable packaging before end-of-life. Null for single-use packaging.',
    `supplier_sustainability_score` DECIMAL(18,2) COMMENT 'Sustainability performance score of the packaging supplier, typically on a 0-100 scale. Based on environmental audits, certifications, and ESG assessments.',
    `sustainable_certification_list` STRING COMMENT 'Semicolon-separated list of sustainability certifications held by the packaging (e.g., Cradle to Cradle; OEKO-TEX; Global Recycled Standard; Blue Angel; Nordic Swan). Supports ESG reporting and marketing claims.',
    `total_weight_grams` DECIMAL(18,2) COMMENT 'Total weight of the packaging unit in grams, including all materials. Used for carbon footprint calculations and logistics optimization.',
    `virgin_plastic_indicator` BOOLEAN COMMENT 'Indicates whether the packaging contains virgin (non-recycled) plastic. True if virgin plastic is present, False if plastic-free or 100% recycled plastic. Critical for plastic reduction commitments.',
    `water_usage_liters` DECIMAL(18,2) COMMENT 'Estimated water consumption in liters required to produce one unit of packaging, from raw material extraction through manufacturing. Supports water stewardship reporting.',
    CONSTRAINT pk_packaging_sustainability PRIMARY KEY(`packaging_sustainability_id`)
) COMMENT 'Master record defining the sustainability profile of each packaging type used by Apparel Fashion across retail, e-commerce, and wholesale channels. Captures packaging type (polybag, hang tag, shopping bag, mailer, carton), material composition, recycled content percentage, recyclability rating, FSC certification status, plastic weight per unit, and compliance with extended producer responsibility (EPR) regulations. Supports plastic reduction and sustainable packaging commitments.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`target` (
    `target_id` BIGINT COMMENT 'Unique identifier for the sustainability target record. Primary key for the sustainability target entity.',
    `esg_report_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_report. Business justification: Non-carbon sustainability targets (water, waste, biodiversity, etc.) are disclosed in ESG reports. Same disclosure pattern as carbon_target. Enables linking targets to the report period for transparen',
    `superseded_target_id` BIGINT COMMENT 'Self-referencing FK on target (superseded_target_id)',
    `baseline_value` DECIMAL(18,2) COMMENT 'The starting or reference value from which progress toward the target is measured. Represents the initial state before improvement initiatives.',
    `baseline_year` STRING COMMENT 'The calendar year in which the baseline value was established or measured.',
    `commitment_framework` STRING COMMENT 'The external sustainability framework, initiative, or standard to which this target is aligned (e.g., Science Based Targets, UN SDG 6, ZDHC Roadmap to Zero, Fair Labor Association).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this sustainability target record was first created in the system.',
    `current_value` DECIMAL(18,2) COMMENT 'The most recent measured or reported value representing progress toward the target. Updated periodically as performance data becomes available.',
    `current_value_as_of_date` DATE COMMENT 'The date on which the current value was last measured or reported, indicating the freshness of progress data.',
    `effective_end_date` DATE COMMENT 'The date on which this sustainability target was retired, achieved, or cancelled. Null for active targets.',
    `effective_start_date` DATE COMMENT 'The date from which this sustainability target became active and tracking began.',
    `executive_sponsor` STRING COMMENT 'Name or title of the executive leader sponsoring and accountable for this sustainability target at the leadership level.',
    `is_public_commitment` BOOLEAN COMMENT 'Indicates whether this target has been publicly disclosed or committed to external stakeholders, investors, or regulatory bodies.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this sustainability target record was most recently modified or updated.',
    `measurement_methodology` STRING COMMENT 'Description of the calculation method, data sources, and standards used to measure progress toward the target.',
    `mitigation_plan` STRING COMMENT 'Description of actions, initiatives, or interventions planned or underway to address risks and ensure target achievement.',
    `notes` STRING COMMENT 'Additional context, assumptions, exclusions, or commentary relevant to the interpretation of this sustainability target.',
    `progress_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage of progress from baseline to target, representing how far the organization has advanced toward the goal.',
    `public_commitment_date` DATE COMMENT 'The date on which the target was publicly announced or committed to external parties. Null if not publicly committed.',
    `related_sdg_goals` STRING COMMENT 'Comma-separated list of United Nations Sustainable Development Goals (SDGs) to which this target contributes (e.g., SDG 6, SDG 12, SDG 5).',
    `reporting_frequency` STRING COMMENT 'The cadence at which progress toward this target is measured and reported internally or externally.. Valid values are `monthly|quarterly|semi_annually|annually`',
    `responsible_department` STRING COMMENT 'The business unit, department, or function accountable for achieving this sustainability target.',
    `risk_level` STRING COMMENT 'Assessment of the risk that the target will not be achieved by the target year, based on current progress and external factors.. Valid values are `low|medium|high|critical`',
    `scope_description` STRING COMMENT 'Detailed description of the organizational scope and boundaries covered by this target (e.g., Global operations, Tier 1 suppliers, Direct manufacturing facilities, All product categories).',
    `target_category` STRING COMMENT 'Classification of the sustainability target by environmental or social domain. Distinct from carbon targets which are tracked separately. [ENUM-REF-CANDIDATE: water_reduction|waste_diversion|sustainable_material_mix|circular_economy|chemical_elimination|social_equity|energy_efficiency|biodiversity|packaging|supply_chain_transparency — 10 candidates stripped; promote to reference product]',
    `target_code` STRING COMMENT 'Unique business identifier or code for the sustainability target used for external reporting and tracking (e.g., WATER-2030, CIRC-DIV-2025).',
    `target_name` STRING COMMENT 'Human-readable name or title of the sustainability target (e.g., Water Reduction 2030, Circular Economy Diversion Rate, Women in Leadership 50%).',
    `target_status` STRING COMMENT 'Current lifecycle status of the sustainability target indicating progress and active state. [ENUM-REF-CANDIDATE: draft|active|on_track|at_risk|achieved|retired|cancelled — 7 candidates stripped; promote to reference product]',
    `target_value` DECIMAL(18,2) COMMENT 'The goal or desired value to be achieved by the target year. Represents the committed improvement level.',
    `unit_of_measure` STRING COMMENT 'The unit in which baseline, target, and current values are expressed (e.g., liters, percentage, metric tons, number of employees, percentage of total materials).',
    `verification_body` STRING COMMENT 'Name of the third-party organization or auditor that verified the target and its progress data. Null if not externally verified.',
    `verification_date` DATE COMMENT 'The date on which the most recent third-party verification or audit of this target was completed. Null if not verified.',
    `verification_status` STRING COMMENT 'Indicates the level of external assurance or verification applied to the target and its reported progress.. Valid values are `not_verified|internal_review|third_party_verified|audited`',
    `year` STRING COMMENT 'The calendar year by which the target value is committed to be achieved.',
    CONSTRAINT pk_target PRIMARY KEY(`target_id`)
) COMMENT 'Master record defining Apparel Fashions sustainability commitments and targets beyond carbon, including water reduction, waste diversion, sustainable material mix percentage, circular economy diversion rate, chemical elimination (ZDHC), and social targets (living wage coverage, women in leadership). Captures target category, baseline value, target value, target year, progress-to-date, and public commitment status. Distinct from carbon_target which is specific to GHG emissions.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` (
    `chemical_compliance_id` BIGINT COMMENT 'Unique identifier for the chemical compliance record. Primary key for tracking Restricted Substance List (RSL) and Manufacturing Restricted Substance List (MRSL) compliance across the supply chain.',
    `colorway_development_id` BIGINT COMMENT 'Foreign key linking to design.colorway_development. Business justification: Colorway dyes and finishes must pass chemical compliance testing (RSL, MRSL). Real process: lab dip approval includes chemical testing; compliance records link to colorway development for audit trails',
    `material_id` BIGINT COMMENT 'Reference to the specific material or component tested for chemical compliance. Links to the material master data in the Product Lifecycle Management (PLM) system.',
    `print_design_id` BIGINT COMMENT 'Foreign key linking to design.print_design. Business justification: Print designs must comply with chemical restrictions (ZDHC MRSL, Oeko-Tex). Real process: print approval requires RSL testing of dyes/pigments; compliance records link to print designs.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or manufacturer responsible for the material or component being tested. Critical for supply chain accountability and remediation tracking.',
    `superseded_chemical_compliance_id` BIGINT COMMENT 'Self-referencing FK on chemical_compliance (superseded_chemical_compliance_id)',
    `applicable_regulation` STRING COMMENT 'Primary regulatory framework or standard governing this chemical restriction. May include REACH, CPSC, OEKO-TEX STANDARD 100, ZDHC MRSL, California Proposition 65, or other jurisdiction-specific regulations.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to every chemical substance. Standard reference for global chemical identification.. Valid values are `^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$`',
    `certificate_expiry_date` DATE COMMENT 'Date when the compliance certificate expires and retesting is required. Critical for maintaining continuous compliance status.',
    `certificate_number` STRING COMMENT 'Compliance certificate number issued upon successful testing. Examples include OEKO-TEX certificate numbers, ZDHC InCheck report numbers, or other certification identifiers.',
    `chemical_name` STRING COMMENT 'Common or trade name of the chemical substance being tracked for compliance. Used for identification and communication across supply chain partners.',
    `compliance_status` STRING COMMENT 'Overall pass/fail determination based on comparison of test result value against threshold limit. Pass indicates compliance; Fail indicates violation requiring remediation; Pending indicates testing in progress; Conditional indicates compliance with restrictions.. Valid values are `Pass|Fail|Pending|Conditional`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this chemical compliance record was first created in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_source` STRING COMMENT 'Source system or platform from which this compliance data originated. Examples include PLM system, ZDHC Gateway, laboratory portal, or manual entry.',
    `detection_status` STRING COMMENT 'Indicates whether the chemical substance was detected in the test sample. Distinct from compliance status; a substance may be detected but still compliant if below threshold.. Valid values are `Detected|Not Detected|Below Detection Limit`',
    `facility_country` STRING COMMENT 'ISO 3-letter country code of the production facility location. Used for jurisdiction-specific compliance requirements and supply chain transparency.. Valid values are `^[A-Z]{3}$`',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this compliance record is currently active and valid. False indicates the record has been superseded or archived.',
    `laboratory_accreditation` STRING COMMENT 'Accreditation body and certificate number validating the testing laboratorys competence. Examples include ISO 17025, CNAS, UKAS, A2LA.',
    `modified_by` STRING COMMENT 'User identifier or system name that last modified this compliance record. Used for accountability and audit purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this chemical compliance record was last updated. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX. Critical for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional context, special circumstances, or clarifications related to the compliance record. May include supplier communications, testing anomalies, or regulatory interpretations.',
    `oeko_tex_class` STRING COMMENT 'OEKO-TEX Standard 100 product class determining applicable limit values. Class I (baby products) has strictest limits; Class IV (decoration materials) has most lenient.. Valid values are `Class I|Class II|Class III|Class IV`',
    `production_facility` STRING COMMENT 'Name or identifier of the manufacturing facility where the material or product was produced. Important for MRSL compliance tracking at facility level.',
    `regulation_jurisdiction` STRING COMMENT 'Geographic region or country where the regulation applies. Uses ISO 3-letter country codes or regional identifiers (e.g., USA, EUR, CHN, Global).',
    `remediation_action` STRING COMMENT 'Description of the corrective action plan to address non-compliance. May include supplier engagement, material substitution, process changes, or product recall.',
    `remediation_completed_date` DATE COMMENT 'Actual date when remediation action was completed and verified. Used to track remediation cycle time and supplier performance.',
    `remediation_due_date` DATE COMMENT 'Target date by which remediation action must be completed. Based on risk assessment and regulatory requirements.',
    `remediation_required` BOOLEAN COMMENT 'Boolean flag indicating whether corrective action is required due to non-compliance. True when compliance_status is Fail or Conditional.',
    `remediation_status` STRING COMMENT 'Current status of the remediation action plan. Tracks progress from identification through verification of corrective measures.. Valid values are `Not Started|In Progress|Completed|Verified|Escalated`',
    `responsible_party` STRING COMMENT 'Name or identifier of the individual or team responsible for managing this compliance record and driving remediation if required.',
    `restriction_type` STRING COMMENT 'Classification of the restriction category. RSL (Restricted Substance List) applies to finished products; MRSL (Manufacturing Restricted Substance List) applies to manufacturing processes and facilities.. Valid values are `RSL|MRSL|Both`',
    `risk_level` STRING COMMENT 'Risk classification based on the severity of non-compliance, potential health/environmental impact, and regulatory consequences. Drives prioritization of remediation efforts.. Valid values are `Critical|High|Medium|Low`',
    `sample_description` STRING COMMENT 'Detailed description of the sample tested, including color, material composition, processing stage, or other identifying characteristics relevant to the test.',
    `sample_type` STRING COMMENT 'Classification of the sample tested. Distinguishes between raw materials, components, finished products, or environmental samples (wastewater, air emissions) for MRSL compliance.. Valid values are `Raw Material|Component|Finished Product|Wastewater|Air Emission`',
    `test_date` DATE COMMENT 'Date when the laboratory test was conducted to measure chemical substance concentration. Critical for tracking compliance timeline and certificate validity.',
    `test_method` STRING COMMENT 'Standardized laboratory test method or protocol used to detect and quantify the chemical substance. Examples include ISO, ASTM, AATCC, or proprietary test methods.',
    `test_report_number` STRING COMMENT 'Unique identifier assigned by the testing laboratory to the test report. Used for traceability and audit purposes.',
    `test_result_value` DECIMAL(18,2) COMMENT 'Actual measured concentration or quantity of the chemical substance detected in laboratory testing. Expressed in the same unit as threshold_unit for direct comparison.',
    `testing_laboratory` STRING COMMENT 'Name of the accredited third-party laboratory that performed the chemical compliance testing. Should be ISO 17025 accredited for credibility.',
    `threshold_limit` DECIMAL(18,2) COMMENT 'Maximum allowable concentration or quantity of the chemical substance permitted by the applicable regulation. Expressed in the unit specified in threshold_unit.',
    `threshold_unit` STRING COMMENT 'Unit of measurement for the threshold limit. Common units include parts per million (ppm), milligrams per kilogram (mg/kg), percentage (percent), milligrams per liter (mg/L), or micrograms per gram (ug/g).. Valid values are `ppm|mg/kg|percent|mg/L|ug/g`',
    `zdhc_mrsl_version` STRING COMMENT 'Version number of the ZDHC MRSL standard used for compliance assessment. ZDHC MRSL is updated periodically with new restrictions and revised limits.',
    `created_by` STRING COMMENT 'User identifier or system name that created this compliance record. Used for accountability and audit purposes.',
    CONSTRAINT pk_chemical_compliance PRIMARY KEY(`chemical_compliance_id`)
) COMMENT 'Master and transactional record managing Restricted Substance List (RSL) and Manufacturing Restricted Substance List (MRSL) compliance for chemicals used in Apparel Fashions supply chain. Captures chemical name, CAS number, restriction type (RSL/MRSL), applicable regulation (REACH, CPSC, OEKO-TEX STANDARD 100, ZDHC MRSL), maximum allowable limit, test result value, pass/fail status, and remediation action. Distinct from compliance.chemical_compliance which is owned by the compliance domain — this record is the sustainability domains operational tracking of ZDHC and chemical stewardship programs.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` (
    `renewable_energy_certificate_id` BIGINT COMMENT 'Unique identifier for the renewable energy certificate record.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to sustainability.initiative. Business justification: REC purchases are often part of renewable energy initiatives. Need to link RECs to the initiative that drove procurement for initiative impact tracking and budget allocation. N:1 relationship. No bidi',
    `production_factory_id` BIGINT COMMENT 'Identifier of the Apparel Fashion facility (manufacturing plant, distribution center, office, store) for which this certificate is being applied to offset Scope 2 emissions. Null if applied at corporate level.',
    `bundled_from_renewable_energy_certificate_id` BIGINT COMMENT 'Self-referencing FK on renewable_energy_certificate (bundled_from_renewable_energy_certificate_id)',
    `associated_market` STRING COMMENT 'Geographic market or grid region where the certificate is being applied for Scope 2 accounting, ensuring alignment between generation location and consumption location per GHG Protocol guidance.',
    `beneficiary_organization` STRING COMMENT 'Name of the organization on whose behalf the certificate was retired, typically Apparel Fashion or a subsidiary entity.',
    `certificate_number` STRING COMMENT 'Externally-issued unique certificate number or serial number assigned by the issuing registry or authority.',
    `certificate_status` STRING COMMENT 'Current lifecycle status of the certificate. Active = available for use, Retired = claimed for Scope 2 accounting, Expired = past validity period, Cancelled = invalidated, Transferred = moved to another account.. Valid values are `active|retired|expired|cancelled|transferred`',
    `certificate_type` STRING COMMENT 'Type of renewable energy certificate instrument. REC = Renewable Energy Certificate (North America), GO = Guarantee of Origin (Europe), I-REC = International Renewable Energy Certificate, TIGR = The International Greenhouse Gas Registry, J-Credit = Japan Carbon Credit.. Valid values are `REC|GO|I-REC|TIGR|J-Credit|Other`',
    `contract_reference_number` STRING COMMENT 'Reference number of the Power Purchase Agreement (PPA), procurement contract, or purchase order under which this certificate was acquired.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this renewable energy certificate record was first created in the system.',
    `energy_source` STRING COMMENT 'Primary renewable energy source used to generate the electricity represented by this certificate.. Valid values are `solar|wind|hydro|geothermal|biomass|mixed`',
    `generation_end_date` DATE COMMENT 'End date of the generation period for the electricity represented by this certificate.',
    `generation_facility_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the generation facility is located.. Valid values are `^[A-Z]{3}$`',
    `generation_facility_location` STRING COMMENT 'Geographic location of the generation facility, typically city and state or province.',
    `generation_facility_name` STRING COMMENT 'Name of the renewable energy generation facility or power plant that produced the electricity.',
    `generation_start_date` DATE COMMENT 'Start date of the generation period for the electricity represented by this certificate.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this renewable energy certificate record was last updated in the system.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding this renewable energy certificate, including any special conditions or clarifications.',
    `procurement_method` STRING COMMENT 'Method by which the renewable energy certificate was procured. Unbundled REC = certificate purchased separately from electricity, Bundled PPA = Power Purchase Agreement with bundled RECs, VPPA = Virtual Power Purchase Agreement, Green Tariff = utility green pricing program, Direct Investment = owned generation facility.. Valid values are `unbundled_rec|bundled_ppa|vppa|green_tariff|direct_investment`',
    `purchase_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the purchase price.. Valid values are `^[A-Z]{3}$`',
    `purchase_date` DATE COMMENT 'Date on which the certificate was purchased or acquired by Apparel Fashion.',
    `purchase_price_per_mwh` DECIMAL(18,2) COMMENT 'Price paid per megawatt-hour for this certificate, used for cost tracking and financial reporting.',
    `quantity_mwh` DECIMAL(18,2) COMMENT 'Quantity of renewable electricity represented by this certificate, measured in megawatt-hours. One certificate typically represents one MWh of renewable electricity generation.',
    `re100_eligible_flag` BOOLEAN COMMENT 'Indicates whether this certificate meets RE100 technical criteria for renewable electricity sourcing, including additionality, vintage matching, and geographic correlation requirements.',
    `registry_account_number` STRING COMMENT 'Account number or identifier in the registry system under which this certificate is held or was retired.',
    `registry_name` STRING COMMENT 'Name of the tracking system or registry that issued and tracks this certificate (e.g., M-RETS, PJM-GATS, APX TIGR, I-REC Standard).',
    `retirement_date` DATE COMMENT 'Date on which the certificate was retired in the registry system to claim the renewable energy attribute for Scope 2 market-based accounting. Null if not yet retired.',
    `retirement_reason` STRING COMMENT 'Business reason or purpose for retiring the certificate, typically referencing the reporting period or facility for which the renewable claim is being made.',
    `scope_2_reporting_period` STRING COMMENT 'Fiscal year or reporting period for which this certificate is being applied to Scope 2 market-based emissions accounting (e.g., FY2024, 2024-Q1).',
    `supplier_name` STRING COMMENT 'Name of the broker, utility, or renewable energy provider from whom the certificate was purchased.',
    `verification_date` DATE COMMENT 'Date on which third-party verification of this certificate was completed. Null if not yet verified.',
    `verification_status` STRING COMMENT 'Status of third-party verification or assurance of this certificate for ESG reporting purposes.. Valid values are `verified|pending|not_verified`',
    `verifier_organization` STRING COMMENT 'Name of the third-party organization that verified this certificate for ESG reporting (e.g., DNV, SGS, Bureau Veritas).',
    `vintage_year` STRING COMMENT 'Calendar year in which the renewable electricity was generated. Critical for matching certificate vintage to consumption period per GHG Protocol.',
    CONSTRAINT pk_renewable_energy_certificate PRIMARY KEY(`renewable_energy_certificate_id`)
) COMMENT 'Master and transactional record for Renewable Energy Certificates (RECs), Guarantees of Origin (GOs), and Power Purchase Agreements (PPAs) procured by Apparel Fashion to support RE100 and Scope 2 market-based accounting. Captures certificate type (REC, GO, I-REC), energy source (solar, wind, hydro), generation facility, vintage year, quantity (MWh), registry, retirement status, and associated facility or market. Enables market-based Scope 2 emissions accounting.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` (
    `social_impact_program_id` BIGINT COMMENT 'Unique identifier for the social impact program record. Primary key.',
    `esg_report_id` BIGINT COMMENT 'Reference to the ESG report in which this program is disclosed.',
    `predecessor_social_impact_program_id` BIGINT COMMENT 'Self-referencing FK on social_impact_program (predecessor_social_impact_program_id)',
    `audit_provider` STRING COMMENT 'Name of the third-party organization that conducted the external audit or verification of program impact.',
    `beneficiary_count` STRING COMMENT 'Total number of individuals directly benefiting from the program during the reporting period.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary country where the program operates. For multi-country programs, this represents the lead country.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this program record was first created in the system.',
    `direct_beneficiary_count` STRING COMMENT 'Number of individuals receiving direct program services or interventions.',
    `end_date` DATE COMMENT 'Planned or actual date when the program concluded or is scheduled to conclude. Null for ongoing programs.',
    `external_audit_flag` BOOLEAN COMMENT 'Indicates whether the program has undergone or is subject to external third-party audit or verification.',
    `external_reporting_flag` BOOLEAN COMMENT 'Indicates whether this program is included in external ESG reports, sustainability disclosures, or public communications.',
    `female_beneficiary_percentage` DECIMAL(18,2) COMMENT 'Percentage of program beneficiaries who are female, supporting gender equity tracking.',
    `fiscal_year` STRING COMMENT 'Fiscal year for which the investment and impact metrics are reported.',
    `fla_aligned_flag` BOOLEAN COMMENT 'Indicates whether the program is aligned with Fair Labor Association workplace standards and principles.',
    `geographic_scope` STRING COMMENT 'Geographic reach and scale of the social impact program.. Valid values are `global|regional|country|local`',
    `herproject_flag` BOOLEAN COMMENT 'Indicates whether this program is part of the HERproject womens empowerment initiative in the supply chain.',
    `impact_metric_type` STRING COMMENT 'Primary quantitative metric used to measure program impact and effectiveness.. Valid values are `wage_increase|training_hours|health_screenings|education_access|employment_created|income_generated`',
    `impact_metric_unit` STRING COMMENT 'Unit of measurement for the impact metric value (e.g., USD, hours, individuals, percentage).',
    `impact_metric_value` DECIMAL(18,2) COMMENT 'Quantitative value of the primary impact metric achieved during the reporting period.',
    `indirect_beneficiary_count` STRING COMMENT 'Estimated number of individuals indirectly benefiting from the program (e.g., family members, community members).',
    `investment_amount` DECIMAL(18,2) COMMENT 'Total financial investment committed or allocated to the program in the reporting currency.',
    `investment_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the investment amount.. Valid values are `^[A-Z]{3}$`',
    `last_audit_date` DATE COMMENT 'Date of the most recent external audit or verification of the program.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this program record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date of the most recent program performance review or impact assessment.',
    `living_wage_benchmark_met_flag` BOOLEAN COMMENT 'Indicates whether the program has achieved living wage benchmarks for participating workers as defined by Fair Wage Network or Global Living Wage Coalition standards.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next program performance review or impact assessment.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information about the program not captured in other fields.',
    `partner_ngo_name` STRING COMMENT 'Name of the primary non-governmental organization or non-profit partner collaborating on program delivery.',
    `partner_ngo_type` STRING COMMENT 'Classification of the partner organization type.. Valid values are `international_ngo|local_ngo|community_organization|government_agency|academic_institution`',
    `program_code` STRING COMMENT 'Unique business identifier code for the social impact program used for external reporting and reference.. Valid values are `^[A-Z0-9]{6,12}$`',
    `program_description` STRING COMMENT 'Detailed narrative description of the programs objectives, activities, and intended social impact outcomes.',
    `program_manager_name` STRING COMMENT 'Name of the individual responsible for day-to-day program management and execution.',
    `program_name` STRING COMMENT 'Full name of the social impact or community investment program.',
    `program_status` STRING COMMENT 'Current lifecycle status of the social impact program.. Valid values are `planned|active|on_hold|completed|discontinued`',
    `program_type` STRING COMMENT 'Classification of the social impact program by its primary focus area.. Valid values are `worker_welfare|living_wage|womens_empowerment|community_development|artisan_partnership|education`',
    `region` STRING COMMENT 'Geographic region or province within the country where the program is implemented.',
    `responsible_executive` STRING COMMENT 'Name or title of the executive or senior leader accountable for program oversight and results.',
    `start_date` DATE COMMENT 'Date when the social impact program officially commenced operations.',
    `success_story_summary` STRING COMMENT 'Brief summary of key success stories, testimonials, or qualitative impact evidence from the program.',
    `target_beneficiary_group` STRING COMMENT 'Description of the primary beneficiary population or demographic group targeted by this program (e.g., garment workers, women in supply chain, local artisans, factory communities).',
    `un_sdg_alignment` STRING COMMENT 'Comma-separated list of UN SDG numbers that this program contributes to (e.g., 1, 5, 8, 10 for poverty, gender equality, decent work, reduced inequalities).',
    `wrap_certified_flag` BOOLEAN COMMENT 'Indicates whether participating facilities in the program hold WRAP certification for social compliance.',
    CONSTRAINT pk_social_impact_program PRIMARY KEY(`social_impact_program_id`)
) COMMENT 'Master record for Apparel Fashions social impact and community investment programs including worker welfare initiatives, living wage programs, womens empowerment programs (HERproject), community development grants, and artisan partnership programs. Captures program name, program type, target beneficiary group, geographic scope, partner NGO, investment amount, beneficiary count, and impact metrics. Supports the Social pillar of ESG reporting.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` (
    `esg_disclosure_metric_id` BIGINT COMMENT 'Unique identifier for each ESG disclosure metric record. Primary key for the ESG disclosure metric transactional data.',
    `esg_report_id` BIGINT COMMENT 'Reference to the parent ESG report to which this metric belongs. Links the metric to the specific reporting period and framework.',
    `target_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_target. Business justification: ESG disclosure metrics track progress toward sustainability targets (water reduction, waste diversion, renewable energy %, etc.). The esg_disclosure_metric table currently has embedded target_value an',
    `restated_esg_disclosure_metric_id` BIGINT COMMENT 'Self-referencing FK on esg_disclosure_metric (restated_esg_disclosure_metric_id)',
    `approval_date` DATE COMMENT 'The date on which this metric was approved for disclosure. Marks the completion of internal review and authorization for publication.',
    `approval_status` STRING COMMENT 'The current approval status of the metric value in the disclosure workflow. Tracks the metric through internal review and approval processes before publication.. Valid values are `Draft|Pending Review|Approved|Rejected|Published`',
    `approved_by` STRING COMMENT 'The name or identifier of the person who approved this metric for disclosure. Provides audit trail for governance and accountability.',
    `assurance_level` STRING COMMENT 'The level of external assurance or verification applied to this specific metric. Indicates the degree of third-party validation (limited assurance, reasonable assurance, no assurance, or internal audit only).. Valid values are `Limited|Reasonable|None|Internal`',
    `assurance_provider` STRING COMMENT 'The name of the third-party organization that provided assurance or verification for this metric (e.g., Deloitte, EY, Bureau Veritas). Null if no external assurance was obtained.',
    `baseline_value` DECIMAL(18,2) COMMENT 'The baseline or reference value against which progress is measured. Used for target-based metrics to track improvement over time.',
    `baseline_year` STRING COMMENT 'The year from which the baseline value was established. Provides temporal context for progress tracking and target achievement assessment.',
    `business_unit` STRING COMMENT 'The specific business unit, division, or brand to which this metric applies. Enables segment-level ESG performance tracking and accountability.',
    `calculation_methodology` STRING COMMENT 'Description of the method, formula, or standard used to calculate or derive the metric value. Ensures transparency and reproducibility of ESG metrics.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this metric record was first created in the system. Provides audit trail for data lineage and record lifecycle tracking.',
    `data_quality_flag` STRING COMMENT 'Indicator of the reliability and completeness of the metric data. Flags whether the value is verified actual data, an estimate, modeled projection, or has quality concerns.. Valid values are `Verified|Estimated|Modeled|Incomplete|Pending`',
    `data_source` STRING COMMENT 'The origin system or method from which the metric data was collected (e.g., SAP ERP, Utility Bills, Third-Party Survey, Manual Calculation, IoT Sensors). Important for data lineage and quality assessment.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this metric belongs. Enables year-over-year trend analysis and alignment with financial reporting cycles.',
    `geographic_scope` STRING COMMENT 'The geographic coverage of the metric (e.g., Global, USA, CHN, IND, specific region or facility). Enables location-based analysis and regional compliance reporting.',
    `indicator_type` STRING COMMENT 'The nature of the metric value: quantitative (numeric measurement), qualitative (descriptive assessment), binary (yes/no), or narrative (text explanation).. Valid values are `Quantitative|Qualitative|Binary|Narrative`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this metric record was last updated. Tracks the most recent change to the record for audit and data quality purposes.',
    `materiality_assessment_flag` BOOLEAN COMMENT 'Indicates whether this metric was identified as material through the organizations materiality assessment process. True if the metric is considered material to stakeholders and business impact.',
    `metric_category` STRING COMMENT 'High-level ESG pillar classification of the metric. Categorizes the metric into one of the four primary ESG dimensions.. Valid values are `Environmental|Social|Governance|Economic`',
    `metric_code` STRING COMMENT 'Unique business identifier for the ESG metric. Typically follows the reporting framework standard code (e.g., GRI 305-1, SASB CG-AA-130a.1, TCFD Metrics a).. Valid values are `^[A-Z0-9-]{3,20}$`',
    `metric_name` STRING COMMENT 'Full descriptive name of the ESG metric being reported (e.g., Scope 1 GHG Emissions, Water Consumption, Employee Turnover Rate, Board Diversity Percentage).',
    `metric_subcategory` STRING COMMENT 'Detailed subcategory within the ESG pillar (e.g., Emissions, Water, Waste, Labor Practices, Diversity, Ethics, Supply Chain). Provides granular classification for analytics and benchmarking.',
    `metric_value_numeric` DECIMAL(18,2) COMMENT 'The quantitative value of the ESG metric for the reporting period. Used for numeric metrics such as emissions tonnage, water volume, energy consumption, employee count, incident rates.',
    `metric_value_text` STRING COMMENT 'The qualitative or narrative value of the ESG metric. Used for descriptive metrics, policy statements, or explanatory disclosures that cannot be captured numerically.',
    `notes` STRING COMMENT 'Additional context, explanations, assumptions, or caveats related to this metric. Provides supplementary information that aids interpretation and understanding of the metric value.',
    `previous_reported_value` DECIMAL(18,2) COMMENT 'The originally reported value before restatement. Maintained for audit trail and transparency when metrics are restated.',
    `public_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this metric is publicly disclosed in external reports, websites, or regulatory filings. True if the metric is available to external stakeholders.',
    `rating_agency_submission_flag` BOOLEAN COMMENT 'Indicates whether this metric is submitted to external ESG rating agencies (e.g., MSCI, Sustainalytics, CDP). True if the metric is part of rating agency disclosures.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether reporting of this metric is mandated by regulatory or legal requirements. True if the metric is required by law or regulation (e.g., EU CSRD, SEC climate disclosure).',
    `reporting_framework` STRING COMMENT 'The ESG reporting framework or standard under which this metric is disclosed. Indicates the governing body or standard that defines the metric. [ENUM-REF-CANDIDATE: GRI|SASB|TCFD|CDP|UNGC|IIRC|CDSB|ISO14001|GOTS|OEKO-TEX — 10 candidates stripped; promote to reference product]',
    `reporting_period_end_date` DATE COMMENT 'The end date of the period for which this metric value is reported. Together with start date, defines the complete temporal scope of the metric.',
    `reporting_period_start_date` DATE COMMENT 'The start date of the period for which this metric value is reported. Defines the temporal boundary of the measurement.',
    `responsible_party` STRING COMMENT 'The name or role of the individual or team responsible for collecting, calculating, and reporting this metric. Establishes accountability for data quality and accuracy.',
    `restatement_flag` BOOLEAN COMMENT 'Indicates whether this metric value is a restatement of a previously reported value. True if the metric has been restated due to methodology changes, data corrections, or boundary adjustments.',
    `restatement_reason` STRING COMMENT 'Explanation of why the metric was restated. Provides transparency on changes to previously disclosed values and ensures stakeholder understanding of data revisions.',
    `scope_boundary` STRING COMMENT 'Defines the organizational and operational boundary of the metric (e.g., Company-Owned Operations, Tier 1 Suppliers, Full Supply Chain, Global, Regional). Critical for understanding what entities and activities are included in the measurement.',
    `stakeholder_priority_level` STRING COMMENT 'The priority level assigned to this metric based on stakeholder engagement and materiality assessment. Reflects the importance of the metric to key stakeholder groups.. Valid values are `Critical|High|Medium|Low`',
    `un_sdg_alignment` STRING COMMENT 'The UN Sustainable Development Goals to which this metric contributes (e.g., SDG 12: Responsible Consumption, SDG 13: Climate Action). May list multiple SDGs separated by semicolons.',
    `unit_of_measure` STRING COMMENT 'The unit in which the metric value is expressed (e.g., metric tons CO2e, cubic meters, MWh, percentage, count, USD). Critical for accurate interpretation and comparability of quantitative metrics.',
    `variance_from_target_pct` DECIMAL(18,2) COMMENT 'The percentage variance between the actual metric value and the target value. Positive values indicate over-performance, negative values indicate under-performance. Calculated field for performance tracking.',
    CONSTRAINT pk_esg_disclosure_metric PRIMARY KEY(`esg_disclosure_metric_id`)
) COMMENT 'Transactional record capturing individual quantitative and qualitative ESG metric values reported in each ESG disclosure period. Captures metric name, GRI/SASB/TCFD indicator code, reporting period, value, unit of measure, boundary (company-owned, supply chain), data quality flag, restatement indicator, and assurance level. Serves as the granular data backbone for ESG report compilation and external rating agency submissions (MSCI, Sustainalytics, CDP).';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` (
    `higg_index_assessment_id` BIGINT COMMENT 'Unique identifier for the Higg Index assessment record.',
    `esg_report_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_report. Business justification: Higg Index scores and facility assessments are disclosed in ESG reports as evidence of supply chain sustainability performance. Need to link assessments to the reporting period for aggregation and dis',
    `facility_id` BIGINT COMMENT 'Foreign key linking to sustainability.facility. Business justification: Higg assessments are conducted at facilities. The product already has production_factory_id (cross-domain), but facility_id links to sustainability domains own facility master for in-domain consisten',
    `previous_assessment_higg_index_assessment_id` BIGINT COMMENT 'Reference to the prior year or prior cycle assessment for the same facility or scope, enabling year-over-year performance tracking.',
    `production_factory_id` BIGINT COMMENT 'Reference to the manufacturing facility, distribution center, or operational site being assessed. Applicable for FEM and FSLM modules.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor organization responsible for the assessed facility or operations.',
    `prior_higg_index_assessment_id` BIGINT COMMENT 'Self-referencing FK on higg_index_assessment (prior_higg_index_assessment_id)',
    `action_plan_completion_date` DATE COMMENT 'Actual date when all improvement actions from the action plan were completed and verified.',
    `action_plan_due_date` DATE COMMENT 'Target completion date for the improvement action plan associated with this assessment.',
    `air_emissions_score` DECIMAL(18,2) COMMENT 'Section-level score for air quality management and emissions control practices, expressed as a percentage (0-100). Applicable for FEM assessments.',
    `assessment_language` STRING COMMENT 'Primary language in which the assessment was completed and documented, using ISO 639-1 two-letter language codes.',
    `assessment_number` STRING COMMENT 'Business-facing unique identifier or reference number for the assessment, typically assigned by the Higg platform or internal tracking system.',
    `assessment_scope_description` STRING COMMENT 'Detailed description of the operational, geographic, or organizational boundaries covered by this assessment.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the assessment in the Higg Index workflow.. Valid values are `draft|submitted|under_verification|verified|published|expired`',
    `assessment_year` STRING COMMENT 'The calendar year for which this assessment was conducted, representing the reporting period.',
    `brand_scope` STRING COMMENT 'The brand or business unit within Apparel Fashion for which this assessment applies. Relevant for BRM assessments.',
    `chemicals_score` DECIMAL(18,2) COMMENT 'Section-level score for chemical management, ZDHC compliance, and hazardous substance control, expressed as a percentage (0-100). Applicable for FEM assessments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this assessment record was first created in the system.',
    `data_quality_rating` STRING COMMENT 'Assessment of the completeness, accuracy, and reliability of the data submitted in this assessment, as evaluated by verifiers or internal reviewers.. Valid values are `high|medium|low`',
    `energy_score` DECIMAL(18,2) COMMENT 'Section-level score for energy management and consumption practices, expressed as a percentage (0-100). Applicable for FEM assessments.',
    `health_safety_score` DECIMAL(18,2) COMMENT 'Section-level score for occupational health and safety management systems and practices, expressed as a percentage (0-100). Applicable for FSLM assessments.',
    `higg_platform_code` STRING COMMENT 'Unique identifier assigned by the Higg Index platform for this assessment, used for cross-system reconciliation and data sharing.',
    `improvement_action_plan_status` STRING COMMENT 'Current status of the corrective action plan (CAP) or continuous improvement plan developed in response to assessment findings.. Valid values are `not_started|in_progress|completed|overdue`',
    `labor_practices_score` DECIMAL(18,2) COMMENT 'Section-level score for labor rights, working conditions, and employee welfare practices, expressed as a percentage (0-100). Applicable for FSLM assessments.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this assessment record was last updated or modified.',
    `module_type` STRING COMMENT 'The specific Higg Index module being assessed: Facility Environmental Module (FEM), Facility Social & Labor Module (FSLM), Brand & Retail Module (BRM), Materials Module, or Product Module.. Valid values are `FEM|FSLM|BRM|MATERIALS|PRODUCT`',
    `notes` STRING COMMENT 'Free-text field for additional context, clarifications, or special circumstances related to this assessment.',
    `public_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this assessment has been approved for public disclosure or transparency reporting (True/False).',
    `publication_date` DATE COMMENT 'Date when the verified assessment results were published or made available to stakeholders.',
    `responsible_person_email` STRING COMMENT 'Email address of the individual responsible for this assessment, used for communication and follow-up.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_person_name` STRING COMMENT 'Name of the individual within Apparel Fashion or the supplier organization who is accountable for completing and maintaining this assessment.',
    `self_assessment_score` DECIMAL(18,2) COMMENT 'The overall score achieved during the self-assessment phase, expressed as a percentage (0-100).',
    `submission_date` DATE COMMENT 'Date when the self-assessment was submitted to the Higg Index platform or to Apparel Fashion for review.',
    `verification_body_name` STRING COMMENT 'Name of the accredited third-party organization that conducted or is conducting the verification audit.',
    `verification_date` DATE COMMENT 'Date when the third-party verification was completed and the verified score was finalized.',
    `verification_status` STRING COMMENT 'Current status of the third-party verification process for this assessment.. Valid values are `not_required|pending|in_progress|completed|failed`',
    `verified_score` DECIMAL(18,2) COMMENT 'The final score after third-party verification, expressed as a percentage (0-100). Null if verification has not been completed.',
    `verifier_accreditation_number` STRING COMMENT 'Official accreditation or registration number of the verification body, as recognized by SAC or relevant governing bodies.',
    `waste_score` DECIMAL(18,2) COMMENT 'Section-level score for waste management, recycling, and circular economy practices, expressed as a percentage (0-100). Applicable for FEM assessments.',
    `water_score` DECIMAL(18,2) COMMENT 'Section-level score for water use, wastewater management, and water conservation practices, expressed as a percentage (0-100). Applicable for FEM assessments.',
    CONSTRAINT pk_higg_index_assessment PRIMARY KEY(`higg_index_assessment_id`)
) COMMENT 'Transactional record of Higg Index assessments completed by Apparel Fashion facilities or supply chain partners, covering the Higg Facility Environmental Module (FEM), Facility Social & Labor Module (FSLM), and Brand & Retail Module (BRM). Captures assessment year, module type, facility or brand scope, self-assessment score, verified score, verification body, section-level scores (energy, water, waste, chemicals, air emissions), and improvement action plan status.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` (
    `biodiversity_impact_id` BIGINT COMMENT 'Unique identifier for the biodiversity impact assessment record.',
    `esg_report_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_report. Business justification: Biodiversity assessments are disclosed in ESG reports (TNFD alignment). Need linkage for reporting biodiversity risk, impact mitigation, and restoration programs. N:1 relationship. No bidirectional co',
    `facility_id` BIGINT COMMENT 'Foreign key linking to sustainability.facility. Business justification: Biodiversity assessments are location-based and should link to sustainability.facility for in-domain consistency. Enables leveraging facility master data (certifications, operational status, etc.) and',
    `production_factory_id` BIGINT COMMENT 'Identifier of the facility associated with the biodiversity impact assessment.',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier associated with the assessed location or sourcing activity.',
    `reassessment_of_biodiversity_impact_id` BIGINT COMMENT 'Self-referencing FK on biodiversity_impact (reassessment_of_biodiversity_impact_id)',
    `annual_sourcing_volume` DECIMAL(18,2) COMMENT 'Annual volume of material sourced from this location, measured in metric tons or applicable unit.',
    `assessment_date` DATE COMMENT 'Date when the biodiversity impact assessment was conducted.',
    `assessment_methodology` STRING COMMENT 'Methodology or framework used to conduct the biodiversity impact assessment.',
    `assessment_number` STRING COMMENT 'Business identifier for the biodiversity impact assessment, formatted as BIA-YYYYMMDD.. Valid values are `^BIA-[0-9]{8}$`',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the biodiversity impact assessment.. Valid values are `draft|in_review|approved|published|archived`',
    `assessment_type` STRING COMMENT 'Category of biodiversity impact assessment conducted.. Valid values are `raw_material_sourcing|facility_location|supply_chain_corridor|land_use_change|water_source|product_lifecycle`',
    `assessor_name` STRING COMMENT 'Name of the individual or organization that conducted the biodiversity impact assessment.',
    `biodiversity_offset_area_hectares` DECIMAL(18,2) COMMENT 'Total area of biodiversity offset committed or implemented, measured in hectares.',
    `biodiversity_sensitivity_classification` STRING COMMENT 'Classification of biodiversity sensitivity level based on international conservation designations and risk assessments. [ENUM-REF-CANDIDATE: key_biodiversity_area|ramsar_wetland|unesco_world_heritage|deforestation_risk_zone|high_conservation_value|protected_area|critical_habitat|low_risk — promote to reference product]',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the location of biodiversity impact.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the biodiversity impact assessment record was first created in the system.',
    `deforestation_risk_zone_flag` BOOLEAN COMMENT 'Indicates whether the location is classified as a high-risk deforestation zone.',
    `ecosystem_type` STRING COMMENT 'Classification of the ecosystem type present at the assessed location. [ENUM-REF-CANDIDATE: tropical_rainforest|temperate_forest|grassland|wetland|marine|freshwater|agricultural|urban — 8 candidates stripped; promote to reference product]',
    `iucn_kba_flag` BOOLEAN COMMENT 'Indicates whether the location is within or adjacent to an IUCN-designated Key Biodiversity Area.',
    `iucn_red_list_category` STRING COMMENT 'Highest IUCN Red List threat category among species identified at the assessed location.. Valid values are `critically_endangered|endangered|vulnerable|near_threatened|least_concern|not_assessed`',
    `land_use_change_area_hectares` DECIMAL(18,2) COMMENT 'Total area of land use change measured in hectares associated with this assessment.',
    `land_use_change_impact` STRING COMMENT 'Assessment of the impact level of land use change on local biodiversity.. Valid values are `no_change|low_impact|moderate_impact|high_impact|severe_impact`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the biodiversity impact assessment record was last modified.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the assessed location in decimal degrees.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the assessed location in decimal degrees.',
    `material_category` STRING COMMENT 'Category of raw material being sourced from the assessed location (e.g., cotton, leather, wool, synthetic fiber).',
    `mitigation_effectiveness_rating` STRING COMMENT 'Assessment of the effectiveness of implemented biodiversity mitigation measures.. Valid values are `not_effective|partially_effective|effective|highly_effective|not_assessed`',
    `mitigation_measures_implemented` STRING COMMENT 'Description of biodiversity mitigation measures implemented at the assessed location.',
    `notes` STRING COMMENT 'Additional notes, observations, or context related to the biodiversity impact assessment.',
    `ramsar_wetland_flag` BOOLEAN COMMENT 'Indicates whether the location is within or adjacent to a Ramsar Convention-designated wetland of international importance.',
    `region` STRING COMMENT 'Geographic region or state/province where the biodiversity impact is assessed.',
    `reporting_period_end_date` DATE COMMENT 'End date of the reporting period covered by this biodiversity impact assessment.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the reporting period covered by this biodiversity impact assessment.',
    `restoration_program_enrolled` BOOLEAN COMMENT 'Indicates whether the location is enrolled in a biodiversity restoration or conservation program.',
    `restoration_program_name` STRING COMMENT 'Name of the biodiversity restoration or conservation program in which the location is enrolled.',
    `sourcing_practice_risk_level` STRING COMMENT 'Risk level assessment of sourcing practices at this location with respect to biodiversity impact.. Valid values are `low|medium|high|critical`',
    `sourcing_volume_unit` STRING COMMENT 'Unit of measure for the annual sourcing volume.. Valid values are `metric_tons|kilograms|liters|square_meters|units`',
    `species_at_risk_count` STRING COMMENT 'Number of threatened or endangered species identified in the assessed location.',
    `species_at_risk_list` STRING COMMENT 'Comma-separated list of threatened or endangered species identified in the assessed location.',
    `third_party_verification_flag` BOOLEAN COMMENT 'Indicates whether the biodiversity impact assessment has been verified by an independent third party.',
    `tnfd_disclosure_alignment` BOOLEAN COMMENT 'Indicates whether this biodiversity impact assessment aligns with TNFD (Taskforce on Nature-related Financial Disclosures) reporting requirements.',
    `verification_body_name` STRING COMMENT 'Name of the third-party organization that verified the biodiversity impact assessment.',
    `verification_date` DATE COMMENT 'Date when the third-party verification of the biodiversity impact assessment was completed.',
    CONSTRAINT pk_biodiversity_impact PRIMARY KEY(`biodiversity_impact_id`)
) COMMENT 'Transactional record capturing biodiversity risk and impact assessments for Apparel Fashions raw material sourcing regions and facility locations. Captures location, ecosystem type, biodiversity sensitivity classification (IUCN Key Biodiversity Area, Ramsar wetland, deforestation-risk zone), land use change impact, species at risk, sourcing practice risk level, and mitigation measures. Supports TNFD (Taskforce on Nature-related Financial Disclosures) reporting.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` (
    `carbon_offset_id` BIGINT COMMENT 'Unique identifier for the carbon offset credit record. Primary key for the carbon offset data product.',
    `carbon_target_id` BIGINT COMMENT 'Foreign key reference to the carbon reduction target that this offset credit contributes toward. Links offset purchases to strategic decarbonization goals.',
    `esg_report_id` BIGINT COMMENT 'Foreign key reference to the ESG report in which this carbon offset credit is disclosed or claimed. Supports traceability from offset purchase to public disclosure.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to sustainability.initiative. Business justification: Carbon offsets may be purchased as part of specific sustainability initiatives. Need to track which initiative funded or drove the offset purchase for budget allocation and initiative impact measureme',
    `retired_against_carbon_offset_id` BIGINT COMMENT 'Self-referencing FK on carbon_offset (retired_against_carbon_offset_id)',
    `additionality_verified` BOOLEAN COMMENT 'Indicates whether the offset project has been verified to meet additionality criteria (i.e., emission reductions would not have occurred without the carbon finance). True if verified, False otherwise.',
    `allocation_business_unit` STRING COMMENT 'Business unit, division, or product line to which the carbon offset credits are allocated for internal carbon accounting and cost allocation purposes.',
    `allocation_fiscal_year` STRING COMMENT 'Fiscal year in which the offset credits are allocated to compensate emissions. May differ from vintage year or purchase year.',
    `associated_emission_scope` STRING COMMENT 'GHG Protocol emission scope category that these offset credits are intended to compensate. Supports allocation of offsets to specific emission categories in ESG reporting.. Valid values are `scope_1|scope_2|scope_3|residual_emissions|net_zero_commitment`',
    `certification_standard` STRING COMMENT 'International carbon offset standard under which the credits were verified and issued. Determines credibility and acceptance in voluntary and compliance markets.. Valid values are `gold_standard|vcs_verra|american_carbon_registry|climate_action_reserve|plan_vivo|puro_earth`',
    `co_benefits_description` STRING COMMENT 'Narrative description of additional environmental or social benefits delivered by the project beyond carbon reduction (e.g., biodiversity protection, community employment, water quality improvement).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this carbon offset record was first created in the system. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the purchase transaction. Supports multi-currency financial reporting.. Valid values are `^[A-Z]{3}$`',
    `double_counting_prevention_flag` BOOLEAN COMMENT 'Indicates whether the offset credits are subject to corresponding adjustments or other mechanisms to prevent double counting between jurisdictions or entities. True if safeguards are in place, False otherwise.',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person who last modified this carbon offset record. Supports accountability and audit trail.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this carbon offset record was most recently updated. Supports change tracking and audit trail.',
    `net_zero_claim_eligible` BOOLEAN COMMENT 'Indicates whether these offset credits meet the quality criteria for use in Apparel Fashions net-zero or carbon neutrality claims, per internal policy and external guidance (e.g., SBTi Net-Zero Standard). True if eligible, False otherwise.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or internal comments related to the carbon offset credit purchase or retirement.',
    `offset_project_name` STRING COMMENT 'Full name of the carbon offset project from which credits were purchased. Examples include reforestation initiatives, renewable energy installations, or cookstove distribution programs.',
    `permanence_risk_rating` STRING COMMENT 'Assessment of the risk that carbon sequestered by the project could be reversed (e.g., forest fire, land use change). Particularly relevant for nature-based solutions.. Valid values are `low|medium|high|not_assessed`',
    `project_location_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the carbon offset project is physically located. Supports geographic analysis and co-benefit assessment.. Valid values are `^[A-Z]{3}$`',
    `project_location_region` STRING COMMENT 'Geographic region or state/province where the offset project is located. Provides additional geographic granularity beyond country.',
    `project_type` STRING COMMENT 'Category of carbon offset project methodology. Defines the mechanism by which greenhouse gas reductions or removals are achieved.. Valid values are `reforestation|afforestation|renewable_energy|cookstoves|soil_carbon|methane_capture`',
    `purchase_date` DATE COMMENT 'Date on which Apparel Fashion acquired the carbon offset credits from the project developer or broker.',
    `purchase_order_number` STRING COMMENT 'Internal purchase order number used to procure the carbon offset credits. Links to procurement and accounts payable systems.',
    `purchase_price_per_tco2e` DECIMAL(18,2) COMMENT 'Unit price paid per metric ton of CO2 equivalent for the carbon offset credits. Used for financial accounting and cost analysis.',
    `quantity_tco2e` DECIMAL(18,2) COMMENT 'Total quantity of carbon offset credits purchased or retired, measured in metric tons of carbon dioxide equivalent. Represents the greenhouse gas reduction or removal impact.',
    `registry_serial_number` STRING COMMENT 'Unique serial number assigned by the carbon registry to this specific batch of offset credits. Ensures traceability and prevents double-counting.',
    `retirement_certificate_url` STRING COMMENT 'Web link to the official retirement certificate issued by the carbon registry. Provides proof of retirement for audit and verification purposes.',
    `retirement_date` DATE COMMENT 'Date on which the carbon offset credits were permanently retired in the registry to claim the emission reduction benefit. Retired credits cannot be resold or reused.',
    `retirement_reason` STRING COMMENT 'Business justification or purpose for retiring the carbon offset credits. Examples include annual carbon neutrality claim, product-specific carbon neutral certification, or event offsetting.',
    `retirement_status` STRING COMMENT 'Current lifecycle status of the carbon offset credits. Active credits are held in inventory; retired credits have been claimed against emissions.. Valid values are `active|retired|cancelled|expired`',
    `scope_3_category` STRING COMMENT 'Specific Scope 3 value chain category (e.g., Category 1 Purchased Goods, Category 4 Upstream Transportation) if the offset is allocated to Scope 3 emissions. Null if not Scope 3.',
    `supplier_broker_name` STRING COMMENT 'Name of the carbon credit broker, marketplace, or project developer from whom the credits were purchased.',
    `total_purchase_amount` DECIMAL(18,2) COMMENT 'Total monetary amount paid for the carbon offset credit purchase. Calculated as quantity multiplied by unit price.',
    `un_sdg_alignment` STRING COMMENT 'Comma-separated list of UN SDG numbers (1-17) that the offset project contributes to. Supports integrated ESG reporting and impact measurement.',
    `verification_body_name` STRING COMMENT 'Name of the independent third-party validation and verification body (VVB) that audited the project and certified the emission reductions.',
    `verification_date` DATE COMMENT 'Date on which the verification body completed the audit and issued the verification statement for the emission reductions.',
    `verification_report_url` STRING COMMENT 'Web link to the publicly available verification report or project documentation. Supports transparency and stakeholder due diligence.',
    `vintage_year` STRING COMMENT 'Calendar year in which the greenhouse gas emission reductions or removals occurred. Vintage year affects credit pricing and eligibility for certain programs.',
    CONSTRAINT pk_carbon_offset PRIMARY KEY(`carbon_offset_id`)
) COMMENT 'Master and transactional record for carbon offset credits purchased or retired by Apparel Fashion to compensate for residual GHG emissions. Captures offset project name, project type (reforestation, cookstoves, renewable energy, soil carbon), standard (Gold Standard, VCS/Verra, ACR), vintage year, quantity (tCO2e), registry serial number, retirement date, and associated emission scope. Supports net-zero and carbon neutrality claims.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` (
    `ecolabel_id` BIGINT COMMENT 'Unique identifier for the eco-label or sustainability certification record.',
    `superseded_ecolabel_id` BIGINT COMMENT 'Self-referencing FK on ecolabel (superseded_ecolabel_id)',
    `accreditation_body` STRING COMMENT 'Name of the accreditation organization that validates the issuing body (e.g., International Accreditation Forum, national accreditation bodies).',
    `annual_license_fee_amount` DECIMAL(18,2) COMMENT 'Annual licensing fee amount charged by the issuing body for the right to use this eco-label. Null if no fee is required.',
    `applicable_material_types` STRING COMMENT 'Comma-separated list of material or fiber types eligible for this eco-label (e.g., organic cotton, recycled polyester, Tencel, wool).',
    `applicable_product_categories` STRING COMMENT 'Comma-separated list of product categories or Stock Keeping Unit (SKU) types to which this eco-label can be applied (e.g., apparel, footwear, accessories, home textiles).',
    `approval_date` DATE COMMENT 'Date when Apparel Fashion internally approved this eco-label for use on products and marketing materials.',
    `approved_by` STRING COMMENT 'Name or identifier of the executive or governance body that approved the use of this eco-label within Apparel Fashion.',
    `audit_frequency_months` STRING COMMENT 'Required frequency in months for re-audit or recertification to maintain the eco-label (e.g., 12 for annual, 36 for triennial).',
    `carbon_reduction_claim` STRING COMMENT 'Description of carbon footprint reduction or climate impact claim associated with this eco-label (e.g., 30% lower CO2 emissions vs conventional production).',
    `certification_scope` STRING COMMENT 'Description of what aspects are covered by the certification (e.g., fiber sourcing, manufacturing process, chemical usage, labor practices, carbon footprint).',
    `chain_of_custody_required` BOOLEAN COMMENT 'Indicates whether a documented chain of custody from raw material to finished product is required for this eco-label.',
    `circular_economy_eligible` BOOLEAN COMMENT 'Indicates whether products bearing this eco-label are eligible for circular economy programs such as take-back, recycling, or resale initiatives.',
    `consumer_facing_claim_text` STRING COMMENT 'Approved marketing claim or label text that can be displayed to consumers on product tags, packaging, or digital channels (e.g., Made with Organic Cotton, Certified Recycled Content).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this eco-label record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when the eco-label became valid and available for use on Apparel Fashion products.',
    `environmental_criteria` STRING COMMENT 'Summary of the environmental performance criteria required to earn this eco-label (e.g., reduced water usage, chemical restrictions, renewable energy use, biodegradability).',
    `esg_alignment_goals` STRING COMMENT 'Comma-separated list of United Nations Sustainable Development Goals (UN SDGs) or ESG themes that this eco-label supports (e.g., SDG 12 Responsible Consumption, SDG 13 Climate Action).',
    `expiry_date` DATE COMMENT 'Date when the eco-label is no longer valid or has been superseded by a newer version. Null if the label has no expiration.',
    `geographic_scope` STRING COMMENT 'Geographic applicability of the eco-label indicating whether it is recognized globally, regionally, or only within specific countries.. Valid values are `global|regional|national`',
    `issuing_body_country_code` STRING COMMENT 'Three-letter ISO country code representing the headquarters location of the issuing body.. Valid values are `^[A-Z]{3}$`',
    `issuing_body_name` STRING COMMENT 'Name of the organization or certification body that issues and governs the eco-label (e.g., Textile Exchange, OEKO-TEX Association, Fair Labor Association).',
    `label_code` STRING COMMENT 'Unique alphanumeric code identifying the eco-label or certification standard (e.g., GOTS, OEKO-TEX, BCI, FSC).. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `label_name` STRING COMMENT 'Full official name of the eco-label or sustainability certification (e.g., Global Organic Textile Standard, OEKO-TEX Standard 100).',
    `label_status` STRING COMMENT 'Current lifecycle status of the eco-label indicating whether it is actively used, deprecated, or under review.. Valid values are `active|inactive|deprecated|under_review|suspended`',
    `label_type` STRING COMMENT 'Classification of the eco-label indicating whether it certifies a product, manufacturing process, brand claim, facility, supply chain, or material.. Valid values are `product_certification|process_certification|brand_claim|facility_certification|supply_chain_certification|material_certification`',
    `last_modified_by` STRING COMMENT 'User identifier or system account that last modified this eco-label record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this eco-label record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date when the eco-label record was last reviewed for accuracy, relevance, and compliance with current standards.',
    `license_fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the annual license fee (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `license_fee_required` BOOLEAN COMMENT 'Indicates whether a licensing fee must be paid to the issuing body to use this eco-label on products.',
    `logo_file_path` STRING COMMENT 'File path or storage location of the official eco-label logo image for use in product labeling and marketing materials.',
    `minimum_content_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage of certified or sustainable material required in a product to qualify for this eco-label (e.g., 95% organic cotton for GOTS).',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this eco-label record to ensure ongoing compliance and relevance.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or special instructions related to the use or management of this eco-label.',
    `public_disclosure_required` BOOLEAN COMMENT 'Indicates whether the use of this eco-label requires public disclosure of certification details or audit results.',
    `recognized_countries` STRING COMMENT 'Comma-separated list of three-letter ISO country codes where this eco-label is officially recognized and accepted by regulators and consumers.',
    `regulatory_basis` STRING COMMENT 'Legal or regulatory framework that governs the use of this eco-label (e.g., FTC Green Guides, EU Ecodesign Directive, California Green Chemistry Initiative).',
    `social_criteria` STRING COMMENT 'Summary of social and labor standards required for this eco-label (e.g., fair wages, safe working conditions, no child labor, freedom of association).',
    `usage_guidelines_url` STRING COMMENT 'Web address linking to the official usage guidelines, logo specifications, and compliance requirements for this eco-label.. Valid values are `^https?://.*$`',
    `verification_method` STRING COMMENT 'Method used to verify compliance with the eco-label standard (e.g., third-party audit, laboratory testing, chain of custody documentation).. Valid values are `third_party_audit|self_declaration|chain_of_custody|lab_testing|document_review|site_inspection`',
    `water_stewardship_claim` STRING COMMENT 'Description of water conservation or stewardship claim associated with this eco-label (e.g., reduced water consumption, wastewater treatment standards).',
    CONSTRAINT pk_ecolabel PRIMARY KEY(`ecolabel_id`)
) COMMENT 'Reference master catalog of eco-labels, sustainability certifications, and green claims used on Apparel Fashion products and marketing materials. Captures label name, issuing body, label type (product certification, process certification, brand claim), applicable product categories, consumer-facing claim text, regulatory basis (FTC Green Guides, EU Ecodesign), and usage guidelines. Governs which eco-labels can be applied to which products and under what conditions.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` (
    `scope3_category_id` BIGINT COMMENT 'Unique identifier for the Scope 3 greenhouse gas emission category as defined by the GHG Protocol Corporate Value Chain Standard.',
    `parent_scope3_category_id` BIGINT COMMENT 'Self-referencing FK on scope3_category (parent_scope3_category_id)',
    `applicability_flag` BOOLEAN COMMENT 'Boolean indicator of whether this Scope 3 category is applicable and material to Apparel Fashions business operations and value chain. True indicates the category is relevant and should be tracked; False indicates the category does not apply to the companys activities.',
    `baseline_emissions_mt_co2e` DECIMAL(18,2) COMMENT 'The total greenhouse gas emissions for this category in the baseline year, expressed in metric tons of carbon dioxide equivalent. Serves as the reference point for measuring progress toward reduction targets.',
    `baseline_year` STRING COMMENT 'The reference year against which emission reductions for this category are measured and tracked. Typically aligned with corporate carbon reduction targets and Science Based Targets initiative (SBTi) commitments.',
    `calculation_methodology` STRING COMMENT 'The primary calculation approach used to quantify emissions for this category. Spend-based uses financial data and emission factors; activity-based uses physical quantities; average-data uses industry averages; supplier-specific uses actual supplier data; hybrid combines multiple methods.. Valid values are `spend_based|activity_based|average_data|supplier_specific|hybrid`',
    `calculation_methodology_description` STRING COMMENT 'Detailed explanation of the specific calculation approach, data sources, emission factors, and assumptions used to quantify emissions for this Scope 3 category at Apparel Fashion. Includes references to databases such as DEFRA, EPA, or industry-specific factors.',
    `category_code` STRING COMMENT 'Short alphanumeric code used internally to reference this Scope 3 category in reporting systems and carbon emission records. Typically formatted as S3C01, S3C02, etc.',
    `category_name` STRING COMMENT 'The official name of the Scope 3 emission category as defined by the GHG Protocol. Examples include Purchased Goods and Services, Capital Goods, Fuel and Energy Related Activities, Upstream Transportation and Distribution, Waste Generated in Operations, Business Travel, Employee Commuting, Upstream Leased Assets, Downstream Transportation and Distribution, Processing of Sold Products, Use of Sold Products, End-of-Life Treatment of Sold Products, Downstream Leased Assets, Franchises, and Investments.',
    `category_number` STRING COMMENT 'The official numeric identifier (1-15) assigned to this Scope 3 category by the GHG Protocol Corporate Value Chain Standard. Categories are numbered sequentially from 1 (Purchased Goods and Services) through 15 (Investments).',
    `category_status` STRING COMMENT 'Current status of this category in Apparel Fashions Scope 3 reporting program. Active categories are currently tracked and reported; inactive categories are not applicable to the business; under review categories are being evaluated for materiality.. Valid values are `active|inactive|under_review`',
    `category_type` STRING COMMENT 'Classification indicating whether this category represents upstream or downstream value chain emissions. Upstream categories (1-8) occur before the reporting companys operations; downstream categories (9-15) occur after.. Valid values are `upstream|downstream`',
    `cdp_disclosure_flag` BOOLEAN COMMENT 'Boolean indicator of whether emissions for this category are disclosed in Apparel Fashions annual CDP Climate Change questionnaire response. True indicates the category is included in CDP reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this Scope 3 category record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_collection_approach` STRING COMMENT 'Description of how activity data is collected for this category, including source systems (ERP, PLM, WMS, procurement systems), data collection frequency, responsible parties, and data quality controls. Specific to Apparel Fashions operational systems and supply chain structure.',
    `data_coverage_percentage` DECIMAL(18,2) COMMENT 'The percentage of total activity within this category for which actual data is collected and used in emission calculations, as opposed to estimated or extrapolated data. Higher coverage indicates more accurate and reliable emission quantification.',
    `data_owner_email` STRING COMMENT 'The email address of the data owner responsible for this Scope 3 category. Used for coordination, data quality escalation, and audit inquiries.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `data_owner_name` STRING COMMENT 'The name of the individual or role accountable for the accuracy, completeness, and timeliness of emission data for this category. Serves as the primary contact for data quality issues and methodology questions.',
    `data_quality_tier` STRING COMMENT 'Classification of the typical data quality level achieved for this category based on the GHG Protocol data quality hierarchy. Tier 1 represents supplier-specific primary data; Tier 2 represents secondary data; Tier 3 represents industry averages; Tier 4 represents proxy or estimated data.. Valid values are `tier_1_supplier_specific|tier_2_secondary|tier_3_average|tier_4_proxy`',
    `disclosure_requirement` STRING COMMENT 'Classification of the disclosure expectation for this category based on regulatory requirements, investor expectations, and sustainability reporting frameworks. Mandatory categories must be reported; recommended categories are expected by stakeholders; optional categories may be disclosed for transparency.. Valid values are `mandatory|recommended|optional`',
    `emission_factor_database` STRING COMMENT 'The authoritative database or source used to obtain emission factors for calculating this categorys carbon footprint. Common sources include DEFRA, EPA, Ecoinvent, GaBi, Higg MSI, or industry-specific databases.',
    `emission_factor_version` STRING COMMENT 'The version or publication year of the emission factor database currently in use for this category. Emission factors are updated periodically, and version tracking ensures consistency and auditability of calculations.',
    `gri_standard_reference` STRING COMMENT 'The specific GRI standard and disclosure number to which this Scope 3 category maps for sustainability reporting purposes. Typically references GRI 305: Emissions standard.',
    `industry_specific_guidance` STRING COMMENT 'Reference to apparel and fashion industry-specific calculation guidance, tools, or standards applicable to this category. May include references to Higg Index, Sustainable Apparel Coalition methodologies, or textile-specific emission factor databases.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this Scope 3 category record was most recently updated. Tracks changes to methodology, boundaries, targets, or other category attributes over time.',
    `last_verification_date` DATE COMMENT 'The date when emissions data for this category was most recently verified or assured by a third-party auditor. Used to track assurance currency and plan future verification cycles.',
    `materiality_assessment_date` DATE COMMENT 'The date when the most recent materiality assessment was conducted to determine whether this Scope 3 category is significant to Apparel Fashions carbon footprint and should be included in reporting.',
    `materiality_rationale` STRING COMMENT 'Business justification explaining why this category was determined to be material or immaterial to Apparel Fashions Scope 3 emissions inventory. Includes considerations such as estimated emission magnitude, stakeholder expectations, and strategic relevance.',
    `notes` STRING COMMENT 'Additional context, assumptions, limitations, or special considerations relevant to this Scope 3 category. May include information about data gaps, methodology changes, or category-specific challenges in the apparel supply chain.',
    `primary_data_source_system` STRING COMMENT 'The name of the primary operational system of record from which activity data for this category is extracted. Examples include SAP S/4HANA for procurement data, Manhattan WMS for logistics data, or Centric PLM for product material data.',
    `reduction_target_percentage` DECIMAL(18,2) COMMENT 'The percentage reduction in emissions targeted for this category by the target year, relative to the baseline year. Aligned with Apparel Fashions overall Scope 3 reduction commitments and SBTi validation requirements.',
    `reporting_boundary` STRING COMMENT 'Definition of the organizational and operational boundaries for this category, specifying which entities, facilities, geographies, and activities are included in or excluded from the emission calculations for this category.',
    `reporting_frequency` STRING COMMENT 'The cadence at which emission data for this category is calculated, aggregated, and reported. Frequency may vary by category based on data availability, materiality, and stakeholder requirements.. Valid values are `monthly|quarterly|annual|continuous`',
    `responsible_department` STRING COMMENT 'The internal business function or department responsible for data collection, calculation, and reporting for this Scope 3 category. Examples include Sustainability, Supply Chain, Procurement, Logistics, or Product Development.',
    `sasb_metric_reference` STRING COMMENT 'The specific SASB metric code from the Apparel, Accessories & Footwear industry standard to which this Scope 3 category maps. Used for investor-focused sustainability disclosure.',
    `sbti_alignment_flag` BOOLEAN COMMENT 'Boolean indicator of whether the reduction target for this category is aligned with and validated by the Science Based Targets initiative. True indicates SBTi validation; False indicates internal target only.',
    `supply_chain_tier_coverage` STRING COMMENT 'Description of which tiers of the apparel supply chain are included in this categorys emission calculations. For example, Tier 1 (cut-make-trim facilities), Tier 2 (fabric mills), Tier 3 (fiber producers), Tier 4 (raw material extraction). Critical for understanding supply chain transparency and data collection scope.',
    `target_year` STRING COMMENT 'The year by which the emission reduction target for this category is to be achieved. Typically aligned with corporate sustainability milestones such as 2030 or 2050 net-zero commitments.',
    `tcfd_alignment` STRING COMMENT 'Classification indicating which TCFD pillar this categorys data supports in climate-related financial disclosures. Categories may align with Metrics and Targets, Risk Management, Strategy, or Governance pillars.. Valid values are `metrics_targets|risk_management|strategy|governance|not_applicable`',
    `uncertainty_range_percentage` DECIMAL(18,2) COMMENT 'The estimated uncertainty or margin of error in emission calculations for this category, expressed as a percentage. Reflects data quality, estimation methods, and variability in emission factors. Used for sensitivity analysis and disclosure.',
    `verification_requirement` STRING COMMENT 'Classification indicating the level of external assurance or verification required for emissions data in this category. Third-party verification may be required for regulatory compliance, investor expectations, or SBTi validation.. Valid values are `third_party_required|internal_review|not_required`',
    CONSTRAINT pk_scope3_category PRIMARY KEY(`scope3_category_id`)
) COMMENT 'Reference master defining the 15 Scope 3 GHG emission categories applicable to Apparel Fashion per the GHG Protocol Corporate Value Chain Standard. Captures category number, category name (purchased goods and services, capital goods, fuel and energy, upstream transportation, waste, business travel, employee commuting, upstream leased assets, downstream transportation, processing of sold products, use of sold products, end-of-life treatment, downstream leased assets, franchises, investments), calculation methodology, and data collection approach. Used to classify and aggregate carbon_emission records.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` (
    `initiative_id` BIGINT COMMENT 'Unique identifier for the sustainability initiative record. Primary key.',
    `esg_report_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_report. Business justification: Sustainability initiatives and their progress are disclosed in ESG reports. Need to link initiatives to the report period for stakeholder communication and progress tracking. N:1 relationship. No bidi',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier partner involved in the initiative, if the program is supplier-focused.',
    `parent_initiative_id` BIGINT COMMENT 'Self-referencing FK on initiative (parent_initiative_id)',
    `actual_carbon_reduction_mt_co2e` DECIMAL(18,2) COMMENT 'Measured annual greenhouse gas emissions reduction in metric tons of CO2 equivalent achieved by the initiative, null until verified.',
    `actual_completion_date` DATE COMMENT 'Actual date when the initiative was completed and closed, null if still in progress.',
    `actual_energy_savings_mwh` DECIMAL(18,2) COMMENT 'Measured annual energy consumption reduction in megawatt hours achieved by the initiative, null until verified.',
    `actual_waste_diversion_kg` DECIMAL(18,2) COMMENT 'Measured annual waste diverted from landfill in kilograms achieved by the initiative, null until verified.',
    `actual_water_savings_m3` DECIMAL(18,2) COMMENT 'Measured annual water consumption reduction in cubic meters achieved by the initiative, null until verified.',
    `alignment_to_sbti` BOOLEAN COMMENT 'Indicates whether the initiative contributes to the companys Science Based Targets for climate action.',
    `alignment_to_un_sdg` STRING COMMENT 'Comma-separated list of UN SDG goal numbers that the initiative supports, such as 6,12,13 for Clean Water, Responsible Consumption, and Climate Action.',
    `certification_target` STRING COMMENT 'Name of the sustainability certification or standard the initiative aims to achieve, such as GOTS, OEKO-TEX, or Cradle to Cradle.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sustainability initiative record was first created in the system.',
    `disclosure_date` DATE COMMENT 'Date when the initiative was first publicly disclosed, null if not yet disclosed.',
    `executive_sponsor` STRING COMMENT 'Senior executive providing strategic oversight and budget approval for the initiative.',
    `geographic_scope` STRING COMMENT 'Geographic regions or countries where the initiative is being implemented.',
    `initiative_code` STRING COMMENT 'Externally-known unique business identifier for the sustainability initiative, used for tracking and reporting across systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `initiative_description` STRING COMMENT 'Detailed description of the sustainability initiative, including objectives, scope, and expected outcomes.',
    `initiative_name` STRING COMMENT 'Human-readable name of the sustainability initiative, such as Renewable Energy Transition DC-East or Waterless Dyeing Pilot Program.',
    `initiative_status` STRING COMMENT 'Current lifecycle status of the sustainability initiative in the portfolio management workflow.. Valid values are `planning|approved|in_progress|on_hold|completed|cancelled`',
    `initiative_type` STRING COMMENT 'Classification of the initiative by implementation approach and business function impacted.. Valid values are `operational_efficiency|product_innovation|supply_chain|circular_economy|renewable_energy|waste_reduction`',
    `investment_amount` DECIMAL(18,2) COMMENT 'Total capital and operational expenditure budgeted or required for the initiative.',
    `investment_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the investment amount.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the sustainability initiative record was last updated in the system.',
    `mitigation_plan` STRING COMMENT 'Description of risk mitigation strategies and contingency plans for the initiative.',
    `notes` STRING COMMENT 'Additional comments, lessons learned, or contextual information about the initiative.',
    `on_track_flag` BOOLEAN COMMENT 'Indicates whether the initiative is progressing according to plan and is expected to meet its target completion date and impact goals.',
    `owner` STRING COMMENT 'Name or identifier of the executive or department responsible for delivering the initiative.',
    `priority_level` STRING COMMENT 'Business priority ranking of the initiative relative to other sustainability programs in the portfolio.. Valid values are `critical|high|medium|low`',
    `progress_percentage` DECIMAL(18,2) COMMENT 'Current completion percentage of the initiative, calculated based on milestones achieved or time elapsed.',
    `projected_carbon_reduction_mt_co2e` DECIMAL(18,2) COMMENT 'Estimated annual greenhouse gas emissions reduction in metric tons of CO2 equivalent that the initiative is expected to achieve.',
    `projected_energy_savings_mwh` DECIMAL(18,2) COMMENT 'Estimated annual energy consumption reduction in megawatt hours that the initiative is expected to achieve.',
    `projected_waste_diversion_kg` DECIMAL(18,2) COMMENT 'Estimated annual waste diverted from landfill in kilograms through circular economy or waste reduction programs.',
    `projected_water_savings_m3` DECIMAL(18,2) COMMENT 'Estimated annual water consumption reduction in cubic meters that the initiative is expected to achieve.',
    `public_disclosure_flag` BOOLEAN COMMENT 'Indicates whether the initiative has been publicly disclosed in sustainability reports, press releases, or investor communications.',
    `risk_level` STRING COMMENT 'Assessment of the implementation risk associated with the initiative, considering technical, financial, and operational factors.. Valid values are `low|medium|high|critical`',
    `scope_boundary` STRING COMMENT 'Description of the organizational and operational boundaries covered by the initiative, such as specific facilities, suppliers, or product lines.',
    `start_date` DATE COMMENT 'Date when the sustainability initiative officially commenced or is planned to commence.',
    `sustainability_pillar` STRING COMMENT 'Primary sustainability focus area of the initiative, aligned with ESG (Environmental, Social, and Governance) framework pillars.. Valid values are `climate|water|circularity|chemicals|social|biodiversity`',
    `target_completion_date` DATE COMMENT 'Planned date by which the initiative is expected to achieve its objectives and close.',
    `verification_body` STRING COMMENT 'Name of the third-party organization that conducted verification or assurance of the initiatives impact.',
    `verification_date` DATE COMMENT 'Date when third-party verification of the initiatives impact was completed, null if not yet verified.',
    `verification_status` STRING COMMENT 'Status of third-party verification or assurance of the initiatives impact claims.. Valid values are `not_verified|in_progress|verified|certified`',
    CONSTRAINT pk_initiative PRIMARY KEY(`initiative_id`)
) COMMENT 'Master record for discrete sustainability improvement initiatives and projects undertaken by Apparel Fashion, such as switching to renewable energy at a DC, implementing waterless dyeing at a mill, launching a repair service, or eliminating virgin plastic packaging. Captures initiative name, sustainability pillar (climate, water, circularity, chemicals, social), owner, start date, target completion date, investment required, projected impact (tCO2e saved, liters water saved), actual impact achieved, and status. Enables portfolio management of sustainability programs.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`initiative_carbon_contribution` (
    `initiative_carbon_contribution_id` BIGINT COMMENT 'Unique identifier for this initiative-to-carbon-target contribution record. Primary key.',
    `carbon_target_id` BIGINT COMMENT 'Foreign key linking to the carbon reduction target that this initiative is aligned with and contributing toward.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to the sustainability initiative that is contributing carbon reduction toward the target.',
    `actual_carbon_reduction_mt_co2e` DECIMAL(18,2) COMMENT 'Measured annual greenhouse gas emissions reduction in metric tons of CO2 equivalent that this specific initiative has actually delivered toward this specific carbon target, based on verified measurement and reporting.',
    `alignment_end_date` DATE COMMENT 'Date when this initiatives contribution to this carbon target ended or is planned to end. Null if the alignment is ongoing. Supports historical tracking of initiative-target relationships.',
    `alignment_start_date` DATE COMMENT 'Date when this initiative was formally aligned to contribute toward this carbon target. Enables tracking of when initiatives were added to target portfolios.',
    `allocation_methodology` STRING COMMENT 'Description of the methodology used to allocate this initiatives carbon reduction to this specific target (e.g., direct attribution - initiative exclusively serves this target, proportional allocation based on scope coverage, financial allocation based on investment split).',
    `contribution_percentage` DECIMAL(18,2) COMMENT 'The percentage of this initiatives total carbon reduction impact that is allocated to this specific carbon target. Enables initiatives to contribute proportionally to multiple targets (e.g., 60% to Scope 1+2 target, 40% to Scope 3 target).',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this contribution record was created in the system.',
    `last_updated_by` STRING COMMENT 'User or system that last updated this contribution record.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp when this contribution record was last updated.',
    `notes` STRING COMMENT 'Additional notes on this initiative-target contribution relationship, including assumptions, exclusions, measurement challenges, or special circumstances affecting the carbon accounting.',
    `projected_carbon_reduction_mt_co2e` DECIMAL(18,2) COMMENT 'Estimated annual greenhouse gas emissions reduction in metric tons of CO2 equivalent that this specific initiative is projected to contribute toward this specific carbon target. This is the initiatives allocated contribution to the target, which may differ from the initiatives total projected impact if the initiative contributes to multiple targets.',
    `reporting_year` STRING COMMENT 'The calendar or fiscal year for which this contribution is being reported. Enables year-over-year tracking of initiative contributions to targets.',
    `verification_date` DATE COMMENT 'Date when the carbon reduction contribution was last verified or validated by internal or external auditors.',
    `verification_status` STRING COMMENT 'Current verification status of this initiatives carbon reduction contribution to this target. Values: unverified (initial estimate), internal_review (under internal audit), third_party_verified (validated by external auditor), sbti_approved (approved by Science Based Targets initiative), disputed (under review due to measurement concerns).',
    `created_by` STRING COMMENT 'User or system that created this initiative-target contribution record.',
    CONSTRAINT pk_initiative_carbon_contribution PRIMARY KEY(`initiative_carbon_contribution_id`)
) COMMENT 'This association product represents the contribution relationship between sustainability initiatives and carbon reduction targets. It captures the quantified carbon impact that each initiative delivers toward specific corporate carbon targets, enabling portfolio-level carbon accounting, SBTi reporting, CDP disclosure, and progress tracking against science-based targets. Each record links one sustainability initiative to one carbon target with projected and actual carbon reduction metrics, contribution percentages, verification status, and timeline alignment.. Existence Justification: In apparel fashion sustainability operations, initiatives frequently contribute to multiple carbon targets simultaneously (e.g., a renewable energy initiative contributes to both Scope 1+2 absolute target and intensity-based target), and carbon targets are achieved through portfolios of multiple initiatives. Sustainability teams actively manage these initiative-to-target alignments for SBTi reporting, CDP disclosure, and board-level carbon accounting, tracking projected vs. actual contributions, verification status, and allocation percentages for each initiative-target pair.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sustainability`.`facility` (
    `facility_id` BIGINT COMMENT 'Primary key for facility',
    `parent_facility_id` BIGINT COMMENT 'Self-referencing FK on facility (parent_facility_id)',
    `address_line_1` STRING COMMENT 'Primary street address of the facility including building number and street name.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, floor, or building designation.',
    `annual_carbon_emissions_tonnes` DECIMAL(18,2) COMMENT 'Total annual carbon dioxide equivalent emissions produced by the facility measured in metric tonnes, used for carbon footprint tracking.',
    `annual_energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Total annual energy consumption by the facility measured in megawatt hours, used for energy efficiency tracking.',
    `annual_water_consumption_cubic_meters` DECIMAL(18,2) COMMENT 'Total annual water consumption by the facility measured in cubic meters, critical for water stewardship reporting.',
    `bluesign_certified` BOOLEAN COMMENT 'Indicates whether the facility is certified under Bluesign system for sustainable textile production.',
    `certification_status` STRING COMMENT 'Current status of sustainability and compliance certifications for the facility.',
    `chemical_management_system_implemented` BOOLEAN COMMENT 'Indicates whether the facility has implemented a chemical inventory and management system aligned with ZDHC guidelines.',
    `city` STRING COMMENT 'City or municipality where the facility is located.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country where the facility operates.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the facility record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date when the facility was or is planned to be decommissioned and cease operations.',
    `email_address` STRING COMMENT 'Primary email contact for facility operations and communications.',
    `employee_count` STRING COMMENT 'Total number of employees working at the facility, used for labor compliance and social responsibility reporting.',
    `facility_code` STRING COMMENT 'Externally-known unique business identifier for the facility used across supply chain systems and partner communications.',
    `facility_name` STRING COMMENT 'Official registered name of the manufacturing, distribution, or retail facility.',
    `facility_type` STRING COMMENT 'Classification of the facility based on its primary operational function within the apparel supply chain.',
    `fair_trade_certified` BOOLEAN COMMENT 'Indicates whether the facility is certified under Fair Trade standards for ethical labor practices.',
    `hazardous_waste_generated_tonnes` DECIMAL(18,2) COMMENT 'Annual quantity of hazardous waste generated by the facility measured in metric tonnes, required for environmental compliance reporting.',
    `higg_index_score` DECIMAL(18,2) COMMENT 'Higg Index score measuring the facilitys environmental and social performance, ranging from 0 to 100.',
    `iso_14001_certified` BOOLEAN COMMENT 'Indicates whether the facility holds ISO 14001 environmental management system certification.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance or sustainability audit conducted at the facility.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the facility record was last updated in the system.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the facility location for mapping and logistics optimization.',
    `leed_certification_level` STRING COMMENT 'LEED green building certification level achieved by the facility, indicating environmental design and construction standards.',
    `living_wage_compliant` BOOLEAN COMMENT 'Indicates whether the facility pays workers a living wage as defined by local living wage benchmarks.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the facility location for mapping and logistics optimization.',
    `next_audit_scheduled_date` DATE COMMENT 'Scheduled date for the next compliance or sustainability audit at the facility.',
    `operational_start_date` DATE COMMENT 'Date when the facility commenced operations, used for lifecycle tracking and depreciation calculations.',
    `operational_status` STRING COMMENT 'Current operational state of the facility in its lifecycle.',
    `ownership_type` STRING COMMENT 'Legal ownership structure of the facility indicating the business relationship model.',
    `phone_number` STRING COMMENT 'Primary contact telephone number for the facility.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the facility address.',
    `production_capacity_units_per_month` STRING COMMENT 'Maximum monthly production capacity of the facility measured in units, applicable to manufacturing facilities.',
    `renewable_energy_percentage` DECIMAL(18,2) COMMENT 'Percentage of total energy consumption sourced from renewable energy sources, ranging from 0 to 100.',
    `state_province` STRING COMMENT 'State, province, or administrative region of the facility location.',
    `tier_level` STRING COMMENT 'Position of the facility within the apparel supply chain hierarchy, where Tier 1 is final assembly and higher tiers are upstream suppliers.',
    `total_area_sqm` DECIMAL(18,2) COMMENT 'Total physical area of the facility measured in square meters, used for capacity planning and environmental impact calculations.',
    `waste_diversion_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of total waste diverted from landfills through recycling, composting, or circular economy programs, ranging from 0 to 100.',
    `wastewater_treatment_compliant` BOOLEAN COMMENT 'Indicates whether the facility meets local and international wastewater treatment standards.',
    CONSTRAINT pk_facility PRIMARY KEY(`facility_id`)
) COMMENT 'Master reference table for facility. Referenced by facility_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ADD CONSTRAINT `fk_sustainability_esg_report_previous_report_esg_report_id` FOREIGN KEY (`previous_report_esg_report_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ADD CONSTRAINT `fk_sustainability_esg_report_prior_period_esg_report_id` FOREIGN KEY (`prior_period_esg_report_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_carbon_target_id` FOREIGN KEY (`carbon_target_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_target`(`carbon_target_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_scope3_category_id` FOREIGN KEY (`scope3_category_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`scope3_category`(`scope3_category_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_corrected_carbon_emission_id` FOREIGN KEY (`corrected_carbon_emission_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_emission`(`carbon_emission_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ADD CONSTRAINT `fk_sustainability_carbon_target_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ADD CONSTRAINT `fk_sustainability_carbon_target_superseded_carbon_target_id` FOREIGN KEY (`superseded_carbon_target_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_target`(`carbon_target_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ADD CONSTRAINT `fk_sustainability_sustainable_material_derived_from_sustainable_material_id` FOREIGN KEY (`derived_from_sustainable_material_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ADD CONSTRAINT `fk_sustainability_material_certification_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ADD CONSTRAINT `fk_sustainability_material_certification_renewed_material_certification_id` FOREIGN KEY (`renewed_material_certification_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`material_certification`(`material_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ADD CONSTRAINT `fk_sustainability_circular_program_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ADD CONSTRAINT `fk_sustainability_circular_program_predecessor_circular_program_id` FOREIGN KEY (`predecessor_circular_program_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`circular_program`(`circular_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ADD CONSTRAINT `fk_sustainability_circular_enrollment_circular_program_id` FOREIGN KEY (`circular_program_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`circular_program`(`circular_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ADD CONSTRAINT `fk_sustainability_circular_enrollment_renewed_circular_enrollment_id` FOREIGN KEY (`renewed_circular_enrollment_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`circular_enrollment`(`circular_enrollment_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ADD CONSTRAINT `fk_sustainability_environmental_impact_revised_environmental_impact_id` FOREIGN KEY (`revised_environmental_impact_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`environmental_impact`(`environmental_impact_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ADD CONSTRAINT `fk_sustainability_water_usage_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`facility`(`facility_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ADD CONSTRAINT `fk_sustainability_water_usage_corrected_water_usage_id` FOREIGN KEY (`corrected_water_usage_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`water_usage`(`water_usage_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`facility`(`facility_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_renewable_energy_certificate_id` FOREIGN KEY (`renewable_energy_certificate_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate`(`renewable_energy_certificate_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_corrected_energy_consumption_id` FOREIGN KEY (`corrected_energy_consumption_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`energy_consumption`(`energy_consumption_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_corrected_waste_record_id` FOREIGN KEY (`corrected_waste_record_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`waste_record`(`waste_record_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ADD CONSTRAINT `fk_sustainability_supplier_esg_assessment_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ADD CONSTRAINT `fk_sustainability_supplier_esg_assessment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`facility`(`facility_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ADD CONSTRAINT `fk_sustainability_supplier_esg_assessment_prior_supplier_esg_assessment_id` FOREIGN KEY (`prior_supplier_esg_assessment_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment`(`supplier_esg_assessment_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ADD CONSTRAINT `fk_sustainability_traceability_record_prior_traceability_record_id` FOREIGN KEY (`prior_traceability_record_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`traceability_record`(`traceability_record_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ADD CONSTRAINT `fk_sustainability_packaging_sustainability_replacement_packaging_packaging_sustainability_id` FOREIGN KEY (`replacement_packaging_packaging_sustainability_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability`(`packaging_sustainability_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ADD CONSTRAINT `fk_sustainability_packaging_sustainability_superseded_packaging_sustainability_id` FOREIGN KEY (`superseded_packaging_sustainability_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability`(`packaging_sustainability_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ADD CONSTRAINT `fk_sustainability_target_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ADD CONSTRAINT `fk_sustainability_target_superseded_target_id` FOREIGN KEY (`superseded_target_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ADD CONSTRAINT `fk_sustainability_chemical_compliance_superseded_chemical_compliance_id` FOREIGN KEY (`superseded_chemical_compliance_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`chemical_compliance`(`chemical_compliance_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ADD CONSTRAINT `fk_sustainability_renewable_energy_certificate_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ADD CONSTRAINT `fk_sustainability_renewable_energy_certificate_bundled_from_renewable_energy_certificate_id` FOREIGN KEY (`bundled_from_renewable_energy_certificate_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate`(`renewable_energy_certificate_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ADD CONSTRAINT `fk_sustainability_social_impact_program_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ADD CONSTRAINT `fk_sustainability_social_impact_program_predecessor_social_impact_program_id` FOREIGN KEY (`predecessor_social_impact_program_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`social_impact_program`(`social_impact_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ADD CONSTRAINT `fk_sustainability_esg_disclosure_metric_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ADD CONSTRAINT `fk_sustainability_esg_disclosure_metric_target_id` FOREIGN KEY (`target_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ADD CONSTRAINT `fk_sustainability_esg_disclosure_metric_restated_esg_disclosure_metric_id` FOREIGN KEY (`restated_esg_disclosure_metric_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric`(`esg_disclosure_metric_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ADD CONSTRAINT `fk_sustainability_higg_index_assessment_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ADD CONSTRAINT `fk_sustainability_higg_index_assessment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`facility`(`facility_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ADD CONSTRAINT `fk_sustainability_higg_index_assessment_previous_assessment_higg_index_assessment_id` FOREIGN KEY (`previous_assessment_higg_index_assessment_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment`(`higg_index_assessment_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ADD CONSTRAINT `fk_sustainability_higg_index_assessment_prior_higg_index_assessment_id` FOREIGN KEY (`prior_higg_index_assessment_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment`(`higg_index_assessment_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ADD CONSTRAINT `fk_sustainability_biodiversity_impact_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ADD CONSTRAINT `fk_sustainability_biodiversity_impact_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`facility`(`facility_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ADD CONSTRAINT `fk_sustainability_biodiversity_impact_reassessment_of_biodiversity_impact_id` FOREIGN KEY (`reassessment_of_biodiversity_impact_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact`(`biodiversity_impact_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ADD CONSTRAINT `fk_sustainability_carbon_offset_carbon_target_id` FOREIGN KEY (`carbon_target_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_target`(`carbon_target_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ADD CONSTRAINT `fk_sustainability_carbon_offset_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ADD CONSTRAINT `fk_sustainability_carbon_offset_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ADD CONSTRAINT `fk_sustainability_carbon_offset_retired_against_carbon_offset_id` FOREIGN KEY (`retired_against_carbon_offset_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_offset`(`carbon_offset_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ADD CONSTRAINT `fk_sustainability_ecolabel_superseded_ecolabel_id` FOREIGN KEY (`superseded_ecolabel_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`ecolabel`(`ecolabel_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ADD CONSTRAINT `fk_sustainability_scope3_category_parent_scope3_category_id` FOREIGN KEY (`parent_scope3_category_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`scope3_category`(`scope3_category_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ADD CONSTRAINT `fk_sustainability_initiative_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ADD CONSTRAINT `fk_sustainability_initiative_parent_initiative_id` FOREIGN KEY (`parent_initiative_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative_carbon_contribution` ADD CONSTRAINT `fk_sustainability_initiative_carbon_contribution_carbon_target_id` FOREIGN KEY (`carbon_target_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_target`(`carbon_target_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative_carbon_contribution` ADD CONSTRAINT `fk_sustainability_initiative_carbon_contribution_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`facility` ADD CONSTRAINT `fk_sustainability_facility_parent_facility_id` FOREIGN KEY (`parent_facility_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`facility`(`facility_id`);

-- ========= TAGS =========
ALTER SCHEMA `apparel_fashion_ecm`.`sustainability` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `apparel_fashion_ecm`.`sustainability` SET TAGS ('dbx_domain' = 'sustainability');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` SET TAGS ('dbx_subdomain' = 'governance_reporting');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `esg_report_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Report Identifier');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `previous_report_esg_report_id` SET TAGS ('dbx_business_glossary_term' = 'Previous ESG Report Identifier');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `prior_period_esg_report_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `assurance_provider` SET TAGS ('dbx_business_glossary_term' = 'Assurance Provider');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `assurance_standard` SET TAGS ('dbx_business_glossary_term' = 'Assurance Standard');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `assurance_status` SET TAGS ('dbx_business_glossary_term' = 'Assurance Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `assurance_status` SET TAGS ('dbx_value_regex' = 'Not Assured|Limited Assurance|Reasonable Assurance|In Progress');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `consolidation_approach` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Approach');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `consolidation_approach` SET TAGS ('dbx_value_regex' = 'Operational Control|Financial Control|Equity Share|Full Consolidation');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `disclosure_level` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Level');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `disclosure_level` SET TAGS ('dbx_value_regex' = 'Core|Comprehensive|Partial|Voluntary|Mandatory');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document Format');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `document_format` SET TAGS ('dbx_value_regex' = 'PDF|HTML|XBRL|Interactive|Multi-Format');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `gri_content_index_included` SET TAGS ('dbx_business_glossary_term' = 'Global Reporting Initiative (GRI) Content Index Included');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `materiality_assessment_conducted` SET TAGS ('dbx_business_glossary_term' = 'Materiality Assessment Conducted');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `report_language` SET TAGS ('dbx_business_glossary_term' = 'Report Language');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `report_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'ESG Report Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `report_number` SET TAGS ('dbx_value_regex' = '^ESG-[0-9]{4}-[0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'ESG Report Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'Draft|Under Review|Approved|Published|Archived|Withdrawn');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `report_title` SET TAGS ('dbx_business_glossary_term' = 'ESG Report Title');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'ESG Report Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'Annual|Biannual|Quarterly|Ad-Hoc|Integrated');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `report_url` SET TAGS ('dbx_business_glossary_term' = 'Report Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `report_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_business_glossary_term' = 'ESG Reporting Framework');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `restatement_explanation` SET TAGS ('dbx_business_glossary_term' = 'Restatement Explanation');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `restatement_flag` SET TAGS ('dbx_business_glossary_term' = 'Restatement Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `sasb_index_included` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Accounting Standards Board (SASB) Index Included');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `scope_boundary_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Boundary Description');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `stakeholder_engagement_conducted` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Engagement Conducted');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `tcfd_alignment` SET TAGS ('dbx_business_glossary_term' = 'Task Force on Climate-related Financial Disclosures (TCFD) Alignment');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `un_sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'United Nations Sustainable Development Goals (UN SDG) Alignment');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_report` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` SET TAGS ('dbx_subdomain' = 'environmental_operations');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `carbon_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `carbon_target_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Target Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `esg_report_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Report Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `scope3_category_id` SET TAGS ('dbx_business_glossary_term' = 'Scope3 Category Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `corrected_carbon_emission_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `activity_data_unit` SET TAGS ('dbx_business_glossary_term' = 'Activity Data Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `activity_data_value` SET TAGS ('dbx_business_glossary_term' = 'Activity Data Value');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `biogenic_emission_flag` SET TAGS ('dbx_business_glossary_term' = 'Biogenic Emission Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'Direct Measurement|Emission Factor|Mass Balance|Supplier-Specific|Industry Average|Spend-Based');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `cdp_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Carbon Disclosure Project (CDP) Disclosure Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `ch4_quantity_kg` SET TAGS ('dbx_business_glossary_term' = 'Methane (CH4) Quantity in Kilograms');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `co2_quantity_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide (CO2) Quantity in Kilograms');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `co2e_quantity_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) Quantity in Kilograms');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `emission_date` SET TAGS ('dbx_business_glossary_term' = 'Emission Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `emission_event_number` SET TAGS ('dbx_business_glossary_term' = 'Emission Event Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `emission_event_number` SET TAGS ('dbx_value_regex' = '^CE-[0-9]{10}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `emission_factor_source` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Source');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `emission_factor_value` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Value');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `emission_factor_version` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Version');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `emission_scope` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emission Scope');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `emission_scope` SET TAGS ('dbx_value_regex' = 'Scope 1|Scope 2|Scope 3');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `emission_source_identifier` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Identifier');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `emission_source_name` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `emission_source_type` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `geographic_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `geographic_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `n2o_quantity_kg` SET TAGS ('dbx_business_glossary_term' = 'Nitrous Oxide (N2O) Quantity in Kilograms');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Emission Record Notes');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `offset_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Applied Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `offset_project_identifier` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Project Identifier');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `offset_quantity_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Quantity in Kilograms CO2e');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `other_ghg_quantity_kg` SET TAGS ('dbx_business_glossary_term' = 'Other Greenhouse Gas (GHG) Quantity in Kilograms');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `renewable_energy_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `science_based_target_alignment` SET TAGS ('dbx_business_glossary_term' = 'Science-Based Target (SBT) Alignment Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'Unverified|Internal Review|Third-Party Verified|Certified');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ALTER COLUMN `verifier_organization` SET TAGS ('dbx_business_glossary_term' = 'Verifier Organization');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` SET TAGS ('dbx_subdomain' = 'governance_reporting');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `carbon_target_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Target ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `esg_report_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Report Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `superseded_carbon_target_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `assurance_level` SET TAGS ('dbx_business_glossary_term' = 'Assurance Level');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `assurance_level` SET TAGS ('dbx_value_regex' = 'limited|reasonable|none');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `assurance_provider` SET TAGS ('dbx_business_glossary_term' = 'Assurance Provider');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `baseline_emissions_mt_co2e` SET TAGS ('dbx_business_glossary_term' = 'Baseline Emissions (Metric Tons CO2e)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `baseline_intensity_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Intensity Value');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `baseline_year` SET TAGS ('dbx_business_glossary_term' = 'Baseline Year');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `board_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Board Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `boundary_description` SET TAGS ('dbx_business_glossary_term' = 'Boundary Description');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `current_emissions_mt_co2e` SET TAGS ('dbx_business_glossary_term' = 'Current Emissions (Metric Tons CO2e)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `current_year` SET TAGS ('dbx_business_glossary_term' = 'Current Year');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `external_assurance_flag` SET TAGS ('dbx_business_glossary_term' = 'External Assurance Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `intensity_metric` SET TAGS ('dbx_business_glossary_term' = 'Intensity Metric');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `intensity_metric` SET TAGS ('dbx_value_regex' = 'revenue|unit_produced|square_meter|employee|none');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `last_assurance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assurance Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `methodology_notes` SET TAGS ('dbx_business_glossary_term' = 'Methodology Notes');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `on_track_flag` SET TAGS ('dbx_business_glossary_term' = 'On Track Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `progress_percentage` SET TAGS ('dbx_business_glossary_term' = 'Progress Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `public_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `responsible_executive` SET TAGS ('dbx_business_glossary_term' = 'Responsible Executive');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `sbti_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Science Based Targets initiative (SBTi) Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `sbti_commitment_letter_date` SET TAGS ('dbx_business_glossary_term' = 'Science Based Targets initiative (SBTi) Commitment Letter Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `sbti_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Science Based Targets initiative (SBTi) Validation Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `sbti_validation_status` SET TAGS ('dbx_value_regex' = 'not_submitted|under_review|approved|rejected|expired');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `scope_3_category_coverage` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category Coverage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `scope_coverage` SET TAGS ('dbx_business_glossary_term' = 'Scope Coverage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `scope_coverage` SET TAGS ('dbx_value_regex' = 'scope_1|scope_2|scope_3|scope_1_2|scope_1_2_3');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `target_emissions_mt_co2e` SET TAGS ('dbx_business_glossary_term' = 'Target Emissions (Metric Tons CO2e)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `target_intensity_value` SET TAGS ('dbx_business_glossary_term' = 'Target Intensity Value');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `target_name` SET TAGS ('dbx_business_glossary_term' = 'Target Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `target_reduction_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Reduction Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `target_status` SET TAGS ('dbx_business_glossary_term' = 'Target Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `target_status` SET TAGS ('dbx_value_regex' = 'draft|active|achieved|expired|retired|superseded');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `target_type` SET TAGS ('dbx_business_glossary_term' = 'Target Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `target_type` SET TAGS ('dbx_value_regex' = 'absolute|intensity');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `target_year` SET TAGS ('dbx_business_glossary_term' = 'Target Year');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `temperature_alignment` SET TAGS ('dbx_business_glossary_term' = 'Temperature Alignment');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `temperature_alignment` SET TAGS ('dbx_value_regex' = '1_5_degrees|well_below_2_degrees|2_degrees|not_aligned');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_target` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` SET TAGS ('dbx_subdomain' = 'circular_economy');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `sustainable_material_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Material ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `derived_from_sustainable_material_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `biodegradable_flag` SET TAGS ('dbx_business_glossary_term' = 'Biodegradable Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `carbon_footprint_kg_co2e` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint (kg CO2e)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `chemical_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Chemical Compliance Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `chemical_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|restricted');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `circular_economy_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Circular Economy Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `color_fastness_rating` SET TAGS ('dbx_business_glossary_term' = 'Color Fastness Rating');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `color_fastness_rating` SET TAGS ('dbx_value_regex' = 'grade_1|grade_2|grade_3|grade_4|grade_5');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `esg_score` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Score');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `fiber_composition` SET TAGS ('dbx_business_glossary_term' = 'Fiber Composition');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `fiber_type` SET TAGS ('dbx_business_glossary_term' = 'Fiber Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `material_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `material_name` SET TAGS ('dbx_business_glossary_term' = 'Material Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `material_status` SET TAGS ('dbx_business_glossary_term' = 'Material Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `material_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|discontinued|restricted');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `material_weight_gsm` SET TAGS ('dbx_business_glossary_term' = 'Material Weight (GSM)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `material_width_cm` SET TAGS ('dbx_business_glossary_term' = 'Material Width (cm)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `organic_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Organic Content Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `recycled_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Recycled Content Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `renewable_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Source Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `shrinkage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Shrinkage Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `sustainability_attribute` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Attribute');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `traceability_tier` SET TAGS ('dbx_business_glossary_term' = 'Traceability Tier');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `traceability_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|full_chain');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|meter|yard|square_meter|roll|piece');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ALTER COLUMN `water_consumption_liters` SET TAGS ('dbx_business_glossary_term' = 'Water Consumption (Liters)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` SET TAGS ('dbx_subdomain' = 'circular_economy');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `material_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Certification Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `sustainable_material_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `renewed_material_certification_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Audit Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `audit_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `certification_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Certification Cost Amount');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `certification_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `certification_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Certification Cost Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `certification_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `certification_document_url` SET TAGS ('dbx_business_glossary_term' = 'Certification Document Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `certification_scope` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `certification_standard_code` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending_renewal|under_review');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `certification_version` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard Version');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `certified_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Certified Content Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `certified_product_category` SET TAGS ('dbx_business_glossary_term' = 'Certified Product Category');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `certifying_body_accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body Accreditation Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `certifying_body_name` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `chain_of_custody_tc_number` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Transaction Certificate (TC) Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `compliance_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verification Method');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `compliance_verification_method` SET TAGS ('dbx_value_regex' = 'on_site_audit|document_review|laboratory_testing|remote_assessment|hybrid');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `is_multi_site_certification` SET TAGS ('dbx_business_glossary_term' = 'Multi-Site Certification Indicator');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Issue Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `material_origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Material Origin Country Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `material_origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `non_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Notes');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `public_verification_url` SET TAGS ('dbx_business_glossary_term' = 'Public Verification Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Renewal Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Email Address');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ALTER COLUMN `test_report_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Report Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` SET TAGS ('dbx_subdomain' = 'circular_economy');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `circular_program_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Program ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `esg_report_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Report Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `predecessor_circular_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `carbon_reduction_target_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Reduction Target (kg CO2e)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `certification_standard` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `circular_program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `collection_method` SET TAGS ('dbx_value_regex' = 'in-store_dropoff|mail-in|home_pickup|partner_location|digital_trade-in');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `customer_eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Customer Eligibility Criteria');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `customer_participation_target` SET TAGS ('dbx_business_glossary_term' = 'Customer Participation Target');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `diversion_target_quantity` SET TAGS ('dbx_business_glossary_term' = 'Diversion Target Quantity');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `diversion_target_unit` SET TAGS ('dbx_business_glossary_term' = 'Diversion Target Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `diversion_target_unit` SET TAGS ('dbx_value_regex' = 'units|kg|tonnes|lbs');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `eligible_product_categories` SET TAGS ('dbx_business_glossary_term' = 'Eligible Product Categories');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `esg_alignment_goals` SET TAGS ('dbx_business_glossary_term' = 'Environmental, Social, and Governance (ESG) Alignment Goals');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `incentive_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Incentive Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `incentive_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `incentive_type` SET TAGS ('dbx_business_glossary_term' = 'Incentive Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `incentive_type` SET TAGS ('dbx_value_regex' = 'discount_voucher|loyalty_points|store_credit|cash_refund|donation|none');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `incentive_value` SET TAGS ('dbx_business_glossary_term' = 'Incentive Value');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `marketing_campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `material_recovery_rate_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Material Recovery Rate Target Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `minimum_item_condition` SET TAGS ('dbx_business_glossary_term' = 'Minimum Item Condition');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `minimum_item_condition` SET TAGS ('dbx_value_regex' = 'any|gently_used|good|like_new');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `modified_by` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `participating_channels` SET TAGS ('dbx_business_glossary_term' = 'Participating Channels');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `processing_partner` SET TAGS ('dbx_business_glossary_term' = 'Processing Partner');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `processing_partner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `program_owner` SET TAGS ('dbx_business_glossary_term' = 'Program Owner');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `program_owner` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'planning|pilot|active|paused|discontinued');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'take-back|resale|rental|repair|upcycling|recycling');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annual|annual');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions URL');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_program` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` SET TAGS ('dbx_subdomain' = 'circular_economy');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `circular_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Enrollment ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `circular_program_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Program Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Facility ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `renewed_circular_enrollment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `carbon_offset_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset (Kilograms CO2e)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `certification_reference` SET TAGS ('dbx_business_glossary_term' = 'Certification Reference');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `collection_method` SET TAGS ('dbx_value_regex' = 'drop-off|mail-in|pickup|event|partner-site');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `customer_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Consent Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `diversion_outcome` SET TAGS ('dbx_business_glossary_term' = 'Diversion Outcome');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `diversion_outcome` SET TAGS ('dbx_value_regex' = 'recycled|resold|repaired|upcycled|donated|disposed');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'in-store|online|mobile-app|call-center|partner-location|event');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_value_regex' = '^CE-[0-9]{10}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|completed|cancelled|rejected');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `enrollment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `esg_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'ESG Reporting Period');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `esg_reporting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-Q[1-4]$|^[0-9]{4}-[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `incentive_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Incentive Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `incentive_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `incentive_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Incentive Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `incentive_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Incentive Issued Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `incentive_type` SET TAGS ('dbx_business_glossary_term' = 'Incentive Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `incentive_type` SET TAGS ('dbx_value_regex' = 'discount-voucher|loyalty-points|store-credit|donation|none');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `incentive_value` SET TAGS ('dbx_business_glossary_term' = 'Incentive Value');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `items_submitted_count` SET TAGS ('dbx_business_glossary_term' = 'Items Submitted Count');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `material_composition` SET TAGS ('dbx_business_glossary_term' = 'Material Composition');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `partner_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `processing_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Processing Completed Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (Kilograms)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` SET TAGS ('dbx_subdomain' = 'environmental_operations');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `environmental_impact_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Assessment ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `print_design_id` SET TAGS ('dbx_business_glossary_term' = 'Print Design Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `revised_environmental_impact_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `acidification_potential_kg_so2e` SET TAGS ('dbx_business_glossary_term' = 'Acidification Potential in Kilograms Sulfur Dioxide Equivalent (SO2e)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Life Cycle Assessment (LCA) Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `assessment_number` SET TAGS ('dbx_value_regex' = '^LCA-[0-9]{8}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|peer_review|completed|published|archived');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Life Cycle Assessment (LCA) Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'cradle_to_gate|cradle_to_grave|gate_to_gate|cradle_to_cradle|hotspot_analysis|comparative');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `assessor_organization` SET TAGS ('dbx_business_glossary_term' = 'Assessor Organization');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `certification_standard` SET TAGS ('dbx_business_glossary_term' = 'Environmental Certification Standard');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Life Cycle Assessment (LCA) Data Quality Score');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `ecotoxicity_potential_kg_1_4_dbe` SET TAGS ('dbx_business_glossary_term' = 'Ecotoxicity Potential in Kilograms 1,4-Dichlorobenzene Equivalent (1,4-DBe)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `energy_consumption_mj` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption in Megajoules (MJ)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `eutrophication_potential_kg_po4e` SET TAGS ('dbx_business_glossary_term' = 'Eutrophication Potential in Kilograms Phosphate Equivalent (PO4e)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `functional_unit` SET TAGS ('dbx_business_glossary_term' = 'Functional Unit');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `functional_unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Functional Unit Quantity');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `global_warming_potential_kg_co2e` SET TAGS ('dbx_business_glossary_term' = 'Global Warming Potential (GWP) in Kilograms Carbon Dioxide Equivalent (CO2e)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `hazardous_waste_kg` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste in Kilograms');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `human_toxicity_potential_kg_1_4_dbe` SET TAGS ('dbx_business_glossary_term' = 'Human Toxicity Potential in Kilograms 1,4-Dichlorobenzene Equivalent (1,4-DBe)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `land_use_square_meters` SET TAGS ('dbx_business_glossary_term' = 'Land Use in Square Meters');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Life Cycle Assessment (LCA) Methodology');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `ozone_depletion_potential_kg_cfc11e` SET TAGS ('dbx_business_glossary_term' = 'Ozone Depletion Potential in Kilograms CFC-11 Equivalent (CFC-11e)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `peer_review_completed` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Completed Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `peer_review_date` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `photochemical_ozone_creation_potential_kg_c2h4e` SET TAGS ('dbx_business_glossary_term' = 'Photochemical Ozone Creation Potential in Kilograms Ethylene Equivalent (C2H4e)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `public_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `recycled_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Recycled Content Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `renewable_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Renewable Content Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `system_boundary_description` SET TAGS ('dbx_business_glossary_term' = 'System Boundary Description');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `uncertainty_percentage` SET TAGS ('dbx_business_glossary_term' = 'Assessment Uncertainty Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `waste_generated_kg` SET TAGS ('dbx_business_glossary_term' = 'Waste Generated in Kilograms');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `water_consumption_liters` SET TAGS ('dbx_business_glossary_term' = 'Water Consumption in Liters');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ALTER COLUMN `water_pollution_index` SET TAGS ('dbx_business_glossary_term' = 'Water Pollution Index');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` SET TAGS ('dbx_subdomain' = 'environmental_operations');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Water Usage ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `corrected_water_usage_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|exempted');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_value_regex' = 'automated_meter|manual_meter|estimated|supplier_reported');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `data_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Data Verification Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `data_verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|third_party_audited|pending');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `discharge_destination_type` SET TAGS ('dbx_business_glossary_term' = 'Discharge Destination Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `discharge_destination_type` SET TAGS ('dbx_value_regex' = 'municipal_sewer|surface_water|groundwater|third_party|on_site');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'manufacturing|warehouse|distribution_center|retail_store|office|dyeing_facility');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `permit_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `production_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Production Volume Units');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `regulatory_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Permit Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `third_party_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Third Party Auditor Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `total_water_intake_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Water Intake Volume (Cubic Meters)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `wastewater_discharged_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Discharged Volume (Cubic Meters)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `wastewater_treatment_method` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Treatment Method');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `wastewater_treatment_method` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `wastewater_treatment_method` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_consumption_per_unit_produced` SET TAGS ('dbx_business_glossary_term' = 'Water Consumption Per Unit Produced');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_quality_bod_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Biochemical Oxygen Demand (BOD) Milligrams Per Liter');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_quality_cod_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Chemical Oxygen Demand (COD) Milligrams Per Liter');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_quality_ph_level` SET TAGS ('dbx_business_glossary_term' = 'Water Quality pH Level');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_quality_tss_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Total Suspended Solids (TSS) Milligrams Per Liter');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_recycled_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Water Recycled Volume (Cubic Meters)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_reduction_achieved_m3` SET TAGS ('dbx_business_glossary_term' = 'Water Reduction Achieved (Cubic Meters)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_reduction_target_m3` SET TAGS ('dbx_business_glossary_term' = 'Water Reduction Target (Cubic Meters)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_source_type` SET TAGS ('dbx_business_glossary_term' = 'Water Source Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_source_type` SET TAGS ('dbx_value_regex' = 'municipal|groundwater|rainwater|surface_water|recycled|desalinated');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_stewardship_certification` SET TAGS ('dbx_business_glossary_term' = 'Water Stewardship Certification');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_stewardship_program_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Water Stewardship Program Enrolled');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_stress_basin_classification` SET TAGS ('dbx_business_glossary_term' = 'Water Stress Basin Classification');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `water_stress_basin_classification` SET TAGS ('dbx_value_regex' = 'low|low_to_medium|medium_to_high|high|extremely_high');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `zld_commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Zero Liquid Discharge (ZLD) Commitment Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ALTER COLUMN `zld_commitment_status` SET TAGS ('dbx_value_regex' = 'committed|in_progress|achieved|not_applicable');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` SET TAGS ('dbx_subdomain' = 'environmental_operations');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `renewable_energy_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `corrected_energy_consumption_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `consumption_date` SET TAGS ('dbx_business_glossary_term' = 'Consumption Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `consumption_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consumption Quantity');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `emission_factor` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `emission_factor_source` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Source');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_cost` SET TAGS ('dbx_business_glossary_term' = 'Energy Cost');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_intensity_metric` SET TAGS ('dbx_business_glossary_term' = 'Energy Intensity Metric');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_source` SET TAGS ('dbx_business_glossary_term' = 'Energy Source');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `energy_source` SET TAGS ('dbx_value_regex' = 'grid_electricity|natural_gas|renewable_energy|solar|diesel|fuel_oil');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'retail_store|distribution_center|corporate_office|manufacturing_plant');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `intensity_denominator` SET TAGS ('dbx_business_glossary_term' = 'Intensity Denominator');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `intensity_denominator` SET TAGS ('dbx_value_regex' = 'square_feet|square_meters|units_produced|revenue_usd|employee_count');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `meter_code` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `meter_reading_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `meter_reading_type` SET TAGS ('dbx_value_regex' = 'actual|estimated|billed');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `renewable_energy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `reporting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(Q[1-4]|M(0[1-9]|1[0-2])|W(0[1-9]|[1-4][0-9]|5[0-3]))$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `scope_1_emissions_kg_co2e` SET TAGS ('dbx_business_glossary_term' = 'Scope 1 Emissions (kg CO2e)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `scope_2_emissions_kg_co2e` SET TAGS ('dbx_business_glossary_term' = 'Scope 2 Emissions (kg CO2e)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kWh|MWh|GJ|MJ|therms|MMBtu');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `utility_account_number` SET TAGS ('dbx_business_glossary_term' = 'Utility Account Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `utility_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `utility_provider` SET TAGS ('dbx_business_glossary_term' = 'Utility Provider');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`energy_consumption` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending_verification');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` SET TAGS ('dbx_subdomain' = 'environmental_operations');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `waste_record_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Record Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Reduction Initiative Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `corrected_waste_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `carbon_footprint_kg_co2e` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint in Kilograms Carbon Dioxide Equivalent (CO2e)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `certification_standard` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Waste Disposal Cost Amount');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `disposal_facility_location` SET TAGS ('dbx_business_glossary_term' = 'Disposal Facility Location');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `disposal_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Disposal Facility Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `disposal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disposal Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `diversion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Diversion Rate Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `hazardous_waste_manifest_number` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Manifest Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `material_composition` SET TAGS ('dbx_business_glossary_term' = 'Material Composition');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Waste Record Notes');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|verified|approved|rejected|archived');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `reporting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(Q[1-4]|M(0[1-9]|1[0-2]))$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `revenue_from_recycling` SET TAGS ('dbx_business_glossary_term' = 'Revenue from Recycling');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `revenue_from_recycling` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Waste Volume in Cubic Meters');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `waste_collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Waste Collection Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `waste_generation_date` SET TAGS ('dbx_business_glossary_term' = 'Waste Generation Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `waste_handler_license_number` SET TAGS ('dbx_business_glossary_term' = 'Waste Handler License Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `waste_handler_name` SET TAGS ('dbx_business_glossary_term' = 'Waste Handler Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `waste_source_process` SET TAGS ('dbx_business_glossary_term' = 'Waste Source Process');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `waste_stream_classification` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Classification');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `waste_stream_classification` SET TAGS ('dbx_value_regex' = 'hazardous|non_hazardous|recyclable|compostable|special_handling');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `waste_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Waste Transaction Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `waste_transaction_number` SET TAGS ('dbx_value_regex' = '^WR-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `waste_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Waste Weight in Kilograms (KG)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ALTER COLUMN `zwtl_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Zero Waste to Landfill (ZWTL) Compliant Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` SET TAGS ('dbx_subdomain' = 'supply_accountability');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `supplier_esg_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ESG (Environmental, Social, Governance) Assessment ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `esg_report_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Report Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `prior_supplier_esg_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `areas_for_improvement` SET TAGS ('dbx_business_glossary_term' = 'Areas for Improvement');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `assessment_cost` SET TAGS ('dbx_business_glossary_term' = 'Assessment Cost');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `assessment_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `assessment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Assessment Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `assessment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `assessment_report_url` SET TAGS ('dbx_business_glossary_term' = 'Assessment Report URL (Uniform Resource Locator)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `assessor_accreditation` SET TAGS ('dbx_business_glossary_term' = 'Assessor Accreditation');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `assessor_organization` SET TAGS ('dbx_business_glossary_term' = 'Assessor Organization');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `certification_achieved` SET TAGS ('dbx_business_glossary_term' = 'Certification Achieved Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `corrective_action_plan_approved` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Approved Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `corrective_action_plan_submitted` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Submitted Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `environmental_score` SET TAGS ('dbx_business_glossary_term' = 'Environmental Score');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `facility_country_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Country Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `facility_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `follow_up_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Assessment Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `follow_up_assessment_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Assessment Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `governance_score` SET TAGS ('dbx_business_glossary_term' = 'Governance Score');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `key_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Key Findings Summary');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall ESG (Environmental, Social, Governance) Rating');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|acceptable|needs_improvement|unacceptable|zero_tolerance');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall ESG (Environmental, Social, Governance) Score');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `remediation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Remediation Deadline Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `remediation_required` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'ESG (Environmental, Social, Governance) Risk Level');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Assessment Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `social_score` SET TAGS ('dbx_business_glossary_term' = 'Social Score');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `strengths_identified` SET TAGS ('dbx_business_glossary_term' = 'Strengths Identified');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `supplier_tier` SET TAGS ('dbx_business_glossary_term' = 'Supplier Tier');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `supplier_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ALTER COLUMN `valid_until_date` SET TAGS ('dbx_business_glossary_term' = 'Valid Until Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` SET TAGS ('dbx_subdomain' = 'supply_accountability');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `traceability_record_id` SET TAGS ('dbx_business_glossary_term' = 'Traceability Record Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Material Batch Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `print_design_id` SET TAGS ('dbx_business_glossary_term' = 'Print Design Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `rfid_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `prior_traceability_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `blockchain_hash` SET TAGS ('dbx_business_glossary_term' = 'Blockchain Transaction Hash');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `carbon_footprint_kg_co2e` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint in Kilograms Carbon Dioxide Equivalent (kg CO2e)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `certification_standard` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `chain_of_custody_method` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody (CoC) Method');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `chain_of_custody_method` SET TAGS ('dbx_value_regex' = 'Identity Preserved|Segregated|Mass Balance|Book and Claim');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `chemical_usage_kg` SET TAGS ('dbx_business_glossary_term' = 'Chemical Usage in Kilograms (kg)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `energy_consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption in Kilowatt Hours (kWh)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `fair_trade_certified` SET TAGS ('dbx_business_glossary_term' = 'Fair Trade Certified Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `geographic_coordinates` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coordinates');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `material_composition` SET TAGS ('dbx_business_glossary_term' = 'Material Composition Description');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type Description');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Traceability Notes');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `organic_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Organic Content Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `process_stage` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Process Stage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `qr_code_data` SET TAGS ('dbx_business_glossary_term' = 'Quick Response (QR) Code Data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Material Quantity');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'Active|Archived|Disputed|Corrected');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `recycled_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Recycled Content Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `shipping_document_number` SET TAGS ('dbx_business_glossary_term' = 'Shipping Document Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `traceability_tier` SET TAGS ('dbx_business_glossary_term' = 'Traceability Tier Level');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `traceability_tier` SET TAGS ('dbx_value_regex' = 'Tier 1|Tier 2|Tier 3|Tier 4|Raw Material');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `transaction_certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction Certificate Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'Verified|Pending|Failed|Not Required');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `verifier_organization` SET TAGS ('dbx_business_glossary_term' = 'Verifier Organization Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `waste_generated_kg` SET TAGS ('dbx_business_glossary_term' = 'Waste Generated in Kilograms (kg)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ALTER COLUMN `water_consumption_liters` SET TAGS ('dbx_business_glossary_term' = 'Water Consumption in Liters');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` SET TAGS ('dbx_subdomain' = 'circular_economy');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `packaging_sustainability_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Sustainability ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `replacement_packaging_packaging_sustainability_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Packaging ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `superseded_packaging_sustainability_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `annual_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Annual Volume (Units)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `annual_volume_units` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `baseline_year` SET TAGS ('dbx_business_glossary_term' = 'Baseline Year');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `biodegradability_certification` SET TAGS ('dbx_business_glossary_term' = 'Biodegradability Certification');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `biodegradability_certification` SET TAGS ('dbx_value_regex' = 'ok_compost_home|ok_compost_industrial|astm_d6400|en_13432|not_certified');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `carbon_footprint_kg_co2e` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint (kg CO2e)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Channel Applicability');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_value_regex' = 'retail|e_commerce|wholesale|all_channels');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `cost_per_unit_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit (United States Dollar)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `cost_per_unit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `energy_consumption_mj` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption (Megajoules)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `epr_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Extended Producer Responsibility (EPR) Compliance Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `epr_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt|pending_review');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `epr_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Extended Producer Responsibility (EPR) Registration Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `epr_registration_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}-[A-Z0-9]{6,15}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `fsc_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Forest Stewardship Council (FSC) Certificate Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `fsc_certificate_number` SET TAGS ('dbx_value_regex' = '^FSC-[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `fsc_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Forest Stewardship Council (FSC) Certification Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `fsc_certification_status` SET TAGS ('dbx_value_regex' = 'fsc_100|fsc_mix|fsc_recycled|not_certified|pending');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `hazardous_substance_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Substance Indicator');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'active|phasing_out|discontinued|under_development');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `material_composition` SET TAGS ('dbx_business_glossary_term' = 'Material Composition');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `microplastic_shedding_risk` SET TAGS ('dbx_business_glossary_term' = 'Microplastic Shedding Risk');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `microplastic_shedding_risk` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `packaging_category` SET TAGS ('dbx_business_glossary_term' = 'Packaging Category');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `packaging_category` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary|point_of_sale|e_commerce|wholesale');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `packaging_reduction_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Packaging Reduction Target Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `packaging_type_code` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `packaging_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `packaging_type_name` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `phase_out_target_date` SET TAGS ('dbx_business_glossary_term' = 'Phase-Out Target Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `plastic_weight_grams` SET TAGS ('dbx_business_glossary_term' = 'Plastic Weight (Grams)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `post_consumer_recycled_percentage` SET TAGS ('dbx_business_glossary_term' = 'Post-Consumer Recycled (PCR) Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `primary_material_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Material Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `reach_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Registration, Evaluation, Authorisation and Restriction of Chemicals (REACH) Compliance Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `reach_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|not_applicable');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `recyclability_rating` SET TAGS ('dbx_business_glossary_term' = 'Recyclability Rating');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `recyclability_rating` SET TAGS ('dbx_value_regex' = 'fully_recyclable|widely_recyclable|limited_recyclability|not_recyclable|compostable|biodegradable');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `recycled_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Recycled Content Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `renewable_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Renewable Content Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `reusability_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reusability Indicator');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `reuse_cycle_count` SET TAGS ('dbx_business_glossary_term' = 'Reuse Cycle Count');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `supplier_sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Supplier Sustainability Score');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `sustainable_certification_list` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Certification List');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `total_weight_grams` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (Grams)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `virgin_plastic_indicator` SET TAGS ('dbx_business_glossary_term' = 'Virgin Plastic Indicator');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `water_usage_liters` SET TAGS ('dbx_business_glossary_term' = 'Water Usage (Liters)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` SET TAGS ('dbx_subdomain' = 'governance_reporting');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `esg_report_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Report Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `superseded_target_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `baseline_year` SET TAGS ('dbx_business_glossary_term' = 'Baseline Year');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `commitment_framework` SET TAGS ('dbx_business_glossary_term' = 'Commitment Framework');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `current_value` SET TAGS ('dbx_business_glossary_term' = 'Current Value');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `current_value_as_of_date` SET TAGS ('dbx_business_glossary_term' = 'Current Value As Of Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `executive_sponsor` SET TAGS ('dbx_business_glossary_term' = 'Executive Sponsor');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `is_public_commitment` SET TAGS ('dbx_business_glossary_term' = 'Is Public Commitment Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `progress_percentage` SET TAGS ('dbx_business_glossary_term' = 'Progress Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `public_commitment_date` SET TAGS ('dbx_business_glossary_term' = 'Public Commitment Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `related_sdg_goals` SET TAGS ('dbx_business_glossary_term' = 'Related Sustainable Development Goals (SDG) Goals');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `target_category` SET TAGS ('dbx_business_glossary_term' = 'Target Category');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `target_code` SET TAGS ('dbx_business_glossary_term' = 'Target Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `target_name` SET TAGS ('dbx_business_glossary_term' = 'Target Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `target_status` SET TAGS ('dbx_business_glossary_term' = 'Target Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `verification_body` SET TAGS ('dbx_business_glossary_term' = 'Verification Body');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_verified|internal_review|third_party_verified|audited');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`target` ALTER COLUMN `year` SET TAGS ('dbx_business_glossary_term' = 'Target Year');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` SET TAGS ('dbx_subdomain' = 'supply_accountability');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `chemical_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Compliance ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `colorway_development_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Development Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `print_design_id` SET TAGS ('dbx_business_glossary_term' = 'Print Design Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `superseded_chemical_compliance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `applicable_regulation` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulation');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `chemical_name` SET TAGS ('dbx_business_glossary_term' = 'Chemical Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'Pass|Fail|Pending|Conditional');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `detection_status` SET TAGS ('dbx_business_glossary_term' = 'Detection Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `detection_status` SET TAGS ('dbx_value_regex' = 'Detected|Not Detected|Below Detection Limit');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `facility_country` SET TAGS ('dbx_business_glossary_term' = 'Facility Country');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `facility_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `laboratory_accreditation` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Accreditation');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `oeko_tex_class` SET TAGS ('dbx_business_glossary_term' = 'OEKO-TEX Product Class');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `oeko_tex_class` SET TAGS ('dbx_value_regex' = 'Class I|Class II|Class III|Class IV');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `production_facility` SET TAGS ('dbx_business_glossary_term' = 'Production Facility');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `regulation_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulation Jurisdiction');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `remediation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completed Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `remediation_required` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Completed|Verified|Escalated');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'RSL|MRSL|Both');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `sample_description` SET TAGS ('dbx_business_glossary_term' = 'Sample Description');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'Raw Material|Component|Finished Product|Wastewater|Air Emission');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `test_report_number` SET TAGS ('dbx_business_glossary_term' = 'Test Report Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `test_result_value` SET TAGS ('dbx_business_glossary_term' = 'Test Result Value');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `testing_laboratory` SET TAGS ('dbx_business_glossary_term' = 'Testing Laboratory');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `threshold_limit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Limit');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'ppm|mg/kg|percent|mg/L|ug/g');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `zdhc_mrsl_version` SET TAGS ('dbx_business_glossary_term' = 'Zero Discharge of Hazardous Chemicals (ZDHC) Manufacturing Restricted Substance List (MRSL) Version');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` SET TAGS ('dbx_subdomain' = 'environmental_operations');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `renewable_energy_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Facility ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `bundled_from_renewable_energy_certificate_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `associated_market` SET TAGS ('dbx_business_glossary_term' = 'Associated Market');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `beneficiary_organization` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Organization');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `certificate_status` SET TAGS ('dbx_value_regex' = 'active|retired|expired|cancelled|transferred');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `certificate_type` SET TAGS ('dbx_value_regex' = 'REC|GO|I-REC|TIGR|J-Credit|Other');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `energy_source` SET TAGS ('dbx_business_glossary_term' = 'Energy Source');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `energy_source` SET TAGS ('dbx_value_regex' = 'solar|wind|hydro|geothermal|biomass|mixed');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `generation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Generation End Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `generation_facility_country_code` SET TAGS ('dbx_business_glossary_term' = 'Generation Facility Country Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `generation_facility_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `generation_facility_location` SET TAGS ('dbx_business_glossary_term' = 'Generation Facility Location');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `generation_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Generation Facility Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `generation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Generation Start Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `procurement_method` SET TAGS ('dbx_business_glossary_term' = 'Procurement Method');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `procurement_method` SET TAGS ('dbx_value_regex' = 'unbundled_rec|bundled_ppa|vppa|green_tariff|direct_investment');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `purchase_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Purchase Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `purchase_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `purchase_price_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price Per Megawatt-Hour (MWh)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `purchase_price_per_mwh` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `quantity_mwh` SET TAGS ('dbx_business_glossary_term' = 'Quantity Megawatt-Hours (MWh)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `re100_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy 100 (RE100) Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `registry_account_number` SET TAGS ('dbx_business_glossary_term' = 'Registry Account Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `registry_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `registry_name` SET TAGS ('dbx_business_glossary_term' = 'Registry Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `scope_2_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Scope 2 Reporting Period');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|not_verified');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `verifier_organization` SET TAGS ('dbx_business_glossary_term' = 'Verifier Organization');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` SET TAGS ('dbx_subdomain' = 'governance_reporting');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `social_impact_program_id` SET TAGS ('dbx_business_glossary_term' = 'Social Impact Program ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `esg_report_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Report ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `predecessor_social_impact_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `audit_provider` SET TAGS ('dbx_business_glossary_term' = 'Audit Provider');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Count');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `direct_beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Direct Beneficiary Count');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `external_audit_flag` SET TAGS ('dbx_business_glossary_term' = 'External Audit Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `external_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `female_beneficiary_percentage` SET TAGS ('dbx_business_glossary_term' = 'Female Beneficiary Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `fla_aligned_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Association (FLA) Aligned Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|country|local');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `herproject_flag` SET TAGS ('dbx_business_glossary_term' = 'HERproject Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `impact_metric_type` SET TAGS ('dbx_business_glossary_term' = 'Impact Metric Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `impact_metric_type` SET TAGS ('dbx_value_regex' = 'wage_increase|training_hours|health_screenings|education_access|employment_created|income_generated');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `impact_metric_unit` SET TAGS ('dbx_business_glossary_term' = 'Impact Metric Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `impact_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Impact Metric Value');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `indirect_beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Indirect Beneficiary Count');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `investment_amount` SET TAGS ('dbx_business_glossary_term' = 'Investment Amount');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `investment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `investment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Investment Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `investment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `living_wage_benchmark_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Living Wage Benchmark Met Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `living_wage_benchmark_met_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `living_wage_benchmark_met_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `partner_ngo_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Non-Governmental Organization (NGO) Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `partner_ngo_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Non-Governmental Organization (NGO) Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `partner_ngo_type` SET TAGS ('dbx_value_regex' = 'international_ngo|local_ngo|community_organization|government_agency|academic_institution');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'planned|active|on_hold|completed|discontinued');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'worker_welfare|living_wage|womens_empowerment|community_development|artisan_partnership|education');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `responsible_executive` SET TAGS ('dbx_business_glossary_term' = 'Responsible Executive');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `success_story_summary` SET TAGS ('dbx_business_glossary_term' = 'Success Story Summary');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `target_beneficiary_group` SET TAGS ('dbx_business_glossary_term' = 'Target Beneficiary Group');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `un_sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`social_impact_program` ALTER COLUMN `wrap_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Worldwide Responsible Accredited Production (WRAP) Certified Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` SET TAGS ('dbx_subdomain' = 'governance_reporting');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `esg_disclosure_metric_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Disclosure Metric Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `esg_report_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Report Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `restated_esg_disclosure_metric_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'Draft|Pending Review|Approved|Rejected|Published');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `assurance_level` SET TAGS ('dbx_business_glossary_term' = 'Assurance Level');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `assurance_level` SET TAGS ('dbx_value_regex' = 'Limited|Reasonable|None|Internal');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `assurance_provider` SET TAGS ('dbx_business_glossary_term' = 'Assurance Provider');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `baseline_year` SET TAGS ('dbx_business_glossary_term' = 'Baseline Year');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'Verified|Estimated|Modeled|Incomplete|Pending');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `indicator_type` SET TAGS ('dbx_business_glossary_term' = 'Indicator Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `indicator_type` SET TAGS ('dbx_value_regex' = 'Quantitative|Qualitative|Binary|Narrative');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `materiality_assessment_flag` SET TAGS ('dbx_business_glossary_term' = 'Materiality Assessment Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `metric_category` SET TAGS ('dbx_business_glossary_term' = 'Metric Category');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `metric_category` SET TAGS ('dbx_value_regex' = 'Environmental|Social|Governance|Economic');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `metric_code` SET TAGS ('dbx_business_glossary_term' = 'Metric Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `metric_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,20}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Metric Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `metric_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Metric Subcategory');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `metric_value_numeric` SET TAGS ('dbx_business_glossary_term' = 'Metric Value Numeric');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `metric_value_text` SET TAGS ('dbx_business_glossary_term' = 'Metric Value Text');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `previous_reported_value` SET TAGS ('dbx_business_glossary_term' = 'Previous Reported Value');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `public_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `rating_agency_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Rating Agency Submission Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_business_glossary_term' = 'Reporting Framework');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `restatement_flag` SET TAGS ('dbx_business_glossary_term' = 'Restatement Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `restatement_reason` SET TAGS ('dbx_business_glossary_term' = 'Restatement Reason');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `scope_boundary` SET TAGS ('dbx_business_glossary_term' = 'Scope Boundary');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `stakeholder_priority_level` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Priority Level');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `stakeholder_priority_level` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `un_sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric` ALTER COLUMN `variance_from_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Variance from Target Percentage (PCT)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` SET TAGS ('dbx_subdomain' = 'supply_accountability');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `higg_index_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Higg Index Assessment ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `esg_report_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Report Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `previous_assessment_higg_index_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Assessment ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `prior_higg_index_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `action_plan_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `action_plan_due_date` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Due Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `air_emissions_score` SET TAGS ('dbx_business_glossary_term' = 'Air Emissions Section Score');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `assessment_language` SET TAGS ('dbx_business_glossary_term' = 'Assessment Language');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `assessment_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Assessment Scope Description');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_verification|verified|published|expired');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `assessment_year` SET TAGS ('dbx_business_glossary_term' = 'Assessment Year');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `brand_scope` SET TAGS ('dbx_business_glossary_term' = 'Brand Scope');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `chemicals_score` SET TAGS ('dbx_business_glossary_term' = 'Chemicals Section Score');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `data_quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Rating');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `data_quality_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `energy_score` SET TAGS ('dbx_business_glossary_term' = 'Energy Section Score');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `health_safety_score` SET TAGS ('dbx_business_glossary_term' = 'Health and Safety Section Score');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `health_safety_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `health_safety_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `higg_platform_code` SET TAGS ('dbx_business_glossary_term' = 'Higg Platform ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `improvement_action_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Improvement Action Plan Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `improvement_action_plan_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|overdue');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `labor_practices_score` SET TAGS ('dbx_business_glossary_term' = 'Labor Practices Section Score');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `module_type` SET TAGS ('dbx_business_glossary_term' = 'Higg Module Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `module_type` SET TAGS ('dbx_value_regex' = 'FEM|FSLM|BRM|MATERIALS|PRODUCT');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `public_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Email');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `self_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Self-Assessment Score');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `verification_body_name` SET TAGS ('dbx_business_glossary_term' = 'Verification Body Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|failed');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `verified_score` SET TAGS ('dbx_business_glossary_term' = 'Verified Score');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `verifier_accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Verifier Accreditation Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `waste_score` SET TAGS ('dbx_business_glossary_term' = 'Waste Section Score');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ALTER COLUMN `water_score` SET TAGS ('dbx_business_glossary_term' = 'Water Section Score');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` SET TAGS ('dbx_subdomain' = 'environmental_operations');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `biodiversity_impact_id` SET TAGS ('dbx_business_glossary_term' = 'Biodiversity Impact ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `esg_report_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Report Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `reassessment_of_biodiversity_impact_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `annual_sourcing_volume` SET TAGS ('dbx_business_glossary_term' = 'Annual Sourcing Volume');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_business_glossary_term' = 'Assessment Methodology');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessment_number` SET TAGS ('dbx_value_regex' = '^BIA-[0-9]{8}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|published|archived');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'raw_material_sourcing|facility_location|supply_chain_corridor|land_use_change|water_source|product_lifecycle');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `biodiversity_offset_area_hectares` SET TAGS ('dbx_business_glossary_term' = 'Biodiversity Offset Area (Hectares)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `biodiversity_sensitivity_classification` SET TAGS ('dbx_business_glossary_term' = 'Biodiversity Sensitivity Classification');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `deforestation_risk_zone_flag` SET TAGS ('dbx_business_glossary_term' = 'Deforestation Risk Zone Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `ecosystem_type` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `iucn_kba_flag` SET TAGS ('dbx_business_glossary_term' = 'IUCN Key Biodiversity Area (KBA) Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `iucn_red_list_category` SET TAGS ('dbx_business_glossary_term' = 'IUCN Red List Category');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `iucn_red_list_category` SET TAGS ('dbx_value_regex' = 'critically_endangered|endangered|vulnerable|near_threatened|least_concern|not_assessed');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `land_use_change_area_hectares` SET TAGS ('dbx_business_glossary_term' = 'Land Use Change Area (Hectares)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `land_use_change_impact` SET TAGS ('dbx_business_glossary_term' = 'Land Use Change Impact');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `land_use_change_impact` SET TAGS ('dbx_value_regex' = 'no_change|low_impact|moderate_impact|high_impact|severe_impact');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `mitigation_effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Effectiveness Rating');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `mitigation_effectiveness_rating` SET TAGS ('dbx_value_regex' = 'not_effective|partially_effective|effective|highly_effective|not_assessed');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `mitigation_measures_implemented` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Measures Implemented');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `ramsar_wetland_flag` SET TAGS ('dbx_business_glossary_term' = 'Ramsar Wetland Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `restoration_program_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Restoration Program Enrolled');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `restoration_program_name` SET TAGS ('dbx_business_glossary_term' = 'Restoration Program Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `sourcing_practice_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Practice Risk Level');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `sourcing_practice_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `sourcing_volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Volume Unit');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `sourcing_volume_unit` SET TAGS ('dbx_value_regex' = 'metric_tons|kilograms|liters|square_meters|units');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `species_at_risk_count` SET TAGS ('dbx_business_glossary_term' = 'Species at Risk Count');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `species_at_risk_list` SET TAGS ('dbx_business_glossary_term' = 'Species at Risk List');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `third_party_verification_flag` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Verification Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `tnfd_disclosure_alignment` SET TAGS ('dbx_business_glossary_term' = 'TNFD Disclosure Alignment');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `verification_body_name` SET TAGS ('dbx_business_glossary_term' = 'Verification Body Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` SET TAGS ('dbx_subdomain' = 'environmental_operations');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `carbon_offset_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `carbon_target_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Target Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `esg_report_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Report Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `retired_against_carbon_offset_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `additionality_verified` SET TAGS ('dbx_business_glossary_term' = 'Additionality Verified Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `allocation_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Allocation Business Unit');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `allocation_fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Allocation Fiscal Year');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `associated_emission_scope` SET TAGS ('dbx_business_glossary_term' = 'Associated Emission Scope');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `associated_emission_scope` SET TAGS ('dbx_value_regex' = 'scope_1|scope_2|scope_3|residual_emissions|net_zero_commitment');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `certification_standard` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `certification_standard` SET TAGS ('dbx_value_regex' = 'gold_standard|vcs_verra|american_carbon_registry|climate_action_reserve|plan_vivo|puro_earth');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `co_benefits_description` SET TAGS ('dbx_business_glossary_term' = 'Co-Benefits Description');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `double_counting_prevention_flag` SET TAGS ('dbx_business_glossary_term' = 'Double Counting Prevention Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `net_zero_claim_eligible` SET TAGS ('dbx_business_glossary_term' = 'Net Zero Claim Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `offset_project_name` SET TAGS ('dbx_business_glossary_term' = 'Offset Project Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `permanence_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Permanence Risk Rating');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `permanence_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|not_assessed');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `project_location_country_code` SET TAGS ('dbx_business_glossary_term' = 'Project Location Country Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `project_location_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `project_location_region` SET TAGS ('dbx_business_glossary_term' = 'Project Location Region');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'reforestation|afforestation|renewable_energy|cookstoves|soil_carbon|methane_capture');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `purchase_price_per_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price per Metric Ton Carbon Dioxide Equivalent (tCO2e)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `purchase_price_per_tco2e` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `quantity_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Quantity in Metric Tons Carbon Dioxide Equivalent (tCO2e)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `registry_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Registry Serial Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `retirement_certificate_url` SET TAGS ('dbx_business_glossary_term' = 'Retirement Certificate Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `retirement_status` SET TAGS ('dbx_business_glossary_term' = 'Retirement Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `retirement_status` SET TAGS ('dbx_value_regex' = 'active|retired|cancelled|expired');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `scope_3_category` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `supplier_broker_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier or Broker Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `total_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Amount');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `total_purchase_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `un_sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'United Nations Sustainable Development Goal (UN SDG) Alignment');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `verification_body_name` SET TAGS ('dbx_business_glossary_term' = 'Verification Body Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `verification_report_url` SET TAGS ('dbx_business_glossary_term' = 'Verification Report Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` SET TAGS ('dbx_subdomain' = 'circular_economy');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `ecolabel_id` SET TAGS ('dbx_business_glossary_term' = 'Eco-Label Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `superseded_ecolabel_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `annual_license_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual License Fee Amount');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `annual_license_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `applicable_material_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Material Types');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `applicable_product_categories` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Categories');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency (Months)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `carbon_reduction_claim` SET TAGS ('dbx_business_glossary_term' = 'Carbon Reduction Claim');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `certification_scope` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `chain_of_custody_required` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Required');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `circular_economy_eligible` SET TAGS ('dbx_business_glossary_term' = 'Circular Economy Eligible');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `consumer_facing_claim_text` SET TAGS ('dbx_business_glossary_term' = 'Consumer-Facing Claim Text');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `environmental_criteria` SET TAGS ('dbx_business_glossary_term' = 'Environmental Criteria');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `esg_alignment_goals` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Alignment Goals');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|national');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `issuing_body_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body Country Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `issuing_body_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `issuing_body_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `label_code` SET TAGS ('dbx_business_glossary_term' = 'Label Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `label_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `label_name` SET TAGS ('dbx_business_glossary_term' = 'Label Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `label_status` SET TAGS ('dbx_business_glossary_term' = 'Label Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `label_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|under_review|suspended');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `label_type` SET TAGS ('dbx_business_glossary_term' = 'Label Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `label_type` SET TAGS ('dbx_value_regex' = 'product_certification|process_certification|brand_claim|facility_certification|supply_chain_certification|material_certification');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `license_fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'License Fee Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `license_fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `license_fee_required` SET TAGS ('dbx_business_glossary_term' = 'License Fee Required');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `logo_file_path` SET TAGS ('dbx_business_glossary_term' = 'Logo File Path');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `minimum_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Minimum Content Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `public_disclosure_required` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Required');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `recognized_countries` SET TAGS ('dbx_business_glossary_term' = 'Recognized Countries');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `social_criteria` SET TAGS ('dbx_business_glossary_term' = 'Social Criteria');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `usage_guidelines_url` SET TAGS ('dbx_business_glossary_term' = 'Usage Guidelines Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `usage_guidelines_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'third_party_audit|self_declaration|chain_of_custody|lab_testing|document_review|site_inspection');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`ecolabel` ALTER COLUMN `water_stewardship_claim` SET TAGS ('dbx_business_glossary_term' = 'Water Stewardship Claim');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` SET TAGS ('dbx_subdomain' = 'governance_reporting');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `scope3_category_id` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `parent_scope3_category_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `applicability_flag` SET TAGS ('dbx_business_glossary_term' = 'Applicability Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `baseline_emissions_mt_co2e` SET TAGS ('dbx_business_glossary_term' = 'Baseline Emissions Metric Tons Carbon Dioxide Equivalent (MT CO2e)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `baseline_year` SET TAGS ('dbx_business_glossary_term' = 'Baseline Year');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_value_regex' = 'spend_based|activity_based|average_data|supplier_specific|hybrid');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `calculation_methodology_description` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology Description');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Category Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `category_number` SET TAGS ('dbx_business_glossary_term' = 'Category Number');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `category_status` SET TAGS ('dbx_business_glossary_term' = 'Category Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `category_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `category_type` SET TAGS ('dbx_business_glossary_term' = 'Category Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `category_type` SET TAGS ('dbx_value_regex' = 'upstream|downstream');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `cdp_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Carbon Disclosure Project (CDP) Disclosure Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `data_collection_approach` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Approach');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `data_coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Data Coverage Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `data_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Data Owner Email Address');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `data_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `data_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `data_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `data_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Data Owner Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `data_owner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `data_quality_tier` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Tier');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `data_quality_tier` SET TAGS ('dbx_value_regex' = 'tier_1_supplier_specific|tier_2_secondary|tier_3_average|tier_4_proxy');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `disclosure_requirement` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Requirement');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `disclosure_requirement` SET TAGS ('dbx_value_regex' = 'mandatory|recommended|optional');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `emission_factor_database` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Database');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `emission_factor_version` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Version');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `gri_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Global Reporting Initiative (GRI) Standard Reference');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `industry_specific_guidance` SET TAGS ('dbx_business_glossary_term' = 'Industry Specific Guidance');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `last_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `materiality_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Materiality Assessment Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `materiality_rationale` SET TAGS ('dbx_business_glossary_term' = 'Materiality Rationale');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `primary_data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Primary Data Source System');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `reduction_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Reduction Target Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `reporting_boundary` SET TAGS ('dbx_business_glossary_term' = 'Reporting Boundary');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|continuous');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `sasb_metric_reference` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Accounting Standards Board (SASB) Metric Reference');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `sbti_alignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Science Based Targets Initiative (SBTi) Alignment Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `supply_chain_tier_coverage` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Tier Coverage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `target_year` SET TAGS ('dbx_business_glossary_term' = 'Target Year');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `tcfd_alignment` SET TAGS ('dbx_business_glossary_term' = 'Task Force on Climate-related Financial Disclosures (TCFD) Alignment');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `tcfd_alignment` SET TAGS ('dbx_value_regex' = 'metrics_targets|risk_management|strategy|governance|not_applicable');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `uncertainty_range_percentage` SET TAGS ('dbx_business_glossary_term' = 'Uncertainty Range Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `verification_requirement` SET TAGS ('dbx_business_glossary_term' = 'Verification Requirement');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`scope3_category` ALTER COLUMN `verification_requirement` SET TAGS ('dbx_value_regex' = 'third_party_required|internal_review|not_required');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` SET TAGS ('dbx_subdomain' = 'governance_reporting');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Initiative ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `esg_report_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Report Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `parent_initiative_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `actual_carbon_reduction_mt_co2e` SET TAGS ('dbx_business_glossary_term' = 'Actual Carbon Reduction (Metric Tons CO2 Equivalent)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `actual_energy_savings_mwh` SET TAGS ('dbx_business_glossary_term' = 'Actual Energy Savings (Megawatt Hours)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `actual_waste_diversion_kg` SET TAGS ('dbx_business_glossary_term' = 'Actual Waste Diversion (Kilograms)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `actual_water_savings_m3` SET TAGS ('dbx_business_glossary_term' = 'Actual Water Savings (Cubic Meters)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `alignment_to_sbti` SET TAGS ('dbx_business_glossary_term' = 'Alignment to Science Based Targets Initiative (SBTi)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `alignment_to_un_sdg` SET TAGS ('dbx_business_glossary_term' = 'Alignment to United Nations Sustainable Development Goals (UN SDG)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `certification_target` SET TAGS ('dbx_business_glossary_term' = 'Certification Target');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `executive_sponsor` SET TAGS ('dbx_business_glossary_term' = 'Executive Sponsor');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_code` SET TAGS ('dbx_business_glossary_term' = 'Initiative Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_description` SET TAGS ('dbx_business_glossary_term' = 'Initiative Description');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_name` SET TAGS ('dbx_business_glossary_term' = 'Initiative Name');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_status` SET TAGS ('dbx_business_glossary_term' = 'Initiative Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_status` SET TAGS ('dbx_value_regex' = 'planning|approved|in_progress|on_hold|completed|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_type` SET TAGS ('dbx_business_glossary_term' = 'Initiative Type');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_type` SET TAGS ('dbx_value_regex' = 'operational_efficiency|product_innovation|supply_chain|circular_economy|renewable_energy|waste_reduction');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `investment_amount` SET TAGS ('dbx_business_glossary_term' = 'Investment Amount');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `investment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Investment Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `investment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `on_track_flag` SET TAGS ('dbx_business_glossary_term' = 'On Track Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Initiative Owner');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `progress_percentage` SET TAGS ('dbx_business_glossary_term' = 'Progress Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `projected_carbon_reduction_mt_co2e` SET TAGS ('dbx_business_glossary_term' = 'Projected Carbon Reduction (Metric Tons CO2 Equivalent)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `projected_energy_savings_mwh` SET TAGS ('dbx_business_glossary_term' = 'Projected Energy Savings (Megawatt Hours)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `projected_waste_diversion_kg` SET TAGS ('dbx_business_glossary_term' = 'Projected Waste Diversion (Kilograms)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `projected_water_savings_m3` SET TAGS ('dbx_business_glossary_term' = 'Projected Water Savings (Cubic Meters)');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `public_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `scope_boundary` SET TAGS ('dbx_business_glossary_term' = 'Scope Boundary');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Initiative Start Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `sustainability_pillar` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Pillar');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `sustainability_pillar` SET TAGS ('dbx_value_regex' = 'climate|water|circularity|chemicals|social|biodiversity');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `verification_body` SET TAGS ('dbx_business_glossary_term' = 'Verification Body');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_verified|in_progress|verified|certified');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative_carbon_contribution` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative_carbon_contribution` SET TAGS ('dbx_subdomain' = 'governance_reporting');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative_carbon_contribution` SET TAGS ('dbx_association_edges' = 'sustainability.sustainability_initiative,sustainability.carbon_target');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative_carbon_contribution` ALTER COLUMN `initiative_carbon_contribution_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Carbon Contribution ID');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative_carbon_contribution` ALTER COLUMN `carbon_target_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Carbon Contribution - Carbon Target Id');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative_carbon_contribution` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Carbon Contribution - Sustainability Initiative Id');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative_carbon_contribution` ALTER COLUMN `actual_carbon_reduction_mt_co2e` SET TAGS ('dbx_business_glossary_term' = 'Actual Carbon Reduction');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative_carbon_contribution` ALTER COLUMN `alignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Alignment End Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative_carbon_contribution` ALTER COLUMN `alignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Alignment Start Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative_carbon_contribution` ALTER COLUMN `allocation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Allocation Methodology');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative_carbon_contribution` ALTER COLUMN `contribution_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contribution Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative_carbon_contribution` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative_carbon_contribution` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative_carbon_contribution` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative_carbon_contribution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contribution Notes');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative_carbon_contribution` ALTER COLUMN `projected_carbon_reduction_mt_co2e` SET TAGS ('dbx_business_glossary_term' = 'Projected Carbon Reduction');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative_carbon_contribution` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative_carbon_contribution` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative_carbon_contribution` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative_carbon_contribution` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`facility` SET TAGS ('dbx_subdomain' = 'environmental_operations');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`facility` ALTER COLUMN `parent_facility_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`facility` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`facility` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`facility` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`facility` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`facility` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`facility` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`facility` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`facility` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
