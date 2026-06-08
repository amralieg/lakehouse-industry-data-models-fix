-- Schema for Domain: research | Business: Food Beverage | Version: v1_ecm
-- Generated on: 2026-05-05 21:26:25

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `food_beverage_ecm`.`research` COMMENT 'Manages R&D projects, product innovation pipeline, formulation development, sensory science, pilot plant trials, patent/IP management, and technology scouting for new food and beverage products';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`rd_project` (
    `rd_project_id` BIGINT COMMENT 'Unique system-generated identifier for the research and development project.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Legal entity (company code) is required for consolidation of R&D expenses in financial statements.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: R&D projects are charged to cost centers for internal cost allocation; required for cost allocation reports.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Project budget aligns with corporate budget record; required for budget‑vs‑actual variance analysis.',
    `forecast_id` BIGINT COMMENT 'Foreign key linking to finance.forecast. Business justification: R&D expense forecasts feed financial forecasting process; needed for forward‑looking expense planning.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: R&D expense postings use a specific GL account; needed for accurate journal entries.',
    `innovation_pipeline_id` BIGINT COMMENT 'Foreign key linking to research.innovation_pipeline. Business justification: R&D project belongs to a single innovation pipeline; child side gets FK to parent.',
    `employee_id` BIGINT COMMENT 'Identifier of the business sponsor responsible for funding and championing the project.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Regulatory Submission Management: each R&D project must record the product registration it supports for filing.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Projects need profit‑center assignment to assess profitability; used in profit‑center performance reports.',
    `rd_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `sku_id` BIGINT COMMENT 'FK to product.sku.sku_id — Innovation-to-commercialization traceability: must trace which R&D project produced which commercialized SKU. Required for R&D ROI analysis and NPD pipeline reporting.',
    `target_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_target. Business justification: R&D projects define specific sustainability targets; linking enables target alignment tracking in project governance.',
    `target_sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: An R&D project aims to develop or reformulate a specific SKU; linking tracks project‑to‑product ownership.',
    `tertiary_rd_sponsor_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `parent_rd_project_id` BIGINT COMMENT 'Self-referencing FK on rd_project (parent_rd_project_id)',
    `actual_end_date` DATE COMMENT 'Date when the project was actually closed or delivered.',
    `actual_spent` DECIMAL(18,2) COMMENT 'Cumulative amount actually spent to date on the project.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the project received final approval to proceed to launch.',
    `budget_allocation` DECIMAL(18,2) COMMENT 'Total budget approved for the project, expressed in USD.',
    `compliance_status` STRING COMMENT 'Overall compliance standing of the project against internal and regulatory standards.. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the project record was first created in the system.',
    `expected_cogs` DECIMAL(18,2) COMMENT 'Projected cost of goods sold for the product at launch.',
    `expected_margin_percent` DECIMAL(18,2) COMMENT 'Projected gross margin percentage for the product.',
    `ip_patent_filed` BOOLEAN COMMENT 'Indicates whether a patent application has been filed for technology developed in the project.',
    `ip_patent_number` STRING COMMENT 'Official patent number assigned after filing, if applicable.',
    `lifecycle_status` STRING COMMENT 'Overall status of the project in its lifecycle.. Valid values are `active|on_hold|completed|cancelled|archived`',
    `market_segment` STRING COMMENT 'Target market segment for the resulting product (e.g., snacks, beverages, dairy).',
    `objectives` STRING COMMENT 'Key measurable objectives that the project seeks to achieve.',
    `planned_end_date` DATE COMMENT 'Projected completion date for the project.',
    `project_code` STRING COMMENT 'Internal alphanumeric code used to reference the project across systems.',
    `project_name` STRING COMMENT 'Human‑readable name of the R&D project.',
    `project_type` STRING COMMENT 'Classification of the R&D effort: new product development, product renovation, cost optimization, or technology scouting.. Valid values are `new_product|renovation|cost_optimization|technology_scouting`',
    `rd_project_description` STRING COMMENT 'Narrative description of the projects purpose, scope, and expected outcomes.',
    `regulatory_approval_required` BOOLEAN COMMENT 'Indicates whether the project requires formal regulatory approval before launch.',
    `regulatory_approval_status` STRING COMMENT 'Current status of any required regulatory approvals.. Valid values are `pending|approved|rejected`',
    `risk_level` STRING COMMENT 'Overall risk rating assigned to the project.. Valid values are `low|medium|high|critical`',
    `risk_status` STRING COMMENT 'Current status of risk mitigation activities.. Valid values are `identified|mitigated|escalated|closed`',
    `stage_gate_phase` STRING COMMENT 'Current stage‑gate phase of the project within the product development lifecycle.. Valid values are `ideation|concept|feasibility|development|scale_up|launch`',
    `start_date` DATE COMMENT 'Date when the project officially commenced.',
    `strategic_goal` STRING COMMENT 'Specific strategic objective the project aims to achieve.',
    `strategic_pillar` STRING COMMENT 'High‑level strategic pillar (e.g., Growth, Innovation, Sustainability) the project aligns to.',
    `target_customer_profile` STRING COMMENT 'Key consumer demographics and psychographics the product is designed for.',
    `target_launch_date` DATE COMMENT 'Planned commercial launch date for the product resulting from the project.',
    `target_market` STRING COMMENT 'Geographic market(s) where the product is intended to be launched.',
    `technology_area` STRING COMMENT 'Primary technology focus of the project (e.g., plant‑based, low‑sugar, functional ingredients).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the project record.',
    CONSTRAINT pk_rd_project PRIMARY KEY(`rd_project_id`)
) COMMENT 'Master record for each R&D and innovation project in the Food Beverage pipeline — captures project ID, name, type (new product development, renovation, cost optimization, technology scouting), stage-gate phase (ideation, concept, feasibility, development, scale-up, launch), project sponsor, lead scientist, target launch date, budget allocation, strategic pillar alignment, and current status. This is the backbone entity for the entire research domain, linking all formulation, trial, sensory, and IP activities.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` (
    `innovation_pipeline_id` BIGINT COMMENT 'Unique identifier for the innovation pipeline record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Innovation pipeline ownership requires assigning a senior manager; the HR system tracks this manager via employee_id for approval and accountability.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Innovation Pipeline Tracking: pipeline entries need product_registration_id to map concepts to registered products.',
    `parent_innovation_pipeline_id` BIGINT COMMENT 'Self-referencing FK on innovation_pipeline (parent_innovation_pipeline_id)',
    `actual_spend_usd` DECIMAL(18,2) COMMENT 'Cumulative spend to date.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the project received formal approval to proceed.',
    `budget_amount_usd` DECIMAL(18,2) COMMENT 'Approved budget for the project.',
    `compliance_status` STRING COMMENT 'Current compliance standing with relevant regulations.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pipeline record was first created.',
    `effective_end_date` DATE COMMENT 'Planned or actual completion date; nullable if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the project officially commenced.',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Projected total cost to develop and bring the product to market.',
    `estimated_revenue_usd` DECIMAL(18,2) COMMENT 'Projected revenue potential of the product if successfully launched.',
    `health_score` DECIMAL(18,2) COMMENT 'Composite score reflecting overall health of the project.',
    `innovation_horizon` STRING COMMENT 'Strategic horizon indicating core, adjacent, or transformational focus.. Valid values are `H1_core|H2_adjacent|H3_transformational`',
    `innovation_pipeline_status` STRING COMMENT 'Overall lifecycle status of the project.. Valid values are `active|on_hold|cancelled|completed`',
    `market_opportunity` STRING COMMENT 'Qualitative assessment of market size and growth potential.',
    `milestone_count` STRING COMMENT 'Number of defined milestones for the project.',
    `next_milestone_date` DATE COMMENT 'Planned date for the upcoming milestone.',
    `patent_filed` BOOLEAN COMMENT 'Indicates whether a patent has been filed for the innovation.',
    `patent_number` STRING COMMENT 'Identifier of the granted or pending patent.',
    `pipeline_stage` STRING COMMENT 'Current stage of the project within the stage‑gate process.. Valid values are `idea|concept|feasibility|development|validation|launch`',
    `priority` STRING COMMENT 'Business priority assigned to the project.. Valid values are `high|medium|low`',
    `project_code` STRING COMMENT 'Business identifier or code assigned to the project (e.g., internal SKU‑style code).',
    `project_description` STRING COMMENT 'Narrative description of the projects objectives and scope.',
    `project_lead` STRING COMMENT 'Name of the internal employee responsible for the project.',
    `project_name` STRING COMMENT 'Human‑readable name of the R&D project.',
    `project_type` STRING COMMENT 'Classification of the innovation type.. Valid values are `new_product|line_extension|reformulation|process_innovation`',
    `projected_roi_percent` DECIMAL(18,2) COMMENT 'Estimated return on investment expressed as a percentage.',
    `regulatory_impact` STRING COMMENT 'Summary of regulatory considerations affecting the project.',
    `resource_allocation_percent` DECIMAL(18,2) COMMENT 'Percentage of total R&D capacity assigned to this project.',
    `resource_capacity_hours` DECIMAL(18,2) COMMENT 'Total labor hours allocated to the project.',
    `risk_level` STRING COMMENT 'Overall risk rating for the project.. Valid values are `low|medium|high`',
    `strategic_category` STRING COMMENT 'High‑level business category the innovation aligns to.. Valid values are `snacks|beverages|dairy|packaged_foods`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    CONSTRAINT pk_innovation_pipeline PRIMARY KEY(`innovation_pipeline_id`)
) COMMENT 'Portfolio-level master record tracking the aggregate innovation pipeline for Food Beverage — captures pipeline stage distribution, estimated revenue potential by project, strategic category alignment (snacks, beverages, dairy, packaged foods), innovation horizon (H1 core, H2 adjacent, H3 transformational), resource capacity allocation, and pipeline health metrics. Serves as the SSOT for R&D portfolio governance and stage-gate review meetings.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`experimental_formula` (
    `experimental_formula_id` BIGINT COMMENT 'Unique system-generated identifier for each experimental formula record.',
    `formulation_version_id` BIGINT COMMENT 'Foreign key linking to research.formulation_version. Business justification: Experimental formula is a concrete instance of a formulation version; child side gets FK to parent.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Formulation Approval: experimental formula must be linked to the product registration it will be marketed under.',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to ingredient.raw_material. Business justification: Regulatory traceability requires each experimental formula to reference the exact raw material used for safety and label compliance.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Experimental formulas are created within an R&D project; linking provides project context and eliminates silo.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: R&D experimental formulas are created for a specific SKU; linking enables traceability from formula to product for PLM and regulatory filings.',
    `derived_from_experimental_formula_id` BIGINT COMMENT 'Self-referencing FK on experimental_formula (derived_from_experimental_formula_id)',
    `allergen_statement` STRING COMMENT 'Declared allergen information for the experimental formula.',
    `batch_size_kg` DECIMAL(18,2) COMMENT 'Target batch size in kilograms for pilot production runs.',
    `cost_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated cost in US dollars to develop the experimental formula.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the experimental formula record was first created.',
    `effective_date` DATE COMMENT 'Date when the experimental formula becomes effective for testing.',
    `experimental_formula_description` STRING COMMENT 'Detailed textual description of the formulation purpose and characteristics.',
    `experimental_formula_status` STRING COMMENT 'Current lifecycle status of the experimental formula.. Valid values are `active|inactive|draft|completed|withdrawn`',
    `expiry_date` DATE COMMENT 'Date after which the experimental formula is no longer valid for testing.',
    `formula_code` STRING COMMENT 'Business identifier code assigned to the experimental formula.. Valid values are `^[A-Z0-9]{1,20}$`',
    `formula_name` STRING COMMENT 'Human‑readable name describing the experimental formulation.',
    `formula_type` STRING COMMENT 'Classification of the formula lifecycle stage.. Valid values are `experimental|pilot|approved|rejected|archived`',
    `formulation_notes` STRING COMMENT 'Free‑form notes captured by R&D during formulation development.',
    `ingredient_count` STRING COMMENT 'Number of distinct ingredients included in the experimental formulation.',
    `intellectual_property_status` STRING COMMENT 'Current status of intellectual property protection for the formula.. Valid values are `none|pending|granted|expired`',
    `intended_market` STRING COMMENT 'Three‑letter ISO country code of the market where the formula will be launched.. Valid values are `^[A-Z]{3}$`',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the experimental formula is marked as confidential within the organization.',
    `nutritional_info_summary` STRING COMMENT 'Brief summary of key nutritional values (e.g., calories, protein, sugar).',
    `patent_pending` BOOLEAN COMMENT 'True if a patent application is pending for the formulation.',
    `processing_temperature_c` DECIMAL(18,2) COMMENT 'Target processing temperature in degrees Celsius for the formulation.',
    `processing_time_minutes` STRING COMMENT 'Planned processing time in minutes for the experimental batch.',
    `regulatory_status` STRING COMMENT 'Regulatory approval status of the experimental formula.. Valid values are `pending|approved|rejected|withdrawn`',
    `risk_assessment_level` STRING COMMENT 'Overall risk level associated with the experimental formula.. Valid values are `low|moderate|high|critical`',
    `scale_up_feasibility` STRING COMMENT 'Assessment of feasibility to scale the formulation to commercial production.. Valid values are `low|medium|high`',
    `sensory_panel_date` DATE COMMENT 'Date when the sensory panel evaluation was conducted.',
    `sensory_panel_score` DECIMAL(18,2) COMMENT 'Average score from sensory panel evaluation (0‑100 scale).',
    `shelf_life_days` STRING COMMENT 'Projected shelf life in days for the experimental product.',
    `target_product_category` STRING COMMENT 'Primary product category for which the experimental formula is intended.. Valid values are `snack|beverage|dairy|frozen|convenience`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the experimental formula record.',
    `version_number` STRING COMMENT 'Sequential version number of the formula within its code.',
    CONSTRAINT pk_experimental_formula PRIMARY KEY(`experimental_formula_id`)
) COMMENT 'R&D working formulation record representing each experimental or approved recipe version developed during product innovation — captures formulation code, version number, associated R&D project, target product category, ingredient composition (linked to ingredient domain), processing conditions, intended market/jurisdiction, regulatory status, and formulation owner. Distinct from product.formulation which is the approved commercial formulation; this entity tracks all R&D-stage working versions including experimental and rejected iterations.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`formulation_version` (
    `formulation_version_id` BIGINT COMMENT 'Unique surrogate key for each formulation version record.',
    `packaging_profile_id` BIGINT COMMENT 'Foreign key linking to sustainability.packaging_profile. Business justification: Each formulation version selects a packaging profile for lifecycle impact assessment; link supports packaging sustainability scoring.',
    `patent_id` BIGINT COMMENT 'Identifier of the associated patent or patent application.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who created the version record.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Label Compliance: each formulation version is tied to the product registration for accurate labeling.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Each formulation version represents the formulation of a SKU; needed for version control, cost, and compliance reporting.',
    `previous_formulation_version_id` BIGINT COMMENT 'Self-referencing FK on formulation_version (previous_formulation_version_id)',
    `allergen_flag` STRING COMMENT 'Indicates presence or risk of allergens in the formulation.. Valid values are `none|contains|potential`',
    `approval_status` STRING COMMENT 'Regulatory or internal approval state of the version.. Valid values are `approved|rejected|under_review`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the version received its approval decision.',
    `batch_size_kg` DECIMAL(18,2) COMMENT 'Standard batch size for production runs of this version.',
    `carbon_footprint_kg_co2e` DECIMAL(18,2) COMMENT 'Estimated greenhouse‑gas emissions per kilogram of product.',
    `change_rationale` STRING COMMENT 'Reason for the change (e.g., cost reduction, taste improvement, allergen removal).',
    `changed_ingredients` STRING COMMENT 'JSON‑encoded list of ingredient modifications introduced in this version.',
    `changed_processing_parameters` STRING COMMENT 'JSON‑encoded processing parameter changes (e.g., temperature, time, pH).',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost per unit for the formulation version.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the formulation version record was created in the system.',
    `delta_summary` STRING COMMENT 'Narrative description of differences compared to the prior version.',
    `effective_date` DATE COMMENT 'Date on which the formulation version becomes operationally effective.',
    `expiration_date` DATE COMMENT 'Optional date after which the version is no longer valid.',
    `formulation_category` STRING COMMENT 'High‑level product family to which the formulation belongs.. Valid values are `beverage|snack|dairy|confectionery|meal|sauce`',
    `formulation_version_status` STRING COMMENT 'Current lifecycle state of the formulation version.. Valid values are `active|inactive|pending|deprecated|rejected`',
    `gras_notification_required` BOOLEAN COMMENT 'Indicates if a GRAS (Generally Recognized As Safe) submission is needed.',
    `gras_notification_status` STRING COMMENT 'Current state of the GRAS submission process.. Valid values are `pending|submitted|approved`',
    `is_approved_for_release` BOOLEAN COMMENT 'True when the version has passed all release gates.',
    `is_current_version` BOOLEAN COMMENT 'Flag indicating whether this version is the latest active version.',
    `nutritional_profile` STRING COMMENT 'JSON‑encoded nutrition facts (calories, fat, protein, etc.) for the version.',
    `packaging_material` STRING COMMENT 'Primary material used for packaging the product.. Valid values are `plastic|glass|paper|metal|biodegradable`',
    `patent_related_flag` BOOLEAN COMMENT 'True if the formulation is covered by a pending or granted patent.',
    `processing_temperature_c` DECIMAL(18,2) COMMENT 'Temperature used during manufacturing of the formulation.',
    `processing_time_min` STRING COMMENT 'Total time required for the processing step.',
    `regulatory_compliance_status` STRING COMMENT 'Overall compliance state with FDA/USDA/EFSA regulations.. Valid values are `compliant|non_compliant|pending`',
    `regulatory_review_notes` STRING COMMENT 'Free‑text notes from regulatory reviewers.',
    `shelf_life_days` STRING COMMENT 'Maximum storage duration before product quality degrades.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Recommended storage temperature for the formulation.',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Composite score reflecting environmental impact of the formulation.',
    `target_market` STRING COMMENT 'Geographic market or channel for which the formulation is intended (e.g., NA, EU, APAC).',
    `taste_score` DECIMAL(18,2) COMMENT 'Sensory panel rating (0‑10 scale) for the formulation version.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the formulation version record.',
    `version_author` STRING COMMENT 'Name of the R&D staff who authored the version.',
    `version_code` STRING COMMENT 'External identifier (e.g., PLM code) assigned to the formulation version.',
    `version_comment` STRING COMMENT 'Additional free‑form comments supplied by the author.',
    `version_name` STRING COMMENT 'Descriptive name for the formulation version used by R&D staff.',
    `version_number` STRING COMMENT 'Sequential integer indicating the version order of the formulation.',
    `version_type` STRING COMMENT 'Classification of the version lifecycle stage.. Valid values are `prototype|pilot|final|revision`',
    CONSTRAINT pk_formulation_version PRIMARY KEY(`formulation_version_id`)
) COMMENT 'Versioned iteration record for each R&D working formulation — captures version number, change rationale (cost reduction, taste improvement, allergen removal, regulatory compliance), changed ingredients, changed processing parameters, version author, approval status, and comparison delta versus prior version. Enables full formulation change history and supports regulatory traceability for novel food submissions and GRAS notifications.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` (
    `rd_sensory_panel_id` BIGINT COMMENT 'Unique system-generated identifier for the sensory evaluation panel.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Sensory panel execution is overseen by a panel leader (employee); HR records this role for scheduling and compliance reporting.',
    `rd_project_id` BIGINT COMMENT 'Identifier of the research and development project linked to this panel.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Sensory panels evaluate a concrete SKU; linking ties sensory data to the product for launch decisions.',
    `follow_up_rd_sensory_panel_id` BIGINT COMMENT 'Self-referencing FK on rd_sensory_panel (follow_up_rd_sensory_panel_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the panel results were formally approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the panel record was first created in the system.',
    `data_source_system` STRING COMMENT 'Source system where the panel data originated (e.g., Veeva Vault, MES).',
    `evaluation_protocol` STRING COMMENT 'Description of the standardized protocol used for the panel.',
    `facility_location` STRING COMMENT 'Name or code of the facility where the panel took place.',
    `formulation_version` STRING COMMENT 'Version identifier of the product formulation evaluated in the panel.',
    `is_blind` BOOLEAN COMMENT 'True if the panel was conducted blind to product identity.',
    `is_controlled_environment` BOOLEAN COMMENT 'True if the testing environment was controlled for variables such as lighting and temperature.',
    `notes` STRING COMMENT 'Free‑form observations and comments captured during the panel.',
    `overall_outcome` STRING COMMENT 'Result of the panel after analysis (e.g., pass, fail, inconclusive).. Valid values are `pass|fail|inconclusive`',
    `overall_score` DECIMAL(18,2) COMMENT 'Aggregated numeric score representing overall panel rating.',
    `panel_category` STRING COMMENT 'Primary sensory attribute focus of the panel.. Valid values are `taste|aroma|texture|appearance|overall_acceptance`',
    `panel_code` STRING COMMENT 'Business identifier code assigned to the panel for tracking and reference.',
    `panel_date` DATE COMMENT 'Calendar date on which the sensory evaluation was conducted.',
    `panel_duration_minutes` STRING COMMENT 'Total duration of the panel session in minutes.',
    `panel_leader` STRING COMMENT 'Name of the individual leading the sensory evaluation.',
    `panel_location_code` STRING COMMENT 'Standardized code representing the physical location of the panel.',
    `panel_name` STRING COMMENT 'Human‑readable name of the sensory panel.',
    `panel_type` STRING COMMENT 'Classification of the panel methodology (e.g., trained descriptive, consumer hedonic, discrimination, QDA).. Valid values are `trained_descriptive|consumer_hedonic|discrimination|qda`',
    `panelist_count` STRING COMMENT 'Number of participants who took part in the sensory panel.',
    `rd_sensory_panel_status` STRING COMMENT 'Current lifecycle status of the panel.. Valid values are `planned|in_progress|completed|cancelled`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the panel complied with relevant FDA/USDA regulations.',
    `reviewer_name` STRING COMMENT 'Name of the individual who reviewed and approved the panel outcomes.',
    `sample_preparation_details` STRING COMMENT 'Notes on how product samples were prepared for evaluation.',
    `score_unit` STRING COMMENT 'Unit of measurement for the overall score (e.g., points, scale, rating).. Valid values are `points|scale|rating`',
    `sensory_methodology` STRING COMMENT 'Specific sensory testing methodology employed.. Valid values are `triangle|duo_trio|ranking|paired_comparison|qda`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the panel record.',
    `version_number` STRING COMMENT 'Incremental version number for audit tracking.',
    CONSTRAINT pk_rd_sensory_panel PRIMARY KEY(`rd_sensory_panel_id`)
) COMMENT 'Master record for sensory evaluation panels conducted during product development — captures panel ID, panel type (trained descriptive, consumer hedonic, discrimination, QDA), associated R&D project and formulation version, panel date, facility location, panelist count, panel leader, evaluation protocol, and overall panel outcome. Central entity for sensory science program management at Food Beverage.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`sensory_result` (
    `sensory_result_id` BIGINT COMMENT 'Unique surrogate key for each sensory evaluation result record.',
    `employee_id` BIGINT COMMENT 'Internal identifier of the consumer panelist who provided the evaluation.',
    `formulation_version_id` BIGINT COMMENT 'Identifier of the product formulation version evaluated in this test.',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to ingredient.raw_material. Business justification: Sensory testing is performed on a particular raw material; linking records the ingredient for product development decisions.',
    `rd_lab_sample_id` BIGINT COMMENT 'Identifier of the physical product sample presented to the panelist.',
    `sensory_session_id` BIGINT COMMENT 'Identifier of the sensory testing session to which this result belongs.',
    `replicate_sensory_result_id` BIGINT COMMENT 'Self-referencing FK on sensory_result (replicate_sensory_result_id)',
    `aftertaste_score` STRING COMMENT 'Numeric rating (e.g., 1‑10) of the lingering aftertaste.',
    `appearance_score` STRING COMMENT 'Numeric rating (e.g., 1‑10) of the visual appearance of the sample.',
    `aroma_score` STRING COMMENT 'Numeric rating (e.g., 1‑10) of the aroma perceived by the panelist.',
    `blind_branded_flag` STRING COMMENT 'Indicates whether the sample was presented blind (unbranded) or with branding cues.. Valid values are `blind|branded`',
    `comment_text` STRING COMMENT 'Free‑text field for optional qualitative feedback from the panelist.',
    `device_code` BIGINT COMMENT 'Identifier of the hardware device (e.g., tablet, kiosk) used to capture the response.',
    `evaluation_location` STRING COMMENT 'Code of the facility or lab where the sensory test was conducted.',
    `evaluation_timestamp` TIMESTAMP COMMENT 'Date and time when the panelist completed the sensory evaluation.',
    `flavor_score` STRING COMMENT 'Numeric rating (e.g., 1‑10) of the overall flavor profile.',
    `hedonic_scale_rating` STRING COMMENT 'Rating on the standard 9‑point hedonic scale (1 = dislike extremely, 9 = like extremely).',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity of the testing environment during evaluation, expressed as a percentage.',
    `internal_notes` STRING COMMENT 'Optional free‑text field for analysts to capture observations or data quality comments.',
    `overall_liking_score` STRING COMMENT 'Overall acceptance rating (e.g., 1‑10) reflecting the panelists liking.',
    `rating_scale_type` STRING COMMENT 'Indicates which hedonic scale (9‑point, 7‑point, or 5‑point) was used for this evaluation.. Valid values are `9-point|7-point|5-point`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sensory result record was first created in the data lake.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this sensory result record.',
    `sensory_result_status` STRING COMMENT 'Current lifecycle status of the sensory result record.. Valid values are `active|inactive|deleted`',
    `temperature_c` DECIMAL(18,2) COMMENT 'Measured temperature of the sample at the time of evaluation, in degrees Celsius.',
    `texture_score` STRING COMMENT 'Numeric rating (e.g., 1‑10) of the mouthfeel and texture.',
    CONSTRAINT pk_sensory_result PRIMARY KEY(`sensory_result_id`)
) COMMENT 'Individual panelist response record from a sensory evaluation session — captures panelist ID, panel session reference, formulation version evaluated, attribute scores (appearance, aroma, flavor, texture, aftertaste, overall liking), hedonic scale ratings, free-text comments, and blind vs. branded condition flag. Provides the granular data foundation for statistical sensory analysis and consumer preference modeling.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`pilot_trial` (
    `pilot_trial_id` BIGINT COMMENT 'System-generated unique identifier for each pilot trial record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Pilot trials are often performed for a key customer; the link supports trial agreements and cost allocation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pilot trial costs are charged to cost centers; required for trial cost accounting.',
    `employee_id` BIGINT COMMENT 'Identifier of the scientist or analyst responsible for the trial.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Trial budget is tracked against corporate budget; enables budget‑vs‑actual for pilot trials.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Trial expenses need a GL account for journal posting; supports financial reporting of trial spend.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to ingredient.lot. Business justification: Pilot production batches are executed with a defined ingredient lot; linking enables traceability and quality investigation.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing facility where the trial took place.',
    `production_line_id` BIGINT COMMENT 'Identifier of the specific production line or equipment used.',
    `rd_project_id` BIGINT COMMENT 'Identifier of the research & development project linked to this trial.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Pilot production trials are run on a specific SKU to validate scale‑up; linking supports trial tracking and cost analysis.',
    `previous_pilot_trial_id` BIGINT COMMENT 'Self-referencing FK on pilot_trial (previous_pilot_trial_id)',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual expenditure incurred for the trial, in US dollars.',
    `batch_size` DECIMAL(18,2) COMMENT 'Planned or actual batch size for the trial in kilograms.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Projected cost for conducting the trial, in US dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the trial record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `USD|EUR|GBP|CAD|JPY|AUD`',
    `formulation_version` STRING COMMENT 'Version label of the product formulation used in the trial.',
    `notes` STRING COMMENT 'Free‑form observations, comments, or deviations recorded by the trial team.',
    `outcome` STRING COMMENT 'Result of the trial: pass, fail, or conditional.. Valid values are `pass|fail|conditional`',
    `pilot_trial_status` STRING COMMENT 'Current lifecycle state of the trial.. Valid values are `planned|in_progress|completed|cancelled`',
    `processing_parameters` STRING COMMENT 'Key processing settings (e.g., temperature, time, speed) captured as a structured string.',
    `quality_flag` BOOLEAN COMMENT 'Indicates whether the trial met predefined quality criteria (true = met).',
    `regulatory_approval_status` STRING COMMENT 'Current status of regulatory review for the trial outcome.. Valid values are `pending|approved|rejected`',
    `scale_up_readiness` STRING COMMENT 'Readiness level for moving the formulation to larger scale production.. Valid values are `not_ready|partial|ready`',
    `trial_code` STRING COMMENT 'Human‑readable code assigned to the trial (e.g., PT‑2024‑001).',
    `trial_timestamp` TIMESTAMP COMMENT 'Date and time when the trial was executed or recorded.',
    `trial_type` STRING COMMENT 'Classification of the trial scale: bench, pilot, semi‑commercial, or full plant.. Valid values are `bench|pilot|semi-commercial|plant`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the trial record.',
    `yield_percent` DECIMAL(18,2) COMMENT 'Percentage of usable product obtained from the trial batch.',
    CONSTRAINT pk_pilot_trial PRIMARY KEY(`pilot_trial_id`)
) COMMENT 'Pilot plant and bench-scale trial record capturing each production trial conducted during R&D scale-up — captures trial ID, associated R&D project and formulation version, trial type (bench, pilot, semi-commercial, plant trial), trial date, facility and line used, batch size, processing parameters applied, yield achieved, trial outcome (pass/fail/conditional), and scale-up readiness assessment. Links R&D formulation work to manufacturing feasibility.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`trial_observation` (
    `trial_observation_id` BIGINT COMMENT 'Unique identifier for each trial observation record.',
    `batch_record_id` BIGINT COMMENT 'Identifier of the production batch associated with the trial.',
    `employee_id` BIGINT COMMENT 'Identifier of the person who recorded the observation.',
    `equipment_master_id` BIGINT COMMENT 'Identifier of the equipment or machine involved in the observation.',
    `pilot_trial_id` BIGINT COMMENT 'Identifier of the pilot plant trial to which this observation belongs.',
    `related_trial_observation_id` BIGINT COMMENT 'Self-referencing FK on trial_observation (related_trial_observation_id)',
    `corrective_action` STRING COMMENT 'Action taken to address the observation, including steps performed and responsible party.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the observation record was first created in the system.',
    `location` STRING COMMENT 'Plant or facility location identifier where the observation was made.',
    `measured_value` DECIMAL(18,2) COMMENT 'Actual value recorded for the parameter during the observation.',
    `notes` STRING COMMENT 'Free‑form comments providing additional context or details about the observation.',
    `observation_timestamp` TIMESTAMP COMMENT 'Date and time when the observation was recorded in the pilot plant trial.',
    `observation_type` STRING COMMENT 'Category of the observation indicating the nature of the event.. Valid values are `process_deviation|equipment_issue|quality_defect|yield_loss|safety_concern`',
    `observer_role` STRING COMMENT 'Job role of the observer at the time of recording.. Valid values are `technician|engineer|quality_analyst|supervisor`',
    `parameter_name` STRING COMMENT 'Name of the measured parameter (e.g., temperature, pH, viscosity).',
    `process_step` STRING COMMENT 'Specific step or operation within the pilot trial where the observation occurred.',
    `severity` STRING COMMENT 'Impact level of the observation on product quality, safety, or production.. Valid values are `critical|high|medium|low|info`',
    `target_value` DECIMAL(18,2) COMMENT 'Planned or acceptable target value for the parameter.',
    `trial_observation_status` STRING COMMENT 'Current lifecycle status of the observation record.. Valid values are `open|closed|pending_review|resolved`',
    `unit_of_measure` STRING COMMENT 'Unit in which the parameter is measured (e.g., kg, °C, %). [ENUM-REF-CANDIDATE: kg|g|ml|l|°C|%|ppm — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the observation record.',
    CONSTRAINT pk_trial_observation PRIMARY KEY(`trial_observation_id`)
) COMMENT 'Granular observation record captured during a pilot plant trial — captures observation type (process deviation, equipment issue, quality defect, yield loss, safety concern), observation timestamp, process step, parameter measured versus target, severity, corrective action taken, and observer identity. Provides the detailed trial log that supports root cause analysis and formulation/process optimization decisions.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`patent` (
    `patent_id` BIGINT COMMENT 'System-generated unique identifier for the patent record.',
    `continuation_patent_id` BIGINT COMMENT 'Self-referencing FK on patent (continuation_patent_id)',
    `abstract` STRING COMMENT 'Brief summary of the invention as provided in the application.',
    `annuity_amount` DECIMAL(18,2) COMMENT 'Monetary amount required for each annuity payment.',
    `annuity_frequency` STRING COMMENT 'How often annuity payments are due.. Valid values are `annual|semi_annual|quarterly`',
    `annuity_next_due_date` DATE COMMENT 'Date of the next scheduled annuity payment.',
    `application_number` STRING COMMENT 'Unique identifier of the patent application.',
    `assignee_name` STRING COMMENT 'Legal entity to which the patent rights are assigned.',
    `claims_summary` STRING COMMENT 'Concise description of the patent claims.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the patent record was first created in the system.',
    `expiration_date` DATE COMMENT 'Date the patent rights expire.',
    `filing_date` DATE COMMENT 'Date the patent application was filed with the granting authority.',
    `grant_date` DATE COMMENT 'Date the patent was officially granted.',
    `inventor_names` STRING COMMENT 'Comma‑separated list of inventor full names.',
    `is_patent_family` BOOLEAN COMMENT 'Indicates whether this patent is part of a broader patent family.',
    `jurisdiction` STRING COMMENT 'Country or region where the patent is granted (ISO 3‑letter code).',
    `legal_status` STRING COMMENT 'Current legal standing of the patent with the granting authority.. Valid values are `pending|granted|rejected|withdrawn|lapsed`',
    `licensing_status` STRING COMMENT 'Current licensing state of the patent.. Valid values are `licensed|unlicensed|in_negotiation|expired`',
    `maintenance_fee_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the upcoming maintenance fee.',
    `maintenance_fee_due_date` DATE COMMENT 'Date by which the next maintenance fee must be paid to keep the patent in force.',
    `patent_family_code` STRING COMMENT 'Identifier linking all patents belonging to the same family.',
    `patent_number` STRING COMMENT 'Official patent number assigned by the granting authority.',
    `patent_status` STRING COMMENT 'Overall lifecycle status of the patent record.. Valid values are `active|inactive|expired|pending`',
    `patent_type` STRING COMMENT 'Classification of the patent (utility, design, plant, provisional).. Valid values are `utility|design|plant|provisional`',
    `priority_country` STRING COMMENT 'Country of the priority filing (ISO 3‑letter code).',
    `priority_date` DATE COMMENT 'Date of the earliest filing that the patent claims priority from.',
    `rnd_project_code` STRING COMMENT 'Identifier of the R&D project associated with the invention.',
    `source_system` STRING COMMENT 'Name of the source system where the patent data originated (e.g., Veeva Vault, internal IP tracker).',
    `technology_domain` STRING COMMENT 'Primary technology area the patent covers (e.g., formulation, process, packaging, equipment).',
    `title` STRING COMMENT 'Full title of the patent as recorded in the application.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the patent record.',
    CONSTRAINT pk_patent PRIMARY KEY(`patent_id`)
) COMMENT 'Intellectual property patent master record for Food Beverage — captures patent number, title, patent type (utility, design, plant, provisional), filing date, grant date, expiration date, jurisdiction(s), inventors, assignee entity, technology domain (formulation, process, packaging, equipment), associated R&D project, licensing status, and annuity payment schedule. SSOT for IP portfolio management and freedom-to-operate assessments.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`ip_asset` (
    `ip_asset_id` BIGINT COMMENT 'System-generated unique identifier for the IP asset.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: IP assets (patents, trade secrets) are owned by R&D projects; linking enables traceability.',
    `parent_ip_asset_id` BIGINT COMMENT 'Self-referencing FK on ip_asset (parent_ip_asset_id)',
    `asset_type` STRING COMMENT 'Category of IP asset indicating whether it is a patent, trade secret, know‑how, trademark, or copyright.. Valid values are `patent|trade_secret|know_how|trademark|copyright`',
    `commercialization_status` STRING COMMENT 'Stage of commercialization for the IP asset.. Valid values are `not_commercialized|in_development|launched|discontinued`',
    `compliance_review_date` DATE COMMENT 'Date of the most recent compliance review for the IP asset.',
    `compliance_status` STRING COMMENT 'Overall compliance status with regulatory and internal IP policies.. Valid values are `compliant|non_compliant|pending`',
    `confidentiality_classification` STRING COMMENT 'Classification indicating the sensitivity level of the IP asset (restricted, confidential, internal, public).',
    `conflict_description` STRING COMMENT 'Narrative describing the nature of any conflict or infringement risk.',
    `conflict_flag` BOOLEAN COMMENT 'Indicates if there is a known conflict or infringement risk.',
    `disclosure_level` STRING COMMENT 'Level of public disclosure permitted for the IP asset.. Valid values are `public|confidential|restricted`',
    `document_reference` STRING COMMENT 'URL or path to the primary document that defines the IP asset.',
    `effective_date` DATE COMMENT 'Date the IP asset became effective or enforceable.',
    `expiration_date` DATE COMMENT 'Date the IP asset expires or loses protection.',
    `filing_cost` DECIMAL(18,2) COMMENT 'Cost incurred to file the IP asset with the relevant authority.',
    `ip_asset_description` STRING COMMENT 'Detailed narrative describing the IP asset, its scope and purpose.',
    `ip_asset_name` STRING COMMENT 'Descriptive name of the IP asset used for identification.',
    `ip_asset_status` STRING COMMENT 'Current lifecycle status of the IP asset.. Valid values are `active|pending|expired|withdrawn|licensed|unlicensed`',
    `ip_audit_created` TIMESTAMP COMMENT 'Timestamp when the IP asset record was first created.',
    `ip_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the IP asset record.',
    `ip_manager` STRING COMMENT 'Internal manager responsible for the IP asset.',
    `ip_value_estimate` DECIMAL(18,2) COMMENT 'Monetary estimate of the IP assets worth.',
    `jurisdiction` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code(s) where the IP protection is sought. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|DEU|FRA|JPN|CHN|IND|BRA|... — promote to reference product]',
    `legal_counsel` STRING COMMENT 'External or internal legal counsel overseeing the IP asset.',
    `legal_status` STRING COMMENT 'Current legal standing of the IP asset.. Valid values are `pending|granted|rejected|expired`',
    `licensee` STRING COMMENT 'External party that holds a license to the IP asset.',
    `licensing_end_date` DATE COMMENT 'Date when the licensing agreement for the IP asset ends.',
    `licensing_start_date` DATE COMMENT 'Date when the licensing agreement for the IP asset begins.',
    `licensing_status` STRING COMMENT 'Current licensing condition of the IP asset.. Valid values are `licensed|unlicensed|in_negotiation`',
    `maintenance_cost` DECIMAL(18,2) COMMENT 'Ongoing cost to maintain the IP asset (e.g., renewal fees).',
    `maintenance_due_date` DATE COMMENT 'Date by which the next maintenance fee must be paid.',
    `owner_department` STRING COMMENT 'Business department that owns or is responsible for the IP asset.',
    `protection_strategy` STRING COMMENT 'Strategic approach for protecting the IP asset.. Valid values are `defensive|offensive|open|collaborative`',
    `publication_date` DATE COMMENT 'Date the IP asset was publicly published.',
    `publication_status` STRING COMMENT 'Whether the IP asset has been published in a public registry.. Valid values are `published|unpublished|pending`',
    `renewal_date` DATE COMMENT 'Date the IP asset was last renewed.',
    `renewal_status` STRING COMMENT 'Status of the most recent renewal action.. Valid values are `pending|completed|overdue`',
    `risk_assessment` STRING COMMENT 'Qualitative risk rating for the IP asset.. Valid values are `low|medium|high`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score (0‑100) derived from risk assessment.',
    `royalty_amount` DECIMAL(18,2) COMMENT 'Monetary amount of royalty payable per period.',
    `royalty_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for royalty payments.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `royalty_rate` DECIMAL(18,2) COMMENT 'Royalty rate expressed as a percentage for licensed IP.',
    `source_system` STRING COMMENT 'Source system where the IP asset originated.. Valid values are `Veeva Vault|TraceGains|SAP|Oracle|Other`',
    `creation_date` DATE COMMENT 'Date the IP asset record was initially created in the system.',
    CONSTRAINT pk_ip_asset PRIMARY KEY(`ip_asset_id`)
) COMMENT 'Broader intellectual property asset master covering all IP types beyond patents — captures trade secrets, know-how records, proprietary processes, copyrights, trademarks relevant to R&D, and confidential formulation disclosures. Captures asset type, description, creation date, owner, confidentiality classification, associated R&D project, and commercialization status. Complements the patent entity to provide complete IP portfolio visibility.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`technology_scout` (
    `technology_scout_id` BIGINT COMMENT 'System-generated unique identifier for each technology scouting record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each technology scouting effort is assigned to a specific analyst employee; linking supports workload tracking and performance metrics.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Technology scouting records are tied to specific R&D projects; linking captures ownership.',
    `related_technology_scout_id` BIGINT COMMENT 'Self-referencing FK on technology_scout (related_technology_scout_id)',
    `analyst_name` STRING COMMENT 'Name of the analyst who performed the scouting assessment.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated monetary cost to acquire or implement the technology (in the specified currency).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the scouting record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code for the cost estimate currency.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `department_responsible` STRING COMMENT 'Business unit or department that will own the technology evaluation.',
    `evaluation_status` STRING COMMENT 'Current stage of the technology evaluation workflow.. Valid values are `identified|assessed|shortlisted|rejected|in_licensing`',
    `expected_implementation_timeline_months` STRING COMMENT 'Projected time required to integrate the technology into production, expressed in months.',
    `external_reference_code` STRING COMMENT 'Identifier assigned by the source organization (e.g., startup catalog number, university project code).',
    `external_reference_url` STRING COMMENT 'Web link to the source document, website, or repository containing detailed technology information.',
    `intellectual_property_status` STRING COMMENT 'Current IP protection status of the technology.. Valid values are `patented|pending|none`',
    `last_updated` DATE COMMENT 'Date of the most recent modification to the scouting record.',
    `market_opportunity_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) estimating market size and growth potential.',
    `next_action` STRING COMMENT 'Suggested follow‑up activity for the technology.. Valid values are `pilot|partner|monitor|discard`',
    `notes` STRING COMMENT 'Additional observations, comments, or qualitative insights recorded by the analyst.',
    `potential_impact` STRING COMMENT 'Qualitative description of expected impact on revenue, cost, or market position.',
    `regulatory_implications` STRING COMMENT 'Regulatory bodies or standards that may affect adoption of the technology.. Valid values are `none|FDA|USDA|EU|GFSI`',
    `related_product_codes` STRING COMMENT 'Pipe‑separated list of internal product SKUs or GTINs that could benefit from the technology.',
    `relevance_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) reflecting alignment with Food Beverage strategic priorities.',
    `risk_level` STRING COMMENT 'Assessment of technical, regulatory, or market risk associated with the technology.. Valid values are `low|medium|high`',
    `scouting_date` DATE COMMENT 'Date when the technology was first identified or logged.',
    `source_name` STRING COMMENT 'Name of the organization, institution, or event that originated the technology.',
    `source_type` STRING COMMENT 'Category of the entity that provided the technology information.. Valid values are `startup|university|supplier|competitor|conference`',
    `stakeholder_contact` STRING COMMENT 'Name or email of the internal stakeholder overseeing the technology.',
    `strategic_priority` STRING COMMENT 'Priority level assigned by the innovation team for this technology.. Valid values are `high|medium|low`',
    `technology_readiness_level` STRING COMMENT 'Standardized TRL rating (1‑9) indicating maturity of the technology.',
    `technology_scout_description` STRING COMMENT 'Free‑form textual description of the technology, its function, and key features.',
    `technology_scout_name` STRING COMMENT 'Human‑readable name of the external technology or innovation being scouted.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the scouting record.',
    CONSTRAINT pk_technology_scout PRIMARY KEY(`technology_scout_id`)
) COMMENT 'Technology scouting record capturing external technology opportunities identified for potential adoption or partnership — captures technology name, source (startup, university, supplier, competitor, conference), technology readiness level (TRL 1-9), relevance to Food Beverage strategic priorities, scouting analyst, evaluation status (identified, assessed, shortlisted, rejected, in-licensing), and recommended next action. Feeds the innovation pipeline with external technology inputs.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`stage_gate_review` (
    `stage_gate_review_id` BIGINT COMMENT 'Unique system-generated identifier for each stage gate review record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Gate review records must capture which employee created the review entry for audit trails and regulatory compliance.',
    `rd_project_id` BIGINT COMMENT 'Identifier of the research & development project linked to this gate review.',
    `recycled_stage_gate_review_id` BIGINT COMMENT 'Self-referencing FK on stage_gate_review (recycled_stage_gate_review_id)',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget for the project at this gate (currency‑agnostic).',
    `commercial_viability_score` DECIMAL(18,2) COMMENT 'Numeric assessment (0‑100) of market and commercial potential.',
    `committee_members` STRING COMMENT 'Comma‑separated list of individuals participating in the gate review.',
    `conditions_attached` STRING COMMENT 'Specific conditions required for a conditional go decision.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost to bring the product to market as of this gate.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the review record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code for monetary values.. Valid values are `^[A-Z]{3}$`',
    `decision` STRING COMMENT 'Outcome of the gate review (go, kill, hold, recycle).. Valid values are `go|kill|hold|recycle`',
    `decision_rationale` STRING COMMENT 'Narrative explanation for the gate decision.',
    `documentation_link` STRING COMMENT 'Link to the digital folder or document containing review artifacts.',
    `expected_launch_date` DATE COMMENT 'Projected commercial launch date if the decision is go.',
    `financial_return_score` DECIMAL(18,2) COMMENT 'Numeric assessment (0‑100) of projected financial return for the product.',
    `gate_number` STRING COMMENT 'Sequential gate identifier (0 through 5) in the NPD stage‑gate process.',
    `is_conditional_go` BOOLEAN COMMENT 'True if the decision is a conditional go; otherwise false.',
    `notes` STRING COMMENT 'Free‑form field for any extra comments or observations.',
    `overall_gate_score` DECIMAL(18,2) COMMENT 'Aggregated score summarising all gate criteria.',
    `projected_roi` DECIMAL(18,2) COMMENT 'Projected ROI percentage based on financial return score and cost estimate.',
    `regulatory_compliance_score` DECIMAL(18,2) COMMENT 'Numeric assessment (0‑100) of compliance with FDA, USDA, GFSI, etc.',
    `review_date` DATE COMMENT 'Date on which the gate review was conducted.',
    `review_location` STRING COMMENT 'Physical or virtual location where the gate review took place.',
    `review_method` STRING COMMENT 'Mode of the gate review (in‑person, virtual, or hybrid).. Valid values are `in_person|virtual|hybrid`',
    `review_number` STRING COMMENT 'Human‑readable reference number for the review (e.g., RG-2023-001).. Valid values are `^RG-d{4}-d{3}$`',
    `risk_level` STRING COMMENT 'Overall risk classification assigned during the review.. Valid values are `low|medium|high`',
    `stage_gate_review_status` STRING COMMENT 'Current lifecycle state of the review record.. Valid values are `pending|in_review|completed|on_hold`',
    `technical_feasibility_score` DECIMAL(18,2) COMMENT 'Numeric assessment (0‑100) of technical feasibility at this gate.',
    `updated_by` STRING COMMENT 'User identifier of the person who last updated the review record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the review record.',
    `created_by` STRING COMMENT 'User identifier of the person who created the review record.',
    CONSTRAINT pk_stage_gate_review PRIMARY KEY(`stage_gate_review_id`)
) COMMENT 'Stage-gate decision review record for each formal gate review conducted on an R&D project — captures gate number (Gate 0 through Gate 5), review date, decision (go, kill, hold, recycle), decision rationale, gate criteria scores (technical feasibility, commercial viability, regulatory compliance, financial return), review committee members, and conditions attached to a conditional go decision. Governs the NPD stage-gate process at Food Beverage.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`concept` (
    `concept_id` BIGINT COMMENT 'Unique system-generated identifier for the product concept.',
    `employee_id` BIGINT COMMENT 'System user who created the concept record.',
    `innovation_pipeline_id` BIGINT COMMENT 'Identifier of the innovation pipeline entry linked to this concept.',
    `owner_user_employee_id` BIGINT COMMENT 'System user responsible for the concept.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Concept to Market: final product registration is linked to the originating concept for traceability.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Concept originates from a specific R&D project; child side gets FK to parent.',
    `parent_concept_id` BIGINT COMMENT 'Self-referencing FK on concept (parent_concept_id)',
    `benefit_proposition` STRING COMMENT 'Core consumer benefit the concept promises (e.g., low‑calorie, high‑protein).',
    `compliance_notes` STRING COMMENT 'Free‑text notes on compliance considerations.',
    `concept_category` STRING COMMENT 'High‑level product category (e.g., snack, beverage, dairy).',
    `concept_description` STRING COMMENT 'Detailed narrative describing the concept, its purpose and key attributes.',
    `concept_name` STRING COMMENT 'Human‑readable name of the product concept.',
    `concept_source` STRING COMMENT 'Origin of the concept idea.. Valid values are `internal|external|partner`',
    `concept_status` STRING COMMENT 'Current lifecycle status of the concept.. Valid values are `active|advanced|parked|killed`',
    `consumer_segment` STRING COMMENT 'Primary consumer segment the concept is aimed at (e.g., health‑conscious, premium, family).',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Preliminary estimate of total cost to develop the concept.',
    `creation_timestamp` TIMESTAMP COMMENT 'Date‑time when the concept record was created.',
    `flavor_hypothesis` STRING COMMENT 'Proposed flavor profile for the concept.',
    `format_hypothesis` STRING COMMENT 'Proposed product format (e.g., ready‑to‑drink, powder, bar).',
    `intellectual_property_filed` BOOLEAN COMMENT 'Indicates whether any IP (patent, trademark) has been filed for the concept.',
    `last_test_date` DATE COMMENT 'Date of the most recent concept testing.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the concept record.',
    `launch_window_estimate` DATE COMMENT 'Estimated calendar window for product launch.',
    `market_trend_alignment_score` DECIMAL(18,2) COMMENT 'Score (0‑100) indicating how well the concept aligns with current market trends.',
    `origin_date` DATE COMMENT 'Date the concept was first created or logged.',
    `owner_role` STRING COMMENT 'Job role of the concept owner (e.g., R&D Manager, Brand Manager).',
    `pack_size_hypothesis` STRING COMMENT 'Proposed packaging size or unit (e.g., 250 ml, 12‑oz).',
    `packaging_material` STRING COMMENT 'Material used for packaging (e.g., PET, aluminum, paper).',
    `packaging_type` STRING COMMENT 'Primary packaging format (e.g., bottle, pouch, can).',
    `patent_status` STRING COMMENT 'Current patent status for the concept.. Valid values are `none|filed|granted|expired`',
    `priority` STRING COMMENT 'Business priority ranking (e.g., 1 = high, 5 = low).',
    `projected_cogs` DECIMAL(18,2) COMMENT 'Estimated COGS per unit if the concept proceeds to production.',
    `projected_margin_percent` DECIMAL(18,2) COMMENT 'Estimated gross margin as a percentage of sales price.',
    `projected_revenue` DECIMAL(18,2) COMMENT 'Estimated annual revenue (currency‑agnostic) for the concept.',
    `projected_sales_volume` STRING COMMENT 'Estimated annual unit sales if the concept is launched.',
    `projected_shelf_life_days` STRING COMMENT 'Estimated shelf life in days for the finished product.',
    `purchase_intent_rating` DECIMAL(18,2) COMMENT 'Average consumer purchase intent rating (0‑100).',
    `regulatory_approval_status` STRING COMMENT 'Current status of regulatory review for the concept.. Valid values are `pending|approved|rejected`',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk assessment score (0‑100) based on technical, market, and regulatory factors.',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Internal sustainability rating (0‑100) for the concept.',
    `target_market` STRING COMMENT 'Geographic market(s) the concept is intended for.',
    `test_comments` STRING COMMENT 'Free‑text observations from concept testing.',
    `test_method` STRING COMMENT 'Method used to obtain the concept test score.. Valid values are `clt|online|focus_group`',
    `test_sample_size` STRING COMMENT 'Number of respondents in the latest concept test.',
    `test_score` DECIMAL(18,2) COMMENT 'Aggregated score from concept testing (0‑100 scale).',
    CONSTRAINT pk_concept PRIMARY KEY(`concept_id`)
) COMMENT 'Product concept master record representing a consumer-validated or internally generated product idea prior to full formulation development — captures concept ID, concept name, category, target consumer segment, key benefit proposition, flavor/format/pack size hypothesis, concept test score (CLT or online), purchase intent rating, associated innovation pipeline entry, and concept status (active, advanced, parked, killed). Bridges consumer insight and formulation development.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`consumer_test` (
    `consumer_test_id` BIGINT COMMENT 'Unique identifier for the consumer test record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Consumer test participation must be linked to the customer account for incentive tracking and compliance reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the R&D analyst responsible for the test.',
    `rd_sensory_panel_id` BIGINT COMMENT 'Identifier of the consumer panel used for recruitment.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Consumer tests are conducted on a SKU to gauge market acceptance; linking feeds results into product launch planning.',
    `retest_consumer_test_id` BIGINT COMMENT 'Self-referencing FK on consumer_test (retest_consumer_test_id)',
    `concept_version` STRING COMMENT 'Version identifier of the product concept or formulation being evaluated.',
    `consumer_test_status` STRING COMMENT 'Current lifecycle status of the consumer test.. Valid values are `planned|in_progress|completed|analyzed|closed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consumer test record was created in the system.',
    `end_date` DATE COMMENT 'Planned end date of the consumer test.',
    `execution_timestamp` TIMESTAMP COMMENT 'Timestamp when the test execution was completed.',
    `geography` STRING COMMENT 'Geographic region or city where the test participants are located, if more granular than market.',
    `key_driver_attributes` STRING COMMENT 'Comma-separated list of attributes identified as key drivers of liking (e.g., sweetness, texture).',
    `overall_liking_score` DECIMAL(18,2) COMMENT 'Average overall liking rating on a 1-10 scale across all participants.',
    `purchase_intent_score` DECIMAL(18,2) COMMENT 'Average purchase intent rating on a 0-100 scale.',
    `recommendation` STRING COMMENT 'Recommended action based on test results.. Valid values are `launch|revise|cancel|further_testing`',
    `recruitment_criteria` STRING COMMENT 'Criteria used to select participants (e.g., age range, consumption frequency, dietary restrictions).',
    `sample_size` STRING COMMENT 'Number of participants recruited for the consumer test.',
    `start_date` DATE COMMENT 'Planned start date of the consumer test.',
    `target_demographic` STRING COMMENT 'Target consumer demographic segment for the test (e.g., Millennials, Parents).',
    `test_category` STRING COMMENT 'Broad category of the test focus.. Valid values are `sensory|concept|product|packaging|label`',
    `test_code` STRING COMMENT 'External reference code for the consumer test, used in reporting and tracking.',
    `test_duration_days` STRING COMMENT 'Planned duration of the test in days.',
    `test_market` STRING COMMENT 'Three-letter ISO country code representing the primary market where the test is conducted.. Valid values are `[A-Z]{3}`',
    `test_method` STRING COMMENT 'Blinding method applied during the test.. Valid values are `blind|double_blind|open`',
    `test_protocol` STRING COMMENT 'Detailed protocol description outlining test procedures, product usage instructions, and data collection methods.',
    `test_type` STRING COMMENT 'Methodology used for the test: in-home use test (IHUT), central location test (CLT), or online concept test.. Valid values are `in_home|central_location|online`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consumer test record.',
    CONSTRAINT pk_consumer_test PRIMARY KEY(`consumer_test_id`)
) COMMENT 'Consumer product test record capturing in-home use tests (IHUT), central location tests (CLT), and online concept/product tests conducted during R&D — captures test ID, test type, associated concept or formulation version, test market/geography, sample size, recruitment criteria, test protocol, overall liking score, purchase intent, key driver attributes, and test outcome recommendation. Distinct from marketing.consumer_insight which covers broader market research; this entity is R&D-specific product testing.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` (
    `rd_lab_sample_id` BIGINT COMMENT 'System-generated unique identifier for the laboratory sample record.',
    `batch_record_id` BIGINT COMMENT 'Identifier of the production batch from which the sample originated.',
    `employee_id` BIGINT COMMENT 'Identifier of the analyst responsible for the sample.',
    `lab_id` BIGINT COMMENT 'Identifier of the laboratory where the sample is stored or processed.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to ingredient.lot. Business justification: Lab samples are taken from a specific ingredient lot; the link supports chain‑of‑custody and regulatory documentation.',
    `pilot_trial_id` BIGINT COMMENT 'Identifier of the pilot trial linked to the sample.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Lab samples are taken from a SKU for analytical testing; linking ensures sample data is tied to the correct product.',
    `derived_from_rd_lab_sample_id` BIGINT COMMENT 'Self-referencing FK on rd_lab_sample (derived_from_rd_lab_sample_id)',
    `abv_percent` DECIMAL(18,2) COMMENT 'Alcohol content of the sample expressed as percent ABV.',
    `allergen_info` STRING COMMENT 'Allergen content or related declarations for the sample.',
    `brix_percent` DECIMAL(18,2) COMMENT 'Sugar content expressed as degrees Brix.',
    `chain_of_custody` STRING COMMENT 'Narrative record of custody transfers for the sample.',
    `collection_date` DATE COMMENT 'Date on which the sample was collected.',
    `collection_timestamp` TIMESTAMP COMMENT 'Exact timestamp of sample collection.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sample record was first created.',
    `disposal_date` DATE COMMENT 'Date on which the sample was disposed.',
    `disposal_method` STRING COMMENT 'Method used to dispose of the sample.. Valid values are `incineration|landfill|recycling|return_to_supplier|other`',
    `expiry_date` DATE COMMENT 'Date after which the sample is considered expired.',
    `formulation_version` STRING COMMENT 'Version identifier of the formulation associated with the sample.',
    `hazard_status` STRING COMMENT 'Risk classification of the sample based on safety considerations.. Valid values are `none|low|medium|high|critical`',
    `microbial_count_cfu` BIGINT COMMENT 'Colony forming units measured in the sample.',
    `notes` STRING COMMENT 'Free‑form notes or observations about the sample.',
    `ph` DECIMAL(18,2) COMMENT 'Acidity/alkalinity measurement of the sample.',
    `quality_flag` STRING COMMENT 'Result of quality assessment for the sample.. Valid values are `pass|fail|pending|retest`',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of material in the sample.',
    `rd_lab_sample_status` STRING COMMENT 'Current lifecycle status of the sample.. Valid values are `available|in_use|disposed|quarantined|expired`',
    `regulatory_approval_status` STRING COMMENT 'Regulatory review outcome for the sample.. Valid values are `approved|pending|rejected|not_required`',
    `sample_code` STRING COMMENT 'Business identifier code assigned to the sample (e.g., SMP-2023-001).',
    `sample_name` STRING COMMENT 'Human‑readable name or description of the sample.',
    `sample_type` STRING COMMENT 'Category of the sample indicating its role in R&D.. Valid values are `raw_material|intermediate|prototype|competitor_benchmark|reference_standard`',
    `storage_humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity level of the storage environment.',
    `storage_location` STRING COMMENT 'Identifier of the storage location (e.g., freezer, shelf, cabinet).',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Temperature at which the sample is stored, expressed in degrees Celsius.',
    `unit_of_measure` STRING COMMENT 'Unit used for the sample quantity.. Valid values are `g|kg|ml|l|units`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the sample record.',
    CONSTRAINT pk_rd_lab_sample PRIMARY KEY(`rd_lab_sample_id`)
) COMMENT 'Laboratory sample master record for all physical samples managed within R&D labs — captures sample ID, sample type (raw material, intermediate, prototype, competitor benchmark, reference standard), associated formulation version or pilot trial, collection date, storage conditions, quantity, chain of custody, expiry date, and disposal record. Enables sample traceability and lab inventory management across R&D facilities.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`rd_test_request` (
    `rd_test_request_id` BIGINT COMMENT 'Unique surrogate key for the laboratory test request record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Custom R&D test requests are initiated by a specific customer account; linking enables request tracking and billing.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Test request costs are allocated to cost centers; required for cost tracking of lab work.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Test request budget is managed against corporate budget; needed for budget approval workflow.',
    `employee_id` BIGINT COMMENT 'Identifier of the R&D scientist who submitted the test request.',
    `rd_lab_sample_id` BIGINT COMMENT 'Identifier of the physical sample submitted for testing.',
    `rd_project_id` BIGINT COMMENT 'Identifier of the research and development project to which the test request belongs.',
    `retest_rd_test_request_id` BIGINT COMMENT 'Self-referencing FK on rd_test_request (retest_rd_test_request_id)',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the test was completed and results were recorded.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the test request record was first created in the data lake.',
    `estimated_turnaround_hours` STRING COMMENT 'System‑calculated estimate of how long the test will take based on method and lab load.',
    `formulation_version` STRING COMMENT 'Version label of the product formulation being tested (e.g., v1.2, revA).',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the sample contains hazardous substances requiring special handling.',
    `lab_location` STRING COMMENT 'Physical location or facility where the test will be performed.',
    `notes` STRING COMMENT 'Free‑form comments or special instructions provided by the scientist.',
    `priority` STRING COMMENT 'Business priority assigned to the request, influencing lab scheduling.. Valid values are `high|medium|low`',
    `rd_test_request_status` STRING COMMENT 'Current lifecycle state of the test request as it moves through the R&D lab workflow.. Valid values are `draft|submitted|in_review|approved|rejected|completed`',
    `regulatory_compliance_required` BOOLEAN COMMENT 'True if the test must meet FDA/USDA or other regulatory specifications.',
    `request_number` STRING COMMENT 'Human‑readable identifier assigned to the test request, used in lab tracking and reporting.',
    `request_timestamp` TIMESTAMP COMMENT 'Date and time when the test request was initially submitted by the scientist.',
    `required_turnaround_hours` STRING COMMENT 'Maximum number of hours the scientist expects the test results to be returned.',
    `result_available_timestamp` TIMESTAMP COMMENT 'Date and time when the test results became accessible to the requesting scientist.',
    `sample_quantity` DECIMAL(18,2) COMMENT 'Amount of sample material submitted, expressed in grams or milliliters as appropriate.',
    `test_method` STRING COMMENT 'Analytical or physical test method requested (e.g., HPLC, GC‑MS, texture analysis).. Valid values are `hplc|gc_ms|texture|viscosity|ph|water_activity`',
    `unit_of_measure` STRING COMMENT 'Unit for the sample quantity (e.g., g, ml, mg).',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the test request record.',
    CONSTRAINT pk_rd_test_request PRIMARY KEY(`rd_test_request_id`)
) COMMENT 'Laboratory test request record submitted by R&D scientists for analytical, microbiological, or physical testing of R&D samples — captures request ID, requesting scientist, associated project and formulation version, sample reference, test methods requested (HPLC, GC-MS, texture analysis, viscosity, pH, water activity), priority, required turnaround time, and request status. Manages the R&D lab testing workflow distinct from quality.inspection_lot which covers commercial production QC.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`rd_test_result` (
    `rd_test_result_id` BIGINT COMMENT 'Unique identifier for the test result record.',
    `batch_record_id` BIGINT COMMENT 'Identifier of the production batch associated with the sample.',
    `calibration_order_id` BIGINT COMMENT 'Identifier of the instrument calibration record used.',
    `employee_id` BIGINT COMMENT 'Identifier of the analyst who performed or reviewed the test.',
    `rd_lab_sample_id` BIGINT COMMENT 'Identifier of the sample material tested.',
    `rd_test_request_id` BIGINT COMMENT 'Identifier of the associated test request.',
    `retest_rd_test_result_id` BIGINT COMMENT 'Self-referencing FK on rd_test_result (retest_rd_test_result_id)',
    `analyst_comments` STRING COMMENT 'Additional comments provided by the analyst.',
    `approval_status` STRING COMMENT 'Regulatory or internal approval status of the result.. Valid values are `approved|not_approved|pending`',
    `compliance_flag` BOOLEAN COMMENT 'Indicates if the result complies with regulatory requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test result record was created.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric score representing overall data quality assessment.',
    `data_source_system` STRING COMMENT 'Source system that supplied the test result (e.g., LIMS, MES).',
    `detection_limit` DECIMAL(18,2) COMMENT 'Lowest concentration that can be reliably measured.',
    `formulation_version` STRING COMMENT 'Version identifier of the product formulation tested.',
    `instrument_code` BIGINT COMMENT 'Identifier of the analytical instrument used.',
    `lab_location_code` STRING COMMENT 'Code representing the laboratory where testing was performed.',
    `measured_value` DECIMAL(18,2) COMMENT 'Numeric value obtained from the measurement.',
    `measurement_repeat_flag` BOOLEAN COMMENT 'True if the measurement was repeated for verification.',
    `measurement_type` STRING COMMENT 'Category of measurement performed.. Valid values are `chemical|microbial|physical|sensory`',
    `measurement_uncertainty` DECIMAL(18,2) COMMENT 'Estimated uncertainty associated with the measured value.',
    `notes` STRING COMMENT 'Free-text comments or observations related to the test result.',
    `oos_flag` BOOLEAN COMMENT 'True if the result is out of specification.',
    `parameter_name` STRING COMMENT 'Name of the measured parameter (e.g., pH, Brix).',
    `pass_fail_flag` STRING COMMENT 'Indicates whether the measured value meets specification limits.. Valid values are `pass|fail`',
    `quality_control_flag` BOOLEAN COMMENT 'Indicates if the result is part of a QC sample.',
    `rd_test_result_status` STRING COMMENT 'Current lifecycle status of the test result.. Valid values are `pending|completed|reviewed|rejected`',
    `regulatory_reference` STRING COMMENT 'Reference to the specific regulatory clause or standard applicable.',
    `result_date` DATE COMMENT 'Date component of the result timestamp.',
    `result_quality_flag` STRING COMMENT 'Quality assessment of the result.. Valid values are `acceptable|questionable|invalid`',
    `result_reviewed_by` BIGINT COMMENT 'Analyst identifier who reviewed the result.',
    `result_sequence` STRING COMMENT 'Sequence number for multiple parameters within the same test request.',
    `result_timestamp` TIMESTAMP COMMENT 'Date and time when the test result was recorded.',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the result was reviewed.',
    `specification_limit_high` DECIMAL(18,2) COMMENT 'Upper acceptable limit for the parameter.',
    `specification_limit_low` DECIMAL(18,2) COMMENT 'Lower acceptable limit for the parameter.',
    `test_method` STRING COMMENT 'Method used to perform the analytical test.. Valid values are `HPLC|GC-MS|LC-MS|ELISA|PCR|NIR`',
    `test_result_category` STRING COMMENT 'Broad category of the test result.. Valid values are `stability|purity|potency|microbial|sensory`',
    `test_result_source` STRING COMMENT 'Origin of the test result data.. Valid values are `lab|field|external`',
    `unit_of_measure` STRING COMMENT 'Unit associated with the measured value (e.g., mg/L, %).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the test result record.',
    CONSTRAINT pk_rd_test_result PRIMARY KEY(`rd_test_result_id`)
) COMMENT 'Analytical test result record for R&D laboratory tests — captures result ID, associated test request, test method applied, instrument used, analyst, result values per parameter (with units), specification limits for comparison, pass/fail determination, result date, and any out-of-specification (OOS) flags. Provides the scientific data foundation for formulation optimization decisions. Distinct from ingredient.test_result (raw material CoA testing) and quality.micro_test_result (production QC).';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` (
    `competitor_benchmark_id` BIGINT COMMENT 'Unique surrogate key for each competitor benchmark record.',
    `concept_id` BIGINT COMMENT 'Foreign key linking to research.concept. Business justification: Competitor benchmarks are evaluated against product concepts; linking provides context for analysis.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Benchmarking competitor products against our SKU requires associating benchmark data with the SKU for pricing and positioning analysis.',
    `previous_competitor_benchmark_id` BIGINT COMMENT 'Self-referencing FK on competitor_benchmark (previous_competitor_benchmark_id)',
    `allergen_info` STRING COMMENT 'Allergen declarations (e.g., contains milk, soy).',
    `benchmark_code` STRING COMMENT 'Business identifier code used to reference the benchmark in external systems.',
    `benchmark_date` DATE COMMENT 'Date when the competitor product was evaluated.',
    `competitor_benchmark_status` STRING COMMENT 'Current lifecycle status of the benchmark record.. Valid values are `active|inactive|archived`',
    `competitor_brand` STRING COMMENT 'Name of the competitors brand.',
    `competitor_product_name` STRING COMMENT 'Name of the competitors product being benchmarked.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the product complies with relevant regulatory requirements (e.g., FDA, USDA).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the benchmark record was first created.',
    `evaluation_method` STRING COMMENT 'Methodology used to conduct the benchmark evaluation.. Valid values are `In-house|Third-party|Consumer|Lab`',
    `ingredient_list` STRING COMMENT 'Full list of ingredients as declared on the product label.',
    `label_claims` STRING COMMENT 'Other label claims (e.g., "Organic", "Non‑GMO").',
    `market_region` STRING COMMENT 'Three‑letter ISO country code representing the geographic market where the product was purchased.. Valid values are `USA|CAN|MEX|GBR|FRA|DEU`',
    `nutrient_claims` STRING COMMENT 'Marketing claims related to nutrients (e.g., "Low Sugar", "High Protein").',
    `nutritional_calories_kcal` STRING COMMENT 'Energy content per serving expressed in kilocalories.',
    `nutritional_carbohydrate_g` DECIMAL(18,2) COMMENT 'Total carbohydrate grams per serving.',
    `nutritional_fat_g` DECIMAL(18,2) COMMENT 'Total fat grams per serving.',
    `nutritional_protein_g` DECIMAL(18,2) COMMENT 'Protein grams per serving.',
    `nutritional_saturated_fat_g` DECIMAL(18,2) COMMENT 'Saturated fat grams per serving.',
    `nutritional_sodium_mg` STRING COMMENT 'Sodium milligrams per serving.',
    `nutritional_sugar_g` DECIMAL(18,2) COMMENT 'Total sugar grams per serving.',
    `packaging_format` STRING COMMENT 'Description of the packaging type and size (e.g., Bottle 500 ml, Can 330 ml).',
    `packaging_material` STRING COMMENT 'Primary material of the packaging (e.g., PET, Glass, Aluminum).',
    `price_currency` STRING COMMENT 'Three‑letter ISO currency code for the retail price.. Valid values are `USD|CAD|EUR|GBP|JPY|CNY`',
    `product_category` STRING COMMENT 'High‑level category of the product (e.g., Beverage, Snack).',
    `product_subcategory` STRING COMMENT 'More specific sub‑category (e.g., Carbonated Soft Drink, Energy Bar).',
    `product_type` STRING COMMENT 'Broad type classification (e.g., Beverage, Snack, Dairy).',
    `purchase_market` STRING COMMENT 'Channel through which the benchmark product was purchased.. Valid values are `Retail|Foodservice|Online|Convenience|Club|Restaurant`',
    `retail_price` DECIMAL(18,2) COMMENT 'Retail price of the competitor product in the specified currency.',
    `sample_size` STRING COMMENT 'Number of panelists or units evaluated for the benchmark.',
    `sensory_aftertaste_score` STRING COMMENT 'Score (0‑10) for aftertaste from the sensory panel.',
    `sensory_appearance_score` STRING COMMENT 'Score (0‑10) for visual appearance from the sensory panel.',
    `sensory_aroma_score` STRING COMMENT 'Score (0‑10) for aroma from the sensory panel.',
    `sensory_flavor_score` STRING COMMENT 'Score (0‑10) for flavor from the sensory panel.',
    `sensory_overall_liking_score` STRING COMMENT 'Overall liking score (0‑10) from the sensory panel.',
    `sensory_texture_score` STRING COMMENT 'Score (0‑10) for mouthfeel/texture from the sensory panel.',
    `shelf_life_days` STRING COMMENT 'Number of days the product remains fit for consumption under recommended storage.',
    `source_system` STRING COMMENT 'System or process that supplied the benchmark data (e.g., TraceGains, Manual).',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Optimal storage temperature in degrees Celsius.',
    `strategic_implications` STRING COMMENT 'Analyst commentary on how the benchmark influences product strategy.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the benchmark record.',
    `volume_ml` STRING COMMENT 'Net liquid volume of the product in milliliters.',
    CONSTRAINT pk_competitor_benchmark PRIMARY KEY(`competitor_benchmark_id`)
) COMMENT 'Competitive product benchmarking record capturing the systematic evaluation of competitor and market reference products — captures benchmark ID, competitor brand and product name, category, purchase market, evaluation date, sensory profile scores, nutritional composition, ingredient list analysis, packaging format, retail price point, and strategic implications. Informs formulation targets and positioning decisions during NPD.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`rd_budget` (
    `rd_budget_id` BIGINT COMMENT 'System-generated unique identifier for the R&D budget record.',
    `employee_id` BIGINT COMMENT 'System identifier of the user who approved the budget.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: R&D‑specific budget must map to the master finance budget record for consolidation and reporting.',
    `rd_project_id` BIGINT COMMENT 'Identifier of the R&D project to which this budget belongs.',
    `parent_rd_budget_id` BIGINT COMMENT 'Self-referencing FK on rd_budget (parent_rd_budget_id)',
    `approval_date` DATE COMMENT 'Date when the budget was formally approved.',
    `budget_code` STRING COMMENT 'Business identifier for the budget, often used in reporting and external communication.',
    `budget_external_testing_amount` DECIMAL(18,2) COMMENT 'Approved budget for third‑party testing and validation services.',
    `budget_licensing_amount` DECIMAL(18,2) COMMENT 'Approved budget for licensing fees, patents, and IP costs.',
    `budget_materials_amount` DECIMAL(18,2) COMMENT 'Approved budget for raw material and ingredient costs.',
    `budget_owner` STRING COMMENT 'Name of the individual responsible for the budget.',
    `budget_personnel_amount` DECIMAL(18,2) COMMENT 'Approved budget for personnel costs within the R&D project.',
    `budget_pilot_plant_amount` DECIMAL(18,2) COMMENT 'Approved budget for pilot‑scale production runs.',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget.. Valid values are `draft|approved|active|closed|cancelled`',
    `budget_type` STRING COMMENT 'Classification of the budget purpose: operational, capital, or research.. Valid values are `operational|capital|research`',
    `cost_center_code` STRING COMMENT 'Internal cost center to which the budget is charged.. Valid values are `CC[0-9]{4}`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the budget record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for all monetary amounts.. Valid values are `[A-Z]{3}`',
    `department_code` STRING COMMENT 'Department responsible for the R&D effort.',
    `effective_from` DATE COMMENT 'Date when the budget becomes effective.',
    `effective_until` DATE COMMENT 'Date when the budget expires or is superseded.',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year for which the budget is planned.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the budget details are confidential.',
    `notes` STRING COMMENT 'Additional remarks, comments, or audit notes.',
    `rd_budget_description` STRING COMMENT 'Free‑form description of the budget purpose and scope.',
    `region_code` STRING COMMENT 'Three‑letter code representing the geographic region of the budget.. Valid values are `[A-Z]{3}`',
    `total_actual_spend` DECIMAL(18,2) COMMENT 'Cumulative actual spend to date across all categories.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Approved total budget amount across all categories.',
    `total_committed_spend` DECIMAL(18,2) COMMENT 'Spend that has been committed but not yet incurred.',
    `total_forecast_to_complete` DECIMAL(18,2) COMMENT 'Projected additional spend required to complete the budget.',
    `total_variance_amount` DECIMAL(18,2) COMMENT 'Difference between approved budget and actual spend (budget - actual).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the budget record.',
    CONSTRAINT pk_rd_budget PRIMARY KEY(`rd_budget_id`)
) COMMENT 'R&D project-level budget and spend tracking record — captures budget ID, associated R&D project, fiscal year, approved budget by category (personnel, materials, external testing, pilot plant, licensing), actual spend to date, committed spend, forecast to complete, variance, and budget owner. Provides R&D financial governance at the project level. Distinct from finance.budget which covers enterprise-wide financial budgeting.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`external_collaboration` (
    `external_collaboration_id` BIGINT COMMENT 'Unique system-generated identifier for the external collaboration record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: External collaborations may involve a strategic customer partner; linking captures the account for governance and revenue sharing.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Collaboration funding is recorded in corporate budget; required for financial oversight of external R&D.',
    `formulation_version_id` BIGINT COMMENT 'Identifier of the formulation version that is the focus of the collaboration.',
    `rd_project_id` BIGINT COMMENT 'Identifier of the internal R&D project associated with this collaboration.',
    `parent_external_collaboration_id` BIGINT COMMENT 'Self-referencing FK on external_collaboration (parent_external_collaboration_id)',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the collaboration agreement was formally approved.',
    `collaboration_code` STRING COMMENT 'Human‑readable code assigned to the collaboration for external reference.',
    `collaboration_name` STRING COMMENT 'Descriptive name of the external R&D collaboration.',
    `collaboration_scope` STRING COMMENT 'Brief description of the functional and technical scope of the collaboration.',
    `collaboration_status` STRING COMMENT 'Current lifecycle state of the collaboration.. Valid values are `active|inactive|completed|terminated|pending`',
    `collaboration_type` STRING COMMENT 'High‑level classification of the collaboration (e.g., joint development, technology scouting).',
    `confidentiality_level` STRING COMMENT 'Data sensitivity classification for the collaboration record.. Valid values are `restricted|confidential|public`',
    `contract_document_code` STRING COMMENT 'Identifier of the stored contract document in the document management system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the collaboration record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code for the funding amount.. Valid values are `[A-Z]{3}`',
    `deliverables` STRING COMMENT 'Expected tangible outputs (e.g., prototypes, reports, patents).',
    `end_date` DATE COMMENT 'Date the collaboration agreement terminates or expires (nullable for open‑ended).',
    `funding_amount` DECIMAL(18,2) COMMENT 'Total monetary funding allocated to the collaboration.',
    `funding_source` STRING COMMENT 'Origin of the funding (e.g., internal R&D budget, external grant).',
    `ip_ownership_terms` STRING COMMENT 'Key terms defining ownership and licensing of IP generated through the collaboration.',
    `location_city` STRING COMMENT 'City of the partners primary location.',
    `location_country` STRING COMMENT 'ISO‑3 country code of the partners primary location.. Valid values are `[A-Z]{3}`',
    `milestones` STRING COMMENT 'Structured list of major milestones and target dates for the collaboration.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the collaboration.',
    `partner_contact_email` STRING COMMENT 'Primary email address for the external partner contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `partner_contact_phone` STRING COMMENT 'Primary telephone number for the external partner contact.',
    `partner_name` STRING COMMENT 'Legal name of the external partner organization.',
    `partner_type` STRING COMMENT 'Category of the external partner.. Valid values are `university|startup|cro|supplier|industry_consortium`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the collaboration complies with all applicable food‑safety and regulatory requirements.',
    `renewal_option` STRING COMMENT 'Indicates whether the collaboration may be renewed after the end date.. Valid values are `yes|no`',
    `risk_assessment_level` STRING COMMENT 'Overall risk rating assigned to the collaboration.. Valid values are `low|medium|high`',
    `start_date` DATE COMMENT 'Date the collaboration agreement becomes effective.',
    `status_change_date` DATE COMMENT 'Date when the collaboration status last changed.',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Internal sustainability rating for the collaboration (0‑100 scale).',
    `termination_reason` STRING COMMENT 'Reason for termination if the collaboration ends before the planned end date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the collaboration record.',
    CONSTRAINT pk_external_collaboration PRIMARY KEY(`external_collaboration_id`)
) COMMENT 'External R&D collaboration and partnership record capturing joint development agreements, university research partnerships, startup co-development arrangements, and contract research organization (CRO) engagements — captures collaboration ID, partner name, partner type (university, startup, CRO, supplier, industry consortium), collaboration scope, start and end dates, IP ownership terms, milestones, deliverables, and collaboration status. Manages the open innovation ecosystem at Food Beverage.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` (
    `regulatory_submission_dossier_id` BIGINT COMMENT 'Unique identifier for the regulatory submission dossier record.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the dossier record.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Regulatory Dossier Traceability: dossier must reference the product registration to ensure correct filing.',
    `rd_project_id` BIGINT COMMENT 'Identifier of the R&D project linked to the submission.',
    `formulation_version_id` BIGINT COMMENT 'Identifier of the formulation version associated with this submission.',
    `amended_regulatory_submission_dossier_id` BIGINT COMMENT 'Self-referencing FK on regulatory_submission_dossier (amended_regulatory_submission_dossier_id)',
    `agency_name` STRING COMMENT 'Name of the regulatory agency handling the submission.. Valid values are `FDA|USDA|EFSA|GFSI|ISO_22000|FSSAI`',
    `agency_reference_number` STRING COMMENT 'Reference number assigned by the agency to the submission.',
    `approval_outcome` STRING COMMENT 'Final outcome of the regulatory review.. Valid values are `approved|conditionally_approved|rejected|withdrawn`',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the submission meets all regulatory compliance requirements.',
    `confidentiality_flag` BOOLEAN COMMENT 'Indicates whether the dossier contains confidential information.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dossier record was created.',
    `currency_code` STRING COMMENT 'Currency of the submission fee.. Valid values are `USD|EUR|CAD|GBP|JPY|CNY`',
    `docket_url` STRING COMMENT 'Web URL linking to the electronic dossier.',
    `dossier_number` STRING COMMENT 'Agency-assigned identifier for the dossier.',
    `dossier_title` STRING COMMENT 'Human‑readable title describing the dossier.',
    `expected_decision_date` DATE COMMENT 'Projected date for agency decision on the submission.',
    `expiration_date` DATE COMMENT 'Date after which the dossier is no longer active.',
    `formulation_version` STRING COMMENT 'Version identifier of the formulation associated with the submission.',
    `ingredient_list` STRING COMMENT 'List of ingredient identifiers included in the submission.',
    `jurisdiction` STRING COMMENT 'Geographic jurisdiction for the submission.. Valid values are `USA|EU|CAN|AUS|JPN|CHN`',
    `regulatory_agency_contact` STRING COMMENT 'Contact details of the agency representative handling the dossier.',
    `regulatory_review_notes` STRING COMMENT 'Notes and comments from the regulatory agency during review.',
    `regulatory_submission_dossier_status` STRING COMMENT 'Current lifecycle status of the dossier.. Valid values are `draft|submitted|under_review|approved|rejected|withdrawn`',
    `review_status` STRING COMMENT 'Current status of the agencys review process.. Valid values are `pending|in_review|completed`',
    `risk_assessment_level` STRING COMMENT 'Risk level assigned to the submission based on product and ingredient profile.. Valid values are `low|medium|high`',
    `scientific_evidence_summary` STRING COMMENT 'Summary of scientific evidence supporting the submission.',
    `submission_category` STRING COMMENT 'Category indicating whether the submission is pre‑market or post‑market.. Valid values are `pre_market|post_market`',
    `submission_channel` STRING COMMENT 'Channel through which the submission was transmitted.. Valid values are `ePortal|email|mail`',
    `submission_date` DATE COMMENT 'Date the dossier was submitted to the regulatory agency.',
    `submission_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the agency for processing the submission.',
    `submission_method` STRING COMMENT 'Method used to submit the dossier to the agency.. Valid values are `electronic|paper`',
    `submission_priority` STRING COMMENT 'Priority level assigned to the submission for processing.. Valid values are `high|medium|low`',
    `submission_source_system` STRING COMMENT 'Originating system that created the dossier record.',
    `submission_type` STRING COMMENT 'Category of the regulatory submission.. Valid values are `GRAS|novel_food|health_claim|food_additive`',
    `supporting_documents_count` STRING COMMENT 'Number of supporting documents attached to the dossier.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the dossier record.',
    CONSTRAINT pk_regulatory_submission_dossier PRIMARY KEY(`regulatory_submission_dossier_id`)
) COMMENT 'R&D-originated regulatory submission dossier record for novel food ingredients, GRAS notifications, health claims substantiation, and new product market authorizations — captures dossier ID, submission type (GRAS, novel food, health claim, food additive petition), target jurisdiction, associated formulation and R&D project, submission date, agency reference number, review status, and approval outcome. Distinct from regulatory.agency_submission which tracks post-commercialization regulatory filings; this entity covers R&D-stage pre-market submissions.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` (
    `ingredient_feasibility_id` BIGINT COMMENT 'System-generated unique identifier for each ingredient feasibility assessment record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Ingredient feasibility studies can be requested by customers; linking tracks customer‑driven feasibility work.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the assessment record.',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to ingredient.raw_material. Business justification: Feasibility studies assess a specific raw materials technical, regulatory and supply attributes, so they must link to that raw_material record.',
    `rd_project_id` BIGINT COMMENT 'Identifier of the R&D project associated with this feasibility assessment.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Feasibility assessments of ingredients are performed for a particular SKU; linking enables ingredient selection per product.',
    `superseded_ingredient_feasibility_id` BIGINT COMMENT 'Self-referencing FK on ingredient_feasibility (superseded_ingredient_feasibility_id)',
    `allergen_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is a known allergen.',
    `assessment_code` STRING COMMENT 'Business-friendly alphanumeric code assigned to the feasibility assessment for external reference.',
    `assessment_date` DATE COMMENT 'Date on which the feasibility assessment was performed.',
    `assessment_status` STRING COMMENT 'Current lifecycle state of the feasibility assessment.. Valid values are `draft|under_review|completed|archived`',
    `brix_value` DECIMAL(18,2) COMMENT 'Sugar content expressed in degrees Brix.',
    `cfus_per_gram` STRING COMMENT 'Microbial count indicating safety or probiotic potency.',
    `cost_per_unit_usd` DECIMAL(18,2) COMMENT 'Unit cost of the ingredient expressed in US dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment record was first created.',
    `feasibility_cost_score` DECIMAL(18,2) COMMENT 'Score (0‑100) representing cost competitiveness of the ingredient.',
    `feasibility_regulatory_status` STRING COMMENT 'Regulatory clearance status for the ingredient in target markets.. Valid values are `approved|pending|rejected|not_applicable`',
    `feasibility_supply_availability_score` DECIMAL(18,2) COMMENT 'Score (0‑100) indicating reliability and volume of supply from the vendor.',
    `feasibility_sustainability_score` DECIMAL(18,2) COMMENT 'Score (0‑100) reflecting environmental and social sustainability attributes.',
    `feasibility_technical_functionality_score` DECIMAL(18,2) COMMENT 'Score (0‑100) reflecting how well the ingredient meets technical formulation requirements.',
    `functional_properties` STRING COMMENT 'Free‑text description of the ingredients functional benefits (e.g., emulsification, gelling).',
    `gluten_free` BOOLEAN COMMENT 'True if the ingredient is certified gluten‑free.',
    `halal_certified` BOOLEAN COMMENT 'True if the ingredient is certified halal.',
    `ingredient_name` STRING COMMENT 'Descriptive name of the ingredient being evaluated.',
    `ingredient_origin_country` STRING COMMENT 'Three‑letter ISO country code of the ingredients primary source.. Valid values are `^[A-Z]{3}$`',
    `ingredient_type` STRING COMMENT 'Category of the ingredient based on its functional role in formulations.. Valid values are `novel_protein|functional_fiber|natural_color|flavor|bioactive`',
    `kosher_certified` BOOLEAN COMMENT 'True if the ingredient is certified kosher.',
    `non_gmo` BOOLEAN COMMENT 'True if the ingredient is verified non‑genetically modified.',
    `notes` STRING COMMENT 'Additional observations, comments, or rationale captured by the assessor.',
    `organic_certified` BOOLEAN COMMENT 'True if the ingredient holds an organic certification.',
    `overall_feasibility_score` DECIMAL(18,2) COMMENT 'Aggregated weighted score summarizing all feasibility dimensions.',
    `ph_value` DECIMAL(18,2) COMMENT 'Acidity/alkalinity measurement of the ingredient.',
    `recommendation` STRING COMMENT 'Decision outcome based on the overall feasibility score.. Valid values are `approve|conditional_approve|reject|further_study`',
    `regulatory_comments` STRING COMMENT 'Narrative notes on regulatory considerations, exemptions, or pending actions.',
    `risk_level` STRING COMMENT 'Overall risk classification derived from feasibility findings.. Valid values are `low|medium|high|critical`',
    `shelf_life_days` STRING COMMENT 'Recommended shelf life of the ingredient under standard storage conditions.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Optimal storage temperature for the ingredient in degrees Celsius.',
    `supplier_name` STRING COMMENT 'Name of the ingredient supplier providing the material.',
    `supply_lead_time_days` STRING COMMENT 'Estimated number of days required for the supplier to deliver the ingredient.',
    `sustainability_metric` STRING COMMENT 'Key sustainability indicator (e.g., carbon_footprint_kg_co2e).',
    `sustainability_metric_value` DECIMAL(18,2) COMMENT 'Numeric value associated with the selected sustainability metric.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the assessment record.',
    CONSTRAINT pk_ingredient_feasibility PRIMARY KEY(`ingredient_feasibility_id`)
) COMMENT 'Ingredient feasibility assessment record evaluating new or novel ingredients for potential use in Food Beverage formulations — captures assessment ID, ingredient name, supplier, ingredient type (novel protein, functional fiber, natural color, flavor, bioactive), feasibility dimensions assessed (technical functionality, regulatory status, supply availability, cost, sustainability), overall feasibility score, recommendation, and associated R&D project. Bridges technology scouting and formulation development.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`scale_up_plan` (
    `scale_up_plan_id` BIGINT COMMENT 'Unique identifier for the scale-up plan.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Scale‑up activities are charged to cost centers for cost tracking; required for cost‑center reporting.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Scale‑up plan budget aligns with corporate budget; supports budget control and variance analysis.',
    `formulation_version_id` BIGINT COMMENT 'Identifier of the formulation version being scaled up.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Scale‑up expenses post to GL accounts; needed for accurate financial statements.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who performed the readiness sign‑off.',
    `rd_project_id` BIGINT COMMENT 'Identifier of the R&D project linked to this scale‑up plan.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Scale‑up plans are drafted for a SKU to transition from pilot to full production; linking provides schedule and cost alignment.',
    `plant_id` BIGINT COMMENT 'Identifier of the plant where commercial production will occur.',
    `production_line_id` BIGINT COMMENT 'Identifier of the specific production line within the target plant.',
    `tertiary_scale_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified the scale‑up plan record.',
    `superseded_scale_up_plan_id` BIGINT COMMENT 'Self-referencing FK on scale_up_plan (superseded_scale_up_plan_id)',
    `actual_cost_usd` DECIMAL(18,2) COMMENT 'Total actual cost incurred to date for the scale‑up plan, in US dollars.',
    `budget_usd` DECIMAL(18,2) COMMENT 'Approved budget for the scale‑up effort, expressed in US dollars.',
    `compliance_status` STRING COMMENT 'Current compliance status of the scale‑up plan with internal and external regulations.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the scale‑up plan record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for budget and cost fields. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CAD|AUD|CHF|CNY|INR|BRL|MXN|ZAR — promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date when the scale‑up plan ends or is superseded (nullable for open‑ended plans).',
    `effective_start_date` DATE COMMENT 'Date when the scale‑up plan becomes effective.',
    `equipment_qualification_requirements` STRING COMMENT 'Requirements and criteria for qualifying equipment for scale‑up.',
    `milestone_count` STRING COMMENT 'Total count of defined milestones in the scale‑up plan.',
    `next_milestone_date` DATE COMMENT 'Planned date of the upcoming milestone.',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the scale‑up plan.',
    `plan_code` STRING COMMENT 'Human‑readable code identifying the scale‑up plan.',
    `plan_name` STRING COMMENT 'Descriptive name of the scale‑up plan.',
    `plan_type` STRING COMMENT 'Category of the scale‑up plan indicating the nature of the transition.. Valid values are `pilot_to_commercial|line_scale_up|facility_expansion`',
    `process_parameter_transfer_specifications` STRING COMMENT 'Detailed specifications for transferring process parameters from pilot to commercial scale.',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory approvals required for the scaled‑up product.. Valid values are `approved|pending|rejected`',
    `risk_assessment_details` STRING COMMENT 'Narrative description of identified risks and mitigation actions.',
    `risk_assessment_level` STRING COMMENT 'Overall risk level assigned to the scale‑up plan.. Valid values are `low|medium|high`',
    `scale_up_plan_status` STRING COMMENT 'Current lifecycle status of the scale‑up plan.. Valid values are `planned|in_progress|completed|on_hold|cancelled`',
    `scale_up_readiness_signoff` BOOLEAN COMMENT 'Indicates whether the plan has been formally signed off as ready for execution.',
    `signoff_timestamp` TIMESTAMP COMMENT 'Timestamp when the readiness sign‑off was recorded.',
    `trial_batch_schedule` STRING COMMENT 'Schedule and sequencing of trial batches during scale‑up.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the scale‑up plan record.',
    CONSTRAINT pk_scale_up_plan PRIMARY KEY(`scale_up_plan_id`)
) COMMENT 'Manufacturing scale-up plan record defining the transition pathway from pilot plant to commercial production for an approved R&D formulation — captures plan ID, associated R&D project and formulation version, target manufacturing plant and line, scale-up milestones, process parameter transfer specifications, equipment qualification requirements, trial batch schedule, risk assessment, and scale-up readiness sign-off. Bridges R&D and manufacturing domains.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`rd_milestone` (
    `rd_milestone_id` BIGINT COMMENT 'System-generated unique identifier for the research and development milestone record.',
    `employee_id` BIGINT COMMENT 'Identifier of the person responsible for the milestone.',
    `rd_project_id` BIGINT COMMENT 'Identifier of the R&D project to which this milestone belongs.',
    `predecessor_rd_milestone_id` BIGINT COMMENT 'Self-referencing FK on rd_milestone (predecessor_rd_milestone_id)',
    `actual_completion_date` DATE COMMENT 'Date the milestone was actually completed or closed.',
    `actual_duration_days` STRING COMMENT 'Number of calendar days actually taken to complete the milestone.',
    `approval_status` STRING COMMENT 'Current approval state of the milestone after review.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the milestone received its final approval decision.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the milestone meets all applicable regulatory and internal compliance requirements.',
    `cost_actual_usd` DECIMAL(18,2) COMMENT 'Actual cost incurred to complete the milestone, expressed in US dollars.',
    `cost_target_usd` DECIMAL(18,2) COMMENT 'Planned cost budget for achieving the milestone, expressed in US dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the milestone record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for cost fields.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `delay_days` STRING COMMENT 'Number of days the milestone was delayed beyond the planned date.',
    `delay_reason` STRING COMMENT 'Narrative explanation for any deviation from the planned date.',
    `expected_duration_days` STRING COMMENT 'Planned number of calendar days allocated to complete the milestone.',
    `gate_decision` STRING COMMENT 'Result of the gate review for the milestone.. Valid values are `pass|fail|conditional|deferred`',
    `is_critical` BOOLEAN COMMENT 'True if the milestone is a critical path item for product launch.',
    `is_gate_milestone` BOOLEAN COMMENT 'True if the milestone serves as a stage‑gate decision point.',
    `milestone_code` STRING COMMENT 'Human‑readable code assigned to the milestone for tracking and reference.',
    `milestone_name` STRING COMMENT 'Descriptive name of the milestone (e.g., "Formulation Freeze").',
    `milestone_sequence` STRING COMMENT 'Ordinal position of the milestone within the R&D project timeline.',
    `milestone_type` STRING COMMENT 'Category of the milestone indicating the gate or decision point in the R&D project.. Valid values are `formulation_freeze|sensory_approval|pilot_trial_completion|regulatory_clearance|cost_target_confirmation|launch_readiness`',
    `notes` STRING COMMENT 'Additional free‑form comments or observations related to the milestone.',
    `owner_department` STRING COMMENT 'Organizational department responsible for the milestone owner.',
    `owner_role` STRING COMMENT 'Job role or function of the milestone owner (e.g., Project Lead, Scientist).',
    `planned_date` DATE COMMENT 'Target date on which the milestone is scheduled to be achieved.',
    `priority` STRING COMMENT 'Business priority assigned to the milestone.. Valid values are `low|medium|high|critical`',
    `rd_milestone_status` STRING COMMENT 'Current lifecycle state of the milestone.. Valid values are `planned|in_progress|completed|delayed|cancelled`',
    `regulatory_clearance_status` STRING COMMENT 'Status of any required regulatory approval for the milestone.. Valid values are `not_required|pending|cleared|rejected`',
    `risk_level` STRING COMMENT 'Risk assessment rating assigned to the milestone.. Valid values are `low|medium|high|critical`',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the milestone record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the milestone record.',
    `created_by` STRING COMMENT 'User identifier of the person who created the milestone record.',
    CONSTRAINT pk_rd_milestone PRIMARY KEY(`rd_milestone_id`)
) COMMENT 'Project milestone record tracking key deliverables and decision points within an R&D project — captures milestone ID, associated R&D project, milestone name, milestone type (formulation freeze, sensory approval, pilot trial completion, regulatory clearance, cost target confirmation, launch readiness), planned date, actual completion date, milestone owner, completion status, and any delay rationale. Enables project timeline management and stage-gate readiness tracking.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`lab` (
    `lab_id` BIGINT COMMENT 'Primary key for lab',
    `parent_lab_id` BIGINT COMMENT 'Self-referencing FK on lab (parent_lab_id)',
    `address_line1` STRING COMMENT 'First line of the laboratorys street address.',
    `address_line2` STRING COMMENT 'Second line of the laboratorys street address (optional).',
    `audit_status` STRING COMMENT 'Result of the latest audit.',
    `budget_annual_usd` DECIMAL(18,2) COMMENT 'Approved annual operating budget for the laboratory in US dollars.',
    `capacity_kg` DECIMAL(18,2) COMMENT 'Maximum material handling capacity of the laboratory in kilograms.',
    `city` STRING COMMENT 'City where the laboratory is located.',
    `classification` STRING COMMENT 'Classification indicating ownership or contractual arrangement.',
    `lab_code` STRING COMMENT 'Internal alphanumeric code used to reference the laboratory.',
    `cost_center_code` STRING COMMENT 'Financial cost center associated with the laboratorys expenses.',
    `country` STRING COMMENT 'Three‑letter ISO country code where the laboratory resides.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the laboratory record was first created in the system.',
    `lab_description` STRING COMMENT 'Free‑form description of the laboratorys purpose and capabilities.',
    `effective_from` DATE COMMENT 'Date when the laboratory became active for R&D use.',
    `effective_until` DATE COMMENT 'Date when the laboratory is scheduled to be retired or repurposed (nullable).',
    `equipment_count` STRING COMMENT 'Total number of major equipment units installed in the laboratory.',
    `humidity_control_capability` BOOLEAN COMMENT 'Indicates if the laboratory can maintain controlled humidity levels.',
    `is_iso_certified` BOOLEAN COMMENT 'Indicates whether the laboratory holds an ISO certification.',
    `iso_certification_number` STRING COMMENT 'Reference number of the ISO certification, if applicable.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the laboratory (decimal degrees).',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the laboratory (decimal degrees).',
    `max_humidity_percent` DECIMAL(18,2) COMMENT 'Maximum allowable relative humidity for controlled zones.',
    `max_temperature_c` DECIMAL(18,2) COMMENT 'Maximum allowable temperature for controlled zones.',
    `min_temperature_c` DECIMAL(18,2) COMMENT 'Minimum allowable temperature for controlled zones.',
    `lab_name` STRING COMMENT 'Human‑readable name of the laboratory.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the laboratory.',
    `operating_hours` STRING COMMENT 'Standard operating hours for the laboratory (e.g., 08:00‑18:00).',
    `owner_department` STRING COMMENT 'Internal department responsible for the laboratory.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the laboratory address.',
    `primary_contact_email` STRING COMMENT 'Email address of the laboratorys primary contact.',
    `primary_contact_name` STRING COMMENT 'Name of the main point‑of‑contact for the laboratory.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the laboratorys primary contact.',
    `region` STRING COMMENT 'Broad geographic region (e.g., North America, EMEA) where the laboratory is located.',
    `risk_level` STRING COMMENT 'Overall risk classification based on safety and compliance assessments.',
    `safety_certification_status` STRING COMMENT 'Current status of the laboratorys safety certifications.',
    `state` STRING COMMENT 'State or province of the laboratory location.',
    `lab_status` STRING COMMENT 'Current operational status of the laboratory.',
    `temperature_control_capability` BOOLEAN COMMENT 'Indicates if the laboratory can maintain controlled temperature environments.',
    `lab_type` STRING COMMENT 'Category of laboratory based on its primary function.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the laboratory record.',
    `waste_disposal_method` STRING COMMENT 'Primary method used for hazardous waste disposal at the laboratory.',
    CONSTRAINT pk_lab PRIMARY KEY(`lab_id`)
) COMMENT 'Master reference table for lab. Referenced by lab_id.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`sensory_session` (
    `sensory_session_id` BIGINT COMMENT 'Primary key for sensory_session',
    `panelist_group_id` BIGINT COMMENT 'Identifier of the panelist group assigned to this session.',
    `sku_id` BIGINT COMMENT 'Identifier of the product being evaluated in the session.',
    `follow_up_sensory_session_id` BIGINT COMMENT 'Self-referencing FK on sensory_session (follow_up_sensory_session_id)',
    `average_score` DECIMAL(18,2) COMMENT 'Mean score across all panelists for the primary attribute.',
    `conducted_by` STRING COMMENT 'Name of the researcher or lead who oversaw the session.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sensory session record was first created.',
    `data_collection_device` STRING COMMENT 'Tool used to capture panelist responses (e.g., tablet, paper, mobile app).',
    `end_timestamp` TIMESTAMP COMMENT 'Date and time when the sensory session concluded.',
    `is_blinded` BOOLEAN COMMENT 'Indicates whether the session was conducted blind to product identity.',
    `location_name` STRING COMMENT 'Name of the facility or site where the session was conducted.',
    `notes` STRING COMMENT 'Free-text field for additional observations or comments.',
    `number_of_panelists` STRING COMMENT 'Total count of panelists participating in the session.',
    `protocol_version` STRING COMMENT 'Version identifier of the sensory testing protocol applied.',
    `randomization_scheme` STRING COMMENT 'Approach used to randomize sample presentation order.',
    `sampling_method` STRING COMMENT 'Methodology for selecting panelists for the session.',
    `scale_type` STRING COMMENT 'Scale used by panelists to record their responses.',
    `sensory_attribute` STRING COMMENT 'Specific sensory characteristic being measured.',
    `session_code` STRING COMMENT 'Alphanumeric code used internally to reference the session.',
    `session_name` STRING COMMENT 'Descriptive name given to the sensory session for easy identification.',
    `session_type` STRING COMMENT 'Category of the sensory session based on its purpose.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the sensory session began.',
    `sensory_session_status` STRING COMMENT 'Current lifecycle state of the session.',
    `test_method` STRING COMMENT 'Methodology used to conduct the sensory evaluation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the session record.',
    CONSTRAINT pk_sensory_session PRIMARY KEY(`sensory_session_id`)
) COMMENT 'Master reference table for sensory_session. Referenced by session_id.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`research`.`panelist_group` (
    `panelist_group_id` BIGINT COMMENT 'Primary key for panelist_group',
    `parent_panelist_group_id` BIGINT COMMENT 'Self-referencing FK on panelist_group (parent_panelist_group_id)',
    `approval_status` STRING COMMENT 'Current approval state of the panelist group for use in studies.',
    `confidentiality_level` STRING COMMENT 'Data sensitivity classification for the panelist group.',
    `consent_obtained_date` DATE COMMENT 'Date when data privacy consent was recorded for the group.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the panelist group record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the incentive amount.',
    `data_privacy_consent` BOOLEAN COMMENT 'Indicates whether all panelists have provided required data privacy consent.',
    `panelist_group_description` STRING COMMENT 'Detailed description of the groups purpose, composition, and usage.',
    `effective_end_date` DATE COMMENT 'Date when the panelist group is retired or expires; null if open-ended.',
    `effective_start_date` DATE COMMENT 'Date when the panelist group becomes active for research projects.',
    `eligibility_criteria` STRING COMMENT 'Business rules defining which individuals qualify for inclusion in the panelist group.',
    `group_code` STRING COMMENT 'Unique alphanumeric code used to reference the panelist group in external systems.',
    `group_type` STRING COMMENT 'Classification of the panelist group based on participant characteristics.',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Monetary incentive offered per panelist for participation.',
    `last_review_date` DATE COMMENT 'Date of the most recent review of the panelist groups composition and relevance.',
    `panelist_group_name` STRING COMMENT 'Descriptive name of the panelist group.',
    `notes` STRING COMMENT 'Free‑text field for any supplemental information about the panelist group.',
    `panelist_count` STRING COMMENT 'Number of individual panelists assigned to the group.',
    `panelist_source_system` STRING COMMENT 'Name of the operational system that originally sourced the panelist data.',
    `recruitment_method` STRING COMMENT 'Primary method used to recruit panelists into the group.',
    `research_focus` STRING COMMENT 'Primary research domain(s) the panelist group supports.',
    `panelist_group_status` STRING COMMENT 'Current lifecycle status of the panelist group.',
    `target_market` STRING COMMENT 'Geographic market(s) the panelist group is intended to represent.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the panelist group record.',
    CONSTRAINT pk_panelist_group PRIMARY KEY(`panelist_group_id`)
) COMMENT 'Master reference table for panelist_group. Referenced by panelist_group_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_innovation_pipeline_id` FOREIGN KEY (`innovation_pipeline_id`) REFERENCES `food_beverage_ecm`.`research`.`innovation_pipeline`(`innovation_pipeline_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_parent_rd_project_id` FOREIGN KEY (`parent_rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ADD CONSTRAINT `fk_research_innovation_pipeline_parent_innovation_pipeline_id` FOREIGN KEY (`parent_innovation_pipeline_id`) REFERENCES `food_beverage_ecm`.`research`.`innovation_pipeline`(`innovation_pipeline_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ADD CONSTRAINT `fk_research_experimental_formula_formulation_version_id` FOREIGN KEY (`formulation_version_id`) REFERENCES `food_beverage_ecm`.`research`.`formulation_version`(`formulation_version_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ADD CONSTRAINT `fk_research_experimental_formula_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ADD CONSTRAINT `fk_research_experimental_formula_derived_from_experimental_formula_id` FOREIGN KEY (`derived_from_experimental_formula_id`) REFERENCES `food_beverage_ecm`.`research`.`experimental_formula`(`experimental_formula_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ADD CONSTRAINT `fk_research_formulation_version_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `food_beverage_ecm`.`research`.`patent`(`patent_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ADD CONSTRAINT `fk_research_formulation_version_previous_formulation_version_id` FOREIGN KEY (`previous_formulation_version_id`) REFERENCES `food_beverage_ecm`.`research`.`formulation_version`(`formulation_version_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ADD CONSTRAINT `fk_research_rd_sensory_panel_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ADD CONSTRAINT `fk_research_rd_sensory_panel_follow_up_rd_sensory_panel_id` FOREIGN KEY (`follow_up_rd_sensory_panel_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_sensory_panel`(`rd_sensory_panel_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ADD CONSTRAINT `fk_research_sensory_result_formulation_version_id` FOREIGN KEY (`formulation_version_id`) REFERENCES `food_beverage_ecm`.`research`.`formulation_version`(`formulation_version_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ADD CONSTRAINT `fk_research_sensory_result_rd_lab_sample_id` FOREIGN KEY (`rd_lab_sample_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_lab_sample`(`rd_lab_sample_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ADD CONSTRAINT `fk_research_sensory_result_sensory_session_id` FOREIGN KEY (`sensory_session_id`) REFERENCES `food_beverage_ecm`.`research`.`sensory_session`(`sensory_session_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ADD CONSTRAINT `fk_research_sensory_result_replicate_sensory_result_id` FOREIGN KEY (`replicate_sensory_result_id`) REFERENCES `food_beverage_ecm`.`research`.`sensory_result`(`sensory_result_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ADD CONSTRAINT `fk_research_pilot_trial_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ADD CONSTRAINT `fk_research_pilot_trial_previous_pilot_trial_id` FOREIGN KEY (`previous_pilot_trial_id`) REFERENCES `food_beverage_ecm`.`research`.`pilot_trial`(`pilot_trial_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ADD CONSTRAINT `fk_research_trial_observation_pilot_trial_id` FOREIGN KEY (`pilot_trial_id`) REFERENCES `food_beverage_ecm`.`research`.`pilot_trial`(`pilot_trial_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ADD CONSTRAINT `fk_research_trial_observation_related_trial_observation_id` FOREIGN KEY (`related_trial_observation_id`) REFERENCES `food_beverage_ecm`.`research`.`trial_observation`(`trial_observation_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ADD CONSTRAINT `fk_research_patent_continuation_patent_id` FOREIGN KEY (`continuation_patent_id`) REFERENCES `food_beverage_ecm`.`research`.`patent`(`patent_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ADD CONSTRAINT `fk_research_ip_asset_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ADD CONSTRAINT `fk_research_ip_asset_parent_ip_asset_id` FOREIGN KEY (`parent_ip_asset_id`) REFERENCES `food_beverage_ecm`.`research`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ADD CONSTRAINT `fk_research_technology_scout_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ADD CONSTRAINT `fk_research_technology_scout_related_technology_scout_id` FOREIGN KEY (`related_technology_scout_id`) REFERENCES `food_beverage_ecm`.`research`.`technology_scout`(`technology_scout_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ADD CONSTRAINT `fk_research_stage_gate_review_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ADD CONSTRAINT `fk_research_stage_gate_review_recycled_stage_gate_review_id` FOREIGN KEY (`recycled_stage_gate_review_id`) REFERENCES `food_beverage_ecm`.`research`.`stage_gate_review`(`stage_gate_review_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ADD CONSTRAINT `fk_research_concept_innovation_pipeline_id` FOREIGN KEY (`innovation_pipeline_id`) REFERENCES `food_beverage_ecm`.`research`.`innovation_pipeline`(`innovation_pipeline_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ADD CONSTRAINT `fk_research_concept_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ADD CONSTRAINT `fk_research_concept_parent_concept_id` FOREIGN KEY (`parent_concept_id`) REFERENCES `food_beverage_ecm`.`research`.`concept`(`concept_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ADD CONSTRAINT `fk_research_consumer_test_rd_sensory_panel_id` FOREIGN KEY (`rd_sensory_panel_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_sensory_panel`(`rd_sensory_panel_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ADD CONSTRAINT `fk_research_consumer_test_retest_consumer_test_id` FOREIGN KEY (`retest_consumer_test_id`) REFERENCES `food_beverage_ecm`.`research`.`consumer_test`(`consumer_test_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ADD CONSTRAINT `fk_research_rd_lab_sample_lab_id` FOREIGN KEY (`lab_id`) REFERENCES `food_beverage_ecm`.`research`.`lab`(`lab_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ADD CONSTRAINT `fk_research_rd_lab_sample_pilot_trial_id` FOREIGN KEY (`pilot_trial_id`) REFERENCES `food_beverage_ecm`.`research`.`pilot_trial`(`pilot_trial_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ADD CONSTRAINT `fk_research_rd_lab_sample_derived_from_rd_lab_sample_id` FOREIGN KEY (`derived_from_rd_lab_sample_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_lab_sample`(`rd_lab_sample_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ADD CONSTRAINT `fk_research_rd_test_request_rd_lab_sample_id` FOREIGN KEY (`rd_lab_sample_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_lab_sample`(`rd_lab_sample_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ADD CONSTRAINT `fk_research_rd_test_request_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ADD CONSTRAINT `fk_research_rd_test_request_retest_rd_test_request_id` FOREIGN KEY (`retest_rd_test_request_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_test_request`(`rd_test_request_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ADD CONSTRAINT `fk_research_rd_test_result_rd_lab_sample_id` FOREIGN KEY (`rd_lab_sample_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_lab_sample`(`rd_lab_sample_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ADD CONSTRAINT `fk_research_rd_test_result_rd_test_request_id` FOREIGN KEY (`rd_test_request_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_test_request`(`rd_test_request_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ADD CONSTRAINT `fk_research_rd_test_result_retest_rd_test_result_id` FOREIGN KEY (`retest_rd_test_result_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_test_result`(`rd_test_result_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ADD CONSTRAINT `fk_research_competitor_benchmark_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `food_beverage_ecm`.`research`.`concept`(`concept_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ADD CONSTRAINT `fk_research_competitor_benchmark_previous_competitor_benchmark_id` FOREIGN KEY (`previous_competitor_benchmark_id`) REFERENCES `food_beverage_ecm`.`research`.`competitor_benchmark`(`competitor_benchmark_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ADD CONSTRAINT `fk_research_rd_budget_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ADD CONSTRAINT `fk_research_rd_budget_parent_rd_budget_id` FOREIGN KEY (`parent_rd_budget_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_budget`(`rd_budget_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ADD CONSTRAINT `fk_research_external_collaboration_formulation_version_id` FOREIGN KEY (`formulation_version_id`) REFERENCES `food_beverage_ecm`.`research`.`formulation_version`(`formulation_version_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ADD CONSTRAINT `fk_research_external_collaboration_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ADD CONSTRAINT `fk_research_external_collaboration_parent_external_collaboration_id` FOREIGN KEY (`parent_external_collaboration_id`) REFERENCES `food_beverage_ecm`.`research`.`external_collaboration`(`external_collaboration_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ADD CONSTRAINT `fk_research_regulatory_submission_dossier_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ADD CONSTRAINT `fk_research_regulatory_submission_dossier_formulation_version_id` FOREIGN KEY (`formulation_version_id`) REFERENCES `food_beverage_ecm`.`research`.`formulation_version`(`formulation_version_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ADD CONSTRAINT `fk_research_regulatory_submission_dossier_amended_regulatory_submission_dossier_id` FOREIGN KEY (`amended_regulatory_submission_dossier_id`) REFERENCES `food_beverage_ecm`.`research`.`regulatory_submission_dossier`(`regulatory_submission_dossier_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ADD CONSTRAINT `fk_research_ingredient_feasibility_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ADD CONSTRAINT `fk_research_ingredient_feasibility_superseded_ingredient_feasibility_id` FOREIGN KEY (`superseded_ingredient_feasibility_id`) REFERENCES `food_beverage_ecm`.`research`.`ingredient_feasibility`(`ingredient_feasibility_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ADD CONSTRAINT `fk_research_scale_up_plan_formulation_version_id` FOREIGN KEY (`formulation_version_id`) REFERENCES `food_beverage_ecm`.`research`.`formulation_version`(`formulation_version_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ADD CONSTRAINT `fk_research_scale_up_plan_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ADD CONSTRAINT `fk_research_scale_up_plan_superseded_scale_up_plan_id` FOREIGN KEY (`superseded_scale_up_plan_id`) REFERENCES `food_beverage_ecm`.`research`.`scale_up_plan`(`scale_up_plan_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ADD CONSTRAINT `fk_research_rd_milestone_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ADD CONSTRAINT `fk_research_rd_milestone_predecessor_rd_milestone_id` FOREIGN KEY (`predecessor_rd_milestone_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_milestone`(`rd_milestone_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`lab` ADD CONSTRAINT `fk_research_lab_parent_lab_id` FOREIGN KEY (`parent_lab_id`) REFERENCES `food_beverage_ecm`.`research`.`lab`(`lab_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_session` ADD CONSTRAINT `fk_research_sensory_session_panelist_group_id` FOREIGN KEY (`panelist_group_id`) REFERENCES `food_beverage_ecm`.`research`.`panelist_group`(`panelist_group_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_session` ADD CONSTRAINT `fk_research_sensory_session_follow_up_sensory_session_id` FOREIGN KEY (`follow_up_sensory_session_id`) REFERENCES `food_beverage_ecm`.`research`.`sensory_session`(`sensory_session_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`panelist_group` ADD CONSTRAINT `fk_research_panelist_group_parent_panelist_group_id` FOREIGN KEY (`parent_panelist_group_id`) REFERENCES `food_beverage_ecm`.`research`.`panelist_group`(`panelist_group_id`);

