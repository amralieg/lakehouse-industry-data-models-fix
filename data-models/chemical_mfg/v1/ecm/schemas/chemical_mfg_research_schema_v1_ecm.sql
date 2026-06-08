-- Schema for Domain: research | Business: Chemical Mfg | Version: v1_ecm
-- Generated on: 2026-05-06 12:33:22

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `chemical_mfg_ecm`.`research` COMMENT 'Research and Development domain managing new chemical compound development, experimental formulations, lab-scale synthesis records, patent filings, technology transfer to commercial production, compound registry (CAS number assignment), trial batch records, stability study data, R&D project portfolio management, and innovation pipeline. Integrates with LabWare LIMS and Aspen HYSYS.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`research`.`project` (
    `project_id` BIGINT COMMENT 'Primary key for project',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Project budgeting and expense allocation require linking each R&D project to its responsible cost center for financial reporting and variance analysis.',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to maintenance.functional_location. Business justification: R&D projects are assigned to a plant/lab location for resource allocation, safety oversight, and regulatory traceability.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for Project Lead assignment report; links project lead to employee record for accountability and resource planning.',
    `actual_end_date` DATE COMMENT 'Date when the project was actually closed or completed.',
    `application_area` STRING COMMENT 'Specific application or end‑use for the developed compound.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved financial budget allocated to the project.',
    `compliance_status` STRING COMMENT 'Current compliance standing with applicable regulations.. Valid values are `compliant|non_compliant|pending|exempt`',
    `confidentiality_level` STRING COMMENT 'Data classification for the projects information.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the project record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the budget.. Valid values are `USD|EUR|GBP|JPY|CNY|Other`',
    `expected_outcome` STRING COMMENT 'Qualitative description of the intended result of the project.',
    `external_partner` STRING COMMENT 'Name of any external CRO, university, or partner involved.',
    `ip_status` STRING COMMENT 'Current IP protection status for the project outcomes.. Valid values are `pending|granted|rejected|not_applicable`',
    `market_target` STRING COMMENT 'Primary market segment the project aims to serve.. Valid values are `automotive|agriculture|electronics|pharma|consumer_goods|other`',
    `milestone_1_date` DATE COMMENT 'Target or actual date for the first milestone.',
    `milestone_1_name` STRING COMMENT 'Name of the first key milestone.',
    `milestone_2_date` DATE COMMENT 'Target or actual date for the second milestone.',
    `milestone_2_name` STRING COMMENT 'Name of the second key milestone.',
    `patent_filing_status` STRING COMMENT 'Status of any patent applications arising from the project.. Valid values are `not_filed|filed|granted|rejected`',
    `phase` STRING COMMENT 'Current phase of the project within the innovation pipeline.. Valid values are `discovery|feasibility|scale_up|technology_transfer|completed|cancelled`',
    `planned_end_date` DATE COMMENT 'Target completion date as originally planned.',
    `priority_tier` STRING COMMENT 'Business priority assigned to the project.. Valid values are `high|medium|low`',
    `project_code` STRING COMMENT 'External business code or number assigned to the project for tracking across systems.',
    `project_description` STRING COMMENT 'Detailed description of the projects objectives, scope, and expected deliverables.',
    `project_name` STRING COMMENT 'Human‑readable name of the R&D project.',
    `project_status` STRING COMMENT 'Overall lifecycle status of the project.. Valid values are `active|on_hold|completed|cancelled|suspended`',
    `project_type` STRING COMMENT 'Categorization of the R&D effort.. Valid values are `new_compound|formulation|process_development|optimization|scale_up`',
    `regulatory_approval_required` BOOLEAN COMMENT 'Indicates whether the project outcome must obtain regulatory clearance.',
    `related_cas_numbers` STRING COMMENT 'Comma‑separated list of CAS numbers associated with the project.',
    `risk_level` STRING COMMENT 'Assessed risk category for the project.. Valid values are `low|moderate|high|critical`',
    `safety_review_status` STRING COMMENT 'Result of internal safety and hazard assessments.. Valid values are `approved|pending|rejected`',
    `sponsor_organization` STRING COMMENT 'Internal or external organization sponsoring the project.',
    `stage_gate_date` DATE COMMENT 'Date of the most recent stage‑gate review.',
    `stage_gate_status` STRING COMMENT 'Current stage‑gate decision point for the project.. Valid values are `gate1|gate2|gate3|gate4|gate5|completed`',
    `start_date` DATE COMMENT 'Planned start date of the project.',
    `success_criteria` STRING COMMENT 'Specific measurable criteria used to judge project success.',
    `technology_readiness_level` STRING COMMENT 'Standardized TRL rating (1‑9) indicating maturity of the technology.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the project record.',
    CONSTRAINT pk_project PRIMARY KEY(`project_id`)
) COMMENT 'Master record for R&D projects in the chemical manufacturing innovation pipeline. Captures project identity, objectives, scope, phase (discovery, feasibility, scale-up, technology transfer), priority tier, budget allocation, target application market (automotive, agriculture, electronics, etc.), project sponsor, lead scientist, start/end dates, current stage-gate status, and external collaboration context (partner organizations, CRO contracts, IP terms). Serves as the portfolio management backbone for all new compound development and formulation research initiatives, including open innovation partnerships.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`research`.`compound_registry` (
    `compound_registry_id` BIGINT COMMENT 'System-generated unique identifier for each compound record.',
    `ohs_risk_assessment_id` BIGINT COMMENT 'Reference to the risk assessment record linked to this compound.',
    `boiling_point_c` DECIMAL(18,2) COMMENT 'Temperature at which the compound transitions from liquid to gas at standard pressure.',
    `cas_number` STRING COMMENT 'Unique numeric identifier assigned by the CAS registry.. Valid values are `^d{2,7}-d{2}-d$`',
    `compound_type` STRING COMMENT 'Business classification of the compounds role in manufacturing.. Valid values are `intermediate|active_ingredient|additive|polymer|solvent`',
    `creation_timestamp` TIMESTAMP COMMENT 'Date and time when the compound record was first created in the system.',
    `density_g_per_cm3` DECIMAL(18,2) COMMENT 'Mass per unit volume of the compound at standard conditions.',
    `effective_date` DATE COMMENT 'Date from which the current record version is considered effective.',
    `environmental_impact_score` DECIMAL(18,2) COMMENT 'Composite score representing the compounds environmental impact.',
    `ghs_pictogram_codes` STRING COMMENT 'GHS hazard pictograms applicable to the compound.. Valid values are `GHS01|GHS02|GHS03|GHS04|GHS05|GHS06`',
    `hazard_classification` STRING COMMENT 'GHS hazard class and category for the compound. [ENUM-REF-CANDIDATE: acute_toxicity|skin_corrosion|eye_damage|respiratory_hazard|environmental_hazard|flammable|explosive|carcinogenic|mutagenic|reproductive_toxicity — promote to reference product]',
    `inchi_key` STRING COMMENT 'Fixed‑length hashed representation of the full InChI string.',
    `is_controlled_substance` BOOLEAN COMMENT 'True if the compound is subject to controlled substance regulations.',
    `is_hazardous` BOOLEAN COMMENT 'True if the compound is classified as hazardous under GHS.',
    `iupac_name` STRING COMMENT 'Official systematic chemical name according to IUPAC rules.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the compound record.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the compound record.. Valid values are `active|inactive|retired|draft|pending`',
    `melting_point_c` DECIMAL(18,2) COMMENT 'Temperature at which the compound transitions from solid to liquid.',
    `molecular_formula` STRING COMMENT 'Empirical formula representing the number and type of atoms in the molecule.',
    `molecular_weight` DECIMAL(18,2) COMMENT 'Exact mass of the compound expressed in grams per mole.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the compound.',
    `origin` STRING COMMENT 'Indicates whether the compound was internally synthesized, externally sourced, or licensed.. Valid values are `synthesized|sourced|licensed`',
    `patent_filing_date` DATE COMMENT 'Date on which the patent application was filed.',
    `patent_number` STRING COMMENT 'Identifier of the patent protecting the compound, if any.',
    `patent_status` STRING COMMENT 'Current status of the associated patent.. Valid values are `filed|granted|expired|rejected|pending`',
    `physical_state` STRING COMMENT 'Standard state of the compound at ambient conditions.. Valid values are `solid|liquid|gas|plasma`',
    `primary_application` STRING COMMENT 'Main industry or market segment where the compound is applied.. Valid values are `pharmaceutical|agricultural|industrial|consumer|research`',
    `purity_percent` DECIMAL(18,2) COMMENT 'Measured purity of the compound expressed as a percent.',
    `regulatory_body` STRING COMMENT 'Primary regulatory authority governing the compound.. Valid values are `EPA|ECHA|TSCA|FDA|OSHA`',
    `regulatory_status` STRING COMMENT 'Current regulatory approval state of the compound under applicable frameworks (e.g., TSCA, REACH).. Valid values are `approved|pending|rejected|withdrawn`',
    `restricted_use_flag` BOOLEAN COMMENT 'Indicates whether the compound is subject to restricted use regulations.',
    `shelf_life_days` STRING COMMENT 'Number of days the compound remains usable under recommended storage conditions.',
    `smiles_notation` STRING COMMENT 'Linear text representation of the compounds structure.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Maximum recommended storage temperature for the compound.',
    `structural_class` STRING COMMENT 'High‑level classification of the chemical structure (e.g., aromatic, aliphatic, heterocycle).',
    `synthesis_route` STRING COMMENT 'High‑level description of the synthetic pathway used to produce the compound.',
    `trade_name` STRING COMMENT 'Common commercial name used for the compound in the market.',
    `version_number` STRING COMMENT 'Version of the compound record for change tracking.',
    CONSTRAINT pk_compound_registry PRIMARY KEY(`compound_registry_id`)
) COMMENT 'Authoritative master registry of all chemical compounds developed or evaluated by the R&D organization. Stores compound name (IUPAC and trade), CAS number (assigned or pending), molecular formula, molecular weight, structural class, InChI key, SMILES notation, compound type (intermediate, active ingredient, additive, polymer), origin (synthesized, sourced, licensed), regulatory status under TSCA/REACH, and hazard classification per GHS. This is the SSOT for compound identity across the enterprise.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` (
    `experimental_formulation_id` BIGINT COMMENT 'Unique identifier for the experimental formulation record.',
    `employee_id` BIGINT COMMENT 'Identifier of the lead scientist responsible for the formulation.',
    `formula_version_id` BIGINT COMMENT 'Foreign key linking to formulation.formula_version. Business justification: Experimental Formulation Validation requires referencing the exact formula version being tested, enabling traceability from lab to production.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Formulation BOM requires a direct link to the primary raw material for sourcing, cost, and compliance; material_master_id provides this, removing duplicate cas_number.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: Pilot‑scale formulations are produced on specific pilot equipment; linking supports maintenance planning and equipment utilization analysis.',
    `project_id` BIGINT COMMENT 'Identifier of the R&D project to which this formulation belongs.',
    `safety_data_sheet_id` BIGINT COMMENT 'Reference to the associated Safety Data Sheet record.',
    `active_ingredient_concentration` DECIMAL(18,2) COMMENT 'Concentration value of the primary active ingredient.',
    `batch_number` STRING COMMENT 'Identifier for the specific batch used in experimental runs.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `blend_ratio_description` STRING COMMENT 'Narrative description of component blend ratios used in the formulation.',
    `concentration_unit` STRING COMMENT 'Unit of measure for active ingredient concentration.. Valid values are `ppm|wt_percent|mol_percent`',
    `cost_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated cost to scale the formulation to commercial production, expressed in USD.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the formulation record was first created.',
    `data_source_system` STRING COMMENT 'System that originated the record.. Valid values are `LabWare LIMS|Aspen HYSYS|SAP S/4HANA`',
    `effective_from` DATE COMMENT 'Date from which the formulation is considered effective for use.',
    `effective_until` DATE COMMENT 'Date until which the formulation remains effective (null if open-ended).',
    `experimental_end_date` DATE COMMENT 'Date when experimental work on the formulation concluded.',
    `experimental_formulation_status` STRING COMMENT 'Current lifecycle status of the experimental formulation.. Valid values are `draft|active|archived|transferred`',
    `experimental_start_date` DATE COMMENT 'Date when experimental work on the formulation began.',
    `formulation_code` STRING COMMENT 'Unique code assigned to the formulation for internal tracking.',
    `formulation_description` STRING COMMENT 'Detailed textual description of the formulation composition and purpose.',
    `ghs_classification` STRING COMMENT 'GHS hazard classification for the formulation.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle stage of the formulation within R&D.. Valid values are `in_development|validated|released|retired`',
    `lot_number` STRING COMMENT 'Lot identifier for raw material(s) used in the formulation.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `notes` STRING COMMENT 'Free-text field for any additional remarks or observations.',
    `patent_filing_number` STRING COMMENT 'Identifier of the patent filing associated with the formulation.',
    `patent_status` STRING COMMENT 'Current status of the related patent.. Valid values are `pending|granted|expired`',
    `ph_target_max` DECIMAL(18,2) COMMENT 'Maximum target pH value for the formulation.',
    `ph_target_min` DECIMAL(18,2) COMMENT 'Minimum target pH value for the formulation.',
    `reach_registration_number` STRING COMMENT 'Regulatory registration identifier under the REACH framework.. Valid values are `^[A-Z0-9]{8,12}$`',
    `regulatory_approval_status` STRING COMMENT 'Current status of regulatory approval for the formulation.. Valid values are `pending|approved|rejected`',
    `scale_up_feasibility` STRING COMMENT 'Qualitative assessment of the formulations feasibility for scale-up.. Valid values are `low|medium|high`',
    `solvent_system` STRING COMMENT 'Description of the solvent(s) used in the formulation.',
    `stability_study_required` BOOLEAN COMMENT 'Indicates whether a stability study is required for this formulation.',
    `stability_test_duration_days` STRING COMMENT 'Planned duration of the stability study in days.',
    `target_application` STRING COMMENT 'Intended end-use or application area for the experimental formulation (e.g., coating, adhesive).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the formulation record.',
    `version` STRING COMMENT 'Version identifier of the formulation record, e.g., v1.0, v2.1.',
    `viscosity_target` DECIMAL(18,2) COMMENT 'Desired viscosity value for the formulation.',
    `viscosity_unit` STRING COMMENT 'Unit of measure for viscosity target.. Valid values are `cP|mPa·s`',
    CONSTRAINT pk_experimental_formulation PRIMARY KEY(`experimental_formulation_id`)
) COMMENT 'Records lab-scale and pilot-scale experimental formulations developed during R&D. Captures formulation code, version, target application, blend ratios, active ingredient concentrations (PPM or weight percent), solvent system, pH target range, viscosity target, experimental status (draft, active, archived, transferred), associated compound registry entries, and the R&D project it belongs to. Distinct from the commercial formulation domain — these are pre-commercial, version-controlled research records managed in LabWare LIMS.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` (
    `synthesis_procedure_id` BIGINT COMMENT 'Unique identifier for the synthesis procedure.',
    `compound_registry_id` BIGINT COMMENT 'Foreign key linking to research.compound_registry. Business justification: Synthesis procedures are defined for a specific compound; adding compound_registry_id creates a direct link to the master compound record.',
    `equipment_id` BIGINT COMMENT 'Identifier of the primary reactor or equipment used.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Needed for SOP execution log; ties the operator performing the synthesis to employee for safety training compliance.',
    `research_process_simulation_id` BIGINT COMMENT 'Reference to the Aspen HYSYS simulation model linked to this procedure.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the procedure was approved.',
    `batch_number` STRING COMMENT 'Identifier of the trial batch associated with this procedure.',
    `catalyst` STRING COMMENT 'Catalyst used in the reaction, including name and grade.',
    `change_control_number` STRING COMMENT 'Management of Change (MOC) identifier associated with any amendment.',
    `cost_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated cost to execute the procedure at lab scale in US dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the procedure record was created.',
    `document_version` STRING COMMENT 'Version identifier of the attached procedure document.',
    `effective_from` DATE COMMENT 'Date from which the procedure is considered valid.',
    `effective_until` DATE COMMENT 'Date after which the procedure is no longer valid (nullable).',
    `emissions_co2_kg` DECIMAL(18,2) COMMENT 'Estimated CO₂ emissions for the procedure per batch.',
    `expected_yield_percent` DECIMAL(18,2) COMMENT 'Target yield expressed as a percentage of theoretical maximum.',
    `hazard_class` STRING COMMENT 'Primary hazard classification of the reaction according to GHS.. Valid values are `flammable|corrosive|toxic|reactive|environmental|none`',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the procedure is marked as critical for production scale‑up.',
    `is_patentable` BOOLEAN COMMENT 'Indicates whether the procedure is considered patentable.',
    `lab_location` STRING COMMENT 'Physical location or lab where the procedure is performed.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the procedure.. Valid values are `draft|active|retired|obsolete|pending_approval|rejected`',
    `notes` STRING COMMENT 'Free‑form notes captured by the chemist.',
    `patent_application_number` STRING COMMENT 'Identifier of the patent application linked to this procedure, if any.',
    `ph_range` STRING COMMENT 'Target pH range for the reaction, expressed as min‑max.',
    `pressure_bar` DECIMAL(18,2) COMMENT 'Operating pressure for the reaction in bar.',
    `procedure_code` STRING COMMENT 'Internal code used to reference the synthesis procedure.',
    `procedure_name` STRING COMMENT 'Human‑readable name of the synthesis procedure.',
    `reaction_time_minutes` STRING COMMENT 'Total duration of the reaction in minutes.',
    `reagent_list` STRING COMMENT 'Comma‑separated list of reagents with quantities and purity.',
    `regulatory_compliance_codes` STRING COMMENT 'Comma‑separated list of applicable regulatory codes (e.g., REACH, TSCA).',
    `review_comments` STRING COMMENT 'Comments from scientific review board.',
    `safety_precautions` STRING COMMENT 'Key safety measures and PPE required, aligned with PSM.',
    `scale_kg` DECIMAL(18,2) COMMENT 'Mass of the batch at lab scale in kilograms.',
    `solvent` STRING COMMENT 'Primary solvent employed in the reaction.',
    `sop_reference` STRING COMMENT 'Reference to the governing SOP document.',
    `synthesis_type` STRING COMMENT 'Category of chemical reaction performed.. Valid values are `condensation|polymerization|oxidation|hydrogenation|reduction|alkylation`',
    `temperature_c` DECIMAL(18,2) COMMENT 'Operating temperature for the reaction in degrees Celsius.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification.',
    `validation_status` STRING COMMENT 'Status of experimental validation of the procedure.. Valid values are `not_started|in_progress|completed|failed`',
    `version_number` STRING COMMENT 'Version of the procedure record.',
    `waste_generated_kg` DECIMAL(18,2) COMMENT 'Estimated amount of waste produced per batch in kilograms.',
    CONSTRAINT pk_synthesis_procedure PRIMARY KEY(`synthesis_procedure_id`)
) COMMENT 'Documented synthesis route and reaction procedure for producing a compound or intermediate at lab scale. Includes procedure code, reaction type (condensation, polymerization, oxidation, hydrogenation, etc.), reagent list, stoichiometry, reaction conditions (temperature, pressure, catalyst, solvent), expected yield range, safety precautions (PSM-relevant), SOP reference, version history, and approval status. Managed in LabWare LIMS and linked to Aspen HYSYS simulation records for scale-up feasibility.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` (
    `lab_experiment_id` BIGINT COMMENT 'Unique system-generated identifier for the laboratory experiment record.',
    `cas_registry_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.cas_registry. Business justification: Safety and compliance reporting ties each lab experiment to the official CAS registry entry; cas_registry_id replaces the free‑text cas_number.',
    `employee_id` BIGINT COMMENT 'Identifier of the R&D scientist responsible for executing the experiment.',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to maintenance.functional_location. Business justification: Required for safety, capacity, and regulatory reporting: each lab experiment is performed in a specific functional location (lab).',
    `equipment_id` BIGINT COMMENT 'Identifier of the primary equipment or instrument used during the experiment.',
    `project_id` BIGINT COMMENT 'Identifier of the R&D project under which the experiment is conducted.',
    `safety_data_sheet_id` BIGINT COMMENT 'Reference to the Safety Data Sheet associated with the chemical used.',
    `trial_batch_id` BIGINT COMMENT 'Identifier for the trial batch produced in this experiment.',
    `actual_duration_min` STRING COMMENT 'Actual elapsed time of the experiment in minutes.',
    `actual_pressure_bar` DECIMAL(18,2) COMMENT 'Measured pressure recorded during the experiment.',
    `actual_temperature_c` DECIMAL(18,2) COMMENT 'Measured temperature achieved during the experiment.',
    `analysis_software_version` STRING COMMENT 'Version of the software used to analyze experiment data.',
    `batch_number` STRING COMMENT 'Manufacturing batch number associated with the experimental material.',
    `corrective_action` STRING COMMENT 'Action taken to correct a deviation identified during the experiment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the experiment record was first created in the system.',
    `data_file_path` STRING COMMENT 'File system path or URI to raw data files generated by the experiment.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric score representing the overall quality of the experiment data.',
    `deviation_flag` BOOLEAN COMMENT 'Indicates whether the experiment deviated from the planned protocol.',
    `effectiveness_check` STRING COMMENT 'Result of the effectiveness assessment for corrective actions.. Valid values are `passed|failed|not_applicable`',
    `electronic_notebook_ref` STRING COMMENT 'Link or identifier to the electronic lab notebook entry documenting the experiment.',
    `end_timestamp` TIMESTAMP COMMENT 'Date and time when the experiment execution finished or was terminated.',
    `experiment_code` STRING COMMENT 'Business identifier assigned to the experiment, used for tracking and reporting.',
    `experiment_type` STRING COMMENT 'Category of the experiment indicating its purpose or methodology.. Valid values are `synthesis|screening|characterization|stability|compatibility`',
    `instrument_method` STRING COMMENT 'Analytical or synthesis method employed by the instrument.',
    `lab_experiment_status` STRING COMMENT 'Current lifecycle state of the experiment.. Valid values are `planned|in_progress|completed|failed|cancelled`',
    `notes` STRING COMMENT 'Free-text field for additional comments or observations.',
    `observed_outcome` STRING COMMENT 'Narrative description of the experimental result or observation.',
    `planned_duration_min` STRING COMMENT 'Intended duration of the experiment in minutes.',
    `planned_pressure_bar` DECIMAL(18,2) COMMENT 'Target pressure set for the experiment in bar.',
    `planned_temperature_c` DECIMAL(18,2) COMMENT 'Target temperature set for the experiment in degrees Celsius.',
    `preventive_action` STRING COMMENT 'Planned action to prevent recurrence of the identified issue.',
    `purity_percent` DECIMAL(18,2) COMMENT 'Measured purity of the final product expressed as a percentage.',
    `quality_control_flag` BOOLEAN COMMENT 'Indicates whether the experiment passed internal quality control criteria.',
    `regulatory_compliance_status` STRING COMMENT 'Indicates whether the experiment meets applicable regulatory requirements.. Valid values are `compliant|non_compliant|pending`',
    `root_cause` STRING COMMENT 'Identified root cause for any deviation or failure.',
    `sample_preparation_details` STRING COMMENT 'Description of how the sample was prepared prior to the experiment.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the experiment execution began.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the experiment record.',
    `verification_status` STRING COMMENT 'Status of verification for corrective/preventive actions.. Valid values are `pending|verified|rejected`',
    `yield_percent` DECIMAL(18,2) COMMENT 'Percentage of product obtained relative to theoretical maximum.',
    CONSTRAINT pk_lab_experiment PRIMARY KEY(`lab_experiment_id`)
) COMMENT 'Transactional record of an individual laboratory experiment or synthesis run executed by R&D scientists, serving as the primary execution and deviation management record. Captures experiment ID, type (synthesis, screening, characterization, stability, compatibility), assigned scientist, electronic lab notebook reference, start/end datetime, equipment used, actual conditions vs. planned, observed outcomes, yield, purity, experiment status (planned, in-progress, completed, failed, cancelled). For deviations and failures: root cause investigation findings, corrective actions taken, preventive measures, verification status, and effectiveness check outcome. Integrates with LabWare LIMS for execution tracking and serves as the R&D-specific deviation record supporting GMP compliance and continuous improvement.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`research`.`trial_batch` (
    `trial_batch_id` BIGINT COMMENT 'Primary key for trial_batch',
    `coa_document_id` BIGINT COMMENT 'Identifier of the COA document generated for this trial batch.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Batch production costs are charged to a cost center; linking trial batch to cost center enables accurate cost accounting and batch‑level expense tracking.',
    `employee_id` BIGINT COMMENT 'Identifier of the plant operator responsible for the batch run.',
    `equipment_id` BIGINT COMMENT 'Identifier of the reactor or vessel used for the trial batch run.',
    `experimental_formulation_id` BIGINT COMMENT 'Identifier of the experimental formulation being validated in this trial batch.',
    `lot_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.lot_record. Business justification: Regulatory traceability report requires linking each trial batch to the exact raw‑material lot used; lot_record_id provides this, replacing the denormalized lot_number.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the manufacturing site or plant where the trial batch was run.',
    `project_id` BIGINT COMMENT 'Identifier of the R&D project that owns this trial batch.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Batch production is driven by a work order; linking enables cost tracking, schedule alignment, and compliance reporting.',
    `actual_yield_percent` DECIMAL(18,2) COMMENT 'Measured product yield achieved in the trial batch.',
    `agitation_speed_rpm` STRING COMMENT 'Rotational speed of the agitator during the batch, in revolutions per minute.',
    `avg_temperature_c` DECIMAL(18,2) COMMENT 'Mean temperature across the batch duration, in degrees Celsius.',
    `batch_number` STRING COMMENT 'Human‑readable identifier assigned to the trial batch (often the LOT number).',
    `batch_size_kg` DECIMAL(18,2) COMMENT 'Planned total mass of material processed in the trial batch, expressed in kilograms.',
    `batch_version` STRING COMMENT 'Version number of the batch recipe or procedure used.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the trial batch record was first created in the system.',
    `disposition` STRING COMMENT 'Final disposition after evaluation (e.g., pass, fail, hold, rework).. Valid values are `pass|fail|hold|rework`',
    `emission_estimate_kg` DECIMAL(18,2) COMMENT 'Estimated mass of regulated emissions generated during the trial batch.',
    `energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Electrical energy consumed by the batch process, expressed in megawatt‑hours.',
    `feed_rate_kg_per_hr` DECIMAL(18,2) COMMENT 'Rate at which reactants were fed into the reactor, kilograms per hour.',
    `hazard_class` STRING COMMENT 'Regulatory hazard classification (e.g., GHS class 1‑6).. Valid values are `1|2|3|4|5|6`',
    `is_hazardous` BOOLEAN COMMENT 'True if the batch involved hazardous chemicals; otherwise false.',
    `max_temperature_c` DECIMAL(18,2) COMMENT 'Highest temperature recorded during the batch run, in degrees Celsius.',
    `min_temperature_c` DECIMAL(18,2) COMMENT 'Lowest temperature recorded during the batch run, in degrees Celsius.',
    `notes` STRING COMMENT 'Free‑form comments or observations captured by operators or scientists.',
    `process_end_timestamp` TIMESTAMP COMMENT 'Date‑time when the trial batch processing completed or was stopped.',
    `process_start_timestamp` TIMESTAMP COMMENT 'Date‑time when the trial batch processing began.',
    `quality_status` STRING COMMENT 'Result of quality control testing for the trial batch.. Valid values are `passed|failed|out_of_spec`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the batch met all applicable regulatory requirements (true) or not (false).',
    `safety_review_status` STRING COMMENT 'Status of the safety and regulatory review for the trial batch.. Valid values are `pending|approved|rejected`',
    `sampling_point_count` STRING COMMENT 'Number of intermediate sampling points taken for analysis during the batch.',
    `sampling_points_description` STRING COMMENT 'Free‑text description of sampling times, locations, and purposes.',
    `shift_code` STRING COMMENT 'Work shift during which the batch was executed.. Valid values are `A|B|C|D`',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Planned product yield expressed as a percentage of theoretical maximum.',
    `trial_batch_status` STRING COMMENT 'Current lifecycle status of the trial batch.. Valid values are `planned|in_progress|completed|failed|hold|rework`',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the trial batch record.',
    `waste_generated_kg` DECIMAL(18,2) COMMENT 'Total weight of waste material produced by the trial batch.',
    `yield_difference_percent` DECIMAL(18,2) COMMENT 'Difference between actual and target yield (actual – target).',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_trial_batch PRIMARY KEY(`trial_batch_id`)
) COMMENT 'Records pilot-scale and trial batch manufacturing runs executed to validate R&D formulations and synthesis procedures before technology transfer to commercial production. Captures trial batch number (LOT), batch size, reactor/vessel used, process parameters (temperature profile, agitation speed, feed rates), actual vs. target yield, intermediate sampling points, batch disposition (pass, fail, hold, rework), and linkage to the experimental formulation and synthesis procedure being validated. Bridges R&D and production domains.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` (
    `rd_stability_study_id` BIGINT COMMENT 'System-generated unique identifier for the stability study record.',
    `compound_registry_id` BIGINT COMMENT 'Reference to the chemical compound (CAS number) being evaluated.',
    `employee_id` BIGINT COMMENT 'Internal identifier of the scientist accountable for the study execution.',
    `experimental_formulation_id` BIGINT COMMENT 'Reference to the specific formulation or batch used in the study.',
    `lab_instrument_id` BIGINT COMMENT 'Reference to the analytical instrument used for measurements in the study.',
    `stability_study_id` BIGINT COMMENT 'FK to quality.stability_study.stability_study_id — R&D stability studies must link to quality stability study master for technology transfer and unified stability trending across development and commercial phases.',
    `acceptance_criteria_assay_percent` DECIMAL(18,2) COMMENT 'Minimum acceptable assay potency percentage for the product to pass the study.',
    `acceptance_criteria_color` STRING COMMENT 'Qualitative color change tolerance for the product.. Valid values are `no_change|slight|significant`',
    `acceptance_criteria_particulate_ppm` DECIMAL(18,2) COMMENT 'Maximum permissible particulate count expressed in parts per million.',
    `acceptance_criteria_ph` DECIMAL(18,2) COMMENT 'Acceptable pH range limit for the product during the study.',
    `acceptance_criteria_viscosity_cp` DECIMAL(18,2) COMMENT 'Maximum allowable viscosity (centipoise) for the product to be considered stable.',
    `actual_completion_date` DATE COMMENT 'Date on which the study was actually completed.',
    `batch_lot_number` STRING COMMENT 'Lot number of the experimental batch subjected to the stability study.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the stability study record was first created in the system.',
    `data_quality_status` STRING COMMENT 'Overall quality assessment of the study data.. Valid values are `valid|questionable|invalid`',
    `end_date` DATE COMMENT 'Planned completion date for the stability study.',
    `is_oos_flag` BOOLEAN COMMENT 'Indicates whether any measured parameter fell outside the predefined acceptance criteria.',
    `is_oot_flag` BOOLEAN COMMENT 'Indicates whether observed trends deviate from expected stability patterns.',
    `light_exposure_lux` DECIMAL(18,2) COMMENT 'Illuminance level applied for photostability studies, measured in lux.',
    `notes` STRING COMMENT 'Free-text field for additional observations, comments, or special instructions.',
    `rd_stability_study_status` STRING COMMENT 'Current lifecycle status of the stability study.. Valid values are `planned|in_progress|completed|closed|cancelled`',
    `regulatory_protocol_reference` STRING COMMENT 'Identifier or document reference for the regulatory protocol governing the study (e.g., ICH Q1A, EPA guideline).',
    `sampling_interval_months` STRING COMMENT 'Interval between scheduled sampling timepoints, expressed in months.',
    `shelf_life_estimate_months` STRING COMMENT 'Projected shelf life of the product based on study results, expressed in months.',
    `start_date` DATE COMMENT 'Date on which the stability study was initiated.',
    `storage_condition_description` STRING COMMENT 'Narrative description of the storage conditions (e.g., sealed, protected from light).',
    `study_code` STRING COMMENT 'Business-assigned alphanumeric code that uniquely identifies the stability study across systems.',
    `study_duration_months` STRING COMMENT 'Total planned duration of the stability study expressed in months.',
    `study_name` STRING COMMENT 'Descriptive name of the stability study, often reflecting the compound or formulation under test.',
    `study_type` STRING COMMENT 'Classification of the study based on the testing protocol applied.. Valid values are `accelerated|real_time|photostability|freeze_thaw`',
    `test_humidity_percent` DECIMAL(18,2) COMMENT 'Controlled relative humidity level for the study environment, expressed as a percentage.',
    `test_temperature_c` DECIMAL(18,2) COMMENT 'Controlled temperature at which the sample is stored during the study, expressed in degrees Celsius.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the stability study record.',
    `version_number` STRING COMMENT 'Version of the study record, incremented on substantive changes.',
    CONSTRAINT pk_rd_stability_study PRIMARY KEY(`rd_stability_study_id`)
) COMMENT 'Master and detail record for stability studies conducted on experimental compounds and formulations per ICH Q1A/Q1B, EPA, and internal protocols. Master level captures study ID, study type (accelerated, real-time, photostability, freeze-thaw), test conditions (temperature, humidity, light exposure), study duration, sampling intervals, acceptance criteria, regulatory protocol reference, study status, and responsible scientist. Detail level captures each scheduled timepoint: interval (T=0, T=1mo, T=3mo, T=6mo, etc.), actual test date, parameters measured (assay, pH, viscosity, color, particulate count, degradation products in PPM), pass/fail against criteria, OOS/OOT flags, analyst ID, and instrument reference. Supports shelf-life determination, trend analysis, and product registration.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`research`.`patent_filing` (
    `patent_filing_id` BIGINT COMMENT 'System-generated unique identifier for the patent filing record.',
    `licensing_agreement_id` BIGINT COMMENT 'Reference to the licensing agreement record, if any.',
    `project_id` BIGINT COMMENT 'Identifier of the R&D project that generated the invention disclosure.',
    `abstract` STRING COMMENT 'Brief summary of the invention disclosed in the patent application.',
    `attorney_contact` STRING COMMENT 'Primary email address of the attorney handling the filing.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `attorney_firm` STRING COMMENT 'Name of the law firm representing the patent applicant.',
    `confidentiality_level` STRING COMMENT 'Data classification level for the patent filing record.. Valid values are `public|internal|confidential|restricted`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Estimated monetary cost to file and prosecute the patent.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the patent filing record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for cost_amount.',
    `docket_number` STRING COMMENT 'Internal docket number used to track the filing within the organization.',
    `estimated_commercial_value_tier` STRING COMMENT 'Business‑level estimate of the potential commercial value of the invention.. Valid values are `low|medium|high|very_high`',
    `expiration_date` DATE COMMENT 'Date the patent rights expire (typically 20 years from priority date).',
    `filing_date` DATE COMMENT 'Date the patent application was officially filed with the patent office.',
    `filing_number` STRING COMMENT 'Unique number assigned by the patent office at the time of filing.',
    `fto_assessment_date` DATE COMMENT 'Date the FTO assessment was performed.',
    `fto_result` STRING COMMENT 'Outcome of the FTO assessment.. Valid values are `clear|risk|blocked`',
    `grant_date` DATE COMMENT 'Date the patent was granted by the patent office.',
    `inventor_names` STRING COMMENT 'Comma‑separated list of inventor full names; each name is considered PII.',
    `ip_committee_decision` STRING COMMENT 'Outcome of the internal IP committee review (approve, reject, or defer).. Valid values are `approve|reject|defer`',
    `is_freedom_to_operate_assessed` BOOLEAN COMMENT 'Indicates whether a freedom‑to‑operate (FTO) analysis has been completed.',
    `jurisdiction` STRING COMMENT 'Geographic jurisdiction or patent office where the application was filed.. Valid values are `US|EU|JP|CN|CA|AU`',
    `licensing_status` STRING COMMENT 'Whether the patented technology is currently licensed to third parties.. Valid values are `licensed|unlicensed|in_negotiation`',
    `maintenance_fee_due_date` DATE COMMENT 'Date by which the next maintenance fee must be paid to keep the patent in force.',
    `maintenance_fee_status` STRING COMMENT 'Current status of the upcoming maintenance fee.. Valid values are `due|paid|overdue`',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `patent_application_number` STRING COMMENT 'Official application number assigned by the patent office.',
    `patent_family_code` STRING COMMENT 'Identifier linking related patent applications that belong to the same family.',
    `patent_filing_status` STRING COMMENT 'Current lifecycle status of the patent filing. [ENUM-REF-CANDIDATE: draft|filed|published|granted|expired|abandoned|rejected — promote to reference product]. Valid values are `draft|filed|published|granted|expired|abandoned`',
    `patent_type` STRING COMMENT 'Classification of the patent (e.g., composition of matter, process, use, or product).. Valid values are `composition|process|use|product`',
    `prior_art_search_status` STRING COMMENT 'Progress status of the prior‑art search for the invention.. Valid values are `not_started|in_progress|completed`',
    `priority_claim_number` STRING COMMENT 'Number of the priority claim if the filing claims priority to an earlier application.',
    `priority_date` DATE COMMENT 'Date of the earliest filing that establishes priority for the invention.',
    `publication_date` DATE COMMENT 'Date the patent application was published and made publicly available.',
    `related_cas_numbers` STRING COMMENT 'Comma‑separated list of CAS numbers referenced in the invention.',
    `technology_area` STRING COMMENT 'High‑level technology domain of the invention.. Valid values are `pharma|agri|materials|specialty|energy|other`',
    `title` STRING COMMENT 'Official title of the invention as filed in the patent application.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the patent filing record.',
    CONSTRAINT pk_patent_filing PRIMARY KEY(`patent_filing_id`)
) COMMENT 'Master record for the full intellectual property lifecycle from invention disclosure through patent grant. Captures initial disclosure (inventors, novelty description, prior art search status, IP committee review decision, estimated commercial value tier), patent application details (filing number, jurisdiction, priority date, patent type — composition of matter, process, use), prosecution status, publication and grant dates, expiration, and legal status. Supports IP portfolio management, freedom-to-operate assessments, and innovation pipeline tracking from first scientist disclosure through granted protection.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` (
    `technology_transfer_id` BIGINT COMMENT 'Unique system-generated identifier for the technology transfer record.',
    `project_id` BIGINT COMMENT 'Identifier of the R&D project that originated the technology being transferred.',
    `transfer_package_document_id` BIGINT COMMENT 'Reference to the document package containing process description, BOM, SOP, COA specifications.',
    `associated_cas_numbers` STRING COMMENT 'Comma-separated list of CAS numbers related to the transferred chemical compounds.',
    `batch_number` STRING COMMENT 'Identifier of the trial batch associated with the technology transfer.',
    `compliance_status` STRING COMMENT 'Overall regulatory compliance status of the transferred technology.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the technology transfer record was first created in the system.',
    `deviation_notes` STRING COMMENT 'Notes describing any deviations identified during the transfer process.',
    `effective_from` TIMESTAMP COMMENT 'Timestamp from which the transfer information is considered effective for downstream processes.',
    `effective_until` TIMESTAMP COMMENT 'Timestamp indicating when the transfer information ceases to be effective, if applicable.',
    `ip_status` STRING COMMENT 'Current IP protection status of the transferred technology.. Valid values are `protected|public|restricted`',
    `manufacturing_signoff_date` TIMESTAMP COMMENT 'Date and time when manufacturing approved receipt of the technology.',
    `notes` STRING COMMENT 'Additional free-form notes related to the technology transfer.',
    `open_action_items` STRING COMMENT 'List of unresolved action items resulting from the transfer assessment.',
    `quality_status` STRING COMMENT 'Result of quality control assessment for the transferred technology.. Valid values are `passed|failed|pending`',
    `r_and_d_signoff_date` TIMESTAMP COMMENT 'Date and time when R&D authorized the technology transfer.',
    `readiness_checklist_completed` BOOLEAN COMMENT 'Indicates whether the predefined readiness checklist has been fully completed.',
    `readiness_checklist_date` TIMESTAMP COMMENT 'Date and time when the readiness checklist was marked complete.',
    `regulatory_approval_required` BOOLEAN COMMENT 'Indicates whether external regulatory approval is required for the transferred technology.',
    `regulatory_approval_status` STRING COMMENT 'Current status of any required regulatory approvals.. Valid values are `approved|pending|denied`',
    `safety_review_completed` BOOLEAN COMMENT 'Indicates whether a safety review has been completed for the transfer.',
    `safety_review_date` TIMESTAMP COMMENT 'Date and time when the safety review was finalized.',
    `technology_readiness_level` STRING COMMENT 'Numeric level (1-9) indicating the maturity of the technology being transferred.',
    `transfer_category` STRING COMMENT 'High-level classification of what is being transferred.. Valid values are `process|formulation|compound`',
    `transfer_cost_amount` DECIMAL(18,2) COMMENT 'Monetary cost associated with the technology transfer, including engineering and validation expenses.',
    `transfer_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the transfer cost.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `transfer_description` STRING COMMENT 'Free-text description summarizing the technology being transferred, objectives, and key considerations.',
    `transfer_end_date` DATE COMMENT 'Actual completion date of the technology transfer.',
    `transfer_number` STRING COMMENT 'Business-visible reference number for the technology transfer, used in documentation and tracking.. Valid values are `^TT-d{6}$`',
    `transfer_start_date` DATE COMMENT 'Planned start date of the technology transfer activity.',
    `transfer_status` STRING COMMENT 'Current lifecycle status of the technology transfer process.. Valid values are `draft|in_review|approved|rejected|completed`',
    `transfer_type` STRING COMMENT 'Classification of the transfer pathway indicating source and target production scale.. Valid values are `lab_to_pilot|pilot_to_commercial|lab_to_commercial`',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the technology transfer record.',
    `version_number` STRING COMMENT 'Incremental version number for the record to support optimistic concurrency.',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_technology_transfer PRIMARY KEY(`technology_transfer_id`)
) COMMENT 'Transactional record documenting the formal handoff of a validated R&D process, formulation, or compound from the R&D organization to commercial manufacturing. Captures transfer ID, transfer type (lab-to-pilot, pilot-to-commercial), sending R&D project, receiving production plant/site, transfer package documents (process description, BOM, SOP, COA specifications), readiness checklist completion status, sign-off dates by R&D and manufacturing, and any open action items or deviations noted during transfer. Integrates with SAP PP and MES.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` (
    `research_process_simulation_id` BIGINT COMMENT 'Primary key for process_simulation',
    `experimental_formulation_id` BIGINT COMMENT 'Reference to the formulation entity that this simulation evaluates.',
    `associated_procedure` STRING COMMENT 'Name or identifier of the laboratory synthesis procedure linked to this simulation.',
    `capital_cost_estimate_usd` DECIMAL(18,2) COMMENT 'Preliminary capital expenditure estimate for implementing the simulated process, expressed in US dollars.',
    `conversion_rate_percent` DECIMAL(18,2) COMMENT 'Primary conversion metric expressed as a percentage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the simulation record was first created.',
    `energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Total energy consumption of the simulated process in megawatt‑hours.',
    `feasibility_outcome` STRING COMMENT 'Result of the scale‑up feasibility assessment.. Valid values are `feasible|feasible_with_modifications|not_feasible`',
    `hazop_findings` STRING COMMENT 'Key findings from HAZOP or PHA analyses related to the simulated process.',
    `identified_scale_up_challenges` STRING COMMENT 'Narrative description of heat, mass, mixing, or safety challenges identified for scale‑up.',
    `model_tool` STRING COMMENT 'Software tool used to build and run the simulation.. Valid values are `Aspen HYSYS|Aspen Plus|CHEMCAD`',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `process_units_modeled` STRING COMMENT 'List of major process units (reactor, separator, heat exchanger, etc.) represented in the model.',
    `recommended_process_modifications` STRING COMMENT 'Suggested changes to equipment, operating conditions, or control strategies to improve feasibility.',
    `scale_factor` DECIMAL(18,2) COMMENT 'Factor by which the lab‑scale results are extrapolated (e.g., 10×).',
    `selectivity_percent` DECIMAL(18,2) COMMENT 'Selectivity of desired product relative to by‑products, expressed as a percentage.',
    `simulation_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the simulation execution completed.',
    `simulation_name` STRING COMMENT 'Human‑readable name of the simulation model.',
    `simulation_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the simulation execution began.',
    `simulation_status` STRING COMMENT 'Current lifecycle status of the simulation run.. Valid values are `planned|running|completed|failed`',
    `simulation_type` STRING COMMENT 'Classification of the simulation methodology.. Valid values are `steady_state|dynamic|heat_integration`',
    `thermodynamic_model` STRING COMMENT 'Thermodynamic correlation or equation of state applied in the simulation.. Valid values are `NRTL|UNIFAC|Peng-Robinson|Soave-Redlich-Kwong|Wilson`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the simulation record.',
    `validation_date` DATE COMMENT 'Date on which the simulation was validated.',
    `validation_status` STRING COMMENT 'Indicates whether simulation results have been validated against experimental data.. Valid values are `validated|not_validated|partial`',
    `version_number` STRING COMMENT 'Version number of the simulation model, incremented on each revision.',
    `yield_percent` DECIMAL(18,2) COMMENT 'Overall product yield from the simulated process, expressed as a percentage.',
    CONSTRAINT pk_research_process_simulation PRIMARY KEY(`research_process_simulation_id`)
) COMMENT 'Record of process simulation models and scale-up feasibility assessments for R&D compounds and formulations. Captures simulation ID, simulation name, associated synthesis procedure or formulation, simulation type (steady-state, dynamic, heat integration), process units modeled, key outputs (conversion rate, selectivity, energy consumption, yield), thermodynamic model used (NRTL, UNIFAC, Peng-Robinson, etc.), validation status against lab data, scale factor evaluated, identified scale-up challenges (heat transfer, mass transfer, mixing, safety), HAZOP/PHA findings, recommended process modifications, capital cost estimate, and feasibility outcome (feasible, feasible with modifications, not feasible). Enables data-driven scale-up decisions and supports go/no-go stage-gate reviews. Integrates with process simulation tools (Aspen HYSYS, Aspen Plus, CHEMCAD) for model import/export.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`research`.`analytical_method` (
    `analytical_method_id` BIGINT COMMENT 'System-generated unique identifier for the analytical method record.',
    `lab_instrument_id` BIGINT COMMENT 'Identifier of the instrument on which the method is performed.',
    `accuracy_percent` DECIMAL(18,2) COMMENT 'Closeness of measured value to the true value, expressed as a percentage.',
    `analytical_method_status` STRING COMMENT 'Current operational status of the method.. Valid values are `active|inactive|deprecated|retired|pending`',
    `applicable_matrix` STRING COMMENT 'Sample matrix or material type the method is validated for (e.g., water, soil, polymer).',
    `associated_cas_numbers` STRING COMMENT 'Comma‑separated list of CAS numbers relevant to the analytes covered by the method.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the method record was first created.',
    `data_quality_flag` STRING COMMENT 'Result of the most recent data quality assessment.. Valid values are `pass|fail|conditional`',
    `detection_limit` DECIMAL(18,2) COMMENT 'Lowest concentration of analyte that can be reliably detected by the method.',
    `detection_limit_units` STRING COMMENT 'Units for detection limit (e.g., ppm, mg/L).',
    `effective_date` DATE COMMENT 'Date when the method became officially effective for use.',
    `expiration_date` DATE COMMENT 'Date after which the method is considered obsolete (if applicable).',
    `instrument_type` STRING COMMENT 'Type or model of the instrument on which the method is performed.',
    `is_compendial` BOOLEAN COMMENT 'Indicates whether the method is a recognized compendial method.',
    `labware_method_code` STRING COMMENT 'Code used by LabWare LIMS to reference this method.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the last periodic review of the method.',
    `linearity_range_max` DECIMAL(18,2) COMMENT 'Maximum concentration where the method response remains linear.',
    `linearity_range_min` DECIMAL(18,2) COMMENT 'Minimum concentration where the method response is linear.',
    `linearity_units` STRING COMMENT 'Units for the linearity range (e.g., µg/mL).',
    `method_code` STRING COMMENT 'Internal code used to reference the method within LIMS and other systems.',
    `method_description` STRING COMMENT 'Detailed description of the analytical procedure.',
    `method_name` STRING COMMENT 'Human‑readable name of the analytical method.',
    `method_type` STRING COMMENT 'Technology category of the method (e.g., HPLC, GC).. Valid values are `HPLC|GC|NMR|FTIR|ICP-MS|titration`',
    `method_version` STRING COMMENT 'Version identifier for the method (e.g., v1.2).',
    `precision_percent` DECIMAL(18,2) COMMENT 'Repeatability expressed as %RSD across replicate injections.',
    `regulatory_compliance_reference` STRING COMMENT 'Regulatory or compendial standard the method complies with.. Valid values are `USP|ASTM|EPA|ISO|GHS|REACH`',
    `sample_preparation_notes` STRING COMMENT 'Procedural notes for preparing samples prior to analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the method record.',
    `validation_author` STRING COMMENT 'Name of the scientist or engineer who approved the validation.',
    `validation_date` DATE COMMENT 'Date on which the method was formally validated.',
    `validation_status` STRING COMMENT 'Current validation stage of the method.. Valid values are `development|validated|compendial`',
    CONSTRAINT pk_analytical_method PRIMARY KEY(`analytical_method_id`)
) COMMENT 'Master record for validated analytical methods used in R&D laboratory testing and characterization. Stores method ID, method name, method type (HPLC, GC, NMR, FTIR, ICP-MS, titration, rheology, particle size), applicable matrices, detection limits, linearity range, precision and accuracy parameters, validation status (development, validated, compendial), regulatory compliance reference (USP, ASTM, EPA method), instrument type, and LabWare LIMS method code. Serves as the SSOT for R&D analytical methodology.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`research`.`milestone` (
    `milestone_id` BIGINT COMMENT 'Primary key for milestone',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Milestone gate decisions require an approving authority; linking to employee enables audit trail and gate approval reports.',
    `project_id` BIGINT COMMENT 'Identifier of the parent R&D project.',
    `actual_completion_date` DATE COMMENT 'Date on which the milestone was actually finished; may be null if not yet completed.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Financial budget earmarked for activities associated with the milestone.',
    `compliance_status` STRING COMMENT 'Indicates whether the milestone meets applicable regulatory or internal compliance criteria.. Valid values are `compliant|non_compliant|pending|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the milestone record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the budget amount (e.g., USD, EUR).',
    `decision_rationale` STRING COMMENT 'Free‑text justification for the gate decision outcome.',
    `gate_decision_outcome` STRING COMMENT 'Result of the stage‑gate review: go, no‑go, conditional, or not applicable.. Valid values are `go|no_go|conditional|not_applicable`',
    `is_critical` BOOLEAN COMMENT 'True if the milestone is deemed critical for project delivery.',
    `milestone_name` STRING COMMENT 'Descriptive name of the milestone (e.g., "Formulation Prototype Complete").',
    `milestone_status` STRING COMMENT 'Operational status reflecting progress of the milestone.. Valid values are `not_started|in_progress|completed|delayed|cancelled`',
    `milestone_type` STRING COMMENT 'Category of the milestone indicating its purpose in the R&D stage‑gate workflow.. Valid values are `stage_gate|go_no_go|prototype_delivery|regulatory_submission|technology_transfer|other`',
    `notes` STRING COMMENT 'Supplementary comments or observations captured by the project team.',
    `planned_date` DATE COMMENT 'Target date on which the milestone is scheduled to be achieved.',
    `regulatory_submission_required` BOOLEAN COMMENT 'True if the milestone triggers a regulatory filing (e.g., FDA, REACH).',
    `risk_level` STRING COMMENT 'Qualitative risk rating assigned during project planning.. Valid values are `low|medium|high|critical`',
    `sequence` STRING COMMENT 'Numeric sequence indicating the position of the milestone in the project timeline.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the milestone record.',
    CONSTRAINT pk_milestone PRIMARY KEY(`milestone_id`)
) COMMENT 'Tracks stage-gate milestones and deliverables within R&D projects. Captures milestone ID, milestone name, milestone type (stage-gate review, go/no-go decision, prototype delivery, regulatory submission, technology transfer sign-off), planned date, actual completion date, milestone status (not started, in progress, completed, delayed, cancelled), gate decision outcome (go, no-go, conditional), decision rationale, and approving authority. Enables R&D portfolio governance and innovation pipeline visibility.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`research`.`sample` (
    `sample_id` BIGINT COMMENT 'Primary key for sample',
    `lab_experiment_id` BIGINT COMMENT 'Identifier of the experiment or trial batch linked to the sample.',
    `compound_registry_id` BIGINT COMMENT 'Foreign key linking to research.compound_registry. Business justification: Samples are physical instances of a compound; adding compound_registry_id links each sample to its master compound.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Sample custody is tracked for compliance; assigning a custodian employee supports chain‑of‑custody and disposal audits.',
    `safety_data_sheet_id` BIGINT COMMENT 'Reference to the Safety Data Sheet (SDS) associated with the sample.',
    `trial_batch_id` BIGINT COMMENT 'Identifier of the trial or production batch associated with the sample.',
    `analysis_results` STRING COMMENT 'Free‑text field capturing key analytical findings for the sample.',
    `cas_number` STRING COMMENT 'Chemical Abstracts Service registry number for the compound represented by the sample.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sample record was first created in the system.',
    `disposal_date` DATE COMMENT 'Date the sample was disposed.',
    `disposal_method` STRING COMMENT 'Method used to dispose of the sample when no longer needed.. Valid values are `incineration|landfill|chemical_neutralization|recycling|return_to_supplier`',
    `expiration_date` DATE COMMENT 'Date after which the sample is considered expired and must not be used.',
    `hazard_class` STRING COMMENT 'GHS hazard class of the sample.. Valid values are `flammable|corrosive|toxic|reactive|oxidizer|explosive`',
    `is_hazardous` BOOLEAN COMMENT 'True if the sample is classified as hazardous under GHS.',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp when the sample status last changed.',
    `light_sensitive` BOOLEAN COMMENT 'Indicates whether the sample is sensitive to light exposure.',
    `lot_number` STRING COMMENT 'Lot number assigned to the sample for traceability.',
    `notes` STRING COMMENT 'Additional comments or observations about the sample.',
    `ppe_required` BOOLEAN COMMENT 'Indicates whether special PPE is required when handling the sample.',
    `quality_control_status` STRING COMMENT 'Result of quality control testing performed on the sample.. Valid values are `passed|failed|pending`',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of material in the sample.',
    `regulatory_compliance_status` STRING COMMENT 'Indicates whether the sample meets applicable regulatory requirements.. Valid values are `compliant|non_compliant|pending`',
    `retention_period_days` STRING COMMENT 'Number of days the sample must be retained according to regulatory or project policy.',
    `sample_code` STRING COMMENT 'External reference code assigned to the sample, used in lab records and reports.',
    `sample_name` STRING COMMENT 'Human‑readable name or label for the sample.',
    `sample_status` STRING COMMENT 'Current lifecycle status of the sample.. Valid values are `available|in_test|consumed|expired|disposed`',
    `sample_type` STRING COMMENT 'Category describing the nature of the sample.. Valid values are `synthesized_compound|experimental_formulation|reference_standard|retained_sample|raw_material_evaluation`',
    `source_identifier` STRING COMMENT 'Identifier of the source entity (e.g., supplier batch number, field collection ID).',
    `source_type` STRING COMMENT 'Origin of the sample.. Valid values are `internal_synthesis|external_supplier|field_collection|customer_return`',
    `storage_humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity percentage of the storage environment.',
    `storage_location` STRING COMMENT 'Location code of the storage area (e.g., freezer, cabinet).',
    `storage_requirements` STRING COMMENT 'Textual description of any special storage conditions (e.g., inert atmosphere, refrigeration).',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Temperature condition of the storage environment in degrees Celsius.',
    `unit_of_measure` STRING COMMENT 'Unit used for the sample quantity.. Valid values are `kg|g|mg|L|mL|units`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the sample record.',
    CONSTRAINT pk_sample PRIMARY KEY(`sample_id`)
) COMMENT 'Tracks physical samples generated, received, tested, or distributed by the R&D laboratory throughout their lifecycle. Captures sample ID, sample type (synthesized compound, experimental formulation, reference standard, retained sample, raw material evaluation), source (internal synthesis, external supplier, field collection, customer return), associated experiment or trial batch, quantity and unit of measure, storage location and conditions (temperature, humidity, light sensitivity), chain of custody log with custodian transfers, retention period, expiration date, current status (available, in-test, consumed, expired, disposed), and disposal record with method. Managed in LabWare LIMS sample management module. Supports GLP/GMP sample traceability requirements.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` (
    `structure_activity_record_id` BIGINT COMMENT 'Unique identifier for the structure-activity relationship record.',
    `assay_id` BIGINT COMMENT 'Identifier of the assay or test method used to generate the activity data.',
    `employee_id` BIGINT COMMENT 'Employee who performed or oversaw the assay.',
    `lab_instrument_id` BIGINT COMMENT 'Identifier of the instrument or equipment used for the measurement.',
    `compound_registry_id` BIGINT COMMENT 'Internal identifier of the chemical compound (linked to the compound master data).',
    `safety_data_sheet_id` BIGINT COMMENT 'Reference to the associated Safety Data Sheet (SDS) record.',
    `activity_type` STRING COMMENT 'Category of the measured activity (e.g., efficacy, toxicity, solubility).. Valid values are `efficacy|toxicity|solubility|reactivity|thermal_stability|uv_resistance`',
    `activity_unit` STRING COMMENT 'Unit of measure for the activity value (e.g., mg/L, µM, %).',
    `activity_value` DECIMAL(18,2) COMMENT 'Numeric result of the activity measurement.',
    `batch_number` STRING COMMENT 'Identifier of the experimental batch associated with the measurement.',
    `concentration_mg_per_ml` DECIMAL(18,2) COMMENT 'Concentration of the compound in the assay solution.',
    `confidence_level` STRING COMMENT 'Qualitative confidence rating of the measurement.. Valid values are `high|medium|low`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SAR record was first created in the system.',
    `data_quality_flag` STRING COMMENT 'Indicator of the data quality for the measurement.. Valid values are `good|questionable|bad`',
    `is_control` BOOLEAN COMMENT 'True if the record represents a control sample; otherwise False.',
    `lot_number` STRING COMMENT 'Lot identifier for the material used in the assay.',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the activity measurement was recorded.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the measurement.',
    `ph` DECIMAL(18,2) COMMENT 'Measured pH of the assay solution.',
    `record_status` STRING COMMENT 'Current lifecycle status of the SAR record.. Valid values are `active|archived|deleted`',
    `regulatory_classification` STRING COMMENT 'Regulatory framework(s) applicable to the compound or activity.. Valid values are `REACH|TSCA|EPA|GHS|None`',
    `result_status` STRING COMMENT 'Overall status of the assay result.. Valid values are `passed|failed|inconclusive|pending`',
    `solvent` STRING COMMENT 'Name of the solvent used in the assay.',
    `source_system` STRING COMMENT 'Originating system that supplied the activity record.. Valid values are `labware_lims|aspen_hysys|custom_assay`',
    `temperature_c` DECIMAL(18,2) COMMENT 'Temperature at which the assay was conducted, expressed in degrees Celsius.',
    `test_condition_description` STRING COMMENT 'Free‑text description of any additional test conditions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the SAR record.',
    `version_number` STRING COMMENT 'Version of the SAR record for change tracking.',
    CONSTRAINT pk_structure_activity_record PRIMARY KEY(`structure_activity_record_id`)
) COMMENT 'Records structure-activity relationship (SAR) data linking molecular structural features to observed performance outcomes in chemical and agrochemical applications. Captures structural descriptors (functional groups, substituents, molecular fragments), activity type (efficacy, toxicity, solubility, reactivity, thermal stability, UV resistance), measured values with units, test system or assay used, and confidence level. Supports computational chemistry, lead optimization, and formulation design decisions in specialty chemical and crop protection R&D.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`research`.`licensing_agreement` (
    `licensing_agreement_id` BIGINT COMMENT 'Primary key for licensing_agreement',
    `compound_registry_id` BIGINT COMMENT 'Foreign key linking to research.compound_registry. Business justification: Licensing agreements reference specific chemical compounds; using a foreign key to compound_registry centralizes compound information and removes duplicated name and CAS fields.',
    `amended_licensing_agreement_id` BIGINT COMMENT 'Self-referencing FK on licensing_agreement (amended_licensing_agreement_id)',
    `agreement_number` STRING COMMENT 'External reference number assigned to the licensing agreement by the legal department.',
    `agreement_type` STRING COMMENT 'Category of the licensing agreement indicating the nature of rights granted.',
    `amendment_count` STRING COMMENT 'Number of times the agreement has been amended.',
    `audit_rights` STRING COMMENT 'Rights reserved by the licensor to audit compliance with the agreement.',
    `confidentiality_level` STRING COMMENT 'Level of confidentiality required for the licensed information.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the licensing agreement record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date on which the licensing agreement terminates, if applicable.',
    `effective_start_date` DATE COMMENT 'Date on which the licensing agreement becomes binding.',
    `exclusive_flag` BOOLEAN COMMENT 'Indicates whether the license is exclusive to the licensee.',
    `governing_law` STRING COMMENT 'Jurisdiction whose laws govern the agreement.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment to the agreement.',
    `license_scope` STRING COMMENT 'Description of the rights granted (e.g., manufacturing, distribution, research).',
    `licensee_contact_email` STRING COMMENT 'Primary email address for the licensees point of contact.',
    `licensee_contact_phone` STRING COMMENT 'Primary telephone number for the licensees point of contact.',
    `licensee_name` STRING COMMENT 'Legal name of the party receiving the license.',
    `licensor_contact_email` STRING COMMENT 'Primary email address for the licensors point of contact.',
    `licensor_contact_phone` STRING COMMENT 'Primary telephone number for the licensors point of contact.',
    `licensor_name` STRING COMMENT 'Legal name of the party granting the license.',
    `payment_frequency` STRING COMMENT 'How often royalty payments are due.',
    `payment_terms` STRING COMMENT 'Specific conditions governing payment (e.g., net 30, invoicing details).',
    `renewal_notice_period_days` STRING COMMENT 'Number of days prior to expiry that a renewal notice must be given.',
    `renewal_option` STRING COMMENT 'Whether the agreement can be renewed and how.',
    `reporting_requirements` STRING COMMENT 'Obligations for the licensee to report usage, sales, or other metrics.',
    `royalty_currency` STRING COMMENT 'ISO 4217 currency code for royalty payments.',
    `royalty_rate` DECIMAL(18,2) COMMENT 'Percentage of revenue payable as royalty to the licensor.',
    `signed_by` STRING COMMENT 'Name of the individual who signed the agreement on behalf of the licensor.',
    `signed_date` DATE COMMENT 'Date on which the agreement was signed by authorized parties.',
    `licensing_agreement_status` STRING COMMENT 'Current lifecycle state of the licensing agreement.',
    `termination_notice_period_days` STRING COMMENT 'Number of days required to notify termination of the agreement.',
    `territory` STRING COMMENT 'Geographic region(s) where the license rights are granted.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the licensing agreement record.',
    `usage_limit_quantity` DECIMAL(18,2) COMMENT 'Maximum amount of the compound that may be used under the agreement.',
    `usage_limit_unit` STRING COMMENT 'Unit of measure for the usage limit.',
    CONSTRAINT pk_licensing_agreement PRIMARY KEY(`licensing_agreement_id`)
) COMMENT 'Master reference table for licensing_agreement. Referenced by licensing_agreement_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`research`.`assay` (
    `assay_id` BIGINT COMMENT 'Primary key for assay',
    `compound_registry_id` BIGINT COMMENT 'Foreign key linking to research.compound_registry. Business justification: Assays are performed on specific chemical compounds; linking to the authoritative compound registry eliminates redundancy of storing CAS numbers and enables consistent compound data across the domain.',
    `replicate_assay_id` BIGINT COMMENT 'Self-referencing FK on assay (replicate_assay_id)',
    `accuracy` DECIMAL(18,2) COMMENT 'Typical accuracy (bias) of the assay expressed as a percentage.',
    `application` STRING COMMENT 'Typical application area (e.g., environmental monitoring, pharmaceutical QC).',
    `approved_date` DATE COMMENT 'Date on which the assay was formally approved for use.',
    `assay_category` STRING COMMENT 'High‑level grouping of the assay within the R&D portfolio.',
    `assay_notes` STRING COMMENT 'Free‑form comments or observations about the assay.',
    `assay_quality_flag` BOOLEAN COMMENT 'Indicates whether the assay has passed internal quality checks.',
    `assay_retention_period_days` STRING COMMENT 'Number of days the assay record must be retained for compliance.',
    `assay_status_reason` STRING COMMENT 'Explanation for the current status, such as deprecation rationale.',
    `assay_subcategory` STRING COMMENT 'More specific classification within the assay category.',
    `assay_version_number` STRING COMMENT 'Sequential integer version of the assay definition.',
    `assay_code` STRING COMMENT 'External code or catalogue number used to reference the assay in lab systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assay record was first created in the system.',
    `data_source` STRING COMMENT 'System or laboratory where assay data originates (e.g., LabWare LIMS).',
    `assay_description` STRING COMMENT 'Detailed textual description of the assay purpose, principle, and scope.',
    `detection_limit` DECIMAL(18,2) COMMENT 'Lowest concentration reliably detectable by the assay.',
    `expiry_date` DATE COMMENT 'Date after which the assay definition is considered obsolete.',
    `instrument` STRING COMMENT 'Primary analytical instrument used to perform the assay.',
    `is_control` BOOLEAN COMMENT 'Indicates whether the assay is designated as a control or reference assay.',
    `limit_of_quantitation` DECIMAL(18,2) COMMENT 'Lowest concentration at which the assay can reliably quantify the analyte.',
    `measurement_unit` STRING COMMENT 'Unit of measure for quantitative assay results (e.g., mg/L, ppm).',
    `method` STRING COMMENT 'Laboratory technique or analytical method employed (e.g., HPLC, GC‑MS, ELISA).',
    `assay_name` STRING COMMENT 'Human‑readable name of the assay.',
    `owner` STRING COMMENT 'Name of the person or group responsible for the assay.',
    `owner_department` STRING COMMENT 'Organizational department that owns the assay.',
    `precision` DECIMAL(18,2) COMMENT 'Typical precision (e.g., %RSD) of the assay at the target concentration.',
    `protocol` STRING COMMENT 'Reference to the detailed experimental protocol or SOP used for the assay.',
    `quantification_range` STRING COMMENT 'Concentration range over which the assay provides accurate quantification.',
    `regulatory_approval` STRING COMMENT 'Regulatory body or standard that has approved the assay (e.g., EPA Method 525).',
    `result_type` STRING COMMENT 'Indicates whether the assay yields quantitative measurements or qualitative outcomes.',
    `safety_classification` STRING COMMENT 'Safety level associated with handling the assay reagents or samples.',
    `sample_matrix` STRING COMMENT 'Typical sample type or matrix the assay is validated for (e.g., water, soil, serum).',
    `sop_reference` STRING COMMENT 'Identifier of the Standard Operating Procedure governing the assay.',
    `assay_status` STRING COMMENT 'Current lifecycle state of the assay definition.',
    `technology` STRING COMMENT 'Underlying technology platform (e.g., mass spectrometry, immunoassay).',
    `assay_type` STRING COMMENT 'Category describing the scientific discipline or technique of the assay.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the assay record.',
    `validation_status` STRING COMMENT 'Current validation state of the assay after method verification.',
    `version` STRING COMMENT 'Version identifier for the assay definition, reflecting revisions.',
    CONSTRAINT pk_assay PRIMARY KEY(`assay_id`)
) COMMENT 'Master reference table for assay. Referenced by assay_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`research`.`transfer_package_document` (
    `transfer_package_document_id` BIGINT COMMENT 'Primary key for transfer_package_document',
    `destination_location_site_id` BIGINT COMMENT 'Identifier of the receiving facility or location for the transfer.',
    `transfer_package_id` BIGINT COMMENT 'Identifier of the transfer package associated with this document.',
    `project_id` BIGINT COMMENT 'Identifier of the R&D project associated with the transfer.',
    `site_id` BIGINT COMMENT 'Identifier of the originating facility or location for the transfer.',
    `superseded_transfer_package_document_id` BIGINT COMMENT 'Self-referencing FK on transfer_package_document (superseded_transfer_package_document_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the document was approved.',
    `approved_by` STRING COMMENT 'Name of the individual who approved the document.',
    `batch_number` STRING COMMENT 'Manufacturing batch number of the chemical product being transferred.',
    `cas_number` STRING COMMENT 'Chemical Abstracts Service (CAS) registry number for the compound.',
    `checksum` STRING COMMENT 'Checksum (e.g., SHA-256) of the document file for integrity verification.',
    `chemical_name` STRING COMMENT 'Common name of the chemical compound in the transfer package.',
    `confidentiality_level` STRING COMMENT 'Data classification level of the document.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the document record was first created in the system.',
    `document_file_path` STRING COMMENT 'File system or storage path where the document PDF is stored.',
    `document_number` STRING COMMENT 'Unique business identifier assigned to the document (e.g., D-2023-0012).',
    `document_title` STRING COMMENT 'Title of the transfer package document.',
    `document_type` STRING COMMENT 'Category of the document describing the nature of the transfer package.',
    `effective_date` DATE COMMENT 'Date from which the document is considered effective for the transfer.',
    `emergency_contact` STRING COMMENT 'Emergency contact phone number for the transfer operation.',
    `expiration_date` DATE COMMENT 'Date after which the document is no longer valid.',
    `is_hazardous` BOOLEAN COMMENT 'Indicates whether the transferred chemical is classified as hazardous.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the document.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of the chemical transferred, expressed in the unit specified.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the quantity field.',
    `regulatory_compliance_status` STRING COMMENT 'Regulatory compliance status of the transfer package document.',
    `revision_number` STRING COMMENT 'Revision number of the document (incremental).',
    `safety_data_sheet_version` STRING COMMENT 'Version of the Safety Data Sheet (SDS) referenced.',
    `transfer_package_document_status` STRING COMMENT 'Current lifecycle status of the document.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the document record.',
    `version_number` STRING COMMENT 'Version label of the document (e.g., v1.0).',
    CONSTRAINT pk_transfer_package_document PRIMARY KEY(`transfer_package_document_id`)
) COMMENT 'Master reference table for transfer_package_document. Referenced by transfer_package_document_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`research`.`transfer_package` (
    `transfer_package_id` BIGINT COMMENT 'Primary key for transfer_package',
    `superseded_transfer_package_id` BIGINT COMMENT 'Self-referencing FK on transfer_package (superseded_transfer_package_id)',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual time when the transfer completed.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual time when the transfer began.',
    `carrier_id` BIGINT COMMENT 'Identifier of the logistics carrier responsible for moving the package.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the transfer package record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.',
    `destination_location_id` BIGINT COMMENT 'Identifier of the receiving facility or warehouse for the transfer.',
    `gross_cost` DECIMAL(18,2) COMMENT 'Total cost before taxes and discounts for the transfer.',
    `hazard_classification` STRING COMMENT 'Regulatory hazard class of the material being transferred.',
    `net_cost` DECIMAL(18,2) COMMENT 'Final cost after taxes and discounts for the transfer.',
    `package_number` STRING COMMENT 'External business identifier assigned to the transfer package, used in shipping documents and tracking systems.',
    `quantity` DECIMAL(18,2) COMMENT 'Numeric amount of the material being transferred.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned completion time for the transfer operation.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned start time for the transfer operation.',
    `source_location_id` BIGINT COMMENT 'Identifier of the originating facility or warehouse for the transfer.',
    `special_handling_instructions` STRING COMMENT 'Any additional handling requirements or notes for the transfer.',
    `transfer_package_status` STRING COMMENT 'Current lifecycle status of the transfer package.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the transfer cost.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the package requires temperature-controlled transport.',
    `transfer_method` STRING COMMENT 'Mode of transportation used for the package.',
    `transfer_timestamp` TIMESTAMP COMMENT 'Timestamp when the transfer was officially initiated.',
    `unit_of_measure` STRING COMMENT 'Unit associated with the transfer quantity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the transfer package record.',
    `volume_m3` DECIMAL(18,2) COMMENT 'Total volume of the package in cubic meters.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the package in kilograms.',
    CONSTRAINT pk_transfer_package PRIMARY KEY(`transfer_package_id`)
) COMMENT 'Master reference table for transfer_package. Referenced by package_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ADD CONSTRAINT `fk_research_experimental_formulation_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ADD CONSTRAINT `fk_research_synthesis_procedure_compound_registry_id` FOREIGN KEY (`compound_registry_id`) REFERENCES `chemical_mfg_ecm`.`research`.`compound_registry`(`compound_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ADD CONSTRAINT `fk_research_synthesis_procedure_research_process_simulation_id` FOREIGN KEY (`research_process_simulation_id`) REFERENCES `chemical_mfg_ecm`.`research`.`research_process_simulation`(`research_process_simulation_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ADD CONSTRAINT `fk_research_lab_experiment_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ADD CONSTRAINT `fk_research_lab_experiment_trial_batch_id` FOREIGN KEY (`trial_batch_id`) REFERENCES `chemical_mfg_ecm`.`research`.`trial_batch`(`trial_batch_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ADD CONSTRAINT `fk_research_trial_batch_experimental_formulation_id` FOREIGN KEY (`experimental_formulation_id`) REFERENCES `chemical_mfg_ecm`.`research`.`experimental_formulation`(`experimental_formulation_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ADD CONSTRAINT `fk_research_trial_batch_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ADD CONSTRAINT `fk_research_rd_stability_study_compound_registry_id` FOREIGN KEY (`compound_registry_id`) REFERENCES `chemical_mfg_ecm`.`research`.`compound_registry`(`compound_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ADD CONSTRAINT `fk_research_rd_stability_study_experimental_formulation_id` FOREIGN KEY (`experimental_formulation_id`) REFERENCES `chemical_mfg_ecm`.`research`.`experimental_formulation`(`experimental_formulation_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ADD CONSTRAINT `fk_research_patent_filing_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `chemical_mfg_ecm`.`research`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ADD CONSTRAINT `fk_research_patent_filing_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ADD CONSTRAINT `fk_research_technology_transfer_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ADD CONSTRAINT `fk_research_technology_transfer_transfer_package_document_id` FOREIGN KEY (`transfer_package_document_id`) REFERENCES `chemical_mfg_ecm`.`research`.`transfer_package_document`(`transfer_package_document_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ADD CONSTRAINT `fk_research_research_process_simulation_experimental_formulation_id` FOREIGN KEY (`experimental_formulation_id`) REFERENCES `chemical_mfg_ecm`.`research`.`experimental_formulation`(`experimental_formulation_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ADD CONSTRAINT `fk_research_milestone_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ADD CONSTRAINT `fk_research_sample_lab_experiment_id` FOREIGN KEY (`lab_experiment_id`) REFERENCES `chemical_mfg_ecm`.`research`.`lab_experiment`(`lab_experiment_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ADD CONSTRAINT `fk_research_sample_compound_registry_id` FOREIGN KEY (`compound_registry_id`) REFERENCES `chemical_mfg_ecm`.`research`.`compound_registry`(`compound_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ADD CONSTRAINT `fk_research_sample_trial_batch_id` FOREIGN KEY (`trial_batch_id`) REFERENCES `chemical_mfg_ecm`.`research`.`trial_batch`(`trial_batch_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ADD CONSTRAINT `fk_research_structure_activity_record_assay_id` FOREIGN KEY (`assay_id`) REFERENCES `chemical_mfg_ecm`.`research`.`assay`(`assay_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ADD CONSTRAINT `fk_research_structure_activity_record_compound_registry_id` FOREIGN KEY (`compound_registry_id`) REFERENCES `chemical_mfg_ecm`.`research`.`compound_registry`(`compound_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`licensing_agreement` ADD CONSTRAINT `fk_research_licensing_agreement_compound_registry_id` FOREIGN KEY (`compound_registry_id`) REFERENCES `chemical_mfg_ecm`.`research`.`compound_registry`(`compound_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`licensing_agreement` ADD CONSTRAINT `fk_research_licensing_agreement_amended_licensing_agreement_id` FOREIGN KEY (`amended_licensing_agreement_id`) REFERENCES `chemical_mfg_ecm`.`research`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`assay` ADD CONSTRAINT `fk_research_assay_compound_registry_id` FOREIGN KEY (`compound_registry_id`) REFERENCES `chemical_mfg_ecm`.`research`.`compound_registry`(`compound_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`assay` ADD CONSTRAINT `fk_research_assay_replicate_assay_id` FOREIGN KEY (`replicate_assay_id`) REFERENCES `chemical_mfg_ecm`.`research`.`assay`(`assay_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`transfer_package_document` ADD CONSTRAINT `fk_research_transfer_package_document_transfer_package_id` FOREIGN KEY (`transfer_package_id`) REFERENCES `chemical_mfg_ecm`.`research`.`transfer_package`(`transfer_package_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`transfer_package_document` ADD CONSTRAINT `fk_research_transfer_package_document_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`transfer_package_document` ADD CONSTRAINT `fk_research_transfer_package_document_superseded_transfer_package_document_id` FOREIGN KEY (`superseded_transfer_package_document_id`) REFERENCES `chemical_mfg_ecm`.`research`.`transfer_package_document`(`transfer_package_document_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`transfer_package` ADD CONSTRAINT `fk_research_transfer_package_superseded_transfer_package_id` FOREIGN KEY (`superseded_transfer_package_id`) REFERENCES `chemical_mfg_ecm`.`research`.`transfer_package`(`transfer_package_id`);

