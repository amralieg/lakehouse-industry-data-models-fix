-- Schema for Domain: analytics | Business: Advertising | Version: v1_ecm
-- Generated on: 2026-05-08 02:28:03

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `advertising_ecm`.`analytics` COMMENT 'Owns marketing analytics models, dashboards, reports, data science experiments, attribution studies, media mix models (MMM), and insight deliverables produced for clients. Manages the analytical output layer distinct from raw performance data.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `advertising_ecm`.`analytics`.`insight_report` (
    `insight_report_id` BIGINT COMMENT 'Unique identifier for the insight report. Primary key for the insight report entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client (advertiser) for whom this insight report was produced.',
    `analytics_request_id` BIGINT COMMENT 'Foreign key linking to analytics.analytics_request. Business justification: Insight reports are produced in response to analytics requests. The analytics_request captures the client need, scope, and requirements; the insight_report is the deliverable that fulfills that reques',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: Report approval is the quality control gate before client delivery. Tracking the approving worker is essential for accountability, compliance with client contracts, and managing approval SLAs. Current',
    `brand_brand_profile_id` BIGINT COMMENT 'Reference to the specific brand within the client organization that this report focuses on.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Insight reports are generated for specific brands. The existing brand_id (unlinked) should be replaced with brand_profile_id FK to brand.brand_profile. This normalizes brand reference and enables join',
    `campaign_id` BIGINT COMMENT 'Reference to the primary campaign analyzed in this report, if the report is campaign-specific.',
    `contract_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.milestone. Business justification: Insight reports often serve as milestone deliverables triggering payment or project progression. Essential for milestone-based project management and revenue recognition.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Insight reports are analytics deliverables tracked to cost centers for internal P&L analysis, profitability reporting by practice group, and resource allocation decisions in agency operations.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Insight reports routinely analyze project/initiative performance, outcomes, and ROI. Agency reporting processes require linking analytical findings to the specific initiatives being evaluated. Essenti',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Reports analyze IO delivery, pacing, and performance vs contracted terms. IO-level reporting required for billing reconciliation and vendor management. Natural FK for IO analysis.',
    `media_placement_id` BIGINT COMMENT 'Foreign key linking to media.placement. Business justification: Reports analyze placement-level performance, viewability, and brand safety. Placement analysis drives optimization and makegood decisions. Natural FK for placement-level reporting.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Reports analyze media plan performance vs targets. Media planners and clients require plan-level reporting for optimization decisions. Natural FK for plan performance analysis.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Insight reports are contractual deliverables specified in SOWs with defined acceptance criteria and payment triggers. Essential for fulfilling SOW deliverable obligations and tracking contractual comp',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Insight reports routinely analyze vendor performance, delivery quality, cost efficiency, and compliance for vendor scorecards and preferred vendor list updates. Standard reporting requirement in agenc',
    `superseded_insight_report_id` BIGINT COMMENT 'Self-referencing FK on insight_report (superseded_insight_report_id)',
    `approval_date` DATE COMMENT 'The date on which the insight report was formally approved for delivery by internal stakeholders or management.',
    `archived_date` DATE COMMENT 'The date on which the insight report was moved to archived status, indicating it is no longer actively used but retained for historical reference.',
    `client_feedback` STRING COMMENT 'Feedback received from the client regarding the quality, relevance, and actionability of the insight report.',
    `confidentiality_level` STRING COMMENT 'The data classification level assigned to this report, governing access and distribution controls.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the insight report record was first created in the system.',
    `data_sources` STRING COMMENT 'Comma-separated list of data sources and systems used as inputs for this analysis (e.g., Google Campaign Manager 360, Nielsen Ad Intel, Comscore, internal CRM).',
    `delivery_date` DATE COMMENT 'The date on which the insight report was formally delivered to the client.',
    `distribution_list` STRING COMMENT 'Comma-separated list of email addresses or contact identifiers for recipients of this report. Contains client and internal stakeholder contacts.',
    `executive_summary` STRING COMMENT 'High-level summary of the reports key findings and recommendations, typically 2-3 paragraphs intended for executive consumption.',
    `key_findings_narrative` STRING COMMENT 'Detailed narrative describing the primary insights, trends, and actionable findings uncovered in the analysis.',
    `kpi_metrics_included` STRING COMMENT 'Comma-separated list of KPI metrics analyzed and reported in this insight report (e.g., CPM, CPC, CTR, CPA, ROAS, ROI, GRP, TRP, VTR).',
    `language` STRING COMMENT 'The primary language in which the report is written (e.g., English, Spanish, French).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the insight report record was most recently updated or modified.',
    `lead_analyst_name` STRING COMMENT 'The full name of the principal analyst who authored or led the creation of this insight report.',
    `methodology_notes` STRING COMMENT 'Documentation of the analytical methods, data sources, statistical techniques, and assumptions used to produce the insights in this report.',
    `owning_analyst_team` STRING COMMENT 'The name or identifier of the analytics team responsible for producing this report.',
    `page_count` STRING COMMENT 'The total number of pages or slides in the delivered report document.',
    `recommendations` STRING COMMENT 'Actionable recommendations provided to the client based on the analysis, including optimization strategies, budget reallocation suggestions, and tactical adjustments.',
    `report_file_path` STRING COMMENT 'The storage location or URI where the final report deliverable is stored (e.g., cloud storage path, DAM system reference).',
    `report_format` STRING COMMENT 'The file format or delivery medium of the insight report (PDF, PowerPoint, Excel, Tableau dashboard, Looker dashboard, HTML, Word). [ENUM-REF-CANDIDATE: pdf|powerpoint|excel|tableau_dashboard|looker_dashboard|html|word — 7 candidates stripped; promote to reference product]',
    `report_status` STRING COMMENT 'Current lifecycle status of the insight report. Tracks progression from draft through review, approval, delivery, and archival.. Valid values are `draft|in_review|approved|delivered|archived|cancelled`',
    `report_title` STRING COMMENT 'The formal title of the analytical insight report or deliverable as presented to the client.',
    `report_type` STRING COMMENT 'Classification of the insight report by analytical purpose. Includes campaign post-mortem, brand health, audience analysis, competitive landscape, MMM (Media Mix Model) readout, attribution study, performance summary, QBR (Quarterly Business Review), and custom analysis. [ENUM-REF-CANDIDATE: campaign_post_mortem|brand_health|audience_analysis|competitive_landscape|mmm_readout|attribution_study|performance_summary|quarterly_business_review|custom_analysis — 9 candidates stripped; promote to reference product]',
    `reporting_period_end_date` DATE COMMENT 'The end date of the time period covered by this analytical report. Defines the conclusion of the data observation window.',
    `reporting_period_start_date` DATE COMMENT 'The start date of the time period covered by this analytical report. Defines the beginning of the data observation window.',
    `tags` STRING COMMENT 'Comma-separated list of metadata tags or keywords used for categorization, search, and retrieval of the report (e.g., digital, social, video, retail, automotive).',
    `version_number` STRING COMMENT 'The version identifier of the report, tracking iterations and revisions (e.g., 1.0, 1.1, 2.0).',
    CONSTRAINT pk_insight_report PRIMARY KEY(`insight_report_id`)
) COMMENT 'Master record for a formal analytical insight report or deliverable produced for a client — the authoritative SSOT for all client-facing analytics outputs. Captures report title, type (campaign post-mortem, brand health, audience analysis, competitive landscape, MMM readout, attribution study), reporting period, client and brand references, owning analyst team, delivery status (draft, in-review, delivered, archived), delivery date, distribution list, executive summary, key findings narrative, and methodology notes. Distinct from raw performance data — this is the curated analytical output layer.';

CREATE OR REPLACE TABLE `advertising_ecm`.`analytics`.`mmm_study` (
    `mmm_study_id` BIGINT COMMENT 'Unique identifier for the Media Mix Model study. Primary key for the MMM study entity.',
    `ad_channel_id` BIGINT COMMENT 'Foreign key linking to media.ad_channel. Business justification: MMM studies model channel-level ROI and saturation curves. Channel coefficients drive budget optimization recommendations. Links model outputs to channels analyzed.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client for whom this MMM study was commissioned.',
    `brand_brand_profile_id` BIGINT COMMENT 'Reference to the specific brand being analyzed in this MMM study.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: MMM (Marketing Mix Modeling) studies analyze brand performance across media channels. The existing brand_id (unlinked) should be replaced with brand_profile_id FK to brand.brand_profile. This enables ',
    `contract_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.milestone. Business justification: MMM studies are major milestones in analytics SOWs, often triggering significant payments. Critical for tracking major deliverable completion and revenue recognition.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: MMM studies are commissioned analytics work with significant labor and vendor costs that agencies allocate to specific cost centers for internal cost tracking and practice profitability analysis.',
    `creative_asset_id` BIGINT COMMENT 'Foreign key linking to creative.creative_asset. Business justification: Modern marketing mix models incorporate creative quality variables. Studies may flag specific asset types or creative approaches as higher-performing drivers of outcome variables. Increasingly common ',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Marketing Mix Modeling studies are commissioned to evaluate effectiveness of specific initiatives/projects. Agencies need to link MMM findings back to the initiatives being modeled for optimization re',
    `measurement_plan_id` BIGINT COMMENT 'Foreign key linking to analytics.measurement_plan. Business justification: MMM studies are executed based on measurement plans. The measurement plan defines the measurement objective, methodology, KPIs, and data collection approach that the MMM study implements. This FK link',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: MMM studies model media plan effectiveness and ROI. Studies evaluate plan channel mix and budget allocation. Essential for linking model outputs to executed plans.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: MMM studies are major analytics deliverables typically specified in SOWs with defined budgets, timelines, and acceptance criteria. Critical for delivering contracted analytics work and managing projec',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Marketing mix models decompose media effectiveness by supplier/vendor to optimize future vendor selection and budget allocation across the supply base. Core MMM use case for vendor ROI analysis.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_contract. Business justification: External MMM vendors work under vendor contracts that define pricing, IP ownership, and deliverables. Essential for managing external analytics vendor relationships and tracking vendor performance.',
    `worker_id` BIGINT COMMENT 'Reference to the agency analyst or data scientist who owns and is responsible for this MMM study.',
    `prior_mmm_study_id` BIGINT COMMENT 'Self-referencing FK on mmm_study (prior_mmm_study_id)',
    `actual_completion_date` DATE COMMENT 'The actual date on which the MMM study analysis was completed and finalized.',
    `budget_allocated` DECIMAL(18,2) COMMENT 'Total budget allocated by the client for conducting this MMM study, including data acquisition, modeling, and delivery costs.',
    `calibration_status` STRING COMMENT 'Status indicating whether the MMM model has been calibrated against known market conditions or holdout data to ensure accuracy.. Valid values are `not_started|in_progress|calibrated|failed|pending_review`',
    `commissioned_date` DATE COMMENT 'The date on which the MMM study was officially commissioned or initiated by the client.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this MMM study record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this MMM study (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_sources` STRING COMMENT 'Comma-separated list or description of all data sources used in the MMM study (e.g., Google Analytics, Nielsen, Comscore, client CRM, media billing systems).',
    `delivery_date` DATE COMMENT 'The date on which the final MMM study deliverables were delivered to the client.',
    `delivery_status` STRING COMMENT 'Status indicating whether the MMM study deliverables have been prepared and delivered to the client, and the client acceptance state.. Valid values are `not_delivered|in_preparation|delivered|accepted|revision_requested`',
    `external_vendor_tool` STRING COMMENT 'Specific software tool or platform used by the external vendor for MMM analysis (e.g., Nielsen Marketing Cloud, Analytic Partners ROI Genome, Ekimetrics Copilot).',
    `geographic_scope` STRING COMMENT 'Description of the geographic markets or regions covered by the MMM study (e.g., USA National, EMEA, specific DMA codes).',
    `granularity_level` STRING COMMENT 'The time granularity at which the MMM model operates and produces insights (e.g., daily, weekly, monthly, quarterly).. Valid values are `daily|weekly|monthly|quarterly`',
    `holdout_validation_approach` STRING COMMENT 'The method used to validate the MMM model using holdout data (e.g., time-based split, geographic holdout, random sample, or no holdout).. Valid values are `time_based|geographic|random_sample|none`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this MMM study record was last updated or modified.',
    `mape` DECIMAL(18,2) COMMENT 'Mean Absolute Percentage Error metric representing the average absolute percentage difference between predicted and actual values, indicating model accuracy.',
    `media_channels_included` STRING COMMENT 'Comma-separated list or description of all media channels included in the MMM analysis (e.g., TV, Digital Display, Search, Social, OOH, Radio, Print).',
    `model_version` STRING COMMENT 'Version identifier for the MMM model, following semantic versioning convention (e.g., v1.0, v2.1) to track iterations and refinements.. Valid values are `^v[0-9]+.[0-9]+(.[0-9]+)?$`',
    `modeling_methodology` STRING COMMENT 'Statistical or machine learning methodology employed for the Media Mix Model analysis (e.g., Bayesian, frequentist, Robyn, Meridian). [ENUM-REF-CANDIDATE: bayesian|frequentist|robyn|meridian|time_series|regression|machine_learning — 7 candidates stripped; promote to reference product]',
    `modeling_period_end_date` DATE COMMENT 'The end date of the historical data period used for building and training the Media Mix Model.',
    `modeling_period_start_date` DATE COMMENT 'The start date of the historical data period used for building and training the Media Mix Model.',
    `notes` STRING COMMENT 'Free-form notes capturing additional context, assumptions, limitations, or special considerations relevant to this MMM study.',
    `optimization_recommendations` STRING COMMENT 'Summary of key optimization recommendations derived from the MMM study for improving media mix allocation and Return on Ad Spend (ROAS).',
    `outcome_variable` STRING COMMENT 'The dependent variable or business outcome being modeled and optimized in the MMM study (e.g., revenue, sales volume, leads, conversions).. Valid values are `revenue|sales_volume|leads|conversions|brand_awareness|market_share`',
    `r_squared` DECIMAL(18,2) COMMENT 'R-squared coefficient of determination indicating the proportion of variance in the outcome variable explained by the media mix model (range 0 to 1).',
    `rmse` DECIMAL(18,2) COMMENT 'Root Mean Squared Error metric representing the standard deviation of prediction errors, providing a measure of model accuracy in the same units as the outcome variable.',
    `study_code` STRING COMMENT 'Unique alphanumeric code assigned to the MMM study for tracking and reference across systems and deliverables.. Valid values are `^[A-Z0-9]{6,12}$`',
    `study_name` STRING COMMENT 'Business-friendly name or title assigned to this Media Mix Model study for identification and reporting purposes.',
    `study_status` STRING COMMENT 'Current lifecycle status of the MMM study indicating its progress from initiation through delivery. [ENUM-REF-CANDIDATE: draft|in_progress|calibration|validation|completed|delivered|archived — 7 candidates stripped; promote to reference product]',
    `target_completion_date` DATE COMMENT 'The planned or target date for completing the MMM study analysis and delivering results to the client.',
    CONSTRAINT pk_mmm_study PRIMARY KEY(`mmm_study_id`)
) COMMENT 'Master record for a Media Mix Model (MMM) study commissioned for a client or brand. Captures study name, client and brand references, modeling period (start/end dates), modeling methodology (Bayesian, frequentist, Robyn, Meridian), media channels included, outcome variable (revenue, sales volume, leads), model version, calibration status, holdout validation approach, agency analyst owner, external vendor/tool used (Nielsen, Analytic Partners, Ekimetrics), delivery status, and final model accuracy metrics (MAPE, R-squared). The SSOT for all MMM engagements managed by the analytics team.';

CREATE OR REPLACE TABLE `advertising_ecm`.`analytics`.`attribution_study` (
    `attribution_study_id` BIGINT COMMENT 'Unique identifier for the attribution study record. Primary key.',
    `ad_channel_id` BIGINT COMMENT 'Foreign key linking to media.ad_channel. Business justification: Attribution studies measure channel-level contribution to conversions. Channel attribution drives budget allocation decisions. Links study findings to specific channels evaluated.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client for whom this attribution study was conducted.',
    `analytics_request_id` BIGINT COMMENT 'Foreign key linking to analytics.analytics_request. Business justification: Attribution studies can be commissioned via analytics requests. The analytics_request captures the client need for attribution analysis; the attribution_study is the deliverable that fulfills that req',
    `brand_brand_profile_id` BIGINT COMMENT 'Reference to the specific brand being analyzed in this attribution study.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Attribution studies measure campaign effectiveness for specific brands. The existing brand_id (unlinked) should be replaced with brand_profile_id FK to brand.brand_profile. This normalizes brand refer',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign or campaign group that is the subject of this attribution study.',
    `contract_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.milestone. Business justification: Attribution studies are milestones in measurement plans, often triggering payments. Essential for tracking analytics project progress and managing payment schedules.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Attribution studies are analytics deliverables with production costs (labor, tools, data) that agencies track to cost centers for internal accounting and service line profitability reporting.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Attribution studies measure conversion impact of specific campaign initiatives. Linking study results to initiatives enables performance evaluation, optimization, and demonstrates project ROI to clien',
    `measurement_plan_id` BIGINT COMMENT 'Foreign key linking to analytics.measurement_plan. Business justification: Attribution studies are executed based on measurement plans. The measurement plan defines the attribution methodology, measurement window, conversion events, and data sources that the attribution stud',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Attribution studies measure media plan channel contribution to conversions. Planners use attribution to optimize future plans. Links study findings to plan being evaluated.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Attribution studies are analytics deliverables specified in SOWs with defined methodologies and budgets. Essential for fulfilling contracted analytics obligations and tracking deliverable completion.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Attribution studies track conversion paths through vendor touchpoints (publisher, DSP, data provider) to evaluate each vendors contribution to campaign outcomes. Standard multi-touch attribution prac',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_contract. Business justification: External attribution vendors work under vendor contracts that define pricing and deliverables. Critical for managing vendor-delivered analytics and tracking vendor costs.',
    `worker_id` BIGINT COMMENT 'Reference to the data analyst or data scientist who owns and is responsible for this attribution study.',
    `prior_attribution_study_id` BIGINT COMMENT 'Self-referencing FK on attribution_study (prior_attribution_study_id)',
    `attribution_methodology` STRING COMMENT 'Specific attribution model or algorithm applied in the study (e.g., last-click, data-driven, Shapley value, Markov chain, algorithmic MTA). [ENUM-REF-CANDIDATE: last_click|first_click|linear|time_decay|position_based|data_driven|algorithmic_mta|shapley_value|markov_chain|custom — 10 candidates stripped; promote to reference product]',
    `conversion_events_measured` STRING COMMENT 'Comma-separated list or description of conversion events included in the attribution analysis (e.g., purchase, lead submission, app install, sign-up).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this attribution study record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in the attribution study (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_sources_integrated` STRING COMMENT 'List of data sources integrated for the attribution study (e.g., ad server, CRM, pixel data, clean room, DMP, CDP, offline sales).',
    `delivery_date` DATE COMMENT 'Date when the attribution study findings and deliverables were delivered to the client.',
    `key_findings_summary` STRING COMMENT 'Executive summary of the key attribution findings, insights, and recommendations from the study.',
    `measurement_window_days` STRING COMMENT 'Number of days in the lookback window used to attribute conversions to touchpoints (e.g., 7, 14, 30, 90 days).',
    `model_confidence_score` DECIMAL(18,2) COMMENT 'Statistical confidence score or accuracy metric for the attribution model, typically expressed as a percentage (0-100).',
    `model_training_end_date` DATE COMMENT 'End date of the historical data period used to train the attribution model.',
    `model_training_start_date` DATE COMMENT 'Start date of the historical data period used to train the attribution model.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this attribution study record was last modified or updated.',
    `notes` STRING COMMENT 'Additional notes, comments, or context about the attribution study, including methodology adjustments, data quality issues, or special considerations.',
    `platform_tool_used` STRING COMMENT 'Name of the attribution platform, tool, or software used to conduct the study (e.g., Google Attribution, Neustar, Visual IQ, Rockerbox, custom in-house model).',
    `report_url` STRING COMMENT 'URL or file path to the full attribution study report, dashboard, or presentation deliverable.',
    `roas_overall` DECIMAL(18,2) COMMENT 'Overall Return on Ad Spend (ROAS) calculated across all channels and touchpoints in the attribution study.',
    `study_code` STRING COMMENT 'Unique alphanumeric code assigned to the attribution study for tracking and reference across systems.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `study_completion_date` DATE COMMENT 'Date when the attribution study analysis was completed and finalized.',
    `study_name` STRING COMMENT 'Business-friendly name or title of the attribution study for identification and reporting purposes.',
    `study_start_date` DATE COMMENT 'Date when the attribution study project was initiated or commissioned by the client.',
    `study_status` STRING COMMENT 'Current lifecycle status of the attribution study (e.g., draft, in progress, under review, completed, delivered, archived, cancelled). [ENUM-REF-CANDIDATE: draft|in_progress|under_review|completed|delivered|archived|cancelled — 7 candidates stripped; promote to reference product]',
    `study_type` STRING COMMENT 'Classification of the attribution study methodology and scope (e.g., multi-touch attribution, unified measurement, media mix model).. Valid values are `multi_touch_attribution|unified_measurement|media_mix_model|incrementality_test|cross_channel_attribution|single_touch_attribution`',
    `top_performing_channel` STRING COMMENT 'Marketing channel identified as the top performer based on attribution analysis (e.g., paid search, display, social, email, OOH).',
    `total_conversions_attributed` BIGINT COMMENT 'Total number of conversions attributed across all touchpoints and channels in the study period.',
    `total_revenue_attributed` DECIMAL(18,2) COMMENT 'Total revenue amount attributed to marketing touchpoints based on the attribution model.',
    `validation_approach` STRING COMMENT 'Method used to validate the accuracy and reliability of the attribution model (e.g., holdout validation, cross-validation, A/B test, control group).. Valid values are `holdout_validation|cross_validation|backtesting|a_b_test|control_group|none`',
    CONSTRAINT pk_attribution_study PRIMARY KEY(`attribution_study_id`)
) COMMENT 'Master record for a multi-touch attribution (MTA) or unified measurement study conducted for a client campaign or brand. Captures study name, client and brand references, campaign scope, attribution methodology (last-click, data-driven, Shapley, Markov chain, algorithmic MTA), measurement window, conversion events measured, data sources integrated (ad server, CRM, pixel, clean room), model training period, validation approach, analyst owner, tool/platform used (Google Attribution, Neustar, Visual IQ, Rockerbox), delivery status, and key attribution findings. Distinct from the performance.attribution_model which is an operational configuration — this is the analytical study deliverable.';