-- ========= TAGS =========
ALTER SCHEMA `food_beverage_ecm`.`research` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `food_beverage_ecm`.`research` SET TAGS ('dbx_domain' = 'research');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` SET TAGS ('dbx_subdomain' = 'project_portfolio');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'R&D Project Identifier (RD_PROJECT_ID)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `innovation_pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'Innovation Pipeline Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Sponsor Identifier (SPONSOR_ID)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `rd_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `target_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Target Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `tertiary_rd_sponsor_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `parent_rd_project_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date (ACTUAL_END_DATE)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `actual_spent` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend (ACTUAL_SPENT)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Approved Timestamp (APPROVED_TIMESTAMP)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `budget_allocation` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation (BUDGET_ALLOCATION)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `expected_cogs` SET TAGS ('dbx_business_glossary_term' = 'Expected Cost of Goods Sold (EXPECTED_COGS)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `expected_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected Margin Percent (EXPECTED_MARGIN_PERCENT)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `ip_patent_filed` SET TAGS ('dbx_business_glossary_term' = 'IP Patent Filed (IP_PATENT_FILED)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `ip_patent_number` SET TAGS ('dbx_business_glossary_term' = 'IP Patent Number (IP_PATENT_NUMBER)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LIFECYCLE_STATUS)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|completed|cancelled|archived');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment (MARKET_SEGMENT)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `objectives` SET TAGS ('dbx_business_glossary_term' = 'Project Objectives (OBJECTIVES)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date (PLANNED_END_DATE)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code (PROJECT_CODE)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name (PROJECT_NAME)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type (PROJECT_TYPE)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'new_product|renovation|cost_optimization|technology_scouting');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `rd_project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description (DESCRIPTION)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required (REGULATORY_APPROVAL_REQUIRED)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status (REGULATORY_APPROVAL_STATUS)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RISK_LEVEL)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `risk_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Status (RISK_STATUS)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `risk_status` SET TAGS ('dbx_value_regex' = 'identified|mitigated|escalated|closed');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `stage_gate_phase` SET TAGS ('dbx_business_glossary_term' = 'Stage‑Gate Phase (STAGE_GATE_PHASE)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `stage_gate_phase` SET TAGS ('dbx_value_regex' = 'ideation|concept|feasibility|development|scale_up|launch');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date (START_DATE)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `strategic_goal` SET TAGS ('dbx_business_glossary_term' = 'Strategic Goal (STRATEGIC_GOAL)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `strategic_pillar` SET TAGS ('dbx_business_glossary_term' = 'Strategic Pillar (STRATEGIC_PILLAR)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `target_customer_profile` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Profile (TARGET_CUSTOMER_PROFILE)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `target_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Target Launch Date (TARGET_LAUNCH_DATE)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market (TARGET_MARKET)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `technology_area` SET TAGS ('dbx_business_glossary_term' = 'Technology Area (TECHNOLOGY_AREA)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` SET TAGS ('dbx_subdomain' = 'project_portfolio');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `innovation_pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'Innovation Pipeline ID');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `parent_innovation_pipeline_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend (USD)');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `budget_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount (USD)');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Project End Date');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost (USD)');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `estimated_revenue_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue (USD)');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `health_score` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Health Score');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `health_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `health_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `innovation_horizon` SET TAGS ('dbx_business_glossary_term' = 'Innovation Horizon');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `innovation_horizon` SET TAGS ('dbx_value_regex' = 'H1_core|H2_adjacent|H3_transformational');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `innovation_pipeline_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `innovation_pipeline_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|cancelled|completed');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `market_opportunity` SET TAGS ('dbx_business_glossary_term' = 'Market Opportunity');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `milestone_count` SET TAGS ('dbx_business_glossary_term' = 'Milestone Count');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `next_milestone_date` SET TAGS ('dbx_business_glossary_term' = 'Next Milestone Date');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `patent_filed` SET TAGS ('dbx_business_glossary_term' = 'Patent Filed Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `patent_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Number');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `pipeline_stage` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Stage');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `pipeline_stage` SET TAGS ('dbx_value_regex' = 'idea|concept|feasibility|development|validation|launch');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Project Priority');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `project_lead` SET TAGS ('dbx_business_glossary_term' = 'Project Lead');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'new_product|line_extension|reformulation|process_innovation');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `projected_roi_percent` SET TAGS ('dbx_business_glossary_term' = 'Projected ROI (%)');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `regulatory_impact` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `resource_allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Resource Allocation (%)');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `resource_capacity_hours` SET TAGS ('dbx_business_glossary_term' = 'Resource Capacity (Hours)');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `strategic_category` SET TAGS ('dbx_business_glossary_term' = 'Strategic Category');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `strategic_category` SET TAGS ('dbx_value_regex' = 'snacks|beverages|dairy|packaged_foods');
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` SET TAGS ('dbx_subdomain' = 'formulation_scale');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `experimental_formula_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Formula Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `formulation_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Version Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `derived_from_experimental_formula_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `allergen_statement` SET TAGS ('dbx_business_glossary_term' = 'Allergen Statement');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `batch_size_kg` SET TAGS ('dbx_business_glossary_term' = 'Batch Size (kg)');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate (USD)');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `experimental_formula_description` SET TAGS ('dbx_business_glossary_term' = 'Experimental Formula Description');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `experimental_formula_status` SET TAGS ('dbx_business_glossary_term' = 'Experimental Formula Status');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `experimental_formula_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|completed|withdrawn');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `formula_code` SET TAGS ('dbx_business_glossary_term' = 'Experimental Formula Code');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `formula_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `formula_name` SET TAGS ('dbx_business_glossary_term' = 'Experimental Formula Name');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `formula_type` SET TAGS ('dbx_business_glossary_term' = 'Experimental Formula Type');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `formula_type` SET TAGS ('dbx_value_regex' = 'experimental|pilot|approved|rejected|archived');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `formulation_notes` SET TAGS ('dbx_business_glossary_term' = 'Formulation Notes');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `ingredient_count` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Count');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `intellectual_property_status` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property Status');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `intellectual_property_status` SET TAGS ('dbx_value_regex' = 'none|pending|granted|expired');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `intended_market` SET TAGS ('dbx_business_glossary_term' = 'Intended Market (ISO 3166‑3)');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `intended_market` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `nutritional_info_summary` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Information Summary');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `patent_pending` SET TAGS ('dbx_business_glossary_term' = 'Patent Pending Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `processing_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Processing Temperature (°C)');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `processing_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Processing Time (Minutes)');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|withdrawn');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `risk_assessment_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Level');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `risk_assessment_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `scale_up_feasibility` SET TAGS ('dbx_business_glossary_term' = 'Scale‑Up Feasibility');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `scale_up_feasibility` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `sensory_panel_date` SET TAGS ('dbx_business_glossary_term' = 'Sensory Panel Date');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `sensory_panel_score` SET TAGS ('dbx_business_glossary_term' = 'Sensory Panel Score');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `target_product_category` SET TAGS ('dbx_business_glossary_term' = 'Target Product Category');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `target_product_category` SET TAGS ('dbx_value_regex' = 'snack|beverage|dairy|frozen|convenience');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` SET TAGS ('dbx_subdomain' = 'formulation_scale');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `formulation_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Version ID');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `packaging_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Profile Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent ID');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `previous_formulation_version_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `allergen_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `allergen_flag` SET TAGS ('dbx_value_regex' = 'none|contains|potential');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|under_review');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `batch_size_kg` SET TAGS ('dbx_business_glossary_term' = 'Batch Size (Kilograms)');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `carbon_footprint_kg_co2e` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint (kg CO2e)');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `change_rationale` SET TAGS ('dbx_business_glossary_term' = 'Change Rationale');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `changed_ingredients` SET TAGS ('dbx_business_glossary_term' = 'Changed Ingredients');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `changed_processing_parameters` SET TAGS ('dbx_business_glossary_term' = 'Changed Processing Parameters');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `delta_summary` SET TAGS ('dbx_business_glossary_term' = 'Delta Summary');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `formulation_category` SET TAGS ('dbx_business_glossary_term' = 'Formulation Category');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `formulation_category` SET TAGS ('dbx_value_regex' = 'beverage|snack|dairy|confectionery|meal|sauce');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `formulation_version_status` SET TAGS ('dbx_business_glossary_term' = 'Formulation Version Status');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `formulation_version_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|deprecated|rejected');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `gras_notification_required` SET TAGS ('dbx_business_glossary_term' = 'GRAS Notification Required');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `gras_notification_status` SET TAGS ('dbx_business_glossary_term' = 'GRAS Notification Status');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `gras_notification_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|approved');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `is_approved_for_release` SET TAGS ('dbx_business_glossary_term' = 'Is Approved For Release');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `is_current_version` SET TAGS ('dbx_business_glossary_term' = 'Is Current Version');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `nutritional_profile` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Profile');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `packaging_material` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `packaging_material` SET TAGS ('dbx_value_regex' = 'plastic|glass|paper|metal|biodegradable');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `patent_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Patent Related Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `processing_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Processing Temperature (Celsius)');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `processing_time_min` SET TAGS ('dbx_business_glossary_term' = 'Processing Time (Minutes)');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `regulatory_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Review Notes');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (Celsius)');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Score');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `taste_score` SET TAGS ('dbx_business_glossary_term' = 'Taste Score');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `version_author` SET TAGS ('dbx_business_glossary_term' = 'Version Author');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `version_code` SET TAGS ('dbx_business_glossary_term' = 'Version Code');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `version_comment` SET TAGS ('dbx_business_glossary_term' = 'Version Comment');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `version_name` SET TAGS ('dbx_business_glossary_term' = 'Version Name');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `version_type` SET TAGS ('dbx_business_glossary_term' = 'Version Type');
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ALTER COLUMN `version_type` SET TAGS ('dbx_value_regex' = 'prototype|pilot|final|revision');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` SET TAGS ('dbx_subdomain' = 'sensory_testing');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `rd_sensory_panel_id` SET TAGS ('dbx_business_glossary_term' = 'Sensory Panel ID');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Panel Leader Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'R&D Project ID');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `follow_up_rd_sensory_panel_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `evaluation_protocol` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Protocol');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `facility_location` SET TAGS ('dbx_business_glossary_term' = 'Facility Location');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `formulation_version` SET TAGS ('dbx_business_glossary_term' = 'Formulation Version');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `is_blind` SET TAGS ('dbx_business_glossary_term' = 'Blind Test Indicator');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `is_controlled_environment` SET TAGS ('dbx_business_glossary_term' = 'Controlled Environment Indicator');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Panel Notes');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `overall_outcome` SET TAGS ('dbx_business_glossary_term' = 'Overall Outcome');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `overall_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|inconclusive');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Sensory Score');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `panel_category` SET TAGS ('dbx_business_glossary_term' = 'Panel Category');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `panel_category` SET TAGS ('dbx_value_regex' = 'taste|aroma|texture|appearance|overall_acceptance');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `panel_code` SET TAGS ('dbx_business_glossary_term' = 'Sensory Panel Code');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `panel_date` SET TAGS ('dbx_business_glossary_term' = 'Panel Date');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `panel_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Panel Duration (Minutes)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `panel_leader` SET TAGS ('dbx_business_glossary_term' = 'Panel Leader Name');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `panel_leader` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `panel_leader` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `panel_location_code` SET TAGS ('dbx_business_glossary_term' = 'Panel Location Code');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `panel_name` SET TAGS ('dbx_business_glossary_term' = 'Sensory Panel Name');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `panel_type` SET TAGS ('dbx_business_glossary_term' = 'Sensory Panel Type');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `panel_type` SET TAGS ('dbx_value_regex' = 'trained_descriptive|consumer_hedonic|discrimination|qda');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `panelist_count` SET TAGS ('dbx_business_glossary_term' = 'Panelist Count');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `rd_sensory_panel_status` SET TAGS ('dbx_business_glossary_term' = 'Panel Status');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `rd_sensory_panel_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `sample_preparation_details` SET TAGS ('dbx_business_glossary_term' = 'Sample Preparation Details');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `score_unit` SET TAGS ('dbx_business_glossary_term' = 'Score Unit');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `score_unit` SET TAGS ('dbx_value_regex' = 'points|scale|rating');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `sensory_methodology` SET TAGS ('dbx_business_glossary_term' = 'Sensory Methodology');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `sensory_methodology` SET TAGS ('dbx_value_regex' = 'triangle|duo_trio|ranking|paired_comparison|qda');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` SET TAGS ('dbx_subdomain' = 'sensory_testing');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `sensory_result_id` SET TAGS ('dbx_business_glossary_term' = 'Sensory Result Identifier (SRI)');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Panelist Identifier (PID)');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `formulation_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Version Identifier (FVID)');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `rd_lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identifier (SID)');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `sensory_session_id` SET TAGS ('dbx_business_glossary_term' = 'Sensory Session Identifier (SSID)');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `replicate_sensory_result_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `aftertaste_score` SET TAGS ('dbx_business_glossary_term' = 'Aftertaste Score (ATS)');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `appearance_score` SET TAGS ('dbx_business_glossary_term' = 'Appearance Score (APS)');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `aroma_score` SET TAGS ('dbx_business_glossary_term' = 'Aroma Score (ARS)');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `blind_branded_flag` SET TAGS ('dbx_business_glossary_term' = 'Blind vs Branded Condition (BVC)');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `blind_branded_flag` SET TAGS ('dbx_value_regex' = 'blind|branded');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `comment_text` SET TAGS ('dbx_business_glossary_term' = 'Panelist Comment (PCMT)');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Device Identifier (DEID)');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `evaluation_location` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Location Code (ELC)');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `evaluation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Timestamp (ET)');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `flavor_score` SET TAGS ('dbx_business_glossary_term' = 'Flavor Score (FLS)');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `hedonic_scale_rating` SET TAGS ('dbx_business_glossary_term' = 'Hedonic Scale Rating (HSR)');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Sample Humidity Percentage (SHP)');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes (IN)');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `overall_liking_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Liking Score (OLS)');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `rating_scale_type` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale Type (RST)');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `rating_scale_type` SET TAGS ('dbx_value_regex' = '9-point|7-point|5-point');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `sensory_result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Record Status (RRS)');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `sensory_result_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deleted');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Sample Temperature (°C) (STC)');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ALTER COLUMN `texture_score` SET TAGS ('dbx_business_glossary_term' = 'Texture Score (TXS)');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` SET TAGS ('dbx_subdomain' = 'formulation_scale');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `pilot_trial_id` SET TAGS ('dbx_business_glossary_term' = 'Pilot Trial Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'R&D Project Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `previous_pilot_trial_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost (USD)');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `batch_size` SET TAGS ('dbx_business_glossary_term' = 'Batch Size (kg)');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate (USD)');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|AUD');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `formulation_version` SET TAGS ('dbx_business_glossary_term' = 'Formulation Version');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Trial Notes');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Trial Outcome');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `pilot_trial_status` SET TAGS ('dbx_business_glossary_term' = 'Pilot Trial Status');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `pilot_trial_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `processing_parameters` SET TAGS ('dbx_business_glossary_term' = 'Processing Parameters');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `scale_up_readiness` SET TAGS ('dbx_business_glossary_term' = 'Scale‑Up Readiness Assessment');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `scale_up_readiness` SET TAGS ('dbx_value_regex' = 'not_ready|partial|ready');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `trial_code` SET TAGS ('dbx_business_glossary_term' = 'Pilot Trial Code');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `trial_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Trial Event Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `trial_type` SET TAGS ('dbx_business_glossary_term' = 'Pilot Trial Type');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `trial_type` SET TAGS ('dbx_value_regex' = 'bench|pilot|semi-commercial|plant');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ALTER COLUMN `yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` SET TAGS ('dbx_subdomain' = 'formulation_scale');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `trial_observation_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Observation ID');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Observer ID');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `equipment_master_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `pilot_trial_id` SET TAGS ('dbx_business_glossary_term' = 'Trial ID');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `related_trial_observation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Observation Notes');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `observation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Observation Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `observation_type` SET TAGS ('dbx_business_glossary_term' = 'Observation Type');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `observation_type` SET TAGS ('dbx_value_regex' = 'process_deviation|equipment_issue|quality_defect|yield_loss|safety_concern');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `observer_role` SET TAGS ('dbx_business_glossary_term' = 'Observer Role');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `observer_role` SET TAGS ('dbx_value_regex' = 'technician|engineer|quality_analyst|supervisor');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Process Step');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|info');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `trial_observation_status` SET TAGS ('dbx_business_glossary_term' = 'Observation Status');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `trial_observation_status` SET TAGS ('dbx_value_regex' = 'open|closed|pending_review|resolved');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` SET TAGS ('dbx_subdomain' = 'intellectual_property');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `continuation_patent_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `abstract` SET TAGS ('dbx_business_glossary_term' = 'Patent Abstract');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `annuity_amount` SET TAGS ('dbx_business_glossary_term' = 'Annuity Amount');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `annuity_frequency` SET TAGS ('dbx_business_glossary_term' = 'Annuity Frequency');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `annuity_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `annuity_next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Annuity Due Date');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `assignee_name` SET TAGS ('dbx_business_glossary_term' = 'Assignee Name');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `claims_summary` SET TAGS ('dbx_business_glossary_term' = 'Claims Summary');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `grant_date` SET TAGS ('dbx_business_glossary_term' = 'Grant Date');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `inventor_names` SET TAGS ('dbx_business_glossary_term' = 'Inventor Names');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `inventor_names` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `inventor_names` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `is_patent_family` SET TAGS ('dbx_business_glossary_term' = 'Is Patent Family');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `legal_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Status');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `legal_status` SET TAGS ('dbx_value_regex' = 'pending|granted|rejected|withdrawn|lapsed');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `licensing_status` SET TAGS ('dbx_business_glossary_term' = 'Licensing Status');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `licensing_status` SET TAGS ('dbx_value_regex' = 'licensed|unlicensed|in_negotiation|expired');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `maintenance_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Fee Amount');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `maintenance_fee_due_date` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Fee Due Date');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `patent_family_code` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `patent_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Number');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `patent_status` SET TAGS ('dbx_business_glossary_term' = 'Patent Status');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `patent_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|pending');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `patent_type` SET TAGS ('dbx_business_glossary_term' = 'Patent Type');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `patent_type` SET TAGS ('dbx_value_regex' = 'utility|design|plant|provisional');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `priority_country` SET TAGS ('dbx_business_glossary_term' = 'Priority Country');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `priority_date` SET TAGS ('dbx_business_glossary_term' = 'Priority Date');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `rnd_project_code` SET TAGS ('dbx_business_glossary_term' = 'R&D Project Code');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `technology_domain` SET TAGS ('dbx_business_glossary_term' = 'Technology Domain');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Patent Title');
ALTER TABLE `food_beverage_ecm`.`research`.`patent` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` SET TAGS ('dbx_subdomain' = 'intellectual_property');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property Asset Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `parent_ip_asset_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property Asset Type');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_value_regex' = 'patent|trade_secret|know_how|trademark|copyright');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `commercialization_status` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Commercialization Status');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `commercialization_status` SET TAGS ('dbx_value_regex' = 'not_commercialized|in_development|launched|discontinued');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Compliance Review Date');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Compliance Status');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Confidentiality Classification');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `conflict_description` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Conflict Description');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `conflict_flag` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Conflict Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `disclosure_level` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Disclosure Level');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `disclosure_level` SET TAGS ('dbx_value_regex' = 'public|confidential|restricted');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Document Reference');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property Asset Effective Date');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property Asset Expiration Date');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `filing_cost` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Filing Cost');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `ip_asset_description` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property Asset Description');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `ip_asset_name` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property Asset Name');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `ip_asset_status` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property Asset Status');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `ip_asset_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|withdrawn|licensed|unlicensed');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `ip_audit_created` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Audit Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `ip_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Audit Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `ip_manager` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Manager');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `ip_manager` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `ip_manager` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `ip_value_estimate` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Value Estimate');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Jurisdiction');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `legal_counsel` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Legal Counsel');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `legal_counsel` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `legal_counsel` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `legal_status` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Legal Status');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `legal_status` SET TAGS ('dbx_value_regex' = 'pending|granted|rejected|expired');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `licensee` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Licensee');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `licensing_end_date` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Licensing End Date');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `licensing_start_date` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Licensing Start Date');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `licensing_status` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Licensing Status');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `licensing_status` SET TAGS ('dbx_value_regex' = 'licensed|unlicensed|in_negotiation');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `maintenance_cost` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Maintenance Cost');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Maintenance Due Date');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Owner Department');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `protection_strategy` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Protection Strategy');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `protection_strategy` SET TAGS ('dbx_value_regex' = 'defensive|offensive|open|collaborative');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Publication Date');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `publication_status` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Publication Status');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `publication_status` SET TAGS ('dbx_value_regex' = 'published|unpublished|pending');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Renewal Date');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Renewal Status');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'pending|completed|overdue');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Risk Assessment');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Risk Score');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Royalty Amount');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `royalty_currency` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Royalty Currency');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `royalty_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Royalty Rate');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Source System');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Veeva Vault|TraceGains|SAP|Oracle|Other');
ALTER TABLE `food_beverage_ecm`.`research`.`ip_asset` ALTER COLUMN `creation_date` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property Asset Creation Date');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` SET TAGS ('dbx_subdomain' = 'intellectual_property');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `technology_scout_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Scout Record Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `related_technology_scout_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `analyst_name` SET TAGS ('dbx_business_glossary_term' = 'Scouting Analyst Name');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `department_responsible` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_value_regex' = 'identified|assessed|shortlisted|rejected|in_licensing');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `expected_implementation_timeline_months` SET TAGS ('dbx_business_glossary_term' = 'Implementation Timeline (Months)');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Technology Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `external_reference_url` SET TAGS ('dbx_business_glossary_term' = 'External Reference URL');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `intellectual_property_status` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property Status');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `intellectual_property_status` SET TAGS ('dbx_value_regex' = 'patented|pending|none');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `last_updated` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `market_opportunity_score` SET TAGS ('dbx_business_glossary_term' = 'Market Opportunity Score');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `next_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Next Action');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `next_action` SET TAGS ('dbx_value_regex' = 'pilot|partner|monitor|discard');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Analyst Notes');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `potential_impact` SET TAGS ('dbx_business_glossary_term' = 'Potential Business Impact');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `regulatory_implications` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Implications');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `regulatory_implications` SET TAGS ('dbx_value_regex' = 'none|FDA|USDA|EU|GFSI');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `related_product_codes` SET TAGS ('dbx_business_glossary_term' = 'Related Product Codes');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `relevance_score` SET TAGS ('dbx_business_glossary_term' = 'Relevance Score');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `scouting_date` SET TAGS ('dbx_business_glossary_term' = 'Scouting Date');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `source_name` SET TAGS ('dbx_business_glossary_term' = 'Technology Source Name');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Source Type');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'startup|university|supplier|competitor|conference');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `stakeholder_contact` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Contact');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `technology_readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Technology Readiness Level (TRL)');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `technology_scout_description` SET TAGS ('dbx_business_glossary_term' = 'Technology Description');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `technology_scout_name` SET TAGS ('dbx_business_glossary_term' = 'Technology Name');
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` SET TAGS ('dbx_subdomain' = 'project_portfolio');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `stage_gate_review_id` SET TAGS ('dbx_business_glossary_term' = 'Stage Gate Review Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'R&D Project Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `recycled_stage_gate_review_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `commercial_viability_score` SET TAGS ('dbx_business_glossary_term' = 'Commercial Viability Score');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `committee_members` SET TAGS ('dbx_business_glossary_term' = 'Review Committee Members');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `conditions_attached` SET TAGS ('dbx_business_glossary_term' = 'Conditional Go Conditions');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `decision` SET TAGS ('dbx_business_glossary_term' = 'Gate Decision');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `decision` SET TAGS ('dbx_value_regex' = 'go|kill|hold|recycle');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `documentation_link` SET TAGS ('dbx_business_glossary_term' = 'Review Documentation URL');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `expected_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Launch Date');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `financial_return_score` SET TAGS ('dbx_business_glossary_term' = 'Financial Return Score');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `gate_number` SET TAGS ('dbx_business_glossary_term' = 'Gate Number');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `is_conditional_go` SET TAGS ('dbx_business_glossary_term' = 'Conditional Go Indicator');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Review Notes');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `overall_gate_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Gate Score');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `projected_roi` SET TAGS ('dbx_business_glossary_term' = 'Projected Return on Investment');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `regulatory_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Score');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `review_location` SET TAGS ('dbx_business_glossary_term' = 'Review Location');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `review_method` SET TAGS ('dbx_business_glossary_term' = 'Review Method');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `review_method` SET TAGS ('dbx_value_regex' = 'in_person|virtual|hybrid');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Stage Gate Review Number');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `review_number` SET TAGS ('dbx_value_regex' = '^RG-d{4}-d{3}$');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `stage_gate_review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `stage_gate_review_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|completed|on_hold');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `technical_feasibility_score` SET TAGS ('dbx_business_glossary_term' = 'Technical Feasibility Score');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` SET TAGS ('dbx_subdomain' = 'project_portfolio');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `innovation_pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'Innovation Pipeline Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `owner_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Owner User Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `owner_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `owner_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `parent_concept_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `benefit_proposition` SET TAGS ('dbx_business_glossary_term' = 'Benefit Proposition');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `concept_category` SET TAGS ('dbx_business_glossary_term' = 'Concept Category');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `concept_description` SET TAGS ('dbx_business_glossary_term' = 'Concept Description');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `concept_name` SET TAGS ('dbx_business_glossary_term' = 'Concept Name');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `concept_source` SET TAGS ('dbx_business_glossary_term' = 'Concept Source');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `concept_source` SET TAGS ('dbx_value_regex' = 'internal|external|partner');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `concept_status` SET TAGS ('dbx_business_glossary_term' = 'Concept Status');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `concept_status` SET TAGS ('dbx_value_regex' = 'active|advanced|parked|killed');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `consumer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Consumer Segment');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `flavor_hypothesis` SET TAGS ('dbx_business_glossary_term' = 'Flavor Hypothesis');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `format_hypothesis` SET TAGS ('dbx_business_glossary_term' = 'Format Hypothesis');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `intellectual_property_filed` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property Filed Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Concept Last Test Date');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `launch_window_estimate` SET TAGS ('dbx_business_glossary_term' = 'Launch Window Estimate');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `market_trend_alignment_score` SET TAGS ('dbx_business_glossary_term' = 'Market Trend Alignment Score');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `origin_date` SET TAGS ('dbx_business_glossary_term' = 'Concept Origin Date');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `owner_role` SET TAGS ('dbx_business_glossary_term' = 'Concept Owner Role');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `pack_size_hypothesis` SET TAGS ('dbx_business_glossary_term' = 'Pack Size Hypothesis');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `packaging_material` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `patent_status` SET TAGS ('dbx_business_glossary_term' = 'Patent Status');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `patent_status` SET TAGS ('dbx_value_regex' = 'none|filed|granted|expired');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Concept Priority');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `projected_cogs` SET TAGS ('dbx_business_glossary_term' = 'Projected Cost of Goods Sold (COGS)');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `projected_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Projected Margin Percentage');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `projected_revenue` SET TAGS ('dbx_business_glossary_term' = 'Projected Revenue');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `projected_sales_volume` SET TAGS ('dbx_business_glossary_term' = 'Projected Sales Volume');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `projected_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Projected Shelf Life (Days)');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `purchase_intent_rating` SET TAGS ('dbx_business_glossary_term' = 'Purchase Intent Rating');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Concept Risk Score');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Score');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `test_comments` SET TAGS ('dbx_business_glossary_term' = 'Concept Test Comments');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Concept Test Method');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `test_method` SET TAGS ('dbx_value_regex' = 'clt|online|focus_group');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `test_sample_size` SET TAGS ('dbx_business_glossary_term' = 'Concept Test Sample Size');
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ALTER COLUMN `test_score` SET TAGS ('dbx_business_glossary_term' = 'Concept Test Score');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` SET TAGS ('dbx_subdomain' = 'sensory_testing');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `consumer_test_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Test ID');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `rd_sensory_panel_id` SET TAGS ('dbx_business_glossary_term' = 'Panel ID');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `retest_consumer_test_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `concept_version` SET TAGS ('dbx_business_glossary_term' = 'Concept Version');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `consumer_test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `consumer_test_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|analyzed|closed');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Test End Date');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `geography` SET TAGS ('dbx_business_glossary_term' = 'Geography');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `key_driver_attributes` SET TAGS ('dbx_business_glossary_term' = 'Key Driver Attributes');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `overall_liking_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Liking Score');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `purchase_intent_score` SET TAGS ('dbx_business_glossary_term' = 'Purchase Intent Score');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `recommendation` SET TAGS ('dbx_business_glossary_term' = 'Test Recommendation');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `recommendation` SET TAGS ('dbx_value_regex' = 'launch|revise|cancel|further_testing');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `recruitment_criteria` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Criteria');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Test Start Date');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `test_category` SET TAGS ('dbx_business_glossary_term' = 'Test Category');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `test_category` SET TAGS ('dbx_value_regex' = 'sensory|concept|product|packaging|label');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `test_code` SET TAGS ('dbx_business_glossary_term' = 'Consumer Test Code (CTC)');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `test_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Test Duration (Days)');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `test_market` SET TAGS ('dbx_business_glossary_term' = 'Test Market (ISO 3166-1 Alpha-3)');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `test_market` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `test_method` SET TAGS ('dbx_value_regex' = 'blind|double_blind|open');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `test_protocol` SET TAGS ('dbx_business_glossary_term' = 'Test Protocol');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Consumer Test Type (CTT)');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'in_home|central_location|online');
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` SET TAGS ('dbx_subdomain' = 'formulation_scale');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `rd_lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Research & Development Lab Sample ID');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `lab_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory ID');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `pilot_trial_id` SET TAGS ('dbx_business_glossary_term' = 'Pilot Trial ID');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `derived_from_rd_lab_sample_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `abv_percent` SET TAGS ('dbx_business_glossary_term' = 'Alcohol By Volume (ABV) Percentage');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `allergen_info` SET TAGS ('dbx_business_glossary_term' = 'Allergen Information');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `brix_percent` SET TAGS ('dbx_business_glossary_term' = 'Brix Percentage');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `chain_of_custody` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Date');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Disposal Date');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Sample Disposal Method');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'incineration|landfill|recycling|return_to_supplier|other');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Expiry Date');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `formulation_version` SET TAGS ('dbx_business_glossary_term' = 'Formulation Version');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `hazard_status` SET TAGS ('dbx_business_glossary_term' = 'Hazard Status');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `hazard_status` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|critical');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `microbial_count_cfu` SET TAGS ('dbx_business_glossary_term' = 'Microbial Count (CFU)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Sample Notes');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `ph` SET TAGS ('dbx_business_glossary_term' = 'pH Value');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `quality_flag` SET TAGS ('dbx_value_regex' = 'pass|fail|pending|retest');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Sample Quantity');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `rd_lab_sample_status` SET TAGS ('dbx_business_glossary_term' = 'Lab Sample Status');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `rd_lab_sample_status` SET TAGS ('dbx_value_regex' = 'available|in_use|disposed|quarantined|expired');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|not_required');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `sample_code` SET TAGS ('dbx_business_glossary_term' = 'Lab Sample Code');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `sample_name` SET TAGS ('dbx_business_glossary_term' = 'Lab Sample Name');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Lab Sample Type');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'raw_material|intermediate|prototype|competitor_benchmark|reference_standard');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `storage_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Storage Humidity (%)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Sample Storage Location');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (°C)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'g|kg|ml|l|units');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` SET TAGS ('dbx_subdomain' = 'formulation_scale');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `rd_test_request_id` SET TAGS ('dbx_business_glossary_term' = 'Research & Development Test Request ID');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Scientist ID');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `rd_lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'R&D Project ID');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `retest_rd_test_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Completion Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `estimated_turnaround_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Turnaround Time (Hours)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `formulation_version` SET TAGS ('dbx_business_glossary_term' = 'Formulation Version');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `lab_location` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Location');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Request Notes');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Test Request Priority');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `rd_test_request_status` SET TAGS ('dbx_business_glossary_term' = 'Test Request Status');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `rd_test_request_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|in_review|approved|rejected|completed');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `regulatory_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Required');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Test Request Number');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Request Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `required_turnaround_hours` SET TAGS ('dbx_business_glossary_term' = 'Required Turnaround Time (Hours)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `result_available_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Result Availability Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `sample_quantity` SET TAGS ('dbx_business_glossary_term' = 'Sample Quantity');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `test_method` SET TAGS ('dbx_value_regex' = 'hplc|gc_ms|texture|viscosity|ph|water_activity');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` SET TAGS ('dbx_subdomain' = 'formulation_scale');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `rd_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'R&D Test Result ID');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `calibration_order_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration ID');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `rd_lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `rd_test_request_id` SET TAGS ('dbx_business_glossary_term' = 'R&D Test Request ID');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `retest_rd_test_result_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `analyst_comments` SET TAGS ('dbx_business_glossary_term' = 'Analyst Comments');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|not_approved|pending');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `detection_limit` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `formulation_version` SET TAGS ('dbx_business_glossary_term' = 'Formulation Version');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `instrument_code` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `lab_location_code` SET TAGS ('dbx_business_glossary_term' = 'Lab Location Code');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `measurement_repeat_flag` SET TAGS ('dbx_business_glossary_term' = 'Measurement Repeat Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'chemical|microbial|physical|sensory');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `measurement_uncertainty` SET TAGS ('dbx_business_glossary_term' = 'Measurement Uncertainty');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `oos_flag` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Specification Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `pass_fail_flag` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `pass_fail_flag` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `quality_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `rd_test_result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `rd_test_result_status` SET TAGS ('dbx_value_regex' = 'pending|completed|reviewed|rejected');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `result_date` SET TAGS ('dbx_business_glossary_term' = 'Result Date');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `result_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Result Quality Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `result_quality_flag` SET TAGS ('dbx_value_regex' = 'acceptable|questionable|invalid');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `result_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Result Reviewed By');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `result_sequence` SET TAGS ('dbx_business_glossary_term' = 'Result Sequence');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `result_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Result Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `specification_limit_high` SET TAGS ('dbx_business_glossary_term' = 'Specification Limit High');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `specification_limit_low` SET TAGS ('dbx_business_glossary_term' = 'Specification Limit Low');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method (e.g., High Performance Liquid Chromatography)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `test_method` SET TAGS ('dbx_value_regex' = 'HPLC|GC-MS|LC-MS|ELISA|PCR|NIR');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `test_result_category` SET TAGS ('dbx_business_glossary_term' = 'Test Result Category');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `test_result_category` SET TAGS ('dbx_value_regex' = 'stability|purity|potency|microbial|sensory');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `test_result_source` SET TAGS ('dbx_business_glossary_term' = 'Test Result Source');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `test_result_source` SET TAGS ('dbx_value_regex' = 'lab|field|external');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` SET TAGS ('dbx_subdomain' = 'sensory_testing');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `competitor_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Competitor Benchmark ID');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `previous_competitor_benchmark_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `allergen_info` SET TAGS ('dbx_business_glossary_term' = 'Allergen Information');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `benchmark_code` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Code');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `benchmark_date` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Evaluation Date');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `competitor_benchmark_status` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Record Status');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `competitor_benchmark_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `competitor_brand` SET TAGS ('dbx_business_glossary_term' = 'Competitor Brand Name');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `competitor_product_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Product Name');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `evaluation_method` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Method');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `evaluation_method` SET TAGS ('dbx_value_regex' = 'In-house|Third-party|Consumer|Lab');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `ingredient_list` SET TAGS ('dbx_business_glossary_term' = 'Ingredient List');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `label_claims` SET TAGS ('dbx_business_glossary_term' = 'Label Claims');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `market_region` SET TAGS ('dbx_business_glossary_term' = 'Market Region (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `market_region` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX|GBR|FRA|DEU');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `nutrient_claims` SET TAGS ('dbx_business_glossary_term' = 'Nutrient Claims');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `nutritional_calories_kcal` SET TAGS ('dbx_business_glossary_term' = 'Calories (kcal)');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `nutritional_carbohydrate_g` SET TAGS ('dbx_business_glossary_term' = 'Total Carbohydrate (g)');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `nutritional_fat_g` SET TAGS ('dbx_business_glossary_term' = 'Total Fat (g)');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `nutritional_protein_g` SET TAGS ('dbx_business_glossary_term' = 'Protein (g)');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `nutritional_saturated_fat_g` SET TAGS ('dbx_business_glossary_term' = 'Saturated Fat (g)');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `nutritional_sodium_mg` SET TAGS ('dbx_business_glossary_term' = 'Sodium (mg)');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `nutritional_sugar_g` SET TAGS ('dbx_business_glossary_term' = 'Total Sugar (g)');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `packaging_format` SET TAGS ('dbx_business_glossary_term' = 'Packaging Format');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `packaging_material` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Currency (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `price_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|CNY');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `product_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Product Subcategory');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `purchase_market` SET TAGS ('dbx_business_glossary_term' = 'Purchase Market Channel');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `purchase_market` SET TAGS ('dbx_value_regex' = 'Retail|Foodservice|Online|Convenience|Club|Restaurant');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `retail_price` SET TAGS ('dbx_business_glossary_term' = 'Retail Price');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `sensory_aftertaste_score` SET TAGS ('dbx_business_glossary_term' = 'Sensory Aftertaste Score');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `sensory_appearance_score` SET TAGS ('dbx_business_glossary_term' = 'Sensory Appearance Score');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `sensory_aroma_score` SET TAGS ('dbx_business_glossary_term' = 'Sensory Aroma Score');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `sensory_flavor_score` SET TAGS ('dbx_business_glossary_term' = 'Sensory Flavor Score');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `sensory_overall_liking_score` SET TAGS ('dbx_business_glossary_term' = 'Sensory Overall Liking Score');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `sensory_texture_score` SET TAGS ('dbx_business_glossary_term' = 'Sensory Texture Score');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Recommended Storage Temperature (°C)');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `strategic_implications` SET TAGS ('dbx_business_glossary_term' = 'Strategic Implications');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ALTER COLUMN `volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Product Volume (mL)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` SET TAGS ('dbx_subdomain' = 'project_portfolio');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `rd_budget_id` SET TAGS ('dbx_business_glossary_term' = 'R&D Budget Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approval User Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'R&D Project Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `parent_rd_budget_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code (BUDGET_CODE)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `budget_external_testing_amount` SET TAGS ('dbx_business_glossary_term' = 'External Testing Budget Amount (EXTERNAL_TESTING_BUDGET)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `budget_licensing_amount` SET TAGS ('dbx_business_glossary_term' = 'Licensing Budget Amount (LICENSING_BUDGET)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `budget_materials_amount` SET TAGS ('dbx_business_glossary_term' = 'Materials Budget Amount (MATERIALS_BUDGET)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `budget_owner` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner (OWNER)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `budget_owner` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `budget_owner` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `budget_personnel_amount` SET TAGS ('dbx_business_glossary_term' = 'Personnel Budget Amount (PERSONNEL_BUDGET)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `budget_pilot_plant_amount` SET TAGS ('dbx_business_glossary_term' = 'Pilot Plant Budget Amount (PILOT_PLANT_BUDGET)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status (STATUS)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|closed|cancelled');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type (TYPE)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'operational|capital|research');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (COST_CENTER)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = 'CC[0-9]{4}');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code (DEPT_CODE)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective End Date');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `rd_budget_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Description');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (REGION)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `total_actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Actual Spend (ACTUAL_SPEND)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Amount (TOTAL_BUDGET)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `total_committed_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Spend (COMMITTED_SPEND)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `total_forecast_to_complete` SET TAGS ('dbx_business_glossary_term' = 'Forecast To Complete (FORECAST_TTC)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `total_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Variance Amount (VARIANCE)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` SET TAGS ('dbx_subdomain' = 'project_portfolio');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `external_collaboration_id` SET TAGS ('dbx_business_glossary_term' = 'External Collaboration Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `formulation_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Version Identifier (FORM_VER_ID)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'R&D Project Identifier (PROJECT_ID)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `parent_external_collaboration_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVED_TS)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `collaboration_code` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Code (COLL_CODE)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `collaboration_name` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Name (COLL_NAME)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `collaboration_scope` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Scope (COLL_SCOPE)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `collaboration_status` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Status (COLL_STATUS)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `collaboration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|completed|terminated|pending');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `collaboration_type` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Type (COLL_TYPE)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level (CONF_LEVEL)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|public');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `contract_document_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Identifier (DOC_ID)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CODE)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `deliverables` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Deliverables (DELIVERABLES)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Collaboration End Date (END_DATE)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Funding Amount (FUND_AMT)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source (FUND_SRC)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `ip_ownership_terms` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property Ownership Terms (IP_TERMS)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `location_city` SET TAGS ('dbx_business_glossary_term' = 'Partner City (CITY)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `location_country` SET TAGS ('dbx_business_glossary_term' = 'Partner Country (COUNTRY)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `location_country` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `milestones` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Milestones (MILESTONES)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'General Notes (NOTES)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Email (PARTNER_EMAIL)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `partner_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Phone (PARTNER_PHONE)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `partner_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `partner_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `partner_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Name (PARTNER_NAME)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Type (PARTNER_TYPE)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `partner_type` SET TAGS ('dbx_value_regex' = 'university|startup|cro|supplier|industry_consortium');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag (REG_COMPLY)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option (RENEW_OPT)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `renewal_option` SET TAGS ('dbx_value_regex' = 'yes|no');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `risk_assessment_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Level (RISK_LEVEL)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `risk_assessment_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Start Date (START_DATE)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `status_change_date` SET TAGS ('dbx_business_glossary_term' = 'Status Change Date (STATUS_CHANGE_DATE)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Score (SUST_SCORE)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason (TERM_REASON)');
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` SET TAGS ('dbx_subdomain' = 'intellectual_property');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `regulatory_submission_dossier_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Dossier ID');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'R&D Project ID');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `formulation_version_id` SET TAGS ('dbx_business_glossary_term' = 'Target Formulation Version ID');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `amended_regulatory_submission_dossier_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Name');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `agency_name` SET TAGS ('dbx_value_regex' = 'FDA|USDA|EFSA|GFSI|ISO_22000|FSSAI');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `agency_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Agency Reference Number');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `approval_outcome` SET TAGS ('dbx_business_glossary_term' = 'Approval Outcome');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `approval_outcome` SET TAGS ('dbx_value_regex' = 'approved|conditionally_approved|rejected|withdrawn');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `confidentiality_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|CAD|GBP|JPY|CNY');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `docket_url` SET TAGS ('dbx_business_glossary_term' = 'Docket URL (Link to Submission Dossier)');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `dossier_number` SET TAGS ('dbx_business_glossary_term' = 'Dossier Number (Agency Assigned Identifier)');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `dossier_title` SET TAGS ('dbx_business_glossary_term' = 'Dossier Title (Descriptive Name)');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `expected_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Decision Date');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Dossier Expiration Date');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `formulation_version` SET TAGS ('dbx_business_glossary_term' = 'Formulation Version Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `ingredient_list` SET TAGS ('dbx_business_glossary_term' = 'Ingredient List (Identifiers)');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction (Country or Region Code)');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = 'USA|EU|CAN|AUS|JPN|CHN');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `regulatory_agency_contact` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Contact Information');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `regulatory_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Review Notes');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `regulatory_submission_dossier_status` SET TAGS ('dbx_business_glossary_term' = 'Dossier Lifecycle Status');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `regulatory_submission_dossier_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|withdrawn');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|completed');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `risk_assessment_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Level');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `risk_assessment_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `scientific_evidence_summary` SET TAGS ('dbx_business_glossary_term' = 'Scientific Evidence Summary');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `submission_category` SET TAGS ('dbx_business_glossary_term' = 'Submission Category (Pre-Market or Post-Market)');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `submission_category` SET TAGS ('dbx_value_regex' = 'pre_market|post_market');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `submission_channel` SET TAGS ('dbx_business_glossary_term' = 'Submission Channel (ePortal, Email, Mail)');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `submission_channel` SET TAGS ('dbx_value_regex' = 'ePortal|email|mail');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `submission_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Submission Fee Amount');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method (Electronic or Paper)');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic|paper');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `submission_priority` SET TAGS ('dbx_business_glossary_term' = 'Submission Priority');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `submission_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `submission_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Submission Record');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type (GRAS, Novel Food, Health Claim, Food Additive Petition)');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'GRAS|novel_food|health_claim|food_additive');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `supporting_documents_count` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documents Count');
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` SET TAGS ('dbx_subdomain' = 'formulation_scale');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `ingredient_feasibility_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Feasibility Assessment ID');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'R&D Project ID');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `superseded_ingredient_feasibility_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `allergen_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `assessment_code` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Feasibility Assessment Code');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|completed|archived');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `brix_value` SET TAGS ('dbx_business_glossary_term' = 'Brix Value');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `cfus_per_gram` SET TAGS ('dbx_business_glossary_term' = 'Colony Forming Units per Gram (CFU/g)');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `cost_per_unit_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit (USD)');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `feasibility_cost_score` SET TAGS ('dbx_business_glossary_term' = 'Cost Score (CS)');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `feasibility_regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `feasibility_regulatory_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|not_applicable');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `feasibility_supply_availability_score` SET TAGS ('dbx_business_glossary_term' = 'Supply Availability Score (SA)');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `feasibility_sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Score (SS)');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `feasibility_technical_functionality_score` SET TAGS ('dbx_business_glossary_term' = 'Technical Functionality Score (TF)');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `functional_properties` SET TAGS ('dbx_business_glossary_term' = 'Functional Properties Description');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `gluten_free` SET TAGS ('dbx_business_glossary_term' = 'Gluten‑Free Indicator');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `halal_certified` SET TAGS ('dbx_business_glossary_term' = 'Halal Certification Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `ingredient_name` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Name');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `ingredient_origin_country` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Origin Country');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `ingredient_origin_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `ingredient_type` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Type');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `ingredient_type` SET TAGS ('dbx_value_regex' = 'novel_protein|functional_fiber|natural_color|flavor|bioactive');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `kosher_certified` SET TAGS ('dbx_business_glossary_term' = 'Kosher Certification Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `non_gmo` SET TAGS ('dbx_business_glossary_term' = 'Non‑GMO Indicator');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `organic_certified` SET TAGS ('dbx_business_glossary_term' = 'Organic Certification Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `overall_feasibility_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Feasibility Score');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `ph_value` SET TAGS ('dbx_business_glossary_term' = 'pH Value');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `recommendation` SET TAGS ('dbx_business_glossary_term' = 'Feasibility Recommendation');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `recommendation` SET TAGS ('dbx_value_regex' = 'approve|conditional_approve|reject|further_study');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `regulatory_comments` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Comments');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (°C)');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `supply_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Supply Lead Time (Days)');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `sustainability_metric` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Metric');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `sustainability_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Metric Value');
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` SET TAGS ('dbx_subdomain' = 'formulation_scale');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `scale_up_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Scale-Up Plan ID');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `formulation_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Version ID');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Signoff User ID');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'R&D Project ID');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Target Manufacturing Plant ID');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Target Production Line ID');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `tertiary_scale_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `tertiary_scale_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `tertiary_scale_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `superseded_scale_up_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Incurred (USD)');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Scale-Up Plan Budget (USD)');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective End Date');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `equipment_qualification_requirements` SET TAGS ('dbx_business_glossary_term' = 'Equipment Qualification Requirements');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `milestone_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Scale-Up Milestones');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `next_milestone_date` SET TAGS ('dbx_business_glossary_term' = 'Next Milestone Date');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Scale-Up Plan Code');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Scale-Up Plan Name');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Scale-Up Plan Type (TYPE)');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'pilot_to_commercial|line_scale_up|facility_expansion');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `process_parameter_transfer_specifications` SET TAGS ('dbx_business_glossary_term' = 'Process Parameter Transfer Specifications');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status (REG_APPROVAL_STATUS)');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `risk_assessment_details` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Details');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `risk_assessment_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Level (RISK_LEVEL)');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `risk_assessment_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `scale_up_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Scale-Up Plan Status (STATUS)');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `scale_up_plan_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|on_hold|cancelled');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `scale_up_readiness_signoff` SET TAGS ('dbx_business_glossary_term' = 'Scale-Up Readiness Signoff (BOOLEAN)');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `signoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signoff Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `trial_batch_schedule` SET TAGS ('dbx_business_glossary_term' = 'Trial Batch Schedule');
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` SET TAGS ('dbx_subdomain' = 'project_portfolio');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `rd_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'R&D Milestone Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Owner Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'R&D Project Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `predecessor_rd_milestone_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Completion Date');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `actual_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Duration (Days)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Approval Status');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Milestone Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Milestone Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `cost_actual_usd` SET TAGS ('dbx_business_glossary_term' = 'Milestone Actual Cost (USD)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `cost_target_usd` SET TAGS ('dbx_business_glossary_term' = 'Milestone Cost Target (USD)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Milestone Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Milestone Currency Code');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `delay_days` SET TAGS ('dbx_business_glossary_term' = 'Milestone Delay Days');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `delay_reason` SET TAGS ('dbx_business_glossary_term' = 'Milestone Delay Reason');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `expected_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Expected Milestone Duration (Days)');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `gate_decision` SET TAGS ('dbx_business_glossary_term' = 'Gate Decision Outcome');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `gate_decision` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|deferred');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Milestone Indicator');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `is_gate_milestone` SET TAGS ('dbx_business_glossary_term' = 'Gate Milestone Indicator');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Milestone Code');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `milestone_sequence` SET TAGS ('dbx_business_glossary_term' = 'Milestone Sequence Number');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'formulation_freeze|sensory_approval|pilot_trial_completion|regulatory_clearance|cost_target_confirmation|launch_readiness');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Milestone Notes');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Milestone Owner Department');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `owner_role` SET TAGS ('dbx_business_glossary_term' = 'Milestone Owner Role');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Milestone Date');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Milestone Priority');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `rd_milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `rd_milestone_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|delayed|cancelled');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `regulatory_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Clearance Status');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `regulatory_clearance_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|cleared|rejected');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Milestone Risk Level');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Milestone Record Updated By');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Milestone Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Milestone Record Created By');
ALTER TABLE `food_beverage_ecm`.`research`.`lab` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`research`.`lab` SET TAGS ('dbx_subdomain' = 'formulation_scale');
ALTER TABLE `food_beverage_ecm`.`research`.`lab` ALTER COLUMN `lab_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`lab` ALTER COLUMN `parent_lab_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`lab` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`lab` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`lab` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`lab` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`lab` ALTER COLUMN `budget_annual_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`lab` ALTER COLUMN `budget_annual_usd` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`lab` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`lab` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`lab` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`lab` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`lab` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`lab` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`lab` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`lab` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`lab` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`lab` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`lab` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`lab` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`lab` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`lab` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_session` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_session` SET TAGS ('dbx_subdomain' = 'sensory_testing');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_session` ALTER COLUMN `sensory_session_id` SET TAGS ('dbx_business_glossary_term' = 'Sensory Session Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_session` ALTER COLUMN `follow_up_sensory_session_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`research`.`panelist_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`research`.`panelist_group` SET TAGS ('dbx_subdomain' = 'sensory_testing');
ALTER TABLE `food_beverage_ecm`.`research`.`panelist_group` ALTER COLUMN `panelist_group_id` SET TAGS ('dbx_business_glossary_term' = 'Panelist Group Identifier');
ALTER TABLE `food_beverage_ecm`.`research`.`panelist_group` ALTER COLUMN `parent_panelist_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