-- ========= TAGS =========
ALTER SCHEMA `chemical_mfg_ecm`.`research` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `chemical_mfg_ecm`.`research` SET TAGS ('dbx_domain' = 'research');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` SET TAGS ('dbx_subdomain' = 'project_management');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Scientist Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Project End Date');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `application_area` SET TAGS ('dbx_business_glossary_term' = 'Application Area');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Amount');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|exempt');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY|Other');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `expected_outcome` SET TAGS ('dbx_business_glossary_term' = 'Expected Project Outcome');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `external_partner` SET TAGS ('dbx_business_glossary_term' = 'External Partner Organization');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `ip_status` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property Status');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `ip_status` SET TAGS ('dbx_value_regex' = 'pending|granted|rejected|not_applicable');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `market_target` SET TAGS ('dbx_business_glossary_term' = 'Target Market Segment');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `market_target` SET TAGS ('dbx_value_regex' = 'automotive|agriculture|electronics|pharma|consumer_goods|other');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `milestone_1_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone 1 Date');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `milestone_1_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone 1 Name');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `milestone_2_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone 2 Date');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `milestone_2_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone 2 Name');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `patent_filing_status` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Status');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `patent_filing_status` SET TAGS ('dbx_value_regex' = 'not_filed|filed|granted|rejected');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `phase` SET TAGS ('dbx_business_glossary_term' = 'R&D Project Phase');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `phase` SET TAGS ('dbx_value_regex' = 'discovery|feasibility|scale_up|technology_transfer|completed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Project End Date');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Project Priority Tier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `priority_tier` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'R&D Project Code');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'R&D Project Description');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'R&D Project Name');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'R&D Project Status');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `project_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|completed|cancelled|suspended');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'new_compound|formulation|process_development|optimization|scale_up');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `related_cas_numbers` SET TAGS ('dbx_business_glossary_term' = 'Related CAS Numbers');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Project Risk Level');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `safety_review_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Review Status');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `safety_review_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `sponsor_organization` SET TAGS ('dbx_business_glossary_term' = 'Project Sponsor Organization');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `stage_gate_date` SET TAGS ('dbx_business_glossary_term' = 'Stage‑Gate Date');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `stage_gate_status` SET TAGS ('dbx_business_glossary_term' = 'Stage‑Gate Status');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `stage_gate_status` SET TAGS ('dbx_value_regex' = 'gate1|gate2|gate3|gate4|gate5|completed');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `success_criteria` SET TAGS ('dbx_business_glossary_term' = 'Success Criteria');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `technology_readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Technology Readiness Level (TRL)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` SET TAGS ('dbx_subdomain' = 'compound_development');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `compound_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Compound Registry Identifier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `ohs_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Identifier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `boiling_point_c` SET TAGS ('dbx_business_glossary_term' = 'Boiling Point (°C)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'CAS Number (Chemical Abstracts Service Registry Number)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^d{2,7}-d{2}-d$');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `compound_type` SET TAGS ('dbx_business_glossary_term' = 'Compound Type');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `compound_type` SET TAGS ('dbx_value_regex' = 'intermediate|active_ingredient|additive|polymer|solvent');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `density_g_per_cm3` SET TAGS ('dbx_business_glossary_term' = 'Density (g/cm³)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `environmental_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Score');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `ghs_pictogram_codes` SET TAGS ('dbx_business_glossary_term' = 'GHS Pictogram Codes');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `ghs_pictogram_codes` SET TAGS ('dbx_value_regex' = 'GHS01|GHS02|GHS03|GHS04|GHS05|GHS06');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification (GHS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `inchi_key` SET TAGS ('dbx_business_glossary_term' = 'InChI Key (International Chemical Identifier Key)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `is_controlled_substance` SET TAGS ('dbx_business_glossary_term' = 'Is Controlled Substance');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `iupac_name` SET TAGS ('dbx_business_glossary_term' = 'IUPAC Name (International Union of Pure and Applied Chemistry)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|draft|pending');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `melting_point_c` SET TAGS ('dbx_business_glossary_term' = 'Melting Point (°C)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `molecular_formula` SET TAGS ('dbx_business_glossary_term' = 'Molecular Formula');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `molecular_weight` SET TAGS ('dbx_business_glossary_term' = 'Molecular Weight (g/mol)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `origin` SET TAGS ('dbx_business_glossary_term' = 'Origin (Source of Compound)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `origin` SET TAGS ('dbx_value_regex' = 'synthesized|sourced|licensed');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `patent_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Date');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `patent_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Number');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `patent_status` SET TAGS ('dbx_business_glossary_term' = 'Patent Status');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `patent_status` SET TAGS ('dbx_value_regex' = 'filed|granted|expired|rejected|pending');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `physical_state` SET TAGS ('dbx_business_glossary_term' = 'Physical State');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `physical_state` SET TAGS ('dbx_value_regex' = 'solid|liquid|gas|plasma');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `primary_application` SET TAGS ('dbx_business_glossary_term' = 'Primary Application');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `primary_application` SET TAGS ('dbx_value_regex' = 'pharmaceutical|agricultural|industrial|consumer|research');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `purity_percent` SET TAGS ('dbx_business_glossary_term' = 'Purity Percentage');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'EPA|ECHA|TSCA|FDA|OSHA');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|withdrawn');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `restricted_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Restricted Use Flag');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `smiles_notation` SET TAGS ('dbx_business_glossary_term' = 'SMILES Notation (Simplified Molecular Input Line Entry System)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Recommended Storage Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `structural_class` SET TAGS ('dbx_business_glossary_term' = 'Structural Class');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `synthesis_route` SET TAGS ('dbx_business_glossary_term' = 'Synthesis Route Description');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Name (Commercial Name)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` SET TAGS ('dbx_subdomain' = 'compound_development');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `experimental_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Formulation ID');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Scientist Identifier (SCIENTIST_ID)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Pilot Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Associated R&D Project Identifier (PROJECT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Identifier (SDS_ID)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `active_ingredient_concentration` SET TAGS ('dbx_business_glossary_term' = 'Active Ingredient Concentration (AIC)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (BATCH_NO)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `blend_ratio_description` SET TAGS ('dbx_business_glossary_term' = 'Blend Ratio Description (BLEND_DESC)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_business_glossary_term' = 'Concentration Unit (CONC_UNIT)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_value_regex' = 'ppm|wt_percent|mol_percent');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate (USD) (COST_EST_USD)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Record (SOURCE_SYS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'LabWare LIMS|Aspen HYSYS|SAP S/4HANA');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `experimental_end_date` SET TAGS ('dbx_business_glossary_term' = 'Experimental End Date (EXP_END_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `experimental_formulation_status` SET TAGS ('dbx_business_glossary_term' = 'Experimental Formulation Status (STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `experimental_formulation_status` SET TAGS ('dbx_value_regex' = 'draft|active|archived|transferred');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `experimental_start_date` SET TAGS ('dbx_business_glossary_term' = 'Experimental Start Date (EXP_START_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `formulation_code` SET TAGS ('dbx_business_glossary_term' = 'Formulation Code (FCODE)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `formulation_description` SET TAGS ('dbx_business_glossary_term' = 'Formulation Description (DESC)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System Classification (GHS_CLASS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LIFECYCLE_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'in_development|validated|released|retired');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT_NO)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `patent_filing_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Number (PATENT_NO)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `patent_status` SET TAGS ('dbx_business_glossary_term' = 'Patent Status (PATENT_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `patent_status` SET TAGS ('dbx_value_regex' = 'pending|granted|expired');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `ph_target_max` SET TAGS ('dbx_business_glossary_term' = 'Target pH Maximum (PH_MAX)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `ph_target_min` SET TAGS ('dbx_business_glossary_term' = 'Target pH Minimum (PH_MIN)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'REACH Registration Number (REACH_REG_NO)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status (REG_APPROVAL_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `scale_up_feasibility` SET TAGS ('dbx_business_glossary_term' = 'Scale-up Feasibility Assessment (SCALE_UP_FEAS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `scale_up_feasibility` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `solvent_system` SET TAGS ('dbx_business_glossary_term' = 'Solvent System (SOLVENT_SYS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `stability_study_required` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Required Flag (STABILITY_REQ)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `stability_test_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Stability Test Duration (Days) (STAB_DUR_DAYS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `target_application` SET TAGS ('dbx_business_glossary_term' = 'Target Application (APP)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Formulation Version (VER)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `viscosity_target` SET TAGS ('dbx_business_glossary_term' = 'Viscosity Target (VISC_TARGET)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `viscosity_unit` SET TAGS ('dbx_business_glossary_term' = 'Viscosity Unit (VISC_UNIT)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ALTER COLUMN `viscosity_unit` SET TAGS ('dbx_value_regex' = 'cP|mPa·s');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` SET TAGS ('dbx_subdomain' = 'compound_development');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `synthesis_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Synthesis Procedure ID');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `compound_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Compound Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `research_process_simulation_id` SET TAGS ('dbx_business_glossary_term' = 'Simulation Model ID');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `catalyst` SET TAGS ('dbx_business_glossary_term' = 'Catalyst');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number (MOC)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate (USD)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `emissions_co2_kg` SET TAGS ('dbx_business_glossary_term' = 'CO₂ Emissions (kg)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `expected_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected Yield Percentage (YIELD%)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `hazard_class` SET TAGS ('dbx_value_regex' = 'flammable|corrosive|toxic|reactive|environmental|none');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Procedure Flag');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `is_patentable` SET TAGS ('dbx_business_glossary_term' = 'Patentable Flag');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `lab_location` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Location');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|retired|obsolete|pending_approval|rejected');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `patent_application_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Application Number');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `ph_range` SET TAGS ('dbx_business_glossary_term' = 'pH Range');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `pressure_bar` SET TAGS ('dbx_business_glossary_term' = 'Reaction Pressure (bar)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `procedure_name` SET TAGS ('dbx_business_glossary_term' = 'Procedure Name');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `reaction_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Reaction Time (minutes)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `reagent_list` SET TAGS ('dbx_business_glossary_term' = 'Reagent List');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `regulatory_compliance_codes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Codes');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `review_comments` SET TAGS ('dbx_business_glossary_term' = 'Review Comments');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `safety_precautions` SET TAGS ('dbx_business_glossary_term' = 'Safety Precautions');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `scale_kg` SET TAGS ('dbx_business_glossary_term' = 'Scale (kg)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `solvent` SET TAGS ('dbx_business_glossary_term' = 'Solvent');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `sop_reference` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure Reference (SOP)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `synthesis_type` SET TAGS ('dbx_business_glossary_term' = 'Synthesis Type (Reaction Type)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `synthesis_type` SET TAGS ('dbx_value_regex' = 'condensation|polymerization|oxidation|hydrogenation|reduction|alkylation');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Reaction Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ALTER COLUMN `waste_generated_kg` SET TAGS ('dbx_business_glossary_term' = 'Waste Generated (kg)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` SET TAGS ('dbx_subdomain' = 'process_scaleup');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `lab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Experiment Identifier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Cas Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Scientist Identifier (SCIENTIST_ID)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Equipment Identifier (EQPT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (PROJ_ID)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Identifier (SDS_ID)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `trial_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Batch Identifier (TRIAL_BATCH_ID)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `actual_duration_min` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration (minutes) (ACT_DUR_MIN)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `actual_pressure_bar` SET TAGS ('dbx_business_glossary_term' = 'Actual Pressure (bar) (ACT_PRESS_BAR)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `actual_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Actual Temperature (°C) (ACT_TEMP_C)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `analysis_software_version` SET TAGS ('dbx_business_glossary_term' = 'Analysis Software Version (ANL_SOFT_VER)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (BATCH_NO)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action (CORR_ACTION)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATE_TSTMP)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `data_file_path` SET TAGS ('dbx_business_glossary_term' = 'Data File Path (DATA_FILE_PATH)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score (DQ_SCORE)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Deviation Flag (DEVIATION_FLG)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `effectiveness_check` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Result (EFFECT_CHECK)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `effectiveness_check` SET TAGS ('dbx_value_regex' = 'passed|failed|not_applicable');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `electronic_notebook_ref` SET TAGS ('dbx_business_glossary_term' = 'Electronic Lab Notebook Reference (ELN_REF)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Experiment End Timestamp (EXPT_END_TSTMP)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `experiment_code` SET TAGS ('dbx_business_glossary_term' = 'Experiment Code (EXPT_CD)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `experiment_type` SET TAGS ('dbx_business_glossary_term' = 'Experiment Type (EXPT_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `experiment_type` SET TAGS ('dbx_value_regex' = 'synthesis|screening|characterization|stability|compatibility');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `instrument_method` SET TAGS ('dbx_business_glossary_term' = 'Instrument Method (INST_METHOD)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `lab_experiment_status` SET TAGS ('dbx_business_glossary_term' = 'Experiment Status (EXPT_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `lab_experiment_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|failed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Experiment Notes (EXPT_NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `observed_outcome` SET TAGS ('dbx_business_glossary_term' = 'Observed Outcome (OBS_OUTCOME)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `planned_duration_min` SET TAGS ('dbx_business_glossary_term' = 'Planned Duration (minutes) (PLAN_DUR_MIN)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `planned_pressure_bar` SET TAGS ('dbx_business_glossary_term' = 'Plated Pressure (bar) (PLAN_PRESS_BAR)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `planned_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Planned Temperature (°C) (PLAN_TEMP_C)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `preventive_action` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action (PREV_ACTION)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `purity_percent` SET TAGS ('dbx_business_glossary_term' = 'Purity Percentage (PURITY_PCT)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `quality_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Flag (QC_FLG)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status (REG_COMP_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (ROOT_CAUSE)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `sample_preparation_details` SET TAGS ('dbx_business_glossary_term' = 'Sample Preparation Details (SAMPLE_PREP)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Experiment Start Timestamp (EXPT_START_TSTMP)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (REC_UPDATE_TSTMP)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status (VERIF_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|rejected');
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ALTER COLUMN `yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage (YIELD_PCT)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` SET TAGS ('dbx_subdomain' = 'process_scaleup');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `trial_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Batch Identifier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `coa_document_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis ID');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Reactor/Vessel ID');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `experimental_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Formulation ID');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `lot_record_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Location ID');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'R&D Project ID');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `actual_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield (%)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `agitation_speed_rpm` SET TAGS ('dbx_business_glossary_term' = 'Agitation Speed (RPM)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `avg_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Average Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Trial Batch Number (TRIAL_BATCH_NO)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `batch_size_kg` SET TAGS ('dbx_business_glossary_term' = 'Batch Size (kg)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `batch_version` SET TAGS ('dbx_business_glossary_term' = 'Batch Version');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Batch Disposition');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'pass|fail|hold|rework');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `emission_estimate_kg` SET TAGS ('dbx_business_glossary_term' = 'Estimated Emissions (kg)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `energy_consumption_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption (MWh)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `feed_rate_kg_per_hr` SET TAGS ('dbx_business_glossary_term' = 'Feed Rate (kg/h)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `hazard_class` SET TAGS ('dbx_value_regex' = '1|2|3|4|5|6');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `max_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `min_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Trial Batch Notes');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `process_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Process End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `process_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Process Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `quality_status` SET TAGS ('dbx_value_regex' = 'passed|failed|out_of_spec');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `safety_review_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Review Status');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `safety_review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `sampling_point_count` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Count');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `sampling_points_description` SET TAGS ('dbx_business_glossary_term' = 'Sampling Points Description');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield (%)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `trial_batch_status` SET TAGS ('dbx_business_glossary_term' = 'Trial Batch Status');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `trial_batch_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|failed|hold|rework');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `waste_generated_kg` SET TAGS ('dbx_business_glossary_term' = 'Waste Generated (kg)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `yield_difference_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Difference (%)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` SET TAGS ('dbx_subdomain' = 'compound_development');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `rd_stability_study_id` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Identifier (RD_STABILITY_STUDY_ID)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `compound_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Compound Identifier (COMPOUND_ID)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Scientist Identifier (RESPONSIBLE_SCIENTIST_ID)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `experimental_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Identifier (FORMULATION_ID)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `lab_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier (INSTRUMENT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `acceptance_criteria_assay_percent` SET TAGS ('dbx_business_glossary_term' = 'Assay Acceptance Criteria (%) (ACCEPTANCE_CRITERIA_ASSAY_PERCENT)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `acceptance_criteria_color` SET TAGS ('dbx_business_glossary_term' = 'Color Change Acceptance Criteria (ACCEPTANCE_CRITERIA_COLOR)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `acceptance_criteria_color` SET TAGS ('dbx_value_regex' = 'no_change|slight|significant');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `acceptance_criteria_particulate_ppm` SET TAGS ('dbx_business_glossary_term' = 'Particulate Acceptance Criteria (ppm) (ACCEPTANCE_CRITERIA_PARTICULATE_PPM)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `acceptance_criteria_ph` SET TAGS ('dbx_business_glossary_term' = 'pH Acceptance Criteria (ACCEPTANCE_CRITERIA_PH)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `acceptance_criteria_viscosity_cp` SET TAGS ('dbx_business_glossary_term' = 'Viscosity Acceptance Criteria (cP) (ACCEPTANCE_CRITERIA_VISCOSITY_CP)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date (ACTUAL_COMPLETION_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `batch_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Test Batch Lot Number (BATCH_LOT_NUMBER)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Status (DATA_QUALITY_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_value_regex' = 'valid|questionable|invalid');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date (END_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `is_oos_flag` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Specification Flag (IS_OOS_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `is_oot_flag` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Trend Flag (IS_OOT_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `light_exposure_lux` SET TAGS ('dbx_business_glossary_term' = 'Light Exposure (lux) (LIGHT_EXPOSURE_LUX)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Study Notes (NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `rd_stability_study_status` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Status (STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `rd_stability_study_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|closed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `regulatory_protocol_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Protocol Reference (REGULATORY_PROTOCOL_REFERENCE)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `sampling_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Sampling Interval (Months) (SAMPLING_INTERVAL_MONTHS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `shelf_life_estimate_months` SET TAGS ('dbx_business_glossary_term' = 'Shelf‑Life Estimate (Months) (SHELF_LIFE_ESTIMATE_MONTHS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Study Start Date (START_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `storage_condition_description` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition Description (STORAGE_CONDITION_DESCRIPTION)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `study_code` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Code (STUDY_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `study_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Study Duration (Months) (STUDY_DURATION_MONTHS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `study_name` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Name (STUDY_NAME)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Type (STUDY_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'accelerated|real_time|photostability|freeze_thaw');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `test_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Test Relative Humidity (%) (TEST_HUMIDITY_PERCENT)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `test_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Test Temperature (°C) (TEST_TEMPERATURE_C)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Study Version Number (VERSION_NUMBER)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` SET TAGS ('dbx_subdomain' = 'project_management');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `patent_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Identifier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Identifier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project Identifier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `abstract` SET TAGS ('dbx_business_glossary_term' = 'Patent Abstract');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `attorney_contact` SET TAGS ('dbx_business_glossary_term' = 'Attorney Contact Email');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `attorney_contact` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `attorney_contact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `attorney_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `attorney_firm` SET TAGS ('dbx_business_glossary_term' = 'Attorney Firm');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Filing Cost Amount');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `docket_number` SET TAGS ('dbx_business_glossary_term' = 'Docket Number');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `estimated_commercial_value_tier` SET TAGS ('dbx_business_glossary_term' = 'Estimated Commercial Value Tier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `estimated_commercial_value_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Number');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `fto_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'FTO Assessment Date');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `fto_result` SET TAGS ('dbx_business_glossary_term' = 'FTO Result');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `fto_result` SET TAGS ('dbx_value_regex' = 'clear|risk|blocked');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `grant_date` SET TAGS ('dbx_business_glossary_term' = 'Grant Date');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `inventor_names` SET TAGS ('dbx_business_glossary_term' = 'Inventor Names');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `inventor_names` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `inventor_names` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `ip_committee_decision` SET TAGS ('dbx_business_glossary_term' = 'IP Committee Decision');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `ip_committee_decision` SET TAGS ('dbx_value_regex' = 'approve|reject|defer');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `is_freedom_to_operate_assessed` SET TAGS ('dbx_business_glossary_term' = 'Freedom‑to‑Operate Assessed Flag');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = 'US|EU|JP|CN|CA|AU');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `licensing_status` SET TAGS ('dbx_business_glossary_term' = 'Licensing Status');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `licensing_status` SET TAGS ('dbx_value_regex' = 'licensed|unlicensed|in_negotiation');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `maintenance_fee_due_date` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Fee Due Date');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `maintenance_fee_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Fee Status');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `maintenance_fee_status` SET TAGS ('dbx_value_regex' = 'due|paid|overdue');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `patent_application_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Application Number');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `patent_family_code` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Identifier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `patent_filing_status` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Status');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `patent_filing_status` SET TAGS ('dbx_value_regex' = 'draft|filed|published|granted|expired|abandoned');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `patent_type` SET TAGS ('dbx_business_glossary_term' = 'Patent Type');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `patent_type` SET TAGS ('dbx_value_regex' = 'composition|process|use|product');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `prior_art_search_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Art Search Status');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `prior_art_search_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `priority_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Priority Claim Number');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `priority_date` SET TAGS ('dbx_business_glossary_term' = 'Priority Date');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `related_cas_numbers` SET TAGS ('dbx_business_glossary_term' = 'Related CAS Numbers');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `technology_area` SET TAGS ('dbx_business_glossary_term' = 'Technology Area');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `technology_area` SET TAGS ('dbx_value_regex' = 'pharma|agri|materials|specialty|energy|other');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Patent Title');
ALTER TABLE `chemical_mfg_ecm`.`research`.`patent_filing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` SET TAGS ('dbx_subdomain' = 'process_scaleup');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `technology_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Transfer Identifier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research & Development Project Identifier (RDPID)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `transfer_package_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Package Document Identifier (TPDI)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `associated_cas_numbers` SET TAGS ('dbx_business_glossary_term' = 'Associated CAS Numbers (CAS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (BN)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (CS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `deviation_notes` SET TAGS ('dbx_business_glossary_term' = 'Deviation Notes (DN)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Timestamp (EFT)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Timestamp (EUT)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `ip_status` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property Status (IPST)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `ip_status` SET TAGS ('dbx_value_regex' = 'protected|public|restricted');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `manufacturing_signoff_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Sign-off Timestamp (MFS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'General Notes (GN)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `open_action_items` SET TAGS ('dbx_business_glossary_term' = 'Open Action Items (OAI)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status (QS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `quality_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `r_and_d_signoff_date` SET TAGS ('dbx_business_glossary_term' = 'R&D Sign-off Timestamp (RDS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `readiness_checklist_completed` SET TAGS ('dbx_business_glossary_term' = 'Readiness Checklist Completion Flag (RCCF)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `readiness_checklist_date` SET TAGS ('dbx_business_glossary_term' = 'Readiness Checklist Completion Timestamp (RCCT)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag (RAR)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status (RAS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|denied');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `safety_review_completed` SET TAGS ('dbx_business_glossary_term' = 'Safety Review Completed Flag (SRC)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `safety_review_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Review Date (SRD)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `technology_readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Technology Readiness Level (TRL)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `transfer_category` SET TAGS ('dbx_business_glossary_term' = 'Transfer Category (TC)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `transfer_category` SET TAGS ('dbx_value_regex' = 'process|formulation|compound');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `transfer_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Cost Amount (TCA)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `transfer_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Transfer Cost Currency (TCC)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `transfer_cost_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `transfer_description` SET TAGS ('dbx_business_glossary_term' = 'Technology Transfer Description (TTD)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `transfer_end_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer End Date (TED)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `transfer_number` SET TAGS ('dbx_business_glossary_term' = 'Technology Transfer Number (TTN)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `transfer_number` SET TAGS ('dbx_value_regex' = '^TT-d{6}$');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `transfer_start_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Start Date (TSD)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Technology Transfer Status (TTS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|rejected|completed');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Transfer Type (TTT)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'lab_to_pilot|pilot_to_commercial|lab_to_commercial');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By (RUB)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number (RVN)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`technology_transfer` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By (RCB)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` SET TAGS ('dbx_subdomain' = 'process_scaleup');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `research_process_simulation_id` SET TAGS ('dbx_business_glossary_term' = 'Process Simulation Identifier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `experimental_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Formulation Identifier (FORM_ID)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `associated_procedure` SET TAGS ('dbx_business_glossary_term' = 'Associated Synthesis Procedure (PROC_REF)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `capital_cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Capital Cost Estimate (USD) (CAPITAL_COST_USD)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `conversion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate Percentage (CONV_RATE_PCT)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `energy_consumption_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption (MWh) (ENERGY_CONS_MWH)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `feasibility_outcome` SET TAGS ('dbx_business_glossary_term' = 'Feasibility Outcome (FEASIBILITY_OUTCOME)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `feasibility_outcome` SET TAGS ('dbx_value_regex' = 'feasible|feasible_with_modifications|not_feasible');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `hazop_findings` SET TAGS ('dbx_business_glossary_term' = 'HAZOP / PHA Findings (HAZOP_FINDINGS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `identified_scale_up_challenges` SET TAGS ('dbx_business_glossary_term' = 'Identified Scale‑Up Challenges (SCALE_UP_CHALLENGES)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `model_tool` SET TAGS ('dbx_business_glossary_term' = 'Process Simulation Tool (SIM_TOOL)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `model_tool` SET TAGS ('dbx_value_regex' = 'Aspen HYSYS|Aspen Plus|CHEMCAD');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `process_units_modeled` SET TAGS ('dbx_business_glossary_term' = 'Process Units Modeled (UNITS_MODELED)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `recommended_process_modifications` SET TAGS ('dbx_business_glossary_term' = 'Recommended Process Modifications (RECOMMEND_MODS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `scale_factor` SET TAGS ('dbx_business_glossary_term' = 'Scale Factor Evaluated (SCALE_FACTOR)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `selectivity_percent` SET TAGS ('dbx_business_glossary_term' = 'Selectivity Percentage (SELECTIVITY_PCT)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `simulation_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run End Timestamp (SIM_END_TS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `simulation_name` SET TAGS ('dbx_business_glossary_term' = 'Simulation Name (SIM_NAME)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `simulation_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run Start Timestamp (SIM_START_TS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `simulation_status` SET TAGS ('dbx_business_glossary_term' = 'Simulation Status (SIM_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `simulation_status` SET TAGS ('dbx_value_regex' = 'planned|running|completed|failed');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `simulation_type` SET TAGS ('dbx_business_glossary_term' = 'Simulation Type (SIM_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `simulation_type` SET TAGS ('dbx_value_regex' = 'steady_state|dynamic|heat_integration');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `thermodynamic_model` SET TAGS ('dbx_business_glossary_term' = 'Thermodynamic Model Used (THERMO_MODEL)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `thermodynamic_model` SET TAGS ('dbx_value_regex' = 'NRTL|UNIFAC|Peng-Robinson|Soave-Redlich-Kwong|Wilson');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date (VALIDATION_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status Against Lab Data (VALIDATION_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|not_validated|partial');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Simulation Model Version Number (VERSION_NUM)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`research_process_simulation` ALTER COLUMN `yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage (YIELD_PCT)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` SET TAGS ('dbx_subdomain' = 'compound_development');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `analytical_method_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Identifier (AM_ID)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `lab_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier (INST_ID)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Percentage (ACC_PCT)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `analytical_method_status` SET TAGS ('dbx_business_glossary_term' = 'Method Status (STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `analytical_method_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|retired|pending');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `applicable_matrix` SET TAGS ('dbx_business_glossary_term' = 'Applicable Matrix (MATRIX)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `associated_cas_numbers` SET TAGS ('dbx_business_glossary_term' = 'Associated CAS Numbers (CAS_NUMS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag (DQ_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `detection_limit` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit (DL)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `detection_limit_units` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit Units (DL_UOM)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFF_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXP_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type (INST_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `is_compendial` SET TAGS ('dbx_business_glossary_term' = 'Is Compendial Method (IS_COMPENDIAL)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `labware_method_code` SET TAGS ('dbx_business_glossary_term' = 'LabWare LIMS Method Code (LIMS_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp (LAST_REVIEW_TS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `linearity_range_max` SET TAGS ('dbx_business_glossary_term' = 'Linearity Range Maximum (LR_MAX)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `linearity_range_min` SET TAGS ('dbx_business_glossary_term' = 'Linearity Range Minimum (LR_MIN)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `linearity_units` SET TAGS ('dbx_business_glossary_term' = 'Linearity Units (LR_UOM)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `method_code` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Code (AMC)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `method_description` SET TAGS ('dbx_business_glossary_term' = 'Method Description (DESCRIPTION)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `method_name` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Name (AMN)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `method_type` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Type (AMT)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `method_type` SET TAGS ('dbx_value_regex' = 'HPLC|GC|NMR|FTIR|ICP-MS|titration');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `method_version` SET TAGS ('dbx_business_glossary_term' = 'Method Version (VERSION)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `precision_percent` SET TAGS ('dbx_business_glossary_term' = 'Precision Percentage (PREC_PCT)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `regulatory_compliance_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Reference (REG_REF)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `regulatory_compliance_reference` SET TAGS ('dbx_value_regex' = 'USP|ASTM|EPA|ISO|GHS|REACH');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `sample_preparation_notes` SET TAGS ('dbx_business_glossary_term' = 'Sample Preparation Notes (SAMPLE_PREP_NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `validation_author` SET TAGS ('dbx_business_glossary_term' = 'Validation Author (VAL_AUTHOR)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date (VAL_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status (VAL_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'development|validated|compendial');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` SET TAGS ('dbx_subdomain' = 'project_management');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Identifier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Completion Date');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Milestone Budget Amount');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|exempt');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `gate_decision_outcome` SET TAGS ('dbx_business_glossary_term' = 'Gate Decision Outcome');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `gate_decision_outcome` SET TAGS ('dbx_value_regex' = 'go|no_go|conditional|not_applicable');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Milestone Flag');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|delayed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'stage_gate|go_no_go|prototype_delivery|regulatory_submission|technology_transfer|other');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Milestone Notes');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Milestone Date');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `regulatory_submission_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Milestone Risk Level');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Milestone Sequence');
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` SET TAGS ('dbx_subdomain' = 'process_scaleup');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identifier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `lab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Experiment ID');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `compound_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Compound Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet ID');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `trial_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier (BATCH_ID)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `analysis_results` SET TAGS ('dbx_business_glossary_term' = 'Analysis Results');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'CAS Number (CAS_NUMBER)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method (DISPOSAL_METHOD)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'incineration|landfill|chemical_neutralization|recycling|return_to_supplier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `hazard_class` SET TAGS ('dbx_value_regex' = 'flammable|corrosive|toxic|reactive|oxidizer|explosive');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Flag');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `light_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Light Sensitive Flag');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT_NUMBER)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `ppe_required` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment Required');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Status');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Sample Quantity (QUANTITY)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (DAYS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `sample_code` SET TAGS ('dbx_business_glossary_term' = 'Sample Code (SAMPLE_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `sample_name` SET TAGS ('dbx_business_glossary_term' = 'Sample Name (SAMPLE_NAME)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `sample_status` SET TAGS ('dbx_business_glossary_term' = 'Sample Status (STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `sample_status` SET TAGS ('dbx_value_regex' = 'available|in_test|consumed|expired|disposed');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type (SAMPLE_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'synthesized_compound|experimental_formulation|reference_standard|retained_sample|raw_material_evaluation');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `source_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source Identifier (SOURCE_ID)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Source Type (SOURCE_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'internal_synthesis|external_supplier|field_collection|customer_return');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `storage_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Storage Humidity (%)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location (STORAGE_LOCATION)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `storage_requirements` SET TAGS ('dbx_business_glossary_term' = 'Storage Requirements');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|g|mg|L|mL|units');
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` SET TAGS ('dbx_subdomain' = 'compound_development');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `structure_activity_record_id` SET TAGS ('dbx_business_glossary_term' = 'Structure Activity Record ID');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `assay_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Identifier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `lab_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `compound_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Compound Identifier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet ID');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'efficacy|toxicity|solubility|reactivity|thermal_stability|uv_resistance');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `activity_unit` SET TAGS ('dbx_business_glossary_term' = 'Activity Unit');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `activity_value` SET TAGS ('dbx_business_glossary_term' = 'Activity Value');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `concentration_mg_per_ml` SET TAGS ('dbx_business_glossary_term' = 'Concentration (mg/mL)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'good|questionable|bad');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `is_control` SET TAGS ('dbx_business_glossary_term' = 'Control Sample Flag');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `ph` SET TAGS ('dbx_business_glossary_term' = 'pH Value');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|archived|deleted');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'REACH|TSCA|EPA|GHS|None');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'passed|failed|inconclusive|pending');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `solvent` SET TAGS ('dbx_business_glossary_term' = 'Solvent');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'labware_lims|aspen_hysys|custom_assay');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `test_condition_description` SET TAGS ('dbx_business_glossary_term' = 'Test Condition Description');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`research`.`licensing_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`research`.`licensing_agreement` SET TAGS ('dbx_subdomain' = 'project_management');
ALTER TABLE `chemical_mfg_ecm`.`research`.`licensing_agreement` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Identifier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`licensing_agreement` ALTER COLUMN `compound_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Compound Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`licensing_agreement` ALTER COLUMN `amended_licensing_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`licensing_agreement` ALTER COLUMN `licensee_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`licensing_agreement` ALTER COLUMN `licensee_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`licensing_agreement` ALTER COLUMN `licensee_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`licensing_agreement` ALTER COLUMN `licensee_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`licensing_agreement` ALTER COLUMN `licensor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`licensing_agreement` ALTER COLUMN `licensor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`licensing_agreement` ALTER COLUMN `licensor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`licensing_agreement` ALTER COLUMN `licensor_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`assay` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`research`.`assay` SET TAGS ('dbx_subdomain' = 'compound_development');
ALTER TABLE `chemical_mfg_ecm`.`research`.`assay` ALTER COLUMN `assay_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Identifier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`assay` ALTER COLUMN `compound_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Compound Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`research`.`assay` ALTER COLUMN `replicate_assay_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`transfer_package_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`research`.`transfer_package_document` SET TAGS ('dbx_subdomain' = 'process_scaleup');
ALTER TABLE `chemical_mfg_ecm`.`research`.`transfer_package_document` ALTER COLUMN `transfer_package_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Package Document Identifier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`transfer_package_document` ALTER COLUMN `superseded_transfer_package_document_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`transfer_package_document` ALTER COLUMN `emergency_contact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`transfer_package_document` ALTER COLUMN `emergency_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`research`.`transfer_package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`research`.`transfer_package` SET TAGS ('dbx_subdomain' = 'process_scaleup');
ALTER TABLE `chemical_mfg_ecm`.`research`.`transfer_package` ALTER COLUMN `transfer_package_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Package Identifier');
ALTER TABLE `chemical_mfg_ecm`.`research`.`transfer_package` ALTER COLUMN `superseded_transfer_package_id` SET TAGS ('dbx_self_ref_fk' = 'true');