CREATE OR REPLACE TABLE `advertising_ecm`.`analytics`.`dashboard` (
    `dashboard_id` BIGINT COMMENT 'Unique identifier for the analytics dashboard. Primary key for the dashboard entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client or advertiser for whom this dashboard was created. Links to the client master record in the Client domain.',
    `analytics_request_id` BIGINT COMMENT 'Foreign key linking to analytics.analytics_request. Business justification: Dashboards can be built in response to analytics requests. The analytics_request captures the client need for a reporting interface; the dashboard is the deliverable that fulfills that request. This F',
    `brand_profile_id` BIGINT COMMENT 'Reference to the specific brand within the client organization that this dashboard serves. Links to the brand master record in the Brand domain.',
    `campaign_id` BIGINT COMMENT 'Reference to the primary campaign this dashboard monitors, if the dashboard is campaign-specific. Null for multi-campaign or brand-level dashboards.',
    `contract_template_id` BIGINT COMMENT 'Reference to the dashboard template or blueprint from which this dashboard was instantiated. Null for custom-built dashboards. Links to a dashboard template reference table.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Dashboards are ongoing analytics products with recurring costs (platform licenses, maintenance labor, data feeds) allocated to specific cost centers for budget management and chargeback processes.',
    `worker_id` BIGINT COMMENT 'Reference to the user or manager who approved the dashboard for publication. Null if not yet approved. Links to the Talent domain.',
    `dashboard_created_by_user_worker_id` BIGINT COMMENT 'Reference to the user or analyst who originally created this dashboard. Links to the Talent domain.',
    `dashboard_last_modified_by_user_worker_id` BIGINT COMMENT 'Reference to the user who most recently modified the dashboard configuration or metadata. Links to the Talent domain.',
    `dashboard_worker_id` BIGINT COMMENT 'Reference to the data analyst or analytics team member responsible for maintaining and updating this dashboard. Links to the Talent domain.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Dashboards track initiative-level KPIs, budget burn, timeline adherence, and deliverable status. Project managers and clients use initiative-specific dashboards for real-time monitoring. Essential for',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Dashboards track IO pacing, delivery, and spend vs authorization. IO-level dashboards monitor vendor delivery and budget utilization. Enables IO-level performance monitoring.',
    `media_placement_id` BIGINT COMMENT 'Foreign key linking to media.placement. Business justification: Dashboards monitor placement delivery, viewability, and pacing. Placement-level dashboards track real-time performance and delivery issues. Enables placement-level metrics and alerts.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Dashboards visualize media plan pacing, delivery, and performance. Plan-level dashboards are standard deliverable for clients and internal stakeholders. Enables plan-level filtering and drill-down.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Dashboards are ongoing deliverables specified in SOWs with defined refresh cadences and access terms. Critical for fulfilling SOW reporting obligations and tracking recurring deliverable compliance.',
    `cloned_from_dashboard_id` BIGINT COMMENT 'Self-referencing FK on dashboard (cloned_from_dashboard_id)',
    `access_tier` STRING COMMENT 'Defines the intended audience and access control level for the dashboard. Client-facing dashboards are shared externally. Internal-only dashboards are for agency use. Executive-only dashboards contain sensitive P&L (Profit and Loss) or strategic data. Restricted dashboards require special permissions.. Valid values are `client_facing|internal_only|executive_only|restricted`',
    `approval_status` STRING COMMENT 'The current approval state of the dashboard before it can be published to clients or moved to live status. Pending indicates awaiting review. Approved indicates cleared for publication. Rejected indicates not approved. Revision requested indicates feedback provided and changes needed.. Valid values are `pending|approved|rejected|revision_requested`',
    `approved_timestamp` TIMESTAMP COMMENT 'The timestamp when the dashboard was approved for publication. Null if not yet approved.',
    `archived_timestamp` TIMESTAMP COMMENT 'The timestamp when the dashboard was archived and removed from active use. Null for non-archived dashboards.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this dashboard record was first created in the system. Represents the start of the dashboards lifecycle.',
    `dashboard_code` STRING COMMENT 'Short alphanumeric code or identifier used for system references and API calls. Typically uppercase with underscores or hyphens.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `dashboard_description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and key insights provided by the dashboard. Includes business context and intended use cases.',
    `dashboard_name` STRING COMMENT 'The business name or title of the dashboard as displayed to users and referenced in documentation.',
    `dashboard_type` STRING COMMENT 'Classification of the dashboard by its primary analytical purpose. Campaign performance tracks KPIs (Key Performance Indicators) like CTR (Click-Through Rate), CPA (Cost Per Acquisition), ROAS (Return on Ad Spend). Brand health monitors NPS (Net Promoter Score) and brand equity. Audience insights analyze demographic and behavioral segments. Executive summary provides QBR (Quarterly Business Review) level metrics. Media mix evaluates channel performance and MMM (Media Mix Model) outputs. Competitive SOV (Share of Voice) benchmarks against competitors.. Valid values are `campaign_performance|brand_health|audience_insights|executive_summary|media_mix|competitive_sov`',
    `data_sources` STRING COMMENT 'Comma-separated list or description of the upstream data sources feeding this dashboard. May include Google Campaign Manager 360, The Trade Desk, Salesforce CRM (Customer Relationship Management), Nielsen Ad Intel, Comscore, Mediaocean Prisma, GA (Google Analytics), or custom ETL (Extract Transform Load) pipelines.',
    `deprecated_timestamp` TIMESTAMP COMMENT 'The timestamp when the dashboard was marked as deprecated and scheduled for retirement. Null for active dashboards.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the dashboard refresh and data pipeline are fully automated (True) or require manual intervention (False).',
    `is_client_shared` BOOLEAN COMMENT 'Indicates whether this dashboard has been shared with the client (True) or is internal-only (False). Used for access control and audit purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this dashboard record was last updated. Tracks the most recent change to dashboard metadata, configuration, or status.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'The timestamp when the dashboard data was last refreshed from source systems. Used to communicate data freshness to users.',
    `last_validated_date` DATE COMMENT 'The date when the dashboard data accuracy and calculations were last verified by the owning analyst or QA (Quality Assurance) team. Critical for ensuring data integrity and client trust.',
    `notes` STRING COMMENT 'Free-text field for internal notes, change logs, known issues, or special instructions related to the dashboard. Used for operational communication among the analytics team.',
    `platform_tool` STRING COMMENT 'The business intelligence or analytics platform on which the dashboard is built and hosted. Datorama is now Salesforce Marketing Cloud Intelligence. [ENUM-REF-CANDIDATE: tableau|looker|power_bi|datorama|google_data_studio|salesforce_marketing_cloud_intelligence|custom — 7 candidates stripped; promote to reference product]',
    `primary_kpi` STRING COMMENT 'The main KPI (Key Performance Indicator) or metric that this dashboard is designed to track. Examples include ROAS (Return on Ad Spend), CTR (Click-Through Rate), CPA (Cost Per Acquisition), GRP (Gross Rating Point), SOV (Share of Voice), NPS (Net Promoter Score), or CLTV (Customer Lifetime Value).',
    `publication_status` STRING COMMENT 'Current lifecycle state of the dashboard. Development indicates active build. UAT (User Acceptance Testing) indicates client or stakeholder review phase. Live indicates production use. Deprecated indicates scheduled for retirement. Archived indicates historical record only.. Valid values are `development|uat|live|deprecated|archived`',
    `published_timestamp` TIMESTAMP COMMENT 'The timestamp when the dashboard was first published to live status and made available to its intended audience. Null for dashboards still in development or UAT (User Acceptance Testing).',
    `refresh_cadence` STRING COMMENT 'The frequency at which the dashboard data is updated from source systems. Real-time indicates streaming or near-instantaneous updates. On-demand indicates manual refresh triggered by users.. Valid values are `real_time|hourly|daily|weekly|monthly|on_demand`',
    `reporting_period_end` DATE COMMENT 'The end date of the time range covered by the dashboard data. Null for ongoing or open-ended dashboards.',
    `reporting_period_start` DATE COMMENT 'The start date of the time range covered by the dashboard data. Used to define the analytical window.',
    `tags` STRING COMMENT 'Comma-separated list of user-defined tags or labels for categorization, search, and filtering. Examples include channel names (PPC, SEO, OOH, CTV), industry verticals, or campaign themes.',
    `url` STRING COMMENT 'The web URL or deep link to access the live dashboard in the hosting platform. Used for direct navigation and sharing.',
    `version` STRING COMMENT 'Version number of the dashboard design and logic. Follows semantic versioning (e.g., v1.0, v2.1.3). Incremented when significant changes are made to layout, metrics, or data sources.. Valid values are `^v?[0-9]+.[0-9]+(.[0-9]+)?$`',
    CONSTRAINT pk_dashboard PRIMARY KEY(`dashboard_id`)
) COMMENT 'Master record for an analytics dashboard or live reporting interface built and maintained for a client or internal team. Captures dashboard name, type (campaign performance, brand health, audience insights, executive summary, media mix, competitive SOV), platform/tool (Tableau, Looker, Power BI, Datorama/Salesforce Marketing Cloud Intelligence, Google Data Studio), client and brand references, refresh cadence (real-time, hourly, daily, weekly), data sources connected, owning analyst, publication status (development, UAT, live, deprecated), access tier (client-facing, internal-only), and last validated date. The SSOT for all managed dashboard assets in the analytics output layer.';

CREATE OR REPLACE TABLE `advertising_ecm`.`analytics`.`insight_finding` (
    `insight_finding_id` BIGINT COMMENT 'Unique identifier for the insight finding record. Primary key for the insight finding entity.',
    `ad_channel_id` BIGINT COMMENT 'Foreign key linking to media.ad_channel. Business justification: Findings document channel-level insights and trends. Channel findings inform strategic channel mix decisions. Links insights to channel.',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: Finding ownership tracks which analyst identified and documented the insight, distinct from parent study ownership. Critical for credit attribution, follow-up question routing, and performance evaluat',
    `attribution_study_id` BIGINT COMMENT 'Foreign key linking to analytics.attribution_study. Business justification: Findings can be extracted from attribution studies. Attribution studies produce insights about customer journey, touchpoint effectiveness, and conversion paths. This FK allows tracking which attributi',
    `audience_insight_id` BIGINT COMMENT 'Foreign key linking to analytics.audience_insight. Business justification: Findings can be extracted from audience insight deliverables. Audience insights synthesize first-party and third-party data about target audiences. This FK allows tracking which audience insight deliv',
    `brand_lift_study_id` BIGINT COMMENT 'Foreign key linking to analytics.brand_lift_study. Business justification: Findings can be extracted from brand lift studies. Brand lift studies measure incremental impact on brand awareness, favorability, and consideration. This FK allows tracking which brand lift study gen',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign this finding relates to, if applicable. Enables linking findings back to specific campaign performance.',
    `competitive_intelligence_id` BIGINT COMMENT 'Foreign key linking to analytics.competitive_intelligence. Business justification: Findings can be extracted from competitive intelligence studies. Competitive intelligence produces insights about competitor strategies, share of voice, and market positioning. This FK allows tracking',
    `contract_deliverable_id` BIGINT COMMENT 'Reference to the parent analytical deliverable (insight report, MMM study, attribution study, or data science experiment) from which this finding was extracted.',
    `creative_asset_id` BIGINT COMMENT 'Foreign key linking to creative.creative_asset. Business justification: Findings routinely identify specific creative assets as high/low performers in attribution, effectiveness, and optimization analyses. Recommendations often call out individual assets for scaling or re',
    `creative_brief_id` BIGINT COMMENT 'Foreign key linking to creative.creative_brief. Business justification: Strategic findings assess campaign-objective alignment by referencing brief goals, target audiences, and success metrics. Findings recommend brief refinements for future campaigns based on performance',
    `creative_effectiveness_study_id` BIGINT COMMENT 'Foreign key linking to analytics.creative_effectiveness_study. Business justification: Findings can be extracted from creative effectiveness studies. Creative effectiveness studies measure message clarity, emotional resonance, brand linkage, and overall creative performance. This FK all',
    `incrementality_test_id` BIGINT COMMENT 'Foreign key linking to analytics.incrementality_test. Business justification: Findings can be extracted from incrementality tests. Incrementality tests measure true causal lift and incremental impact of advertising. This FK allows tracking which incrementality test generated ea',
    `insight_report_id` BIGINT COMMENT 'Foreign key linking to analytics.insight_report. Business justification: Findings are extracted from insight reports. This creates a proper parent-child hierarchy where insight_report is the authoritative source document and insight_finding captures individual insights ext',
    `media_placement_id` BIGINT COMMENT 'Foreign key linking to media.placement. Business justification: Findings document placement-level performance insights and anomalies. Placement findings drive tactical optimization and troubleshooting. Links insights to placement.',
    `mmm_study_id` BIGINT COMMENT 'Foreign key linking to analytics.mmm_study. Business justification: Findings can be extracted from MMM studies. MMM studies produce key insights about media mix effectiveness, channel ROI, and optimization opportunities. This FK allows tracking which MMM study generat',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Findings document plan-level insights and optimization opportunities. Plan findings drive strategic adjustments and learnings. Links insights to plan context.',
    `parent_insight_finding_id` BIGINT COMMENT 'Self-referencing FK on insight_finding (parent_insight_finding_id)',
    `approval_date` DATE COMMENT 'Date when this finding was approved for publication or client delivery. Marks the transition from draft to approved status.',
    `audience_segment` STRING COMMENT 'Target audience segment or demographic group that this finding pertains to, if applicable. Enables audience-specific insight cataloging.',
    `business_impact_classification` STRING COMMENT 'Primary business dimension that this finding impacts. Categorizes the strategic value and application area of the insight.. Valid values are `revenue|efficiency|brand equity|risk|customer acquisition|customer retention`',
    `channel` STRING COMMENT 'Media channel or platform that this finding relates to (e.g., display, social, search, OTT, OOH). Applicable for channel effectiveness findings.',
    `client_visibility_flag` BOOLEAN COMMENT 'Indicates whether this finding is approved for client visibility and inclusion in client-facing deliverables. False indicates internal-only insight.',
    `confidence_level` STRING COMMENT 'Statistical or analytical confidence level in the validity and reliability of this finding. Reflects data quality, sample size, and methodological rigor.. Valid values are `high|medium|low`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this insight finding record was first created in the system. Audit trail for record creation.',
    `creative_element` STRING COMMENT 'Specific creative element, message, or asset that this finding analyzes (e.g., headline variant, color scheme, call-to-action). Applicable for creative performance findings.',
    `data_source` STRING COMMENT 'Primary data source or system from which the analytical data for this finding was extracted (e.g., Google Analytics, Campaign Manager 360, Nielsen, Comscore).',
    `finding_narrative` STRING COMMENT 'Detailed narrative description of the insight finding, including context, analysis methodology, and interpretation of results. The full story behind the finding.',
    `finding_status` STRING COMMENT 'Current lifecycle status of the insight finding within the analytical workflow and approval process.. Valid values are `draft|under review|approved|published|archived`',
    `finding_title` STRING COMMENT 'Concise, descriptive title of the insight finding that summarizes the key discovery or recommendation.',
    `finding_type` STRING COMMENT 'Classification of the insight finding by analytical category. Determines the nature of the discovery and its application domain.. Valid values are `audience insight|channel effectiveness|creative performance|budget optimization recommendation|brand health signal|competitive threat`',
    `impact_value_unit` STRING COMMENT 'Unit of measure for the quantified impact value (e.g., USD, percentage, basis points, impressions).',
    `kpi_impacted` STRING COMMENT 'Primary KPI or metric that this finding directly affects or provides insight into (e.g., CTR, ROAS, CPA, brand awareness).',
    `methodology` STRING COMMENT 'Analytical methodology or technique used to derive this finding (e.g., regression analysis, A/B test, cohort analysis, MMM, attribution modeling).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this insight finding record was last modified. Audit trail for record updates.',
    `priority_tier` STRING COMMENT 'Urgency and importance ranking of this finding for business action. Guides resource allocation and implementation sequencing.. Valid values are `critical|high|medium|low`',
    `publication_date` DATE COMMENT 'Date when this finding was published or delivered to the client. Marks the official release of the insight.',
    `quantified_impact_value` DECIMAL(18,2) COMMENT 'Numerical quantification of the findings business impact, if measurable (e.g., projected revenue lift, cost savings, efficiency gain). Unit depends on impact classification.',
    `recommended_action` STRING COMMENT 'Specific, actionable recommendation based on this finding. Describes what the client or internal team should do in response to this insight.',
    `related_finding_ids` STRING COMMENT 'Comma-separated list of related insight finding IDs that are connected to or build upon this finding. Enables insight graph navigation.',
    `reusability_score` STRING COMMENT 'Score indicating the potential for this finding to be reused or referenced in future analyses or client deliverables. Scale 1-10, with 10 being highly reusable.',
    `sample_size` BIGINT COMMENT 'Number of observations, records, or data points analyzed to produce this finding. Indicates the robustness of the analysis.',
    `statistical_significance` DECIMAL(18,2) COMMENT 'P-value or statistical significance level of the finding, if applicable. Indicates the probability that the observed result occurred by chance.',
    `supporting_evidence_summary` STRING COMMENT 'Summary of the data, metrics, statistical tests, and analytical evidence that support this finding. References to charts, tables, or data sources that validate the insight.',
    `tags` STRING COMMENT 'Comma-separated list of tags or keywords for categorization, search, and cross-report insight discovery. Enables flexible taxonomy and findability.',
    `time_period_end` DATE COMMENT 'End date of the analysis time period for this finding. Defines the temporal scope of the data analyzed.',
    `time_period_start` DATE COMMENT 'Start date of the analysis time period for this finding. Defines the temporal scope of the data analyzed.',
    CONSTRAINT pk_insight_finding PRIMARY KEY(`insight_finding_id`)
) COMMENT 'Individual insight or finding record extracted from an insight report, MMM study, attribution study, or data science experiment. Captures finding title, finding type (audience insight, channel effectiveness, creative performance, budget optimization recommendation, brand health signal, competitive threat), parent deliverable reference, finding narrative, supporting evidence summary, confidence level (high/medium/low), business impact classification (revenue, efficiency, brand equity, risk), recommended action, priority tier, and analyst owner. Enables cross-report insight cataloging and reuse — the atomic unit of analytical intelligence produced for clients.';

