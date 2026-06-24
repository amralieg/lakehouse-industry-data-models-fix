-- Schema for Domain: production | Business: Media_Broadcasting | Version: v2_mvm
-- Generated on: 2026-06-23 04:24:41

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`production` COMMENT 'Manages the end-to-end content production and post-production workflow — from greenlight and pre-production planning through principal photography, editing, VFX, color grading, audio mixing, transcoding, and final delivery. Tracks production budgets, crew assignments, shoot schedules, facility bookings, equipment allocation, and deliverable milestones. Integrates with Dalet Galaxy for ingest and workflow orchestration.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`project` (
    `project_id` BIGINT COMMENT 'Primary key for project',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Projects are commissioned for specific broadcast channels/networks. Network commissioning process requires tracking which channel ordered the content. Essential for content planning, budget allocation',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: A production project produces a specific season. Season-level production tracking (delivery dates, episode counts, rights validation) requires this FK. season_number is denormalized from content.seaso',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Projects often have master license agreements governing distribution rights (co-production deals, pre-sales, output deals). Real business need: tracking which license agreements fund or govern a produ',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Production projects produce a primary master media asset stored in the MAM. Asset management and project completion reports require linking the project to its master asset. Broadcasting operations tea',
    `title_id` BIGINT COMMENT 'FK to content.title.title_id — Critical production-to-content traceability: must answer what content title does this production project produce? for scheduling, rights clearance, and financial reporting workflows.',
    `release_window_id` BIGINT COMMENT 'Foreign key linking to distribution.release_window. Business justification: Production projects are initiated to fulfill release window commitments. Greenlight decisions, production timelines, and delivery milestones are all driven by release window open dates. Production pla',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Production projects are organized at the series level (e.g., producing Season 2 of an existing franchise). Series-level production tracking, greenlight reporting, and franchise budget rollups require ',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: A production project is greenlit for a specific delivery channel (FAST, linear broadcast, SVOD). This drives technical production requirements from day one. Role-prefixed target_ to mirror existing ',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Productions are commissioned for specific streaming platforms (Netflix Originals, HBO Max Exclusives). Platform determines technical specs, content ratings, delivery windows. Real business process: pl',
    `subscription_plan_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscription_plan. Business justification: OTT original content projects are greenlit for a specific subscription tier (e.g., Premium Original vs. Standard Library). Content Tier Assignment at Greenlight determines approved budget thresholds',
    `actual_delivery_date` DATE COMMENT 'Date on which the final deliverable was actually delivered to the distribution or broadcast platform. Compared against target_delivery_date to measure on-time delivery performance and SLA compliance.',
    `actual_spend_usd` DECIMAL(18,2) COMMENT 'Cumulative actual expenditure incurred against this production project to date, denominated in US Dollars. Sourced from SAP S/4HANA cost postings. Compared against approved_budget_usd for variance and financial reconciliation reporting.',
    `approved_budget_usd` DECIMAL(18,2) COMMENT 'Total production budget formally approved at greenlight, denominated in US Dollars. Represents the authorized spend ceiling for the project. Used for financial controlling, variance analysis, and EBITDA reporting in SAP S/4HANA.',
    `co_production_flag` BOOLEAN COMMENT 'Indicates whether this production project is a co-production involving one or more external production partners. Triggers co-production agreement workflows, shared rights structures, and split budget reporting in SAP S/4HANA.',
    `content_genre` STRING COMMENT 'Primary genre classification of the content being produced (e.g., drama, comedy, thriller, sports, news, reality). Used for audience targeting, scheduling, advertising sales, and rights windowing strategies. [ENUM-REF-CANDIDATE: drama|comedy|thriller|action|documentary|news|reality|sports|animation|horror — promote to reference product]',
    `coppa_applicable` BOOLEAN COMMENT 'Indicates whether this production is directed at children under 13 and therefore subject to COPPA compliance requirements. Affects data collection practices, advertising eligibility, and platform distribution restrictions.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production project record was first created in the lakehouse Silver layer. Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail and data lineage tracking.',
    `dalet_workflow_reference` STRING COMMENT 'Integration reference identifier linking this production project to its corresponding workflow instance in Dalet Galaxy Media Asset Management and Workflow Orchestration system. Enables cross-system traceability for ingest, metadata, archive, and workflow operations.',
    `drm_required` BOOLEAN COMMENT 'Indicates whether Digital Rights Management (DRM) protection must be applied to the delivered content assets. Drives technical delivery specifications for CDN, streaming platform configuration, and Akamai CDN security settings.',
    `eidr` STRING COMMENT 'Entertainment Identifier Registry (EIDR) identifier for this content project. Provides a universal, persistent identifier for the title across supply chain partners, distributors, and platforms.. Valid values are `^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-Z]$`',
    `episode_count` STRING COMMENT 'Total number of episodes commissioned for this production project. Applicable to scripted and unscripted series. Used for budget modeling, scheduling, and rights licensing calculations. Null for single-title formats such as feature films.',
    `fcc_license_required` BOOLEAN COMMENT 'Indicates whether this production requires FCC broadcast licensing compliance review prior to linear broadcast distribution. Applicable to content intended for over-the-air or cable transmission in the United States.',
    `greenlight_date` DATE COMMENT 'Calendar date on which the production project received formal executive greenlight approval. Marks the official start of the production lifecycle and triggers budget release and resource mobilization.',
    `isan` STRING COMMENT 'Globally unique identifier assigned to this audiovisual work under the International Standard Audiovisual Number (ISAN) standard (ISO 15706). Used for rights management, royalty tracking, and cross-platform content identification.. Valid values are `^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}$`',
    `omc_asset_structural_characteristic_code` BIGINT COMMENT 'OMC Asset Structural Characteristic identifier describing structural/technical asset traits',
    `omc_concept_role` STRING COMMENT 'MovieLabs OMC structural concept role for this entity: Context',
    `omc_context_code` BIGINT COMMENT 'OMC Context identifier grouping this production entity into a creative/production context',
    `omc_participant_code` BIGINT COMMENT 'OMC Participant identifier (person/organization/service performing or owning this entity)',
    `original_ip_flag` BOOLEAN COMMENT 'Indicates whether this production is based on original intellectual property owned by the organization, as opposed to licensed or adapted IP. Affects rights ownership, residuals obligations, and long-term asset valuation.',
    `post_production_start_date` DATE COMMENT 'Scheduled or actual date on which post-production activities commenced, including editing, VFX, color grading, audio mixing, and transcoding. Used for facility booking and deliverable milestone planning.',
    `pre_production_start_date` DATE COMMENT 'Scheduled or actual date on which pre-production activities commenced, including casting, location scouting, script breakdown, and crew hiring. Used for production planning and milestone tracking.',
    `primary_language` STRING COMMENT 'ISO 639-1 or ISO 639-2 language code for the primary language in which the content is produced (e.g., en, es, fr). Drives localization, dubbing, subtitling, and distribution territory planning.. Valid values are `^[a-z]{2,3}$`',
    `principal_photography_end_date` DATE COMMENT 'Scheduled or actual date on which principal photography concluded (picture wrap). Triggers transition to post-production phase and initiates post-production resource scheduling.',
    `principal_photography_start_date` DATE COMMENT 'Scheduled or actual date on which principal photography (primary filming) commenced. A key production milestone used for crew scheduling, facility booking, and insurance activation.',
    `production_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary country in which the production is being executed. Determines applicable regulatory frameworks, tax incentive eligibility, and co-production treaty benefits.. Valid values are `^[A-Z]{3}$`',
    `production_phase` STRING COMMENT 'Current phase of the content production lifecycle. Tracks the projects progression from development through delivery. Used to gate workflow steps, resource allocation, and financial milestone releases.. Valid values are `development|pre_production|principal_photography|post_production|delivery|archived`',
    `sap_wbs_element` STRING COMMENT 'SAP S/4HANA Work Breakdown Structure element code that maps this production project to the enterprise financial controlling hierarchy for budget tracking, cost allocation, and financial reconciliation.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `synopsis` STRING COMMENT 'Short narrative description of the content production projects story, subject matter, or editorial concept. Used for internal greenlight documentation, sales pitches, EPG metadata, and Dalet Galaxy asset metadata.',
    `target_delivery_date` DATE COMMENT 'Contractually committed or internally planned date by which the finished content must be delivered to distribution, broadcast, or streaming platforms. Drives post-production scheduling, windowing strategy, and SLA compliance.',
    `total_runtime_minutes` STRING COMMENT 'Total planned or delivered runtime of the production in minutes. For series, this is the aggregate runtime across all episodes. Used for scheduling, licensing, and royalty calculations.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this production project record was most recently modified in the lakehouse Silver layer. Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change tracking, incremental processing, and audit compliance.',
    CONSTRAINT pk_project PRIMARY KEY(`project_id`)
) COMMENT 'Master record for a content production project — the greenlit initiative that drives all production activity. Captures the project title, type (scripted series, feature film, documentary, live event, news segment), greenlight status, production phase (development, pre-production, principal photography, post-production, delivery), approved budget, actual spend, production company, showrunner or executive producer, target delivery date, ISAN identifier, and integration reference to Dalet Galaxy workflow. This is the top-level anchor entity for the entire production domain. [DEMO-FITNESS] MVM demo-fitness: Churn prediction & win-back (D2C SVOD) [rating=5/5, status=done]; Rights availability & windowing [rating=5/5, status=best-in-class]; Linear playout + as-run reconciliation [rating=5/5, status=complete]; Production cost & budget vs. actuals [rating=4/5, status=strong]; Compliance / regulatory reporting [rating=5/5, status=complete]; Overall bottom-line [rating=n/a/5, status=substantially above average]';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` (
    `shoot_schedule_id` BIGINT COMMENT 'Unique surrogate identifier for a shoot schedule record in the production domain. Primary key for the shoot_schedule data product.',
    `episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Shoot schedule days are planned for specific episodes. Production planning reports showing which episodes are filmed on which dates are a standard broadcast production management requirement. This lin',
    `location_id` BIGINT COMMENT 'Foreign key linking to production.location. Business justification: Normalization opportunity. Shoot schedule currently has location_name (STRING). FK to location table provides referential integrity and enables retrieving full location details (address, permits, safe',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Shoot days generate dailies (raw footage) ingested into MAM for editorial review. Role-prefixed as dailies_asset_id since shoot_schedule already has dalet_workflow_id. Essential for post-production wo',
    `project_id` BIGINT COMMENT 'Reference to the parent production project to which this shoot schedule day belongs. Links the daily schedule to the overarching production entity.',
    `script_id` BIGINT COMMENT 'Foreign key linking to production.script. Business justification: shoot_schedule already has a scene_numbers STRING column that references specific scenes from a script, but there is no formal FK to the script table. Adding script_id to shoot_schedule formalizes the',
    `actual_extras_count` STRING COMMENT 'The actual number of background performers (extras) who worked on this shoot day. Used for payroll reconciliation, SAG-AFTRA reporting, and production cost tracking.',
    `actual_shoot_hours` DECIMAL(18,2) COMMENT 'The actual number of hours spent in principal photography for the day. Used for budget reconciliation, overtime calculation, and production efficiency analysis.',
    `actual_wrap_time` TIMESTAMP COMMENT 'The actual time at which principal photography concluded for the day. Compared against scheduled wrap time to calculate overtime and assess schedule adherence.',
    `call_time` TIMESTAMP COMMENT 'The scheduled time at which cast and crew are required to report to set. Used for crew coordination, transport logistics, and facility readiness planning.',
    `cover_set_description` STRING COMMENT 'Description of the alternate interior or cover set designated for use if weather or other conditions prevent the primary shoot. Only applicable when weather_contingency_flag is True.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp at which this shoot schedule record was first created in the system. Supports audit trail, data lineage, and compliance requirements.',
    `dalet_workflow_reference` STRING COMMENT 'The workflow instance identifier assigned by Dalet Galaxy for the ingest and orchestration workflow associated with this shoot days deliverables. Enables traceability between the shoot schedule and downstream media asset management processes.',
    `estimated_extras_count` STRING COMMENT 'The planned number of background performers (extras) required for this shoot day. Used for casting coordination, catering planning, and SAG-AFTRA background performer compliance.',
    `estimated_shoot_hours` DECIMAL(18,2) COMMENT 'The planned number of shooting hours for the day, used for budget forecasting, crew scheduling, and facility booking. Expressed in decimal hours (e.g., 10.50 = 10 hours 30 minutes).',
    `first_shot_time` TIMESTAMP COMMENT 'The scheduled or actual time at which the first camera roll of the day begins. A key production efficiency metric used to assess set readiness and pre-production effectiveness.',
    `is_overtime_day` BOOLEAN COMMENT 'Indicates whether this shoot day resulted in overtime hours for cast or crew, triggering additional compensation obligations under union agreements (SAG-AFTRA, DGA, IATSE). Derived operationally but stored for compliance and payroll audit purposes.',
    `meal_penalty_flag` BOOLEAN COMMENT 'Indicates whether a meal penalty was incurred on this shoot day due to failure to provide a meal break within the union-mandated interval (typically 6 hours). Triggers additional compensation obligations under SAG-AFTRA and IATSE agreements.',
    `omc_asset_structural_characteristic_code` BIGINT COMMENT 'OMC Asset Structural Characteristic identifier describing structural/technical asset traits',
    `omc_concept_role` STRING COMMENT 'MovieLabs OMC structural concept role for this entity: Context',
    `omc_context_code` BIGINT COMMENT 'OMC Context identifier grouping this production entity into a creative/production context',
    `omc_participant_code` BIGINT COMMENT 'OMC Participant identifier (person/organization/service performing or owning this entity)',
    `page_count` DECIMAL(18,2) COMMENT 'The number of script pages scheduled for photography on this shoot day, expressed in eighths of a page per industry convention (e.g., 4.625 = 4 and 5/8 pages). A standard production efficiency metric used to assess daily output against industry benchmarks.',
    `production_notes` STRING COMMENT 'Free-text field capturing significant events, issues, or observations from the shoot day, including equipment failures, weather delays, cast illness, or creative changes. Sourced from the daily production report.',
    `production_unit` STRING COMMENT 'Identifies the filming unit responsible for this shoot day. Main unit is led by the principal director; second unit handles action sequences or supplemental footage; splinter unit shoots simultaneously with main unit on a separate set; insert unit captures close-up or detail shots.. Valid values are `main_unit|second_unit|splinter_unit|insert_unit`',
    `revision_date` DATE COMMENT 'The date on which the current revision of this shoot schedule was issued. Used to track the cadence of schedule changes and identify the most current approved version.',
    `revision_version` STRING COMMENT 'The version identifier of this shoot schedule revision (e.g., v1, v3-BLUE, Rev-7). Production schedules are revised frequently; tracking version enables audit of changes and comparison of planned vs. actual across revisions.',
    `scene_numbers` STRING COMMENT 'Comma-separated list of scene numbers from the production script scheduled for photography on this shoot day (e.g., 12, 13A, 14, 15B). Derived from the stripboard and used for script supervisor tracking and editorial planning.',
    `schedule_number` STRING COMMENT 'Externally-known alphanumeric identifier for this shoot schedule record, used in production paperwork, call sheets, and cross-system references (e.g., SS-2024-0042).',
    `scheduled_wrap_time` TIMESTAMP COMMENT 'The planned time at which principal photography is expected to conclude for the day. Used for facility booking, crew scheduling, and overtime cost estimation.',
    `shoot_date` DATE COMMENT 'The calendar date on which principal photography is scheduled or was executed. The primary business event date for this schedule record.',
    `shoot_day_number` STRING COMMENT 'Sequential shoot day number within the production (e.g., Day 1, Day 15, Day 42). Used to track production progress against the total approved shoot days and for budget burn-rate analysis.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `total_approved_shoot_days` STRING COMMENT 'The total number of principal photography days approved in the production greenlight. Used to calculate schedule completion percentage and identify overages requiring executive approval.',
    `turnaround_hours` DECIMAL(18,2) COMMENT 'The minimum rest period in hours between the wrap of the previous shoot day and the call time of this shoot day. Union agreements (SAG-AFTRA, DGA, IATSE) mandate minimum turnaround periods; violations trigger penalty payments.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp at which this shoot schedule record was most recently modified. Used for change detection, incremental data loading in the Databricks Silver Layer, and audit trail maintenance.',
    `weather_contingency_flag` BOOLEAN COMMENT 'Indicates whether this shoot day has a weather contingency plan in place. When True, an alternate interior or cover set is designated in case outdoor conditions prevent the primary shoot. Critical for location shoots and insurance risk management.',
    CONSTRAINT pk_shoot_schedule PRIMARY KEY(`shoot_schedule_id`)
) COMMENT 'Day-by-day principal photography schedule for a production project. Tracks shoot dates, call times, wrap times, location or studio facility, scene numbers, unit (main unit, second unit, splinter unit), director, first assistant director, estimated vs actual shoot hours, weather contingency flags, and schedule revision version. Integrates with facility booking and crew assignment to coordinate all on-set resources. Distinct from the EPG scheduling domain which governs broadcast playout. [DEMO-FITNESS] MVM demo-fitness: Churn prediction & win-back (D2C SVOD) [rating=5/5, status=done]; Rights availability & windowing [rating=5/5, status=best-in-class]; Linear playout + as-run reconciliation [rating=5/5, status=complete]; Production cost & budget vs. actuals [rating=4/5, status=strong]; Compliance / regulatory reporting [rating=5/5, status=complete]; Overall bottom-line [rating=n/a/5, status=substantially above average]';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`budget` (
    `budget_id` BIGINT COMMENT 'Primary key for budget',
    `project_id` BIGINT COMMENT 'Reference to the parent production project this budget record belongs to. Links the financial control baseline to the production entity.',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Cumulative actual costs incurred to date for this cost category, sourced from SAP S/4HANA FI/CO actual postings. Represents real expenditure against the approved budget.',
    `approval_status` STRING COMMENT '',
    `approved_amount` DECIMAL(18,2) COMMENT 'The formally approved budget amount for this cost category and version, representing the financial control baseline authorized by the production greenlight committee.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this budget version was formally approved by the authorized signatory. Null if not yet approved.',
    `change_reason` STRING COMMENT 'Free-text narrative explaining the business justification for a budget revision (e.g., Schedule extension due to weather delays, Additional VFX shots approved by director). Mandatory for revised versions.',
    `change_request_reference` STRING COMMENT 'Reference number of the formal budget change request (BCR) document that authorized a revision to this budget line, traceable in the production finance approval workflow.',
    `budget_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this budget record within the production finance system. Used for cross-system reference and reporting.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `committed_amount` DECIMAL(18,2) COMMENT 'Total value of open purchase order commitments (obligations) for this cost category that have been raised but not yet invoiced. Represents encumbered funds in the SAP MM/CO commitment ledger.',
    `contingency_amount` DECIMAL(18,2) COMMENT 'The absolute monetary value of the contingency reserve allocated for this cost category, derived from the contingency percentage applied to the approved budget amount.',
    `contingency_percentage` DECIMAL(18,2) COMMENT 'The percentage of the approved budget allocated as contingency reserve for this cost category, representing the risk buffer approved by the production finance committee.',
    `cost_category_code` STRING COMMENT 'SAP cost element or cost category code classifying the type of production expenditure (e.g., ATL-TALENT, BTL-CREW, BTL-EQUIPMENT, POST-VFX, POST-AUDIO). [ENUM-REF-CANDIDATE: ATL-TALENT|ATL-RIGHTS|BTL-CREW|BTL-EQUIPMENT|BTL-FACILITIES|BTL-TRAVEL|POST-VFX|POST-AUDIO|POST-COLOR|CONTINGENCY — promote to reference product]',
    `cost_category_name` STRING COMMENT 'Human-readable name of the production cost category (e.g., Above-the-Line Talent, Below-the-Line Crew, Visual Effects, Audio Post-Production).',
    `cost_line_type` STRING COMMENT 'High-level classification of the cost line distinguishing above-the-line (ATL) creative costs (writers, directors, producers, talent) from below-the-line (BTL) technical and crew costs, post-production, contingency, and overhead.. Valid values are `ABOVE_THE_LINE|BELOW_THE_LINE|POST_PRODUCTION|CONTINGENCY|OVERHEAD`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was first created in the source system or ingested into the Databricks Silver Layer. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT '',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert this budget records currency to the productions reporting currency at the time of budget approval or revision.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month number 1–12 or 1–16 for special periods) within the fiscal year to which this budget line is assigned in SAP CO.',
    `fiscal_year` STRING COMMENT 'The four-digit fiscal year to which this budget record belongs in the SAP S/4HANA CO controlling area, used for annual financial planning and SOX reporting.',
    `forecast_amount` DECIMAL(18,2) COMMENT 'Latest estimate of the total cost expected to be incurred for this cost category by production completion, incorporating actuals to date and projected remaining spend.',
    `is_greenlight_budget` BOOLEAN COMMENT 'Indicates whether this budget record represents the original greenlight-approved budget for the production, as distinct from subsequent revisions. The greenlight budget is the primary financial authorization baseline.',
    `is_locked` BOOLEAN COMMENT 'Indicates whether this budget version has been locked and is no longer open for modification. A locked budget serves as the immutable financial baseline for variance reporting.',
    `notes` STRING COMMENT 'Free-text field for additional commentary, assumptions, or clarifications associated with this budget record, entered by the production finance team.',
    `omc_asset_structural_characteristic_code` BIGINT COMMENT 'OMC Asset Structural Characteristic identifier describing structural/technical asset traits',
    `omc_concept_role` STRING COMMENT 'MovieLabs OMC structural concept role for this entity: Context',
    `omc_context_code` BIGINT COMMENT 'OMC Context identifier grouping this production entity into a creative/production context',
    `omc_participant_code` BIGINT COMMENT 'OMC Participant identifier (person/organization/service performing or owning this entity)',
    `period_end_date` DATE COMMENT 'The end date of the fiscal or production period covered by this budget record. Defines the temporal boundary for cost accumulation and variance measurement.',
    `period_start_date` DATE COMMENT 'The start date of the fiscal or production period covered by this budget record, aligning to the SAP fiscal year/period structure.',
    `production_phase` STRING COMMENT 'The production lifecycle phase to which this budget line is attributed (e.g., Development, Pre-Production, Principal Photography, Post-Production, Delivery). Enables phase-level budget tracking.. Valid values are `DEVELOPMENT|PRE_PRODUCTION|PRINCIPAL_PHOTOGRAPHY|POST_PRODUCTION|DELIVERY|CLOSED`',
    `revised_amount` DECIMAL(18,2) COMMENT 'The most recently revised budget amount for this cost category following a formal budget change request. Null if no revision has been approved since the original budget.',
    `sap_cost_object_code` STRING COMMENT 'The SAP S/4HANA CO cost object identifier (Internal Order number or WBS Element ID) that anchors this budget record to the controlling module for financial reconciliation.',
    `sap_wbs_element` STRING COMMENT 'SAP Project System Work Breakdown Structure element code that maps this budget line to a specific phase or deliverable within the production project hierarchy (e.g., PRE-PROD, PRINCIPAL, POST-PROD).',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this budget record in the source system or Silver Layer. Used for incremental load detection and change data capture.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between the approved (or revised) budget amount and the sum of actual costs plus commitments. A negative value indicates an over-budget condition; positive indicates underspend.',
    `version` STRING COMMENT 'Version label of this budget record, distinguishing the original greenlight budget from subsequent revisions and the locked final version. Supports budget version history tracking.. Valid values are `ORIGINAL|REVISED_1|REVISED_2|REVISED_3|FINAL|LOCKED`',
    `version_number` STRING COMMENT 'Sequential integer version number of this budget record (e.g., 1 = original, 2 = first revision). Enables ordered version history and audit trail.',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Detailed production budget record aligned to the SAP S/4HANA CO (Controlling) module. Captures above-the-line and below-the-line cost categories, approved budget amounts by cost category, revised budget amounts, actual costs to date, purchase order commitments, variance amounts, currency, budget version, and approval status. Serves as the financial control baseline for a production project. Links to SAP cost centers and WBS elements for financial reconciliation. [DEMO-FITNESS] MVM demo-fitness: Churn prediction & win-back (D2C SVOD) [rating=5/5, status=done]; Rights availability & windowing [rating=5/5, status=best-in-class]; Linear playout + as-run reconciliation [rating=5/5, status=complete]; Production cost & budget vs. actuals [rating=4/5, status=strong]; Compliance / regulatory reporting [rating=5/5, status=complete]; Overall bottom-line [rating=n/a/5, status=substantially above average]';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Unique surrogate identifier for each individual budget line item within a production budget. Primary key for this entity.',
    `ad_order_id` BIGINT COMMENT 'Foreign key linking to sales.ad_order. Business justification: Advertiser-funded production cost recovery: production budget lines for commercial shoots are billed back to specific ad orders. Finance and sales ops track cost-per-order for billing, margin reportin',
    `budget_id` BIGINT COMMENT 'Reference to the parent production budget document that contains this line item. A production may have multiple budget versions (e.g., greenlight, revised, final).',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Budget lines track advertiser-funded production costs for branded content and product integrations. Business process: advertiser co-production cost allocation, campaign-funded production expense track',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.contract. Business justification: Above-the-line budget lines (actor/director fees) are driven by talent contracts. Production accountants reconcile budget lines against talent contracts for SAG/AFTRA compliance reporting and cost-to-',
    `episode_id` BIGINT COMMENT 'Reference to the specific episode or segment to which this budget line is allocated. Null for series-level or film-level lines that are not episode-specific.',
    `project_id` BIGINT COMMENT 'Reference to the parent production project to which this budget line belongs. Links the line item to its overarching production context.',
    `accrued_amount` DECIMAL(18,2) COMMENT 'Costs accrued for work performed or services received but not yet invoiced or formally committed. Supports period-end financial close and accurate cost-to-complete reporting.',
    `actual_amount` DECIMAL(18,2) COMMENT 'Total actual costs incurred and posted against this budget line to date, sourced from SAP FI invoice postings and payroll actuals. Used for variance analysis against budgeted and committed amounts.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line was formally approved by the authorized approver. Provides an audit trail for financial governance and SOX compliance.',
    `budgeted_amount` DECIMAL(18,2) COMMENT 'Original approved budget amount for this line item as established at greenlight or budget approval. Represents the planned cost baseline against which actuals and commitments are measured.',
    `committed_amount` DECIMAL(18,2) COMMENT 'Total value of purchase orders, contracts, or binding agreements raised against this budget line but not yet invoiced. Represents financial obligations that reduce available budget.',
    `contingency_pct` DECIMAL(18,2) COMMENT 'Contingency percentage applied to this budget line to cover unforeseen cost overruns. Typically 5–15% for production lines. Contributes to the overall production contingency reserve.',
    `cost_category` STRING COMMENT 'High-level cost category classifying the budget line within the production budget structure. Above-the-line covers creative talent (writers, directors, producers, cast); below-the-line covers crew, equipment, locations, and production services. [ENUM-REF-CANDIDATE: above_the_line|below_the_line|post_production|music_licensing|vfx|marketing|overhead|contingency|insurance|legal — promote to reference product]',
    `cost_sub_category` STRING COMMENT 'Granular sub-classification within the cost category (e.g., Cast Fees, Location Fees, Equipment Rental, VFX Compositing, Music Synchronization License, Post-Production Labor). Enables detailed variance analysis at the sub-category level.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line record was first created in the system. Provides audit trail for record provenance and financial governance.',
    `forecast_amount` DECIMAL(18,2) COMMENT 'Estimate at Completion (EAC) for this budget line, representing the current best estimate of total cost when the line item is fully complete. Combines actuals to date with estimate to complete.',
    `fringe_rate_pct` DECIMAL(18,2) COMMENT 'Percentage applied to labor costs on this line to account for employer fringe benefits (payroll taxes, pension contributions, health insurance, residuals). Standard production accounting practice for above-the-line and below-the-line labor lines.',
    `is_above_the_line` BOOLEAN COMMENT 'Flag indicating whether this budget line is classified as above-the-line (ATL) cost, covering creative talent such as writers, directors, producers, and principal cast. False indicates below-the-line (BTL) cost.',
    `is_union_labor` BOOLEAN COMMENT 'Flag indicating whether this budget line involves union or guild labor subject to collective bargaining agreements (DGA, SAG-AFTRA, WGA, IATSE). Drives fringe rate calculations and residuals obligations.',
    `line_description` STRING COMMENT 'Free-text description of the specific cost item represented by this budget line (e.g., Lead Actor Day Rate — Week 3, Steadicam Rental — Principal Photography, Dolby Atmos Mix — Episode 4).',
    `line_number` STRING COMMENT 'Sequential line number within the parent budget document, used for ordering and referencing individual line items in budget reports and purchase orders.',
    `notes` STRING COMMENT 'Free-text notes or comments entered by the production accountant or line producer providing additional context, assumptions, or justification for this budget line item.',
    `omc_asset_structural_characteristic_code` BIGINT COMMENT 'OMC Asset Structural Characteristic identifier describing structural/technical asset traits',
    `omc_concept_role` STRING COMMENT 'MovieLabs OMC structural concept role for this entity: Context',
    `omc_context_code` BIGINT COMMENT 'OMC Context identifier grouping this production entity into a creative/production context',
    `omc_participant_code` BIGINT COMMENT 'OMC Participant identifier (person/organization/service performing or owning this entity)',
    `production_phase` STRING COMMENT 'Phase of the production workflow during which this cost is incurred. Enables phase-based cost tracking and cash flow forecasting across the full production lifecycle from development through delivery.. Valid values are `development|pre_production|principal_photography|post_production|delivery|archive`',
    `purchase_order_number` STRING COMMENT 'SAP purchase order number raised against this budget line for vendor commitments. Links the budget line to the formal procurement document and enables three-way matching (PO, goods receipt, invoice).',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of units associated with this budget line (e.g., number of shoot days, number of crew members, number of VFX shots, hours of post-production labor). Combined with unit_rate to derive budgeted amount.',
    `revised_budgeted_amount` DECIMAL(18,2) COMMENT 'Most recent approved revision to the budgeted amount, reflecting approved change orders, scope changes, or budget transfers. Null if no revision has been approved since original budget.',
    `shoot_date_end` DATE COMMENT 'Planned or actual end date for the activity or service associated with this budget line. Used for scheduling, resource allocation, and cost accrual period determination.',
    `shoot_date_start` DATE COMMENT 'Planned or actual start date for the activity or service associated with this budget line (e.g., first day of location shoot, start of VFX work, commencement of post-production labor).',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `tax_credit_eligible` BOOLEAN COMMENT 'Flag indicating whether this budget line qualifies for production tax credits or incentives (e.g., UK High-End TV Tax Relief, US state film tax credits). Enables automated calculation of eligible spend for tax credit claims.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity field (e.g., day, hour, week, flat_fee, shot, reel, license). Defines how the quantity is counted for rate-based cost calculations. [ENUM-REF-CANDIDATE: day|hour|week|flat_fee|shot|reel|license|unit — 8 candidates stripped; promote to reference product]',
    `unit_rate` DECIMAL(18,2) COMMENT 'Rate per unit of measure for this budget line (e.g., daily rate for a crew member, hourly rate for facility hire, per-shot rate for VFX). Multiplied by quantity to derive the budgeted amount.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line record was most recently modified. Supports incremental data loading in the Databricks Silver Layer and change data capture from SAP S/4HANA.',
    `wbs_element` STRING COMMENT 'SAP Work Breakdown Structure element code that hierarchically positions this budget line within the production project plan (e.g., PRD-2024-001.3.2.1 for a specific post-production task).',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Individual line-item within a production budget, representing a specific cost category or account code (e.g., cast fees, location fees, equipment rental, VFX, music licensing, post-production labor). Captures account code, cost category, sub-category, vendor or payee, budgeted amount, committed amount, actual amount, episode or segment allocation, and SAP G/L account reference. Enables granular cost tracking and variance analysis at the line-item level. [DEMO-FITNESS] MVM demo-fitness: Churn prediction & win-back (D2C SVOD) [rating=5/5, status=done]; Rights availability & windowing [rating=5/5, status=best-in-class]; Linear playout + as-run reconciliation [rating=5/5, status=complete]; Production cost & budget vs. actuals [rating=4/5, status=strong]; Compliance / regulatory reporting [rating=5/5, status=complete]; Overall bottom-line [rating=n/a/5, status=substantially above average]';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` (
    `crew_assignment_id` BIGINT COMMENT 'Unique surrogate identifier for a crew assignment record in the production domain. Primary key for the crew_assignment data product.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.contract. Business justification: Payroll and union compliance require every crew assignment to reference the governing talent contract to validate contracted_rate, overtime_eligible, residuals_eligible, and union_guild_affiliation te',
    `deal_memo_id` BIGINT COMMENT 'Foreign key linking to talent.deal_memo. Business justification: Before a long-form contract is executed, crew assignments are issued against deal memos. Production coordinators need to track which deal memo authorizes each assignment for start-work approvals and t',
    `project_id` BIGINT COMMENT 'Reference to the production project to which this crew member is assigned. Links the assignment to the master production record.',
    `profile_id` BIGINT COMMENT 'Reference to the crew members master record in the talent domain. Identifies the individual below-the-line crew member being assigned.',
    `assignment_number` STRING COMMENT 'Externally-known business identifier for this crew assignment, used in deal memos, call sheets, and payroll processing. Format: CA-{YEAR}-{SEQUENCE}.. Valid values are `^CA-[0-9]{4}-[0-9]{6}$`',
    `box_rental_rate` DECIMAL(18,2) COMMENT 'Daily or weekly rate paid to the crew member for the rental of their personal tool box or specialized equipment package (e.g., makeup artists kit, wardrobe supervisors supplies). Distinct from kit_rental_rate which covers technical equipment.',
    `contracted_rate` DECIMAL(18,2) COMMENT 'The agreed compensation rate for this crew assignment, expressed in the applicable deal_type unit (per day, per week, or flat total). Stored in the productions base currency. Used for budget tracking and payroll processing in SAP S/4HANA.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this crew assignment record was first created in the system. Used for audit trail, data lineage, and compliance reporting. Conforms to ISO 8601 format with timezone offset.',
    `credit_name` STRING COMMENT 'The name as it should appear in the productions end credits, which may differ from the crew members legal name (e.g., stage name, preferred professional name). Sourced from the deal memo credit clause.',
    `credit_position` STRING COMMENT 'Specifies where the crew members credit appears in the production: main_title (opening credits), end_title (closing credits), both, or none (no contractual credit obligation). Drives post-production credit sequence assembly.. Valid values are `main_title|end_title|both|none`',
    `dalet_workflow_reference` STRING COMMENT 'The workflow instance identifier in Dalet Galaxy that corresponds to this crew assignments production workflow. Enables traceability between the HR/payroll record and the media asset management workflow orchestration system.',
    `department` STRING COMMENT 'The production department to which the crew member belongs for this assignment (e.g., camera, grip, electric, art, wardrobe, hair/makeup, post-production, sound, VFX). Drives crew call sheet grouping and budget cost center allocation. [ENUM-REF-CANDIDATE: camera|grip|electric|art|wardrobe|hair_makeup|post_production|sound|vfx|production — 10 candidates stripped; promote to reference product]',
    `end_date` DATE COMMENT 'The contractually agreed last day of work for this crew assignment. Nullable for open-ended or rolling assignments. Used for wrap scheduling and final payroll processing.',
    `filming_location_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary filming location where this crew member will work. Determines applicable labor laws, tax treaties, work permit requirements, and per diem rates.. Valid values are `^[A-Z]{3}$`',
    `guaranteed_days` STRING COMMENT 'The minimum number of work days guaranteed to the crew member under this assignment deal, regardless of actual production schedule. Relevant for weekly and episodic deal types. Used for take-or-pay liability calculation.',
    `kit_rental_rate` DECIMAL(18,2) COMMENT 'Daily or weekly rate paid to the crew member for the rental of their personal professional equipment (kit) used on the production (e.g., camera operators lens kit, sound mixers equipment package). Common in below-the-line crew deals.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this crew assignment record was most recently modified. Used for change data capture (CDC), audit trail, and Silver layer incremental processing in the Databricks Lakehouse.',
    `meal_penalty_eligible` BOOLEAN COMMENT 'Indicates whether this crew member is entitled to meal penalty payments if the production fails to provide a meal break within the contractually required interval (typically 6 hours under IATSE/DGA agreements). Drives production scheduling compliance.',
    `omc_asset_structural_characteristic_code` BIGINT COMMENT 'OMC Asset Structural Characteristic identifier describing structural/technical asset traits',
    `omc_concept_role` STRING COMMENT 'MovieLabs OMC structural concept role for this entity: Participant',
    `omc_context_code` BIGINT COMMENT 'OMC Context identifier grouping this production entity into a creative/production context',
    `omc_participant_code` BIGINT COMMENT 'OMC Participant identifier (person/organization/service performing or owning this entity)',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether this crew member is eligible for overtime pay under their union/guild agreement or applicable labor law. True = eligible for overtime; False = flat deal or exempt classification. Drives payroll calculation logic.',
    `overtime_rate_multiplier` DECIMAL(18,2) COMMENT 'The multiplier applied to the base contracted_rate for overtime hours (e.g., 1.5 for time-and-a-half, 2.0 for double-time). Applicable only when overtime_eligible is True. Sourced from the applicable union/guild agreement.',
    `per_diem_rate` DECIMAL(18,2) COMMENT 'Daily allowance paid to the crew member for meals and incidental expenses when working away from their home base location. Rate varies by filming location and union agreement. Used for production cost budgeting.',
    `production_company` STRING COMMENT 'The legal name of the production company or entity that is the employer of record for this crew assignment. Relevant for co-productions where multiple entities may employ different crew members. Used for payroll and tax reporting.',
    `residuals_eligible` BOOLEAN COMMENT 'Indicates whether this crew member is entitled to residual payments when the production is reused, syndicated, or distributed on additional platforms (e.g., streaming, international broadcast). Residuals are governed by DGA, IATSE, and SAG-AFTRA agreements.',
    `role_title` STRING COMMENT 'The specific production role or job title assigned to the crew member (e.g., Director, Director of Photography, Gaffer, Script Supervisor, Editor, Colorist, VFX Supervisor, Sound Mixer, Key Grip, Best Boy). [ENUM-REF-CANDIDATE: director|director_of_photography|gaffer|script_supervisor|editor|colorist|vfx_supervisor|sound_mixer|key_grip|best_boy|production_designer|costume_designer — promote to reference product]',
    `safety_training_certified` BOOLEAN COMMENT 'Indicates whether the crew member has completed the required on-set safety training certification for this production (e.g., OSHA safety, COVID-19 protocols, stunt safety). Required for insurance compliance and production liability management.',
    `scheduled_days` STRING COMMENT 'The total number of work days currently scheduled for this crew member on the production, as reflected in the current production schedule. May differ from guaranteed_days if the schedule changes.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `start_date` DATE COMMENT 'The contractually agreed first day of work for this crew assignment. Used for payroll calculation, permit verification, and production schedule alignment.',
    `travel_allowance` DECIMAL(18,2) COMMENT 'Fixed or estimated travel reimbursement amount for this crew assignment, covering transportation costs to and from the filming location. Distinct from per_diem_rate which covers daily living expenses.',
    `turnaround_hours` DECIMAL(18,2) COMMENT 'The minimum number of hours required between the end of one work day and the start of the next for this crew member, as stipulated by their union/guild agreement (e.g., 10 hours for IATSE, 12 hours for DGA). Violation triggers turnaround penalty payments.',
    `union_guild_affiliation` STRING COMMENT 'The labor union or guild to which the crew member belongs for this assignment. Determines applicable minimum rates, working conditions, residuals obligations, and benefit fund contributions. DGA = Directors Guild of America; IATSE = International Alliance of Theatrical Stage Employees; SAG-AFTRA = Screen Actors Guild–American Federation of Television and Radio Artists; WGA = Writers Guild of America; NABET = National Association of Broadcast Employees and Technicians; Teamsters = International Brotherhood of Teamsters. [ENUM-REF-CANDIDATE: DGA|IATSE|SAG-AFTRA|WGA|NABET|Teamsters|non_union — 7 candidates stripped; promote to reference product]',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `work_permit_expiry_date` DATE COMMENT 'The expiration date of the crew members work permit or visa authorization. Used to trigger renewal alerts and ensure continuous legal work authorization throughout the assignment period.',
    `work_permit_number` STRING COMMENT 'The official government-issued work permit or visa authorization number for the crew member in the production jurisdiction. Nullable when work_permit_required is False. Required for compliance audits and production insurance.',
    `work_permit_required` BOOLEAN COMMENT 'Indicates whether a work permit or visa authorization is required for this crew member to legally work on this production in the filming jurisdiction. True = permit required; False = no permit required (domestic/citizen crew). Triggers compliance workflow in HR.',
    CONSTRAINT pk_crew_assignment PRIMARY KEY(`crew_assignment_id`)
) COMMENT 'Assignment of a crew member to a specific production project in a defined role and department. Captures crew role (director, DP, gaffer, script supervisor, editor, colorist, VFX supervisor, sound mixer), department (camera, grip, electric, art, wardrobe, hair/makeup, post-production), start date, end date, deal type (daily, weekly, flat), contracted rate, union or guild affiliation (DGA, IATSE, SAG-AFTRA), overtime eligibility, work permit status, and assignment status. References the talent domain for the crew members master record. Tracks the full below-the-line crew roster for a production. [DEMO-FITNESS] MVM demo-fitness: Churn prediction & win-back (D2C SVOD) [rating=5/5, status=done]; Rights availability & windowing [rating=5/5, status=best-in-class]; Linear playout + as-run reconciliation [rating=5/5, status=complete]; Production cost & budget vs. actuals [rating=4/5, status=strong]; Compliance / regulatory reporting [rating=5/5, status=complete]; Overall bottom-line [rating=n/a/5, status=substantially above average]';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` (
    `facility_booking_id` BIGINT COMMENT 'Unique surrogate identifier for each facility booking record in the production domain. Primary key for the facility_booking data product.',
    `episode_id` BIGINT COMMENT 'Identifier of the specific episode or segment within the production project that requires this facility booking. Nullable for feature films or non-episodic productions.',
    `project_id` BIGINT COMMENT 'Identifier of the production project for which this facility is being booked. Links the booking to the overarching content production initiative.',
    `shoot_schedule_id` BIGINT COMMENT 'Foreign key linking to production.shoot_schedule. Business justification: Facility bookings are made for specific shoot schedule entries. Operational link — booking times align with shoot schedule. Optional FK (nullable) — facilities may also be booked for post-production o',
    `actual_cost` DECIMAL(18,2) COMMENT 'The final invoiced or accrued cost of the facility booking after actual usage is confirmed. Includes any overtime charges or adjustments. Reconciled against estimated_cost for budget variance reporting in SAP S/4HANA CO.',
    `actual_end` TIMESTAMP COMMENT 'The actual date and time the facility usage concluded, as recorded by the facility operator or production coordinator. Used for overtime calculation, billing reconciliation, and schedule variance reporting.',
    `actual_start` TIMESTAMP COMMENT 'The actual date and time the facility usage commenced, as recorded by the facility operator or production coordinator. May differ from booking_start due to delays or early starts. Used for variance analysis and billing reconciliation.',
    `booking_end` TIMESTAMP COMMENT 'The scheduled date and time at which the facility booking period ends. Combined with booking_start to compute duration and detect scheduling conflicts across productions.',
    `booking_reference` STRING COMMENT 'Externally visible alphanumeric reference code assigned to this booking, used in communications with facility operators, vendors, and production coordinators. Corresponds to the booking order number in SAP S/4HANA MM module.. Valid values are `^BK-[A-Z0-9]{8,16}$`',
    `booking_start` TIMESTAMP COMMENT 'The scheduled date and time at which the facility booking period begins. Used for conflict detection, crew scheduling, and playout coordination. Stored in ISO 8601 format with timezone offset.',
    `cancellation_date` DATE COMMENT 'The date on which the facility booking was formally cancelled. Used to determine whether cancellation fees apply per the vendor contract terms and for financial accrual reversal in SAP S/4HANA.',
    `cancellation_fee` DECIMAL(18,2) COMMENT 'Monetary penalty charged by the facility vendor when a confirmed booking is cancelled within the contractual notice period. Recorded for financial reconciliation and budget variance reporting.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the booking was cancelled. Populated only when booking_status is cancelled. Used for production post-mortem analysis and vendor dispute resolution.',
    `capacity_persons` STRING COMMENT 'Maximum number of persons the facility can accommodate during the booking period. Used for crew planning, health and safety compliance, and resource allocation decisions.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this facility booking record was first created in the system. Serves as the audit trail creation marker and is used for SLA compliance tracking and data lineage.',
    `dalet_workflow_reference` STRING COMMENT 'Reference identifier of the associated workflow job in Dalet Galaxy Media Asset Management system. Enables traceability between the facility booking and the ingest, metadata, or archive workflow triggered by the production activity.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'The projected total cost of the facility booking at the time of reservation, calculated from rate_amount and the planned booking duration. Used for production budget planning and greenlight approvals.',
    `facility_location` STRING COMMENT 'Physical location or campus of the facility (e.g., Burbank Studio Lot, London Soho Post). Used for logistics planning, travel coordination, and geographic cost allocation.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether this booking grants exclusive use of the facility for the booked period, preventing any concurrent bookings by other productions. When False, the facility may be shared with other productions subject to capacity constraints.',
    `notes` STRING COMMENT 'Free-text field for production coordinators to capture special requirements, setup instructions, access arrangements, or other operational notes relevant to the facility booking.',
    `omc_asset_structural_characteristic_code` BIGINT COMMENT 'OMC Asset Structural Characteristic identifier describing structural/technical asset traits',
    `omc_concept_role` STRING COMMENT 'MovieLabs OMC structural concept role for this entity: Context',
    `omc_context_code` BIGINT COMMENT 'OMC Context identifier grouping this production entity into a creative/production context',
    `omc_participant_code` BIGINT COMMENT 'OMC Participant identifier (person/organization/service performing or owning this entity)',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of hours the facility was used beyond the originally booked end time. Drives overtime rate calculations and is a key input to actual_cost reconciliation and production schedule variance analysis.',
    `production_phase` STRING COMMENT 'The stage of the content production lifecycle during which this facility is being used. Enables cost allocation by production phase and supports milestone tracking. [ENUM-REF-CANDIDATE: pre_production|principal_photography|post_production|vfx|color_grading|audio_mix|delivery — promote to reference product]',
    `purchase_order_number` STRING COMMENT 'SAP S/4HANA MM purchase order number raised for this facility booking when the facility is provided by an external vendor. Required for accounts payable processing and three-way match (PO, goods receipt, invoice).',
    `rate_amount` DECIMAL(18,2) COMMENT 'The contracted rate charged for the facility per the applicable rate_type unit (e.g., cost per hour or cost per day). Sourced from the facility rate card or negotiated contract. Used for budget estimation and cost allocation.',
    `rate_type` STRING COMMENT 'The billing rate structure applied to this facility booking. Determines how the total cost is calculated — per hour, per day, half-day block, weekly block, or a negotiated flat fee.. Valid values are `hourly|daily|half_day|weekly|flat_fee`',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `technical_specs` STRING COMMENT 'Free-text description of the technical capabilities and equipment configuration of the facility at the time of booking (e.g., Dolby Atmos 7.1.4 mixing console, Pro Tools HDX, 4K DI suite). Sourced from Dalet Galaxy facility metadata.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this facility booking record was most recently modified. Used for change detection in ETL pipelines, audit compliance, and conflict resolution in concurrent update scenarios.',
    `wbs_element` STRING COMMENT 'SAP S/4HANA Project System Work Breakdown Structure element code that identifies the specific production phase or deliverable to which this facility cost is charged. Enables granular project cost tracking.',
    CONSTRAINT pk_facility_booking PRIMARY KEY(`facility_booking_id`)
) COMMENT 'Reservation and usage record for a production facility — soundstage, editing suite, dubbing stage, color grading suite, ADR studio, screening room, or post-production bay. Captures facility name, facility type, location, booking start datetime, booking end datetime, booked production project, booked episode or segment, booking status (tentative, confirmed, cancelled), rate per hour or day, total cost, and technical specifications of the facility. Enables resource conflict detection and cost allocation. [DEMO-FITNESS] MVM demo-fitness: Churn prediction & win-back (D2C SVOD) [rating=5/5, status=done]; Rights availability & windowing [rating=5/5, status=best-in-class]; Linear playout + as-run reconciliation [rating=5/5, status=complete]; Production cost & budget vs. actuals [rating=4/5, status=strong]; Compliance / regulatory reporting [rating=5/5, status=complete]; Overall bottom-line [rating=n/a/5, status=substantially above average]';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` (
    `equipment_allocation_id` BIGINT COMMENT 'Unique surrogate identifier for each equipment allocation record. Primary key for the equipment_allocation data product in the production domain.',
    `location_id` BIGINT COMMENT 'Foreign key linking to production.location. Business justification: equipment_allocation currently stores shoot_location as a denormalized STRING column. The production.location table is the master record for physical shoot sites with full address, permit, safety, and',
    `project_id` BIGINT COMMENT 'Reference to the production project or title to which this equipment is allocated. Links the allocation to the broader production workflow managed in Dalet Galaxy.',
    `shoot_schedule_id` BIGINT COMMENT 'Foreign key linking to production.shoot_schedule. Business justification: Equipment allocations are operationally tied to specific shoot days — cameras, lighting rigs, and other gear are checked out and deployed for particular scheduled shoot days. Adding shoot_schedule_id ',
    `allocation_end_date` DATE COMMENT 'The date on which the equipment allocation ends — i.e., the last day the equipment is assigned to the production. Used for rental cost calculation and return scheduling.',
    `allocation_number` STRING COMMENT 'Externally-known business identifier for the allocation record, used in production paperwork, crew call sheets, and facility booking confirmations. Format: EQALLOC-{YYYY}-{NNNNNN}.. Valid values are `^EQALLOC-[0-9]{4}-[0-9]{6}$`',
    `allocation_start_date` DATE COMMENT 'The date on which the equipment allocation begins — i.e., the first day the equipment is available to the production. Used for rental rate calculation and scheduling conflict detection.',
    `checkout_condition` STRING COMMENT 'Assessed physical condition of the equipment at the time of checkout. Establishes the baseline condition for damage assessment upon return. Recorded by the equipment manager.. Valid values are `new|excellent|good|fair|poor`',
    `checkout_timestamp` TIMESTAMP COMMENT 'Exact date and time the equipment was physically checked out from the equipment room or rental house. Serves as the principal business event timestamp for the allocation lifecycle.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the equipment allocation record was first created in the system. Supports audit trail requirements and data lineage tracking in the Databricks Silver Layer.',
    `dalet_workflow_reference` STRING COMMENT 'Identifier of the associated Dalet Galaxy workflow instance that orchestrates the equipment allocation within the broader production ingest and post-production pipeline. Enables end-to-end workflow traceability.',
    `damage_claim_amount` DECIMAL(18,2) COMMENT 'Monetary value of the damage or loss claim raised against this allocation, in the currency specified by currency_code. Null when no damage claim exists. Used for financial reconciliation and insurance recovery.',
    `damage_description` STRING COMMENT 'Free-text description of any damage, loss, or malfunction identified at return. Null when equipment is returned in acceptable condition. Used to support insurance claims and vendor dispute resolution.',
    `equipment_name` STRING COMMENT 'Human-readable name or model designation of the equipment item (e.g., ARRI ALEXA Mini LF, Cooke S4/i 32mm, Litepanels Astra 6X). Supports crew call sheets and production reports.',
    `insurance_policy_number` STRING COMMENT 'Reference number of the insurance policy covering this equipment allocation. Used for claims processing and compliance with production insurance requirements.',
    `insurance_value` DECIMAL(18,2) COMMENT 'Declared replacement value of the equipment for insurance purposes, in the currency specified by currency_code. Used to calculate insurance premiums and process loss/damage claims.',
    `is_insurance_required` BOOLEAN COMMENT 'Indicates whether specific insurance coverage must be arranged for this equipment allocation (True) or whether it falls under the productions blanket policy (False). Relevant for high-value or specialist equipment.',
    `is_owned_asset` BOOLEAN COMMENT 'Indicates whether the equipment is owned by the production company (True) or rented from an external vendor (False). Drives depreciation accounting vs. rental cost booking in SAP S/4HANA FI.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes related to the equipment allocation, such as special handling instructions, configuration requirements, or crew briefing notes.',
    `omc_asset_structural_characteristic_code` BIGINT COMMENT 'OMC Asset Structural Characteristic identifier describing structural/technical asset traits',
    `omc_concept_role` STRING COMMENT 'MovieLabs OMC structural concept role for this entity: Participant',
    `omc_context_code` BIGINT COMMENT 'OMC Context identifier grouping this production entity into a creative/production context',
    `omc_participant_code` BIGINT COMMENT 'OMC Participant identifier (person/organization/service performing or owning this entity)',
    `production_department` STRING COMMENT 'The production department responsible for the equipment allocation (e.g., camera, lighting, grip, sound). Used for departmental budget tracking and cost centre allocation in SAP S/4HANA CO. [ENUM-REF-CANDIDATE: camera|lighting|grip|sound|art|vfx|post_production|production_office|other — promote to reference product]',
    `purchase_order_number` STRING COMMENT 'SAP S/4HANA purchase order number raised for the equipment rental from an external vendor. Null for owned assets. Used for three-way match (PO, goods receipt, invoice) in accounts payable.',
    `quantity` STRING COMMENT 'Number of identical equipment units covered by this allocation record (e.g., 3 identical LED panels allocated as a single record). Defaults to 1 for individually serialised items.',
    `rental_rate_amount` DECIMAL(18,2) COMMENT 'The agreed rental rate per day or per week (per rental_rate_type) for the equipment, in the productions base currency. Used for production budget tracking and vendor cost reconciliation in SAP S/4HANA.',
    `rental_rate_type` STRING COMMENT 'Indicates whether the rental rate is charged on a daily, weekly, or flat-fee basis. Determines how the total rental cost is computed for budget tracking and vendor invoice reconciliation.. Valid values are `daily|weekly|flat_fee`',
    `return_condition` STRING COMMENT 'Assessed physical condition of the equipment at the time of return. Compared against checkout_condition to identify damage or deterioration. Triggers damage claim workflow if degraded. [ENUM-REF-CANDIDATE: new|excellent|good|fair|poor|damaged|lost — 7 candidates stripped; promote to reference product]',
    `return_timestamp` TIMESTAMP COMMENT 'Exact date and time the equipment was physically returned to the equipment room or rental house. Null until the equipment is returned. Used to calculate actual rental duration and late return penalties.',
    `serial_number` STRING COMMENT 'Manufacturer serial number of the specific equipment unit allocated. Used for asset tracking, insurance claims, and loss/damage investigations. Classified confidential as it identifies a specific high-value asset.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the equipment allocation record was last modified. Used for change data capture (CDC) in the Databricks Silver Layer pipeline and audit compliance.',
    CONSTRAINT pk_equipment_allocation PRIMARY KEY(`equipment_allocation_id`)
) COMMENT 'Allocation record tracking the assignment of production equipment (cameras, lenses, lighting rigs, sound packages, jibs, drones, editing workstations, encoding hardware) to a production project or shoot day. Captures equipment item, equipment category, serial number, rental vendor or owned asset flag, allocation start date, allocation end date, daily or weekly rental rate, insurance value, condition at checkout, condition at return, and responsible crew member. Supports equipment cost tracking and loss/damage management. [DEMO-FITNESS] MVM demo-fitness: Churn prediction & win-back (D2C SVOD) [rating=5/5, status=done]; Rights availability & windowing [rating=5/5, status=best-in-class]; Linear playout + as-run reconciliation [rating=5/5, status=complete]; Production cost & budget vs. actuals [rating=4/5, status=strong]; Compliance / regulatory reporting [rating=5/5, status=complete]; Overall bottom-line [rating=n/a/5, status=substantially above average]';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`script` (
    `script_id` BIGINT COMMENT 'Unique identifier for the production script or screenplay record. Primary key.',
    `clearance_request_id` BIGINT COMMENT 'Foreign key linking to rights.clearance_request. Business justification: Script clearance is a named pre-production process: scripts containing music, third-party IP, or underlying works require a formal clearance request before production proceeds. Production teams must t',
    `episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Scripts correspond to specific episodes in episodic production. Writers room management, WGA registration, and music cue sheet workflows require script-to-episode traceability. script.title_id covers ',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Script documents (PDF, Final Draft files) are stored as media assets in broadcasting MAM systems. Rights clearance and WGA compliance workflows require linking the script record to its digital asset r',
    `project_id` BIGINT COMMENT 'Reference to the parent production project or episode to which this script belongs.',
    `program_rundown_id` BIGINT COMMENT 'Foreign key linking to scheduling.program_rundown. Business justification: Live and scripted broadcast operations: a program rundown is built directly from the approved production script. Rundown producers reference the locked script version; this link supports script-to-run',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Scripts are written for specific content titles. Essential for pre-production planning, rights clearance (script-based content analysis), and tracking script versions against final distributed content',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.rights_holder. Business justification: Scripts are often based on underlying IP owned by rights holders (novels, plays, life rights, true stories, existing franchises). Real business need: tracking the rights holder of the underlying IP be',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Scripts based on underlying IP (novels, articles, prior works) require a dedicated license agreement for the underlying rights, distinct from the project-level master license. This underlying rights ',
    `profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: WGA registration, residual eligibility, and credit arbitration require linking a script to the writers talent profile. script.writer_credits is a denormalized text field; a proper FK enables writer r',
    `approval_date` DATE COMMENT 'The date on which the script was officially approved for production.',
    `approved_by` STRING COMMENT 'The name or identifier of the individual or role who approved the script for production.',
    `copyright_holder` STRING COMMENT 'The legal entity or individual who holds the copyright to the script.',
    `copyright_year` STRING COMMENT 'The year in which the script copyright was established or registered.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this script record was first created in the system.',
    `dalet_document_reference` STRING COMMENT 'The unique document identifier or reference in the Dalet Galaxy Media Asset Management (MAM) system linking this script record to the digital script file.',
    `distribution_restriction` STRING COMMENT 'Any restrictions or limitations on the distribution or sharing of the script (e.g., internal use only, NDA required).',
    `estimated_runtime_minutes` STRING COMMENT 'The estimated runtime of the production in minutes based on the script length and pacing.',
    `file_size_mb` DECIMAL(18,2) COMMENT 'The size of the script file in megabytes.',
    `format` STRING COMMENT 'The production format for which the script is intended (feature film, television episode, miniseries, web series, documentary, commercial, short film). [ENUM-REF-CANDIDATE: feature film|television episode|miniseries|web series|documentary|commercial|short film — 7 candidates stripped; promote to reference product]',
    `genre` STRING COMMENT 'The genre or category of the script (e.g., drama, comedy, thriller, documentary).',
    `language` STRING COMMENT 'The primary language in which the script is written (e.g., English, Spanish, French).',
    `lock_date` DATE COMMENT 'The date on which the script was locked and finalized for production.',
    `lock_status` BOOLEAN COMMENT 'Indicates whether the script is locked for production (true) or still open for revisions (false).',
    `notes` STRING COMMENT 'General notes, comments, or annotations related to the script for production reference.',
    `omc_asset_structural_characteristic_code` BIGINT COMMENT 'OMC Asset Structural Characteristic identifier describing structural/technical asset traits',
    `omc_concept_role` STRING COMMENT 'MovieLabs OMC structural concept role for this entity: Asset Structural Characteristic',
    `omc_context_code` BIGINT COMMENT 'OMC Context identifier grouping this production entity into a creative/production context',
    `omc_participant_code` BIGINT COMMENT 'OMC Participant identifier (person/organization/service performing or owning this entity)',
    `page_count` STRING COMMENT 'The total number of pages in the script document.',
    `revision_date` DATE COMMENT 'The date of the most recent revision or update to the script.',
    `revision_notes` STRING COMMENT 'Notes or comments describing the changes made in the current revision of the script.',
    `scene_count` STRING COMMENT 'The total number of scenes defined in the script.',
    `script_number` STRING COMMENT 'The externally-known unique identifier or code assigned to this script for production tracking and reference purposes.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this script record was last updated or modified.',
    `version_number` STRING COMMENT 'The version or revision number of the script (e.g., 1.0, 2.3, Final).',
    `wga_registration_number` STRING COMMENT 'The WGA registration number assigned to this script for copyright and intellectual property protection.',
    CONSTRAINT pk_script PRIMARY KEY(`script_id`)
) COMMENT 'Master record for a production script or screenplay associated with a production project or episode. Captures script title, version number, draft type (outline, first draft, revised draft, shooting script, post-production script), writer credits, WGA registration number, page count, script lock status, lock date, language, and Dalet Galaxy document reference. Tracks the full script revision history and serves as the authoritative script record for production and rights purposes. [DEMO-FITNESS] MVM demo-fitness: Churn prediction & win-back (D2C SVOD) [rating=5/5, status=done]; Rights availability & windowing [rating=5/5, status=best-in-class]; Linear playout + as-run reconciliation [rating=5/5, status=complete]; Production cost & budget vs. actuals [rating=4/5, status=strong]; Compliance / regulatory reporting [rating=5/5, status=complete]; Overall bottom-line [rating=n/a/5, status=substantially above average]';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` (
    `deliverable_id` BIGINT COMMENT 'Unique identifier for the production deliverable. Primary key.',
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: Each deliverable conforms to specific ABR encoding profile for adaptive streaming distribution. Real business process: transcoding workflow configuration, encoding quality control, and streaming optim',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: A deliverable is a specific versioned file output (e.g., 1080p H.264 for a platform). Platform delivery compliance reports and QC sign-off workflows require linking the deliverable to the exact asset_',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Deliverables are channel-specific: aspect ratio, resolution, loudness, codec, and closed-caption specs differ per channel. Traffic and operations teams must know which channel a deliverable targets to',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: A production deliverable, once QC-approved, is registered as a content version in the media supply chain. Linking deliverable→content.version enables traceability from production output to distributio',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Deliverables are produced to meet the technical specifications of a specific delivery channel (FAST, linear, OTT). The production-to-distribution handoff process requires knowing which delivery channe',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: Deliverables require specific DRM protection policies based on content rights and platform requirements. Real business process: content protection enforcement, rights management, and secure delivery c',
    `episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Deliverables are produced for specific episodes (e.g., S01E03 master file). Episode-level deliverable tracking is a standard broadcast operations requirement for scheduling, QC assignment, and on-air ',
    `isci_creative_id` BIGINT COMMENT 'Foreign key linking to sales.isci_creative. Business justification: Branded content deliverables often ARE the ad creative asset delivered to advertisers. Business process: branded content asset delivery to advertisers, product integration segment handoff, advertiser ',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Deliverables are created to fulfill specific license agreement technical and format requirements (e.g., HD master for territory X, dubbed version for territory Y). Real business need: linking delivera',
    `media_asset_id` BIGINT COMMENT 'Reference to the digital media asset in the Media Asset Management (MAM) system that represents this deliverable. Links to Dalet Galaxy or other MAM upon delivery.',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to production.milestone. Business justification: Deliverables are milestone-driven outputs in a production workflow — e.g., a Picture Lock deliverable is tied to the Picture Lock milestone, a Final Mix deliverable to the Audio Mix Complete m',
    `project_id` BIGINT COMMENT 'Reference to the parent production project that this deliverable belongs to.',
    `release_window_id` BIGINT COMMENT 'Foreign key linking to distribution.release_window. Business justification: Deliverables are created to fulfill specific release window obligations (SVOD premiere, AVOD, EST). Production teams must track which release window a deliverable satisfies to ensure on-time delivery ',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: Core broadcast traffic workflow: a deliverable is assigned to fulfill a specific schedule slot. Traffic and operations teams verify the correct deliverable is available and QC-approved for each slots',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: Deliverables are ingested and published to specific streaming endpoints. The technical delivery process requires knowing the target endpoint for upload, ingest validation, and CDN origin configuration',
    `subscription_plan_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscription_plan. Business justification: OTT production pipelines encode deliverables to specific quality tiers (4K/HD/SD) that map directly to subscription plans. The Deliverable-to-Plan Tier Mapping process drives encoding specs, QC acce',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Deliverables are formatted for specific platforms with platform-specific technical requirements (resolution, codec, DRM). Real business process: platform-specific asset preparation, transcoding, and d',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Deliverables are final production outputs that become content titles in the distribution system. Critical for asset-to-content mapping, delivery acceptance workflows, and tracking which production del',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Actual date and time when the deliverable was successfully delivered or handed off.',
    `aspect_ratio` DECIMAL(18,2) COMMENT 'Display aspect ratio of the video deliverable (e.g., 16:9, 4:3, 2.39:1, 1:1). Null for non-video deliverables.',
    `audio_channels` STRING COMMENT 'Audio channel configuration for the deliverable (e.g., Stereo, 5.1 Surround, 7.1 Surround, Mono, Dolby Atmos). Null for non-audio deliverables.',
    `audio_description_flag` BOOLEAN COMMENT 'Indicates whether an audio description track for visually impaired viewers is included. True = audio description present; False = no audio description.',
    `checksum_md5` STRING COMMENT 'MD5 hash of the deliverable file for integrity verification during transfer and storage.. Valid values are `^[a-f0-9]{32}$`',
    `closed_caption_flag` BOOLEAN COMMENT 'Indicates whether closed captions for accessibility are included in this deliverable. True = closed captions present; False = no closed captions.',
    `compliance_certificate_flag` BOOLEAN COMMENT 'Indicates whether a regulatory compliance certificate (e.g., FCC, Ofcom, content rating) accompanies this deliverable. True = certificate included; False = no certificate.',
    `contract_reference` STRING COMMENT 'Reference number or identifier of the contract or agreement that mandates this deliverable.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred to produce this deliverable, including labor, equipment, facilities, and post-production services.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this deliverable record was first created in the system.',
    `delivery_location` STRING COMMENT 'Physical address, URL, FTP path, or cloud storage location where the deliverable was sent or made available.',
    `due_date` DATE COMMENT 'Contractually or operationally required date by which this deliverable must be completed and handed off.',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Total runtime duration of the deliverable in seconds (for video/audio deliverables). Null for non-time-based deliverables like documents or images.',
    `file_size_bytes` BIGINT COMMENT 'Total file size of the deliverable in bytes. Used for storage planning, transfer time estimation, and CDN capacity management.',
    `deliverable_name` STRING COMMENT 'Human-readable name or title of the deliverable (e.g., Broadcast Master HD, Promo Cut 30s, Closed Caption SRT File).',
    `omc_asset_structural_characteristic_code` BIGINT COMMENT 'OMC Asset Structural Characteristic identifier describing structural/technical asset traits',
    `omc_concept_role` STRING COMMENT 'MovieLabs OMC structural concept role for this entity: Asset Structural Characteristic',
    `omc_context_code` BIGINT COMMENT 'OMC Context identifier grouping this production entity into a creative/production context',
    `omc_participant_code` BIGINT COMMENT 'OMC Participant identifier (person/organization/service performing or owning this entity)',
    `qc_notes` STRING COMMENT 'Detailed notes from the quality control review, including any issues found, corrective actions taken, or validation comments.',
    `qc_operator_name` STRING COMMENT 'Name of the quality control technician or automated system that performed the QC validation.',
    `qc_pass_flag` BOOLEAN COMMENT 'Indicates whether the deliverable passed quality control validation. True = passed QC; False = failed QC or not yet tested.',
    `qc_performed_timestamp` TIMESTAMP COMMENT 'Date and time when quality control validation was completed for this deliverable.',
    `revision_notes` STRING COMMENT 'Description of changes made in this revision of the deliverable (e.g., Corrected audio sync issue, Updated end credits, Re-encoded for HDR).',
    `revision_number` STRING COMMENT 'Version or revision number of this deliverable. Increments when the deliverable is updated or redelivered after corrections.',
    `scheduled_delivery_timestamp` TIMESTAMP COMMENT 'Planned date and time for delivery of this deliverable to the recipient or platform.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `subtitle_languages` STRING COMMENT 'Comma-separated list of language codes for subtitle tracks included in this deliverable (e.g., en,es,fr). Null if no subtitles are included.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this deliverable record was last modified.',
    CONSTRAINT pk_deliverable PRIMARY KEY(`deliverable_id`)
) COMMENT 'Contractually or operationally required output deliverable from a production project — the specific media asset or document that must be produced and handed off. Captures deliverable name, deliverable type (broadcast master, streaming master, promo cut, trailer, EPK, closed caption file, audio description track, subtitles, M&E track, textless version, compliance certificate), target format, target platform or recipient, due date, actual delivery date, delivery status, and QC pass/fail flag. Links to the digital asset management domain upon delivery. [DEMO-FITNESS] MVM demo-fitness: Churn prediction & win-back (D2C SVOD) [rating=5/5, status=done]; Rights availability & windowing [rating=5/5, status=best-in-class]; Linear playout + as-run reconciliation [rating=5/5, status=complete]; Production cost & budget vs. actuals [rating=4/5, status=strong]; Compliance / regulatory reporting [rating=5/5, status=complete]; Overall bottom-line [rating=n/a/5, status=substantially above average]';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` (
    `qc_review_id` BIGINT COMMENT 'Unique identifier for the quality control review record. Primary key.',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Production QC reviews are performed on a specific asset version (e.g., 4K HDR vs 1080p SDR). Broadcaster compliance and re-QC workflows require knowing which version was reviewed; the existing media_a',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: QC reviews are channel-specific: each channel has distinct loudness (LUFS), resolution, codec, and closed-caption compliance standards. QC operators must know the target channel to apply the correct t',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: QC reviews validate specific content versions for distribution. Essential for version-level quality tracking, linking production QC to content version records, and ensuring only QC-passed versions are',
    `deliverable_id` BIGINT COMMENT 'Reference to the production deliverable or post-production output being reviewed.',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: QC reviews validate content against the technical standards of the target delivery channel (resolution, audio config, caption requirements). The delivery channel defines acceptance criteria; QC operat',
    `isci_creative_id` BIGINT COMMENT 'Foreign key linking to sales.isci_creative. Business justification: Ad clearance / commercial QC process: QC teams review isci_creative assets for broadcast compliance (loudness, closed captions, codec) before trafficking. Ad ops requires QC pass status on each isci_c',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Production QC reviews inspect specific media assets for technical compliance before delivery. Role-prefixed as reviewed_asset_id since qc_review already links to deliverable. Essential for broadcast c',
    `project_id` BIGINT COMMENT 'Reference to the parent production project this QC review belongs to.',
    `qc_inspection_id` BIGINT COMMENT 'Foreign key linking to mediaasset.qc_inspection. Business justification: End-to-end QC traceability reports required by broadcasters link the editorial/compliance production QC review to the technical file QC inspection in the MAM. Regulators and delivery partners require ',
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: QC reviews validate deliverables against target ABR profile specifications for distribution readiness. Real business process: quality assurance for streaming assets, technical compliance validation, a',
    `audio_channel_configuration` STRING COMMENT 'Audio channel layout (e.g., stereo, 5.1 surround, 7.1 surround, mono).',
    `audio_codec` STRING COMMENT 'Audio codec used in the deliverable (e.g., AAC, Dolby Digital, PCM).',
    `audio_description_compliance_flag` BOOLEAN COMMENT 'Indicates whether audio description track meets accessibility standards. True if compliant, False if missing or non-compliant.',
    `closed_caption_compliance_flag` BOOLEAN COMMENT 'Indicates whether closed captions meet accessibility and regulatory standards (FCC, CVAA). True if compliant, False if violations detected.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the QC review record was first created in the system.',
    `dalet_workflow_reference` STRING COMMENT 'Identifier linking this QC review to the corresponding workflow instance in Dalet Galaxy MAM for ingest and workflow orchestration.',
    `error_codes` STRING COMMENT 'Comma-separated list of specific error codes identified during the review, aligned with EBU R128, ATSC A/85, and ITU-R BT.1788 standards (e.g., V001 for video freeze, A002 for loudness violation, C003 for closed caption sync error).',
    `final_approval_date` DATE COMMENT 'Date when the deliverable received final approval for distribution. Null if not yet approved.',
    `loudness_compliance_flag` BOOLEAN COMMENT 'Indicates whether the deliverable meets loudness standards (EBU R128 or ATSC A/85). True if compliant, False if violations detected.',
    `loudness_lufs` DECIMAL(18,2) COMMENT 'Measured integrated loudness level in LUFS (Loudness Units relative to Full Scale) per EBU R128 or ATSC A/85 standards. Target is typically -23 LUFS for broadcast.',
    `omc_asset_structural_characteristic_code` BIGINT COMMENT 'OMC Asset Structural Characteristic identifier describing structural/technical asset traits',
    `omc_concept_role` STRING COMMENT 'MovieLabs OMC structural concept role for this entity: Asset Structural Characteristic',
    `omc_context_code` BIGINT COMMENT 'OMC Context identifier grouping this production entity into a creative/production context',
    `omc_participant_code` BIGINT COMMENT 'OMC Participant identifier (person/organization/service performing or owning this entity)',
    `p1_critical_error_count` STRING COMMENT 'Number of P1 critical errors that prevent broadcast or distribution (e.g., audio dropout, video corruption, missing segments).',
    `p2_major_error_count` STRING COMMENT 'Number of P2 major errors that significantly impact quality but may not prevent distribution (e.g., color grading inconsistencies, audio sync issues).',
    `p3_minor_error_count` STRING COMMENT 'Number of P3 minor errors that have minimal impact on viewer experience (e.g., minor subtitle timing issues, cosmetic artifacts).',
    `qc_notes` STRING COMMENT 'Free-text notes and observations recorded by the QC operator during the review, including context for errors and recommendations.',
    `qc_platform` STRING COMMENT 'Name of the QC platform or tool used to perform the review (e.g., Dalet Galaxy QC module, Tektronix Sentry, Interra Baton).',
    `qc_result` STRING COMMENT 'Overall result of the QC review: pass (no issues), fail (critical issues preventing distribution), conditional pass (minor issues requiring remediation), or pending review (awaiting final approval).. Valid values are `pass|fail|conditional_pass|pending_review`',
    `re_qc_date` DATE COMMENT 'Date when the deliverable was re-reviewed after remediation. Null if no re-QC has been performed.',
    `remediation_notes` STRING COMMENT 'Detailed notes describing the remediation actions required to address identified errors and bring the deliverable into compliance.',
    `remediation_required_flag` BOOLEAN COMMENT 'Indicates whether the deliverable requires remediation or correction before final approval. True if remediation needed, False if no action required.',
    `review_date` DATE COMMENT 'Date when the QC review was performed.',
    `review_duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the QC review session in minutes.',
    `review_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the QC operator completed the review session.',
    `review_number` STRING COMMENT 'Business identifier for the QC review, typically formatted as a human-readable reference code.',
    `review_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the QC operator began the review session.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `total_error_count` STRING COMMENT 'Total number of errors identified across all severity levels during the QC review.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the QC review record was last modified.',
    `video_codec` STRING COMMENT 'Video codec used in the deliverable (e.g., H.264, H.265/HEVC, ProRes, MPEG-2).',
    `video_frame_rate` DECIMAL(18,2) COMMENT 'Measured video frame rate (e.g., 23.976, 25, 29.97, 50, 59.94 fps).',
    `video_resolution` STRING COMMENT 'Measured video resolution of the deliverable (e.g., 1920x1080, 3840x2160).',
    CONSTRAINT pk_qc_review PRIMARY KEY(`qc_review_id`)
) COMMENT 'Quality control review record for a production deliverable or post-production output. Captures QC type (technical QC, editorial QC, compliance QC, accessibility QC, loudness QC), QC operator, review date, pass/fail/conditional result, error count by severity (P1 critical, P2 major, P3 minor), specific error codes per EBU R128/ATSC A/85 loudness standards and ITU-R BT.1788 video quality standards, remediation required flag, re-QC date, and final approval status. Ensures all deliverables meet broadcast and platform technical specifications before distribution. Feeds the deliverable acceptance workflow. [DEMO-FITNESS] MVM demo-fitness: Churn prediction & win-back (D2C SVOD) [rating=5/5, status=done]; Rights availability & windowing [rating=5/5, status=best-in-class]; Linear playout + as-run reconciliation [rating=5/5, status=complete]; Production cost & budget vs. actuals [rating=4/5, status=strong]; Compliance / regulatory reporting [rating=5/5, status=complete]; Overall bottom-line [rating=n/a/5, status=substantially above average]';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` (
    `milestone_id` BIGINT COMMENT 'Primary key for milestone',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Production milestones (greenlight, picture lock, delivery) are tracked at the season level in broadcast operations. milestone already links to content.title, but season-level milestone reporting (e.g.',
    `predecessor_milestone_id` BIGINT COMMENT 'Reference to another milestone that must be completed before this milestone can begin or be achieved.',
    `project_id` BIGINT COMMENT 'Reference to the parent production project or episode for which this milestone is tracked.',
    `program_schedule_id` BIGINT COMMENT 'Foreign key linking to scheduling.program_schedule. Business justification: On-air readiness tracking: production milestones (content lock, final delivery) are tied to a specific program schedules broadcast date. Broadcast operations use this link to flag schedule risk when ',
    `release_window_id` BIGINT COMMENT 'Foreign key linking to distribution.release_window. Business justification: Production milestones are set to meet release window open dates (e.g., picture lock by SVOD window open). Production scheduling and critical path reports require linking milestones to release window',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Production milestones track progress toward content title delivery. Essential for content delivery scheduling, windowing plan coordination, and tracking production progress against content distributio',
    `actual_date` DATE COMMENT 'The date on which the milestone was actually achieved or completed. Null if milestone has not yet been reached.',
    `approval_authority` STRING COMMENT 'Name or role of the individual or committee authorized to approve this milestone (e.g., Executive Producer, Network Executive, Showrunner).',
    `approval_date` DATE COMMENT 'Date on which formal approval or sign-off was granted for this milestone. Null if approval is not yet obtained.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether formal approval or sign-off is required before this milestone can be marked as achieved.',
    `baseline_date` DATE COMMENT 'Approved baseline date for the milestone after initial project approval, used for variance tracking and performance measurement.',
    `budget_impact_usd` DECIMAL(18,2) COMMENT 'Estimated financial impact or cost associated with achieving this milestone, or cost of delay if milestone is missed.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was first created in the system.',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether this milestone is on the critical path of the production schedule, meaning any delay directly impacts final delivery date.',
    `dalet_workflow_reference` STRING COMMENT 'External identifier linking this milestone to the corresponding workflow or task in Dalet Galaxy Media Asset Management system.',
    `deliverable_description` STRING COMMENT 'Detailed description of the tangible output or deliverable associated with this milestone (e.g., locked picture file, final audio mix stems, QC report).',
    `dependency_count` STRING COMMENT 'Number of other milestones or tasks that are dependent on the completion of this milestone.',
    `forecast_date` DATE COMMENT 'Current projected or estimated date for milestone completion based on latest production progress and risk assessment.',
    `mitigation_plan` STRING COMMENT 'Description of actions or contingency plans in place to address identified risks and ensure milestone is achieved.',
    `milestone_name` STRING COMMENT 'Human-readable name or title of the milestone event (e.g., Greenlight Approval, Picture Lock, Final Delivery).',
    `notes` STRING COMMENT 'Free-form text field for additional context, comments, or observations related to this milestone event.',
    `omc_asset_structural_characteristic_code` BIGINT COMMENT 'OMC Asset Structural Characteristic identifier describing structural/technical asset traits',
    `omc_concept_role` STRING COMMENT 'MovieLabs OMC structural concept role for this entity: Context',
    `omc_context_code` BIGINT COMMENT 'OMC Context identifier grouping this production entity into a creative/production context',
    `omc_participant_code` BIGINT COMMENT 'OMC Participant identifier (person/organization/service performing or owning this entity)',
    `planned_date` DATE COMMENT 'Originally scheduled or target date for achieving this milestone as defined during production planning.',
    `responsible_department` STRING COMMENT 'The production department or functional area responsible for delivering this milestone. [ENUM-REF-CANDIDATE: production|post_production|vfx|audio|editorial|color|qc|delivery|archive|legal|finance — 11 candidates stripped; promote to reference product]',
    `risk_description` STRING COMMENT 'Detailed explanation of identified risks, issues, or blockers that may prevent timely achievement of this milestone.',
    `sap_wbs_element` STRING COMMENT 'SAP project structure element code linking this milestone to the enterprise project management and financial tracking hierarchy.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `stakeholder_notification_flag` BOOLEAN COMMENT 'Indicates whether stakeholders (network executives, distributors, talent) must be notified when this milestone is achieved or at risk.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was last modified or updated.',
    `variance_days` STRING COMMENT 'Number of days difference between planned date and actual date (positive indicates delay, negative indicates early completion). Calculated field for reporting purposes.',
    CONSTRAINT pk_milestone PRIMARY KEY(`milestone_id`)
) COMMENT 'Key milestone event in the production lifecycle for a project or episode. Captures milestone type (greenlight, pre-production start, first day of photography, picture lock, audio mix complete, VFX complete, final QC pass, delivery to broadcaster, archive complete), planned date, actual date, milestone status (upcoming, at-risk, achieved, missed), responsible owner, and any associated approval or sign-off requirement. Enables production schedule tracking and stakeholder reporting against key delivery gates. [DEMO-FITNESS] MVM demo-fitness: Churn prediction & win-back (D2C SVOD) [rating=5/5, status=done]; Rights availability & windowing [rating=5/5, status=best-in-class]; Linear playout + as-run reconciliation [rating=5/5, status=complete]; Production cost & budget vs. actuals [rating=4/5, status=strong]; Compliance / regulatory reporting [rating=5/5, status=complete]; Overall bottom-line [rating=n/a/5, status=substantially above average]';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`location` (
    `location_id` BIGINT COMMENT 'Unique identifier for the production location. Primary key.',
    `address_line_1` STRING COMMENT 'Primary street address of the production location including street number and name.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, building, or unit number.',
    `base_camp_capacity` STRING COMMENT 'Number of trailers or mobile units that can be accommodated at the base camp area near the location for cast, crew, wardrobe, makeup, and catering.',
    `city` STRING COMMENT 'City or municipality where the location is situated.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this location record was first created in the system.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Total fee paid to the location owner or manager for the right to film at this location. Excludes additional costs such as permits, insurance, or restoration.',
    `fee_currency` STRING COMMENT 'Three-letter ISO currency code for the location fee (e.g., USD, CAD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `insurance_required_flag` BOOLEAN COMMENT 'Indicates whether the location owner requires specific production insurance coverage or certificates of insurance before filming can commence.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the location in decimal degrees format, used for mapping, navigation, and sunrise/sunset calculations.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the location in decimal degrees format, used for mapping, navigation, and logistics planning.',
    `manager_notes` STRING COMMENT 'Free-text notes and observations from the location manager regarding access, restrictions, special requirements, or other relevant production considerations.',
    `location_name` STRING COMMENT 'Human-readable name or title of the production location (e.g., Downtown Warehouse District, Malibu Beach House, Historic City Hall).',
    `noise_assessment` STRING COMMENT 'Assessment of ambient noise levels at the location: quiet (minimal background noise, suitable for dialogue recording), moderate (some noise, may require sound treatment), noisy (significant noise, requires ADR or sound mitigation), unacceptable (excessive noise, unsuitable for production).. Valid values are `quiet|moderate|noisy|unacceptable`',
    `omc_asset_structural_characteristic_code` BIGINT COMMENT 'OMC Asset Structural Characteristic identifier describing structural/technical asset traits',
    `omc_concept_role` STRING COMMENT 'MovieLabs OMC structural concept role for this entity: Context',
    `omc_context_code` BIGINT COMMENT 'OMC Context identifier grouping this production entity into a creative/production context',
    `omc_participant_code` BIGINT COMMENT 'OMC Participant identifier (person/organization/service performing or owning this entity)',
    `owner_contact_email` STRING COMMENT 'Primary email address for the location owner or authorized representative for contract and coordination communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `owner_contact_phone` STRING COMMENT 'Primary phone number for the location owner or authorized representative for coordination and emergency contact during production.',
    `parking_capacity` STRING COMMENT 'Number of vehicle parking spaces available at or near the location for crew, cast, and equipment trucks.',
    `permit_authority` STRING COMMENT 'Name of the governmental or regulatory authority responsible for issuing filming permits for this location (e.g., Los Angeles Film Office, NYC Mayor Office of Media and Entertainment).',
    `permit_expiry_date` DATE COMMENT 'Date when the filming permit expires and is no longer valid for production use.',
    `permit_issue_date` DATE COMMENT 'Date when the filming permit was officially issued by the permitting authority.',
    `permit_number` STRING COMMENT 'Official permit or authorization number issued by the permitting authority for filming at this location.',
    `power_availability` STRING COMMENT 'Assessment of electrical power availability at the location: grid (connected to utility power), generator required (no grid power, generators needed), limited (some power available but insufficient for full production), none (no power infrastructure).. Valid values are `grid|generator_required|limited|none`',
    `region` STRING COMMENT 'Broader geographic region or area classification (e.g., Southern California, Pacific Northwest, New England) used for production planning and logistics.',
    `restoration_required_flag` BOOLEAN COMMENT 'Indicates whether the production is contractually obligated to restore the location to its original condition after filming concludes.',
    `restroom_facilities` STRING COMMENT 'Assessment of restroom availability: on site (permanent facilities available), portable required (portable restrooms must be brought in), nearby (facilities within walking distance), none (no facilities available).. Valid values are `on_site|portable_required|nearby|none`',
    `safety_assessment_date` DATE COMMENT 'Date when the safety assessment was conducted by the production safety officer or third-party assessor.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `state_province` STRING COMMENT 'State, province, or administrative region of the location.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this location record was last modified in the system.',
    `water_availability` STRING COMMENT 'Assessment of water access at the location: available (connected to water supply), limited (some water but insufficient for full crew), trucked in required (no water infrastructure, must be transported), none (no water access).. Valid values are `available|limited|trucked_in_required|none`',
    CONSTRAINT pk_location PRIMARY KEY(`location_id`)
) COMMENT 'Master record for a physical production location — an on-location shoot site used for principal photography or second unit work. Captures location name, address, GPS coordinates, country, region, location type (practical interior, practical exterior, backlot, remote, international), location scout approval status, permit status, permit authority, permit expiry date, location fee, safety assessment status, noise assessment, sunrise/sunset data relevance, parking and base camp capacity, and contact details for the location owner or manager. Distinct from facility_booking which covers controlled studio and post-production facilities. [DEMO-FITNESS] MVM demo-fitness: Churn prediction & win-back (D2C SVOD) [rating=5/5, status=done]; Rights availability & windowing [rating=5/5, status=best-in-class]; Linear playout + as-run reconciliation [rating=5/5, status=complete]; Production cost & budget vs. actuals [rating=4/5, status=strong]; Compliance / regulatory reporting [rating=5/5, status=complete]; Overall bottom-line [rating=n/a/5, status=substantially above average]';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` (
    `cost_transaction_id` BIGINT COMMENT 'Primary key for cost_transaction',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to production.budget_line. Business justification: Cost transactions are posted against specific budget line items. Currently uses budget_line_reference (STRING) — replacing with FK to budget_line.budget_line_id provides referential integrity and enab',
    `budget_id` BIGINT COMMENT 'Reference to the specific budget line or cost object this transaction is charged against.',
    `project_id` BIGINT COMMENT 'Reference to the production project against which this cost transaction is posted.',
    `approval_date` DATE COMMENT 'Date on which the transaction was approved for payment.',
    `cost_category_code` STRING COMMENT 'Code representing the cost category or expense type (e.g., talent, equipment, location, post-production).',
    `cost_category_name` STRING COMMENT 'Descriptive name of the cost category or expense classification.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost transaction record was first created in the system.',
    `cost_transaction_description` STRING COMMENT 'Detailed description or narrative of the cost transaction, including purpose and context.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert the transaction amount to the reporting currency.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month or quarter) within the fiscal year for this transaction.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the transaction was posted for financial reporting purposes.',
    `invoice_date` DATE COMMENT 'Date on the vendor invoice or billing document.',
    `invoice_number` STRING COMMENT 'Vendor invoice number or billing reference for this transaction.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net transaction amount excluding taxes and other adjustments.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this transaction.',
    `omc_asset_structural_characteristic_code` BIGINT COMMENT 'OMC Asset Structural Characteristic identifier describing structural/technical asset traits',
    `omc_concept_role` STRING COMMENT 'MovieLabs OMC structural concept role for this entity: Context',
    `omc_context_code` BIGINT COMMENT 'OMC Context identifier grouping this production entity into a creative/production context',
    `omc_participant_code` BIGINT COMMENT 'OMC Participant identifier (person/organization/service performing or owning this entity)',
    `payee_name` STRING COMMENT 'Name of the individual or entity receiving payment for this transaction (e.g., crew member, contractor, petty cash recipient).',
    `payment_date` DATE COMMENT 'Date on which payment was made or is scheduled to be made for this transaction.',
    `payment_method` STRING COMMENT 'Method used for payment: wire transfer, check, credit card, petty cash, ACH, or payroll.. Valid values are `wire_transfer|check|credit_card|petty_cash|ach|payroll`',
    `payment_status` STRING COMMENT 'Current payment status of the transaction: pending, approved, paid, cancelled, on hold, or rejected.. Valid values are `pending|approved|paid|cancelled|on_hold|rejected`',
    `posting_date` DATE COMMENT 'The date on which the transaction was posted to the general ledger in SAP.',
    `production_phase` STRING COMMENT 'Phase of production during which this cost was incurred: pre-production, principal photography, post-production, delivery, or closed.. Valid values are `pre_production|principal_photography|post_production|delivery|closed`',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with this transaction, if applicable.',
    `reporting_currency_amount` DECIMAL(18,2) COMMENT 'Transaction amount converted to the standard reporting currency (typically USD) for consolidated financial reporting.',
    `sap_document_number` STRING COMMENT 'SAP S/4HANA financial document number (FI/CO posting document) associated with this transaction.',
    `sap_line_item_number` STRING COMMENT 'Line item number within the SAP document for granular traceability.',
    `sap_wbs_element` STRING COMMENT 'SAP WBS element representing the project structure node for this cost transaction.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount associated with this transaction, if applicable.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The monetary amount of the cost transaction in the original transaction currency.',
    `transaction_date` DATE COMMENT 'The date on which the cost transaction was incurred or posted in the financial system.',
    `transaction_number` STRING COMMENT 'Business-facing unique transaction number or document reference for this cost entry.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost transaction record was last updated or modified.',
    CONSTRAINT pk_cost_transaction PRIMARY KEY(`cost_transaction_id`)
) COMMENT 'Individual cost transaction record incurred during production — purchase orders, vendor invoices, petty cash disbursements, payroll charges, and inter-company cost allocations posted against a production project. Captures transaction date, transaction type, vendor or payee, cost category, budget line reference, amount, currency, SAP document number, payment status, and approver. Provides the granular financial audit trail for production spend reconciliation against the production budget. [DEMO-FITNESS] MVM demo-fitness: Churn prediction & win-back (D2C SVOD) [rating=5/5, status=done]; Rights availability & windowing [rating=5/5, status=best-in-class]; Linear playout + as-run reconciliation [rating=5/5, status=complete]; Production cost & budget vs. actuals [rating=4/5, status=strong]; Compliance / regulatory reporting [rating=5/5, status=complete]; Overall bottom-line [rating=n/a/5, status=substantially above average]';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ADD CONSTRAINT `fk_production_shoot_schedule_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`location`(`location_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ADD CONSTRAINT `fk_production_shoot_schedule_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ADD CONSTRAINT `fk_production_shoot_schedule_script_id` FOREIGN KEY (`script_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`script`(`script_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ADD CONSTRAINT `fk_production_budget_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`budget`(`budget_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ADD CONSTRAINT `fk_production_facility_booking_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ADD CONSTRAINT `fk_production_facility_booking_shoot_schedule_id` FOREIGN KEY (`shoot_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`shoot_schedule`(`shoot_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ADD CONSTRAINT `fk_production_equipment_allocation_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`location`(`location_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ADD CONSTRAINT `fk_production_equipment_allocation_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ADD CONSTRAINT `fk_production_equipment_allocation_shoot_schedule_id` FOREIGN KEY (`shoot_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`shoot_schedule`(`shoot_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ADD CONSTRAINT `fk_production_script_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`deliverable`(`deliverable_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_predecessor_milestone_id` FOREIGN KEY (`predecessor_milestone_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`budget_line`(`budget_line_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`budget`(`budget_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`production` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`production` SET TAGS ('dbx_domain' = 'production');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `project_id` SET TAGS ('dbx_column_comment' = 'Primary key for project');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `channel_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_scheduling_channel_Business_justification' = 'Projects are commissioned for specific broadcast channels/networks. Network commissioning process requires tracking which channel ordered the content. Essential for content planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `channel_id` SET TAGS ('dbx_budget_allocation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Content Season Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Master License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_license_agreement_Business_justification' = 'Projects often have master license agreements governing distribution rights (co-production deals');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_pre_sales' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_output_deals)_Real_business_need' = 'tracking which license agreements fund or govern a produ');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Title Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `title_id` SET TAGS ('dbx_column_comment_FK_to_content_title_title_id_—_Critical_production_to_content_traceability' = 'must answer what content title does this production project produce? for scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `title_id` SET TAGS ('dbx_rights_clearance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `title_id` SET TAGS ('dbx_and_financial_reporting_workflows' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `release_window_id` SET TAGS ('dbx_business_glossary_term' = 'Release Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Target Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Target Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_ott_platform_Business_justification' = 'Productions are commissioned for specific streaming platforms (Netflix Originals');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_HBO_Max_Exclusives)_Platform_determines_technical_specs' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_content_ratings' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_delivery_windows_Real_business_process' = 'pl');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `subscription_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Target Subscription Plan Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_column_comment' = 'Date on which the final deliverable was actually delivered to the distribution or broadcast platform. Compared against target_delivery_date to measure on-time delivery performance and SLA compliance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Production Spend (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_column_comment' = 'Cumulative actual expenditure incurred against this production project to date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_denominated_in_US_Dollars_Sourced_from_SAP_S_4HANA_cost_postings_Compared_against_approved_budget_usd_for_variance_and_financial_reconciliation_reporting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `approved_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Approved Production Budget (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `approved_budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `approved_budget_usd` SET TAGS ('dbx_column_comment' = 'Total production budget formally approved at greenlight');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `approved_budget_usd` SET TAGS ('dbx_denominated_in_US_Dollars_Represents_the_authorized_spend_ceiling_for_the_project_Used_for_financial_controlling' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `approved_budget_usd` SET TAGS ('dbx_variance_analysis' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `approved_budget_usd` SET TAGS ('dbx_and_EBITDA_reporting_in_SAP_S_4HANA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `co_production_flag` SET TAGS ('dbx_business_glossary_term' = 'Co-Production Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `co_production_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `co_production_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this production project is a co-production involving one or more external production partners. Triggers co-production agreement workflows');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `co_production_flag` SET TAGS ('dbx_shared_rights_structures' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `co_production_flag` SET TAGS ('dbx_and_split_budget_reporting_in_SAP_S_4HANA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_business_glossary_term' = 'Content Genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_column_comment' = 'Primary genre classification of the content being produced (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_drama' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_comedy' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_thriller' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_sports' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_news' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_reality)_Used_for_audience_targeting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_scheduling' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_advertising_sales' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_and_rights_windowing_strategies_[ENUM_REF_CANDIDATE' = 'drama');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_comedy' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_thriller' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_action' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_documentary' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_news' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_reality' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_sports' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_animation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_horror_—_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `coppa_applicable` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `coppa_applicable` SET TAGS ('dbx_column_comment' = 'Indicates whether this production is directed at children under 13 and therefore subject to COPPA compliance requirements. Affects data collection practices');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `coppa_applicable` SET TAGS ('dbx_advertising_eligibility' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `coppa_applicable` SET TAGS ('dbx_and_platform_distribution_restrictions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `coppa_applicable` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment_Timestamp_when_this_production_project_record_was_first_created_in_the_lakehouse_Silver_layer_Conforms_to_ISO_8601_format_(yyyy_MM_ddTHH' = 'mm:ss.SSSXXX). Used for audit trail and data lineage tracking.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Workflow ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_column_comment' = 'Integration reference identifier linking this production project to its corresponding workflow instance in Dalet Galaxy Media Asset Management and Workflow Orchestration system. Enables cross-system traceability for ingest');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_metadata' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_archive' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_and_workflow_operations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `drm_required` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `drm_required` SET TAGS ('dbx_column_comment' = 'Indicates whether Digital Rights Management (DRM) protection must be applied to the delivered content assets. Drives technical delivery specifications for CDN');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `drm_required` SET TAGS ('dbx_streaming_platform_configuration' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `drm_required` SET TAGS ('dbx_and_Akamai_CDN_security_settings' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `eidr` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `eidr` SET TAGS ('dbx_value_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `eidr` SET TAGS ('dbx_standard_identifier' = 'EIDR');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `eidr` SET TAGS ('dbx_first_class' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `eidr` SET TAGS ('dbx_regex' = '^10.5240/...');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `eidr` SET TAGS ('dbx_column_comment' = 'Entertainment Identifier Registry (EIDR) identifier for this content project. Provides a universal');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `eidr` SET TAGS ('dbx_persistent_identifier_for_the_title_across_supply_chain_partners' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `eidr` SET TAGS ('dbx_distributors' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `eidr` SET TAGS ('dbx_and_platforms' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `eidr` SET TAGS ('dbx_validation_regex' = '^10.5240/[0-9A-F-]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `eidr` SET TAGS ('dbx_standard' = 'EIDR');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `eidr` SET TAGS ('dbx_regex_validation' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `episode_count` SET TAGS ('dbx_business_glossary_term' = 'Episode Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `episode_count` SET TAGS ('dbx_column_comment' = 'Total number of episodes commissioned for this production project. Applicable to scripted and unscripted series. Used for budget modeling');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `episode_count` SET TAGS ('dbx_scheduling' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `episode_count` SET TAGS ('dbx_and_rights_licensing_calculations_Null_for_single_title_formats_such_as_feature_films' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `fcc_license_required` SET TAGS ('dbx_business_glossary_term' = 'FCC Broadcast License Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `fcc_license_required` SET TAGS ('dbx_column_comment' = 'Indicates whether this production requires FCC broadcast licensing compliance review prior to linear broadcast distribution. Applicable to content intended for over-the-air or cable transmission in the United States.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `fcc_license_required` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `greenlight_date` SET TAGS ('dbx_business_glossary_term' = 'Greenlight Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `greenlight_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `greenlight_date` SET TAGS ('dbx_column_comment' = 'Calendar date on which the production project received formal executive greenlight approval. Marks the official start of the production lifecycle and triggers budget release and resource mobilization.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `isan` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `isan` SET TAGS ('dbx_value_regex' = '^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `isan` SET TAGS ('dbx_standard_identifier' = 'ISAN');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `isan` SET TAGS ('dbx_first_class' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `isan` SET TAGS ('dbx_regex' = '^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `isan` SET TAGS ('dbx_column_comment' = 'Globally unique identifier assigned to this audiovisual work under the International Standard Audiovisual Number (ISAN) standard (ISO 15706). Used for rights management');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `isan` SET TAGS ('dbx_royalty_tracking' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `isan` SET TAGS ('dbx_and_cross_platform_content_identification' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `isan` SET TAGS ('dbx_validation_regex' = '^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `isan` SET TAGS ('dbx_standard' = 'ISAN');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `isan` SET TAGS ('dbx_regex_validation' = '^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}(-[A-Z0-9])?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `original_ip_flag` SET TAGS ('dbx_business_glossary_term' = 'Original Intellectual Property (IP) Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `original_ip_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `original_ip_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this production is based on original intellectual property owned by the organization');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `original_ip_flag` SET TAGS ('dbx_as_opposed_to_licensed_or_adapted_IP_Affects_rights_ownership' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `original_ip_flag` SET TAGS ('dbx_residuals_obligations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `original_ip_flag` SET TAGS ('dbx_and_long_term_asset_valuation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `post_production_start_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Production Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `post_production_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `post_production_start_date` SET TAGS ('dbx_column_comment' = 'Scheduled or actual date on which post-production activities commenced');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `post_production_start_date` SET TAGS ('dbx_including_editing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `post_production_start_date` SET TAGS ('dbx_VFX' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `post_production_start_date` SET TAGS ('dbx_color_grading' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `post_production_start_date` SET TAGS ('dbx_audio_mixing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `post_production_start_date` SET TAGS ('dbx_and_transcoding_Used_for_facility_booking_and_deliverable_milestone_planning' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `pre_production_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Production Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `pre_production_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `pre_production_start_date` SET TAGS ('dbx_column_comment' = 'Scheduled or actual date on which pre-production activities commenced');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `pre_production_start_date` SET TAGS ('dbx_including_casting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `pre_production_start_date` SET TAGS ('dbx_location_scouting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `pre_production_start_date` SET TAGS ('dbx_script_breakdown' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `pre_production_start_date` SET TAGS ('dbx_and_crew_hiring_Used_for_production_planning_and_milestone_tracking' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Production Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `primary_language` SET TAGS ('dbx_column_comment' = 'ISO 639-1 or ISO 639-2 language code for the primary language in which the content is produced (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `primary_language` SET TAGS ('dbx_en' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `primary_language` SET TAGS ('dbx_es' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `primary_language` SET TAGS ('dbx_fr)_Drives_localization' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `primary_language` SET TAGS ('dbx_dubbing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `primary_language` SET TAGS ('dbx_subtitling' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `primary_language` SET TAGS ('dbx_and_distribution_territory_planning' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `primary_language` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `primary_language` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `primary_language` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `primary_language` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `principal_photography_end_date` SET TAGS ('dbx_business_glossary_term' = 'Principal Photography End Date (Picture Wrap)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `principal_photography_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `principal_photography_end_date` SET TAGS ('dbx_column_comment' = 'Scheduled or actual date on which principal photography concluded (picture wrap). Triggers transition to post-production phase and initiates post-production resource scheduling.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `principal_photography_start_date` SET TAGS ('dbx_business_glossary_term' = 'Principal Photography Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `principal_photography_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `principal_photography_start_date` SET TAGS ('dbx_column_comment' = 'Scheduled or actual date on which principal photography (primary filming) commenced. A key production milestone used for crew scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `principal_photography_start_date` SET TAGS ('dbx_facility_booking' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `principal_photography_start_date` SET TAGS ('dbx_and_insurance_activation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_country` SET TAGS ('dbx_business_glossary_term' = 'Primary Production Country');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_country` SET TAGS ('dbx_column_comment' = 'ISO 3166-1 alpha-3 country code for the primary country in which the production is being executed. Determines applicable regulatory frameworks');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_country` SET TAGS ('dbx_tax_incentive_eligibility' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_country` SET TAGS ('dbx_and_co_production_treaty_benefits' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_phase` SET TAGS ('dbx_business_glossary_term' = 'Production Phase');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_phase` SET TAGS ('dbx_value_regex' = 'development|pre_production|principal_photography|post_production|delivery|archived');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_phase` SET TAGS ('dbx_column_comment' = 'Current phase of the content production lifecycle. Tracks the projects progression from development through delivery. Used to gate workflow steps');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_phase` SET TAGS ('dbx_resource_allocation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_phase` SET TAGS ('dbx_and_financial_milestone_releases' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_business_glossary_term' = 'SAP Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_column_comment' = 'SAP S/4HANA Work Breakdown Structure element code that maps this production project to the enterprise financial controlling hierarchy for budget tracking');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_cost_allocation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_and_financial_reconciliation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `synopsis` SET TAGS ('dbx_business_glossary_term' = 'Production Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `synopsis` SET TAGS ('dbx_column_comment' = 'Short narrative description of the content production projects story');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `synopsis` SET TAGS ('dbx_subject_matter' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `synopsis` SET TAGS ('dbx_or_editorial_concept_Used_for_internal_greenlight_documentation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `synopsis` SET TAGS ('dbx_sales_pitches' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `synopsis` SET TAGS ('dbx_EPG_metadata' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `synopsis` SET TAGS ('dbx_and_Dalet_Galaxy_asset_metadata' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `target_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Target Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `target_delivery_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `target_delivery_date` SET TAGS ('dbx_column_comment' = 'Contractually committed or internally planned date by which the finished content must be delivered to distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `target_delivery_date` SET TAGS ('dbx_broadcast' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `target_delivery_date` SET TAGS ('dbx_or_streaming_platforms_Drives_post_production_scheduling' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `target_delivery_date` SET TAGS ('dbx_windowing_strategy' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `target_delivery_date` SET TAGS ('dbx_and_SLA_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `total_runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Runtime (Minutes)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `total_runtime_minutes` SET TAGS ('dbx_fact_metric' = 'monetary');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `total_runtime_minutes` SET TAGS ('dbx_column_comment' = 'Total planned or delivered runtime of the production in minutes. For series');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `total_runtime_minutes` SET TAGS ('dbx_this_is_the_aggregate_runtime_across_all_episodes_Used_for_scheduling' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `total_runtime_minutes` SET TAGS ('dbx_licensing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `total_runtime_minutes` SET TAGS ('dbx_and_royalty_calculations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment_Timestamp_when_this_production_project_record_was_most_recently_modified_in_the_lakehouse_Silver_layer_Conforms_to_ISO_8601_format_(yyyy_MM_ddTHH' = 'mm:ss.SSSXXX). Used for change tracking');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_incremental_processing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_and_audit_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `shoot_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shoot Schedule ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `shoot_schedule_id` SET TAGS ('dbx_column_comment' = 'Unique surrogate identifier for a shoot schedule record in the production domain. Primary key for the shoot_schedule data product.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `location_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_production_location_Business_justification' = 'Normalization opportunity. Shoot schedule currently has location_name (STRING). FK to location table provides referential integrity and enables retrieving full location details (address');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `location_id` SET TAGS ('dbx_permits' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `location_id` SET TAGS ('dbx_safe' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Dailies Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_mediaasset_media_asset_Business_justification' = 'Shoot days generate dailies (raw footage) ingested into MAM for editorial review. Role-prefixed as dailies_asset_id since shoot_schedule already has dalet_workflow_id. Essential for post-production wo');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `project_id` SET TAGS ('dbx_column_comment' = 'Reference to the parent production project to which this shoot schedule day belongs. Links the daily schedule to the overarching production entity.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `script_id` SET TAGS ('dbx_business_glossary_term' = 'Script Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `actual_extras_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Background Extras Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `actual_extras_count` SET TAGS ('dbx_column_comment' = 'The actual number of background performers (extras) who worked on this shoot day. Used for payroll reconciliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `actual_extras_count` SET TAGS ('dbx_SAG_AFTRA_reporting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `actual_extras_count` SET TAGS ('dbx_and_production_cost_tracking' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `actual_shoot_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Shoot Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `actual_shoot_hours` SET TAGS ('dbx_column_comment' = 'The actual number of hours spent in principal photography for the day. Used for budget reconciliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `actual_shoot_hours` SET TAGS ('dbx_overtime_calculation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `actual_shoot_hours` SET TAGS ('dbx_and_production_efficiency_analysis' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `actual_wrap_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Wrap Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `actual_wrap_time` SET TAGS ('dbx_column_comment' = 'The actual time at which principal photography concluded for the day. Compared against scheduled wrap time to calculate overtime and assess schedule adherence.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `call_time` SET TAGS ('dbx_business_glossary_term' = 'Call Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `call_time` SET TAGS ('dbx_column_comment' = 'The scheduled time at which cast and crew are required to report to set. Used for crew coordination');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `call_time` SET TAGS ('dbx_transport_logistics' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `call_time` SET TAGS ('dbx_and_facility_readiness_planning' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `cover_set_description` SET TAGS ('dbx_business_glossary_term' = 'Cover Set Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `cover_set_description` SET TAGS ('dbx_column_comment' = 'Description of the alternate interior or cover set designated for use if weather or other conditions prevent the primary shoot. Only applicable when weather_contingency_flag is True.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp at which this shoot schedule record was first created in the system. Supports audit trail');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_data_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_and_compliance_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Workflow ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_column_comment' = 'The workflow instance identifier assigned by Dalet Galaxy for the ingest and orchestration workflow associated with this shoot days deliverables. Enables traceability between the shoot schedule and downstream media asset management processes.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `estimated_extras_count` SET TAGS ('dbx_business_glossary_term' = 'Estimated Background Extras Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `estimated_extras_count` SET TAGS ('dbx_column_comment' = 'The planned number of background performers (extras) required for this shoot day. Used for casting coordination');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `estimated_extras_count` SET TAGS ('dbx_catering_planning' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `estimated_extras_count` SET TAGS ('dbx_and_SAG_AFTRA_background_performer_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `estimated_shoot_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Shoot Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `estimated_shoot_hours` SET TAGS ('dbx_column_comment' = 'The planned number of shooting hours for the day');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `estimated_shoot_hours` SET TAGS ('dbx_used_for_budget_forecasting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `estimated_shoot_hours` SET TAGS ('dbx_crew_scheduling' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `estimated_shoot_hours` SET TAGS ('dbx_and_facility_booking_Expressed_in_decimal_hours_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `estimated_shoot_hours` SET TAGS ('dbx_10_50' = '10 hours 30 minutes).');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `first_shot_time` SET TAGS ('dbx_business_glossary_term' = 'First Shot Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `first_shot_time` SET TAGS ('dbx_column_comment' = 'The scheduled or actual time at which the first camera roll of the day begins. A key production efficiency metric used to assess set readiness and pre-production effectiveness.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `is_overtime_day` SET TAGS ('dbx_business_glossary_term' = 'Overtime Day Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `is_overtime_day` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `is_overtime_day` SET TAGS ('dbx_column_comment' = 'Indicates whether this shoot day resulted in overtime hours for cast or crew');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `is_overtime_day` SET TAGS ('dbx_triggering_additional_compensation_obligations_under_union_agreements_(SAG_AFTRA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `is_overtime_day` SET TAGS ('dbx_DGA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `is_overtime_day` SET TAGS ('dbx_IATSE)_Derived_operationally_but_stored_for_compliance_and_payroll_audit_purposes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `meal_penalty_flag` SET TAGS ('dbx_business_glossary_term' = 'Meal Penalty Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `meal_penalty_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `meal_penalty_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether a meal penalty was incurred on this shoot day due to failure to provide a meal break within the union-mandated interval (typically 6 hours). Triggers additional compensation obligations under SAG-AFTRA and IATSE agreements.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Script Page Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `page_count` SET TAGS ('dbx_column_comment' = 'The number of script pages scheduled for photography on this shoot day');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `page_count` SET TAGS ('dbx_expressed_in_eighths_of_a_page_per_industry_convention_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `page_count` SET TAGS ('dbx_4_625' = '4 and 5/8 pages). A standard production efficiency metric used to assess daily output against industry benchmarks.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `page_count` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `production_notes` SET TAGS ('dbx_business_glossary_term' = 'Production Day Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `production_notes` SET TAGS ('dbx_column_comment' = 'Free-text field capturing significant events');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `production_notes` SET TAGS ('dbx_issues' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `production_notes` SET TAGS ('dbx_or_observations_from_the_shoot_day' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `production_notes` SET TAGS ('dbx_including_equipment_failures' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `production_notes` SET TAGS ('dbx_weather_delays' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `production_notes` SET TAGS ('dbx_cast_illness' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `production_notes` SET TAGS ('dbx_or_creative_changes_Sourced_from_the_daily_production_report' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `production_unit` SET TAGS ('dbx_business_glossary_term' = 'Production Unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `production_unit` SET TAGS ('dbx_value_regex' = 'main_unit|second_unit|splinter_unit|insert_unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `production_unit` SET TAGS ('dbx_column_comment' = 'Identifies the filming unit responsible for this shoot day. Main unit is led by the principal director; second unit handles action sequences or supplemental footage; splinter unit shoots simultaneously with main unit on a separate set; insert unit captures close-up or detail shots.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Revision Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `revision_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `revision_date` SET TAGS ('dbx_column_comment' = 'The date on which the current revision of this shoot schedule was issued. Used to track the cadence of schedule changes and identify the most current approved version.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `revision_version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Revision Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `revision_version` SET TAGS ('dbx_column_comment' = 'The version identifier of this shoot schedule revision (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `revision_version` SET TAGS ('dbx_'v1'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `revision_version` SET TAGS ('dbx_'v3_BLUE'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `revision_version` SET TAGS ('dbx_'Rev_7')_Production_schedules_are_revised_frequently;_tracking_version_enables_audit_of_changes_and_comparison_of_planned_vs_actual_across_revisions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `scene_numbers` SET TAGS ('dbx_business_glossary_term' = 'Scene Numbers');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `scene_numbers` SET TAGS ('dbx_column_comment' = 'Comma-separated list of scene numbers from the production script scheduled for photography on this shoot day (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `scene_numbers` SET TAGS ('dbx_'12' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `scene_numbers` SET TAGS ('dbx_13A' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `scene_numbers` SET TAGS ('dbx_14' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `scene_numbers` SET TAGS ('dbx_15B')_Derived_from_the_stripboard_and_used_for_script_supervisor_tracking_and_editorial_planning' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Shoot Schedule Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_column_comment' = 'Externally-known alphanumeric identifier for this shoot schedule record');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_used_in_production_paperwork' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_call_sheets' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_and_cross_system_references_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_SS_2024_0042)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `scheduled_wrap_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Wrap Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `scheduled_wrap_time` SET TAGS ('dbx_column_comment' = 'The planned time at which principal photography is expected to conclude for the day. Used for facility booking');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `scheduled_wrap_time` SET TAGS ('dbx_crew_scheduling' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `scheduled_wrap_time` SET TAGS ('dbx_and_overtime_cost_estimation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `shoot_date` SET TAGS ('dbx_business_glossary_term' = 'Shoot Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `shoot_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `shoot_date` SET TAGS ('dbx_column_comment' = 'The calendar date on which principal photography is scheduled or was executed. The primary business event date for this schedule record.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `shoot_day_number` SET TAGS ('dbx_business_glossary_term' = 'Shoot Day Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `shoot_day_number` SET TAGS ('dbx_column_comment' = 'Sequential shoot day number within the production (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `shoot_day_number` SET TAGS ('dbx_Day_1' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `shoot_day_number` SET TAGS ('dbx_Day_15' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `shoot_day_number` SET TAGS ('dbx_Day_42)_Used_to_track_production_progress_against_the_total_approved_shoot_days_and_for_budget_burn_rate_analysis' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `total_approved_shoot_days` SET TAGS ('dbx_business_glossary_term' = 'Total Approved Shoot Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `total_approved_shoot_days` SET TAGS ('dbx_fact_metric' = 'monetary');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `total_approved_shoot_days` SET TAGS ('dbx_column_comment' = 'The total number of principal photography days approved in the production greenlight. Used to calculate schedule completion percentage and identify overages requiring executive approval.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `turnaround_hours` SET TAGS ('dbx_business_glossary_term' = 'Crew Turnaround Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `turnaround_hours` SET TAGS ('dbx_column_comment' = 'The minimum rest period in hours between the wrap of the previous shoot day and the call time of this shoot day. Union agreements (SAG-AFTRA');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `turnaround_hours` SET TAGS ('dbx_DGA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `turnaround_hours` SET TAGS ('dbx_IATSE)_mandate_minimum_turnaround_periods;_violations_trigger_penalty_payments' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp at which this shoot schedule record was most recently modified. Used for change detection');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_incremental_data_loading_in_the_Databricks_Silver_Layer' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_and_audit_trail_maintenance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `weather_contingency_flag` SET TAGS ('dbx_business_glossary_term' = 'Weather Contingency Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `weather_contingency_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `weather_contingency_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this shoot day has a weather contingency plan in place. When True');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `weather_contingency_flag` SET TAGS ('dbx_an_alternate_interior_or_cover_set_is_designated_in_case_outdoor_conditions_prevent_the_primary_shoot_Critical_for_location_shoots_and_insurance_risk_management' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_column_comment' = 'Primary key for budget');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `project_id` SET TAGS ('dbx_column_comment' = 'Reference to the parent production project this budget record belongs to. Links the financial control baseline to the production entity.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_column_comment' = 'Cumulative actual costs incurred to date for this cost category');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_sourced_from_SAP_S_4HANA_FI_CO_actual_postings_Represents_real_expenditure_against_the_approved_budget' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approved_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approved_amount` SET TAGS ('dbx_column_comment' = 'The formally approved budget amount for this cost category and version');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approved_amount` SET TAGS ('dbx_representing_the_financial_control_baseline_authorized_by_the_production_greenlight_committee' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this budget version was formally approved by the authorized signatory. Null if not yet approved.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Budget Change Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `change_reason` SET TAGS ('dbx_column_comment' = 'Free-text narrative explaining the business justification for a budget revision (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `change_reason` SET TAGS ('dbx_'Schedule_extension_due_to_weather_delays'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `change_reason` SET TAGS ('dbx_'Additional_VFX_shots_approved_by_director')_Mandatory_for_revised_versions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `change_reason` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `change_reason` SET TAGS ('dbx_ENUM_REF_CANDIDATE' = 'promote-to-reference-product');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `change_request_reference` SET TAGS ('dbx_business_glossary_term' = 'Budget Change Request Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `change_request_reference` SET TAGS ('dbx_column_comment' = 'Reference number of the formal budget change request (BCR) document that authorized a revision to this budget line');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `change_request_reference` SET TAGS ('dbx_traceable_in_the_production_finance_approval_workflow' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_column_comment' = 'Externally-known alphanumeric code uniquely identifying this budget record within the production finance system. Used for cross-system reference and reporting.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Commitment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_column_comment' = 'Total value of open purchase order commitments (obligations) for this cost category that have been raised but not yet invoiced. Represents encumbered funds in the SAP MM/CO commitment ledger.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_business_glossary_term' = 'Contingency Reserve Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_column_comment' = 'The absolute monetary value of the contingency reserve allocated for this cost category');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_derived_from_the_contingency_percentage_applied_to_the_approved_budget_amount' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contingency Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_column_comment' = 'The percentage of the approved budget allocated as contingency reserve for this cost category');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_representing_the_risk_buffer_approved_by_the_production_finance_committee' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Category Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_column_comment' = 'SAP cost element or cost category code classifying the type of production expenditure (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_ATL_TALENT' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_BTL_CREW' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_BTL_EQUIPMENT' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_POST_VFX' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_POST_AUDIO)_[ENUM_REF_CANDIDATE' = 'ATL-TALENT');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_ATL_RIGHTS' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_BTL_CREW' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_BTL_EQUIPMENT' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_BTL_FACILITIES' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_BTL_TRAVEL' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_POST_VFX' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_POST_AUDIO' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_POST_COLOR' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_CONTINGENCY_—_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Category Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_column_comment' = 'Human-readable name of the production cost category (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_'Above_the_Line_Talent'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_'Below_the_Line_Crew'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_'Visual_Effects'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_'Audio_Post_Production')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_line_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Line Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_line_type` SET TAGS ('dbx_value_regex' = 'ABOVE_THE_LINE|BELOW_THE_LINE|POST_PRODUCTION|CONTINGENCY|OVERHEAD');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_line_type` SET TAGS ('dbx_column_comment' = 'High-level classification of the cost line distinguishing above-the-line (ATL) creative costs (writers');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_line_type` SET TAGS ('dbx_directors' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_line_type` SET TAGS ('dbx_producers' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_line_type` SET TAGS ('dbx_talent)_from_below_the_line_(BTL)_technical_and_crew_costs' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_line_type` SET TAGS ('dbx_post_production' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_line_type` SET TAGS ('dbx_contingency' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_line_type` SET TAGS ('dbx_and_overhead' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this budget record was first created in the source system or ingested into the Databricks Silver Layer. Supports audit trail and data lineage.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_column_comment' = 'The foreign exchange rate applied to convert this budget records currency to the productions reporting currency at the time of budget approval or revision.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_column_comment' = 'The fiscal period (month number 1–12 or 1–16 for special periods) within the fiscal year to which this budget line is assigned in SAP CO.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_column_comment' = 'The four-digit fiscal year to which this budget record belongs in the SAP S/4HANA CO controlling area');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_used_for_annual_financial_planning_and_SOX_reporting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Forecast to Complete Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_column_comment' = 'Latest estimate of the total cost expected to be incurred for this cost category by production completion');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_incorporating_actuals_to_date_and_projected_remaining_spend' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `is_greenlight_budget` SET TAGS ('dbx_business_glossary_term' = 'Greenlight Budget Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `is_greenlight_budget` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `is_greenlight_budget` SET TAGS ('dbx_column_comment' = 'Indicates whether this budget record represents the original greenlight-approved budget for the production');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `is_greenlight_budget` SET TAGS ('dbx_as_distinct_from_subsequent_revisions_The_greenlight_budget_is_the_primary_financial_authorization_baseline' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Budget Locked Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `is_locked` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `is_locked` SET TAGS ('dbx_column_comment' = 'Indicates whether this budget version has been locked and is no longer open for modification. A locked budget serves as the immutable financial baseline for variance reporting.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-text field for additional commentary');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_assumptions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_or_clarifications_associated_with_this_budget_record' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_entered_by_the_production_finance_team' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `period_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `period_end_date` SET TAGS ('dbx_column_comment' = 'The end date of the fiscal or production period covered by this budget record. Defines the temporal boundary for cost accumulation and variance measurement.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `period_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `period_start_date` SET TAGS ('dbx_column_comment' = 'The start date of the fiscal or production period covered by this budget record');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `period_start_date` SET TAGS ('dbx_aligning_to_the_SAP_fiscal_year_period_structure' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `production_phase` SET TAGS ('dbx_business_glossary_term' = 'Production Phase');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `production_phase` SET TAGS ('dbx_value_regex' = 'DEVELOPMENT|PRE_PRODUCTION|PRINCIPAL_PHOTOGRAPHY|POST_PRODUCTION|DELIVERY|CLOSED');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `production_phase` SET TAGS ('dbx_column_comment' = 'The production lifecycle phase to which this budget line is attributed (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `production_phase` SET TAGS ('dbx_Development' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `production_phase` SET TAGS ('dbx_Pre_Production' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `production_phase` SET TAGS ('dbx_Principal_Photography' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `production_phase` SET TAGS ('dbx_Post_Production' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `production_phase` SET TAGS ('dbx_Delivery)_Enables_phase_level_budget_tracking' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `revised_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budget Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `revised_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `revised_amount` SET TAGS ('dbx_column_comment' = 'The most recently revised budget amount for this cost category following a formal budget change request. Null if no revision has been approved since the original budget.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `sap_cost_object_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Cost Object ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `sap_cost_object_code` SET TAGS ('dbx_column_comment' = 'The SAP S/4HANA CO cost object identifier (Internal Order number or WBS Element ID) that anchors this budget record to the controlling module for financial reconciliation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_business_glossary_term' = 'SAP Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_column_comment' = 'SAP Project System Work Breakdown Structure element code that maps this budget line to a specific phase or deliverable within the production project hierarchy (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_PRE_PROD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_PRINCIPAL' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_POST_PROD)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp of the most recent modification to this budget record in the source system or Silver Layer. Used for incremental load detection and change data capture.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_column_comment' = 'The difference between the approved (or revised) budget amount and the sum of actual costs plus commitments. A negative value indicates an over-budget condition; positive indicates underspend.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = 'ORIGINAL|REVISED_1|REVISED_2|REVISED_3|FINAL|LOCKED');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_column_comment' = 'Version label of this budget record');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_distinguishing_the_original_greenlight_budget_from_subsequent_revisions_and_the_locked_final_version_Supports_budget_version_history_tracking' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `version_number` SET TAGS ('dbx_column_comment' = 'Sequential integer version number of this budget record (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `version_number` SET TAGS ('dbx_1' = 'original');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `version_number` SET TAGS ('dbx_2' = 'first revision). Enables ordered version history and audit trail.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_column_comment' = 'Unique surrogate identifier for each individual budget line item within a production budget. Primary key for this entity.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('dbx_column_comment' = 'Reference to the parent production budget document that contains this line item. A production may have multiple budget versions (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('dbx_greenlight' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('dbx_revised' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('dbx_final)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `campaign_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_advertising_campaign_Business_justification' = 'Budget lines track advertiser-funded production costs for branded content and product integrations. Business process: advertiser co-production cost allocation');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `campaign_id` SET TAGS ('dbx_campaign_funded_production_expense_track' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `episode_id` SET TAGS ('dbx_business_glossary_term' = 'Episode ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `episode_id` SET TAGS ('dbx_column_comment' = 'Reference to the specific episode or segment to which this budget line is allocated. Null for series-level or film-level lines that are not episode-specific.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `project_id` SET TAGS ('dbx_column_comment' = 'Reference to the parent production project to which this budget line belongs. Links the line item to its overarching production context.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `accrued_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `accrued_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `accrued_amount` SET TAGS ('dbx_column_comment' = 'Costs accrued for work performed or services received but not yet invoiced or formally committed. Supports period-end financial close and accurate cost-to-complete reporting.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `actual_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `actual_amount` SET TAGS ('dbx_column_comment' = 'Total actual costs incurred and posted against this budget line to date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `actual_amount` SET TAGS ('dbx_sourced_from_SAP_FI_invoice_postings_and_payroll_actuals_Used_for_variance_analysis_against_budgeted_and_committed_amounts' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this budget line was formally approved by the authorized approver. Provides an audit trail for financial governance and SOX compliance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budgeted_amount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budgeted_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budgeted_amount` SET TAGS ('dbx_column_comment' = 'Original approved budget amount for this line item as established at greenlight or budget approval. Represents the planned cost baseline against which actuals and commitments are measured.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `committed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `committed_amount` SET TAGS ('dbx_column_comment' = 'Total value of purchase orders');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `committed_amount` SET TAGS ('dbx_contracts' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `committed_amount` SET TAGS ('dbx_or_binding_agreements_raised_against_this_budget_line_but_not_yet_invoiced_Represents_financial_obligations_that_reduce_available_budget' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `contingency_pct` SET TAGS ('dbx_business_glossary_term' = 'Contingency Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `contingency_pct` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `contingency_pct` SET TAGS ('dbx_column_comment' = 'Contingency percentage applied to this budget line to cover unforeseen cost overruns. Typically 5–15% for production lines. Contributes to the overall production contingency reserve.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Production Cost Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_column_comment' = 'High-level cost category classifying the budget line within the production budget structure. Above-the-line covers creative talent (writers');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_directors' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_producers' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_cast);_below_the_line_covers_crew' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_equipment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_locations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_and_production_services_[ENUM_REF_CANDIDATE' = 'above_the_line');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_below_the_line' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_post_production' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_music_licensing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_vfx' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_marketing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_overhead' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_contingency' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_insurance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_legal_—_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_sub_category` SET TAGS ('dbx_business_glossary_term' = 'Production Cost Sub-Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_sub_category` SET TAGS ('dbx_column_comment' = 'Granular sub-classification within the cost category (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_sub_category` SET TAGS ('dbx_'Cast_Fees'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_sub_category` SET TAGS ('dbx_'Location_Fees'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_sub_category` SET TAGS ('dbx_'Equipment_Rental'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_sub_category` SET TAGS ('dbx_'VFX_Compositing'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_sub_category` SET TAGS ('dbx_'Music_Synchronization_License'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_sub_category` SET TAGS ('dbx_'Post_Production_Labor')_Enables_detailed_variance_analysis_at_the_sub_category_level' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this budget line record was first created in the system. Provides audit trail for record provenance and financial governance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Forecast Amount (EAC)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_column_comment' = 'Estimate at Completion (EAC) for this budget line');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_representing_the_current_best_estimate_of_total_cost_when_the_line_item_is_fully_complete_Combines_actuals_to_date_with_estimate_to_complete' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `fringe_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Fringe Benefit Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `fringe_rate_pct` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `fringe_rate_pct` SET TAGS ('dbx_column_comment' = 'Percentage applied to labor costs on this line to account for employer fringe benefits (payroll taxes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `fringe_rate_pct` SET TAGS ('dbx_pension_contributions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `fringe_rate_pct` SET TAGS ('dbx_health_insurance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `fringe_rate_pct` SET TAGS ('dbx_residuals)_Standard_production_accounting_practice_for_above_the_line_and_below_the_line_labor_lines' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `is_above_the_line` SET TAGS ('dbx_business_glossary_term' = 'Above-the-Line (ATL) Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `is_above_the_line` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `is_above_the_line` SET TAGS ('dbx_column_comment' = 'Flag indicating whether this budget line is classified as above-the-line (ATL) cost');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `is_above_the_line` SET TAGS ('dbx_covering_creative_talent_such_as_writers' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `is_above_the_line` SET TAGS ('dbx_directors' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `is_above_the_line` SET TAGS ('dbx_producers' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `is_above_the_line` SET TAGS ('dbx_and_principal_cast_False_indicates_below_the_line_(BTL)_cost' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `is_union_labor` SET TAGS ('dbx_business_glossary_term' = 'Union Labor Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `is_union_labor` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `is_union_labor` SET TAGS ('dbx_column_comment' = 'Flag indicating whether this budget line involves union or guild labor subject to collective bargaining agreements (DGA');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `is_union_labor` SET TAGS ('dbx_SAG_AFTRA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `is_union_labor` SET TAGS ('dbx_WGA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `is_union_labor` SET TAGS ('dbx_IATSE)_Drives_fringe_rate_calculations_and_residuals_obligations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `line_description` SET TAGS ('dbx_column_comment' = 'Free-text description of the specific cost item represented by this budget line (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `line_description` SET TAGS ('dbx_'Lead_Actor_Day_Rate_—_Week_3'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `line_description` SET TAGS ('dbx_'Steadicam_Rental_—_Principal_Photography'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `line_description` SET TAGS ('dbx_'Dolby_Atmos_Mix_—_Episode_4')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `line_number` SET TAGS ('dbx_column_comment' = 'Sequential line number within the parent budget document');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `line_number` SET TAGS ('dbx_used_for_ordering_and_referencing_individual_line_items_in_budget_reports_and_purchase_orders' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-text notes or comments entered by the production accountant or line producer providing additional context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_assumptions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_or_justification_for_this_budget_line_item' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `production_phase` SET TAGS ('dbx_business_glossary_term' = 'Production Phase');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `production_phase` SET TAGS ('dbx_value_regex' = 'development|pre_production|principal_photography|post_production|delivery|archive');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `production_phase` SET TAGS ('dbx_column_comment' = 'Phase of the production workflow during which this cost is incurred. Enables phase-based cost tracking and cash flow forecasting across the full production lifecycle from development through delivery.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_column_comment' = 'SAP purchase order number raised against this budget line for vendor commitments. Links the budget line to the formal procurement document and enables three-way matching (PO');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_goods_receipt' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_invoice)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Quantity');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `quantity` SET TAGS ('dbx_column_comment' = 'Quantity of units associated with this budget line (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `quantity` SET TAGS ('dbx_number_of_shoot_days' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `quantity` SET TAGS ('dbx_number_of_crew_members' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `quantity` SET TAGS ('dbx_number_of_VFX_shots' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `quantity` SET TAGS ('dbx_hours_of_post_production_labor)_Combined_with_unit_rate_to_derive_budgeted_amount' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `revised_budgeted_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budgeted Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `revised_budgeted_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `revised_budgeted_amount` SET TAGS ('dbx_column_comment' = 'Most recent approved revision to the budgeted amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `revised_budgeted_amount` SET TAGS ('dbx_reflecting_approved_change_orders' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `revised_budgeted_amount` SET TAGS ('dbx_scope_changes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `revised_budgeted_amount` SET TAGS ('dbx_or_budget_transfers_Null_if_no_revision_has_been_approved_since_original_budget' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `shoot_date_end` SET TAGS ('dbx_business_glossary_term' = 'Shoot End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `shoot_date_end` SET TAGS ('dbx_column_comment' = 'Planned or actual end date for the activity or service associated with this budget line. Used for scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `shoot_date_end` SET TAGS ('dbx_resource_allocation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `shoot_date_end` SET TAGS ('dbx_and_cost_accrual_period_determination' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `shoot_date_start` SET TAGS ('dbx_business_glossary_term' = 'Shoot Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `shoot_date_start` SET TAGS ('dbx_column_comment' = 'Planned or actual start date for the activity or service associated with this budget line (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `shoot_date_start` SET TAGS ('dbx_first_day_of_location_shoot' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `shoot_date_start` SET TAGS ('dbx_start_of_VFX_work' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `shoot_date_start` SET TAGS ('dbx_commencement_of_post_production_labor)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `tax_credit_eligible` SET TAGS ('dbx_business_glossary_term' = 'Tax Credit Eligible Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `tax_credit_eligible` SET TAGS ('dbx_column_comment' = 'Flag indicating whether this budget line qualifies for production tax credits or incentives (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `tax_credit_eligible` SET TAGS ('dbx_UK_High_End_TV_Tax_Relief' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `tax_credit_eligible` SET TAGS ('dbx_US_state_film_tax_credits)_Enables_automated_calculation_of_eligible_spend_for_tax_credit_claims' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `tax_credit_eligible` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_column_comment' = 'Unit of measure for the quantity field (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_day' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_hour' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_week' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_flat_fee' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_shot' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_reel' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_license)_Defines_how_the_quantity_is_counted_for_rate_based_cost_calculations_[ENUM_REF_CANDIDATE' = 'day');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_hour' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_week' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_flat_fee' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_shot' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_reel' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_license' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_unit_—_8_candidates_stripped;_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_column_comment' = 'Rate per unit of measure for this budget line (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_daily_rate_for_a_crew_member' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_hourly_rate_for_facility_hire' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_per_shot_rate_for_VFX)_Multiplied_by_quantity_to_derive_the_budgeted_amount' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this budget line record was most recently modified. Supports incremental data loading in the Databricks Silver Layer and change data capture from SAP S/4HANA.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_column_comment' = 'SAP Work Breakdown Structure element code that hierarchically positions this budget line within the production project plan (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_PRD_2024_001_3_2_1_for_a_specific_post_production_task)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` SET TAGS ('dbx_subdomain' = 'resource_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `crew_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Assignment ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `crew_assignment_id` SET TAGS ('dbx_column_comment' = 'Unique surrogate identifier for a crew assignment record in the production domain. Primary key for the crew_assignment data product.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Contract Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `deal_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Deal Memo Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `project_id` SET TAGS ('dbx_column_comment' = 'Reference to the production project to which this crew member is assigned. Links the assignment to the master production record.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `profile_id` SET TAGS ('dbx_column_comment' = 'Reference to the crew members master record in the talent domain. Identifies the individual below-the-line crew member being assigned.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Crew Assignment Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_value_regex' = '^CA-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_column_comment' = 'Externally-known business identifier for this crew assignment');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_used_in_deal_memos' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_call_sheets' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_and_payroll_processing_Format' = 'CA-{YEAR}-{SEQUENCE}.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `box_rental_rate` SET TAGS ('dbx_business_glossary_term' = 'Box Rental Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `box_rental_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `box_rental_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `box_rental_rate` SET TAGS ('dbx_column_comment' = 'Daily or weekly rate paid to the crew member for the rental of their personal tool box or specialized equipment package (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `box_rental_rate` SET TAGS ('dbx_makeup_artist's_kit' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `box_rental_rate` SET TAGS ('dbx_wardrobe_supervisor's_supplies)_Distinct_from_kit_rental_rate_which_covers_technical_equipment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_business_glossary_term' = 'Contracted Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_column_comment' = 'The agreed compensation rate for this crew assignment');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_expressed_in_the_applicable_deal_type_unit_(per_day' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_per_week' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_or_flat_total)_Stored_in_the_production's_base_currency_Used_for_budget_tracking_and_payroll_processing_in_SAP_S_4HANA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'The date and time when this crew assignment record was first created in the system. Used for audit trail');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_data_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_and_compliance_reporting_Conforms_to_ISO_8601_format_with_timezone_offset' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_name` SET TAGS ('dbx_business_glossary_term' = 'Screen Credit Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_name` SET TAGS ('dbx_column_comment' = 'The name as it should appear in the productions end credits');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_name` SET TAGS ('dbx_which_may_differ_from_the_crew_member's_legal_name_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_name` SET TAGS ('dbx_stage_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_name` SET TAGS ('dbx_preferred_professional_name)_Sourced_from_the_deal_memo_credit_clause' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_position` SET TAGS ('dbx_business_glossary_term' = 'Screen Credit Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_position` SET TAGS ('dbx_value_regex' = 'main_title|end_title|both|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_position` SET TAGS ('dbx_column_comment_Specifies_where_the_crew_member's_credit_appears_in_the_production' = 'main_title (opening credits)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_position` SET TAGS ('dbx_end_title_(closing_credits)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_position` SET TAGS ('dbx_both' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_position` SET TAGS ('dbx_or_none_(no_contractual_credit_obligation)_Drives_post_production_credit_sequence_assembly' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Workflow ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_column_comment' = 'The workflow instance identifier in Dalet Galaxy that corresponds to this crew assignments production workflow. Enables traceability between the HR/payroll record and the media asset management workflow orchestration system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Production Department');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_column_comment' = 'The production department to which the crew member belongs for this assignment (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_camera' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_grip' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_electric' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_art' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_wardrobe' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_hair_makeup' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_post_production' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_sound' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_VFX)_Drives_crew_call_sheet_grouping_and_budget_cost_center_allocation_[ENUM_REF_CANDIDATE' = 'camera');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_grip' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_electric' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_art' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_wardrobe' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_hair_makeup' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_post_production' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_sound' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_vfx' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_production_—_10_candidates_stripped;_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_column_comment' = 'The contractually agreed last day of work for this crew assignment. Nullable for open-ended or rolling assignments. Used for wrap scheduling and final payroll processing.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `filming_location_country` SET TAGS ('dbx_business_glossary_term' = 'Filming Location Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `filming_location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `filming_location_country` SET TAGS ('dbx_column_comment' = 'ISO 3166-1 alpha-3 country code for the primary filming location where this crew member will work. Determines applicable labor laws');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `filming_location_country` SET TAGS ('dbx_tax_treaties' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `filming_location_country` SET TAGS ('dbx_work_permit_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `filming_location_country` SET TAGS ('dbx_and_per_diem_rates' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `guaranteed_days` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Work Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `guaranteed_days` SET TAGS ('dbx_column_comment' = 'The minimum number of work days guaranteed to the crew member under this assignment deal');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `guaranteed_days` SET TAGS ('dbx_regardless_of_actual_production_schedule_Relevant_for_weekly_and_episodic_deal_types_Used_for_take_or_pay_liability_calculation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `kit_rental_rate` SET TAGS ('dbx_business_glossary_term' = 'Kit Rental Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `kit_rental_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `kit_rental_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `kit_rental_rate` SET TAGS ('dbx_column_comment' = 'Daily or weekly rate paid to the crew member for the rental of their personal professional equipment (kit) used on the production (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `kit_rental_rate` SET TAGS ('dbx_camera_operator's_lens_kit' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `kit_rental_rate` SET TAGS ('dbx_sound_mixer's_equipment_package)_Common_in_below_the_line_crew_deals' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_column_comment' = 'The date and time when this crew assignment record was most recently modified. Used for change data capture (CDC)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_audit_trail' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_and_Silver_layer_incremental_processing_in_the_Databricks_Lakehouse' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `meal_penalty_eligible` SET TAGS ('dbx_business_glossary_term' = 'Meal Penalty Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `meal_penalty_eligible` SET TAGS ('dbx_column_comment' = 'Indicates whether this crew member is entitled to meal penalty payments if the production fails to provide a meal break within the contractually required interval (typically 6 hours under IATSE/DGA agreements). Drives production scheduling compliance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Participant');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Participant');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Participant');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Participant');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_column_comment' = 'Indicates whether this crew member is eligible for overtime pay under their union/guild agreement or applicable labor law. True = eligible for overtime; False = flat deal or exempt classification. Drives payroll calculation logic.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `overtime_rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Rate Multiplier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `overtime_rate_multiplier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `overtime_rate_multiplier` SET TAGS ('dbx_column_comment' = 'The multiplier applied to the base contracted_rate for overtime hours (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `overtime_rate_multiplier` SET TAGS ('dbx_1_5_for_time_and_a_half' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `overtime_rate_multiplier` SET TAGS ('dbx_2_0_for_double_time)_Applicable_only_when_overtime_eligible_is_True_Sourced_from_the_applicable_union_guild_agreement' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_column_comment' = 'Daily allowance paid to the crew member for meals and incidental expenses when working away from their home base location. Rate varies by filming location and union agreement. Used for production cost budgeting.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `production_company` SET TAGS ('dbx_business_glossary_term' = 'Production Company Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `production_company` SET TAGS ('dbx_column_comment' = 'The legal name of the production company or entity that is the employer of record for this crew assignment. Relevant for co-productions where multiple entities may employ different crew members. Used for payroll and tax reporting.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `production_company` SET TAGS ('dbx_regulation' = 'PCI DSS');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `residuals_eligible` SET TAGS ('dbx_business_glossary_term' = 'Residuals Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `residuals_eligible` SET TAGS ('dbx_column_comment' = 'Indicates whether this crew member is entitled to residual payments when the production is reused');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `residuals_eligible` SET TAGS ('dbx_syndicated' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `residuals_eligible` SET TAGS ('dbx_or_distributed_on_additional_platforms_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `residuals_eligible` SET TAGS ('dbx_streaming' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `residuals_eligible` SET TAGS ('dbx_international_broadcast)_Residuals_are_governed_by_DGA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `residuals_eligible` SET TAGS ('dbx_IATSE' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `residuals_eligible` SET TAGS ('dbx_and_SAG_AFTRA_agreements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_business_glossary_term' = 'Crew Role Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_column_comment' = 'The specific production role or job title assigned to the crew member (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_Director' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_Director_of_Photography' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_Gaffer' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_Script_Supervisor' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_Editor' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_Colorist' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_VFX_Supervisor' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_Sound_Mixer' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_Key_Grip' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_Best_Boy)_[ENUM_REF_CANDIDATE' = 'director');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_director_of_photography' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_gaffer' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_script_supervisor' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_editor' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_colorist' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_vfx_supervisor' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_sound_mixer' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_key_grip' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_best_boy' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_production_designer' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_costume_designer_—_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `safety_training_certified` SET TAGS ('dbx_business_glossary_term' = 'Safety Training Certified Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `safety_training_certified` SET TAGS ('dbx_column_comment' = 'Indicates whether the crew member has completed the required on-set safety training certification for this production (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `safety_training_certified` SET TAGS ('dbx_OSHA_safety' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `safety_training_certified` SET TAGS ('dbx_COVID_19_protocols' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `safety_training_certified` SET TAGS ('dbx_stunt_safety)_Required_for_insurance_compliance_and_production_liability_management' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `scheduled_days` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Work Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `scheduled_days` SET TAGS ('dbx_column_comment' = 'The total number of work days currently scheduled for this crew member on the production');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `scheduled_days` SET TAGS ('dbx_as_reflected_in_the_current_production_schedule_May_differ_from_guaranteed_days_if_the_schedule_changes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_column_comment' = 'The contractually agreed first day of work for this crew assignment. Used for payroll calculation');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_permit_verification' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_and_production_schedule_alignment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `travel_allowance` SET TAGS ('dbx_business_glossary_term' = 'Travel Allowance');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `travel_allowance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `travel_allowance` SET TAGS ('dbx_column_comment' = 'Fixed or estimated travel reimbursement amount for this crew assignment');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `travel_allowance` SET TAGS ('dbx_covering_transportation_costs_to_and_from_the_filming_location_Distinct_from_per_diem_rate_which_covers_daily_living_expenses' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `turnaround_hours` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `turnaround_hours` SET TAGS ('dbx_column_comment' = 'The minimum number of hours required between the end of one work day and the start of the next for this crew member');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `turnaround_hours` SET TAGS ('dbx_as_stipulated_by_their_union_guild_agreement_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `turnaround_hours` SET TAGS ('dbx_10_hours_for_IATSE' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `turnaround_hours` SET TAGS ('dbx_12_hours_for_DGA)_Violation_triggers_turnaround_penalty_payments' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `union_guild_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Union / Guild Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `union_guild_affiliation` SET TAGS ('dbx_column_comment' = 'The labor union or guild to which the crew member belongs for this assignment. Determines applicable minimum rates');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `union_guild_affiliation` SET TAGS ('dbx_working_conditions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `union_guild_affiliation` SET TAGS ('dbx_residuals_obligations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `union_guild_affiliation` SET TAGS ('dbx_and_benefit_fund_contributions_DGA_Directors_Guild_of_America;_IATSE_International_Alliance_of_Theatrical_Stage_Employees;_SAG_AFTRA_Screen_Actors_Guild–American_Federation_of_Television_and_Radio_Artists;_WGA_Writers_Guild_of_America;_NABET_National_Association_of_Broadcast_Employees_and_Technicians;_Teamsters_International_Brotherhood_of_Teamsters_[ENUM_REF_CANDIDATE' = 'DGA');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `union_guild_affiliation` SET TAGS ('dbx_IATSE' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `union_guild_affiliation` SET TAGS ('dbx_SAG_AFTRA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `union_guild_affiliation` SET TAGS ('dbx_WGA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `union_guild_affiliation` SET TAGS ('dbx_NABET' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `union_guild_affiliation` SET TAGS ('dbx_Teamsters' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `union_guild_affiliation` SET TAGS ('dbx_non_union_—_7_candidates_stripped;_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_expiry_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_expiry_date` SET TAGS ('dbx_column_comment' = 'The expiration date of the crew members work permit or visa authorization. Used to trigger renewal alerts and ensure continuous legal work authorization throughout the assignment period.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_number` SET TAGS ('dbx_column_comment' = 'The official government-issued work permit or visa authorization number for the crew member in the production jurisdiction. Nullable when work_permit_required is False. Required for compliance audits and production insurance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_required` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_required` SET TAGS ('dbx_column_comment' = 'Indicates whether a work permit or visa authorization is required for this crew member to legally work on this production in the filming jurisdiction. True = permit required; False = no permit required (domestic/citizen crew). Triggers compliance workflow in HR.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` SET TAGS ('dbx_subdomain' = 'resource_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `facility_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Booking ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `facility_booking_id` SET TAGS ('dbx_column_comment' = 'Unique surrogate identifier for each facility booking record in the production domain. Primary key for the facility_booking data product.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `episode_id` SET TAGS ('dbx_business_glossary_term' = 'Episode ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `episode_id` SET TAGS ('dbx_column_comment' = 'Identifier of the specific episode or segment within the production project that requires this facility booking. Nullable for feature films or non-episodic productions.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `project_id` SET TAGS ('dbx_column_comment' = 'Identifier of the production project for which this facility is being booked. Links the booking to the overarching content production initiative.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `shoot_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shoot Schedule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `shoot_schedule_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_production_shoot_schedule_Business_justification' = 'Facility bookings are made for specific shoot schedule entries. Operational link — booking times align with shoot schedule. Optional FK (nullable) — facilities may also be booked for post-production o');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `actual_cost` SET TAGS ('dbx_column_comment' = 'The final invoiced or accrued cost of the facility booking after actual usage is confirmed. Includes any overtime charges or adjustments. Reconciled against estimated_cost for budget variance reporting in SAP S/4HANA CO.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `actual_end` SET TAGS ('dbx_business_glossary_term' = 'Actual End Datetime');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `actual_end` SET TAGS ('dbx_column_comment' = 'The actual date and time the facility usage concluded');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `actual_end` SET TAGS ('dbx_as_recorded_by_the_facility_operator_or_production_coordinator_Used_for_overtime_calculation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `actual_end` SET TAGS ('dbx_billing_reconciliation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `actual_end` SET TAGS ('dbx_and_schedule_variance_reporting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `actual_start` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Datetime');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `actual_start` SET TAGS ('dbx_column_comment' = 'The actual date and time the facility usage commenced');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `actual_start` SET TAGS ('dbx_as_recorded_by_the_facility_operator_or_production_coordinator_May_differ_from_booking_start_due_to_delays_or_early_starts_Used_for_variance_analysis_and_billing_reconciliation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `booking_end` SET TAGS ('dbx_business_glossary_term' = 'Booking End Datetime');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `booking_end` SET TAGS ('dbx_column_comment' = 'The scheduled date and time at which the facility booking period ends. Combined with booking_start to compute duration and detect scheduling conflicts across productions.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `booking_reference` SET TAGS ('dbx_business_glossary_term' = 'Booking Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `booking_reference` SET TAGS ('dbx_value_regex' = '^BK-[A-Z0-9]{8,16}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `booking_reference` SET TAGS ('dbx_column_comment' = 'Externally visible alphanumeric reference code assigned to this booking');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `booking_reference` SET TAGS ('dbx_used_in_communications_with_facility_operators' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `booking_reference` SET TAGS ('dbx_vendors' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `booking_reference` SET TAGS ('dbx_and_production_coordinators_Corresponds_to_the_booking_order_number_in_SAP_S_4HANA_MM_module' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `booking_start` SET TAGS ('dbx_business_glossary_term' = 'Booking Start Datetime');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `booking_start` SET TAGS ('dbx_column_comment' = 'The scheduled date and time at which the facility booking period begins. Used for conflict detection');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `booking_start` SET TAGS ('dbx_crew_scheduling' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `booking_start` SET TAGS ('dbx_and_playout_coordination_Stored_in_ISO_8601_format_with_timezone_offset' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_column_comment' = 'The date on which the facility booking was formally cancelled. Used to determine whether cancellation fees apply per the vendor contract terms and for financial accrual reversal in SAP S/4HANA.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `cancellation_fee` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `cancellation_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `cancellation_fee` SET TAGS ('dbx_column_comment' = 'Monetary penalty charged by the facility vendor when a confirmed booking is cancelled within the contractual notice period. Recorded for financial reconciliation and budget variance reporting.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_column_comment' = 'Free-text explanation for why the booking was cancelled. Populated only when booking_status is cancelled. Used for production post-mortem analysis and vendor dispute resolution.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_ENUM_REF_CANDIDATE' = 'promote-to-reference-product');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `capacity_persons` SET TAGS ('dbx_business_glossary_term' = 'Facility Capacity (Persons)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `capacity_persons` SET TAGS ('dbx_column_comment' = 'Maximum number of persons the facility can accommodate during the booking period. Used for crew planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `capacity_persons` SET TAGS ('dbx_health_and_safety_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `capacity_persons` SET TAGS ('dbx_and_resource_allocation_decisions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'The date and time when this facility booking record was first created in the system. Serves as the audit trail creation marker and is used for SLA compliance tracking and data lineage.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Workflow ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_column_comment' = 'Reference identifier of the associated workflow job in Dalet Galaxy Media Asset Management system. Enables traceability between the facility booking and the ingest');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_metadata' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_or_archive_workflow_triggered_by_the_production_activity' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_column_comment' = 'The projected total cost of the facility booking at the time of reservation');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_calculated_from_rate_amount_and_the_planned_booking_duration_Used_for_production_budget_planning_and_greenlight_approvals' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `facility_location` SET TAGS ('dbx_business_glossary_term' = 'Facility Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `facility_location` SET TAGS ('dbx_column_comment' = 'Physical location or campus of the facility (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `facility_location` SET TAGS ('dbx_'Burbank_Studio_Lot'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `facility_location` SET TAGS ('dbx_'London_Soho_Post')_Used_for_logistics_planning' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `facility_location` SET TAGS ('dbx_travel_coordination' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `facility_location` SET TAGS ('dbx_and_geographic_cost_allocation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Use Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_column_comment' = 'Indicates whether this booking grants exclusive use of the facility for the booked period');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_preventing_any_concurrent_bookings_by_other_productions_When_False' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_the_facility_may_be_shared_with_other_productions_subject_to_capacity_constraints' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Booking Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-text field for production coordinators to capture special requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `notes` SET TAGS ('dbx_setup_instructions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `notes` SET TAGS ('dbx_access_arrangements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `notes` SET TAGS ('dbx_or_other_operational_notes_relevant_to_the_facility_booking' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_column_comment' = 'Number of hours the facility was used beyond the originally booked end time. Drives overtime rate calculations and is a key input to actual_cost reconciliation and production schedule variance analysis.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `production_phase` SET TAGS ('dbx_business_glossary_term' = 'Production Phase');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `production_phase` SET TAGS ('dbx_column_comment_The_stage_of_the_content_production_lifecycle_during_which_this_facility_is_being_used_Enables_cost_allocation_by_production_phase_and_supports_milestone_tracking_[ENUM_REF_CANDIDATE' = 'pre_production');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `production_phase` SET TAGS ('dbx_principal_photography' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `production_phase` SET TAGS ('dbx_post_production' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `production_phase` SET TAGS ('dbx_vfx' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `production_phase` SET TAGS ('dbx_color_grading' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `production_phase` SET TAGS ('dbx_audio_mix' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `production_phase` SET TAGS ('dbx_delivery_—_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_column_comment' = 'SAP S/4HANA MM purchase order number raised for this facility booking when the facility is provided by an external vendor. Required for accounts payable processing and three-way match (PO');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_goods_receipt' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_invoice)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `rate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `rate_amount` SET TAGS ('dbx_column_comment' = 'The contracted rate charged for the facility per the applicable rate_type unit (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `rate_amount` SET TAGS ('dbx_cost_per_hour_or_cost_per_day)_Sourced_from_the_facility_rate_card_or_negotiated_contract_Used_for_budget_estimation_and_cost_allocation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'hourly|daily|half_day|weekly|flat_fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `rate_type` SET TAGS ('dbx_column_comment' = 'The billing rate structure applied to this facility booking. Determines how the total cost is calculated — per hour');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `rate_type` SET TAGS ('dbx_per_day' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `rate_type` SET TAGS ('dbx_half_day_block' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `rate_type` SET TAGS ('dbx_weekly_block' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `rate_type` SET TAGS ('dbx_or_a_negotiated_flat_fee' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `technical_specs` SET TAGS ('dbx_business_glossary_term' = 'Technical Specifications');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `technical_specs` SET TAGS ('dbx_column_comment' = 'Free-text description of the technical capabilities and equipment configuration of the facility at the time of booking (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `technical_specs` SET TAGS ('dbx_'Dolby_Atmos_7_1_4_mixing_console' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `technical_specs` SET TAGS ('dbx_Pro_Tools_HDX' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `technical_specs` SET TAGS ('dbx_4K_DI_suite')_Sourced_from_Dalet_Galaxy_facility_metadata' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'The date and time when this facility booking record was most recently modified. Used for change detection in ETL pipelines');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_audit_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_and_conflict_resolution_in_concurrent_update_scenarios' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `wbs_element` SET TAGS ('dbx_column_comment' = 'SAP S/4HANA Project System Work Breakdown Structure element code that identifies the specific production phase or deliverable to which this facility cost is charged. Enables granular project cost tracking.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` SET TAGS ('dbx_subdomain' = 'resource_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `equipment_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Allocation ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `equipment_allocation_id` SET TAGS ('dbx_column_comment' = 'Unique surrogate identifier for each equipment allocation record. Primary key for the equipment_allocation data product in the production domain.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `project_id` SET TAGS ('dbx_column_comment' = 'Reference to the production project or title to which this equipment is allocated. Links the allocation to the broader production workflow managed in Dalet Galaxy.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `shoot_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shoot Schedule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('dbx_column_comment' = 'The date on which the equipment allocation ends — i.e.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('dbx_the_last_day_the_equipment_is_assigned_to_the_production_Used_for_rental_cost_calculation_and_return_scheduling' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Allocation Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_value_regex' = '^EQALLOC-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_column_comment' = 'Externally-known business identifier for the allocation record');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_used_in_production_paperwork' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_crew_call_sheets' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_and_facility_booking_confirmations_Format' = 'EQALLOC-{YYYY}-{NNNNNN}.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `allocation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `allocation_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `allocation_start_date` SET TAGS ('dbx_column_comment' = 'The date on which the equipment allocation begins — i.e.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `allocation_start_date` SET TAGS ('dbx_the_first_day_the_equipment_is_available_to_the_production_Used_for_rental_rate_calculation_and_scheduling_conflict_detection' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `checkout_condition` SET TAGS ('dbx_business_glossary_term' = 'Equipment Condition at Checkout');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `checkout_condition` SET TAGS ('dbx_value_regex' = 'new|excellent|good|fair|poor');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `checkout_condition` SET TAGS ('dbx_column_comment' = 'Assessed physical condition of the equipment at the time of checkout. Establishes the baseline condition for damage assessment upon return. Recorded by the equipment manager.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `checkout_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Equipment Checkout Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `checkout_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `checkout_timestamp` SET TAGS ('dbx_column_comment' = 'Exact date and time the equipment was physically checked out from the equipment room or rental house. Serves as the principal business event timestamp for the allocation lifecycle.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the equipment allocation record was first created in the system. Supports audit trail requirements and data lineage tracking in the Databricks Silver Layer.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Workflow ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_column_comment' = 'Identifier of the associated Dalet Galaxy workflow instance that orchestrates the equipment allocation within the broader production ingest and post-production pipeline. Enables end-to-end workflow traceability.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `damage_claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Damage Claim Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `damage_claim_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `damage_claim_amount` SET TAGS ('dbx_column_comment' = 'Monetary value of the damage or loss claim raised against this allocation');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `damage_claim_amount` SET TAGS ('dbx_in_the_currency_specified_by_currency_code_Null_when_no_damage_claim_exists_Used_for_financial_reconciliation_and_insurance_recovery' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `damage_claim_amount` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `damage_description` SET TAGS ('dbx_business_glossary_term' = 'Equipment Damage Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `damage_description` SET TAGS ('dbx_column_comment' = 'Free-text description of any damage');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `damage_description` SET TAGS ('dbx_loss' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `damage_description` SET TAGS ('dbx_or_malfunction_identified_at_return_Null_when_equipment_is_returned_in_acceptable_condition_Used_to_support_insurance_claims_and_vendor_dispute_resolution' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `damage_description` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `equipment_name` SET TAGS ('dbx_business_glossary_term' = 'Equipment Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `equipment_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `equipment_name` SET TAGS ('dbx_column_comment' = 'Human-readable name or model designation of the equipment item (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `equipment_name` SET TAGS ('dbx_ARRI_ALEXA_Mini_LF' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `equipment_name` SET TAGS ('dbx_Cooke_S4_i_32mm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `equipment_name` SET TAGS ('dbx_Litepanels_Astra_6X)_Supports_crew_call_sheets_and_production_reports' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `equipment_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `equipment_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_column_comment' = 'Reference number of the insurance policy covering this equipment allocation. Used for claims processing and compliance with production insurance requirements.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `insurance_value` SET TAGS ('dbx_business_glossary_term' = 'Equipment Insurance Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `insurance_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `insurance_value` SET TAGS ('dbx_column_comment' = 'Declared replacement value of the equipment for insurance purposes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `insurance_value` SET TAGS ('dbx_in_the_currency_specified_by_currency_code_Used_to_calculate_insurance_premiums_and_process_loss_damage_claims' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `is_insurance_required` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `is_insurance_required` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `is_insurance_required` SET TAGS ('dbx_column_comment' = 'Indicates whether specific insurance coverage must be arranged for this equipment allocation (True) or whether it falls under the productions blanket policy (False). Relevant for high-value or specialist equipment.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `is_owned_asset` SET TAGS ('dbx_business_glossary_term' = 'Owned Asset Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `is_owned_asset` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `is_owned_asset` SET TAGS ('dbx_column_comment' = 'Indicates whether the equipment is owned by the production company (True) or rented from an external vendor (False). Drives depreciation accounting vs. rental cost booking in SAP S/4HANA FI.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-text field for additional operational notes related to the equipment allocation');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_such_as_special_handling_instructions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_configuration_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_or_crew_briefing_notes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Participant');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Participant');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Participant');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Participant');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `production_department` SET TAGS ('dbx_business_glossary_term' = 'Production Department');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `production_department` SET TAGS ('dbx_column_comment' = 'The production department responsible for the equipment allocation (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `production_department` SET TAGS ('dbx_camera' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `production_department` SET TAGS ('dbx_lighting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `production_department` SET TAGS ('dbx_grip' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `production_department` SET TAGS ('dbx_sound)_Used_for_departmental_budget_tracking_and_cost_centre_allocation_in_SAP_S_4HANA_CO_[ENUM_REF_CANDIDATE' = 'camera');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `production_department` SET TAGS ('dbx_lighting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `production_department` SET TAGS ('dbx_grip' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `production_department` SET TAGS ('dbx_sound' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `production_department` SET TAGS ('dbx_art' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `production_department` SET TAGS ('dbx_vfx' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `production_department` SET TAGS ('dbx_post_production' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `production_department` SET TAGS ('dbx_production_office' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `production_department` SET TAGS ('dbx_other_—_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_column_comment' = 'SAP S/4HANA purchase order number raised for the equipment rental from an external vendor. Null for owned assets. Used for three-way match (PO');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_goods_receipt' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_invoice)_in_accounts_payable' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Equipment Quantity');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `quantity` SET TAGS ('dbx_column_comment' = 'Number of identical equipment units covered by this allocation record (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `quantity` SET TAGS ('dbx_3_identical_LED_panels_allocated_as_a_single_record)_Defaults_to_1_for_individually_serialised_items' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `rental_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rental Rate Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `rental_rate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `rental_rate_amount` SET TAGS ('dbx_column_comment' = 'The agreed rental rate per day or per week (per rental_rate_type) for the equipment');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `rental_rate_amount` SET TAGS ('dbx_in_the_production's_base_currency_Used_for_production_budget_tracking_and_vendor_cost_reconciliation_in_SAP_S_4HANA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `rental_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rental Rate Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `rental_rate_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|flat_fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `rental_rate_type` SET TAGS ('dbx_column_comment' = 'Indicates whether the rental rate is charged on a daily');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `rental_rate_type` SET TAGS ('dbx_weekly' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `rental_rate_type` SET TAGS ('dbx_or_flat_fee_basis_Determines_how_the_total_rental_cost_is_computed_for_budget_tracking_and_vendor_invoice_reconciliation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `return_condition` SET TAGS ('dbx_business_glossary_term' = 'Equipment Condition at Return');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `return_condition` SET TAGS ('dbx_column_comment_Assessed_physical_condition_of_the_equipment_at_the_time_of_return_Compared_against_checkout_condition_to_identify_damage_or_deterioration_Triggers_damage_claim_workflow_if_degraded_[ENUM_REF_CANDIDATE' = 'new');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `return_condition` SET TAGS ('dbx_excellent' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `return_condition` SET TAGS ('dbx_good' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `return_condition` SET TAGS ('dbx_fair' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `return_condition` SET TAGS ('dbx_poor' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `return_condition` SET TAGS ('dbx_damaged' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `return_condition` SET TAGS ('dbx_lost_—_7_candidates_stripped;_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `return_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Equipment Return Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `return_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `return_timestamp` SET TAGS ('dbx_column_comment' = 'Exact date and time the equipment was physically returned to the equipment room or rental house. Null until the equipment is returned. Used to calculate actual rental duration and late return penalties.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Serial Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `serial_number` SET TAGS ('dbx_column_comment' = 'Manufacturer serial number of the specific equipment unit allocated. Used for asset tracking');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `serial_number` SET TAGS ('dbx_insurance_claims' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `serial_number` SET TAGS ('dbx_and_loss_damage_investigations_Classified_confidential_as_it_identifies_a_specific_high_value_asset' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the equipment allocation record was last modified. Used for change data capture (CDC) in the Databricks Silver Layer pipeline and audit compliance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_id` SET TAGS ('dbx_business_glossary_term' = 'Script Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the production script or screenplay record. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `clearance_request_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance Request Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `project_id` SET TAGS ('dbx_column_comment' = 'Reference to the parent production project or episode to which this script belongs.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `program_rundown_id` SET TAGS ('dbx_business_glossary_term' = 'Program Rundown Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `title_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_content_title_Business_justification' = 'Scripts are written for specific content titles. Essential for pre-production planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `title_id` SET TAGS ('dbx_rights_clearance_(script_based_content_analysis)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `title_id` SET TAGS ('dbx_and_tracking_script_versions_against_final_distributed_content' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Underlying Rights Holder Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `holder_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_rights_holder_Business_justification' = 'Scripts are often based on underlying IP owned by rights holders (novels');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `holder_id` SET TAGS ('dbx_plays' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `holder_id` SET TAGS ('dbx_life_rights' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `holder_id` SET TAGS ('dbx_true_stories' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `holder_id` SET TAGS ('dbx_existing_franchises)_Real_business_need' = 'tracking the rights holder of the underlying IP be');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Underlying Rights License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Writer Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Script Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `approval_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `approval_date` SET TAGS ('dbx_column_comment' = 'The date on which the script was officially approved for production.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `approved_by` SET TAGS ('dbx_column_comment' = 'The name or identifier of the individual or role who approved the script for production.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_business_glossary_term' = 'Copyright Holder');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_column_comment' = 'The legal entity or individual who holds the copyright to the script.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `copyright_year` SET TAGS ('dbx_business_glossary_term' = 'Copyright Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `copyright_year` SET TAGS ('dbx_column_comment' = 'The year in which the script copyright was established or registered.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when this script record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `dalet_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Document Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `dalet_document_reference` SET TAGS ('dbx_column_comment' = 'The unique document identifier or reference in the Dalet Galaxy Media Asset Management (MAM) system linking this script record to the digital script file.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `distribution_restriction` SET TAGS ('dbx_business_glossary_term' = 'Distribution Restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `distribution_restriction` SET TAGS ('dbx_column_comment' = 'Any restrictions or limitations on the distribution or sharing of the script (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `distribution_restriction` SET TAGS ('dbx_internal_use_only' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `distribution_restriction` SET TAGS ('dbx_NDA_required)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `estimated_runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Runtime in Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `estimated_runtime_minutes` SET TAGS ('dbx_column_comment' = 'The estimated runtime of the production in minutes based on the script length and pacing.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size in Megabytes (MB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_column_comment' = 'The size of the script file in megabytes.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Script Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `format` SET TAGS ('dbx_column_comment' = 'The production format for which the script is intended (feature film');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `format` SET TAGS ('dbx_television_episode' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `format` SET TAGS ('dbx_miniseries' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `format` SET TAGS ('dbx_web_series' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `format` SET TAGS ('dbx_documentary' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `format` SET TAGS ('dbx_commercial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `format` SET TAGS ('dbx_short_film)_[ENUM_REF_CANDIDATE' = 'feature film');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `format` SET TAGS ('dbx_television_episode' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `format` SET TAGS ('dbx_miniseries' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `format` SET TAGS ('dbx_web_series' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `format` SET TAGS ('dbx_documentary' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `format` SET TAGS ('dbx_commercial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `format` SET TAGS ('dbx_short_film_—_7_candidates_stripped;_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `genre` SET TAGS ('dbx_business_glossary_term' = 'Script Genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `genre` SET TAGS ('dbx_column_comment' = 'The genre or category of the script (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `genre` SET TAGS ('dbx_drama' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `genre` SET TAGS ('dbx_comedy' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `genre` SET TAGS ('dbx_thriller' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `genre` SET TAGS ('dbx_documentary)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Script Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `language` SET TAGS ('dbx_column_comment' = 'The primary language in which the script is written (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `language` SET TAGS ('dbx_English' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `language` SET TAGS ('dbx_Spanish' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `language` SET TAGS ('dbx_French)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `language` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `lock_date` SET TAGS ('dbx_business_glossary_term' = 'Script Lock Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `lock_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `lock_date` SET TAGS ('dbx_column_comment' = 'The date on which the script was locked and finalized for production.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `lock_status` SET TAGS ('dbx_business_glossary_term' = 'Script Lock Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `lock_status` SET TAGS ('dbx_column_comment' = 'Indicates whether the script is locked for production (true) or still open for revisions (false).');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Script Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'General notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `notes` SET TAGS ('dbx_comments' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `notes` SET TAGS ('dbx_or_annotations_related_to_the_script_for_production_reference' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Asset Structural Characteristic');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Asset Structural Characteristic');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Asset Structural Characteristic');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Asset Structural Characteristic');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Script Page Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `page_count` SET TAGS ('dbx_column_comment' = 'The total number of pages in the script document.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `page_count` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Script Revision Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `revision_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `revision_date` SET TAGS ('dbx_column_comment' = 'The date of the most recent revision or update to the script.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `revision_notes` SET TAGS ('dbx_business_glossary_term' = 'Revision Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `revision_notes` SET TAGS ('dbx_column_comment' = 'Notes or comments describing the changes made in the current revision of the script.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `scene_count` SET TAGS ('dbx_business_glossary_term' = 'Scene Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `scene_count` SET TAGS ('dbx_column_comment' = 'The total number of scenes defined in the script.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_number` SET TAGS ('dbx_business_glossary_term' = 'Script Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_number` SET TAGS ('dbx_column_comment' = 'The externally-known unique identifier or code assigned to this script for production tracking and reference purposes.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when this script record was last updated or modified.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Script Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `version_number` SET TAGS ('dbx_column_comment' = 'The version or revision number of the script (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `version_number` SET TAGS ('dbx_1_0' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `version_number` SET TAGS ('dbx_2_3' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `version_number` SET TAGS ('dbx_Final)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `wga_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Writers Guild of America (WGA) Registration Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `wga_registration_number` SET TAGS ('dbx_column_comment' = 'The WGA registration number assigned to this script for copyright and intellectual property protection.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` SET TAGS ('dbx_subdomain' = 'delivery_quality');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the production deliverable. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Abr Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_abr_profile_Business_justification' = 'Each deliverable conforms to specific ABR encoding profile for adaptive streaming distribution. Real business process: transcoding workflow configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_encoding_quality_control' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_and_streaming_optim' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Drm Policy Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_drm_policy_Business_justification' = 'Deliverables require specific DRM protection policies based on content rights and platform requirements. Real business process: content protection enforcement');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_rights_management' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_and_secure_delivery_c' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `isci_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Isci Creative Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `isci_creative_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_advertising_isci_creative_Business_justification' = 'Branded content deliverables often ARE the ad creative asset delivered to advertisers. Business process: branded content asset delivery to advertisers');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `isci_creative_id` SET TAGS ('dbx_product_integration_segment_handoff' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `isci_creative_id` SET TAGS ('dbx_advertiser' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_license_agreement_Business_justification' = 'Deliverables are created to fulfill specific license agreement technical and format requirements (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_HD_master_for_territory_X' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_dubbed_version_for_territory_Y)_Real_business_need' = 'linking delivera');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_column_comment' = 'Reference to the digital media asset in the Media Asset Management (MAM) system that represents this deliverable. Links to Dalet Galaxy or other MAM upon delivery.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `project_id` SET TAGS ('dbx_column_comment' = 'Reference to the parent production project that this deliverable belongs to.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `release_window_id` SET TAGS ('dbx_business_glossary_term' = 'Release Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `subscription_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Plan Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Target Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_ott_platform_Business_justification' = 'Deliverables are formatted for specific platforms with platform-specific technical requirements (resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_codec' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_DRM)_Real_business_process' = 'platform-specific asset preparation');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_transcoding' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_and_d' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `title_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_content_title_Business_justification' = 'Deliverables are final production outputs that become content titles in the distribution system. Critical for asset-to-content mapping');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `title_id` SET TAGS ('dbx_delivery_acceptance_workflows' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `title_id` SET TAGS ('dbx_and_tracking_which_production_del' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_column_comment' = 'Actual date and time when the deliverable was successfully delivered or handed off.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_column_comment' = 'Display aspect ratio of the video deliverable (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_'16' = '9');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_'4' = '3');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_'2_39' = '1');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_'1' = '1). Null for non-video deliverables.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `audio_channels` SET TAGS ('dbx_business_glossary_term' = 'Audio Channels');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `audio_channels` SET TAGS ('dbx_column_comment' = 'Audio channel configuration for the deliverable (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `audio_channels` SET TAGS ('dbx_'Stereo'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `audio_channels` SET TAGS ('dbx_'5_1_Surround'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `audio_channels` SET TAGS ('dbx_'7_1_Surround'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `audio_channels` SET TAGS ('dbx_'Mono'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `audio_channels` SET TAGS ('dbx_'Dolby_Atmos')_Null_for_non_audio_deliverables' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `audio_channels` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `audio_description_flag` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `audio_description_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `audio_description_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether an audio description track for visually impaired viewers is included. True = audio description present; False = no audio description.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `audio_description_flag` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'Checksum Message Digest 5 (MD5)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{32}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_column_comment' = 'MD5 hash of the deliverable file for integrity verification during transfer and storage.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `closed_caption_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `closed_caption_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `closed_caption_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether closed captions for accessibility are included in this deliverable. True = closed captions present; False = no closed captions.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `closed_caption_flag` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `compliance_certificate_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certificate Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `compliance_certificate_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `compliance_certificate_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether a regulatory compliance certificate (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `compliance_certificate_flag` SET TAGS ('dbx_FCC' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `compliance_certificate_flag` SET TAGS ('dbx_Ofcom' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `compliance_certificate_flag` SET TAGS ('dbx_content_rating)_accompanies_this_deliverable_True' = 'certificate included; False = no certificate.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `contract_reference` SET TAGS ('dbx_column_comment' = 'Reference number or identifier of the contract or agreement that mandates this deliverable.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `cost_amount` SET TAGS ('dbx_column_comment' = 'Total cost incurred to produce this deliverable');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `cost_amount` SET TAGS ('dbx_including_labor' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `cost_amount` SET TAGS ('dbx_equipment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `cost_amount` SET TAGS ('dbx_facilities' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `cost_amount` SET TAGS ('dbx_and_post_production_services' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this deliverable record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_location` SET TAGS ('dbx_column_comment' = 'Physical address');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_location` SET TAGS ('dbx_URL' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_location` SET TAGS ('dbx_FTP_path' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_location` SET TAGS ('dbx_or_cloud_storage_location_where_the_deliverable_was_sent_or_made_available' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `due_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `due_date` SET TAGS ('dbx_column_comment' = 'Contractually or operationally required date by which this deliverable must be completed and handed off.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_column_comment' = 'Total runtime duration of the deliverable in seconds (for video/audio deliverables). Null for non-time-based deliverables like documents or images.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_column_comment' = 'Total file size of the deliverable in bytes. Used for storage planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_transfer_time_estimation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_and_CDN_capacity_management' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_name` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_name` SET TAGS ('dbx_column_comment' = 'Human-readable name or title of the deliverable (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_name` SET TAGS ('dbx_'Broadcast_Master_HD'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_name` SET TAGS ('dbx_'Promo_Cut_30s'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_name` SET TAGS ('dbx_'Closed_Caption_SRT_File')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Asset Structural Characteristic');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Asset Structural Characteristic');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Asset Structural Characteristic');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Asset Structural Characteristic');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_notes` SET TAGS ('dbx_column_comment' = 'Detailed notes from the quality control review');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_notes` SET TAGS ('dbx_including_any_issues_found' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_notes` SET TAGS ('dbx_corrective_actions_taken' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_notes` SET TAGS ('dbx_or_validation_comments' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_operator_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Operator Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_operator_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_operator_name` SET TAGS ('dbx_column_comment' = 'Name of the quality control technician or automated system that performed the QC validation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_operator_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_operator_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_pass_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Pass Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_pass_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_pass_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the deliverable passed quality control validation. True = passed QC; False = failed QC or not yet tested.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_performed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Performed Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_performed_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_performed_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when quality control validation was completed for this deliverable.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `revision_notes` SET TAGS ('dbx_business_glossary_term' = 'Revision Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `revision_notes` SET TAGS ('dbx_column_comment' = 'Description of changes made in this revision of the deliverable (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `revision_notes` SET TAGS ('dbx_'Corrected_audio_sync_issue'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `revision_notes` SET TAGS ('dbx_'Updated_end_credits'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `revision_notes` SET TAGS ('dbx_'Re_encoded_for_HDR')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `revision_number` SET TAGS ('dbx_column_comment' = 'Version or revision number of this deliverable. Increments when the deliverable is updated or redelivered after corrections.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `scheduled_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `scheduled_delivery_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `scheduled_delivery_timestamp` SET TAGS ('dbx_column_comment' = 'Planned date and time for delivery of this deliverable to the recipient or platform.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_column_comment' = 'Comma-separated list of language codes for subtitle tracks included in this deliverable (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_'en' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_es' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_fr')_Null_if_no_subtitles_are_included' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this deliverable record was last modified.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` SET TAGS ('dbx_subdomain' = 'delivery_quality');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_review_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the quality control review record. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `version_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_content_version_Business_justification' = 'QC reviews validate specific content versions for distribution. Essential for version-level quality tracking');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `version_id` SET TAGS ('dbx_linking_production_QC_to_content_version_records' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `version_id` SET TAGS ('dbx_and_ensuring_only_QC_passed_versions_are' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_column_comment' = 'Reference to the production deliverable or post-production output being reviewed.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `isci_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Isci Creative Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_mediaasset_media_asset_Business_justification' = 'Production QC reviews inspect specific media assets for technical compliance before delivery. Role-prefixed as reviewed_asset_id since qc_review already links to deliverable. Essential for broadcast c');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `project_id` SET TAGS ('dbx_column_comment' = 'Reference to the parent production project this QC review belongs to.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Qc Inspection Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Target Abr Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_abr_profile_Business_justification' = 'QC reviews validate deliverables against target ABR profile specifications for distribution readiness. Real business process: quality assurance for streaming assets');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_technical_compliance_validation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_a' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_channel_configuration` SET TAGS ('dbx_business_glossary_term' = 'Audio Channel Configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_channel_configuration` SET TAGS ('dbx_column_comment' = 'Audio channel layout (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_channel_configuration` SET TAGS ('dbx_stereo' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_channel_configuration` SET TAGS ('dbx_5_1_surround' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_channel_configuration` SET TAGS ('dbx_7_1_surround' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_channel_configuration` SET TAGS ('dbx_mono)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_channel_configuration` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_codec` SET TAGS ('dbx_column_comment' = 'Audio codec used in the deliverable (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_codec` SET TAGS ('dbx_AAC' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_codec` SET TAGS ('dbx_Dolby_Digital' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_codec` SET TAGS ('dbx_PCM)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_codec` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_description_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Compliance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_description_compliance_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_description_compliance_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether audio description track meets accessibility standards. True if compliant');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_description_compliance_flag` SET TAGS ('dbx_False_if_missing_or_non_compliant' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_description_compliance_flag` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `closed_caption_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Compliance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `closed_caption_compliance_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `closed_caption_compliance_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether closed captions meet accessibility and regulatory standards (FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `closed_caption_compliance_flag` SET TAGS ('dbx_CVAA)_True_if_compliant' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `closed_caption_compliance_flag` SET TAGS ('dbx_False_if_violations_detected' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `closed_caption_compliance_flag` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the QC review record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Workflow ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_column_comment' = 'Identifier linking this QC review to the corresponding workflow instance in Dalet Galaxy MAM for ingest and workflow orchestration.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `error_codes` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Error Codes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `error_codes` SET TAGS ('dbx_column_comment' = 'Comma-separated list of specific error codes identified during the review');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `error_codes` SET TAGS ('dbx_aligned_with_EBU_R128' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `error_codes` SET TAGS ('dbx_ATSC_A_85' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `error_codes` SET TAGS ('dbx_and_ITU_R_BT_1788_standards_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `error_codes` SET TAGS ('dbx_V001_for_video_freeze' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `error_codes` SET TAGS ('dbx_A002_for_loudness_violation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `error_codes` SET TAGS ('dbx_C003_for_closed_caption_sync_error)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `final_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `final_approval_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `final_approval_date` SET TAGS ('dbx_column_comment' = 'Date when the deliverable received final approval for distribution. Null if not yet approved.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `loudness_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Loudness Compliance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `loudness_compliance_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `loudness_compliance_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the deliverable meets loudness standards (EBU R128 or ATSC A/85). True if compliant');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `loudness_compliance_flag` SET TAGS ('dbx_False_if_violations_detected' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `loudness_compliance_flag` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `loudness_lufs` SET TAGS ('dbx_business_glossary_term' = 'Loudness Level (LUFS)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `loudness_lufs` SET TAGS ('dbx_column_comment' = 'Measured integrated loudness level in LUFS (Loudness Units relative to Full Scale) per EBU R128 or ATSC A/85 standards. Target is typically -23 LUFS for broadcast.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `loudness_lufs` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Asset Structural Characteristic');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Asset Structural Characteristic');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Asset Structural Characteristic');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Asset Structural Characteristic');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p1_critical_error_count` SET TAGS ('dbx_business_glossary_term' = 'Priority 1 (P1) Critical Error Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p1_critical_error_count` SET TAGS ('dbx_column_comment' = 'Number of P1 critical errors that prevent broadcast or distribution (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p1_critical_error_count` SET TAGS ('dbx_audio_dropout' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p1_critical_error_count` SET TAGS ('dbx_video_corruption' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p1_critical_error_count` SET TAGS ('dbx_missing_segments)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p2_major_error_count` SET TAGS ('dbx_business_glossary_term' = 'Priority 2 (P2) Major Error Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p2_major_error_count` SET TAGS ('dbx_column_comment' = 'Number of P2 major errors that significantly impact quality but may not prevent distribution (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p2_major_error_count` SET TAGS ('dbx_color_grading_inconsistencies' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p2_major_error_count` SET TAGS ('dbx_audio_sync_issues)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p3_minor_error_count` SET TAGS ('dbx_business_glossary_term' = 'Priority 3 (P3) Minor Error Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p3_minor_error_count` SET TAGS ('dbx_column_comment' = 'Number of P3 minor errors that have minimal impact on viewer experience (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p3_minor_error_count` SET TAGS ('dbx_minor_subtitle_timing_issues' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p3_minor_error_count` SET TAGS ('dbx_cosmetic_artifacts)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p3_minor_error_count` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_notes` SET TAGS ('dbx_column_comment' = 'Free-text notes and observations recorded by the QC operator during the review');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_notes` SET TAGS ('dbx_including_context_for_errors_and_recommendations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_platform` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_platform` SET TAGS ('dbx_column_comment' = 'Name of the QC platform or tool used to perform the review (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_platform` SET TAGS ('dbx_Dalet_Galaxy_QC_module' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_platform` SET TAGS ('dbx_Tektronix_Sentry' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_platform` SET TAGS ('dbx_Interra_Baton)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|pending_review');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_result` SET TAGS ('dbx_column_comment_Overall_result_of_the_QC_review' = 'pass (no issues)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_result` SET TAGS ('dbx_fail_(critical_issues_preventing_distribution)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_result` SET TAGS ('dbx_conditional_pass_(minor_issues_requiring_remediation)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_result` SET TAGS ('dbx_or_pending_review_(awaiting_final_approval)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `re_qc_date` SET TAGS ('dbx_business_glossary_term' = 'Re-Quality Control (Re-QC) Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `re_qc_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `re_qc_date` SET TAGS ('dbx_column_comment' = 'Date when the deliverable was re-reviewed after remediation. Null if no re-QC has been performed.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `remediation_notes` SET TAGS ('dbx_business_glossary_term' = 'Remediation Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `remediation_notes` SET TAGS ('dbx_column_comment' = 'Detailed notes describing the remediation actions required to address identified errors and bring the deliverable into compliance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the deliverable requires remediation or correction before final approval. True if remediation needed');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_False_if_no_action_required' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_date` SET TAGS ('dbx_column_comment' = 'Date when the QC review was performed.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Duration (Minutes)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_duration_minutes` SET TAGS ('dbx_column_comment' = 'Total duration of the QC review session in minutes.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review End Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_end_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_end_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the QC operator completed the review session.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_number` SET TAGS ('dbx_column_comment' = 'Business identifier for the QC review');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_number` SET TAGS ('dbx_typically_formatted_as_a_human_readable_reference_code' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_start_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_start_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the QC operator began the review session.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `total_error_count` SET TAGS ('dbx_business_glossary_term' = 'Total Error Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `total_error_count` SET TAGS ('dbx_fact_metric' = 'monetary');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `total_error_count` SET TAGS ('dbx_column_comment' = 'Total number of errors identified across all severity levels during the QC review.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the QC review record was last modified.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_codec` SET TAGS ('dbx_column_comment' = 'Video codec used in the deliverable (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_codec` SET TAGS ('dbx_H_264' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_codec` SET TAGS ('dbx_H_265_HEVC' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_codec` SET TAGS ('dbx_ProRes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_codec` SET TAGS ('dbx_MPEG_2)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Video Frame Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_frame_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_frame_rate` SET TAGS ('dbx_column_comment' = 'Measured video frame rate (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_frame_rate` SET TAGS ('dbx_23_976' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_frame_rate` SET TAGS ('dbx_25' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_frame_rate` SET TAGS ('dbx_29_97' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_frame_rate` SET TAGS ('dbx_50' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_frame_rate` SET TAGS ('dbx_59_94_fps)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_resolution` SET TAGS ('dbx_column_comment' = 'Measured video resolution of the deliverable (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_resolution` SET TAGS ('dbx_1920x1080' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_resolution` SET TAGS ('dbx_3840x2160)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_column_comment' = 'Primary key for milestone');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Content Season Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `predecessor_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Milestone Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `predecessor_milestone_id` SET TAGS ('dbx_column_comment' = 'Reference to another milestone that must be completed before this milestone can begin or be achieved.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `project_id` SET TAGS ('dbx_column_comment' = 'Reference to the parent production project or episode for which this milestone is tracked.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Program Schedule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `release_window_id` SET TAGS ('dbx_business_glossary_term' = 'Release Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `title_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_content_title_Business_justification' = 'Production milestones track progress toward content title delivery. Essential for content delivery scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `title_id` SET TAGS ('dbx_windowing_plan_coordination' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `title_id` SET TAGS ('dbx_and_tracking_production_progress_against_content_distributio' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_column_comment' = 'The date on which the milestone was actually achieved or completed. Null if milestone has not yet been reached.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_authority` SET TAGS ('dbx_column_comment' = 'Name or role of the individual or committee authorized to approve this milestone (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_authority` SET TAGS ('dbx_Executive_Producer' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_authority` SET TAGS ('dbx_Network_Executive' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_authority` SET TAGS ('dbx_Showrunner)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_date` SET TAGS ('dbx_column_comment' = 'Date on which formal approval or sign-off was granted for this milestone. Null if approval is not yet obtained.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether formal approval or sign-off is required before this milestone can be marked as achieved.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Milestone Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `baseline_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `baseline_date` SET TAGS ('dbx_column_comment' = 'Approved baseline date for the milestone after initial project approval');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `baseline_date` SET TAGS ('dbx_used_for_variance_tracking_and_performance_measurement' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `budget_impact_usd` SET TAGS ('dbx_business_glossary_term' = 'Budget Impact in United States Dollars (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `budget_impact_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `budget_impact_usd` SET TAGS ('dbx_column_comment' = 'Estimated financial impact or cost associated with achieving this milestone');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `budget_impact_usd` SET TAGS ('dbx_or_cost_of_delay_if_milestone_is_missed' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this milestone record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this milestone is on the critical path of the production schedule');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_meaning_any_delay_directly_impacts_final_delivery_date' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Workflow Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_column_comment' = 'External identifier linking this milestone to the corresponding workflow or task in Dalet Galaxy Media Asset Management system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `deliverable_description` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `deliverable_description` SET TAGS ('dbx_column_comment' = 'Detailed description of the tangible output or deliverable associated with this milestone (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `deliverable_description` SET TAGS ('dbx_locked_picture_file' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `deliverable_description` SET TAGS ('dbx_final_audio_mix_stems' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `deliverable_description` SET TAGS ('dbx_QC_report)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `dependency_count` SET TAGS ('dbx_business_glossary_term' = 'Dependency Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `dependency_count` SET TAGS ('dbx_column_comment' = 'Number of other milestones or tasks that are dependent on the completion of this milestone.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Milestone Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `forecast_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `forecast_date` SET TAGS ('dbx_column_comment' = 'Current projected or estimated date for milestone completion based on latest production progress and risk assessment.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_column_comment' = 'Description of actions or contingency plans in place to address identified risks and ensure milestone is achieved.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_column_comment' = 'Human-readable name or title of the milestone event (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_Greenlight_Approval' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_Picture_Lock' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_Final_Delivery)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Milestone Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-form text field for additional context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `notes` SET TAGS ('dbx_comments' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `notes` SET TAGS ('dbx_or_observations_related_to_this_milestone_event' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Milestone Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_column_comment' = 'Originally scheduled or target date for achieving this milestone as defined during production planning.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `responsible_department` SET TAGS ('dbx_column_comment_The_production_department_or_functional_area_responsible_for_delivering_this_milestone_[ENUM_REF_CANDIDATE' = 'production');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `responsible_department` SET TAGS ('dbx_post_production' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `responsible_department` SET TAGS ('dbx_vfx' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `responsible_department` SET TAGS ('dbx_audio' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `responsible_department` SET TAGS ('dbx_editorial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `responsible_department` SET TAGS ('dbx_color' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `responsible_department` SET TAGS ('dbx_qc' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `responsible_department` SET TAGS ('dbx_delivery' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `responsible_department` SET TAGS ('dbx_archive' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `responsible_department` SET TAGS ('dbx_legal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `responsible_department` SET TAGS ('dbx_finance_—_11_candidates_stripped;_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `risk_description` SET TAGS ('dbx_column_comment' = 'Detailed explanation of identified risks');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `risk_description` SET TAGS ('dbx_issues' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `risk_description` SET TAGS ('dbx_or_blockers_that_may_prevent_timely_achievement_of_this_milestone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_business_glossary_term' = 'SAP Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_column_comment' = 'SAP project structure element code linking this milestone to the enterprise project management and financial tracking hierarchy.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `stakeholder_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Notification Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `stakeholder_notification_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `stakeholder_notification_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether stakeholders (network executives');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `stakeholder_notification_flag` SET TAGS ('dbx_distributors' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `stakeholder_notification_flag` SET TAGS ('dbx_talent)_must_be_notified_when_this_milestone_is_achieved_or_at_risk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this milestone record was last modified or updated.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `variance_days` SET TAGS ('dbx_business_glossary_term' = 'Milestone Variance in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `variance_days` SET TAGS ('dbx_column_comment' = 'Number of days difference between planned date and actual date (positive indicates delay');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `variance_days` SET TAGS ('dbx_negative_indicates_early_completion)_Calculated_field_for_reporting_purposes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the production location. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_column_comment' = 'Primary street address of the production location including street number and name.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_column_comment' = 'Secondary address information such as suite');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_building' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_or_unit_number' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `base_camp_capacity` SET TAGS ('dbx_business_glossary_term' = 'Base Camp Capacity');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `base_camp_capacity` SET TAGS ('dbx_column_comment' = 'Number of trailers or mobile units that can be accommodated at the base camp area near the location for cast');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `base_camp_capacity` SET TAGS ('dbx_crew' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `base_camp_capacity` SET TAGS ('dbx_wardrobe' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `base_camp_capacity` SET TAGS ('dbx_makeup' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `base_camp_capacity` SET TAGS ('dbx_and_catering' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `city` SET TAGS ('dbx_column_comment' = 'City or municipality where the location is situated.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this location record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Location Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `fee_amount` SET TAGS ('dbx_column_comment' = 'Total fee paid to the location owner or manager for the right to film at this location. Excludes additional costs such as permits');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `fee_amount` SET TAGS ('dbx_insurance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `fee_amount` SET TAGS ('dbx_or_restoration' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Location Fee Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `fee_currency` SET TAGS ('dbx_column_comment' = 'Three-letter ISO currency code for the location fee (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `fee_currency` SET TAGS ('dbx_USD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `fee_currency` SET TAGS ('dbx_CAD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `fee_currency` SET TAGS ('dbx_GBP' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `fee_currency` SET TAGS ('dbx_EUR)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `insurance_required_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `insurance_required_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the location owner requires specific production insurance coverage or certificates of insurance before filming can commence.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_column_comment' = 'Geographic latitude coordinate of the location in decimal degrees format');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_used_for_mapping' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_navigation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_and_sunrise_sunset_calculations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_column_comment' = 'Geographic longitude coordinate of the location in decimal degrees format');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_used_for_mapping' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_navigation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_and_logistics_planning' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `manager_notes` SET TAGS ('dbx_business_glossary_term' = 'Location Manager Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `manager_notes` SET TAGS ('dbx_column_comment' = 'Free-text notes and observations from the location manager regarding access');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `manager_notes` SET TAGS ('dbx_restrictions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `manager_notes` SET TAGS ('dbx_special_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `manager_notes` SET TAGS ('dbx_or_other_relevant_production_considerations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `manager_notes` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `location_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `location_name` SET TAGS ('dbx_column_comment' = 'Human-readable name or title of the production location (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `location_name` SET TAGS ('dbx_'Downtown_Warehouse_District'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `location_name` SET TAGS ('dbx_'Malibu_Beach_House'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `location_name` SET TAGS ('dbx_'Historic_City_Hall')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `location_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `location_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `noise_assessment` SET TAGS ('dbx_business_glossary_term' = 'Noise Assessment');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `noise_assessment` SET TAGS ('dbx_value_regex' = 'quiet|moderate|noisy|unacceptable');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `noise_assessment` SET TAGS ('dbx_column_comment_Assessment_of_ambient_noise_levels_at_the_location' = 'quiet (minimal background noise');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `noise_assessment` SET TAGS ('dbx_suitable_for_dialogue_recording)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `noise_assessment` SET TAGS ('dbx_moderate_(some_noise' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `noise_assessment` SET TAGS ('dbx_may_require_sound_treatment)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `noise_assessment` SET TAGS ('dbx_noisy_(significant_noise' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `noise_assessment` SET TAGS ('dbx_requires_ADR_or_sound_mitigation)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `noise_assessment` SET TAGS ('dbx_unacceptable_(excessive_noise' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `noise_assessment` SET TAGS ('dbx_unsuitable_for_production)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Owner Contact Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_column_comment' = 'Primary email address for the location owner or authorized representative for contract and coordination communications.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Owner Contact Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_column_comment' = 'Primary phone number for the location owner or authorized representative for coordination and emergency contact during production.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `parking_capacity` SET TAGS ('dbx_business_glossary_term' = 'Parking Capacity');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `parking_capacity` SET TAGS ('dbx_column_comment' = 'Number of vehicle parking spaces available at or near the location for crew');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `parking_capacity` SET TAGS ('dbx_cast' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `parking_capacity` SET TAGS ('dbx_and_equipment_trucks' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `permit_authority` SET TAGS ('dbx_business_glossary_term' = 'Permit Authority');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `permit_authority` SET TAGS ('dbx_column_comment' = 'Name of the governmental or regulatory authority responsible for issuing filming permits for this location (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `permit_authority` SET TAGS ('dbx_'Los_Angeles_Film_Office'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `permit_authority` SET TAGS ('dbx_'NYC_Mayor_Office_of_Media_and_Entertainment')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `permit_expiry_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `permit_expiry_date` SET TAGS ('dbx_column_comment' = 'Date when the filming permit expires and is no longer valid for production use.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `permit_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Issue Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `permit_issue_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `permit_issue_date` SET TAGS ('dbx_column_comment' = 'Date when the filming permit was officially issued by the permitting authority.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `permit_number` SET TAGS ('dbx_column_comment' = 'Official permit or authorization number issued by the permitting authority for filming at this location.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `power_availability` SET TAGS ('dbx_business_glossary_term' = 'Power Availability');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `power_availability` SET TAGS ('dbx_value_regex' = 'grid|generator_required|limited|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `power_availability` SET TAGS ('dbx_column_comment_Assessment_of_electrical_power_availability_at_the_location' = 'grid (connected to utility power)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `power_availability` SET TAGS ('dbx_generator_required_(no_grid_power' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `power_availability` SET TAGS ('dbx_generators_needed)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `power_availability` SET TAGS ('dbx_limited_(some_power_available_but_insufficient_for_full_production)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `power_availability` SET TAGS ('dbx_none_(no_power_infrastructure)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `region` SET TAGS ('dbx_column_comment' = 'Broader geographic region or area classification (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `region` SET TAGS ('dbx_'Southern_California'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `region` SET TAGS ('dbx_'Pacific_Northwest'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `region` SET TAGS ('dbx_'New_England')_used_for_production_planning_and_logistics' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `restoration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Restoration Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `restoration_required_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `restoration_required_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the production is contractually obligated to restore the location to its original condition after filming concludes.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `restroom_facilities` SET TAGS ('dbx_business_glossary_term' = 'Restroom Facilities');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `restroom_facilities` SET TAGS ('dbx_value_regex' = 'on_site|portable_required|nearby|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `restroom_facilities` SET TAGS ('dbx_column_comment_Assessment_of_restroom_availability' = 'on site (permanent facilities available)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `restroom_facilities` SET TAGS ('dbx_portable_required_(portable_restrooms_must_be_brought_in)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `restroom_facilities` SET TAGS ('dbx_nearby_(facilities_within_walking_distance)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `restroom_facilities` SET TAGS ('dbx_none_(no_facilities_available)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `safety_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Assessment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `safety_assessment_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `safety_assessment_date` SET TAGS ('dbx_column_comment' = 'Date when the safety assessment was conducted by the production safety officer or third-party assessor.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_column_comment' = 'State');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_province' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_or_administrative_region_of_the_location' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this location record was last modified in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `water_availability` SET TAGS ('dbx_business_glossary_term' = 'Water Availability');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `water_availability` SET TAGS ('dbx_value_regex' = 'available|limited|trucked_in_required|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `water_availability` SET TAGS ('dbx_column_comment_Assessment_of_water_access_at_the_location' = 'available (connected to water supply)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `water_availability` SET TAGS ('dbx_limited_(some_water_but_insufficient_for_full_crew)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `water_availability` SET TAGS ('dbx_trucked_in_required_(no_water_infrastructure' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `water_availability` SET TAGS ('dbx_must_be_transported)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `water_availability` SET TAGS ('dbx_none_(no_water_access)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Transaction Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_transaction_id` SET TAGS ('dbx_column_comment' = 'Primary key for cost_transaction');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_production_budget_line_Business_justification' = 'Cost transactions are posted against specific budget line items. Currently uses budget_line_reference (STRING) — replacing with FK to budget_line.budget_line_id provides referential integrity and enab');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Production Budget ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `budget_id` SET TAGS ('dbx_column_comment' = 'Reference to the specific budget line or cost object this transaction is charged against.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `project_id` SET TAGS ('dbx_column_comment' = 'Reference to the production project against which this cost transaction is posted.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `approval_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `approval_date` SET TAGS ('dbx_column_comment' = 'Date on which the transaction was approved for payment.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Category Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_column_comment' = 'Code representing the cost category or expense type (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_talent' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_equipment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_location' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_post_production)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Category Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_column_comment' = 'Descriptive name of the cost category or expense classification.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this cost transaction record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_transaction_description` SET TAGS ('dbx_column_comment' = 'Detailed description or narrative of the cost transaction');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_transaction_description` SET TAGS ('dbx_including_purpose_and_context' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_column_comment' = 'Exchange rate applied to convert the transaction amount to the reporting currency.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_column_comment' = 'Fiscal period (month or quarter) within the fiscal year for this transaction.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_column_comment' = 'Fiscal year in which the transaction was posted for financial reporting purposes.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `invoice_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `invoice_date` SET TAGS ('dbx_column_comment' = 'Date on the vendor invoice or billing document.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `invoice_date` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `invoice_number` SET TAGS ('dbx_column_comment' = 'Vendor invoice number or billing reference for this transaction.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `invoice_number` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_column_comment' = 'Net transaction amount excluding taxes and other adjustments.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Additional notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_comments' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_or_special_instructions_related_to_this_transaction' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `omc_asset_structural_characteristic_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `omc_concept_role` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `omc_context_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_business_glossary_term' = 'MovieLabs OMC Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `omc_participant_code` SET TAGS ('dbx_omc_aligned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payee_name` SET TAGS ('dbx_business_glossary_term' = 'Payee Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payee_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payee_name` SET TAGS ('dbx_column_comment' = 'Name of the individual or entity receiving payment for this transaction (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payee_name` SET TAGS ('dbx_crew_member' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payee_name` SET TAGS ('dbx_contractor' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payee_name` SET TAGS ('dbx_petty_cash_recipient)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payee_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payee_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_date` SET TAGS ('dbx_column_comment' = 'Date on which payment was made or is scheduled to be made for this transaction.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_date` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|check|credit_card|petty_cash|ach|payroll');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_column_comment_Method_used_for_payment' = 'wire transfer');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_check' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_credit_card' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_petty_cash' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_ACH' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_or_payroll' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|paid|cancelled|on_hold|rejected');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_status` SET TAGS ('dbx_column_comment_Current_payment_status_of_the_transaction' = 'pending');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_status` SET TAGS ('dbx_approved' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_status` SET TAGS ('dbx_paid' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_status` SET TAGS ('dbx_cancelled' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_status` SET TAGS ('dbx_on_hold' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_status` SET TAGS ('dbx_or_rejected' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_status` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_column_comment' = 'The date on which the transaction was posted to the general ledger in SAP.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `production_phase` SET TAGS ('dbx_business_glossary_term' = 'Production Phase');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `production_phase` SET TAGS ('dbx_value_regex' = 'pre_production|principal_photography|post_production|delivery|closed');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `production_phase` SET TAGS ('dbx_column_comment_Phase_of_production_during_which_this_cost_was_incurred' = 'pre-production');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `production_phase` SET TAGS ('dbx_principal_photography' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `production_phase` SET TAGS ('dbx_post_production' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `production_phase` SET TAGS ('dbx_delivery' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `production_phase` SET TAGS ('dbx_or_closed' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_column_comment' = 'Purchase order number associated with this transaction');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_if_applicable' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `reporting_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `reporting_currency_amount` SET TAGS ('dbx_column_comment' = 'Transaction amount converted to the standard reporting currency (typically USD) for consolidated financial reporting.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Document Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_column_comment' = 'SAP S/4HANA financial document number (FI/CO posting document) associated with this transaction.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `sap_line_item_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Line Item Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `sap_line_item_number` SET TAGS ('dbx_column_comment' = 'Line item number within the SAP document for granular traceability.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_business_glossary_term' = 'SAP Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_column_comment' = 'SAP WBS element representing the project structure node for this cost transaction.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_column_comment' = 'Tax amount associated with this transaction');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_if_applicable' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_column_comment' = 'The monetary amount of the cost transaction in the original transaction currency.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_column_comment' = 'The date on which the cost transaction was incurred or posted in the financial system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_column_comment' = 'Business-facing unique transaction number or document reference for this cost entry.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this cost transaction record was last updated or modified.');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