CREATE OR REPLACE TABLE `advertising_ecm`.`analytics`.`measurement_plan` (
    `measurement_plan_id` BIGINT COMMENT 'Unique identifier for the measurement plan record. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client advertiser for whom this measurement plan was created.',
    `analytics_request_id` BIGINT COMMENT 'Foreign key linking to analytics.analytics_request. Business justification: Measurement plans can be developed in response to analytics requests. The analytics_request captures the client need for a measurement strategy; the measurement_plan is the deliverable that fulfills t',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: Measurement plan approval is a critical gate before test execution and budget commitment. Tracking the approving worker enables accountability for methodology decisions, compliance with client SOWs, a',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign this measurement plan is designed to evaluate.',
    `client_onboarding_id` BIGINT COMMENT 'Foreign key linking to client.client_onboarding. Business justification: New client onboarding includes establishing baseline measurement frameworks and KPI definitions. Links measurement plan to onboarding process enables tracking setup phase completion and ensures analyt',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Measurement plans represent scoped analytics work that agencies track to cost centers for resource planning, budget forecasting, and internal cost allocation against client engagements.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Measurement plans define success metrics and testing approach for specific initiatives. Created during project planning phase and referenced throughout execution. Links measurement strategy to the ini',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Measurement plans define KPIs and methodology for evaluating media plan success. Created during planning phase to establish measurement framework. Links measurement strategy to execution plan.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Measurement plans define how SOW analytics commitments will be executed, including methodologies and timelines. Essential for operationalizing SOW measurement obligations and ensuring contractual comp',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Measurement plans specify which vendors (measurement providers, publishers, tech platforms) will be measured and accountability frameworks. Establishes vendor-specific KPIs and data collection require',
    `superseded_measurement_plan_id` BIGINT COMMENT 'Self-referencing FK on measurement_plan (superseded_measurement_plan_id)',
    `analyst_owner` STRING COMMENT 'Name or identifier of the data analyst or data scientist responsible for executing the measurement plan and delivering insights.',
    `approval_status` STRING COMMENT 'Current approval status of the measurement plan in the client sign-off workflow.. Valid values are `draft|pending_review|approved|rejected|revision_requested|finalized`',
    `approved_date` DATE COMMENT 'Date on which the measurement plan received final approval from the client or internal stakeholder.',
    `attribution_window_days` STRING COMMENT 'Number of days after ad exposure during which conversions or actions are attributed back to the campaign, commonly 7, 14, or 30 days.',
    `baseline_benchmark` STRING COMMENT 'Pre-campaign baseline metric or benchmark value used as the control point for measuring lift, improvement, or incremental impact.',
    `compliance_requirements` STRING COMMENT 'Description of regulatory and privacy compliance requirements applicable to this measurement plan, such as GDPR (General Data Protection Regulation), CCPA (California Consumer Privacy Act), or industry-specific standards.',
    `confidence_level` DECIMAL(18,2) COMMENT 'Statistical confidence level (expressed as a percentage, e.g., 95.00) required for measurement results to be considered statistically significant.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost to execute the measurement plan, including vendor fees, data acquisition costs, and internal resource allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the measurement plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost estimate (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_collection_approach` STRING COMMENT 'Description of how data will be collected for measurement, including sources (pixel tracking, survey panels, CRM integration, third-party data feeds), collection frequency, and data quality controls.',
    `data_sources` STRING COMMENT 'Comma-separated list or description of data sources feeding into the measurement plan, such as Google Campaign Manager 360, The Trade Desk, Nielsen Ad Intel, Comscore, CRM systems, or third-party DMPs (Data Management Platforms).',
    `deliverable_format` STRING COMMENT 'Format in which measurement insights and reports will be delivered to the client, such as interactive dashboards, PDF reports, or API feeds.. Valid values are `dashboard|pdf_report|powerpoint|excel|api|custom`',
    `holdout_test_design` STRING COMMENT 'Description of the holdout or control group design used for incrementality testing, including sample size, randomization approach, and geographic or audience segmentation.',
    `measurement_methodology` STRING COMMENT 'Primary analytical methodology applied in this measurement plan. Brand lift measures awareness and perception changes; sales lift measures direct revenue impact; MTA (Multi-Touch Attribution) assigns credit across touchpoints; MMM (Media Mix Modeling) evaluates channel contribution; incrementality testing uses holdout groups to isolate causal impact. [ENUM-REF-CANDIDATE: brand_lift|sales_lift|multi_touch_attribution|media_mix_modeling|incrementality_testing|attribution_modeling|cross_media_measurement|unified_measurement — 8 candidates stripped; promote to reference product]',
    `measurement_objective` STRING COMMENT 'High-level strategic objective of the measurement plan, describing what business question or hypothesis the plan is designed to answer.',
    `measurement_vendor` STRING COMMENT 'Name of the third-party measurement vendor or platform used to execute the measurement plan, such as Nielsen, Comscore, or a specialized attribution provider.',
    `measurement_window_end_date` DATE COMMENT 'The end date of the measurement period, marking the conclusion of data collection for this plan.',
    `measurement_window_start_date` DATE COMMENT 'The start date of the measurement period during which data will be collected and analyzed.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the measurement plan record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about the measurement plan not captured in structured fields.',
    `plan_status` STRING COMMENT 'Current operational status of the measurement plan in its lifecycle.. Valid values are `active|completed|on_hold|cancelled|archived`',
    `plan_version` STRING COMMENT 'Version number of the measurement plan, incremented with each revision or update to track plan evolution.. Valid values are `^v[0-9]+.[0-9]+$`',
    `primary_kpi` STRING COMMENT 'The single most important KPI (Key Performance Indicator) that defines success for this measurement plan, such as ROAS (Return on Ad Spend), CTR (Click-Through Rate), brand awareness lift, or conversion rate.',
    `reporting_cadence` STRING COMMENT 'Frequency at which measurement results and insights will be delivered to the client, aligned with QBR (Quarterly Business Review) or campaign milestones. [ENUM-REF-CANDIDATE: daily|weekly|bi_weekly|monthly|quarterly|end_of_campaign|custom — 7 candidates stripped; promote to reference product]',
    `revision_notes` STRING COMMENT 'Free-text notes documenting changes made in the current version of the measurement plan, including rationale for revisions.',
    `sample_size` STRING COMMENT 'Target sample size for surveys, panels, or test groups used in the measurement plan to ensure statistical validity.',
    `secondary_kpi` STRING COMMENT 'Additional KPI (Key Performance Indicator) tracked to provide supplementary insight into campaign performance, such as engagement rate, VTR (View-Through Rate), or CPA (Cost Per Acquisition).',
    `target_audience_definition` STRING COMMENT 'Detailed definition of the target audience for measurement, including demographic, psychographic, and behavioral criteria used to define the in-scope population.',
    CONSTRAINT pk_measurement_plan PRIMARY KEY(`measurement_plan_id`)
) COMMENT 'Master record for a client measurement plan — the strategic document defining how campaign and brand performance will be measured, what KPIs will be tracked, which methodologies will be applied, and what success looks like. Captures plan name, client and campaign references, measurement objectives, primary and secondary KPIs, measurement methodology (brand lift, sales lift, MTA, MMM, incrementality testing), data collection approach, reporting cadence, baseline benchmarks, holdout test design, analyst owner, approval status, and plan version. The SSOT for measurement strategy commitments made to clients.';

CREATE OR REPLACE TABLE `advertising_ecm`.`analytics`.`brand_lift_study` (
    `brand_lift_study_id` BIGINT COMMENT 'Unique identifier for the brand lift study. Primary key for this entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client (advertiser) for whom this brand lift study is conducted.',
    `analytics_request_id` BIGINT COMMENT 'Foreign key linking to analytics.analytics_request. Business justification: Brand lift studies can be commissioned via analytics requests. The analytics_request captures the client need for brand lift measurement; the brand_lift_study is the deliverable that fulfills that req',
    `brand_brand_profile_id` BIGINT COMMENT 'Reference to the specific brand being measured in this brand lift study.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Brand lift studies directly measure brand awareness, favorability, and preference metrics. The existing brand_id (unlinked) should be replaced with brand_profile_id FK to brand.brand_profile. This ena',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign whose impact is being measured by this brand lift study.',
    `concept_id` BIGINT COMMENT 'Foreign key linking to creative.concept. Business justification: Pre-launch brand lift testing evaluates concepts before full production investment. Common for high-budget campaigns to test multiple concepts and select the strongest for production. Reduces creative',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Brand lift studies are purchased research with vendor costs and internal labor that agencies allocate to specific cost centers for budget tracking and practice profitability analysis.',
    `creative_asset_id` BIGINT COMMENT 'Foreign key linking to creative.creative_asset. Business justification: Brand lift studies measure awareness, favorability, and consideration lift from exposure to specific creative executions. The exposed group sees particular assets; the study must reference them. Stand',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Brand lift studies measure awareness and perception impact of specific initiatives. Results inform initiative effectiveness evaluation and future strategy. Agencies must link lift results to the initi',
    `measurement_plan_id` BIGINT COMMENT 'Foreign key linking to analytics.measurement_plan. Business justification: Brand lift studies are executed based on measurement plans. The measurement plan defines the brand metrics to measure, sample design, and measurement approach that the brand lift study implements. Thi',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Brand lift studies measure media plan impact on brand awareness and perception. Studies evaluate plan effectiveness beyond performance metrics. Connects brand outcomes to media plan.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Brand lift studies are research deliverables specified in SOWs with defined methodologies and budgets. Critical for delivering contracted research and managing study costs against SOW budgets.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Brand lift studies measure campaign effectiveness delivered through specific vendors/publishers to evaluate vendor quality and justify premium inventory costs. Direct vendor performance measurement.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_contract. Business justification: Brand lift study providers work under vendor contracts that define pricing and methodologies. Essential for managing research vendor relationships and tracking study costs.',
    `prior_brand_lift_study_id` BIGINT COMMENT 'Self-referencing FK on brand_lift_study (prior_brand_lift_study_id)',
    `ad_recall_lift_pct` DECIMAL(18,2) COMMENT 'Percentage point lift in advertising recall (ability to remember seeing the ad) among the exposed group compared to the control group.',
    `aided_awareness_lift_pct` DECIMAL(18,2) COMMENT 'Percentage point lift in aided brand awareness (recognition when prompted) among the exposed group compared to the control group.',
    `brand_favorability_lift_pct` DECIMAL(18,2) COMMENT 'Percentage point lift in brand favorability or positive sentiment among the exposed group compared to the control group.',
    `brand_preference_lift_pct` DECIMAL(18,2) COMMENT 'Percentage point lift in brand preference (stated preference for this brand over competitors) among the exposed group compared to the control group.',
    `confidence_level_pct` DECIMAL(18,2) COMMENT 'Statistical confidence level used for the brand lift study results, typically 90%, 95%, or 99%.',
    `consideration_lift_pct` DECIMAL(18,2) COMMENT 'Percentage point lift in brand consideration (likelihood to consider the brand when making a purchase decision) among the exposed group compared to the control group.',
    `control_group_definition` STRING COMMENT 'Detailed description of the criteria and parameters used to define the control group (users who were not served the advertising campaign).',
    `control_sample_size` STRING COMMENT 'Number of respondents in the control group who completed the brand lift survey.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for conducting the brand lift study, including vendor fees, incentives, and related expenses.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand lift study record was first created in the system.',
    `delivery_status` STRING COMMENT 'Status of the brand lift study deliverables and reporting to the client, tracking the final output lifecycle.. Valid values are `pending|delivered|reviewed|archived`',
    `exposed_group_definition` STRING COMMENT 'Detailed description of the criteria and parameters used to define the exposed group (users who were served the advertising campaign).',
    `exposed_sample_size` STRING COMMENT 'Number of respondents in the exposed group who completed the brand lift survey.',
    `margin_of_error_pct` DECIMAL(18,2) COMMENT 'Statistical margin of error for the brand lift study results, expressed as a percentage.',
    `message_association_lift_pct` DECIMAL(18,2) COMMENT 'Percentage point lift in message association (ability to correctly associate key campaign messages with the brand) among the exposed group compared to the control group.',
    `methodology_notes` STRING COMMENT 'Additional notes and details about the brand lift study methodology, sampling approach, survey design, and any deviations from standard practices.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand lift study record was last modified or updated.',
    `purchase_intent_lift_pct` DECIMAL(18,2) COMMENT 'Percentage point lift in purchase intent (stated likelihood to purchase the brand) among the exposed group compared to the control group.',
    `report_delivery_date` DATE COMMENT 'Date when the final brand lift study report and results were delivered to the client.',
    `statistical_significance_flag` BOOLEAN COMMENT 'Indicates whether the overall brand lift results achieved statistical significance at the specified confidence level.',
    `study_code` STRING COMMENT 'Externally-known unique code or identifier for the brand lift study, used for cross-system reference and client communication.',
    `study_end_date` DATE COMMENT 'Date when the brand lift study fieldwork concluded, marking the end of data collection.',
    `study_name` STRING COMMENT 'Human-readable name or title of the brand lift study, used for identification and reporting purposes.',
    `study_start_date` DATE COMMENT 'Date when the brand lift study fieldwork began, marking the start of data collection from exposed and control groups.',
    `study_status` STRING COMMENT 'Current lifecycle status of the brand lift study, indicating its progress from planning through completion.. Valid values are `draft|in-field|completed|cancelled|on-hold`',
    `study_type` STRING COMMENT 'Classification of the brand lift study methodology, indicating the media channel and measurement approach used.. Valid values are `survey-based|digital brand lift|TV brand lift|cross-platform|OTT brand lift|social brand lift`',
    `survey_wave_count` STRING COMMENT 'Number of survey waves or measurement periods conducted during the brand lift study.',
    `target_audience_description` STRING COMMENT 'Detailed description of the target audience demographics and psychographics used for the brand lift study sampling.',
    `unaided_awareness_lift_pct` DECIMAL(18,2) COMMENT 'Percentage point lift in unaided brand awareness (spontaneous recall without prompting) among the exposed group compared to the control group.',
    CONSTRAINT pk_brand_lift_study PRIMARY KEY(`brand_lift_study_id`)
) COMMENT 'Master record for a brand lift study measuring the incremental impact of advertising on brand awareness, consideration, preference, purchase intent, and message association. Captures study name, client and brand references, campaign references, study provider (Kantar Millward Brown, Nielsen Brand Effect, Lucid, Dynata, Ipsos), study type (survey-based, digital brand lift, TV brand lift), exposed and control group definitions, survey wave schedule, metrics tracked (aided/unaided awareness, ad recall, brand favorability, purchase intent), sample size, confidence intervals, lift results by metric, and delivery status. Distinct from brand.brand_health_metric which tracks ongoing brand equity — this is a discrete study event.';

CREATE OR REPLACE TABLE `advertising_ecm`.`analytics`.`incrementality_test` (
    `incrementality_test_id` BIGINT COMMENT 'Unique identifier for the incrementality test record. Primary key for the incrementality test entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser client for whom this incrementality test is being conducted.',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: Incrementality test ownership tracks which analyst designed the test, executed analysis, and owns results interpretation. Critical for knowledge management, client escalation, and performance evaluati',
    `analytics_request_id` BIGINT COMMENT 'Foreign key linking to analytics.analytics_request. Business justification: Incrementality tests can be commissioned via analytics requests. The analytics_request captures the client need for incrementality measurement; the incrementality_test is the deliverable that fulfills',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign being tested for incremental lift. May be null for cross-campaign or channel-level tests.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Incrementality tests are analytics initiatives with associated costs (test setup, measurement tools, analysis labor) tracked to cost centers for internal accounting and resource allocation.',
    `creative_asset_id` BIGINT COMMENT 'Foreign key linking to creative.creative_asset. Business justification: Incrementality tests often test creative variations (treatment = new creative, control = existing creative or holdout). Asset-level testing isolates creative impact on conversions. Standard test desig',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Incrementality tests measure true causal impact of initiative activities versus baseline. Test design and results must be linked to the specific initiative being tested for ROI validation and budget j',
    `measurement_plan_id` BIGINT COMMENT 'Foreign key linking to analytics.measurement_plan. Business justification: Incrementality tests are executed based on measurement plans. The measurement plan defines the test design, holdout approach, outcome metrics, and statistical methodology that the incrementality test ',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Incrementality tests measure media plan true incremental impact vs baseline. Tests validate plan effectiveness and inform future planning. Links test design to plan being evaluated.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Incrementality tests are analytics deliverables specified in SOWs with defined test designs and budgets. Critical for delivering contracted measurement work and managing test costs.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Incrementality tests isolate vendor contribution by testing with/without specific vendor inventory (geo-holdout, PSA control) to prove incremental value. Core vendor validation methodology.',
    `prior_incrementality_test_id` BIGINT COMMENT 'Self-referencing FK on incrementality_test (prior_incrementality_test_id)',
    `control_group_definition` STRING COMMENT 'Detailed definition of the control group, including targeting criteria, geographic boundaries, audience segments, or time periods that did NOT receive the media exposure, serving as the counterfactual baseline.',
    `control_group_outcome_value` DECIMAL(18,2) COMMENT 'The observed outcome metric value in the control group during the test period, serving as the counterfactual baseline.',
    `control_group_size` BIGINT COMMENT 'The number of units (users, households, geographies, or time periods) in the control group that did not receive the media exposure.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this incrementality test record was first created in the system.',
    `incremental_cost_per_outcome` DECIMAL(18,2) COMMENT 'The cost per incremental outcome unit, calculated as total media spend divided by the number of incremental outcomes attributable to the media. Represents the true Cost Per Acquisition (CPA) or Cost Per Action (CPA) accounting for baseline conversions.',
    `incremental_lift_estimate` DECIMAL(18,2) COMMENT 'The estimated causal lift (percentage increase) in the outcome metric attributable to the media exposure, calculated as (treatment - control) / control. Expressed as a decimal (e.g., 0.15 for 15% lift).',
    `incremental_roas` DECIMAL(18,2) COMMENT 'The incremental revenue generated per dollar of media spend, calculated as incremental revenue divided by media spend. Represents the true Return on Ad Spend (ROAS) accounting for baseline revenue that would have occurred without the media.',
    `is_statistically_significant` BOOLEAN COMMENT 'Boolean flag indicating whether the incremental lift estimate is statistically significant at the pre-defined confidence level. True if p-value is below the significance threshold.',
    `lift_confidence_interval_lower` DECIMAL(18,2) COMMENT 'The lower bound of the confidence interval for the incremental lift estimate, representing the minimum plausible lift given the data and confidence level.',
    `lift_confidence_interval_upper` DECIMAL(18,2) COMMENT 'The upper bound of the confidence interval for the incremental lift estimate, representing the maximum plausible lift given the data and confidence level.',
    `measurement_window_days` STRING COMMENT 'The number of days after exposure during which outcomes are measured and attributed to the test. Defines the conversion window for outcome tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this incrementality test record was last modified or updated.',
    `outcome_metric` STRING COMMENT 'The primary business outcome being measured for incremental lift (e.g., conversions, revenue, store visits, app installs, brand awareness, consideration). Defines the dependent variable in the causal analysis.',
    `p_value` DECIMAL(18,2) COMMENT 'The p-value from the hypothesis test of whether the incremental lift is statistically significantly different from zero. Values below the significance threshold (typically 0.05 or 0.10) indicate statistical significance.',
    `power_analysis_confidence_level` DECIMAL(18,2) COMMENT 'The confidence level (1 - alpha) used in power analysis and hypothesis testing, typically 0.90 or 0.95. Defines the probability of correctly rejecting the null hypothesis when the alternative is true.',
    `power_analysis_minimum_detectable_effect` DECIMAL(18,2) COMMENT 'The smallest true effect size (lift percentage) that the test is powered to detect with statistical significance, given the sample size and design. Expressed as a decimal (e.g., 0.05 for 5% lift).',
    `power_analysis_statistical_power` DECIMAL(18,2) COMMENT 'The statistical power (1 - beta) of the test design, representing the probability of detecting a true effect if it exists. Typically targeted at 0.80 or higher.',
    `results_finalized_timestamp` TIMESTAMP COMMENT 'The timestamp when the test results were finalized and approved for reporting to the client. Marks the transition from analysis to delivery.',
    `statistical_methodology` STRING COMMENT 'The statistical or econometric method used to estimate causal lift. Difference-in-differences compares pre/post changes between treatment and control; synthetic control constructs weighted control from untreated units; Bayesian causal impact uses time-series forecasting; propensity score matching balances covariates; regression discontinuity exploits threshold assignment; randomized control trial uses random assignment.. Valid values are `difference_in_differences|synthetic_control|bayesian_causal_impact|propensity_score_matching|regression_discontinuity|randomized_control_trial`',
    `test_channel` STRING COMMENT 'The media channel or tactic being tested for incremental contribution (e.g., display, video, social, search, OOH, CTV, audio). May be a specific channel or a combination.',
    `test_code` STRING COMMENT 'Unique business identifier or code assigned to the incrementality test for external reference and tracking.',
    `test_end_date` DATE COMMENT 'The date when the incrementality test period concluded. Marks the end of the treatment exposure window.',
    `test_name` STRING COMMENT 'Business-friendly name of the incrementality test, used for identification and reporting purposes.',
    `test_notes` STRING COMMENT 'Free-text field for additional context, observations, caveats, or learnings from the incrementality test. May include notes on data quality issues, external events during the test period, or recommendations for future tests.',
    `test_objective` STRING COMMENT 'The business question or hypothesis that this incrementality test is designed to answer (e.g., Does display advertising drive incremental store visits?, What is the true lift from our CTV campaign?).',
    `test_start_date` DATE COMMENT 'The date when the incrementality test period began. Marks the start of the treatment exposure window.',
    `test_status` STRING COMMENT 'Current lifecycle status of the incrementality test. Draft indicates planning phase; planned indicates approved and scheduled; in_flight indicates test is actively running; completed indicates test concluded and results available; cancelled indicates test was terminated before completion; failed indicates test did not meet validity criteria.. Valid values are `draft|planned|in_flight|completed|cancelled|failed`',
    `test_type` STRING COMMENT 'The experimental design methodology used for the incrementality test. Geo holdout withholds treatment from specific geographies; audience holdout withholds from specific user segments; switchback alternates treatment over time; synthetic control constructs a counterfactual control group; matched market pairs similar markets; PSA (Public Service Announcement) test uses PSA impressions as control.. Valid values are `geo_holdout|audience_holdout|switchback|synthetic_control|matched_market|psa_test`',
    `treatment_group_definition` STRING COMMENT 'Detailed definition of the treatment group, including targeting criteria, geographic boundaries, audience segments, or time periods that received the media exposure being tested.',
    `treatment_group_outcome_value` DECIMAL(18,2) COMMENT 'The observed outcome metric value in the treatment group during the test period (e.g., total conversions, total revenue, average brand lift score).',
    `treatment_group_size` BIGINT COMMENT 'The number of units (users, households, geographies, or time periods) in the treatment group that received the media exposure.',
    CONSTRAINT pk_incrementality_test PRIMARY KEY(`incrementality_test_id`)
) COMMENT 'Master record for an incrementality or causal lift test designed to measure the true incremental contribution of a media channel, tactic, or creative to business outcomes. Captures test name, client and campaign references, test type (geo holdout, audience holdout, switchback, synthetic control), treatment and control group definitions, test channel or tactic, test period, outcome metric (conversions, revenue, store visits, app installs), statistical methodology (difference-in-differences, synthetic control, Bayesian causal impact), power analysis parameters, test status, analyst owner, and final lift estimate with confidence intervals. The SSOT for all incrementality measurement engagements.';

CREATE OR REPLACE TABLE `advertising_ecm`.`analytics`.`report_schedule` (
    `report_schedule_id` BIGINT COMMENT 'Unique identifier for the report schedule record. Primary key for the report schedule entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client or advertiser for whom this report schedule is configured. Links to the client master data.',
    `campaign_id` BIGINT COMMENT 'Reference to the specific campaign this report schedule is associated with. Nullable for cross-campaign or portfolio-level reports.',
    `dashboard_id` BIGINT COMMENT 'Reference to the dashboard that is scheduled for delivery. Links to the dashboard definition in the analytics catalog. Nullable when schedule is for a report rather than a dashboard.',
    `insight_report_id` BIGINT COMMENT 'Reference to the report or dashboard that is scheduled for delivery. Links to the report definition in the analytics catalog.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Scheduled reports automate media plan performance delivery to stakeholders. Plan-level report schedules are standard client deliverable. Enables automated plan reporting.',
    `preference_id` BIGINT COMMENT 'Foreign key linking to client.client_preference. Business justification: Report schedules must align with client preferences for cadence, format, and delivery method. Links schedule to preference record ensures automated reporting respects client communication preferences—',
    `worker_id` BIGINT COMMENT 'Reference to the internal user or team responsible for maintaining and managing this report schedule. Links to employee or team master data.',
    `recipient_group_id` BIGINT COMMENT 'Reference to a predefined recipient group or distribution list. Alternative to individual recipient list for managing large or dynamic audiences.',
    `sla_id` BIGINT COMMENT 'Foreign key linking to contract.sla. Business justification: Report delivery schedules are tied to SLA commitments for delivery timing and frequency. Essential for meeting contractual reporting SLAs and tracking compliance.',
    `tertiary_report_modified_by_user_worker_id` BIGINT COMMENT 'Reference to the user who last modified this report schedule. Links to employee or user master data for accountability.',
    `superseded_report_schedule_id` BIGINT COMMENT 'Self-referencing FK on report_schedule (superseded_report_schedule_id)',
    `auto_generation_flag` BOOLEAN COMMENT 'Indicates whether the report is automatically generated and sent without manual intervention. True for fully automated schedules, false for manual approval workflows.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this report schedule record was first created in the system. Used for audit trail and lifecycle tracking.',
    `custom_parameters` STRING COMMENT 'JSON or key-value string containing custom report parameters such as filters, date ranges, or specific metrics to include. Enables flexible report configuration.',
    `data_refresh_lag_hours` STRING COMMENT 'Number of hours of data latency expected before report generation. Ensures reports are generated after source data is fully refreshed and available.',
    `delivery_day_of_month` STRING COMMENT 'Specific day of the month for monthly or quarterly delivery schedules. Value between 1 and 31. Nullable for non-monthly frequencies.',
    `delivery_day_of_week` STRING COMMENT 'Specific day of the week for weekly delivery schedules. Nullable for non-weekly frequencies. [ENUM-REF-CANDIDATE: monday|tuesday|wednesday|thursday|friday|saturday|sunday — 7 candidates stripped; promote to reference product]',
    `delivery_format` STRING COMMENT 'File format or presentation format for the delivered report. Determines how the report content is packaged for recipients.. Valid values are `pdf|excel|csv|powerpoint|live_link|json`',
    `delivery_frequency` STRING COMMENT 'Recurrence pattern for report delivery. Defines how often the report or dashboard is automatically generated and sent to recipients.. Valid values are `daily|weekly|monthly|quarterly|annual|ad_hoc`',
    `delivery_message_body` STRING COMMENT 'Email body text or message content accompanying the report delivery. Provides context and instructions to recipients.',
    `delivery_method` STRING COMMENT 'Primary channel or mechanism used to deliver the report to recipients. Defines the technical delivery approach.. Valid values are `email|slack|client_portal|ftp|api_push|sftp`',
    `delivery_subject_line` STRING COMMENT 'Email subject line or message title used when delivering the report. Supports dynamic tokens for date, client name, or campaign name.',
    `delivery_time` TIMESTAMP COMMENT 'Time of day for scheduled delivery in HH:MM format (24-hour clock). Represents the target time for report generation and distribution.',
    `delivery_timezone` STRING COMMENT 'Timezone for the delivery time. Uses IANA timezone database format (e.g., America/New_York, Europe/London).',
    `effective_end_date` DATE COMMENT 'Date on which this report schedule expires and stops executing deliveries. Nullable for indefinite schedules.',
    `effective_start_date` DATE COMMENT 'Date from which this report schedule becomes active and begins executing deliveries. Supports future-dated schedule activation.',
    `failure_notification_contacts` STRING COMMENT 'Comma-separated list of email addresses or user identifiers to notify when a scheduled delivery fails. Used for operational alerting and SLA management.',
    `include_comparison_period_flag` BOOLEAN COMMENT 'Indicates whether the report should include prior period comparison data (e.g., week-over-week, month-over-month, year-over-year).',
    `last_delivery_status` STRING COMMENT 'Outcome status of the most recent delivery attempt. Indicates whether the last scheduled delivery completed successfully.. Valid values are `success|failed|partial|skipped`',
    `last_delivery_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful delivery execution. Used for tracking delivery history and SLA compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this report schedule record was last modified. Used for change tracking and audit trail.',
    `next_scheduled_delivery_date` DATE COMMENT 'The next date on which this report schedule is set to execute. Updated after each successful delivery.',
    `recipient_list` STRING COMMENT 'Comma-separated or semicolon-separated list of email addresses or user identifiers who receive the scheduled report. Contains contact information for delivery targets.',
    `retry_count` STRING COMMENT 'Number of automatic retry attempts configured for failed deliveries. Defines resilience behavior for transient failures.',
    `retry_interval_minutes` STRING COMMENT 'Number of minutes to wait between retry attempts for failed deliveries. Defines the backoff strategy for delivery failures.',
    `schedule_description` STRING COMMENT 'Detailed description of the schedule purpose, audience, and any special instructions for delivery or content.',
    `schedule_name` STRING COMMENT 'Business-friendly name for the report schedule. Used for identification and management of recurring deliveries.',
    `schedule_status` STRING COMMENT 'Current operational status of the report schedule. Determines whether the schedule is actively executing deliveries.. Valid values are `active|paused|retired|draft|suspended|failed`',
    `sla_delivery_window_hours` STRING COMMENT 'Maximum number of hours allowed from scheduled time to successful delivery to meet SLA commitments. Used for performance monitoring and client satisfaction tracking.',
    `total_deliveries_count` STRING COMMENT 'Cumulative count of all delivery attempts (successful and failed) for this schedule since creation. Used for usage analytics and performance monitoring.',
    CONSTRAINT pk_report_schedule PRIMARY KEY(`report_schedule_id`)
) COMMENT 'Operational record defining the recurring delivery schedule for a report or dashboard. Captures schedule name, linked report or dashboard reference, delivery frequency (daily, weekly, monthly, quarterly, ad-hoc), next scheduled delivery date, delivery method (email, Slack, client portal, FTP, API push), recipient list, format (PDF, Excel, live link, PowerPoint), auto-generation flag, last successful delivery timestamp, failure notification contacts, and schedule status (active, paused, retired). Enables the analytics team to manage SLA commitments for recurring reporting deliverables.';

CREATE OR REPLACE TABLE `advertising_ecm`.`analytics`.`report_delivery` (
    `report_delivery_id` BIGINT COMMENT 'Unique identifier for each report or dashboard delivery instance. Primary key for the report delivery transaction.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client or advertiser organization for whom this report was delivered. Links to the client master data.',
    `campaign_id` BIGINT COMMENT 'Reference to the specific campaign this report covers. Nullable for cross-campaign or portfolio-level reports.',
    `dashboard_id` BIGINT COMMENT 'Reference to the dashboard definition if the delivery was a dashboard rather than a static report. Nullable when delivery is a report.',
    `insight_report_id` BIGINT COMMENT 'Reference to the report or dashboard definition that was delivered. Links to the report catalog or dashboard registry.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Report deliveries track media plan report distribution and client acknowledgment. Delivery tracking ensures SLA compliance for plan reporting. Links delivery to plan.',
    `report_schedule_id` BIGINT COMMENT 'Foreign key linking to analytics.report_schedule. Business justification: Links report delivery instances back to the report schedule that triggered them. The delivery_trigger field on report_delivery indicates some deliveries are scheduled vs ad_hoc or manual. For sc',
    `sla_id` BIGINT COMMENT 'Foreign key linking to contract.sla. Business justification: Report deliveries are measured against SLA targets for timeliness and quality. Critical for tracking SLA compliance and identifying breaches requiring remediation.',
    `worker_id` BIGINT COMMENT 'Reference to the analyst or user who triggered or approved this delivery. Links to the employee or user master data.',
    `redelivery_of_report_delivery_id` BIGINT COMMENT 'Self-referencing FK on report_delivery (redelivery_of_report_delivery_id)',
    `client_acknowledgment_status` STRING COMMENT 'Indicates whether the client has acknowledged receipt and acceptance of the delivered report. Used for contractual compliance and client satisfaction tracking.. Valid values are `acknowledged|pending|not_required`',
    `client_acknowledgment_timestamp` TIMESTAMP COMMENT 'The date and time when the client formally acknowledged receipt of the report. Nullable if acknowledgment is pending or not required.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this delivery record was first created in the system. Audit trail for record creation.',
    `delivery_method` STRING COMMENT 'The technical channel or mechanism used to deliver the report. Indicates how the content was transmitted to the recipient.. Valid values are `email|sftp|api|portal|slack|teams`',
    `delivery_notes` STRING COMMENT 'Free-text notes or comments about this delivery instance. Captures special instructions, exceptions, or contextual information.',
    `delivery_number` STRING COMMENT 'Human-readable business identifier for the delivery instance. Format: DEL-YYYYMMDD-XXXXXX. Used for tracking and client communication.. Valid values are `^DEL-[0-9]{8}-[A-Z0-9]{6}$`',
    `delivery_priority` STRING COMMENT 'The priority level assigned to this delivery. Used for queue management and SLA enforcement.. Valid values are `urgent|high|normal|low`',
    `delivery_source_system` STRING COMMENT 'The name or identifier of the system or platform that generated and delivered the report. Examples: Tableau, Power BI, custom analytics platform.',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the delivery. Tracks whether the delivery was successfully sent, opened by recipient, or encountered errors.. Valid values are `sent|delivered|opened|failed|bounced|pending`',
    `delivery_timestamp` TIMESTAMP COMMENT 'The exact date and time when the report or dashboard was delivered to the recipient. Primary business event timestamp for SLA tracking.',
    `delivery_trigger` STRING COMMENT 'The mechanism that initiated this delivery. Distinguishes between automated scheduled deliveries and manual or event-driven requests.. Valid values are `scheduled|manual|ad_hoc|event_driven|api_request`',
    `delivery_url` STRING COMMENT 'The URL or link where the recipient can access the delivered report or dashboard. Nullable for file-based deliveries.',
    `encryption_flag` BOOLEAN COMMENT 'Boolean indicator of whether the delivered file or content was encrypted for security. True if encrypted, false otherwise.',
    `error_message` STRING COMMENT 'Technical error message or exception details if the delivery failed or bounced. Nullable for successful deliveries.',
    `expiration_timestamp` TIMESTAMP COMMENT 'The date and time when access to the delivered report expires. Nullable for permanent access deliveries.',
    `file_format` STRING COMMENT 'The file format in which the report or dashboard was delivered. Indicates the output format provided to the recipient.. Valid values are `pdf|excel|csv|powerpoint|html|json`',
    `file_size_bytes` BIGINT COMMENT 'The size of the delivered file in bytes. Used for delivery performance monitoring and storage tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this delivery record was last modified. Audit trail for record updates.',
    `opened_timestamp` TIMESTAMP COMMENT 'The date and time when the recipient first opened or accessed the delivered report or dashboard. Nullable if not yet opened or tracking unavailable.',
    `password_protected_flag` BOOLEAN COMMENT 'Boolean indicator of whether the delivered file requires a password to open. True if password-protected, false otherwise.',
    `primary_recipient_email` STRING COMMENT 'The primary email address of the main recipient for this delivery. Used for client engagement tracking and communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_list` STRING COMMENT 'Comma-separated list of email addresses or user identifiers who received this delivery. Captures the actual recipient list at time of delivery for audit purposes.',
    `report_period_end_date` DATE COMMENT 'The end date of the reporting period covered by this delivered report. Used for report content tracking and analytics.',
    `report_period_start_date` DATE COMMENT 'The start date of the reporting period covered by this delivered report. Used for report content tracking and analytics.',
    `retry_count` STRING COMMENT 'The number of retry attempts made for this delivery. Zero for successful first-attempt deliveries.',
    `scheduled_delivery_timestamp` TIMESTAMP COMMENT 'The planned date and time for delivery when scheduled in advance. Nullable for ad-hoc deliveries. Used to measure delivery timeliness.',
    `sla_actual_minutes` STRING COMMENT 'The actual time in minutes from request to delivery. Used to measure SLA compliance and delivery performance.',
    `sla_met_flag` BOOLEAN COMMENT 'Boolean indicator of whether the delivery met the SLA target. True if delivered within SLA, false otherwise.',
    `sla_target_minutes` STRING COMMENT 'The contracted or expected delivery time in minutes from request to delivery. Used for SLA compliance tracking.',
    CONSTRAINT pk_report_delivery PRIMARY KEY(`report_delivery_id`)
) COMMENT 'Transactional record capturing each instance of a report or dashboard being delivered to a client or internal stakeholder. Captures delivery timestamp, linked report or dashboard reference, delivery method used, recipient list at time of delivery, delivery status (sent, opened, failed, bounced), file format delivered, delivery triggered by (scheduled, manual, ad-hoc), analyst who triggered delivery, client acknowledgment status, and any delivery notes or exceptions. The operational audit trail for all analytics output deliveries — enables SLA tracking and client engagement monitoring.';

CREATE OR REPLACE TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` (
    `competitive_intelligence_id` BIGINT COMMENT 'Unique identifier for the competitive intelligence study record.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client for whom this competitive intelligence study was produced.',
    `analytics_request_id` BIGINT COMMENT 'Foreign key linking to analytics.analytics_request. Business justification: Competitive intelligence can be produced in response to analytics requests. The analytics_request captures the client need for competitive analysis; the competitive_intelligence is the deliverable tha',
    `brand_brand_profile_id` BIGINT COMMENT 'Reference to the client brand that is the subject of this competitive intelligence analysis.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Competitive intelligence tracks brand positioning relative to competitors. The existing brand_id (unlinked) should be replaced with brand_profile_id FK to brand.brand_profile. This enables joining to ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Competitive intelligence work is an analytics service line with data subscription costs and analyst labor that agencies track to cost centers for profitability analysis and pricing decisions.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Competitive intelligence informs initiative strategy and evaluates performance versus competitors. Agencies link competitive analysis to specific initiatives to guide tactical decisions and demonstrat',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Competitive intelligence informs media plan strategy and SOV targets. Planners use competitive insights to set budgets and channel mix. Links intelligence to plan it informed.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Competitive intelligence reports are deliverables specified in SOWs with defined scope and delivery schedules. Essential for fulfilling contracted competitive analysis obligations.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Competitive intelligence monitors competitor vendor relationships, supply chain strategies, and publisher partnerships to identify market opportunities and vendor performance benchmarks. Real competit',
    `worker_id` BIGINT COMMENT 'Reference to the primary analyst or data scientist responsible for producing this competitive intelligence study.',
    `prior_competitive_intelligence_id` BIGINT COMMENT 'Self-referencing FK on competitive_intelligence (prior_competitive_intelligence_id)',
    `analysis_period_end_date` DATE COMMENT 'End date of the time period covered by this competitive intelligence analysis.',
    `analysis_period_start_date` DATE COMMENT 'Start date of the time period covered by this competitive intelligence analysis.',
    `channel_mix_comparison` STRING COMMENT 'Analysis of how the client brands media channel allocation compares to competitor channel strategies.',
    `channels_analyzed` STRING COMMENT 'Media channels and platforms analyzed in this competitive intelligence study (e.g., TV, digital, social, OOH, radio).',
    `client_feedback` STRING COMMENT 'Feedback received from the client regarding the competitive intelligence study quality, relevance, and actionability.',
    `competitor_brands_tracked` STRING COMMENT 'List or description of competitor brands included in this competitive intelligence study.',
    `competitor_spend_estimate` STRING COMMENT 'Summary of estimated advertising spend by competitor brands during the analysis period, typically expressed in ranges or indexed values.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Statistical confidence score or quality rating assigned to the competitive intelligence findings, typically expressed as a percentage.',
    `confidentiality_level` STRING COMMENT 'Data classification level assigned to this competitive intelligence study based on sensitivity of findings and client requirements.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this competitive intelligence study record was first created in the system.',
    `creative_strategy_observations` STRING COMMENT 'Narrative summary of observed creative strategies, messaging themes, and executional approaches used by competitors.',
    `data_collection_methodology` STRING COMMENT 'Description of the methodology and techniques used to collect and validate competitive intelligence data for this study.',
    `delivery_date` DATE COMMENT 'Date when the competitive intelligence study was delivered to the client.',
    `executive_summary` STRING COMMENT 'High-level executive summary of the competitive intelligence study suitable for senior stakeholder review.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether follow-up analysis or additional competitive intelligence work was requested by the client.',
    `intelligence_source` STRING COMMENT 'Primary data source or platform used to gather competitive intelligence data (e.g., Nielsen Ad Intel, Kantar CMAG, Pathmatics, Sensor Tower, SimilarWeb, social listening tools).',
    `key_findings_narrative` STRING COMMENT 'Comprehensive narrative summary of the most important competitive intelligence findings from this study.',
    `market_positioning_assessment` STRING COMMENT 'Strategic assessment of the client brands market position relative to competitors based on the intelligence gathered.',
    `markets_covered` STRING COMMENT 'Geographic markets or regions included in the scope of this competitive intelligence analysis.',
    `report_format` STRING COMMENT 'Primary format in which the competitive intelligence deliverable was produced and delivered.. Valid values are `pdf|powerpoint|dashboard|excel|interactive`',
    `sample_size` STRING COMMENT 'Number of data points, ad impressions, or observations analyzed in this competitive intelligence study.',
    `sov_trend_summary` STRING COMMENT 'Executive summary of share of voice trends observed for the client brand relative to competitors during the analysis period.',
    `strategic_implications` STRING COMMENT 'Analysis of strategic implications and recommended actions based on the competitive intelligence findings.',
    `study_code` STRING COMMENT 'Unique business identifier or code assigned to this competitive intelligence study for tracking and reference purposes.',
    `study_name` STRING COMMENT 'Business name or title of the competitive intelligence study deliverable.',
    `study_status` STRING COMMENT 'Current lifecycle status of the competitive intelligence study.. Valid values are `draft|in_progress|under_review|completed|delivered|archived`',
    `study_type` STRING COMMENT 'Classification of the competitive intelligence study by analytical focus area.. Valid values are `share_of_voice|spend_analysis|creative_strategy|channel_mix|market_positioning|brand_health`',
    `tags` STRING COMMENT 'Comma-separated list of business tags or keywords for categorizing and searching competitive intelligence studies.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this competitive intelligence study record was last modified.',
    CONSTRAINT pk_competitive_intelligence PRIMARY KEY(`competitive_intelligence_id`)
) COMMENT 'Master record for competitive intelligence studies and analyses produced for clients — capturing share of voice trends, competitor spend estimates, creative strategy observations, channel mix comparisons, and market positioning assessments. Captures study name, client and brand references, competitor brands tracked, intelligence source (Nielsen Ad Intel, Kantar CMAG, Pathmatics, Sensor Tower, SimilarWeb, social listening tools), analysis period, markets covered, channels analyzed, key competitive findings narrative, strategic implications, and analyst owner. Distinct from brand.share_of_voice which stores raw SOV measurement data — this is the curated competitive intelligence deliverable.';

CREATE OR REPLACE TABLE `advertising_ecm`.`analytics`.`audience_insight` (
    `audience_insight_id` BIGINT COMMENT 'Unique identifier for the audience insight deliverable. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client (advertiser) for whom this audience insight was produced.',
    `analytics_request_id` BIGINT COMMENT 'Foreign key linking to analytics.analytics_request. Business justification: Audience insights can be produced in response to analytics requests. The analytics_request captures the client need for audience analysis; the audience_insight is the deliverable that fulfills that re',
    `audience_segment_id` BIGINT COMMENT 'Reference to the primary audience segment analyzed in this insight.',
    `brand_brand_profile_id` BIGINT COMMENT 'Reference to the specific brand within the client organization that this insight supports.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Audience insights analyze consumer behavior and preferences for specific brands. The existing brand_id (unlinked) should be replaced with brand_profile_id FK to brand.brand_profile. This enables joini',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign this insight supports or was derived from, if applicable.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Audience insights are analytics deliverables with production costs (data acquisition, analysis labor, tools) allocated to specific cost centers for internal cost tracking and service line profitabilit',
    `creative_brief_id` BIGINT COMMENT 'Foreign key linking to creative.creative_brief. Business justification: Audience research (persona insights, behavioral data, segmentation findings) directly informs brief development. Target audience definitions, key messages, and tone-of-voice in briefs are shaped by au',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Audience insights drive initiative targeting strategy and creative development. Linking insights to initiatives enables tracking which insights informed which projects and measuring impact of insight-',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Audience insights inform media plan targeting and channel selection. Insights drive plan audience strategy and vehicle selection. Connects audience research to plan execution.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Audience insights are analytics deliverables specified in SOWs with defined methodologies and delivery schedules. Critical for delivering contracted audience research.',
    `worker_id` BIGINT COMMENT 'Reference to the analytics team member (employee) who owns and is responsible for this insight deliverable.',
    `derived_from_audience_insight_id` BIGINT COMMENT 'Self-referencing FK on audience_insight (derived_from_audience_insight_id)',
    `activation_recommendations` STRING COMMENT 'Strategic recommendations for how to activate the insight in media planning, creative development, channel selection, and targeting strategies.',
    `analysis_end_date` DATE COMMENT 'The date when the analytical work for this insight was completed.',
    `analysis_methodology` STRING COMMENT 'Description of the analytical approach and techniques used to derive the insight (e.g., cohort analysis, regression modeling, clustering, propensity scoring, media mix modeling).',
    `analysis_start_date` DATE COMMENT 'The date when the analytical work for this insight began.',
    `audience_size` BIGINT COMMENT 'The estimated or measured size of the audience segment analyzed in this insight, expressed as the number of individuals or households.',
    `client_feedback` STRING COMMENT 'Summary of feedback received from the client regarding the insight deliverable, including requests for revisions, clarifications, or additional analysis.',
    `confidence_level` DECIMAL(18,2) COMMENT 'Statistical confidence level of the insight findings, expressed as a percentage (e.g., 95.00 for 95% confidence). Indicates the reliability of the analytical conclusions.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this audience insight record was first created in the system.',
    `data_period_end_date` DATE COMMENT 'The end date of the time period covered by the data analyzed in this insight (e.g., the end of the observation window for audience behavior).',
    `data_period_start_date` DATE COMMENT 'The start date of the time period covered by the data analyzed in this insight (e.g., the beginning of the observation window for audience behavior).',
    `data_sources` STRING COMMENT 'Comma-separated list or narrative description of the data sources used to generate this insight (e.g., first-party CRM, third-party DMP feeds, Nielsen panel data, Comscore digital measurement, social listening platforms).',
    `delivery_date` DATE COMMENT 'The date when the insight deliverable was delivered to the client or made available for activation.',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the insight deliverable: draft (work in progress), in_review (under internal or client review), approved (finalized and approved), delivered (sent to client), or archived (historical record).. Valid values are `draft|in_review|approved|delivered|archived`',
    `demographic_focus` STRING COMMENT 'Description of the primary demographic characteristics of the audience analyzed (e.g., age range, gender, income level, education level).',
    `geographic_scope` STRING COMMENT 'Description of the geographic coverage of the audience analyzed (e.g., USA, CAN, GBR, or multi-market). Use ISO 3166-1 alpha-3 country codes where applicable.',
    `insight_code` STRING COMMENT 'Unique business identifier or code assigned to the insight deliverable for tracking and reference across systems and client reports.',
    `insight_name` STRING COMMENT 'Business-friendly name of the audience insight deliverable, used for identification and reference in client communications and internal tracking.',
    `insight_type` STRING COMMENT 'Classification of the insight based on the analytical focus: behavioral (actions and interactions), psychographic (attitudes and values), media consumption (channel and content preferences), purchase journey (path to conversion), cross-device (multi-device behavior), or seasonal (time-based patterns).. Valid values are `behavioral|psychographic|media_consumption|purchase_journey|cross_device|seasonal`',
    `insight_version` STRING COMMENT 'Version number of the insight deliverable, incremented when the insight is revised or updated based on new data or client feedback.',
    `internal_notes` STRING COMMENT 'Internal notes and comments from the analytics team regarding the insight development process, data quality issues, or methodological considerations.',
    `key_findings` STRING COMMENT 'Narrative summary of the primary audience behaviors, preferences, media consumption patterns, and purchase journey insights discovered through the analysis. Core deliverable content.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this audience insight record was last modified or updated.',
    `persona_implications` STRING COMMENT 'Description of how the insight findings inform or refine the understanding of target audience personas, including behavioral traits, motivations, and media habits.',
    `sample_size` BIGINT COMMENT 'The number of data points, individuals, or observations included in the analysis sample used to generate this insight.',
    CONSTRAINT pk_audience_insight PRIMARY KEY(`audience_insight_id`)
) COMMENT 'Master record for an audience insight deliverable produced by the analytics team — synthesizing first-party, second-party, and third-party data to characterize target audience behaviors, preferences, media consumption patterns, and purchase journeys. Captures insight name, client and brand references, audience segment references, insight type (behavioral, psychographic, media consumption, purchase journey, cross-device, seasonal), data sources used, analysis methodology, key audience findings narrative, persona implications, activation recommendations, analyst owner, and delivery status. Distinct from audience.persona (operational targeting persona) — this is the analytical insight output layer.';

CREATE OR REPLACE TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` (
    `creative_effectiveness_study_id` BIGINT COMMENT 'Unique identifier for the creative effectiveness study. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser client for whom this creative effectiveness study is conducted.',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: Creative effectiveness study ownership tracks the analyst responsible for study design, vendor management, and insights delivery. Essential for client relationship management, quality control, and ana',
    `analytics_request_id` BIGINT COMMENT 'Foreign key linking to analytics.analytics_request. Business justification: Creative effectiveness studies can be commissioned via analytics requests. The analytics_request captures the client need for creative testing; the creative_effectiveness_study is the deliverable that',
    `brand_brand_profile_id` BIGINT COMMENT 'Reference to the specific brand being studied in this creative effectiveness analysis.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Creative effectiveness studies measure how well creative assets perform for specific brands. The existing brand_id (unlinked) should be replaced with brand_profile_id FK to brand.brand_profile. This e',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign whose creative assets are being evaluated in this study.',
    `concept_id` BIGINT COMMENT 'Foreign key linking to creative.concept. Business justification: Pre-production concept testing evaluates multiple concepts before full asset production. Studies score concepts on effectiveness dimensions to select winners. Common in high-investment campaigns to re',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Creative effectiveness studies are research products with vendor costs and internal labor that agencies track to cost centers for budget management and practice profitability reporting.',
    `creative_asset_id` BIGINT COMMENT 'Foreign key linking to creative.creative_asset. Business justification: Creative effectiveness studies evaluate specific assets for message clarity, emotional resonance, brand linkage, and visual attention scores. Every study must reference the tested asset(s). Core measu',
    `creative_brief_id` BIGINT COMMENT 'Foreign key linking to creative.creative_brief. Business justification: Studies measure creative execution against original brief objectives, target audience definitions, and key messages. Essential for assessing brief-to-execution alignment and informing future brief dev',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Creative effectiveness studies evaluate creative assets produced within initiatives. Results inform creative optimization and demonstrate creative quality to clients. Linking studies to initiatives co',
    `measurement_plan_id` BIGINT COMMENT 'Foreign key linking to analytics.measurement_plan. Business justification: Creative effectiveness studies are executed based on measurement plans. The measurement plan defines the creative dimensions to evaluate, sample definition, and measurement methodology that the creati',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Creative effectiveness studies evaluate creative performance within media plans. Studies inform creative optimization and rotation strategy. Links creative testing to plan context.',
    `video_completion_event_id` BIGINT COMMENT 'Foreign key linking to performance.video_completion_event. Business justification: Creative effectiveness studies sample specific video completion events to analyze engagement patterns by creative variant. Studies measure completion rates, quartile drop-off, and attention metrics fr',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Creative effectiveness studies are analytics deliverables specified in SOWs with defined methodologies and budgets. Essential for fulfilling contracted creative research obligations.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Creative effectiveness varies by vendor/publisher context (premium vs programmatic, editorial vs UGC); studies track performance by placement vendor to optimize creative-vendor pairing.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_contract. Business justification: Creative testing vendors work under vendor contracts that define pricing and deliverables. Critical for managing external research vendors and tracking study costs.',
    `prior_creative_effectiveness_study_id` BIGINT COMMENT 'Self-referencing FK on creative_effectiveness_study (prior_creative_effectiveness_study_id)',
    `benchmark_comparison` STRING COMMENT 'Comparison of study results against industry benchmarks, category norms, or historical brand performance to provide context for the findings.',
    `brand_linkage_score` DECIMAL(18,2) COMMENT 'Quantitative score measuring how strongly the creative is associated with the brand in the minds of the audience.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the creative effectiveness study record was first created in the system.',
    `creative_dimensions_evaluated` STRING COMMENT 'List of creative dimensions and attributes measured in the study (e.g., message clarity, emotional resonance, brand linkage, call-to-action effectiveness, visual attention, memorability, persuasion).',
    `cta_effectiveness_score` DECIMAL(18,2) COMMENT 'Quantitative score measuring how effectively the creative drives the desired audience action or response.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the study cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `emotional_resonance_score` DECIMAL(18,2) COMMENT 'Quantitative score measuring the emotional impact and connection the creative generates with the audience.',
    `executive_summary` STRING COMMENT 'High-level executive summary of the creative effectiveness study for client presentation and stakeholder communication.',
    `key_findings` STRING COMMENT 'Summary of the primary insights and conclusions from the creative effectiveness study, including strengths and weaknesses of the creative execution.',
    `message_clarity_score` DECIMAL(18,2) COMMENT 'Quantitative score measuring how clearly the creative communicates its intended message to the target audience.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the creative effectiveness study record was last modified or updated.',
    `optimization_recommendations` STRING COMMENT 'Actionable recommendations for improving creative performance based on study findings, including suggested changes to messaging, visuals, format, or targeting.',
    `overall_effectiveness_score` DECIMAL(18,2) COMMENT 'Composite quantitative score representing the overall creative effectiveness across all measured dimensions.',
    `report_url` STRING COMMENT 'URL or file path to the full creative effectiveness study report and deliverables.',
    `sample_definition` STRING COMMENT 'Description of the target audience and sampling criteria used for the study (demographics, psychographics, behavioral qualifications).',
    `sample_size` STRING COMMENT 'Total number of respondents or observations included in the creative effectiveness study.',
    `study_code` STRING COMMENT 'Unique business identifier or code assigned to the study for tracking and reference purposes.',
    `study_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for conducting the creative effectiveness study, including vendor fees, incentives, and internal resource costs.',
    `study_end_date` DATE COMMENT 'Date when the creative effectiveness study fieldwork or data collection was completed.',
    `study_methodology` STRING COMMENT 'Primary research methodology used to measure creative effectiveness (e.g., eye-tracking, biometric response, survey-based testing, in-market performance analysis, AI creative scoring, or mixed methods).. Valid values are `eye-tracking|biometric|survey-based|in-market performance|AI creative scoring|mixed methods`',
    `study_name` STRING COMMENT 'Business name or title of the creative effectiveness study.',
    `study_start_date` DATE COMMENT 'Date when the creative effectiveness study fieldwork or data collection began.',
    `study_status` STRING COMMENT 'Current lifecycle status of the creative effectiveness study.. Valid values are `planned|in progress|completed|cancelled|on hold`',
    `study_type` STRING COMMENT 'Classification of the study timing and design (pre-test before launch, post-test after campaign, continuous tracking, A/B test, or multivariate test).. Valid values are `pre-test|post-test|continuous tracking|A/B test|multivariate test`',
    `visual_attention_score` DECIMAL(18,2) COMMENT 'Quantitative score measuring the level of visual attention and engagement the creative captures from the audience.',
    CONSTRAINT pk_creative_effectiveness_study PRIMARY KEY(`creative_effectiveness_study_id`)
) COMMENT 'Master record for a creative effectiveness study measuring the performance and impact of creative executions on audience engagement, brand metrics, and business outcomes. Captures study name, client and brand references, campaign and creative asset references, study methodology (eye-tracking, biometric, survey-based, in-market performance analysis, AI creative scoring), creative dimensions evaluated (message clarity, emotional resonance, brand linkage, call-to-action effectiveness, visual attention), study provider, sample definition, key findings by creative element, optimization recommendations, and analyst owner. The SSOT for creative analytics and effectiveness measurement.';

CREATE OR REPLACE TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` (
    `budget_optimization_scenario_id` BIGINT COMMENT 'Unique identifier for the budget optimization scenario record. Primary key.',
    `ad_channel_id` BIGINT COMMENT 'Foreign key linking to media.ad_channel. Business justification: Budget scenarios allocate spend across channels based on ROI curves. Scenario recommendations specify channel-level budget allocation. Links optimization to channels.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser (client) for whom this budget optimization scenario was created.',
    `analytics_request_id` BIGINT COMMENT 'Foreign key linking to analytics.analytics_request. Business justification: Budget optimization scenarios can be produced in response to analytics requests. The analytics_request captures the client need for budget optimization recommendations; the budget_optimization_scenari',
    `attribution_study_id` BIGINT COMMENT 'Reference to the attribution study that informed this budget optimization scenario, if applicable.',
    `baseline_scenario_id` BIGINT COMMENT 'Reference to the baseline or comparison scenario against which this optimization scenario is evaluated.',
    `client_brand_id` BIGINT COMMENT 'Reference to the specific client brand associated with this optimization scenario.',
    `creative_brief_id` BIGINT COMMENT 'Foreign key linking to creative.creative_brief. Business justification: Optimization scenarios recommend budget allocations that must align with brief objectives, deliverable requirements, and production constraints. Scenarios reference briefs to ensure recommended alloca',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Budget optimization scenarios model allocation strategies for specific client budgets and must reference the budget being optimized to support budget planning, reallocation decisions, and scenario com',
    `incrementality_test_id` BIGINT COMMENT 'Reference to the incrementality test that informed or validated this budget optimization scenario, if applicable.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Budget optimization scenarios model allocation strategies for specific initiatives. Planners use scenarios to optimize initiative budgets across channels. Linking scenarios to initiatives enables trac',
    `mmm_study_id` BIGINT COMMENT 'Reference to the Media Mix Model study that generated or informed this budget optimization scenario.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Budget optimization scenarios recommend media plan budget allocation across channels. Scenarios drive plan budget decisions and reforecasting. Links optimization recommendations to plan.',
    `revenue_target_id` BIGINT COMMENT 'Foreign key linking to client.client_revenue_target. Business justification: Budget optimization scenarios are built to achieve client revenue targets. Links scenario to target enables tracking whether recommended allocations align with contracted revenue goals—essential for a',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Budget optimization scenarios are strategic planning deliverables specified in SOWs with defined methodologies and delivery schedules. Critical for delivering contracted planning work.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Budget optimization scenarios recommend vendor mix based on historical performance, cost efficiency, and incremental contribution to maximize ROI. Core planning output for vendor budget allocation.',
    `worker_id` BIGINT COMMENT 'Reference to the analytics team member who created and owns this budget optimization scenario.',
    `baseline_budget_optimization_scenario_id` BIGINT COMMENT 'Self-referencing FK on budget_optimization_scenario (baseline_budget_optimization_scenario_id)',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `client_approval_date` DATE COMMENT 'Date on which the client approved this budget optimization scenario.',
    `client_approval_status` STRING COMMENT 'Approval status from the client for this budget optimization scenario recommendation.. Valid values are `pending|approved|rejected|changes_requested`',
    `client_approved_by` STRING COMMENT 'Name or identifier of the client stakeholder who approved this scenario.',
    `confidence_level_lower_bound` DECIMAL(18,2) COMMENT 'Lower bound of the confidence interval for the projected outcomes, expressed as a percentage (e.g., 85.00 for 85%).',
    `confidence_level_upper_bound` DECIMAL(18,2) COMMENT 'Upper bound of the confidence interval for the projected outcomes, expressed as a percentage (e.g., 95.00 for 95%).',
    `constraints_applied` STRING COMMENT 'Description of budget constraints applied in the optimization (e.g., channel floor/ceiling limits, minimum spend requirements, exclusions).',
    `implementation_start_date` DATE COMMENT 'Date on which the recommended budget allocation from this scenario began to be implemented in live campaigns.',
    `model_version` STRING COMMENT 'Version identifier of the analytical model (MMM, attribution, or optimization algorithm) used to generate this scenario.',
    `notes` STRING COMMENT 'Additional notes, comments, or context about this budget optimization scenario for internal reference.',
    `optimization_objective` STRING COMMENT 'The primary business objective this scenario is optimizing for (e.g., maximize ROAS, minimize CPA, maximize reach). [ENUM-REF-CANDIDATE: maximize_reach|maximize_conversions|maximize_revenue|minimize_cpa|maximize_roas|maximize_brand_awareness|maximize_engagement|minimize_cpm — 8 candidates stripped; promote to reference product]',
    `planning_period_end_date` DATE COMMENT 'The end date of the planning period for which this budget optimization scenario applies.',
    `planning_period_start_date` DATE COMMENT 'The start date of the planning period for which this budget optimization scenario applies.',
    `presentation_delivered_date` DATE COMMENT 'Date on which this budget optimization scenario was formally presented to the client.',
    `projected_conversions` BIGINT COMMENT 'Estimated total conversions projected for this budget allocation scenario.',
    `projected_cpa` DECIMAL(18,2) COMMENT 'Estimated Cost Per Acquisition projected for this budget allocation scenario.',
    `projected_cpm` DECIMAL(18,2) COMMENT 'Estimated Cost Per Thousand Impressions projected for this budget allocation scenario.',
    `projected_impressions` BIGINT COMMENT 'Estimated total impressions projected for this budget allocation scenario.',
    `projected_reach` BIGINT COMMENT 'Estimated total unique audience reach projected for this budget allocation scenario.',
    `projected_revenue` DECIMAL(18,2) COMMENT 'Estimated total revenue projected to be generated from this budget allocation scenario.',
    `projected_roas` DECIMAL(18,2) COMMENT 'Estimated Return on Ad Spend ratio projected for this budget allocation scenario (revenue divided by spend).',
    `recommendation_summary` STRING COMMENT 'Executive summary of the budget allocation recommendations and expected outcomes for client presentation.',
    `scenario_code` STRING COMMENT 'Short alphanumeric code or identifier for the scenario, used for internal tracking and reporting.',
    `scenario_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget optimization scenario record was first created in the system.',
    `scenario_description` STRING COMMENT 'Detailed narrative description of the budget optimization scenario, including key assumptions, methodology, and strategic rationale.',
    `scenario_name` STRING COMMENT 'Business-friendly name for the budget optimization scenario (e.g., Q4 2024 ROAS Maximization, Brand Awareness Reach Optimization).',
    `scenario_status` STRING COMMENT 'Current lifecycle status of the budget optimization scenario in the approval and implementation workflow.. Valid values are `draft|under_review|approved|rejected|implemented|archived`',
    `scenario_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget optimization scenario record was last modified.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'The total budget constraint for this optimization scenario, representing the maximum investment amount available for allocation.',
    CONSTRAINT pk_budget_optimization_scenario PRIMARY KEY(`budget_optimization_scenario_id`)
) COMMENT 'Master record for a budget optimization scenario or media investment recommendation produced by the analytics team — typically derived from MMM outputs, incrementality tests, or scenario planning models. Captures scenario name, client and brand references, linked MMM study or attribution study, optimization objective (maximize reach, maximize conversions, maximize revenue, minimize CPA, maximize ROAS), budget constraint (total budget, channel floor/ceiling), recommended channel allocation by channel and tactic, projected outcome estimates, scenario comparison baseline, confidence range, analyst owner, and client approval status. The SSOT for data-driven budget recommendation deliverables.';

CREATE OR REPLACE TABLE `advertising_ecm`.`analytics`.`analytics_request` (
    `analytics_request_id` BIGINT COMMENT 'Unique identifier for the analytics request. Primary key for the analytics request entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client who submitted the analytics request. Links to the client master entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Analytics requests are commissioned under master service agreements that define scope, pricing, and deliverables for analytics services. Essential for tracking analytics work against contractual terms',
    `brand_profile_id` BIGINT COMMENT 'Reference to the brand associated with this analytics request. Links to the brand master entity.',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign associated with this analytics request. Links to the campaign master entity. Nullable for non-campaign-specific requests.',
    `client_brief_id` BIGINT COMMENT 'Foreign key linking to client.client_brief. Business justification: Client briefs trigger analytics requests for campaign measurement planning and performance analysis. Links request to originating brief, enabling traceability from client requirements to analytics del',
    `client_contact_id` BIGINT COMMENT 'Foreign key linking to client.client_contact. Business justification: Analytics requests are submitted by specific client contacts. Structured FK enables tracking which stakeholders request analytics, supports workload analysis by contact, and replaces denormalized requ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Analytics requests are work intake records tracked to cost centers for capacity planning, internal cost allocation, billable vs non-billable analysis, and resource utilization reporting in agency oper',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Analytics requests are often scoped to specific initiatives - project teams request analysis of their initiatives performance. Linking requests to initiatives enables tracking analytical support per ',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Analytics requests are scoped within specific SOWs that define analytics deliverables, budgets, and timelines. Critical for tracking analytics work against SOW commitments and managing project scope.',
    `worker_id` BIGINT COMMENT 'Reference to the analyst assigned to fulfill this analytics request. Links to the talent or employee master entity.',
    `follow_up_analytics_request_id` BIGINT COMMENT 'Self-referencing FK on analytics_request (follow_up_analytics_request_id)',
    `actual_delivery_date` DATE COMMENT 'Actual date when the analytics request was delivered to the requestor. Nullable if not yet delivered.',
    `actual_effort_hours` DECIMAL(18,2) COMMENT 'Actual effort in hours spent to complete the analytics request. Used for performance tracking and future estimation accuracy.',
    `analysis_period_end_date` DATE COMMENT 'End date of the time period covered by the analytics request analysis.',
    `analysis_period_start_date` DATE COMMENT 'Start date of the time period covered by the analytics request analysis.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the analytics request is billable to the client or is part of included services. True if billable, False if non-billable.',
    `cancellation_reason` STRING COMMENT 'Explanation or reason provided when an analytics request is cancelled. Nullable if not cancelled.',
    `client_satisfaction_rating` STRING COMMENT 'Client satisfaction rating for the delivered analytics request, typically on a scale of 1 to 5. Nullable if feedback not yet collected.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this analytics request record was first created in the system. Audit trail for record creation.',
    `data_sources_required` STRING COMMENT 'List or description of data sources needed to fulfill the analytics request, such as campaign performance data, audience data, competitive intelligence feeds, or third-party data.',
    `deliverable_type` STRING COMMENT 'Format or type of the final deliverable produced for the analytics request.. Valid values are `report|dashboard|presentation|data export|model|insight document`',
    `deliverable_url` STRING COMMENT 'URL or file path to the final deliverable output such as a report, dashboard, or presentation. Nullable if not yet delivered or if physical delivery.',
    `effort_estimate_hours` DECIMAL(18,2) COMMENT 'Estimated effort in hours required to complete the analytics request. Used for resource planning and capacity management.',
    `internal_notes` STRING COMMENT 'Internal notes or comments from the analytics team regarding the request, challenges encountered, or lessons learned.',
    `key_findings_summary` STRING COMMENT 'Executive summary of the key findings, insights, or recommendations from the analytics request. Populated upon completion.',
    `kpi_measured` STRING COMMENT 'Primary KPI or metrics measured and analyzed in this analytics request, such as ROAS, CTR, CPA, brand lift, or audience reach.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this analytics request record was last modified. Audit trail for record updates.',
    `priority_tier` STRING COMMENT 'Priority classification of the request. P1 indicates urgent, P2 indicates standard, P3 indicates low priority. Determines resource allocation and scheduling.. Valid values are `P1|P2|P3`',
    `request_number` STRING COMMENT 'Externally-known unique business identifier for the analytics request. Used for tracking and communication with clients and internal teams.. Valid values are `^ANR-[0-9]{6,10}$`',
    `request_status` STRING COMMENT 'Current lifecycle status of the analytics request in the workflow. Tracks progression from intake through delivery.. Valid values are `submitted|scoped|in-progress|in-review|delivered|cancelled`',
    `request_type` STRING COMMENT 'Classification of the analytics request type. MMM refers to Media Mix Model. Determines the analytical approach and resource allocation.. Valid values are `ad-hoc analysis|dashboard build|MMM|attribution study|audience insight|competitive intelligence`',
    `requested_delivery_date` DATE COMMENT 'Target delivery date requested by the client or internal team for completion of the analytics request.',
    `requestor_type` STRING COMMENT 'Classification indicating whether the requestor is a client contact or an internal agency team member.. Valid values are `client|internal`',
    `review_started_timestamp` TIMESTAMP COMMENT 'Date and time when the analytics deliverable entered the review phase. Nullable if not yet in review.',
    `scope_description` STRING COMMENT 'Detailed description of the analytics request scope, objectives, deliverables, and any specific requirements or constraints provided by the requestor.',
    `scoping_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the scoping phase of the analytics request was completed. Nullable if not yet scoped.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the analytics request was originally submitted by the requestor. Represents the business event timestamp for intake.',
    `title` STRING COMMENT 'Short descriptive title of the analytics request provided by the requestor.',
    `work_started_timestamp` TIMESTAMP COMMENT 'Date and time when analytical work on the request was started. Nullable if not yet started.',
    CONSTRAINT pk_analytics_request PRIMARY KEY(`analytics_request_id`)
) COMMENT 'Transactional record capturing ad-hoc and project-based analytics requests submitted by clients or internal agency teams to the analytics function. Captures request title, request type (ad-hoc analysis, dashboard build, MMM, attribution study, audience insight, competitive intelligence, creative effectiveness), requestor (client contact or internal team), priority tier (P1 urgent, P2 standard, P3 low), requested delivery date, assigned analyst, scope description, linked campaign or brand references, request status (submitted, scoped, in-progress, in-review, delivered, cancelled), actual delivery date, and effort estimate in hours. The operational intake and workflow management record for the analytics team.';

CREATE OR REPLACE TABLE `advertising_ecm`.`analytics`.`recipient_group` (
    `recipient_group_id` BIGINT COMMENT 'Primary key for recipient_group',
    `advertiser_id` BIGINT COMMENT 'Reference to the client organization that owns or commissioned this recipient group.',
    `campaign_id` BIGINT COMMENT 'Reference to the primary campaign associated with this recipient group.',
    `worker_id` BIGINT COMMENT 'Reference to the user or team member responsible for managing this recipient group.',
    `parent_recipient_group_id` BIGINT COMMENT 'Self-referencing FK on recipient_group (parent_recipient_group_id)',
    `archived_timestamp` TIMESTAMP COMMENT 'Date and time when this recipient group was archived or deactivated.',
    `channel_preference` STRING COMMENT 'Preferred communication channel for reaching recipients in this group.',
    `recipient_group_code` STRING COMMENT 'Unique business code or identifier for the recipient group used in external systems and reporting.',
    `consent_level` STRING COMMENT 'Level of consent obtained from recipients in this group for marketing communications.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this recipient group record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for monetary values associated with this recipient group.',
    `recipient_group_description` STRING COMMENT 'Detailed business description of the recipient group, including segmentation criteria and intended use cases.',
    `effective_end_date` DATE COMMENT 'Date when this recipient group expires or is no longer valid for campaign targeting.',
    `effective_start_date` DATE COMMENT 'Date when this recipient group becomes active and available for use in campaigns.',
    `estimated_reach` BIGINT COMMENT 'Projected number of unique recipients that can be reached through this group across all channels.',
    `estimated_value` DECIMAL(18,2) COMMENT 'Estimated total business value or revenue potential of this recipient group.',
    `geographic_scope` STRING COMMENT 'Geographic region or market that this recipient group targets, using 3-letter country codes or region identifiers.',
    `is_dynamic` BOOLEAN COMMENT 'Indicates whether the recipient group membership is dynamically updated based on criteria (true) or is a static list (false).',
    `is_suppression_list` BOOLEAN COMMENT 'Indicates whether this recipient group is used as a suppression or exclusion list to prevent message delivery.',
    `language_preference` STRING COMMENT 'Primary language preference for communications to recipients in this group, using ISO 639-1 language codes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this recipient group record was last updated or modified.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Date and time when the recipient group membership was last refreshed or recalculated.',
    `member_count` BIGINT COMMENT 'Total number of individual recipients currently included in this group.',
    `recipient_group_name` STRING COMMENT 'Human-readable name of the recipient group used for identification and display purposes.',
    `next_refresh_timestamp` TIMESTAMP COMMENT 'Scheduled date and time for the next refresh of the recipient group membership.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or context about this recipient group.',
    `opt_in_required` BOOLEAN COMMENT 'Indicates whether explicit opt-in consent is required for recipients in this group to receive communications.',
    `priority_level` STRING COMMENT 'Business priority level assigned to this recipient group for campaign targeting and resource allocation.',
    `refresh_frequency` STRING COMMENT 'Frequency at which the recipient group membership is updated or refreshed based on segmentation criteria.',
    `segmentation_criteria` STRING COMMENT 'Detailed criteria and rules used to define membership in this recipient group, including filters, conditions, and logic.',
    `source_list_code` STRING COMMENT 'External identifier of the source list or audience segment in the originating system.',
    `source_system` STRING COMMENT 'Name of the originating system or platform from which this recipient group was created or imported.',
    `recipient_group_status` STRING COMMENT 'Current lifecycle status of the recipient group indicating whether it is actively used in campaigns.',
    `tags` STRING COMMENT 'Comma-separated list of business tags or labels applied to this recipient group for categorization and filtering.',
    `target_audience_profile` STRING COMMENT 'Summary profile of the target audience characteristics for this recipient group, including key demographic and behavioral attributes.',
    `recipient_group_type` STRING COMMENT 'Classification of the recipient group based on segmentation methodology (demographic, behavioral, geographic, psychographic, custom, or lookalike).',
    CONSTRAINT pk_recipient_group PRIMARY KEY(`recipient_group_id`)
) COMMENT 'Master reference table for recipient_group. Referenced by recipient_group_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ADD CONSTRAINT `fk_analytics_insight_report_analytics_request_id` FOREIGN KEY (`analytics_request_id`) REFERENCES `advertising_ecm`.`analytics`.`analytics_request`(`analytics_request_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ADD CONSTRAINT `fk_analytics_insight_report_superseded_insight_report_id` FOREIGN KEY (`superseded_insight_report_id`) REFERENCES `advertising_ecm`.`analytics`.`insight_report`(`insight_report_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ADD CONSTRAINT `fk_analytics_mmm_study_measurement_plan_id` FOREIGN KEY (`measurement_plan_id`) REFERENCES `advertising_ecm`.`analytics`.`measurement_plan`(`measurement_plan_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ADD CONSTRAINT `fk_analytics_mmm_study_prior_mmm_study_id` FOREIGN KEY (`prior_mmm_study_id`) REFERENCES `advertising_ecm`.`analytics`.`mmm_study`(`mmm_study_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ADD CONSTRAINT `fk_analytics_attribution_study_analytics_request_id` FOREIGN KEY (`analytics_request_id`) REFERENCES `advertising_ecm`.`analytics`.`analytics_request`(`analytics_request_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ADD CONSTRAINT `fk_analytics_attribution_study_measurement_plan_id` FOREIGN KEY (`measurement_plan_id`) REFERENCES `advertising_ecm`.`analytics`.`measurement_plan`(`measurement_plan_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ADD CONSTRAINT `fk_analytics_attribution_study_prior_attribution_study_id` FOREIGN KEY (`prior_attribution_study_id`) REFERENCES `advertising_ecm`.`analytics`.`attribution_study`(`attribution_study_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_analytics_request_id` FOREIGN KEY (`analytics_request_id`) REFERENCES `advertising_ecm`.`analytics`.`analytics_request`(`analytics_request_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_cloned_from_dashboard_id` FOREIGN KEY (`cloned_from_dashboard_id`) REFERENCES `advertising_ecm`.`analytics`.`dashboard`(`dashboard_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ADD CONSTRAINT `fk_analytics_insight_finding_attribution_study_id` FOREIGN KEY (`attribution_study_id`) REFERENCES `advertising_ecm`.`analytics`.`attribution_study`(`attribution_study_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ADD CONSTRAINT `fk_analytics_insight_finding_audience_insight_id` FOREIGN KEY (`audience_insight_id`) REFERENCES `advertising_ecm`.`analytics`.`audience_insight`(`audience_insight_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ADD CONSTRAINT `fk_analytics_insight_finding_brand_lift_study_id` FOREIGN KEY (`brand_lift_study_id`) REFERENCES `advertising_ecm`.`analytics`.`brand_lift_study`(`brand_lift_study_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ADD CONSTRAINT `fk_analytics_insight_finding_competitive_intelligence_id` FOREIGN KEY (`competitive_intelligence_id`) REFERENCES `advertising_ecm`.`analytics`.`competitive_intelligence`(`competitive_intelligence_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ADD CONSTRAINT `fk_analytics_insight_finding_creative_effectiveness_study_id` FOREIGN KEY (`creative_effectiveness_study_id`) REFERENCES `advertising_ecm`.`analytics`.`creative_effectiveness_study`(`creative_effectiveness_study_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ADD CONSTRAINT `fk_analytics_insight_finding_incrementality_test_id` FOREIGN KEY (`incrementality_test_id`) REFERENCES `advertising_ecm`.`analytics`.`incrementality_test`(`incrementality_test_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ADD CONSTRAINT `fk_analytics_insight_finding_insight_report_id` FOREIGN KEY (`insight_report_id`) REFERENCES `advertising_ecm`.`analytics`.`insight_report`(`insight_report_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ADD CONSTRAINT `fk_analytics_insight_finding_mmm_study_id` FOREIGN KEY (`mmm_study_id`) REFERENCES `advertising_ecm`.`analytics`.`mmm_study`(`mmm_study_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ADD CONSTRAINT `fk_analytics_insight_finding_parent_insight_finding_id` FOREIGN KEY (`parent_insight_finding_id`) REFERENCES `advertising_ecm`.`analytics`.`insight_finding`(`insight_finding_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ADD CONSTRAINT `fk_analytics_measurement_plan_analytics_request_id` FOREIGN KEY (`analytics_request_id`) REFERENCES `advertising_ecm`.`analytics`.`analytics_request`(`analytics_request_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ADD CONSTRAINT `fk_analytics_measurement_plan_superseded_measurement_plan_id` FOREIGN KEY (`superseded_measurement_plan_id`) REFERENCES `advertising_ecm`.`analytics`.`measurement_plan`(`measurement_plan_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ADD CONSTRAINT `fk_analytics_brand_lift_study_analytics_request_id` FOREIGN KEY (`analytics_request_id`) REFERENCES `advertising_ecm`.`analytics`.`analytics_request`(`analytics_request_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ADD CONSTRAINT `fk_analytics_brand_lift_study_measurement_plan_id` FOREIGN KEY (`measurement_plan_id`) REFERENCES `advertising_ecm`.`analytics`.`measurement_plan`(`measurement_plan_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ADD CONSTRAINT `fk_analytics_brand_lift_study_prior_brand_lift_study_id` FOREIGN KEY (`prior_brand_lift_study_id`) REFERENCES `advertising_ecm`.`analytics`.`brand_lift_study`(`brand_lift_study_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ADD CONSTRAINT `fk_analytics_incrementality_test_analytics_request_id` FOREIGN KEY (`analytics_request_id`) REFERENCES `advertising_ecm`.`analytics`.`analytics_request`(`analytics_request_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ADD CONSTRAINT `fk_analytics_incrementality_test_measurement_plan_id` FOREIGN KEY (`measurement_plan_id`) REFERENCES `advertising_ecm`.`analytics`.`measurement_plan`(`measurement_plan_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ADD CONSTRAINT `fk_analytics_incrementality_test_prior_incrementality_test_id` FOREIGN KEY (`prior_incrementality_test_id`) REFERENCES `advertising_ecm`.`analytics`.`incrementality_test`(`incrementality_test_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ADD CONSTRAINT `fk_analytics_report_schedule_dashboard_id` FOREIGN KEY (`dashboard_id`) REFERENCES `advertising_ecm`.`analytics`.`dashboard`(`dashboard_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ADD CONSTRAINT `fk_analytics_report_schedule_insight_report_id` FOREIGN KEY (`insight_report_id`) REFERENCES `advertising_ecm`.`analytics`.`insight_report`(`insight_report_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ADD CONSTRAINT `fk_analytics_report_schedule_recipient_group_id` FOREIGN KEY (`recipient_group_id`) REFERENCES `advertising_ecm`.`analytics`.`recipient_group`(`recipient_group_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ADD CONSTRAINT `fk_analytics_report_schedule_superseded_report_schedule_id` FOREIGN KEY (`superseded_report_schedule_id`) REFERENCES `advertising_ecm`.`analytics`.`report_schedule`(`report_schedule_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ADD CONSTRAINT `fk_analytics_report_delivery_dashboard_id` FOREIGN KEY (`dashboard_id`) REFERENCES `advertising_ecm`.`analytics`.`dashboard`(`dashboard_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ADD CONSTRAINT `fk_analytics_report_delivery_insight_report_id` FOREIGN KEY (`insight_report_id`) REFERENCES `advertising_ecm`.`analytics`.`insight_report`(`insight_report_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ADD CONSTRAINT `fk_analytics_report_delivery_report_schedule_id` FOREIGN KEY (`report_schedule_id`) REFERENCES `advertising_ecm`.`analytics`.`report_schedule`(`report_schedule_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ADD CONSTRAINT `fk_analytics_report_delivery_redelivery_of_report_delivery_id` FOREIGN KEY (`redelivery_of_report_delivery_id`) REFERENCES `advertising_ecm`.`analytics`.`report_delivery`(`report_delivery_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ADD CONSTRAINT `fk_analytics_competitive_intelligence_analytics_request_id` FOREIGN KEY (`analytics_request_id`) REFERENCES `advertising_ecm`.`analytics`.`analytics_request`(`analytics_request_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ADD CONSTRAINT `fk_analytics_competitive_intelligence_prior_competitive_intelligence_id` FOREIGN KEY (`prior_competitive_intelligence_id`) REFERENCES `advertising_ecm`.`analytics`.`competitive_intelligence`(`competitive_intelligence_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ADD CONSTRAINT `fk_analytics_audience_insight_analytics_request_id` FOREIGN KEY (`analytics_request_id`) REFERENCES `advertising_ecm`.`analytics`.`analytics_request`(`analytics_request_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ADD CONSTRAINT `fk_analytics_audience_insight_derived_from_audience_insight_id` FOREIGN KEY (`derived_from_audience_insight_id`) REFERENCES `advertising_ecm`.`analytics`.`audience_insight`(`audience_insight_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ADD CONSTRAINT `fk_analytics_creative_effectiveness_study_analytics_request_id` FOREIGN KEY (`analytics_request_id`) REFERENCES `advertising_ecm`.`analytics`.`analytics_request`(`analytics_request_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ADD CONSTRAINT `fk_analytics_creative_effectiveness_study_measurement_plan_id` FOREIGN KEY (`measurement_plan_id`) REFERENCES `advertising_ecm`.`analytics`.`measurement_plan`(`measurement_plan_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ADD CONSTRAINT `fk_analytics_creative_effectiveness_study_prior_creative_effectiveness_study_id` FOREIGN KEY (`prior_creative_effectiveness_study_id`) REFERENCES `advertising_ecm`.`analytics`.`creative_effectiveness_study`(`creative_effectiveness_study_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ADD CONSTRAINT `fk_analytics_budget_optimization_scenario_analytics_request_id` FOREIGN KEY (`analytics_request_id`) REFERENCES `advertising_ecm`.`analytics`.`analytics_request`(`analytics_request_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ADD CONSTRAINT `fk_analytics_budget_optimization_scenario_attribution_study_id` FOREIGN KEY (`attribution_study_id`) REFERENCES `advertising_ecm`.`analytics`.`attribution_study`(`attribution_study_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ADD CONSTRAINT `fk_analytics_budget_optimization_scenario_baseline_scenario_id` FOREIGN KEY (`baseline_scenario_id`) REFERENCES `advertising_ecm`.`analytics`.`budget_optimization_scenario`(`budget_optimization_scenario_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ADD CONSTRAINT `fk_analytics_budget_optimization_scenario_incrementality_test_id` FOREIGN KEY (`incrementality_test_id`) REFERENCES `advertising_ecm`.`analytics`.`incrementality_test`(`incrementality_test_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ADD CONSTRAINT `fk_analytics_budget_optimization_scenario_mmm_study_id` FOREIGN KEY (`mmm_study_id`) REFERENCES `advertising_ecm`.`analytics`.`mmm_study`(`mmm_study_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ADD CONSTRAINT `fk_analytics_budget_optimization_scenario_baseline_budget_optimization_scenario_id` FOREIGN KEY (`baseline_budget_optimization_scenario_id`) REFERENCES `advertising_ecm`.`analytics`.`budget_optimization_scenario`(`budget_optimization_scenario_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ADD CONSTRAINT `fk_analytics_analytics_request_follow_up_analytics_request_id` FOREIGN KEY (`follow_up_analytics_request_id`) REFERENCES `advertising_ecm`.`analytics`.`analytics_request`(`analytics_request_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`recipient_group` ADD CONSTRAINT `fk_analytics_recipient_group_parent_recipient_group_id` FOREIGN KEY (`parent_recipient_group_id`) REFERENCES `advertising_ecm`.`analytics`.`recipient_group`(`recipient_group_id`);

-- ========= TAGS =========
ALTER SCHEMA `advertising_ecm`.`analytics` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `advertising_ecm`.`analytics` SET TAGS ('dbx_domain' = 'analytics');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `insight_report_id` SET TAGS ('dbx_business_glossary_term' = 'Insight Report Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `analytics_request_id` SET TAGS ('dbx_business_glossary_term' = 'Analytics Request Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Worker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `brand_brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Placement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `superseded_insight_report_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `archived_date` SET TAGS ('dbx_business_glossary_term' = 'Archived Date');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `client_feedback` SET TAGS ('dbx_business_glossary_term' = 'Client Feedback');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `data_sources` SET TAGS ('dbx_business_glossary_term' = 'Data Sources');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Distribution List');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `distribution_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `distribution_list` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `executive_summary` SET TAGS ('dbx_business_glossary_term' = 'Executive Summary');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `key_findings_narrative` SET TAGS ('dbx_business_glossary_term' = 'Key Findings Narrative');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `kpi_metrics_included` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Metrics Included');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `lead_analyst_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Analyst Name');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `methodology_notes` SET TAGS ('dbx_business_glossary_term' = 'Methodology Notes');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `owning_analyst_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Analyst Team');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `recommendations` SET TAGS ('dbx_business_glossary_term' = 'Recommendations');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `report_file_path` SET TAGS ('dbx_business_glossary_term' = 'Report File Path');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `report_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `report_format` SET TAGS ('dbx_business_glossary_term' = 'Report Format');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|delivered|archived|cancelled');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `report_title` SET TAGS ('dbx_business_glossary_term' = 'Report Title');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Tags');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `mmm_study_id` SET TAGS ('dbx_business_glossary_term' = 'Media Mix Model (MMM) Study Identifier');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `brand_brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `measurement_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Owner Identifier');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `prior_mmm_study_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|calibrated|failed|pending_review');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `commissioned_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioned Date');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `data_sources` SET TAGS ('dbx_business_glossary_term' = 'Data Sources');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'not_delivered|in_preparation|delivered|accepted|revision_requested');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `external_vendor_tool` SET TAGS ('dbx_business_glossary_term' = 'External Vendor Tool');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `granularity_level` SET TAGS ('dbx_business_glossary_term' = 'Granularity Level');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `granularity_level` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `holdout_validation_approach` SET TAGS ('dbx_business_glossary_term' = 'Holdout Validation Approach');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `holdout_validation_approach` SET TAGS ('dbx_value_regex' = 'time_based|geographic|random_sample|none');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `mape` SET TAGS ('dbx_business_glossary_term' = 'Mean Absolute Percentage Error (MAPE)');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `media_channels_included` SET TAGS ('dbx_business_glossary_term' = 'Media Channels Included');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `model_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `modeling_methodology` SET TAGS ('dbx_business_glossary_term' = 'Modeling Methodology');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `modeling_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Modeling Period End Date');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `modeling_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Modeling Period Start Date');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Study Notes');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `optimization_recommendations` SET TAGS ('dbx_business_glossary_term' = 'Optimization Recommendations');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `outcome_variable` SET TAGS ('dbx_business_glossary_term' = 'Outcome Variable');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `outcome_variable` SET TAGS ('dbx_value_regex' = 'revenue|sales_volume|leads|conversions|brand_awareness|market_share');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `r_squared` SET TAGS ('dbx_business_glossary_term' = 'R-Squared (R²) Coefficient');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `rmse` SET TAGS ('dbx_business_glossary_term' = 'Root Mean Squared Error (RMSE)');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `study_code` SET TAGS ('dbx_business_glossary_term' = 'Study Code');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `study_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `study_name` SET TAGS ('dbx_business_glossary_term' = 'Study Name');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Status');
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `attribution_study_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Study Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `analytics_request_id` SET TAGS ('dbx_business_glossary_term' = 'Analytics Request Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `brand_brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `measurement_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Owner Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `prior_attribution_study_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `attribution_methodology` SET TAGS ('dbx_business_glossary_term' = 'Attribution Methodology');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `conversion_events_measured` SET TAGS ('dbx_business_glossary_term' = 'Conversion Events Measured');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `data_sources_integrated` SET TAGS ('dbx_business_glossary_term' = 'Data Sources Integrated');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `key_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Key Findings Summary');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `measurement_window_days` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window (Days)');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `model_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Model Confidence Score');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `model_training_end_date` SET TAGS ('dbx_business_glossary_term' = 'Model Training End Date');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `model_training_start_date` SET TAGS ('dbx_business_glossary_term' = 'Model Training Start Date');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Study Notes');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `platform_tool_used` SET TAGS ('dbx_business_glossary_term' = 'Platform or Tool Used');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `report_url` SET TAGS ('dbx_business_glossary_term' = 'Report Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `roas_overall` SET TAGS ('dbx_business_glossary_term' = 'Return on Ad Spend (ROAS) Overall');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `study_code` SET TAGS ('dbx_business_glossary_term' = 'Attribution Study Code');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `study_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `study_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Study Completion Date');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `study_name` SET TAGS ('dbx_business_glossary_term' = 'Attribution Study Name');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `study_start_date` SET TAGS ('dbx_business_glossary_term' = 'Study Start Date');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Attribution Study Status');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Attribution Study Type');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'multi_touch_attribution|unified_measurement|media_mix_model|incrementality_test|cross_channel_attribution|single_touch_attribution');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `top_performing_channel` SET TAGS ('dbx_business_glossary_term' = 'Top Performing Channel');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `total_conversions_attributed` SET TAGS ('dbx_business_glossary_term' = 'Total Conversions Attributed');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `total_revenue_attributed` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue Attributed');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `validation_approach` SET TAGS ('dbx_business_glossary_term' = 'Validation Approach');
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ALTER COLUMN `validation_approach` SET TAGS ('dbx_value_regex' = 'holdout_validation|cross_validation|backtesting|a_b_test|control_group|none');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `dashboard_id` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `analytics_request_id` SET TAGS ('dbx_business_glossary_term' = 'Analytics Request Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `contract_template_id` SET TAGS ('dbx_business_glossary_term' = 'Template Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `dashboard_created_by_user_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `dashboard_last_modified_by_user_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `dashboard_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Owning Analyst Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Placement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `cloned_from_dashboard_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `access_tier` SET TAGS ('dbx_business_glossary_term' = 'Access Tier');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `access_tier` SET TAGS ('dbx_value_regex' = 'client_facing|internal_only|executive_only|restricted');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_requested');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `dashboard_code` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Code');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `dashboard_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `dashboard_description` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Description');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `dashboard_name` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Name');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `dashboard_type` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Type');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `dashboard_type` SET TAGS ('dbx_value_regex' = 'campaign_performance|brand_health|audience_insights|executive_summary|media_mix|competitive_sov');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `data_sources` SET TAGS ('dbx_business_glossary_term' = 'Data Sources');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `deprecated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deprecated Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated Flag');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `is_client_shared` SET TAGS ('dbx_business_glossary_term' = 'Is Client Shared Flag');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `last_validated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Validated Date');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Notes');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `platform_tool` SET TAGS ('dbx_business_glossary_term' = 'Platform Tool');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `primary_kpi` SET TAGS ('dbx_business_glossary_term' = 'Primary Key Performance Indicator (KPI)');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `publication_status` SET TAGS ('dbx_business_glossary_term' = 'Publication Status');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `publication_status` SET TAGS ('dbx_value_regex' = 'development|uat|live|deprecated|archived');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `refresh_cadence` SET TAGS ('dbx_business_glossary_term' = 'Refresh Cadence');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `refresh_cadence` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly|monthly|on_demand');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Tags');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Version');
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^v?[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `insight_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Insight Finding Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Owner Worker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `attribution_study_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Study Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `audience_insight_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Insight Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `brand_lift_study_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Lift Study Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `competitive_intelligence_id` SET TAGS ('dbx_business_glossary_term' = 'Competitive Intelligence Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `contract_deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `creative_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `creative_effectiveness_study_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Effectiveness Study Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `incrementality_test_id` SET TAGS ('dbx_business_glossary_term' = 'Incrementality Test Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `insight_report_id` SET TAGS ('dbx_business_glossary_term' = 'Insight Report Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Placement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `mmm_study_id` SET TAGS ('dbx_business_glossary_term' = 'Mmm Study Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `parent_insight_finding_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `business_impact_classification` SET TAGS ('dbx_business_glossary_term' = 'Business Impact Classification');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `business_impact_classification` SET TAGS ('dbx_value_regex' = 'revenue|efficiency|brand equity|risk|customer acquisition|customer retention');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Media Channel');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `client_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Visibility Flag');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `creative_element` SET TAGS ('dbx_business_glossary_term' = 'Creative Element');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `finding_narrative` SET TAGS ('dbx_business_glossary_term' = 'Finding Narrative');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_value_regex' = 'draft|under review|approved|published|archived');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `finding_title` SET TAGS ('dbx_business_glossary_term' = 'Finding Title');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'audience insight|channel effectiveness|creative performance|budget optimization recommendation|brand health signal|competitive threat');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `impact_value_unit` SET TAGS ('dbx_business_glossary_term' = 'Impact Value Unit of Measure');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `kpi_impacted` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Impacted');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Analysis Methodology');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Priority Tier');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `priority_tier` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `quantified_impact_value` SET TAGS ('dbx_business_glossary_term' = 'Quantified Impact Value');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `related_finding_ids` SET TAGS ('dbx_business_glossary_term' = 'Related Finding Identifiers (IDs)');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `reusability_score` SET TAGS ('dbx_business_glossary_term' = 'Reusability Score');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `statistical_significance` SET TAGS ('dbx_business_glossary_term' = 'Statistical Significance Level');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `supporting_evidence_summary` SET TAGS ('dbx_business_glossary_term' = 'Supporting Evidence Summary');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Finding Tags');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `time_period_end` SET TAGS ('dbx_business_glossary_term' = 'Time Period End Date');
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ALTER COLUMN `time_period_start` SET TAGS ('dbx_business_glossary_term' = 'Time Period Start Date');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `measurement_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Plan Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `analytics_request_id` SET TAGS ('dbx_business_glossary_term' = 'Analytics Request Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Worker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `client_onboarding_id` SET TAGS ('dbx_business_glossary_term' = 'Client Onboarding Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `superseded_measurement_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `analyst_owner` SET TAGS ('dbx_business_glossary_term' = 'Analyst Owner');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|revision_requested|finalized');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `attribution_window_days` SET TAGS ('dbx_business_glossary_term' = 'Attribution Window (Days)');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `baseline_benchmark` SET TAGS ('dbx_business_glossary_term' = 'Baseline Benchmark');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Statistical Confidence Level');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Measurement Cost Estimate');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `data_collection_approach` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Approach');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `data_sources` SET TAGS ('dbx_business_glossary_term' = 'Data Sources');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `deliverable_format` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Format');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `deliverable_format` SET TAGS ('dbx_value_regex' = 'dashboard|pdf_report|powerpoint|excel|api|custom');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `holdout_test_design` SET TAGS ('dbx_business_glossary_term' = 'Holdout Test Design');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `measurement_objective` SET TAGS ('dbx_business_glossary_term' = 'Measurement Objective');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `measurement_vendor` SET TAGS ('dbx_business_glossary_term' = 'Measurement Vendor');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `measurement_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window End Date');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `measurement_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window Start Date');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'active|completed|on_hold|cancelled|archived');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `primary_kpi` SET TAGS ('dbx_business_glossary_term' = 'Primary Key Performance Indicator (KPI)');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `reporting_cadence` SET TAGS ('dbx_business_glossary_term' = 'Reporting Cadence');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `revision_notes` SET TAGS ('dbx_business_glossary_term' = 'Revision Notes');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `secondary_kpi` SET TAGS ('dbx_business_glossary_term' = 'Secondary Key Performance Indicator (KPI)');
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ALTER COLUMN `target_audience_definition` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Definition');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `brand_lift_study_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Lift Study Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `analytics_request_id` SET TAGS ('dbx_business_glossary_term' = 'Analytics Request Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `brand_brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `measurement_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `prior_brand_lift_study_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `ad_recall_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Ad Recall Lift Percentage (Pct)');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `aided_awareness_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Aided Awareness Lift Percentage (Pct)');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `brand_favorability_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Brand Favorability Lift Percentage (Pct)');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `brand_preference_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Brand Preference Lift Percentage (Pct)');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `confidence_level_pct` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percentage (Pct)');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `consideration_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Consideration Lift Percentage (Pct)');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `control_group_definition` SET TAGS ('dbx_business_glossary_term' = 'Control Group Definition');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `control_sample_size` SET TAGS ('dbx_business_glossary_term' = 'Control Sample Size');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'pending|delivered|reviewed|archived');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `exposed_group_definition` SET TAGS ('dbx_business_glossary_term' = 'Exposed Group Definition');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `exposed_sample_size` SET TAGS ('dbx_business_glossary_term' = 'Exposed Sample Size');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `margin_of_error_pct` SET TAGS ('dbx_business_glossary_term' = 'Margin of Error Percentage (Pct)');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `message_association_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Message Association Lift Percentage (Pct)');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `methodology_notes` SET TAGS ('dbx_business_glossary_term' = 'Methodology Notes');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `purchase_intent_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Purchase Intent Lift Percentage (Pct)');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `report_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Report Delivery Date');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `statistical_significance_flag` SET TAGS ('dbx_business_glossary_term' = 'Statistical Significance Flag');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `study_code` SET TAGS ('dbx_business_glossary_term' = 'Study Code');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `study_end_date` SET TAGS ('dbx_business_glossary_term' = 'Study End Date');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `study_name` SET TAGS ('dbx_business_glossary_term' = 'Study Name');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `study_start_date` SET TAGS ('dbx_business_glossary_term' = 'Study Start Date');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Status');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `study_status` SET TAGS ('dbx_value_regex' = 'draft|in-field|completed|cancelled|on-hold');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Study Type');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'survey-based|digital brand lift|TV brand lift|cross-platform|OTT brand lift|social brand lift');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `survey_wave_count` SET TAGS ('dbx_business_glossary_term' = 'Survey Wave Count');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `target_audience_description` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Description');
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ALTER COLUMN `unaided_awareness_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Unaided Awareness Lift Percentage (Pct)');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `incrementality_test_id` SET TAGS ('dbx_business_glossary_term' = 'Incrementality Test Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Owner Worker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `analytics_request_id` SET TAGS ('dbx_business_glossary_term' = 'Analytics Request Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `measurement_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `prior_incrementality_test_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `control_group_definition` SET TAGS ('dbx_business_glossary_term' = 'Control Group Definition');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `control_group_outcome_value` SET TAGS ('dbx_business_glossary_term' = 'Control Group Outcome Value');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `control_group_size` SET TAGS ('dbx_business_glossary_term' = 'Control Group Size');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `incremental_cost_per_outcome` SET TAGS ('dbx_business_glossary_term' = 'Incremental Cost Per Outcome (iCPA)');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `incremental_lift_estimate` SET TAGS ('dbx_business_glossary_term' = 'Incremental Lift Estimate');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `incremental_roas` SET TAGS ('dbx_business_glossary_term' = 'Incremental Return on Ad Spend (iROAS)');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `is_statistically_significant` SET TAGS ('dbx_business_glossary_term' = 'Is Statistically Significant');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `lift_confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Lift Confidence Interval Lower Bound');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `lift_confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Lift Confidence Interval Upper Bound');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `measurement_window_days` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window Days');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `outcome_metric` SET TAGS ('dbx_business_glossary_term' = 'Outcome Metric');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `p_value` SET TAGS ('dbx_business_glossary_term' = 'P-Value');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `power_analysis_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Power Analysis Confidence Level');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `power_analysis_minimum_detectable_effect` SET TAGS ('dbx_business_glossary_term' = 'Power Analysis Minimum Detectable Effect (MDE)');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `power_analysis_statistical_power` SET TAGS ('dbx_business_glossary_term' = 'Power Analysis Statistical Power');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `results_finalized_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Results Finalized Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `statistical_methodology` SET TAGS ('dbx_business_glossary_term' = 'Statistical Methodology');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `statistical_methodology` SET TAGS ('dbx_value_regex' = 'difference_in_differences|synthetic_control|bayesian_causal_impact|propensity_score_matching|regression_discontinuity|randomized_control_trial');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `test_channel` SET TAGS ('dbx_business_glossary_term' = 'Test Channel');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `test_code` SET TAGS ('dbx_business_glossary_term' = 'Test Code');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `test_end_date` SET TAGS ('dbx_business_glossary_term' = 'Test End Date');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `test_name` SET TAGS ('dbx_business_glossary_term' = 'Test Name');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `test_notes` SET TAGS ('dbx_business_glossary_term' = 'Test Notes');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `test_objective` SET TAGS ('dbx_business_glossary_term' = 'Test Objective');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `test_start_date` SET TAGS ('dbx_business_glossary_term' = 'Test Start Date');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'draft|planned|in_flight|completed|cancelled|failed');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'geo_holdout|audience_holdout|switchback|synthetic_control|matched_market|psa_test');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `treatment_group_definition` SET TAGS ('dbx_business_glossary_term' = 'Treatment Group Definition');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `treatment_group_definition` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `treatment_group_definition` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `treatment_group_outcome_value` SET TAGS ('dbx_business_glossary_term' = 'Treatment Group Outcome Value');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `treatment_group_outcome_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `treatment_group_outcome_value` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `treatment_group_size` SET TAGS ('dbx_business_glossary_term' = 'Treatment Group Size');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `treatment_group_size` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ALTER COLUMN `treatment_group_size` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` SET TAGS ('dbx_subdomain' = 'delivery_operations');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `report_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Report Schedule Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `dashboard_id` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `insight_report_id` SET TAGS ('dbx_business_glossary_term' = 'Report Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `preference_id` SET TAGS ('dbx_business_glossary_term' = 'Client Preference Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Report Owner Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `recipient_group_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Group Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `tertiary_report_modified_by_user_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `superseded_report_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `auto_generation_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Generation Flag');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `custom_parameters` SET TAGS ('dbx_business_glossary_term' = 'Custom Parameters');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `data_refresh_lag_hours` SET TAGS ('dbx_business_glossary_term' = 'Data Refresh Lag Hours');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `delivery_day_of_month` SET TAGS ('dbx_business_glossary_term' = 'Delivery Day of Month');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `delivery_day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Delivery Day of Week');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `delivery_format` SET TAGS ('dbx_business_glossary_term' = 'Delivery Format');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `delivery_format` SET TAGS ('dbx_value_regex' = 'pdf|excel|csv|powerpoint|live_link|json');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `delivery_frequency` SET TAGS ('dbx_business_glossary_term' = 'Delivery Frequency');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `delivery_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|ad_hoc');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `delivery_message_body` SET TAGS ('dbx_business_glossary_term' = 'Delivery Message Body');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'email|slack|client_portal|ftp|api_push|sftp');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `delivery_subject_line` SET TAGS ('dbx_business_glossary_term' = 'Delivery Subject Line');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `delivery_time` SET TAGS ('dbx_business_glossary_term' = 'Delivery Time');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `delivery_timezone` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timezone');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `failure_notification_contacts` SET TAGS ('dbx_business_glossary_term' = 'Failure Notification Contacts');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `failure_notification_contacts` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `failure_notification_contacts` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `include_comparison_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Include Comparison Period Flag');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `last_delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Last Delivery Status');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `last_delivery_status` SET TAGS ('dbx_value_regex' = 'success|failed|partial|skipped');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `last_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Delivery Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `next_scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Delivery Date');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `recipient_list` SET TAGS ('dbx_business_glossary_term' = 'Recipient List');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `recipient_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `recipient_list` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `retry_interval_minutes` SET TAGS ('dbx_business_glossary_term' = 'Retry Interval Minutes');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Schedule Description');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|paused|retired|draft|suspended|failed');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `sla_delivery_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Delivery Window Hours');
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ALTER COLUMN `total_deliveries_count` SET TAGS ('dbx_business_glossary_term' = 'Total Deliveries Count');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` SET TAGS ('dbx_subdomain' = 'delivery_operations');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `report_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Report Delivery ID');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `dashboard_id` SET TAGS ('dbx_business_glossary_term' = 'Dashboard ID');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `insight_report_id` SET TAGS ('dbx_business_glossary_term' = 'Report ID');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `report_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Report Schedule Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `redelivery_of_report_delivery_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `client_acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Client Acknowledgment Status');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `client_acknowledgment_status` SET TAGS ('dbx_value_regex' = 'acknowledged|pending|not_required');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `client_acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Client Acknowledgment Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'email|sftp|api|portal|slack|teams');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `delivery_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Notes');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `delivery_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Number');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `delivery_number` SET TAGS ('dbx_value_regex' = '^DEL-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `delivery_priority` SET TAGS ('dbx_business_glossary_term' = 'Delivery Priority');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `delivery_priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `delivery_source_system` SET TAGS ('dbx_business_glossary_term' = 'Delivery Source System');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'sent|delivered|opened|failed|bounced|pending');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `delivery_trigger` SET TAGS ('dbx_business_glossary_term' = 'Delivery Trigger');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `delivery_trigger` SET TAGS ('dbx_value_regex' = 'scheduled|manual|ad_hoc|event_driven|api_request');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `delivery_url` SET TAGS ('dbx_business_glossary_term' = 'Delivery Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `encryption_flag` SET TAGS ('dbx_business_glossary_term' = 'Encryption Flag');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiration Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'pdf|excel|csv|powerpoint|html|json');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opened Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `password_protected_flag` SET TAGS ('dbx_business_glossary_term' = 'Password Protected Flag');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `primary_recipient_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Recipient Email');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `primary_recipient_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `primary_recipient_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `primary_recipient_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `recipient_list` SET TAGS ('dbx_business_glossary_term' = 'Recipient List');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `recipient_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `recipient_list` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `report_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Report Period End Date');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `report_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Report Period Start Date');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `scheduled_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `sla_actual_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual (Minutes)');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ALTER COLUMN `sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target (Minutes)');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `competitive_intelligence_id` SET TAGS ('dbx_business_glossary_term' = 'Competitive Intelligence ID');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `analytics_request_id` SET TAGS ('dbx_business_glossary_term' = 'Analytics Request Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `brand_brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Owner ID');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `prior_competitive_intelligence_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `analysis_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Period End Date');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `analysis_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Period Start Date');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `channel_mix_comparison` SET TAGS ('dbx_business_glossary_term' = 'Channel Mix Comparison');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `channels_analyzed` SET TAGS ('dbx_business_glossary_term' = 'Channels Analyzed');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `client_feedback` SET TAGS ('dbx_business_glossary_term' = 'Client Feedback');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `competitor_brands_tracked` SET TAGS ('dbx_business_glossary_term' = 'Competitor Brands Tracked');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `competitor_spend_estimate` SET TAGS ('dbx_business_glossary_term' = 'Competitor Spend Estimate');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `competitor_spend_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `creative_strategy_observations` SET TAGS ('dbx_business_glossary_term' = 'Creative Strategy Observations');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `data_collection_methodology` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Methodology');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `executive_summary` SET TAGS ('dbx_business_glossary_term' = 'Executive Summary');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `intelligence_source` SET TAGS ('dbx_business_glossary_term' = 'Intelligence Source');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `key_findings_narrative` SET TAGS ('dbx_business_glossary_term' = 'Key Findings Narrative');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `market_positioning_assessment` SET TAGS ('dbx_business_glossary_term' = 'Market Positioning Assessment');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `markets_covered` SET TAGS ('dbx_business_glossary_term' = 'Markets Covered');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `report_format` SET TAGS ('dbx_business_glossary_term' = 'Report Format');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `report_format` SET TAGS ('dbx_value_regex' = 'pdf|powerpoint|dashboard|excel|interactive');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `sov_trend_summary` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Trend Summary');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `strategic_implications` SET TAGS ('dbx_business_glossary_term' = 'Strategic Implications');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `study_code` SET TAGS ('dbx_business_glossary_term' = 'Study Code');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `study_name` SET TAGS ('dbx_business_glossary_term' = 'Study Name');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Status');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `study_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|under_review|completed|delivered|archived');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Study Type');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'share_of_voice|spend_analysis|creative_strategy|channel_mix|market_positioning|brand_health');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Tags');
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `audience_insight_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Insight Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `analytics_request_id` SET TAGS ('dbx_business_glossary_term' = 'Analytics Request Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `brand_brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `creative_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Owner Identifier (ID)');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `derived_from_audience_insight_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `activation_recommendations` SET TAGS ('dbx_business_glossary_term' = 'Activation Recommendations');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `analysis_end_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis End Date');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `analysis_methodology` SET TAGS ('dbx_business_glossary_term' = 'Analysis Methodology');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `analysis_start_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Start Date');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `audience_size` SET TAGS ('dbx_business_glossary_term' = 'Audience Size');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `client_feedback` SET TAGS ('dbx_business_glossary_term' = 'Client Feedback');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `data_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Data Period End Date');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `data_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Data Period Start Date');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `data_sources` SET TAGS ('dbx_business_glossary_term' = 'Data Sources');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|delivered|archived');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `demographic_focus` SET TAGS ('dbx_business_glossary_term' = 'Demographic Focus');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `insight_code` SET TAGS ('dbx_business_glossary_term' = 'Insight Code');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `insight_name` SET TAGS ('dbx_business_glossary_term' = 'Insight Name');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `insight_type` SET TAGS ('dbx_business_glossary_term' = 'Insight Type');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `insight_type` SET TAGS ('dbx_value_regex' = 'behavioral|psychographic|media_consumption|purchase_journey|cross_device|seasonal');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `insight_version` SET TAGS ('dbx_business_glossary_term' = 'Insight Version');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `key_findings` SET TAGS ('dbx_business_glossary_term' = 'Key Findings');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `persona_implications` SET TAGS ('dbx_business_glossary_term' = 'Persona Implications');
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `creative_effectiveness_study_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Effectiveness Study ID');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Owner Worker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `analytics_request_id` SET TAGS ('dbx_business_glossary_term' = 'Analytics Request Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `brand_brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `creative_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `measurement_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `video_completion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Video Completion Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `prior_creative_effectiveness_study_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `benchmark_comparison` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Comparison');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `brand_linkage_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Linkage Score');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `creative_dimensions_evaluated` SET TAGS ('dbx_business_glossary_term' = 'Creative Dimensions Evaluated');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `cta_effectiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Call-to-Action (CTA) Effectiveness Score');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `emotional_resonance_score` SET TAGS ('dbx_business_glossary_term' = 'Emotional Resonance Score');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `executive_summary` SET TAGS ('dbx_business_glossary_term' = 'Executive Summary');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `key_findings` SET TAGS ('dbx_business_glossary_term' = 'Key Findings');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `message_clarity_score` SET TAGS ('dbx_business_glossary_term' = 'Message Clarity Score');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `optimization_recommendations` SET TAGS ('dbx_business_glossary_term' = 'Optimization Recommendations');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `overall_effectiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Effectiveness Score');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `report_url` SET TAGS ('dbx_business_glossary_term' = 'Report URL');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `sample_definition` SET TAGS ('dbx_business_glossary_term' = 'Sample Definition');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `study_code` SET TAGS ('dbx_business_glossary_term' = 'Study Code');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `study_cost` SET TAGS ('dbx_business_glossary_term' = 'Study Cost');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `study_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `study_end_date` SET TAGS ('dbx_business_glossary_term' = 'Study End Date');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `study_methodology` SET TAGS ('dbx_business_glossary_term' = 'Study Methodology');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `study_methodology` SET TAGS ('dbx_value_regex' = 'eye-tracking|biometric|survey-based|in-market performance|AI creative scoring|mixed methods');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `study_name` SET TAGS ('dbx_business_glossary_term' = 'Study Name');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `study_start_date` SET TAGS ('dbx_business_glossary_term' = 'Study Start Date');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Status');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `study_status` SET TAGS ('dbx_value_regex' = 'planned|in progress|completed|cancelled|on hold');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Study Type');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'pre-test|post-test|continuous tracking|A/B test|multivariate test');
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ALTER COLUMN `visual_attention_score` SET TAGS ('dbx_business_glossary_term' = 'Visual Attention Score');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `budget_optimization_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Optimization Scenario ID');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `analytics_request_id` SET TAGS ('dbx_business_glossary_term' = 'Analytics Request Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `attribution_study_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Study ID');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `baseline_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline Scenario ID');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand ID');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `creative_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `incrementality_test_id` SET TAGS ('dbx_business_glossary_term' = 'Incrementality Test ID');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `mmm_study_id` SET TAGS ('dbx_business_glossary_term' = 'Media Mix Model (MMM) Study ID');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `revenue_target_id` SET TAGS ('dbx_business_glossary_term' = 'Client Revenue Target Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Owner ID');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `baseline_budget_optimization_scenario_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `client_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Date');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `client_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Status');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `client_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|changes_requested');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `client_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Client Approved By');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `confidence_level_lower_bound` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Lower Bound');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `confidence_level_upper_bound` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Upper Bound');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `constraints_applied` SET TAGS ('dbx_business_glossary_term' = 'Constraints Applied');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `implementation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Start Date');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `optimization_objective` SET TAGS ('dbx_business_glossary_term' = 'Optimization Objective');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `presentation_delivered_date` SET TAGS ('dbx_business_glossary_term' = 'Presentation Delivered Date');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `projected_conversions` SET TAGS ('dbx_business_glossary_term' = 'Projected Conversions');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `projected_cpa` SET TAGS ('dbx_business_glossary_term' = 'Projected Cost Per Acquisition (CPA)');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `projected_cpm` SET TAGS ('dbx_business_glossary_term' = 'Projected Cost Per Mille (CPM)');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `projected_impressions` SET TAGS ('dbx_business_glossary_term' = 'Projected Impressions');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `projected_reach` SET TAGS ('dbx_business_glossary_term' = 'Projected Reach');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `projected_revenue` SET TAGS ('dbx_business_glossary_term' = 'Projected Revenue');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `projected_roas` SET TAGS ('dbx_business_glossary_term' = 'Projected Return on Ad Spend (ROAS)');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `recommendation_summary` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Summary');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `scenario_code` SET TAGS ('dbx_business_glossary_term' = 'Scenario Code');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `scenario_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scenario Created Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `scenario_description` SET TAGS ('dbx_business_glossary_term' = 'Scenario Description');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Scenario Name');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `scenario_status` SET TAGS ('dbx_business_glossary_term' = 'Scenario Status');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `scenario_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|rejected|implemented|archived');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `scenario_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scenario Updated Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` SET TAGS ('dbx_subdomain' = 'delivery_operations');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `analytics_request_id` SET TAGS ('dbx_business_glossary_term' = 'Analytics Request ID');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `client_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brief Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Analyst ID');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `follow_up_analytics_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `actual_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Effort Hours');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `analysis_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Period End Date');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `analysis_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Period Start Date');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `client_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Client Satisfaction Rating');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `data_sources_required` SET TAGS ('dbx_business_glossary_term' = 'Data Sources Required');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `deliverable_type` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Type');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `deliverable_type` SET TAGS ('dbx_value_regex' = 'report|dashboard|presentation|data export|model|insight document');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `deliverable_url` SET TAGS ('dbx_business_glossary_term' = 'Deliverable URL');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `effort_estimate_hours` SET TAGS ('dbx_business_glossary_term' = 'Effort Estimate Hours');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `key_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Key Findings Summary');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `kpi_measured` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Measured');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Priority Tier');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `priority_tier` SET TAGS ('dbx_value_regex' = 'P1|P2|P3');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Analytics Request Number');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^ANR-[0-9]{6,10}$');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `request_status` SET TAGS ('dbx_value_regex' = 'submitted|scoped|in-progress|in-review|delivered|cancelled');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Request Type');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'ad-hoc analysis|dashboard build|MMM|attribution study|audience insight|competitive intelligence');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `requestor_type` SET TAGS ('dbx_business_glossary_term' = 'Requestor Type');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `requestor_type` SET TAGS ('dbx_value_regex' = 'client|internal');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `review_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Started Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `scoping_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scoping Completed Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Request Title');
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ALTER COLUMN `work_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Work Started Timestamp');
ALTER TABLE `advertising_ecm`.`analytics`.`recipient_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`analytics`.`recipient_group` SET TAGS ('dbx_subdomain' = 'delivery_operations');
ALTER TABLE `advertising_ecm`.`analytics`.`recipient_group` ALTER COLUMN `recipient_group_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Group Identifier');
ALTER TABLE `advertising_ecm`.`analytics`.`recipient_group` ALTER COLUMN `parent_recipient_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`analytics`.`recipient_group` ALTER COLUMN `estimated_value` SET TAGS ('dbx_confidential' = 'true');
