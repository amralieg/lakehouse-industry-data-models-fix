-- Schema for Domain: production | Business: Media Broadcasting | Version: v1_mvm
-- Generated on: 2026-05-08 19:23:33

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `media_broadcasting_ecm`.`production` COMMENT 'Manages the end-to-end content production and post-production workflow — from greenlight and pre-production planning through principal photography, editing, VFX, color grading, audio mixing, transcoding, and final delivery. Tracks production budgets, crew assignments, shoot schedules, facility bookings, equipment allocation, and deliverable milestones. Integrates with Dalet Galaxy for ingest and workflow orchestration.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`production`.`project` (
    `project_id` BIGINT COMMENT 'Primary key for project',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.partner_agreement. Business justification: Master agreement governance: business affairs teams track which master partner agreement governs a production projects commercial terms (IP ownership, revenue share, creative control). Required for c',
    `asset_collection_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_collection. Business justification: When a production project is greenlighted, a corresponding MAM asset collection is created to group all project media assets for lifecycle management, bulk QC, and archival operations. Broadcast MAM o',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Production projects bill clients/studios for production services, co-production arrangements, or facility rentals through billing accounts. Essential for production service invoicing, milestone billin',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Projects are commissioned for specific broadcast channels/networks. Network commissioning process requires tracking which channel ordered the content. Essential for content planning, budget allocation',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: Greenlight/commissioning workflow: a broadcaster or distributor commissions a production project under a distribution agreement that defines funding, delivery specs, and territory. Business affairs te',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Production projects are greenlit with specific delivery channel targets (e.g., a FAST channel original, a linear network series). This is a core media-broadcasting greenlight process — the delivery ch',
    `distribution_partner_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_partner. Business justification: Production projects are commissioned by or produced for specific distribution partners (e.g., a cable operator orders an original series). This is a fundamental media-broadcasting output deal process.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Each production project is owned by a specific legal entity for tax incentive claims, co-production treaty compliance, and intercompany billing. Media groups structure productions under dedicated lega',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Projects often have master license agreements governing distribution rights (co-production deals, pre-sales, output deals). Real business need: tracking which license agreements fund or govern a produ',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Content licensing and syndication sales opportunities reference specific production projects to verify rights availability, establish cost basis for pricing, coordinate delivery schedules, and ensure ',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Production projects are executed by or with external production companies (partners). Linking enables contract management, payment processing, co-production tracking, and rights negotiation. The `prod',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Projects must track which regulatory obligations apply based on content type, distribution channels, and target audience. Drives compliance planning and budget allocation for regulatory requirements.',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Greenlight decisions and content P&L reporting require linking each production project to its primary revenue stream (theatrical, SVOD, linear licensing). Finance uses this FK for content ROI analysis',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Productions are commissioned for specific streaming platforms (Netflix Originals, HBO Max Exclusives). Platform determines technical specs, content ratings, delivery windows. Real business process: pl',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Production projects create content titles - this is the master link for tracking which title a production project is creating. Essential for content delivery tracking, rights management, and productio',
    `upfront_deal_id` BIGINT COMMENT 'Foreign key linking to sales.upfront_deal. Business justification: Upfront deals commit advertisers to specific programming volumes; production projects are greenlighted to fulfill those content commitments. Production planning, greenlight approvals, and budget autho',
    `actual_delivery_date` DATE COMMENT 'Date on which the final deliverable was actually delivered to the distribution or broadcast platform. Compared against target_delivery_date to measure on-time delivery performance and SLA compliance.',
    `actual_spend_usd` DECIMAL(18,2) COMMENT 'Cumulative actual expenditure incurred against this production project to date, denominated in US Dollars. Sourced from SAP S/4HANA cost postings. Compared against approved_budget_usd for variance and financial reconciliation reporting.',
    `approved_budget_usd` DECIMAL(18,2) COMMENT 'Total production budget formally approved at greenlight, denominated in US Dollars. Represents the authorized spend ceiling for the project. Used for financial controlling, variance analysis, and EBITDA reporting in SAP S/4HANA.',
    `co_production_flag` BOOLEAN COMMENT 'Indicates whether this production project is a co-production involving one or more external production partners. Triggers co-production agreement workflows, shared rights structures, and split budget reporting in SAP S/4HANA.',
    `content_genre` STRING COMMENT 'Primary genre classification of the content being produced (e.g., drama, comedy, thriller, sports, news, reality). Used for audience targeting, scheduling, advertising sales, and rights windowing strategies. [ENUM-REF-CANDIDATE: drama|comedy|thriller|action|documentary|news|reality|sports|animation|horror — promote to reference product]',
    `content_rating` STRING COMMENT 'Official content rating assigned by the Motion Picture Association (MPA) or TV Parental Guidelines system. Governs broadcast scheduling, advertising eligibility, and platform distribution restrictions including COPPA compliance for childrens content. [ENUM-REF-CANDIDATE: G|PG|PG-13|R|NC-17|TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA — 11 candidates stripped; promote to reference product]',
    `coppa_applicable` BOOLEAN COMMENT 'Indicates whether this production is directed at children under 13 and therefore subject to COPPA compliance requirements. Affects data collection practices, advertising eligibility, and platform distribution restrictions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production project record was first created in the lakehouse Silver layer. Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the budget and spend amounts recorded on this project (e.g., USD, GBP, EUR). Supports multi-currency production environments for international co-productions.. Valid values are `^[A-Z]{3}$`',
    `dalet_workflow_reference` STRING COMMENT 'Integration reference identifier linking this production project to its corresponding workflow instance in Dalet Galaxy Media Asset Management and Workflow Orchestration system. Enables cross-system traceability for ingest, metadata, archive, and workflow operations.',
    `drm_required` BOOLEAN COMMENT 'Indicates whether Digital Rights Management (DRM) protection must be applied to the delivered content assets. Drives technical delivery specifications for CDN, streaming platform configuration, and Akamai CDN security settings.',
    `eidr` STRING COMMENT 'Entertainment Identifier Registry (EIDR) identifier for this content project. Provides a universal, persistent identifier for the title across supply chain partners, distributors, and platforms.. Valid values are `^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-Z]$`',
    `episode_count` STRING COMMENT 'Total number of episodes commissioned for this production project. Applicable to scripted and unscripted series. Used for budget modeling, scheduling, and rights licensing calculations. Null for single-title formats such as feature films.',
    `fcc_license_required` BOOLEAN COMMENT 'Indicates whether this production requires FCC broadcast licensing compliance review prior to linear broadcast distribution. Applicable to content intended for over-the-air or cable transmission in the United States.',
    `greenlight_date` DATE COMMENT 'Calendar date on which the production project received formal executive greenlight approval. Marks the official start of the production lifecycle and triggers budget release and resource mobilization.',
    `greenlight_status` STRING COMMENT 'Executive approval status of the production project. Indicates whether the project has received formal greenlight authorization to proceed, is pending approval, is on hold, or has been cancelled. Controls budget release and resource mobilization.. Valid values are `pending|greenlighted|on_hold|cancelled|completed`',
    `isan` STRING COMMENT 'Globally unique identifier assigned to this audiovisual work under the International Standard Audiovisual Number (ISAN) standard (ISO 15706). Used for rights management, royalty tracking, and cross-platform content identification.. Valid values are `^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}$`',
    `original_ip_flag` BOOLEAN COMMENT 'Indicates whether this production is based on original intellectual property owned by the organization, as opposed to licensed or adapted IP. Affects rights ownership, residuals obligations, and long-term asset valuation.',
    `post_production_start_date` DATE COMMENT 'Scheduled or actual date on which post-production activities commenced, including editing, VFX, color grading, audio mixing, and transcoding. Used for facility booking and deliverable milestone planning.',
    `pre_production_start_date` DATE COMMENT 'Scheduled or actual date on which pre-production activities commenced, including casting, location scouting, script breakdown, and crew hiring. Used for production planning and milestone tracking.',
    `primary_language` STRING COMMENT 'ISO 639-1 or ISO 639-2 language code for the primary language in which the content is produced (e.g., en, es, fr). Drives localization, dubbing, subtitling, and distribution territory planning.. Valid values are `^[a-z]{2,3}$`',
    `principal_photography_end_date` DATE COMMENT 'Scheduled or actual date on which principal photography concluded (picture wrap). Triggers transition to post-production phase and initiates post-production resource scheduling.',
    `principal_photography_start_date` DATE COMMENT 'Scheduled or actual date on which principal photography (primary filming) commenced. A key production milestone used for crew scheduling, facility booking, and insurance activation.',
    `production_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary country in which the production is being executed. Determines applicable regulatory frameworks, tax incentive eligibility, and co-production treaty benefits.. Valid values are `^[A-Z]{3}$`',
    `production_format` STRING COMMENT 'Primary technical production format and resolution specification (e.g., 4K UHD, HD 1080p, HDR10). Determines post-production pipeline, transcoding requirements, and delivery specifications for broadcast and streaming platforms. [ENUM-REF-CANDIDATE: 4K_UHD|HD_1080p|HD_720p|SD|HDR10|Dolby_Vision|IMAX — 7 candidates stripped; promote to reference product]',
    `production_phase` STRING COMMENT 'Current phase of the content production lifecycle. Tracks the projects progression from development through delivery. Used to gate workflow steps, resource allocation, and financial milestone releases.. Valid values are `development|pre_production|principal_photography|post_production|delivery|archived`',
    `project_type` STRING COMMENT 'Classification of the content production project by format and genre category. Drives production workflow templates, budget models, rights structures, and scheduling logic. [ENUM-REF-CANDIDATE: scripted_series|feature_film|documentary|live_event|news_segment|unscripted_series|short_form — promote to reference product]',
    `sap_wbs_element` STRING COMMENT 'SAP S/4HANA Work Breakdown Structure element code that maps this production project to the enterprise financial controlling hierarchy for budget tracking, cost allocation, and financial reconciliation.',
    `season_number` STRING COMMENT 'Season number within a series franchise. Used to link this production project to prior seasons for rights continuity, talent residuals, and audience analytics. Null for non-series formats.',
    `synopsis` STRING COMMENT 'Short narrative description of the content production projects story, subject matter, or editorial concept. Used for internal greenlight documentation, sales pitches, EPG metadata, and Dalet Galaxy asset metadata.',
    `target_delivery_date` DATE COMMENT 'Contractually committed or internally planned date by which the finished content must be delivered to distribution, broadcast, or streaming platforms. Drives post-production scheduling, windowing strategy, and SLA compliance.',
    `total_runtime_minutes` STRING COMMENT 'Total planned or delivered runtime of the production in minutes. For series, this is the aggregate runtime across all episodes. Used for scheduling, licensing, and royalty calculations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this production project record was most recently modified in the lakehouse Silver layer. Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change tracking, incremental processing, and audit compliance.',
    CONSTRAINT pk_project PRIMARY KEY(`project_id`)
) COMMENT 'Master record for a content production project — the greenlit initiative that drives all production activity. Captures the project title, type (scripted series, feature film, documentary, live event, news segment), greenlight status, production phase (development, pre-production, principal photography, post-production, delivery), approved budget, actual spend, production company, showrunner or executive producer, target delivery date, ISAN identifier, and integration reference to Dalet Galaxy workflow. This is the top-level anchor entity for the entire production domain.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` (
    `shoot_schedule_id` BIGINT COMMENT 'Unique surrogate identifier for a shoot schedule record in the production domain. Primary key for the shoot_schedule data product.',
    `location_id` BIGINT COMMENT 'Foreign key linking to production.location. Business justification: Normalization opportunity. Shoot schedule currently has location_name (STRING). FK to location table provides referential integrity and enables retrieving full location details (address, permits, safe',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: A shoot schedule day is tied to a specific production episode being filmed. shoot_schedule already links to project, but in a series production each shoot day is associated with a specific episode. Ad',
    `project_id` BIGINT COMMENT 'Reference to the parent production project to which this shoot schedule day belongs. Links the daily schedule to the overarching production entity.',
    `script_id` BIGINT COMMENT 'Foreign key linking to production.script. Business justification: shoot_schedule has scene_numbers as a text field referencing specific script scenes being shot on a given day. Adding script_id creates a proper FK to the script being filmed on that shoot day, enabli',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Block shooting across multiple episodes of a season is standard in episodic TV. Production coordinators plan shoot schedules at the season level for resource allocation and season delivery reporting. ',
    `actual_extras_count` STRING COMMENT 'The actual number of background performers (extras) who worked on this shoot day. Used for payroll reconciliation, SAG-AFTRA reporting, and production cost tracking.',
    `actual_shoot_hours` DECIMAL(18,2) COMMENT 'The actual number of hours spent in principal photography for the day. Used for budget reconciliation, overtime calculation, and production efficiency analysis.',
    `actual_wrap_time` TIMESTAMP COMMENT 'The actual time at which principal photography concluded for the day. Compared against scheduled wrap time to calculate overtime and assess schedule adherence.',
    `call_time` TIMESTAMP COMMENT 'The scheduled time at which cast and crew are required to report to set. Used for crew coordination, transport logistics, and facility readiness planning.',
    `cover_set_description` STRING COMMENT 'Description of the alternate interior or cover set designated for use if weather or other conditions prevent the primary shoot. Only applicable when weather_contingency_flag is True.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp at which this shoot schedule record was first created in the system. Supports audit trail, data lineage, and compliance requirements.',
    `dalet_workflow_reference` STRING COMMENT 'The workflow instance identifier assigned by Dalet Galaxy for the ingest and orchestration workflow associated with this shoot days deliverables. Enables traceability between the shoot schedule and downstream media asset management processes.',
    `day_out_of_days_type` STRING COMMENT 'Industry-standard Day Out of Days (DOOD) designation indicating the cast/crew work status for this shoot day. SW=Start Work, W=Work, WF=Work Finish, F=Finish, H=Hold, D=Drop, SWF=Start Work Finish. Used for talent scheduling, residuals calculation, and SAG-AFTRA compliance. [ENUM-REF-CANDIDATE: SW|W|WF|F|H|D|SWF — 7 candidates stripped; promote to reference product]',
    `estimated_extras_count` STRING COMMENT 'The planned number of background performers (extras) required for this shoot day. Used for casting coordination, catering planning, and SAG-AFTRA background performer compliance.',
    `estimated_shoot_hours` DECIMAL(18,2) COMMENT 'The planned number of shooting hours for the day, used for budget forecasting, crew scheduling, and facility booking. Expressed in decimal hours (e.g., 10.50 = 10 hours 30 minutes).',
    `first_shot_time` TIMESTAMP COMMENT 'The scheduled or actual time at which the first camera roll of the day begins. A key production efficiency metric used to assess set readiness and pre-production effectiveness.',
    `is_overtime_day` BOOLEAN COMMENT 'Indicates whether this shoot day resulted in overtime hours for cast or crew, triggering additional compensation obligations under union agreements (SAG-AFTRA, DGA, IATSE). Derived operationally but stored for compliance and payroll audit purposes.',
    `meal_penalty_flag` BOOLEAN COMMENT 'Indicates whether a meal penalty was incurred on this shoot day due to failure to provide a meal break within the union-mandated interval (typically 6 hours). Triggers additional compensation obligations under SAG-AFTRA and IATSE agreements.',
    `page_count` DECIMAL(18,2) COMMENT 'The number of script pages scheduled for photography on this shoot day, expressed in eighths of a page per industry convention (e.g., 4.625 = 4 and 5/8 pages). A standard production efficiency metric used to assess daily output against industry benchmarks.',
    `production_notes` STRING COMMENT 'Free-text field capturing significant events, issues, or observations from the shoot day, including equipment failures, weather delays, cast illness, or creative changes. Sourced from the daily production report.',
    `production_unit` STRING COMMENT 'Identifies the filming unit responsible for this shoot day. Main unit is led by the principal director; second unit handles action sequences or supplemental footage; splinter unit shoots simultaneously with main unit on a separate set; insert unit captures close-up or detail shots.. Valid values are `main_unit|second_unit|splinter_unit|insert_unit`',
    `revision_date` DATE COMMENT 'The date on which the current revision of this shoot schedule was issued. Used to track the cadence of schedule changes and identify the most current approved version.',
    `revision_version` STRING COMMENT 'The version identifier of this shoot schedule revision (e.g., v1, v3-BLUE, Rev-7). Production schedules are revised frequently; tracking version enables audit of changes and comparison of planned vs. actual across revisions.',
    `scene_numbers` STRING COMMENT 'Comma-separated list of scene numbers from the production script scheduled for photography on this shoot day (e.g., 12, 13A, 14, 15B). Derived from the stripboard and used for script supervisor tracking and editorial planning.',
    `schedule_number` STRING COMMENT 'Externally-known alphanumeric identifier for this shoot schedule record, used in production paperwork, call sheets, and cross-system references (e.g., SS-2024-0042).',
    `schedule_status` STRING COMMENT 'Current lifecycle state of the shoot schedule day. Drives workflow actions and reporting across production management. [ENUM-REF-CANDIDATE: draft|confirmed|in_progress|completed|cancelled|postponed — promote to reference product if additional states are required]. Valid values are `draft|confirmed|in_progress|completed|cancelled|postponed`',
    `scheduled_wrap_time` TIMESTAMP COMMENT 'The planned time at which principal photography is expected to conclude for the day. Used for facility booking, crew scheduling, and overtime cost estimation.',
    `shoot_date` DATE COMMENT 'The calendar date on which principal photography is scheduled or was executed. The primary business event date for this schedule record.',
    `shoot_day_number` STRING COMMENT 'Sequential shoot day number within the production (e.g., Day 1, Day 15, Day 42). Used to track production progress against the total approved shoot days and for budget burn-rate analysis.',
    `shoot_type` STRING COMMENT 'Classifies the nature of the shoot day environment. Distinguishes between controlled studio environments and on-location shoots, which have different logistical, permitting, and cost implications.. Valid values are `studio|location|exterior|interior|mixed`',
    `total_approved_shoot_days` STRING COMMENT 'The total number of principal photography days approved in the production greenlight. Used to calculate schedule completion percentage and identify overages requiring executive approval.',
    `turnaround_hours` DECIMAL(18,2) COMMENT 'The minimum rest period in hours between the wrap of the previous shoot day and the call time of this shoot day. Union agreements (SAG-AFTRA, DGA, IATSE) mandate minimum turnaround periods; violations trigger penalty payments.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp at which this shoot schedule record was most recently modified. Used for change detection, incremental data loading in the Databricks Silver Layer, and audit trail maintenance.',
    `weather_contingency_flag` BOOLEAN COMMENT 'Indicates whether this shoot day has a weather contingency plan in place. When True, an alternate interior or cover set is designated in case outdoor conditions prevent the primary shoot. Critical for location shoots and insurance risk management.',
    CONSTRAINT pk_shoot_schedule PRIMARY KEY(`shoot_schedule_id`)
) COMMENT 'Day-by-day principal photography schedule for a production project. Tracks shoot dates, call times, wrap times, location or studio facility, scene numbers, unit (main unit, second unit, splinter unit), director, first assistant director, estimated vs actual shoot hours, weather contingency flags, and schedule revision version. Integrates with facility booking and crew assignment to coordinate all on-set resources. Distinct from the EPG scheduling domain which governs broadcast playout.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`production`.`budget` (
    `budget_id` BIGINT COMMENT 'Primary key for budget',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Branded content and co-production budgets are allocated against specific advertising campaigns. Campaign-level P&L reporting and production cost reconciliation require linking production spend directl',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Production budgets are mapped to GL account structures for SAP integration, period-end close, and variance reporting. Media finance teams require every budget version to reference the chart of account',
    `coproduction_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.coproduction_agreement. Business justification: Co-production financial reporting: finance teams track actual production spend against each partys contractual investment obligation (our_investment_amount, our_investment_percentage) defined in the ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Production budgets must be assigned to cost centers for financial consolidation, variance analysis, and departmental P&L reporting. Replaces denormalized sap_cost_center_code with proper FK for SAP in',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Production budgets must be attributed to a legal entity for intercompany accounting, tax credit claims, and statutory consolidation. Media groups (e.g., Warner Bros., NBCUniversal) produce content und',
    `production_budget_id` BIGINT COMMENT 'Foreign key linking to finance.production_budget. Business justification: The production domains operational budget (line-producer view) must reconcile against the finance domains production_budget (SAP/finance system view). Production cost controllers perform budget-to-a',
    `project_id` BIGINT COMMENT 'Reference to the parent production project this budget record belongs to. Links the financial control baseline to the production entity.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Production budgets must roll up to profit centers for segment reporting, EBITDA calculation, and covenant compliance. Media companies track production profitability by business unit/channel (profit ce',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Season-level budgets are the primary financial control unit in episodic TV production. Season budget vs. actual reports are a mandatory deliverable to studio finance and co-production partners. Budget',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Series-level greenlight budgets and deficit financing are core studio finance processes. Finance teams track approved budgets per series for multi-season renewals and co-production deal reporting. Bud',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Cumulative actual costs incurred to date for this cost category, sourced from SAP S/4HANA FI/CO actual postings. Represents real expenditure against the approved budget.',
    `approval_status` STRING COMMENT 'Current workflow approval status of this budget record. DRAFT = in preparation; PENDING_APPROVAL = submitted for sign-off; APPROVED = formally authorized; REJECTED = returned for revision; LOCKED = frozen for actuals comparison; CLOSED = production complete.. Valid values are `DRAFT|PENDING_APPROVAL|APPROVED|REJECTED|LOCKED|CLOSED`',
    `approved_amount` DECIMAL(18,2) COMMENT 'The formally approved budget amount for this cost category and version, representing the financial control baseline authorized by the production greenlight committee.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this budget version was formally approved by the authorized signatory. Null if not yet approved.',
    `budget_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this budget record within the production finance system. Used for cross-system reference and reporting.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `change_reason` STRING COMMENT 'Free-text narrative explaining the business justification for a budget revision (e.g., Schedule extension due to weather delays, Additional VFX shots approved by director). Mandatory for revised versions.',
    `change_request_reference` STRING COMMENT 'Reference number of the formal budget change request (BCR) document that authorized a revision to this budget line, traceable in the production finance approval workflow.',
    `committed_amount` DECIMAL(18,2) COMMENT 'Total value of open purchase order commitments (obligations) for this cost category that have been raised but not yet invoiced. Represents encumbered funds in the SAP MM/CO commitment ledger.',
    `contingency_amount` DECIMAL(18,2) COMMENT 'The absolute monetary value of the contingency reserve allocated for this cost category, derived from the contingency percentage applied to the approved budget amount.',
    `contingency_percentage` DECIMAL(18,2) COMMENT 'The percentage of the approved budget allocated as contingency reserve for this cost category, representing the risk buffer approved by the production finance committee.',
    `cost_category_code` STRING COMMENT 'SAP cost element or cost category code classifying the type of production expenditure (e.g., ATL-TALENT, BTL-CREW, BTL-EQUIPMENT, POST-VFX, POST-AUDIO). [ENUM-REF-CANDIDATE: ATL-TALENT|ATL-RIGHTS|BTL-CREW|BTL-EQUIPMENT|BTL-FACILITIES|BTL-TRAVEL|POST-VFX|POST-AUDIO|POST-COLOR|CONTINGENCY — promote to reference product]',
    `cost_category_name` STRING COMMENT 'Human-readable name of the production cost category (e.g., Above-the-Line Talent, Below-the-Line Crew, Visual Effects, Audio Post-Production).',
    `cost_line_type` STRING COMMENT 'High-level classification of the cost line distinguishing above-the-line (ATL) creative costs (writers, directors, producers, talent) from below-the-line (BTL) technical and crew costs, post-production, contingency, and overhead.. Valid values are `ABOVE_THE_LINE|BELOW_THE_LINE|POST_PRODUCTION|CONTINGENCY|OVERHEAD`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was first created in the source system or ingested into the Databricks Silver Layer. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all monetary amounts on this budget record are denominated (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert this budget records currency to the productions reporting currency at the time of budget approval or revision.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month number 1–12 or 1–16 for special periods) within the fiscal year to which this budget line is assigned in SAP CO.',
    `fiscal_year` STRING COMMENT 'The four-digit fiscal year to which this budget record belongs in the SAP S/4HANA CO controlling area, used for annual financial planning and SOX reporting.',
    `forecast_amount` DECIMAL(18,2) COMMENT 'Latest estimate of the total cost expected to be incurred for this cost category by production completion, incorporating actuals to date and projected remaining spend.',
    `is_greenlight_budget` BOOLEAN COMMENT 'Indicates whether this budget record represents the original greenlight-approved budget for the production, as distinct from subsequent revisions. The greenlight budget is the primary financial authorization baseline.',
    `is_locked` BOOLEAN COMMENT 'Indicates whether this budget version has been locked and is no longer open for modification. A locked budget serves as the immutable financial baseline for variance reporting.',
    `notes` STRING COMMENT 'Free-text field for additional commentary, assumptions, or clarifications associated with this budget record, entered by the production finance team.',
    `period_end_date` DATE COMMENT 'The end date of the fiscal or production period covered by this budget record. Defines the temporal boundary for cost accumulation and variance measurement.',
    `period_start_date` DATE COMMENT 'The start date of the fiscal or production period covered by this budget record, aligning to the SAP fiscal year/period structure.',
    `production_phase` STRING COMMENT 'The production lifecycle phase to which this budget line is attributed (e.g., Development, Pre-Production, Principal Photography, Post-Production, Delivery). Enables phase-level budget tracking.. Valid values are `DEVELOPMENT|PRE_PRODUCTION|PRINCIPAL_PHOTOGRAPHY|POST_PRODUCTION|DELIVERY|CLOSED`',
    `reporting_currency_code` STRING COMMENT 'ISO 4217 three-letter code for the group reporting currency to which all amounts are translated for consolidated financial reporting (e.g., USD for a US-headquartered broadcaster).. Valid values are `^[A-Z]{3}$`',
    `revised_amount` DECIMAL(18,2) COMMENT 'The most recently revised budget amount for this cost category following a formal budget change request. Null if no revision has been approved since the original budget.',
    `sap_cost_object_code` STRING COMMENT 'The SAP S/4HANA CO cost object identifier (Internal Order number or WBS Element ID) that anchors this budget record to the controlling module for financial reconciliation.',
    `sap_wbs_element` STRING COMMENT 'SAP Project System Work Breakdown Structure element code that maps this budget line to a specific phase or deliverable within the production project hierarchy (e.g., PRE-PROD, PRINCIPAL, POST-PROD).',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this budget record was sourced (SAP S/4HANA CO for financial data, Dalet Galaxy for workflow-linked cost data, or MANUAL for spreadsheet-originated entries).. Valid values are `SAP_S4HANA|DALET_GALAXY|MANUAL`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this budget record in the source system or Silver Layer. Used for incremental load detection and change data capture.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between the approved (or revised) budget amount and the sum of actual costs plus commitments. A negative value indicates an over-budget condition; positive indicates underspend.',
    `version` STRING COMMENT 'Version label of this budget record, distinguishing the original greenlight budget from subsequent revisions and the locked final version. Supports budget version history tracking.. Valid values are `ORIGINAL|REVISED_1|REVISED_2|REVISED_3|FINAL|LOCKED`',
    `version_number` STRING COMMENT 'Sequential integer version number of this budget record (e.g., 1 = original, 2 = first revision). Enables ordered version history and audit trail.',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Detailed production budget record aligned to the SAP S/4HANA CO (Controlling) module. Captures above-the-line and below-the-line cost categories, approved budget amounts by cost category, revised budget amounts, actual costs to date, purchase order commitments, variance amounts, currency, budget version, and approval status. Serves as the financial control baseline for a production project. Links to SAP cost centers and WBS elements for financial reconciliation.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`production`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Unique surrogate identifier for each individual budget line item within a production budget. Primary key for this entity.',
    `budget_id` BIGINT COMMENT 'Reference to the parent production budget document that contains this line item. A production may have multiple budget versions (e.g., greenlight, revised, final).',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to advertising.campaign. Business justification: Budget lines track advertiser-funded production costs for branded content and product integrations. Business process: advertiser co-production cost allocation, campaign-funded production expense track',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Each budget line maps to a GL account for cost reporting, variance analysis, and SAP journal posting. The existing gl_account_code is a denormalized text representation of chart_of_accounts. Finance t',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.contract. Business justification: Above-the-line budget lines (actor/director fees) are directly governed by talent contracts. Production finance teams link budget lines to contracts for pay-or-play liability tracking, cost-to-contrac',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Individual budget line items must post to cost centers for detailed expense tracking and actuals vs. budget variance reporting. Required for monthly financial close and departmental budget management.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: When production costs are incurred, journal entries are posted against budget lines for accrual accounting and cost commitment tracking. Production accountants reconcile budget lines against journal e',
    `partner_id` BIGINT COMMENT 'Reference to the vendor, supplier, or payee associated with this budget line item (e.g., VFX house, location owner, equipment rental company, music licensor).',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: budget_line already has a cross-domain content_episode_id but lacks an in-domain production_episode_id. Budget lines are frequently allocated at the episode level (e.g., VFX costs per episode, directo',
    `project_id` BIGINT COMMENT 'Reference to the parent production project to which this budget line belongs. Links the line item to its overarching production context.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Compliance cost tracking: budget lines for closed captioning, accessibility, or FCC filing fees must be traceable to the specific regulatory obligation driving the expenditure. Media broadcasting fina',
    `royalty_rule_id` BIGINT COMMENT 'Foreign key linking to rights.royalty_rule. Business justification: Production accountants budget royalty and residual obligations per budget line using specific royalty rules. This link enables accurate royalty accrual forecasting during production budgeting. No exis',
    `shoot_schedule_id` BIGINT COMMENT 'Foreign key linking to production.shoot_schedule. Business justification: budget_line has shoot_date_start and shoot_date_end as free-text date fields, indicating budget lines are tied to specific shoot periods. Adding shoot_schedule_id normalizes this to a proper FK relati',
    `account_code` STRING COMMENT 'Industry-standard production account code identifying the cost category within the budget (e.g., 1100 for Above-the-Line Talent, 2200 for Camera Equipment). Follows standard production accounting chart of accounts (e.g., AICP, Producers Guild).. Valid values are `^[A-Z0-9]{2,10}$`',
    `accrued_amount` DECIMAL(18,2) COMMENT 'Costs accrued for work performed or services received but not yet invoiced or formally committed. Supports period-end financial close and accurate cost-to-complete reporting.',
    `actual_amount` DECIMAL(18,2) COMMENT 'Total actual costs incurred and posted against this budget line to date, sourced from SAP FI invoice postings and payroll actuals. Used for variance analysis against budgeted and committed amounts.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line was formally approved by the authorized approver. Provides an audit trail for financial governance and SOX compliance.',
    `budgeted_amount` DECIMAL(18,2) COMMENT 'Original approved budget amount for this line item as established at greenlight or budget approval. Represents the planned cost baseline against which actuals and commitments are measured.',
    `committed_amount` DECIMAL(18,2) COMMENT 'Total value of purchase orders, contracts, or binding agreements raised against this budget line but not yet invoiced. Represents financial obligations that reduce available budget.',
    `contingency_pct` DECIMAL(18,2) COMMENT 'Contingency percentage applied to this budget line to cover unforeseen cost overruns. Typically 5–15% for production lines. Contributes to the overall production contingency reserve.',
    `cost_category` STRING COMMENT 'High-level cost category classifying the budget line within the production budget structure. Above-the-line covers creative talent (writers, directors, producers, cast); below-the-line covers crew, equipment, locations, and production services. [ENUM-REF-CANDIDATE: above_the_line|below_the_line|post_production|music_licensing|vfx|marketing|overhead|contingency|insurance|legal — promote to reference product]',
    `cost_sub_category` STRING COMMENT 'Granular sub-classification within the cost category (e.g., Cast Fees, Location Fees, Equipment Rental, VFX Compositing, Music Synchronization License, Post-Production Labor). Enables detailed variance analysis at the sub-category level.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line record was first created in the system. Provides audit trail for record provenance and financial governance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this budget line (e.g., USD, GBP, EUR). Supports multi-currency production budgets for international co-productions.. Valid values are `^[A-Z]{3}$`',
    `forecast_amount` DECIMAL(18,2) COMMENT 'Estimate at Completion (EAC) for this budget line, representing the current best estimate of total cost when the line item is fully complete. Combines actuals to date with estimate to complete.',
    `fringe_rate_pct` DECIMAL(18,2) COMMENT 'Percentage applied to labor costs on this line to account for employer fringe benefits (payroll taxes, pension contributions, health insurance, residuals). Standard production accounting practice for above-the-line and below-the-line labor lines.',
    `is_above_the_line` BOOLEAN COMMENT 'Flag indicating whether this budget line is classified as above-the-line (ATL) cost, covering creative talent such as writers, directors, producers, and principal cast. False indicates below-the-line (BTL) cost.',
    `is_union_labor` BOOLEAN COMMENT 'Flag indicating whether this budget line involves union or guild labor subject to collective bargaining agreements (DGA, SAG-AFTRA, WGA, IATSE). Drives fringe rate calculations and residuals obligations.',
    `line_description` STRING COMMENT 'Free-text description of the specific cost item represented by this budget line (e.g., Lead Actor Day Rate — Week 3, Steadicam Rental — Principal Photography, Dolby Atmos Mix — Episode 4).',
    `line_number` STRING COMMENT 'Sequential line number within the parent budget document, used for ordering and referencing individual line items in budget reports and purchase orders.',
    `line_status` STRING COMMENT 'Current lifecycle status of the budget line item, tracking its progression from initial draft through approval, commitment, invoicing, and payment. Drives workflow routing and financial reporting. [ENUM-REF-CANDIDATE: draft|approved|committed|invoiced|paid|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text notes or comments entered by the production accountant or line producer providing additional context, assumptions, or justification for this budget line item.',
    `production_phase` STRING COMMENT 'Phase of the production workflow during which this cost is incurred. Enables phase-based cost tracking and cash flow forecasting across the full production lifecycle from development through delivery.. Valid values are `development|pre_production|principal_photography|post_production|delivery|archive`',
    `purchase_order_number` STRING COMMENT 'SAP purchase order number raised against this budget line for vendor commitments. Links the budget line to the formal procurement document and enables three-way matching (PO, goods receipt, invoice).',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of units associated with this budget line (e.g., number of shoot days, number of crew members, number of VFX shots, hours of post-production labor). Combined with unit_rate to derive budgeted amount.',
    `revised_budgeted_amount` DECIMAL(18,2) COMMENT 'Most recent approved revision to the budgeted amount, reflecting approved change orders, scope changes, or budget transfers. Null if no revision has been approved since original budget.',
    `tax_credit_eligible` BOOLEAN COMMENT 'Flag indicating whether this budget line qualifies for production tax credits or incentives (e.g., UK High-End TV Tax Relief, US state film tax credits). Enables automated calculation of eligible spend for tax credit claims.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity field (e.g., day, hour, week, flat_fee, shot, reel, license). Defines how the quantity is counted for rate-based cost calculations. [ENUM-REF-CANDIDATE: day|hour|week|flat_fee|shot|reel|license|unit — 8 candidates stripped; promote to reference product]',
    `unit_rate` DECIMAL(18,2) COMMENT 'Rate per unit of measure for this budget line (e.g., daily rate for a crew member, hourly rate for facility hire, per-shot rate for VFX). Multiplied by quantity to derive the budgeted amount.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line record was most recently modified. Supports incremental data loading in the Databricks Silver Layer and change data capture from SAP S/4HANA.',
    `wbs_element` STRING COMMENT 'SAP Work Breakdown Structure element code that hierarchically positions this budget line within the production project plan (e.g., PRD-2024-001.3.2.1 for a specific post-production task).',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Individual line-item within a production budget, representing a specific cost category or account code (e.g., cast fees, location fees, equipment rental, VFX, music licensing, post-production labor). Captures account code, cost category, sub-category, vendor or payee, budgeted amount, committed amount, actual amount, episode or segment allocation, and SAP G/L account reference. Enables granular cost tracking and variance analysis at the line-item level.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` (
    `crew_assignment_id` BIGINT COMMENT 'Unique surrogate identifier for a crew assignment record in the production domain. Primary key for the crew_assignment data product.',
    `cba_rate_card_id` BIGINT COMMENT 'Foreign key linking to talent.cba_rate_card. Business justification: Union crew assignments must reference the applicable CBA rate card to calculate correct scale rates, overtime multipliers, meal penalties, and turnaround compliance. Production payroll systems require',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.contract. Business justification: Production payroll and labor relations require tracing each crew assignment to its governing talent contract for rate verification, pay-or-play enforcement, and residual eligibility determination. Eve',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Crew labor costs must be assigned to cost centers for departmental expense tracking, labor cost allocation, union reporting, and departmental budget management. Essential for tracking above-the-line v',
    `guild_affiliation_id` BIGINT COMMENT 'Foreign key linking to talent.guild_affiliation. Business justification: Crew assignments for guild members require the specific guild_affiliation record to calculate pension/health contributions, file guild reports, and verify membership status. The existing union_guild_a',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Crew members often work through loan-out companies or talent agencies (partners). Linking enables tracking all crew supplied by that partner, payment processing to the loan-out entity, union/guild com',
    `location_id` BIGINT COMMENT 'Foreign key linking to production.location. Business justification: crew_assignment has filming_location_country as a free-text field, indicating crew assignments are tied to specific filming locations. Adding location_id normalizes this to a proper FK, enabling locat',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Crew can be assigned to specific episodes within a series production. Optional FK (nullable) — crew may be assigned at project level or episode level. Enables episode-specific crew tracking for episod',
    `project_id` BIGINT COMMENT 'Reference to the production project to which this crew member is assigned. Links the assignment to the master production record.',
    `program_rundown_id` BIGINT COMMENT 'Foreign key linking to scheduling.program_rundown. Business justification: For live productions (news, sports, talk shows), crew members (directors, floor managers, camera operators) are assigned to specific program rundowns. Live broadcast operations teams manage crew-to-ru',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Showrunners, DPs, and production designers are hired for the run of a series. Series-level crew tracking is required for union reporting, residuals calculation, and talent deal management — a named bu',
    `talent_profile_id` BIGINT COMMENT 'Reference to the crew members master record in the talent domain. Identifies the individual below-the-line crew member being assigned.',
    `assignment_number` STRING COMMENT 'Externally-known business identifier for this crew assignment, used in deal memos, call sheets, and payroll processing. Format: CA-{YEAR}-{SEQUENCE}.. Valid values are `^CA-[0-9]{4}-[0-9]{6}$`',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the crew assignment. Drives payroll eligibility, call sheet inclusion, and production roster reporting. Values: pending (offer extended, not yet accepted), confirmed (deal memo signed), active (currently on set/in production), on_hold (temporarily suspended), completed (assignment concluded), cancelled (assignment terminated before start).. Valid values are `pending|confirmed|active|on_hold|completed|cancelled`',
    `background_check_status` STRING COMMENT 'Status of the crew members background check for this production assignment. Required for productions involving minors (COPPA compliance) or access to secure facilities. Values: not_required, pending, cleared, failed, expired.. Valid values are `not_required|pending|cleared|failed|expired`',
    `box_rental_rate` DECIMAL(18,2) COMMENT 'Daily or weekly rate paid to the crew member for the rental of their personal tool box or specialized equipment package (e.g., makeup artists kit, wardrobe supervisors supplies). Distinct from kit_rental_rate which covers technical equipment.',
    `contracted_rate` DECIMAL(18,2) COMMENT 'The agreed compensation rate for this crew assignment, expressed in the applicable deal_type unit (per day, per week, or flat total). Stored in the productions base currency. Used for budget tracking and payroll processing in SAP S/4HANA.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this crew assignment record was first created in the system. Used for audit trail, data lineage, and compliance reporting. Conforms to ISO 8601 format with timezone offset.',
    `credit_name` STRING COMMENT 'The name as it should appear in the productions end credits, which may differ from the crew members legal name (e.g., stage name, preferred professional name). Sourced from the deal memo credit clause.',
    `credit_position` STRING COMMENT 'Specifies where the crew members credit appears in the production: main_title (opening credits), end_title (closing credits), both, or none (no contractual credit obligation). Drives post-production credit sequence assembly.. Valid values are `main_title|end_title|both|none`',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the contracted_rate (e.g., USD, GBP, EUR). Required for international co-productions where crew may be contracted in local currencies.. Valid values are `^[A-Z]{3}$`',
    `dalet_workflow_reference` STRING COMMENT 'The workflow instance identifier in Dalet Galaxy that corresponds to this crew assignments production workflow. Enables traceability between the HR/payroll record and the media asset management workflow orchestration system.',
    `deal_type` STRING COMMENT 'The compensation structure type for this crew assignment. Daily = per-day rate; Weekly = per-week rate with guaranteed days; Flat = fixed total fee for the engagement; Run of Show = engaged for the full production duration; Episodic = per-episode rate for series production.. Valid values are `daily|weekly|flat|run_of_show|episodic`',
    `department` STRING COMMENT 'The production department to which the crew member belongs for this assignment (e.g., camera, grip, electric, art, wardrobe, hair/makeup, post-production, sound, VFX). Drives crew call sheet grouping and budget cost center allocation. [ENUM-REF-CANDIDATE: camera|grip|electric|art|wardrobe|hair_makeup|post_production|sound|vfx|production — 10 candidates stripped; promote to reference product]',
    `end_date` DATE COMMENT 'The contractually agreed last day of work for this crew assignment. Nullable for open-ended or rolling assignments. Used for wrap scheduling and final payroll processing.',
    `guaranteed_days` STRING COMMENT 'The minimum number of work days guaranteed to the crew member under this assignment deal, regardless of actual production schedule. Relevant for weekly and episodic deal types. Used for take-or-pay liability calculation.',
    `kit_rental_rate` DECIMAL(18,2) COMMENT 'Daily or weekly rate paid to the crew member for the rental of their personal professional equipment (kit) used on the production (e.g., camera operators lens kit, sound mixers equipment package). Common in below-the-line crew deals.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this crew assignment record was most recently modified. Used for change data capture (CDC), audit trail, and Silver layer incremental processing in the Databricks Lakehouse.',
    `meal_penalty_eligible` BOOLEAN COMMENT 'Indicates whether this crew member is entitled to meal penalty payments if the production fails to provide a meal break within the contractually required interval (typically 6 hours under IATSE/DGA agreements). Drives production scheduling compliance.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether this crew member is eligible for overtime pay under their union/guild agreement or applicable labor law. True = eligible for overtime; False = flat deal or exempt classification. Drives payroll calculation logic.',
    `overtime_rate_multiplier` DECIMAL(18,2) COMMENT 'The multiplier applied to the base contracted_rate for overtime hours (e.g., 1.5 for time-and-a-half, 2.0 for double-time). Applicable only when overtime_eligible is True. Sourced from the applicable union/guild agreement.',
    `per_diem_rate` DECIMAL(18,2) COMMENT 'Daily allowance paid to the crew member for meals and incidental expenses when working away from their home base location. Rate varies by filming location and union agreement. Used for production cost budgeting.',
    `production_company` STRING COMMENT 'The legal name of the production company or entity that is the employer of record for this crew assignment. Relevant for co-productions where multiple entities may employ different crew members. Used for payroll and tax reporting.',
    `residuals_eligible` BOOLEAN COMMENT 'Indicates whether this crew member is entitled to residual payments when the production is reused, syndicated, or distributed on additional platforms (e.g., streaming, international broadcast). Residuals are governed by DGA, IATSE, and SAG-AFTRA agreements.',
    `role_title` STRING COMMENT 'The specific production role or job title assigned to the crew member (e.g., Director, Director of Photography, Gaffer, Script Supervisor, Editor, Colorist, VFX Supervisor, Sound Mixer, Key Grip, Best Boy). [ENUM-REF-CANDIDATE: director|director_of_photography|gaffer|script_supervisor|editor|colorist|vfx_supervisor|sound_mixer|key_grip|best_boy|production_designer|costume_designer — promote to reference product]',
    `safety_training_certified` BOOLEAN COMMENT 'Indicates whether the crew member has completed the required on-set safety training certification for this production (e.g., OSHA safety, COVID-19 protocols, stunt safety). Required for insurance compliance and production liability management.',
    `sap_personnel_action_code` STRING COMMENT 'The personnel action number in SAP S/4HANA HR that corresponds to this crew assignment. Used for payroll processing, benefits enrollment, and HR compliance reporting. Enables reconciliation between the production data product and the ERP system of record.',
    `scheduled_days` STRING COMMENT 'The total number of work days currently scheduled for this crew member on the production, as reflected in the current production schedule. May differ from guaranteed_days if the schedule changes.',
    `start_date` DATE COMMENT 'The contractually agreed first day of work for this crew assignment. Used for payroll calculation, permit verification, and production schedule alignment.',
    `travel_allowance` DECIMAL(18,2) COMMENT 'Fixed or estimated travel reimbursement amount for this crew assignment, covering transportation costs to and from the filming location. Distinct from per_diem_rate which covers daily living expenses.',
    `turnaround_hours` DECIMAL(18,2) COMMENT 'The minimum number of hours required between the end of one work day and the start of the next for this crew member, as stipulated by their union/guild agreement (e.g., 10 hours for IATSE, 12 hours for DGA). Violation triggers turnaround penalty payments.',
    `work_permit_expiry_date` DATE COMMENT 'The expiration date of the crew members work permit or visa authorization. Used to trigger renewal alerts and ensure continuous legal work authorization throughout the assignment period.',
    `work_permit_number` STRING COMMENT 'The official government-issued work permit or visa authorization number for the crew member in the production jurisdiction. Nullable when work_permit_required is False. Required for compliance audits and production insurance.',
    `work_permit_required` BOOLEAN COMMENT 'Indicates whether a work permit or visa authorization is required for this crew member to legally work on this production in the filming jurisdiction. True = permit required; False = no permit required (domestic/citizen crew). Triggers compliance workflow in HR.',
    CONSTRAINT pk_crew_assignment PRIMARY KEY(`crew_assignment_id`)
) COMMENT 'Assignment of a crew member to a specific production project in a defined role and department. Captures crew role (director, DP, gaffer, script supervisor, editor, colorist, VFX supervisor, sound mixer), department (camera, grip, electric, art, wardrobe, hair/makeup, post-production), start date, end date, deal type (daily, weekly, flat), contracted rate, union or guild affiliation (DGA, IATSE, SAG-AFTRA), overtime eligibility, work permit status, and assignment status. References the talent domain for the crew members master record. Tracks the full below-the-line crew roster for a production.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`production`.`facility_booking` (
    `facility_booking_id` BIGINT COMMENT 'Unique surrogate identifier for each facility booking record in the production domain. Primary key for the facility_booking data product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Facility bookings must be assigned to cost centers for facility cost allocation and chargeback to production departments. Replaces denormalized cost_center_code. Required for studio utilization report',
    `location_id` BIGINT COMMENT 'Foreign key linking to production.location. Business justification: facility_booking has facility_location as a free-text field. Adding location_id normalizes this to a proper FK to the location master table, enabling location-level facility booking tracking (permit r',
    `partner_id` BIGINT COMMENT 'Identifier of the external facility vendor or studio lot operator when the booked facility is not company-owned. References the vendor master in SAP S/4HANA for procurement and payment processing.',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: facility_booking already has a cross-domain content_episode_id but lacks an in-domain production_episode_id. Facility bookings (editing suites, dubbing stages) are frequently tied to specific producti',
    `project_id` BIGINT COMMENT 'Identifier of the production project for which this facility is being booked. Links the booking to the overarching content production initiative.',
    `program_schedule_id` BIGINT COMMENT 'Foreign key linking to scheduling.program_schedule. Business justification: Studio and facility bookings are made to support specific program schedules (e.g., a studio booked for a live weekly shows broadcast schedule). Facility managers and production coordinators track boo',
    `shoot_schedule_id` BIGINT COMMENT 'Foreign key linking to production.shoot_schedule. Business justification: Facility bookings are made for specific shoot schedule entries. Operational link — booking times align with shoot schedule. Optional FK (nullable) — facilities may also be booked for post-production o',
    `actual_cost` DECIMAL(18,2) COMMENT 'The final invoiced or accrued cost of the facility booking after actual usage is confirmed. Includes any overtime charges or adjustments. Reconciled against estimated_cost for budget variance reporting in SAP S/4HANA CO.',
    `actual_end` TIMESTAMP COMMENT 'The actual date and time the facility usage concluded, as recorded by the facility operator or production coordinator. Used for overtime calculation, billing reconciliation, and schedule variance reporting.',
    `actual_start` TIMESTAMP COMMENT 'The actual date and time the facility usage commenced, as recorded by the facility operator or production coordinator. May differ from booking_start due to delays or early starts. Used for variance analysis and billing reconciliation.',
    `booking_end` TIMESTAMP COMMENT 'The scheduled date and time at which the facility booking period ends. Combined with booking_start to compute duration and detect scheduling conflicts across productions.',
    `booking_reference` STRING COMMENT 'Externally visible alphanumeric reference code assigned to this booking, used in communications with facility operators, vendors, and production coordinators. Corresponds to the booking order number in SAP S/4HANA MM module.. Valid values are `^BK-[A-Z0-9]{8,16}$`',
    `booking_start` TIMESTAMP COMMENT 'The scheduled date and time at which the facility booking period begins. Used for conflict detection, crew scheduling, and playout coordination. Stored in ISO 8601 format with timezone offset.',
    `booking_status` STRING COMMENT 'Current lifecycle state of the facility booking. tentative indicates a provisional hold pending confirmation; confirmed indicates a firm reservation; cancelled indicates the booking was withdrawn; completed indicates the facility usage has concluded; on_hold indicates a temporary pause pending decision.. Valid values are `tentative|confirmed|cancelled|completed|on_hold`',
    `cancellation_date` DATE COMMENT 'The date on which the facility booking was formally cancelled. Used to determine whether cancellation fees apply per the vendor contract terms and for financial accrual reversal in SAP S/4HANA.',
    `cancellation_fee` DECIMAL(18,2) COMMENT 'Monetary penalty charged by the facility vendor when a confirmed booking is cancelled within the contractual notice period. Recorded for financial reconciliation and budget variance reporting.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the booking was cancelled. Populated only when booking_status is cancelled. Used for production post-mortem analysis and vendor dispute resolution.',
    `capacity_persons` STRING COMMENT 'Maximum number of persons the facility can accommodate during the booking period. Used for crew planning, health and safety compliance, and resource allocation decisions.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this facility booking record was first created in the system. Serves as the audit trail creation marker and is used for SLA compliance tracking and data lineage.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the rate and total cost are denominated (e.g., USD, GBP, EUR). Required for multi-territory productions and financial reconciliation in SAP S/4HANA.. Valid values are `^[A-Z]{3}$`',
    `dalet_workflow_reference` STRING COMMENT 'Reference identifier of the associated workflow job in Dalet Galaxy Media Asset Management system. Enables traceability between the facility booking and the ingest, metadata, or archive workflow triggered by the production activity.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'The projected total cost of the facility booking at the time of reservation, calculated from rate_amount and the planned booking duration. Used for production budget planning and greenlight approvals.',
    `facility_type` STRING COMMENT 'Classification of the production facility being booked. Drives resource conflict detection logic and cost allocation rules. [ENUM-REF-CANDIDATE: soundstage|editing_suite|dubbing_stage|color_grading_suite|adr_studio|screening_room|post_production_bay — promote to reference product]',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether this booking grants exclusive use of the facility for the booked period, preventing any concurrent bookings by other productions. When False, the facility may be shared with other productions subject to capacity constraints.',
    `notes` STRING COMMENT 'Free-text field for production coordinators to capture special requirements, setup instructions, access arrangements, or other operational notes relevant to the facility booking.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of hours the facility was used beyond the originally booked end time. Drives overtime rate calculations and is a key input to actual_cost reconciliation and production schedule variance analysis.',
    `production_phase` STRING COMMENT 'The stage of the content production lifecycle during which this facility is being used. Enables cost allocation by production phase and supports milestone tracking. [ENUM-REF-CANDIDATE: pre_production|principal_photography|post_production|vfx|color_grading|audio_mix|delivery — promote to reference product]',
    `purchase_order_number` STRING COMMENT 'SAP S/4HANA MM purchase order number raised for this facility booking when the facility is provided by an external vendor. Required for accounts payable processing and three-way match (PO, goods receipt, invoice).',
    `rate_amount` DECIMAL(18,2) COMMENT 'The contracted rate charged for the facility per the applicable rate_type unit (e.g., cost per hour or cost per day). Sourced from the facility rate card or negotiated contract. Used for budget estimation and cost allocation.',
    `rate_type` STRING COMMENT 'The billing rate structure applied to this facility booking. Determines how the total cost is calculated — per hour, per day, half-day block, weekly block, or a negotiated flat fee.. Valid values are `hourly|daily|half_day|weekly|flat_fee`',
    `technical_specs` STRING COMMENT 'Free-text description of the technical capabilities and equipment configuration of the facility at the time of booking (e.g., Dolby Atmos 7.1.4 mixing console, Pro Tools HDX, 4K DI suite). Sourced from Dalet Galaxy facility metadata.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this facility booking record was most recently modified. Used for change detection in ETL pipelines, audit compliance, and conflict resolution in concurrent update scenarios.',
    `wbs_element` STRING COMMENT 'SAP S/4HANA Project System Work Breakdown Structure element code that identifies the specific production phase or deliverable to which this facility cost is charged. Enables granular project cost tracking.',
    CONSTRAINT pk_facility_booking PRIMARY KEY(`facility_booking_id`)
) COMMENT 'Reservation and usage record for a production facility — soundstage, editing suite, dubbing stage, color grading suite, ADR studio, screening room, or post-production bay. Captures facility name, facility type, location, booking start datetime, booking end datetime, booked production project, booked episode or segment, booking status (tentative, confirmed, cancelled), rate per hour or day, total cost, and technical specifications of the facility. Enables resource conflict detection and cost allocation.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` (
    `equipment_allocation_id` BIGINT COMMENT 'Unique surrogate identifier for each equipment allocation record. Primary key for the equipment_allocation data product in the production domain.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Equipment allocations must be tracked to cost centers for equipment cost tracking and departmental chargebacks. Replaces denormalized cost_centre_code (British spelling). Required for rental cost allo',
    `equipment_item_id` BIGINT COMMENT 'Reference to the master equipment item record (camera body, lens, lighting rig, sound package, jib, drone, editing workstation, encoding hardware) being allocated.',
    `location_id` BIGINT COMMENT 'Foreign key linking to production.location. Business justification: equipment_allocation has shoot_location as a free-text field. Adding location_id normalizes this to a proper FK relationship, enabling location-level equipment tracking (insurance requirements by loca',
    `partner_id` BIGINT COMMENT 'Reference to the external rental vendor supplying the equipment. Null when the equipment is an owned asset. Used for vendor cost reconciliation in SAP S/4HANA.',
    `project_id` BIGINT COMMENT 'Reference to the production project or title to which this equipment is allocated. Links the allocation to the broader production workflow managed in Dalet Galaxy.',
    `shoot_schedule_id` BIGINT COMMENT 'Foreign key linking to production.shoot_schedule. Business justification: Equipment allocations are operationally tied to specific shoot days — cameras, lenses, and lighting rigs are checked out for particular shoot schedule entries. Adding shoot_schedule_id enables day-lev',
    `allocation_end_date` DATE COMMENT 'The date on which the equipment allocation ends — i.e., the last day the equipment is assigned to the production. Used for rental cost calculation and return scheduling.',
    `allocation_number` STRING COMMENT 'Externally-known business identifier for the allocation record, used in production paperwork, crew call sheets, and facility booking confirmations. Format: EQALLOC-{YYYY}-{NNNNNN}.. Valid values are `^EQALLOC-[0-9]{4}-[0-9]{6}$`',
    `allocation_start_date` DATE COMMENT 'The date on which the equipment allocation begins — i.e., the first day the equipment is available to the production. Used for rental rate calculation and scheduling conflict detection.',
    `allocation_status` STRING COMMENT 'Current lifecycle state of the equipment allocation. Drives workflow routing in Dalet Galaxy and cost accrual in SAP S/4HANA. [ENUM-REF-CANDIDATE: requested|confirmed|checked_out|in_use|checked_in|cancelled|lost|damaged — promote to reference product]',
    `asset_tag_code` STRING COMMENT 'Internal asset tag or barcode label affixed to owned equipment for physical inventory tracking. Format: {CC}-{NNNNNN} where CC is category code. Null for rented equipment.. Valid values are `^[A-Z]{2}-[0-9]{6}$`',
    `checkout_condition` STRING COMMENT 'Assessed physical condition of the equipment at the time of checkout. Establishes the baseline condition for damage assessment upon return. Recorded by the equipment manager.. Valid values are `new|excellent|good|fair|poor`',
    `checkout_timestamp` TIMESTAMP COMMENT 'Exact date and time the equipment was physically checked out from the equipment room or rental house. Serves as the principal business event timestamp for the allocation lifecycle.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the equipment allocation record was first created in the system. Supports audit trail requirements and data lineage tracking in the Databricks Silver Layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the rental rate and insurance value amounts (e.g., USD, GBP, EUR). Supports multi-currency productions and financial consolidation in SAP S/4HANA FI.. Valid values are `^[A-Z]{3}$`',
    `dalet_workflow_reference` STRING COMMENT 'Identifier of the associated Dalet Galaxy workflow instance that orchestrates the equipment allocation within the broader production ingest and post-production pipeline. Enables end-to-end workflow traceability.',
    `damage_claim_amount` DECIMAL(18,2) COMMENT 'Monetary value of the damage or loss claim raised against this allocation, in the currency specified by currency_code. Null when no damage claim exists. Used for financial reconciliation and insurance recovery.',
    `damage_description` STRING COMMENT 'Free-text description of any damage, loss, or malfunction identified at return. Null when equipment is returned in acceptable condition. Used to support insurance claims and vendor dispute resolution.',
    `equipment_category` STRING COMMENT 'High-level classification of the equipment type being allocated. Drives cost centre coding, insurance grouping, and crew department assignment. [ENUM-REF-CANDIDATE: camera|lens|lighting|sound|grip|drone|editing_workstation|encoding_hardware|other — promote to reference product]',
    `equipment_name` STRING COMMENT 'Human-readable name or model designation of the equipment item (e.g., ARRI ALEXA Mini LF, Cooke S4/i 32mm, Litepanels Astra 6X). Supports crew call sheets and production reports.',
    `insurance_policy_number` STRING COMMENT 'Reference number of the insurance policy covering this equipment allocation. Used for claims processing and compliance with production insurance requirements.',
    `insurance_value` DECIMAL(18,2) COMMENT 'Declared replacement value of the equipment for insurance purposes, in the currency specified by currency_code. Used to calculate insurance premiums and process loss/damage claims.',
    `is_insurance_required` BOOLEAN COMMENT 'Indicates whether specific insurance coverage must be arranged for this equipment allocation (True) or whether it falls under the productions blanket policy (False). Relevant for high-value or specialist equipment.',
    `is_owned_asset` BOOLEAN COMMENT 'Indicates whether the equipment is owned by the production company (True) or rented from an external vendor (False). Drives depreciation accounting vs. rental cost booking in SAP S/4HANA FI.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes related to the equipment allocation, such as special handling instructions, configuration requirements, or crew briefing notes.',
    `production_department` STRING COMMENT 'The production department responsible for the equipment allocation (e.g., camera, lighting, grip, sound). Used for departmental budget tracking and cost centre allocation in SAP S/4HANA CO. [ENUM-REF-CANDIDATE: camera|lighting|grip|sound|art|vfx|post_production|production_office|other — promote to reference product]',
    `purchase_order_number` STRING COMMENT 'SAP S/4HANA purchase order number raised for the equipment rental from an external vendor. Null for owned assets. Used for three-way match (PO, goods receipt, invoice) in accounts payable.',
    `quantity` STRING COMMENT 'Number of identical equipment units covered by this allocation record (e.g., 3 identical LED panels allocated as a single record). Defaults to 1 for individually serialised items.',
    `rental_rate_amount` DECIMAL(18,2) COMMENT 'The agreed rental rate per day or per week (per rental_rate_type) for the equipment, in the productions base currency. Used for production budget tracking and vendor cost reconciliation in SAP S/4HANA.',
    `rental_rate_type` STRING COMMENT 'Indicates whether the rental rate is charged on a daily, weekly, or flat-fee basis. Determines how the total rental cost is computed for budget tracking and vendor invoice reconciliation.. Valid values are `daily|weekly|flat_fee`',
    `return_condition` STRING COMMENT 'Assessed physical condition of the equipment at the time of return. Compared against checkout_condition to identify damage or deterioration. Triggers damage claim workflow if degraded. [ENUM-REF-CANDIDATE: new|excellent|good|fair|poor|damaged|lost — 7 candidates stripped; promote to reference product]',
    `return_timestamp` TIMESTAMP COMMENT 'Exact date and time the equipment was physically returned to the equipment room or rental house. Null until the equipment is returned. Used to calculate actual rental duration and late return penalties.',
    `serial_number` STRING COMMENT 'Manufacturer serial number of the specific equipment unit allocated. Used for asset tracking, insurance claims, and loss/damage investigations. Classified confidential as it identifies a specific high-value asset.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the equipment allocation record was last modified. Used for change data capture (CDC) in the Databricks Silver Layer pipeline and audit compliance.',
    `wbs_element_code` STRING COMMENT 'SAP S/4HANA Work Breakdown Structure (WBS) element code identifying the specific production phase or deliverable to which this equipment cost is attributed (e.g., pre-production, principal photography, post-production).',
    CONSTRAINT pk_equipment_allocation PRIMARY KEY(`equipment_allocation_id`)
) COMMENT 'Allocation record tracking the assignment of production equipment (cameras, lenses, lighting rigs, sound packages, jibs, drones, editing workstations, encoding hardware) to a production project or shoot day. Captures equipment item, equipment category, serial number, rental vendor or owned asset flag, allocation start date, allocation end date, daily or weekly rental rate, insurance value, condition at checkout, condition at return, and responsible crew member. Supports equipment cost tracking and loss/damage management.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`production`.`production_episode` (
    `production_episode_id` BIGINT COMMENT 'Unique surrogate identifier for the production episode record in the lakehouse Silver layer. Serves as the primary key for all downstream joins and lineage tracking.',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Accessibility compliance planning: each production episode must be linked to the accessibility obligation (e.g., audio description, captioning mandate) that governs its production requirements. This d',
    `asset_collection_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_collection. Business justification: Each production episode maps to a MAM asset collection grouping all versions, proxies, and supplemental assets for that episode. MAM operators create episode-level collections for bulk QC, archival, a',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Episodes require content ratings before broadcast/distribution. Core regulatory workflow linking production output to compliance certification. Drives scheduling decisions and parental control metadat',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Individual episodes in TV series production have dedicated cost centers for episodic cost tracking and variance reporting. Production accountants report costs at episode level mapped to cost centers —',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: Episode-level DRM policy assignment is required for pre-delivery rights enforcement planning in media-broadcasting. DRM requirements are determined at the episode level before deliverables are created',
    `project_id` BIGINT COMMENT 'Reference to the parent production project (series, mini-series, anthology, or episodic documentary) to which this episode belongs. Establishes the episode-to-project hierarchy.',
    `script_id` BIGINT COMMENT 'Foreign key linking to production.script. Business justification: Episodes are based on specific scripts. Strong content relationship — script is the source document for episode production. FK links episode to the locked script version used for production.',
    `season_id` BIGINT COMMENT 'Reference to the season record that groups this episode within a multi-season series. Null for mini-series or anthology formats that do not have a season structure.',
    `sponsorship_id` BIGINT COMMENT 'Foreign key linking to sales.sponsorship. Business justification: Individual episodes are sponsored (e.g., Episode presented by Brand X). Production must track which sponsorship is attached to each episode for branded content compliance, sponsor approval workflows',
    `syndication_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.syndication_agreement. Business justification: Syndication production planning: syndication agreements specify episode count, format, runtime, and language requirements. Production teams track which syndication agreement governs each episodes pro',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Individual episodes may have separate syndication or international license agreements distinct from the series-level agreement. Real business need: episode-level rights tracking for syndication deals,',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Episode-level OTT platform targeting is a core media-broadcasting delivery planning process. Individual episodes within a project may target different OTT platforms (co-production splits). Existing pr',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Production episodes generate content title records. While production_episode links to season, direct title linkage is needed for episodic content workflows, metadata delivery, and distribution schedul',
    `actual_cost_usd` DECIMAL(18,2) COMMENT 'Total actual production cost incurred for this episode in US dollars, as recorded in SAP S/4HANA. Used for budget variance analysis, EBITDA reporting, and production cost per minute calculations.',
    `actual_delivery_date` DATE COMMENT 'Date on which the completed episode master was actually delivered to the distributor, broadcaster, or platform. Compared against scheduled_delivery_date for SLA compliance and penalty assessment.',
    `actual_running_time_sec` STRING COMMENT 'Final delivered running time of the episode in seconds as measured from the completed master file. May differ from target due to editorial decisions made during post-production. Used for playout scheduling reconciliation and delivery compliance verification.',
    `approved_budget_usd` DECIMAL(18,2) COMMENT 'Total approved production budget for this episode in US dollars, as sanctioned at greenlight. Used for budget vs. actual variance analysis in SAP S/4HANA CO and financial reporting under SOX compliance.',
    `audio_language_code` STRING COMMENT 'ISO 639-2 three-letter language code for the primary audio track of this episode. Used for distribution rights matching, subtitle/dubbing workflow triggering, and EPG metadata population.. Valid values are `^[a-z]{3}$`',
    `audio_mix_completion_date` DATE COMMENT 'Date on which the final audio mix (including dialogue, music, and effects) was completed and approved. Prerequisite for final mastering and delivery. Tracked as a post-production milestone in Dalet Galaxy.',
    `closed_captioning_compliant` BOOLEAN COMMENT 'Indicates whether this episode meets FCC closed captioning requirements (47 CFR Part 79) and Ofcom subtitling standards. Required for broadcast clearance and regulatory compliance reporting.',
    `color_grade_completion_date` DATE COMMENT 'Date on which color grading (digital color correction and finishing) was completed and approved. Required before final mastering and transcode for delivery. Tracked as a post-production milestone in Dalet Galaxy.',
    `content_rating` STRING COMMENT 'Audience content rating assigned to this episode per the TV Parental Guidelines system (US) or equivalent regulatory body. Required for EPG metadata, DAI ad targeting restrictions, and COPPA compliance for childrens content.. Valid values are `TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA`',
    `content_type` STRING COMMENT 'Broad classification of the episode content format. Determines applicable production workflows, rights frameworks, talent residual calculations, and compliance requirements (e.g., COPPA for childrens content). [ENUM-REF-CANDIDATE: scripted|unscripted|documentary|news|sports|animation|live_event — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production episode record was first created in the system. Used for audit trail, data lineage, and production workflow initiation tracking. Conforms to ISO 8601 extended format.',
    `delivery_date` DATE COMMENT 'Contractually committed or operationally planned date by which the completed episode master must be delivered to the distributor, broadcaster, or platform. Used for SLA tracking and rights window activation in Rightsline.',
    `director_name` STRING COMMENT 'Full name of the credited director for this episode. Used for DGA residuals calculation, talent contract compliance, and creative attribution in production records.',
    `eidr_code` STRING COMMENT 'EIDR content identifier for this episode, enabling interoperability across supply chain partners, distributors, and rights management systems. Registered with the Entertainment Identifier Registry.. Valid values are `^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-Z]$`',
    `episode_code` STRING COMMENT 'Internal production code assigned by the production team to uniquely identify this episode within the production management system (e.g., Dalet Galaxy asset code). Used for workflow routing, asset tagging, and facility booking references.. Valid values are `^[A-Z0-9]{2,20}$`',
    `episode_number` STRING COMMENT 'Sequential production episode number within the season or series. Used for scheduling, EPG metadata, and audience tracking. Corresponds to the broadcast order number.',
    `first_air_date` DATE COMMENT 'Date on which this episode first aired or was made available to audiences on any platform (linear broadcast, VOD, OTT). Marks the start of the content windowing lifecycle and triggers residuals calculation in Rightsline.',
    `greenlight_date` DATE COMMENT 'Date on which executive approval (greenlight) was granted to proceed with production of this episode. Marks the official start of the production lifecycle and triggers budget release in SAP S/4HANA.',
    `isan` STRING COMMENT 'Globally unique identifier for this episode as registered with the ISAN International Agency. Used for rights clearance, royalty tracking, and cross-platform content identification. Conforms to ISO 15706-2.. Valid values are `^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}$`',
    `master_format` STRING COMMENT 'Technical format specification of the delivered episode master file (e.g., UHD HDR, HD 1080p). Determines transcode profiles required for multi-platform distribution and CDN delivery via Akamai.. Valid values are `UHD_HDR|UHD_SDR|HD_1080p|HD_720p|SD`',
    `picture_lock_date` DATE COMMENT 'Date on which the final edited picture was locked, freezing all visual edits. Triggers downstream post-production workflows including VFX, color grading, and audio mixing. Critical milestone for delivery scheduling.',
    `production_company` STRING COMMENT 'Name of the production company or studio responsible for producing this episode. Used for co-production agreements, rights attribution, and financial reconciliation in SAP S/4HANA.',
    `production_status` STRING COMMENT 'Current lifecycle stage of the episode within the end-to-end production workflow. Drives workflow routing in Dalet Galaxy and milestone reporting to production management. [ENUM-REF-CANDIDATE: development|pre_production|principal_photography|post_production|picture_lock|delivered|archived — promote to reference product]',
    `script_lock_date` DATE COMMENT 'Date on which the final shooting script was locked, freezing all creative changes. Triggers pre-production scheduling, crew assignments, and facility bookings. Key milestone for production planning.',
    `shoot_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary country where principal photography was conducted. Used for production tax credit eligibility, co-production treaty compliance, and content origin classification.. Valid values are `^[A-Z]{3}$`',
    `shoot_end_date` DATE COMMENT 'Scheduled or actual end date of principal photography (picture wrap) for this episode. Used to confirm transition to post-production and trigger post-production workflow initiation in Dalet Galaxy.',
    `shoot_location` STRING COMMENT 'Primary geographic location where principal photography for this episode was conducted. Used for production tax credit eligibility, location permit compliance, and production logistics reporting.',
    `shoot_start_date` DATE COMMENT 'Scheduled or actual start date of principal photography for this episode. Used for crew scheduling, facility booking, and production budget burn-rate tracking in SAP S/4HANA.',
    `showrunner_name` STRING COMMENT 'Full name of the showrunner (executive producer with creative oversight) responsible for this episode. Key accountability reference for production governance and editorial decisions.',
    `subtitle_languages` STRING COMMENT 'Comma-separated list of ISO 639-2 three-letter language codes for subtitle tracks available in the delivered master. Used for accessibility compliance (FCC closed captioning rules), distribution rights, and EPG metadata.',
    `target_running_time_sec` STRING COMMENT 'Planned editorial running time of the episode in seconds, excluding commercial breaks. Used for scheduling slot allocation, playout automation configuration in Ericsson MediaFirst, and delivery specification compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this production episode record. Used for incremental data pipeline processing, change data capture, and audit compliance in the Databricks Silver layer.',
    `vfx_completion_date` DATE COMMENT 'Date on which all visual effects shots were completed and approved for integration into the picture lock. Tracked as a post-production milestone. Null if the episode contains no VFX work.',
    `writer_name` STRING COMMENT 'Full name of the credited writer(s) for this episode. Used for residuals calculation, WGA/guild compliance reporting, and rights attribution in Rightsline.',
    CONSTRAINT pk_production_episode PRIMARY KEY(`production_episode_id`)
) COMMENT 'Master record for an individual episode, segment, or installment within a production project (series, mini-series, anthology, or episodic documentary). Captures episode number, episode title, season number, running time target, production status, writer, director, script lock date, picture lock date, audio mix completion date, delivery date, and ISAN episode identifier. Acts as the granular production unit below the project level for episodic content.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`production`.`script` (
    `script_id` BIGINT COMMENT 'Unique identifier for the production script or screenplay record. Primary key.',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Every episode has a corresponding script — this is the most fundamental relationship in episodic TV production. Script-to-episode traceability is required for WGA residuals, production scheduling, and',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Pre-production content classification: scripts are submitted for content rating review before greenlight in many jurisdictions. Linking script to content_rating supports the pre-production compliance ',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Scripts (PDF, FDX files) are digital assets stored and versioned in the MAM. Linking script to media_asset enables MAM-based version control, rights management, and distribution restriction enforcemen',
    `project_id` BIGINT COMMENT 'Reference to the parent production project or episode to which this script belongs.',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Season script packages (all episode scripts for a season) are tracked for WGA compliance, production scheduling, and delivery milestones. Season-level script management is a standard production workfl',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Series bibles, pilot scripts, and episode scripts are grouped by series in development and production. WGA registration and series-level script tracking are named business processes. Script links to t',
    `sponsorship_id` BIGINT COMMENT 'Foreign key linking to sales.sponsorship. Business justification: Scripts for sponsored content and branded entertainment are written to fulfill specific sponsorship agreements, requiring sponsor approval before production. Linking script to sponsorship enables spon',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Scripts are written for specific content titles. Essential for pre-production planning, rights clearance (script-based content analysis), and tracking script versions against final distributed content',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.rights_holder. Business justification: Scripts are often based on underlying IP owned by rights holders (novels, plays, life rights, true stories, existing franchises). Real business need: tracking the rights holder of the underlying IP be',
    `approval_date` DATE COMMENT 'The date on which the script was officially approved for production.',
    `approved_by` STRING COMMENT 'The name or identifier of the individual or role who approved the script for production.',
    `confidentiality_level` STRING COMMENT 'The confidentiality classification of the script document (public, internal, confidential, restricted).. Valid values are `public|internal|confidential|restricted`',
    `copyright_holder` STRING COMMENT 'The legal entity or individual who holds the copyright to the script.',
    `copyright_year` STRING COMMENT 'The year in which the script copyright was established or registered.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this script record was first created in the system.',
    `dalet_document_reference` STRING COMMENT 'The unique document identifier or reference in the Dalet Galaxy Media Asset Management (MAM) system linking this script record to the digital script file.',
    `distribution_restriction` STRING COMMENT 'Any restrictions or limitations on the distribution or sharing of the script (e.g., internal use only, NDA required).',
    `draft_type` STRING COMMENT 'The classification of the script draft stage (outline, first draft, revised draft, shooting script, post-production script, final draft).. Valid values are `outline|first draft|revised draft|shooting script|post-production script|final draft`',
    `estimated_runtime_minutes` STRING COMMENT 'The estimated runtime of the production in minutes based on the script length and pacing.',
    `file_format` STRING COMMENT 'The digital file format of the script document (PDF, DOCX, FDX, FOUNTAIN, TXT).. Valid values are `PDF|DOCX|FDX|FOUNTAIN|TXT`',
    `file_size_mb` DECIMAL(18,2) COMMENT 'The size of the script file in megabytes.',
    `format` STRING COMMENT 'The production format for which the script is intended (feature film, television episode, miniseries, web series, documentary, commercial, short film). [ENUM-REF-CANDIDATE: feature film|television episode|miniseries|web series|documentary|commercial|short film — 7 candidates stripped; promote to reference product]',
    `genre` STRING COMMENT 'The genre or category of the script (e.g., drama, comedy, thriller, documentary).',
    `language` STRING COMMENT 'The primary language in which the script is written (e.g., English, Spanish, French).',
    `lock_date` DATE COMMENT 'The date on which the script was locked and finalized for production.',
    `lock_status` BOOLEAN COMMENT 'Indicates whether the script is locked for production (true) or still open for revisions (false).',
    `notes` STRING COMMENT 'General notes, comments, or annotations related to the script for production reference.',
    `page_count` STRING COMMENT 'The total number of pages in the script document.',
    `revision_date` DATE COMMENT 'The date of the most recent revision or update to the script.',
    `revision_notes` STRING COMMENT 'Notes or comments describing the changes made in the current revision of the script.',
    `rights_clearance_status` STRING COMMENT 'The status of rights clearance for the script (pending, cleared, restricted, expired).. Valid values are `pending|cleared|restricted|expired`',
    `scene_count` STRING COMMENT 'The total number of scenes defined in the script.',
    `script_number` STRING COMMENT 'The externally-known unique identifier or code assigned to this script for production tracking and reference purposes.',
    `script_status` STRING COMMENT 'Current lifecycle status of the script (draft, in review, approved, locked, archived, rejected).. Valid values are `draft|in review|approved|locked|archived|rejected`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this script record was last updated or modified.',
    `version_number` STRING COMMENT 'The version or revision number of the script (e.g., 1.0, 2.3, Final).',
    `wga_registration_number` STRING COMMENT 'The WGA registration number assigned to this script for copyright and intellectual property protection.',
    `writer_credits` STRING COMMENT 'The names and credits of the writer(s) who authored or contributed to the script.',
    CONSTRAINT pk_script PRIMARY KEY(`script_id`)
) COMMENT 'Master record for a production script or screenplay associated with a production project or episode. Captures script title, version number, draft type (outline, first draft, revised draft, shooting script, post-production script), writer credits, WGA registration number, page count, script lock status, lock date, language, and Dalet Galaxy document reference. Tracks the full script revision history and serves as the authoritative script record for production and rights purposes.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`production`.`post_production_task` (
    `post_production_task_id` BIGINT COMMENT 'Unique identifier for the post-production task within the Dalet Galaxy workflow orchestration pipeline.',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Accessibility task management: post-production tasks for audio description tracks, caption file creation, and SDH subtitle production are directly mandated by accessibility obligations. Linking tasks ',
    `clearance_request_id` BIGINT COMMENT 'Foreign key linking to rights.clearance_request. Business justification: Post-production tasks involving licensed archival footage, music cues, or third-party IP must reference the governing clearance request. Post-production supervisors track clearance status per task to ',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Post-production tasks (editing, color, audio mix) create specific content versions. Critical for tracking which production tasks generated which distributable versions, version lineage, and linking pr',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Post-production tasks (VFX, color grading, audio mix) are charged to specific cost centers for departmental cost tracking and vendor invoice allocation. Media finance teams report post-production cost',
    `deliverable_id` BIGINT COMMENT 'Foreign key linking to production.deliverable. Business justification: Post-production tasks produce deliverables. Optional FK (nullable) — not all tasks produce final deliverables (intermediate tasks). When populated, links task output to contractual/operational deliver',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Post-production tasks (encoding, packaging, captioning) are scoped to specific delivery channel requirements. Media-broadcasting post-production pipelines track which delivery channel a task is prepar',
    `delivery_obligation_id` BIGINT COMMENT 'Foreign key linking to partner.delivery_obligation. Business justification: Obligation-driven post-production workflow: post-production supervisors assign tasks (dubbing, subtitling, QC, localization) directly to fulfill specific contractual delivery obligations. Direct link ',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: DRM packaging is a specific post-production task type in media-broadcasting. The task must reference the applicable DRM policy to configure encryption, key rotation, and license parameters during cont',
    `format_spec_id` BIGINT COMMENT 'Foreign key linking to production.format_spec. Business justification: post_production_task has technical_specification as a free-text field. Adding format_spec_id normalizes this to a proper FK to the format_spec reference table, which contains authoritative technical f',
    `ingest_job_id` BIGINT COMMENT 'Foreign key linking to mediaasset.ingest_job. Business justification: Post-production ingest tasks (camera card ingest, rushes ingest, final delivery ingest) directly correspond to MAM ingest jobs. Linking enables end-to-end production pipeline traceability from task as',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Post-production tasks (editing, color grading, audio mix) produce intermediate and final assets stored in MAM. Role-prefixed as output_asset_id to distinguish from source media. Critical for workflow ',
    `parent_task_post_production_task_id` BIGINT COMMENT 'Reference to the parent post-production task if this task is a sub-task or dependent task in a hierarchical workflow.',
    `partner_id` BIGINT COMMENT 'Reference to the external vendor or post-production facility assigned to perform this task, if outsourced.',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: post_production_task has a cross-domain content_episode_id but no in-domain production_episode_id. Post-production tasks (VFX, color grading, audio mixing) are performed on specific production episode',
    `project_id` BIGINT COMMENT 'Reference to the parent production project that this post-production task belongs to.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Compliance-driven post-production workflow: tasks such as loudness normalization (ATSC A/85), closed captioning embedding, and audio description are mandated by specific regulatory obligations. Post-p',
    `script_id` BIGINT COMMENT 'Foreign key linking to production.script. Business justification: Post-production tasks reference scripts for scene/dialogue context. Optional FK (nullable) — provides editorial context for tasks. Enables linking task to script version for continuity.',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: Post-production task deadlines are driven by the air date of the target schedule slot. Post coordinators and traffic teams use this link to prioritize QC, mastering, and delivery tasks against specifi',
    `transcode_job_id` BIGINT COMMENT 'Foreign key linking to mediaasset.transcode_job. Business justification: Post-production tasks (conform, encode, package) directly trigger MAM transcode jobs. Linking enables production pipeline monitoring against MAM processing jobs — essential for SLA reporting, cost att',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Actual date and time when the post-production task was completed and submitted for review or approval.',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Actual cost incurred for completing this post-production task, used for budget variance analysis.',
    `actual_duration_hours` DECIMAL(18,2) COMMENT 'Actual number of hours spent completing the post-production task, used for cost tracking and performance analysis.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when work on the post-production task commenced.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the task output was formally approved and authorized to proceed to the next workflow stage.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this post-production task record was first created in the workflow system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts associated with this task.. Valid values are `^[A-Z]{3}$`',
    `dalet_workflow_task_reference` STRING COMMENT 'External system identifier from Dalet Galaxy workflow orchestration system for this specific task instance.',
    `dependency_type` STRING COMMENT 'Type of scheduling dependency relationship this task has with its predecessor tasks in the workflow.. Valid values are `finish_to_start|start_to_start|finish_to_finish|start_to_finish|none`',
    `estimated_cost_amount` DECIMAL(18,2) COMMENT 'Budgeted cost for completing this post-production task, including labor, equipment, and vendor fees.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Planned number of hours required to complete the post-production task, used for resource planning and scheduling.',
    `output_media_path` STRING COMMENT 'File system path or MAM location where the completed output files or deliverables from this task are stored.',
    `priority` STRING COMMENT 'Business priority level assigned to the task, determining scheduling and resource allocation urgency.. Valid values are `critical|high|normal|low`',
    `qc_pass_flag` BOOLEAN COMMENT 'Indicator of whether the task output passed quality control review on first submission without requiring revisions.',
    `rejection_reason` STRING COMMENT 'Explanation of why the task output was rejected during review, requiring rework or revision.',
    `review_notes` STRING COMMENT 'Feedback, comments, or change requests provided by reviewers or approvers during the quality control or approval process.',
    `revision_number` STRING COMMENT 'Version number indicating how many times this task has been revised or reworked due to feedback or quality issues.',
    `scheduled_due_date` DATE COMMENT 'Target completion date for the post-production task as defined in the production schedule.',
    `scheduled_start_date` DATE COMMENT 'Planned date when the post-production task is scheduled to begin.',
    `sequence_number` STRING COMMENT 'Ordering position of this task within the overall post-production workflow or within a parent task group.',
    `source_media_path` STRING COMMENT 'File system path or Media Asset Management (MAM) location of the source media files or assets for this task.',
    `task_notes` STRING COMMENT 'General operational notes, instructions, or context information related to the execution of this post-production task.',
    `task_number` STRING COMMENT 'Human-readable business identifier for the post-production task, often used for tracking and communication purposes.',
    `task_status` STRING COMMENT 'Current lifecycle status of the post-production task within the workflow pipeline. [ENUM-REF-CANDIDATE: queued|in_progress|review|approved|rejected|complete|on_hold|cancelled — 8 candidates stripped; promote to reference product]',
    `task_type` STRING COMMENT 'Classification of the post-production work task indicating the specific type of creative or technical operation being performed. [ENUM-REF-CANDIDATE: offline_edit|online_conform|vfx_composite|color_grade|audio_mix|adr_record|subtitle_burn_in|qc_review|transcode|archive_ingest|foley_record|sound_design|title_graphics|versioning — 14 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this post-production task record was last modified or updated.',
    `workstation_code` STRING COMMENT 'Identifier of the specific editing suite, color grading bay, or audio mixing console assigned for this task.',
    CONSTRAINT pk_post_production_task PRIMARY KEY(`post_production_task_id`)
) COMMENT 'Individual post-production work task within the Dalet Galaxy workflow orchestration pipeline. Captures task type (offline edit, online conform, VFX composite, color grade, audio mix, ADR record, subtitle burn-in, QC review, transcode, archive ingest), assigned operator or vendor, task status (queued, in-progress, review, approved, rejected, complete), priority, due date, actual completion date, parent episode or deliverable, and Dalet Galaxy workflow task ID. Enables end-to-end post-production workflow tracking.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`production`.`deliverable` (
    `deliverable_id` BIGINT COMMENT 'Unique identifier for the production deliverable. Primary key.',
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: Each deliverable conforms to specific ABR encoding profile for adaptive streaming distribution. Real business process: transcoding workflow configuration, encoding quality control, and streaming optim',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Deliverables must comply with specific accessibility obligations (closed captioning, audio description, emergency information access) based on distribution channel and regulatory jurisdiction.',
    `ad_order_id` BIGINT COMMENT 'Foreign key linking to sales.ad_order. Business justification: Ad spots and custom creative deliverables are produced to fulfill contracted ad orders. Traffic and production coordinators reconcile deliverable completion against ad order commitments for billing an',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: A production deliverable (broadcast master, streaming proxy, localized version) maps directly to a specific MAM asset_version. QC sign-off, distribution, and compliance workflows require tracing the c',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Deliverables are produced to fulfill campaign content commitments (branded content, custom creative). Campaign delivery tracking and fulfillment reporting require knowing which campaign each deliverab',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Deliverables must reference their content rating for distribution compliance verification. Required for platform submission, broadcast clearance, and international distribution workflows.',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: A production deliverable produces a specific content version — this is the core production-to-catalog handoff. Version lifecycle tracking from production output to content catalog requires this link. ',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Deliverables are prepared for and routed to specific delivery channels (FAST, OTT, linear). The delivery workflow in media-broadcasting requires knowing the target delivery channel to apply correct te',
    `delivery_obligation_id` BIGINT COMMENT 'Foreign key linking to partner.delivery_obligation. Business justification: Delivery fulfillment tracking: operations teams match each production deliverable to the contractual delivery obligation it satisfies, enabling SLA compliance reporting, penalty avoidance, and confirm',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: Distribution fulfillment tracking: distribution operations teams track which deliverables fulfill which distribution agreement obligations, enabling SLA compliance reporting, milestone-based payment t',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: Deliverables require specific DRM protection policies based on content rights and platform requirements. Real business process: content protection enforcement, rights management, and secure delivery c',
    `format_spec_id` BIGINT COMMENT 'Foreign key linking to production.format_spec. Business justification: Normalization opportunity. Deliverable currently has target_format (STRING). FK to format_spec allows retrieving full technical specification (resolution, frame_rate, codec, etc.) and ensures delivera',
    `ingest_job_id` BIGINT COMMENT 'Foreign key linking to mediaasset.ingest_job. Business justification: When a finished deliverable is received into the MAM (e.g., from a post house), an ingest job is created. Linking deliverable to ingest_job enables delivery receipt confirmation and chain-of-custody t',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Deliverables are created to fulfill specific license agreement technical and format requirements (e.g., HD master for territory X, dubbed version for territory Y). Real business need: linking delivera',
    `media_asset_id` BIGINT COMMENT 'Reference to the digital media asset in the Media Asset Management (MAM) system that represents this deliverable. Links to Dalet Galaxy or other MAM upon delivery.',
    `partner_content_window_id` BIGINT COMMENT 'Foreign key linking to partner.partner_content_window. Business justification: Content windowing fulfillment: distribution operations teams produce deliverables to meet the technical and rights requirements of specific partner content windows (SVOD, TVOD, linear). Direct link en',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Deliverables can be episode-specific (e.g., episodic masters for series). Optional FK (nullable) — deliverables may be project-level or episode-level. Enables episode-specific deliverable tracking.',
    `project_id` BIGINT COMMENT 'Reference to the parent production project that this deliverable belongs to.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Deliverables are sent to distribution partners, broadcasters, streaming platforms, and licensees. Linking enables delivery obligation tracking, SLA compliance monitoring, acceptance workflow managemen',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Deliverables must meet specific regulatory obligations before distribution. Links delivery workflow to compliance verification for broadcast standards, platform requirements, and international regulat',
    `release_window_id` BIGINT COMMENT 'Foreign key linking to distribution.release_window. Business justification: A deliverable is produced to fulfill a specific release window obligation (territory, window type, exclusivity). This is a fundamental media-broadcasting contractual process — deliverables are tracked',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: Specific deliverable versions (HD, 4K, censored cuts) are scheduled for playout. Playout automation references exact deliverable file. Required for traffic/continuity operations, version control, and ',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Season delivery packages are a primary contractual unit in distribution and licensing deals. Broadcasters and streaming platforms contract for season-level deliverables. No existing FK covers delivera',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Series delivery packages (series localization deliverables, series promotional packages) are contracted at the series level in distribution deals. Deliverable links to title and production_episode but',
    `sponsorship_id` BIGINT COMMENT 'Foreign key linking to sales.sponsorship. Business justification: Branded content and sponsored segment deliverables fulfill specific sponsorship contracts. Sponsorship fulfillment reporting tracks which deliverables satisfy each sponsorship deal — essential for spo',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: Deliverables are delivered to specific streaming endpoints for CDN ingestion and distribution. Real business process: content delivery tracking, CDN ingestion workflow, and delivery confirmation.',
    `syndication_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.syndication_agreement. Business justification: Syndication fulfillment: post-production teams produce deliverables to specific syndication agreement specs (format, language, territory, run limits). Direct link enables syndication operations teams ',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Deliverables are formatted for specific platforms with platform-specific technical requirements (resolution, codec, DRM). Real business process: platform-specific asset preparation, transcoding, and d',
    `territory_grant_id` BIGINT COMMENT 'Foreign key linking to partner.territory_grant. Business justification: Territory-compliant delivery: rights and distribution teams ensure each deliverable (e.g., dubbed version, localized cut) is produced and delivered within the scope of a specific territory grant. Enab',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Deliverables are final production outputs that become content titles in the distribution system. Critical for asset-to-content mapping, delivery acceptance workflows, and tracking which production del',
    `upfront_deal_id` BIGINT COMMENT 'Foreign key linking to sales.upfront_deal. Business justification: Deliverables produced to fulfill upfront programming commitments must be tracked against the originating upfront deal for advertiser fulfillment reporting and billing reconciliation. Upfront deal mana',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Actual date and time when the deliverable was successfully delivered or handed off.',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the video deliverable (e.g., 16:9, 4:3, 2.39:1, 1:1). Null for non-video deliverables.',
    `audio_channels` STRING COMMENT 'Audio channel configuration for the deliverable (e.g., Stereo, 5.1 Surround, 7.1 Surround, Mono, Dolby Atmos). Null for non-audio deliverables.',
    `audio_description_flag` BOOLEAN COMMENT 'Indicates whether an audio description track for visually impaired viewers is included. True = audio description present; False = no audio description.',
    `checksum_md5` STRING COMMENT 'MD5 hash of the deliverable file for integrity verification during transfer and storage.. Valid values are `^[a-f0-9]{32}$`',
    `closed_caption_flag` BOOLEAN COMMENT 'Indicates whether closed captions for accessibility are included in this deliverable. True = closed captions present; False = no closed captions.',
    `compliance_certificate_flag` BOOLEAN COMMENT 'Indicates whether a regulatory compliance certificate (e.g., FCC, Ofcom, content rating) accompanies this deliverable. True = certificate included; False = no certificate.',
    `contract_reference` STRING COMMENT 'Reference number or identifier of the contract or agreement that mandates this deliverable.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred to produce this deliverable, including labor, equipment, facilities, and post-production services.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this deliverable record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deliverable_name` STRING COMMENT 'Human-readable name or title of the deliverable (e.g., Broadcast Master HD, Promo Cut 30s, Closed Caption SRT File).',
    `deliverable_type` STRING COMMENT 'Category of deliverable output. Broadcast master = final linear transmission file; streaming master = OTT/VOD optimized file; promo cut = promotional excerpt; trailer = marketing preview; EPK = Electronic Press Kit; closed caption file = accessibility text; audio description track = visually impaired narration; subtitle file = translation text; M&E track = Music and Effects (no dialogue); textless version = graphics-free master; compliance certificate = regulatory approval document; QC report = Quality Control validation; as-run log = actual playout record. [ENUM-REF-CANDIDATE: broadcast_master|streaming_master|promo_cut|trailer|epk|closed_caption_file|audio_description_track|subtitle_file|me_track|textless_version|compliance_certificate|qc_report|as_run_log|other — 14 candidates stripped; promote to reference product]',
    `delivery_location` STRING COMMENT 'Physical address, URL, FTP path, or cloud storage location where the deliverable was sent or made available.',
    `delivery_method` STRING COMMENT 'Method or protocol used to deliver the deliverable to the recipient. Physical media = hard drive/tape shipment; FTP = File Transfer Protocol; Aspera = high-speed file transfer; Signiant = media transfer platform; AWS S3 = Amazon cloud storage; Akamai NetStorage = CDN storage; Google Drive/Dropbox = cloud file sharing. [ENUM-REF-CANDIDATE: physical_media|ftp|aspera|signiant|aws_s3|akamai_netstorage|google_drive|dropbox|other — 9 candidates stripped; promote to reference product]',
    `delivery_status` STRING COMMENT 'Current lifecycle state of the deliverable. Not started = work has not begun; in progress = actively being produced; QC pending = awaiting quality control review; QC failed = did not pass quality checks; QC passed = approved for delivery; ready for delivery = prepared and awaiting handoff; delivered = sent to recipient; accepted = recipient confirmed receipt and approval; rejected = recipient declined or returned; cancelled = deliverable no longer required. [ENUM-REF-CANDIDATE: not_started|in_progress|qc_pending|qc_failed|qc_passed|ready_for_delivery|delivered|accepted|rejected|cancelled — 10 candidates stripped; promote to reference product]',
    `due_date` DATE COMMENT 'Contractually or operationally required date by which this deliverable must be completed and handed off.',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Total runtime duration of the deliverable in seconds (for video/audio deliverables). Null for non-time-based deliverables like documents or images.',
    `eidr_code` STRING COMMENT 'Unique universal identifier for the audiovisual content assigned by the Entertainment Identifier Registry. Used for global content identification and rights management.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `file_size_bytes` BIGINT COMMENT 'Total file size of the deliverable in bytes. Used for storage planning, transfer time estimation, and CDN capacity management.',
    `language_code` STRING COMMENT 'Primary language of the deliverable content using ISO 639-1 or ISO 639-2 two or three-letter code, optionally followed by ISO 3166-1 alpha-2 country code (e.g., en, en-US, es-MX, fr-CA).. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `qc_notes` STRING COMMENT 'Detailed notes from the quality control review, including any issues found, corrective actions taken, or validation comments.',
    `qc_operator_name` STRING COMMENT 'Name of the quality control technician or automated system that performed the QC validation.',
    `qc_pass_flag` BOOLEAN COMMENT 'Indicates whether the deliverable passed quality control validation. True = passed QC; False = failed QC or not yet tested.',
    `qc_performed_timestamp` TIMESTAMP COMMENT 'Date and time when quality control validation was completed for this deliverable.',
    `revision_notes` STRING COMMENT 'Description of changes made in this revision of the deliverable (e.g., Corrected audio sync issue, Updated end credits, Re-encoded for HDR).',
    `revision_number` STRING COMMENT 'Version or revision number of this deliverable. Increments when the deliverable is updated or redelivered after corrections.',
    `scheduled_delivery_timestamp` TIMESTAMP COMMENT 'Planned date and time for delivery of this deliverable to the recipient or platform.',
    `subtitle_languages` STRING COMMENT 'Comma-separated list of language codes for subtitle tracks included in this deliverable (e.g., en,es,fr). Null if no subtitles are included.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this deliverable record was last modified.',
    CONSTRAINT pk_deliverable PRIMARY KEY(`deliverable_id`)
) COMMENT 'Contractually or operationally required output deliverable from a production project — the specific media asset or document that must be produced and handed off. Captures deliverable name, deliverable type (broadcast master, streaming master, promo cut, trailer, EPK, closed caption file, audio description track, subtitles, M&E track, textless version, compliance certificate), target format, target platform or recipient, due date, actual delivery date, delivery status, and QC pass/fail flag. Links to the digital asset management domain upon delivery.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`production`.`qc_review` (
    `qc_review_id` BIGINT COMMENT 'Unique identifier for the quality control review record. Primary key.',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: QC reviews verify compliance against specific accessibility obligations. Links quality control processes to regulatory requirements for CVAA, FCC accessibility rules, and international standards.',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: QC reviews are always performed on a specific asset version, not just the parent asset. Direct version-level traceability is required for re-QC workflows, version comparison reporting, and broadcaster',
    `closed_caption_record_id` BIGINT COMMENT 'Foreign key linking to compliance.closed_caption_record. Business justification: QC reviews verify closed captioning accuracy, synchronization, and completeness against FCC standards. Direct operational link between quality control and accessibility compliance verification.',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Content rating verification QC: QC reviews include verifying that content matches its assigned rating classification (TV-MA, TV-PG, etc.) and that rating advisories are correctly embedded. A direct FK',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: QC reviews validate specific content versions for distribution. Essential for version-level quality tracking, linking production QC to content version records, and ensuring only QC-passed versions are',
    `deliverable_id` BIGINT COMMENT 'Reference to the production deliverable or post-production output being reviewed.',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: QC reviews validate content against specific delivery channel technical and compliance requirements (e.g., FAST channel loudness standards vs. OTT HDR specs). Media-broadcasting QC workflows are chann',
    `delivery_obligation_id` BIGINT COMMENT 'Foreign key linking to partner.delivery_obligation. Business justification: QC compliance validation: QC operators review content against the technical standards (codec, resolution, loudness, closed caption) specified in a delivery obligation before partner delivery. Direct l',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Production QC reviews inspect specific media assets for technical compliance before delivery. Role-prefixed as reviewed_asset_id since qc_review already links to deliverable. Essential for broadcast c',
    `post_production_task_id` BIGINT COMMENT 'Foreign key linking to production.post_production_task. Business justification: QC reviews are performed on post-production task outputs. Optional FK (nullable) — QC may be on final deliverables or intermediate task outputs. When populated, links QC review to the specific Dalet w',
    `project_id` BIGINT COMMENT 'Reference to the parent production project this QC review belongs to.',
    `qc_inspection_id` BIGINT COMMENT 'Foreign key linking to mediaasset.qc_inspection. Business justification: Production QC reviews (editorial/compliance) and MAM qc_inspections (technical/format) are complementary processes on the same asset. Broadcasters and OTT platforms require a unified QC audit trail li',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Regulatory QC audit trail: QC reviews verify compliance with specific regulatory standards (FCC loudness rules, caption accuracy requirements). Linking qc_review to the governing regulatory_obligation',
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: QC reviews validate deliverables against target ABR profile specifications for distribution readiness. Real business process: quality assurance for streaming assets, technical compliance validation, a',
    `audio_channel_configuration` STRING COMMENT 'Audio channel layout (e.g., stereo, 5.1 surround, 7.1 surround, mono).',
    `audio_codec` STRING COMMENT 'Audio codec used in the deliverable (e.g., AAC, Dolby Digital, PCM).',
    `audio_description_compliance_flag` BOOLEAN COMMENT 'Indicates whether audio description track meets accessibility standards. True if compliant, False if missing or non-compliant.',
    `closed_caption_compliance_flag` BOOLEAN COMMENT 'Indicates whether closed captions meet accessibility and regulatory standards (FCC, CVAA). True if compliant, False if violations detected.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the QC review record was first created in the system.',
    `dalet_workflow_reference` STRING COMMENT 'Identifier linking this QC review to the corresponding workflow instance in Dalet Galaxy MAM for ingest and workflow orchestration.',
    `error_codes` STRING COMMENT 'Comma-separated list of specific error codes identified during the review, aligned with EBU R128, ATSC A/85, and ITU-R BT.1788 standards (e.g., V001 for video freeze, A002 for loudness violation, C003 for closed caption sync error).',
    `final_approval_date` DATE COMMENT 'Date when the deliverable received final approval for distribution. Null if not yet approved.',
    `final_approval_status` STRING COMMENT 'Final approval status of the deliverable after QC review and any remediation: approved (ready for distribution), rejected (does not meet standards), pending approval (awaiting sign-off), or conditional approval (approved with minor caveats).. Valid values are `approved|rejected|pending_approval|conditional_approval`',
    `loudness_compliance_flag` BOOLEAN COMMENT 'Indicates whether the deliverable meets loudness standards (EBU R128 or ATSC A/85). True if compliant, False if violations detected.',
    `loudness_lufs` DECIMAL(18,2) COMMENT 'Measured integrated loudness level in LUFS (Loudness Units relative to Full Scale) per EBU R128 or ATSC A/85 standards. Target is typically -23 LUFS for broadcast.',
    `p1_critical_error_count` STRING COMMENT 'Number of P1 critical errors that prevent broadcast or distribution (e.g., audio dropout, video corruption, missing segments).',
    `p2_major_error_count` STRING COMMENT 'Number of P2 major errors that significantly impact quality but may not prevent distribution (e.g., color grading inconsistencies, audio sync issues).',
    `p3_minor_error_count` STRING COMMENT 'Number of P3 minor errors that have minimal impact on viewer experience (e.g., minor subtitle timing issues, cosmetic artifacts).',
    `qc_notes` STRING COMMENT 'Free-text notes and observations recorded by the QC operator during the review, including context for errors and recommendations.',
    `qc_platform` STRING COMMENT 'Name of the QC platform or tool used to perform the review (e.g., Dalet Galaxy QC module, Tektronix Sentry, Interra Baton).',
    `qc_result` STRING COMMENT 'Overall result of the QC review: pass (no issues), fail (critical issues preventing distribution), conditional pass (minor issues requiring remediation), or pending review (awaiting final approval).. Valid values are `pass|fail|conditional_pass|pending_review`',
    `qc_type` STRING COMMENT 'Type of quality control review performed: technical QC (video/audio quality), editorial QC (content accuracy), compliance QC (regulatory standards), accessibility QC (closed captions, audio description), loudness QC (EBU R128/ATSC A/85), or format QC (file format and codec validation).. Valid values are `technical_qc|editorial_qc|compliance_qc|accessibility_qc|loudness_qc|format_qc`',
    `re_qc_date` DATE COMMENT 'Date when the deliverable was re-reviewed after remediation. Null if no re-QC has been performed.',
    `remediation_notes` STRING COMMENT 'Detailed notes describing the remediation actions required to address identified errors and bring the deliverable into compliance.',
    `remediation_required_flag` BOOLEAN COMMENT 'Indicates whether the deliverable requires remediation or correction before final approval. True if remediation needed, False if no action required.',
    `review_date` DATE COMMENT 'Date when the QC review was performed.',
    `review_duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the QC review session in minutes.',
    `review_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the QC operator completed the review session.',
    `review_number` STRING COMMENT 'Business identifier for the QC review, typically formatted as a human-readable reference code.',
    `review_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the QC operator began the review session.',
    `review_status` STRING COMMENT 'Current lifecycle status of the QC review process.. Valid values are `scheduled|in_progress|completed|on_hold|cancelled`',
    `total_error_count` STRING COMMENT 'Total number of errors identified across all severity levels during the QC review.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the QC review record was last modified.',
    `video_codec` STRING COMMENT 'Video codec used in the deliverable (e.g., H.264, H.265/HEVC, ProRes, MPEG-2).',
    `video_frame_rate` DECIMAL(18,2) COMMENT 'Measured video frame rate (e.g., 23.976, 25, 29.97, 50, 59.94 fps).',
    `video_resolution` STRING COMMENT 'Measured video resolution of the deliverable (e.g., 1920x1080, 3840x2160).',
    CONSTRAINT pk_qc_review PRIMARY KEY(`qc_review_id`)
) COMMENT 'Quality control review record for a production deliverable or post-production output. Captures QC type (technical QC, editorial QC, compliance QC, accessibility QC, loudness QC), QC operator, review date, pass/fail/conditional result, error count by severity (P1 critical, P2 major, P3 minor), specific error codes per EBU R128/ATSC A/85 loudness standards and ITU-R BT.1788 video quality standards, remediation required flag, re-QC date, and final approval status. Ensures all deliverables meet broadcast and platform technical specifications before distribution. Feeds the deliverable acceptance workflow.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`production`.`milestone` (
    `milestone_id` BIGINT COMMENT 'Primary key for milestone',
    `coproduction_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.coproduction_agreement. Business justification: Co-production contractual milestone compliance: legal and production teams track whether production milestones (delivery dates, creative approvals, picture lock) meet obligations defined in the co-pro',
    `deliverable_id` BIGINT COMMENT 'Foreign key linking to production.deliverable. Business justification: milestone has deliverable_description and deliverable_format as free-text fields, indicating milestones are often tied to specific deliverables (e.g., Picture Lock deliverable due by date X). Adding',
    `delivery_obligation_id` BIGINT COMMENT 'Foreign key linking to partner.delivery_obligation. Business justification: Delivery obligation milestone alignment: production and distribution operations teams map production milestones (picture lock, final delivery, QC pass) to contractual delivery obligations. Enables aut',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: Milestone-based payment triggering: distribution agreements include milestone-based payment schedules (payment on greenlight, delivery, air date). Direct link enables finance and legal teams to automa',
    `predecessor_milestone_id` BIGINT COMMENT 'Reference to another milestone that must be completed before this milestone can begin or be achieved.',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Milestones can be episode-specific (e.g., picture lock for episode 3). Optional FK (nullable) — milestones may be project-level or episode-level. Enables episode-specific milestone tracking for episod',
    `project_id` BIGINT COMMENT 'Reference to the parent production project or episode for which this milestone is tracked.',
    `program_schedule_id` BIGINT COMMENT 'Foreign key linking to scheduling.program_schedule. Business justification: Production milestones (picture lock, delivery, greenlight) are contractually tied to specific program schedule broadcast dates. Broadcast operations and production management reports track milestone c',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Regulatory deadline-driven milestone planning: production milestones (caption delivery, accessibility compliance sign-off, content rating submission) are directly driven by regulatory obligation deadl',
    `release_window_id` BIGINT COMMENT 'Foreign key linking to distribution.release_window. Business justification: Production milestones (picture lock, final delivery) are contractually tied to release window open dates. Missing a release window deadline triggers financial penalties and distribution failures. Medi',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Season-level milestones (season greenlight, season picture lock, season delivery, season premiere) are core production tracking events reported to studio finance and distribution partners. No existing',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Series-level milestones (series greenlight, series order, series wrap, series delivery) are tracked by studio executives and production management. Milestone links to title and production_episode but ',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Production milestones track progress toward content title delivery. Essential for content delivery scheduling, windowing plan coordination, and tracking production progress against content distributio',
    `actual_date` DATE COMMENT 'The date on which the milestone was actually achieved or completed. Null if milestone has not yet been reached.',
    `approval_authority` STRING COMMENT 'Name or role of the individual or committee authorized to approve this milestone (e.g., Executive Producer, Network Executive, Showrunner).',
    `approval_date` DATE COMMENT 'Date on which formal approval or sign-off was granted for this milestone. Null if approval is not yet obtained.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether formal approval or sign-off is required before this milestone can be marked as achieved.',
    `baseline_date` DATE COMMENT 'Approved baseline date for the milestone after initial project approval, used for variance tracking and performance measurement.',
    `budget_impact_usd` DECIMAL(18,2) COMMENT 'Estimated financial impact or cost associated with achieving this milestone, or cost of delay if milestone is missed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was first created in the system.',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether this milestone is on the critical path of the production schedule, meaning any delay directly impacts final delivery date.',
    `dalet_workflow_reference` STRING COMMENT 'External identifier linking this milestone to the corresponding workflow or task in Dalet Galaxy Media Asset Management system.',
    `dependency_count` STRING COMMENT 'Number of other milestones or tasks that are dependent on the completion of this milestone.',
    `forecast_date` DATE COMMENT 'Current projected or estimated date for milestone completion based on latest production progress and risk assessment.',
    `milestone_name` STRING COMMENT 'Human-readable name or title of the milestone event (e.g., Greenlight Approval, Picture Lock, Final Delivery).',
    `milestone_status` STRING COMMENT 'Current lifecycle status of the milestone indicating whether it is pending, on track, delayed, completed, or no longer applicable.. Valid values are `upcoming|in_progress|at_risk|achieved|missed|cancelled`',
    `milestone_type` STRING COMMENT 'Categorical classification of the milestone within the production lifecycle. Defines the phase or gate this milestone represents. [ENUM-REF-CANDIDATE: greenlight|pre_production_start|principal_photography_start|principal_photography_end|picture_lock|audio_mix_complete|vfx_complete|color_grading_complete|final_qc_pass|delivery_to_broadcaster|archive_complete|post_production_start|rough_cut_complete|final_cut_complete|mastering_complete — promote to reference product]',
    `mitigation_plan` STRING COMMENT 'Description of actions or contingency plans in place to address identified risks and ensure milestone is achieved.',
    `notes` STRING COMMENT 'Free-form text field for additional context, comments, or observations related to this milestone event.',
    `planned_date` DATE COMMENT 'Originally scheduled or target date for achieving this milestone as defined during production planning.',
    `responsible_department` STRING COMMENT 'The production department or functional area responsible for delivering this milestone. [ENUM-REF-CANDIDATE: production|post_production|vfx|audio|editorial|color|qc|delivery|archive|legal|finance — 11 candidates stripped; promote to reference product]',
    `risk_description` STRING COMMENT 'Detailed explanation of identified risks, issues, or blockers that may prevent timely achievement of this milestone.',
    `risk_level` STRING COMMENT 'Assessment of the risk that this milestone will not be achieved on time, based on current production status and known issues.. Valid values are `low|medium|high|critical`',
    `sap_wbs_element` STRING COMMENT 'SAP project structure element code linking this milestone to the enterprise project management and financial tracking hierarchy.',
    `stakeholder_notification_flag` BOOLEAN COMMENT 'Indicates whether stakeholders (network executives, distributors, talent) must be notified when this milestone is achieved or at risk.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was last modified or updated.',
    `variance_days` STRING COMMENT 'Number of days difference between planned date and actual date (positive indicates delay, negative indicates early completion). Calculated field for reporting purposes.',
    CONSTRAINT pk_milestone PRIMARY KEY(`milestone_id`)
) COMMENT 'Key milestone event in the production lifecycle for a project or episode. Captures milestone type (greenlight, pre-production start, first day of photography, picture lock, audio mix complete, VFX complete, final QC pass, delivery to broadcaster, archive complete), planned date, actual date, milestone status (upcoming, at-risk, achieved, missed), responsible owner, and any associated approval or sign-off requirement. Enables production schedule tracking and stakeholder reporting against key delivery gates.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`production`.`location` (
    `location_id` BIGINT COMMENT 'Unique identifier for the production location. Primary key.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Location owners and management companies are partners who lease filming locations. Linking enables tracking all locations managed by that partner, payment processing for location fees, permit coordina',
    `address_line_1` STRING COMMENT 'Primary street address of the production location including street number and name.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, building, or unit number.',
    `base_camp_capacity` STRING COMMENT 'Number of trailers or mobile units that can be accommodated at the base camp area near the location for cast, crew, wardrobe, makeup, and catering.',
    `city` STRING COMMENT 'City or municipality where the location is situated.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the location is situated (e.g., USA, CAN, GBR, MEX).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this location record was first created in the system.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Total fee paid to the location owner or manager for the right to film at this location. Excludes additional costs such as permits, insurance, or restoration.',
    `fee_currency` STRING COMMENT 'Three-letter ISO currency code for the location fee (e.g., USD, CAD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `insurance_required_flag` BOOLEAN COMMENT 'Indicates whether the location owner requires specific production insurance coverage or certificates of insurance before filming can commence.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the location in decimal degrees format, used for mapping, navigation, and sunrise/sunset calculations.',
    `location_code` STRING COMMENT 'Business identifier code for the location used in production schedules and call sheets. Typically assigned by the location manager or production coordinator.. Valid values are `^[A-Z0-9]{4,12}$`',
    `location_name` STRING COMMENT 'Human-readable name or title of the production location (e.g., Downtown Warehouse District, Malibu Beach House, Historic City Hall).',
    `location_status` STRING COMMENT 'Current lifecycle status of the location: scouted (identified by location scout), approved (approved for use by director/producer), contracted (agreement signed with owner), active (currently in use for shooting), wrapped (shooting completed), rejected (not suitable for production).. Valid values are `scouted|approved|contracted|active|wrapped|rejected`',
    `location_type` STRING COMMENT 'Classification of the location based on its physical characteristics and usage: practical interior (real indoor space), practical exterior (real outdoor space), backlot (studio-controlled outdoor set), remote (distant or hard-to-access site), international (foreign location), studio exterior (controlled outdoor studio space).. Valid values are `practical_interior|practical_exterior|backlot|remote|international|studio_exterior`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the location in decimal degrees format, used for mapping, navigation, and logistics planning.',
    `manager_notes` STRING COMMENT 'Free-text notes and observations from the location manager regarding access, restrictions, special requirements, or other relevant production considerations.',
    `noise_assessment` STRING COMMENT 'Assessment of ambient noise levels at the location: quiet (minimal background noise, suitable for dialogue recording), moderate (some noise, may require sound treatment), noisy (significant noise, requires ADR or sound mitigation), unacceptable (excessive noise, unsuitable for production).. Valid values are `quiet|moderate|noisy|unacceptable`',
    `owner_contact_email` STRING COMMENT 'Primary email address for the location owner or authorized representative for contract and coordination communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `owner_contact_phone` STRING COMMENT 'Primary phone number for the location owner or authorized representative for coordination and emergency contact during production.',
    `parking_capacity` STRING COMMENT 'Number of vehicle parking spaces available at or near the location for crew, cast, and equipment trucks.',
    `permit_authority` STRING COMMENT 'Name of the governmental or regulatory authority responsible for issuing filming permits for this location (e.g., Los Angeles Film Office, NYC Mayor Office of Media and Entertainment).',
    `permit_expiry_date` DATE COMMENT 'Date when the filming permit expires and is no longer valid for production use.',
    `permit_issue_date` DATE COMMENT 'Date when the filming permit was officially issued by the permitting authority.',
    `permit_number` STRING COMMENT 'Official permit or authorization number issued by the permitting authority for filming at this location.',
    `permit_status` STRING COMMENT 'Current status of filming permits required for this location: not required (no permit needed), pending (application submitted), approved (permit granted), denied (permit rejected), expired (permit validity lapsed).. Valid values are `not_required|pending|approved|denied|expired`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the location address.',
    `power_availability` STRING COMMENT 'Assessment of electrical power availability at the location: grid (connected to utility power), generator required (no grid power, generators needed), limited (some power available but insufficient for full production), none (no power infrastructure).. Valid values are `grid|generator_required|limited|none`',
    `region` STRING COMMENT 'Broader geographic region or area classification (e.g., Southern California, Pacific Northwest, New England) used for production planning and logistics.',
    `restoration_required_flag` BOOLEAN COMMENT 'Indicates whether the production is contractually obligated to restore the location to its original condition after filming concludes.',
    `restroom_facilities` STRING COMMENT 'Assessment of restroom availability: on site (permanent facilities available), portable required (portable restrooms must be brought in), nearby (facilities within walking distance), none (no facilities available).. Valid values are `on_site|portable_required|nearby|none`',
    `safety_assessment_date` DATE COMMENT 'Date when the safety assessment was conducted by the production safety officer or third-party assessor.',
    `safety_assessment_status` STRING COMMENT 'Status of the safety and risk assessment conducted for this location: not assessed (no evaluation performed), in progress (assessment underway), passed (meets safety requirements), failed (does not meet safety standards), conditional (approved with specific safety measures required).. Valid values are `not_assessed|in_progress|passed|failed|conditional`',
    `scout_approval_status` STRING COMMENT 'Approval status from the location scout assessment: pending (awaiting review), approved (meets production requirements), rejected (does not meet requirements), conditional (approved with specific conditions or modifications).. Valid values are `pending|approved|rejected|conditional`',
    `state_province` STRING COMMENT 'State, province, or administrative region of the location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this location record was last modified in the system.',
    `water_availability` STRING COMMENT 'Assessment of water access at the location: available (connected to water supply), limited (some water but insufficient for full crew), trucked in required (no water infrastructure, must be transported), none (no water access).. Valid values are `available|limited|trucked_in_required|none`',
    CONSTRAINT pk_location PRIMARY KEY(`location_id`)
) COMMENT 'Master record for a physical production location — an on-location shoot site used for principal photography or second unit work. Captures location name, address, GPS coordinates, country, region, location type (practical interior, practical exterior, backlot, remote, international), location scout approval status, permit status, permit authority, permit expiry date, location fee, safety assessment status, noise assessment, sunrise/sunset data relevance, parking and base camp capacity, and contact details for the location owner or manager. Distinct from facility_booking which covers controlled studio and post-production facilities.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`production`.`format_spec` (
    `format_spec_id` BIGINT COMMENT 'Primary key for format_spec',
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: Production format specifications map to distribution ABR profiles for transcoding workflows. Real business process: format conversion pipeline configuration, encoding preset selection, and quality ass',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Channels define technical delivery specifications (resolution, codec, audio format) that productions must meet. Broadcast standards compliance requires format specs tied to target channel. Required fo',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Format specifications are authored to meet specific delivery channel technical requirements. In media-broadcasting, each delivery channel (FAST, OTT, linear) mandates distinct format specs. Existing c',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: Technical delivery specification management: broadcast engineers define format specs to meet distribution agreement technical requirements (codec, resolution, bitrate, closed caption standard). Direct',
    `format_specification_id` BIGINT COMMENT 'Foreign key linking to mediaasset.format_specification. Business justification: Production format specs (broadcast technical requirements) must align with MAM format_specifications for cross-domain format compliance validation. Linking enables automated verification that delivera',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: OTT platforms publish platform-specific delivery specifications (Netflix Delivery Specifications, Apple TV+ Tech Specs). Media-broadcasting post-production teams author format_specs per OTT platform. ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Compliance-mandated technical standards: format specifications encode regulatory requirements (FCC loudness ATSC A/85, CEA-608/708 caption standards, HDR broadcast standards). Linking format_spec to r',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: A series has a canonical format spec that all episodes must conform to (series color space, audio configuration, resolution standard). Series-level format spec management is a named technical producti',
    `abr_profile` STRING COMMENT 'The adaptive bitrate streaming profile or ladder configuration associated with this format specification.',
    `approval_date` DATE COMMENT 'The date on which this format specification was officially approved for use in production workflows.',
    `approved_by` STRING COMMENT 'The name or identifier of the person or role who approved this format specification for production use.',
    `aspect_ratio` STRING COMMENT 'The proportional relationship between width and height of the video frame (e.g., 16:9, 4:3, 2.39:1, 1.85:1).',
    `audio_bit_depth` STRING COMMENT 'The number of bits used to represent each audio sample (e.g., 16, 24, 32).',
    `audio_codec` STRING COMMENT 'The audio compression codec used for encoding (e.g., AAC, AC-3, E-AC-3, PCM, Dolby Digital Plus, Dolby Atmos).',
    `audio_configuration` STRING COMMENT 'The audio channel layout and configuration for this format specification.. Valid values are `mono|stereo|5.1|7.1|7.1.4|Atmos|immersive`',
    `audio_sample_rate_khz` DECIMAL(18,2) COMMENT 'The audio sampling frequency in kilohertz (e.g., 48, 96, 192).',
    `bit_depth` STRING COMMENT 'The number of bits used to represent color information per channel (e.g., 8, 10, 12, 16).',
    `broadcast_standard` STRING COMMENT 'The broadcast television standard applicable to this format specification.. Valid values are `ATSC|DVB|ISDB|NTSC|PAL|SECAM`',
    `chroma_subsampling` STRING COMMENT 'The chroma subsampling scheme defining color resolution relative to luminance (e.g., 4:2:0, 4:2:2, 4:4:4).',
    `closed_caption_standard` STRING COMMENT 'The closed captioning or subtitle standard supported by this format (e.g., CEA-608, CEA-708, DVB Subtitles, TTML).',
    `color_space` STRING COMMENT 'The color space standard defining the range and representation of colors in the video signal.. Valid values are `Rec.601|Rec.709|Rec.2020|DCI-P3|Adobe_RGB`',
    `compliance_requirements` STRING COMMENT 'List of regulatory or industry compliance requirements that this format specification satisfies (e.g., FCC broadcast standards, ATSC 3.0, DVB-T2).',
    `container_format` STRING COMMENT 'The file container or wrapper format used to package video, audio, and metadata streams (e.g., MXF, MOV, MP4, TS).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this format specification record was first created in the system.',
    `dalet_format_profile_reference` STRING COMMENT 'The corresponding format profile identifier in Dalet Galaxy MAM system used for workflow orchestration and transcoding.',
    `drm_compatibility` STRING COMMENT 'The DRM systems or encryption standards compatible with this format specification (e.g., Widevine, PlayReady, FairPlay).',
    `effective_end_date` DATE COMMENT 'The date on which this format specification is no longer valid for new production projects. Null indicates no planned end date.',
    `effective_start_date` DATE COMMENT 'The date from which this format specification becomes effective and available for use in production projects.',
    `file_size_gb` DECIMAL(18,2) COMMENT 'The estimated or typical file size in gigabytes for content encoded in this format specification for a standard duration.',
    `format_code` STRING COMMENT 'Short alphanumeric code or identifier used to reference this format specification in production systems and workflows.',
    `format_name` STRING COMMENT 'Business name or label for this format specification (e.g., UHD 4K HDR10 Theatrical, HD 1080p Broadcast Standard).',
    `format_status` STRING COMMENT 'The current lifecycle status of this format specification within the production environment.. Valid values are `draft|approved|active|deprecated|retired`',
    `format_type` STRING COMMENT 'Classification of the format specification by its intended use in the production workflow.. Valid values are `capture|delivery|master|proxy|mezzanine|distribution`',
    `frame_rate` DECIMAL(18,2) COMMENT 'The number of frames per second for this format specification (e.g., 23.976, 24, 25, 29.97, 30, 50, 59.94, 60).',
    `hdr_standard` STRING COMMENT 'The HDR standard applied to this format specification, or SDR if standard dynamic range.. Valid values are `SDR|HDR10|HDR10_Plus|Dolby_Vision|HLG`',
    `is_default_format` BOOLEAN COMMENT 'Boolean flag indicating whether this format specification is the default or recommended format for its type and resolution class.',
    `resolution` STRING COMMENT 'The spatial resolution of the video format, defining the number of pixels and scan type (progressive or interlaced).. Valid values are `SD|HD_720p|HD_1080i|HD_1080p|UHD_4K|UHD_8K`',
    `streaming_protocol` STRING COMMENT 'The streaming delivery protocol supported by this format (e.g., HLS, MPEG-DASH, RTMP, SRT).',
    `technical_notes` STRING COMMENT 'Additional technical notes, specifications, or guidance for production teams using this format specification.',
    `timecode_format` STRING COMMENT 'The timecode standard and format used for frame-accurate synchronization and editing.. Valid values are `drop_frame|non_drop_frame|PAL|film`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this format specification record was last modified or updated.',
    `video_bitrate_mbps` DECIMAL(18,2) COMMENT 'The target or maximum video bitrate in megabits per second for this format specification.',
    `video_codec` STRING COMMENT 'The video compression codec used for encoding (e.g., H.264, H.265/HEVC, ProRes, DNxHD, AVC-Intra, XAVC).',
    CONSTRAINT pk_format_spec PRIMARY KEY(`format_spec_id`)
) COMMENT 'Reference record defining the technical production format specification for a project or deliverable — the agreed capture and delivery format standard. Captures format name, frame rate (23.976, 25, 29.97, 50, 59.94), resolution (HD 1080i, HD 1080p, UHD 4K, 8K), aspect ratio, color space (Rec.709, Rec.2020, P3), HDR standard (HDR10, Dolby Vision, HLG), audio configuration (5.1, 7.1, Atmos), codec, container format, and applicable broadcast standard (ATSC, DVB). Serves as the technical specification baseline for all production and post-production work.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`production`.`equipment_item` (
    `equipment_item_id` BIGINT COMMENT 'Primary key for equipment_item',
    `location_id` BIGINT COMMENT 'Reference to the facility, studio, or storage location where this equipment item is currently located.',
    `parent_equipment_item_id` BIGINT COMMENT 'Self-referencing FK on equipment_item (parent_equipment_item_id)',
    `project_id` BIGINT COMMENT 'Reference to the production project to which this equipment item is currently assigned, if applicable.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier from whom this equipment item was purchased.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original purchase price or acquisition cost of the equipment item in the organizations base currency.',
    `acquisition_date` DATE COMMENT 'Date when the equipment item was acquired or purchased by the organization.',
    `asset_tag` STRING COMMENT 'Externally-visible unique asset tag or barcode identifier affixed to the physical equipment for tracking and inventory purposes.',
    `assignment_start_date` DATE COMMENT 'Date when the current assignment of this equipment item to a production or crew member began.',
    `condition` STRING COMMENT 'Assessment of the physical condition and operational readiness of the equipment item.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this equipment item record was first created in the system.',
    `current_value` DECIMAL(18,2) COMMENT 'Current estimated market or book value of the equipment item, reflecting depreciation and condition.',
    `daily_rental_rate` DECIMAL(18,2) COMMENT 'Daily rental cost for this equipment item if it is rented, in the organizations base currency.',
    `depreciation_method` STRING COMMENT 'Accounting method used to calculate depreciation of this equipment item over its useful life.',
    `disposal_method` STRING COMMENT 'Method by which this equipment item was disposed of after retirement from service.',
    `equipment_item_name` STRING COMMENT 'Human-readable name or title of the equipment item for identification and display purposes.',
    `equipment_item_status` STRING COMMENT 'Current operational status of the equipment item in its lifecycle.',
    `expected_return_date` DATE COMMENT 'Scheduled date when the equipment item is expected to be returned from its current assignment.',
    `insurance_expiration_date` DATE COMMENT 'Date when the current insurance coverage for this equipment item expires.',
    `insurance_policy_number` STRING COMMENT 'Policy number of the insurance coverage protecting this equipment item against loss or damage.',
    `is_rental` BOOLEAN COMMENT 'Indicates whether this equipment item is rented from an external vendor rather than owned by the organization.',
    `last_maintenance_date` DATE COMMENT 'Date when the most recent maintenance, inspection, or service was performed on this equipment item.',
    `maintenance_interval_days` STRING COMMENT 'Standard number of days between scheduled maintenance activities for this equipment item.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured this equipment item.',
    `model_number` STRING COMMENT 'Manufacturer model number or designation for this equipment item.',
    `next_maintenance_due_date` DATE COMMENT 'Scheduled date for the next required maintenance or inspection of this equipment item.',
    `notes` STRING COMMENT 'Free-form notes, comments, or special instructions related to this equipment item.',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with the acquisition of this equipment item.',
    `retirement_date` DATE COMMENT 'Date when this equipment item was retired from active service and removed from the available inventory.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number uniquely identifying this specific unit of equipment.',
    `technical_specifications` STRING COMMENT 'Detailed technical specifications, capabilities, and features of this equipment item relevant to production use.',
    `total_usage_hours` DECIMAL(18,2) COMMENT 'Cumulative total hours of operational usage recorded for this equipment item since acquisition.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this equipment item record was most recently updated in the system.',
    `useful_life_years` STRING COMMENT 'Expected useful life of the equipment item in years for depreciation and replacement planning purposes.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer or vendor warranty coverage for this equipment item expires.',
    CONSTRAINT pk_equipment_item PRIMARY KEY(`equipment_item_id`)
) COMMENT 'Master reference table for equipment_item. Referenced by equipment_item_id.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`production`.`crew_call` (
    `crew_call_id` BIGINT COMMENT 'Unique surrogate identifier for this crew call record. Primary key for the association.',
    `crew_assignment_id` BIGINT COMMENT 'Foreign key linking to the crew assignment record. Identifies which crew member assignment this call applies to.',
    `shoot_schedule_id` BIGINT COMMENT 'Foreign key linking to the shoot schedule day. Identifies which specific shoot day this crew call applies to.',
    `actual_hours_worked` DECIMAL(18,2) COMMENT 'The actual number of hours this crew member worked on this shoot day, from their call time to their individual wrap time. Used for payroll calculation and overtime determination.',
    `call_status` STRING COMMENT 'Lifecycle status of this crew call: scheduled (on call sheet), confirmed (crew acknowledged), checked_in (crew arrived on set), wrapped (crew released), no_show (crew failed to appear), cancelled (shoot day cancelled or crew released before call).',
    `call_time` TIMESTAMP COMMENT 'The specific time this crew member is required to report to set for this shoot day. May differ from the general shoot schedule call time based on department needs (e.g., hair/makeup called earlier than camera crew).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this crew call record was first created in the system, typically when the call sheet is generated.',
    `day_out_of_days_type` STRING COMMENT 'Industry-standard DOOD code indicating this crew members work status for this shoot day: SW (Start Work), W (Work), WF (Work Finish), SWF (Start Work Finish - one-day assignment), H (Hold - on call but not working), T (Travel), R (Rehearsal). This is the core attribute of the DOOD report.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this crew call record was most recently modified, tracking changes to call times, status, or actual hours.',
    `meal_penalty_flag` BOOLEAN COMMENT 'Indicates whether this crew member incurred a meal penalty on this shoot day due to failure to break within the contractually required window (typically 6 hours). Triggers additional compensation per union rules.',
    `overtime_flag` BOOLEAN COMMENT 'Indicates whether this specific crew member incurred overtime hours on this shoot day. Used for payroll processing and budget tracking. Derived from actual hours worked vs contracted hours.',
    `travel_to_location_flag` BOOLEAN COMMENT 'Indicates whether this crew member is required to travel to a distant location for this shoot day, triggering per diem and travel time compensation.',
    `turnaround_hours` DECIMAL(18,2) COMMENT 'The number of hours between this crew members wrap time on the previous shoot day and their call time for this shoot day. Union agreements (DGA, IATSE, SAG-AFTRA) mandate minimum turnaround periods (typically 10-12 hours); violations trigger turnaround penalties.',
    `wrap_time` TIMESTAMP COMMENT 'The time this crew member was released from set for this shoot day. May differ from the general shoot schedule wrap time if certain departments wrap early or late.',
    CONSTRAINT pk_crew_call PRIMARY KEY(`crew_call_id`)
) COMMENT 'This association product represents the day-specific assignment of a crew member to a shoot schedule day. It captures the operational reality of the Day Out of Days (DOOD) report and daily call sheet in film and television production. Each record links one crew assignment to one shoot schedule day with attributes that exist only in the context of that specific shoot day: individual call times, overtime triggers, meal penalty tracking, and turnaround compliance. This is a fundamental production management entity that cannot be modeled as attributes on either the crew assignment (which spans multiple shoot days) or the shoot schedule (which involves multiple crew members).. Existence Justification: In film and television production, crew assignments span multiple shoot days (e.g., a Director of Photography contracted for 45 shoot days), and each shoot day involves dozens of crew members across departments. The Day Out of Days (DOOD) report and daily call sheet are industry-standard production management documents that track the intersection of crew assignments and shoot schedule days. Each crew-day pairing has unique operational data: individual call times (hair/makeup called earlier than camera), overtime triggers, meal penalty tracking, and turnaround compliance—all of which cannot exist on either the crew assignment (which is multi-day) or the shoot schedule (which is multi-crew).';

-- ========= FOREIGN KEYS =========
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ADD CONSTRAINT `fk_production_shoot_schedule_location_id` FOREIGN KEY (`location_id`) REFERENCES `media_broadcasting_ecm`.`production`.`location`(`location_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ADD CONSTRAINT `fk_production_shoot_schedule_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ADD CONSTRAINT `fk_production_shoot_schedule_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ADD CONSTRAINT `fk_production_shoot_schedule_script_id` FOREIGN KEY (`script_id`) REFERENCES `media_broadcasting_ecm`.`production`.`script`(`script_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ADD CONSTRAINT `fk_production_budget_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `media_broadcasting_ecm`.`production`.`budget`(`budget_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_shoot_schedule_id` FOREIGN KEY (`shoot_schedule_id`) REFERENCES `media_broadcasting_ecm`.`production`.`shoot_schedule`(`shoot_schedule_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_location_id` FOREIGN KEY (`location_id`) REFERENCES `media_broadcasting_ecm`.`production`.`location`(`location_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ADD CONSTRAINT `fk_production_facility_booking_location_id` FOREIGN KEY (`location_id`) REFERENCES `media_broadcasting_ecm`.`production`.`location`(`location_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ADD CONSTRAINT `fk_production_facility_booking_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ADD CONSTRAINT `fk_production_facility_booking_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ADD CONSTRAINT `fk_production_facility_booking_shoot_schedule_id` FOREIGN KEY (`shoot_schedule_id`) REFERENCES `media_broadcasting_ecm`.`production`.`shoot_schedule`(`shoot_schedule_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ADD CONSTRAINT `fk_production_equipment_allocation_equipment_item_id` FOREIGN KEY (`equipment_item_id`) REFERENCES `media_broadcasting_ecm`.`production`.`equipment_item`(`equipment_item_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ADD CONSTRAINT `fk_production_equipment_allocation_location_id` FOREIGN KEY (`location_id`) REFERENCES `media_broadcasting_ecm`.`production`.`location`(`location_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ADD CONSTRAINT `fk_production_equipment_allocation_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ADD CONSTRAINT `fk_production_equipment_allocation_shoot_schedule_id` FOREIGN KEY (`shoot_schedule_id`) REFERENCES `media_broadcasting_ecm`.`production`.`shoot_schedule`(`shoot_schedule_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_script_id` FOREIGN KEY (`script_id`) REFERENCES `media_broadcasting_ecm`.`production`.`script`(`script_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ADD CONSTRAINT `fk_production_script_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `media_broadcasting_ecm`.`production`.`deliverable`(`deliverable_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_format_spec_id` FOREIGN KEY (`format_spec_id`) REFERENCES `media_broadcasting_ecm`.`production`.`format_spec`(`format_spec_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_parent_task_post_production_task_id` FOREIGN KEY (`parent_task_post_production_task_id`) REFERENCES `media_broadcasting_ecm`.`production`.`post_production_task`(`post_production_task_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_script_id` FOREIGN KEY (`script_id`) REFERENCES `media_broadcasting_ecm`.`production`.`script`(`script_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_format_spec_id` FOREIGN KEY (`format_spec_id`) REFERENCES `media_broadcasting_ecm`.`production`.`format_spec`(`format_spec_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `media_broadcasting_ecm`.`production`.`deliverable`(`deliverable_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_post_production_task_id` FOREIGN KEY (`post_production_task_id`) REFERENCES `media_broadcasting_ecm`.`production`.`post_production_task`(`post_production_task_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `media_broadcasting_ecm`.`production`.`deliverable`(`deliverable_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_predecessor_milestone_id` FOREIGN KEY (`predecessor_milestone_id`) REFERENCES `media_broadcasting_ecm`.`production`.`milestone`(`milestone_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_item` ADD CONSTRAINT `fk_production_equipment_item_location_id` FOREIGN KEY (`location_id`) REFERENCES `media_broadcasting_ecm`.`production`.`location`(`location_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_item` ADD CONSTRAINT `fk_production_equipment_item_parent_equipment_item_id` FOREIGN KEY (`parent_equipment_item_id`) REFERENCES `media_broadcasting_ecm`.`production`.`equipment_item`(`equipment_item_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_item` ADD CONSTRAINT `fk_production_equipment_item_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_call` ADD CONSTRAINT `fk_production_crew_call_crew_assignment_id` FOREIGN KEY (`crew_assignment_id`) REFERENCES `media_broadcasting_ecm`.`production`.`crew_assignment`(`crew_assignment_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_call` ADD CONSTRAINT `fk_production_crew_call_shoot_schedule_id` FOREIGN KEY (`shoot_schedule_id`) REFERENCES `media_broadcasting_ecm`.`production`.`shoot_schedule`(`shoot_schedule_id`);

-- ========= TAGS =========
ALTER SCHEMA `media_broadcasting_ecm`.`production` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `media_broadcasting_ecm`.`production` SET TAGS ('dbx_domain' = 'production');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `asset_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Collection Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Distribution Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `distribution_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Master License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Production Company Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Target Ott Platform Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Production Spend (USD)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `approved_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Approved Production Budget (USD)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `approved_budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `co_production_flag` SET TAGS ('dbx_business_glossary_term' = 'Co-Production Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_business_glossary_term' = 'Content Genre');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `coppa_applicable` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Applicable Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Workflow ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `drm_required` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Required Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `eidr` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `eidr` SET TAGS ('dbx_value_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-Z]$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `episode_count` SET TAGS ('dbx_business_glossary_term' = 'Episode Count');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `fcc_license_required` SET TAGS ('dbx_business_glossary_term' = 'FCC Broadcast License Required Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `greenlight_date` SET TAGS ('dbx_business_glossary_term' = 'Greenlight Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `greenlight_status` SET TAGS ('dbx_business_glossary_term' = 'Greenlight Status');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `greenlight_status` SET TAGS ('dbx_value_regex' = 'pending|greenlighted|on_hold|cancelled|completed');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `isan` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `isan` SET TAGS ('dbx_value_regex' = '^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `original_ip_flag` SET TAGS ('dbx_business_glossary_term' = 'Original Intellectual Property (IP) Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `post_production_start_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Production Start Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `pre_production_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Production Start Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Production Language');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `principal_photography_end_date` SET TAGS ('dbx_business_glossary_term' = 'Principal Photography End Date (Picture Wrap)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `principal_photography_start_date` SET TAGS ('dbx_business_glossary_term' = 'Principal Photography Start Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `production_country` SET TAGS ('dbx_business_glossary_term' = 'Primary Production Country');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `production_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `production_format` SET TAGS ('dbx_business_glossary_term' = 'Production Format / Resolution');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `production_phase` SET TAGS ('dbx_business_glossary_term' = 'Production Phase');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `production_phase` SET TAGS ('dbx_value_regex' = 'development|pre_production|principal_photography|post_production|delivery|archived');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Production Project Type');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_business_glossary_term' = 'SAP Work Breakdown Structure (WBS) Element');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `season_number` SET TAGS ('dbx_business_glossary_term' = 'Season Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `synopsis` SET TAGS ('dbx_business_glossary_term' = 'Production Synopsis');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `target_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Target Delivery Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `total_runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Runtime (Minutes)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `shoot_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shoot Schedule ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `script_id` SET TAGS ('dbx_business_glossary_term' = 'Script Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `actual_extras_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Background Extras Count');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `actual_shoot_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Shoot Hours');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `actual_wrap_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Wrap Time');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `call_time` SET TAGS ('dbx_business_glossary_term' = 'Call Time');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `cover_set_description` SET TAGS ('dbx_business_glossary_term' = 'Cover Set Description');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Workflow ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `day_out_of_days_type` SET TAGS ('dbx_business_glossary_term' = 'Day Out of Days (DOOD) Type');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `estimated_extras_count` SET TAGS ('dbx_business_glossary_term' = 'Estimated Background Extras Count');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `estimated_shoot_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Shoot Hours');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `first_shot_time` SET TAGS ('dbx_business_glossary_term' = 'First Shot Time');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `is_overtime_day` SET TAGS ('dbx_business_glossary_term' = 'Overtime Day Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `meal_penalty_flag` SET TAGS ('dbx_business_glossary_term' = 'Meal Penalty Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Script Page Count');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `production_notes` SET TAGS ('dbx_business_glossary_term' = 'Production Day Notes');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `production_unit` SET TAGS ('dbx_business_glossary_term' = 'Production Unit');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `production_unit` SET TAGS ('dbx_value_regex' = 'main_unit|second_unit|splinter_unit|insert_unit');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Revision Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `revision_version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Revision Version');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `scene_numbers` SET TAGS ('dbx_business_glossary_term' = 'Scene Numbers');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Shoot Schedule Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Shoot Schedule Status');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|confirmed|in_progress|completed|cancelled|postponed');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `scheduled_wrap_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Wrap Time');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `shoot_date` SET TAGS ('dbx_business_glossary_term' = 'Shoot Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `shoot_day_number` SET TAGS ('dbx_business_glossary_term' = 'Shoot Day Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `shoot_type` SET TAGS ('dbx_business_glossary_term' = 'Shoot Type');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `shoot_type` SET TAGS ('dbx_value_regex' = 'studio|location|exterior|interior|mixed');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `total_approved_shoot_days` SET TAGS ('dbx_business_glossary_term' = 'Total Approved Shoot Days');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `turnaround_hours` SET TAGS ('dbx_business_glossary_term' = 'Crew Turnaround Hours');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ALTER COLUMN `weather_contingency_flag` SET TAGS ('dbx_business_glossary_term' = 'Weather Contingency Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Identifier');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `coproduction_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Coproduction Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `production_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Production Budget Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Status');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'DRAFT|PENDING_APPROVAL|APPROVED|REJECTED|LOCKED|CLOSED');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `approved_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Budget Change Reason');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `change_request_reference` SET TAGS ('dbx_business_glossary_term' = 'Budget Change Request Reference');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Commitment Amount');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_business_glossary_term' = 'Contingency Reserve Amount');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contingency Percentage');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Category Code');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Category Name');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `cost_line_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Line Type');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `cost_line_type` SET TAGS ('dbx_value_regex' = 'ABOVE_THE_LINE|BELOW_THE_LINE|POST_PRODUCTION|CONTINGENCY|OVERHEAD');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Forecast to Complete Amount');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `is_greenlight_budget` SET TAGS ('dbx_business_glossary_term' = 'Greenlight Budget Indicator');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Budget Locked Indicator');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `production_phase` SET TAGS ('dbx_business_glossary_term' = 'Production Phase');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `production_phase` SET TAGS ('dbx_value_regex' = 'DEVELOPMENT|PRE_PRODUCTION|PRINCIPAL_PHOTOGRAPHY|POST_PRODUCTION|DELIVERY|CLOSED');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `revised_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budget Amount');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `revised_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `sap_cost_object_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Cost Object ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_business_glossary_term' = 'SAP Work Breakdown Structure (WBS) Element');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|DALET_GALAXY|MANUAL');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = 'ORIGINAL|REVISED_1|REVISED_2|REVISED_3|FINAL|LOCKED');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor / Payee ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `shoot_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shoot Schedule Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `account_code` SET TAGS ('dbx_business_glossary_term' = 'Production Account Code');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `account_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `accrued_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Amount');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `accrued_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `actual_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `budgeted_amount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Amount');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `budgeted_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `committed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `contingency_pct` SET TAGS ('dbx_business_glossary_term' = 'Contingency Percentage');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Production Cost Category');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `cost_sub_category` SET TAGS ('dbx_business_glossary_term' = 'Production Cost Sub-Category');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Forecast Amount (EAC)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `fringe_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Fringe Benefit Rate Percentage');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `is_above_the_line` SET TAGS ('dbx_business_glossary_term' = 'Above-the-Line (ATL) Indicator');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `is_union_labor` SET TAGS ('dbx_business_glossary_term' = 'Union Labor Indicator');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Description');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Status');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Notes');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `production_phase` SET TAGS ('dbx_business_glossary_term' = 'Production Phase');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `production_phase` SET TAGS ('dbx_value_regex' = 'development|pre_production|principal_photography|post_production|delivery|archive');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Quantity');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `revised_budgeted_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budgeted Amount');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `revised_budgeted_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `tax_credit_eligible` SET TAGS ('dbx_business_glossary_term' = 'Tax Credit Eligible Indicator');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` SET TAGS ('dbx_subdomain' = 'resource_coordination');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `crew_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Assignment ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `cba_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Cba Rate Card Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `guild_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Out Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `program_rundown_id` SET TAGS ('dbx_business_glossary_term' = 'Program Rundown Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Crew Assignment Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_value_regex' = '^CA-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Crew Assignment Status');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|active|on_hold|completed|cancelled');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|cleared|failed|expired');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `box_rental_rate` SET TAGS ('dbx_business_glossary_term' = 'Box Rental Rate');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `box_rental_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_business_glossary_term' = 'Contracted Rate');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `credit_name` SET TAGS ('dbx_business_glossary_term' = 'Screen Credit Name');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `credit_position` SET TAGS ('dbx_business_glossary_term' = 'Screen Credit Position');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `credit_position` SET TAGS ('dbx_value_regex' = 'main_title|end_title|both|none');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Workflow ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|flat|run_of_show|episodic');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Production Department');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `guaranteed_days` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Work Days');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `kit_rental_rate` SET TAGS ('dbx_business_glossary_term' = 'Kit Rental Rate');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `kit_rental_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `meal_penalty_eligible` SET TAGS ('dbx_business_glossary_term' = 'Meal Penalty Eligible Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `overtime_rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Rate Multiplier');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `overtime_rate_multiplier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Rate');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `production_company` SET TAGS ('dbx_business_glossary_term' = 'Production Company Name');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `residuals_eligible` SET TAGS ('dbx_business_glossary_term' = 'Residuals Eligible Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_business_glossary_term' = 'Crew Role Title');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `safety_training_certified` SET TAGS ('dbx_business_glossary_term' = 'Safety Training Certified Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `sap_personnel_action_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Personnel Action ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `scheduled_days` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Work Days');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `travel_allowance` SET TAGS ('dbx_business_glossary_term' = 'Travel Allowance');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `travel_allowance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `turnaround_hours` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Hours');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `work_permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Expiry Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `work_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `work_permit_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ALTER COLUMN `work_permit_required` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Required Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` SET TAGS ('dbx_subdomain' = 'resource_coordination');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `facility_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Booking ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Program Schedule Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `shoot_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shoot Schedule Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `actual_end` SET TAGS ('dbx_business_glossary_term' = 'Actual End Datetime');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `actual_start` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Datetime');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `booking_end` SET TAGS ('dbx_business_glossary_term' = 'Booking End Datetime');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `booking_reference` SET TAGS ('dbx_business_glossary_term' = 'Booking Reference Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `booking_reference` SET TAGS ('dbx_value_regex' = '^BK-[A-Z0-9]{8,16}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `booking_start` SET TAGS ('dbx_business_glossary_term' = 'Booking Start Datetime');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_value_regex' = 'tentative|confirmed|cancelled|completed|on_hold');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `cancellation_fee` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Fee');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `cancellation_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `capacity_persons` SET TAGS ('dbx_business_glossary_term' = 'Facility Capacity (Persons)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Workflow ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Use Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Booking Notes');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `production_phase` SET TAGS ('dbx_business_glossary_term' = 'Production Phase');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Amount');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `rate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'hourly|daily|half_day|weekly|flat_fee');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `technical_specs` SET TAGS ('dbx_business_glossary_term' = 'Technical Specifications');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` SET TAGS ('dbx_subdomain' = 'resource_coordination');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `equipment_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Allocation ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `equipment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Item ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Rental Vendor ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `shoot_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shoot Schedule Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Allocation Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_value_regex' = '^EQALLOC-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `allocation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `asset_tag_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Code');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `asset_tag_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}-[0-9]{6}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `checkout_condition` SET TAGS ('dbx_business_glossary_term' = 'Equipment Condition at Checkout');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `checkout_condition` SET TAGS ('dbx_value_regex' = 'new|excellent|good|fair|poor');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `checkout_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Equipment Checkout Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Workflow ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `damage_claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Damage Claim Amount');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `damage_claim_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `damage_description` SET TAGS ('dbx_business_glossary_term' = 'Equipment Damage Description');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `equipment_category` SET TAGS ('dbx_business_glossary_term' = 'Equipment Category');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `equipment_name` SET TAGS ('dbx_business_glossary_term' = 'Equipment Name');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `insurance_value` SET TAGS ('dbx_business_glossary_term' = 'Equipment Insurance Value');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `insurance_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `is_insurance_required` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `is_owned_asset` SET TAGS ('dbx_business_glossary_term' = 'Owned Asset Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `production_department` SET TAGS ('dbx_business_glossary_term' = 'Production Department');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Equipment Quantity');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `rental_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rental Rate Amount');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `rental_rate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `rental_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rental Rate Type');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `rental_rate_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|flat_fee');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `return_condition` SET TAGS ('dbx_business_glossary_term' = 'Equipment Condition at Return');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `return_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Equipment Return Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Serial Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ALTER COLUMN `wbs_element_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Code');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` SET TAGS ('dbx_subdomain' = 'content_development');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `asset_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Collection Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Policy Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `script_id` SET TAGS ('dbx_business_glossary_term' = 'Script Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `sponsorship_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Target Ott Platform Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Production Cost (USD)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `actual_running_time_sec` SET TAGS ('dbx_business_glossary_term' = 'Actual Running Time (Seconds)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `approved_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Approved Production Budget (USD)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `approved_budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `audio_language_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Audio Language Code');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `audio_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `audio_mix_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Audio Mix Completion Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `closed_captioning_compliant` SET TAGS ('dbx_business_glossary_term' = 'Closed Captioning Compliance Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `color_grade_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Color Grading Completion Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `content_rating` SET TAGS ('dbx_value_regex' = 'TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `director_name` SET TAGS ('dbx_business_glossary_term' = 'Director Name');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `eidr_code` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `eidr_code` SET TAGS ('dbx_value_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-Z]$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `episode_code` SET TAGS ('dbx_business_glossary_term' = 'Episode Production Code');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `episode_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `episode_number` SET TAGS ('dbx_business_glossary_term' = 'Episode Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `first_air_date` SET TAGS ('dbx_business_glossary_term' = 'First Air Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `greenlight_date` SET TAGS ('dbx_business_glossary_term' = 'Greenlight Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `isan` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `isan` SET TAGS ('dbx_value_regex' = '^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `master_format` SET TAGS ('dbx_business_glossary_term' = 'Master Delivery Format');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `master_format` SET TAGS ('dbx_value_regex' = 'UHD_HDR|UHD_SDR|HD_1080p|HD_720p|SD');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `picture_lock_date` SET TAGS ('dbx_business_glossary_term' = 'Picture Lock Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `production_company` SET TAGS ('dbx_business_glossary_term' = 'Production Company Name');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `production_status` SET TAGS ('dbx_business_glossary_term' = 'Production Status');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `script_lock_date` SET TAGS ('dbx_business_glossary_term' = 'Script Lock Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `shoot_country_code` SET TAGS ('dbx_business_glossary_term' = 'Principal Photography Country Code');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `shoot_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `shoot_end_date` SET TAGS ('dbx_business_glossary_term' = 'Principal Photography End Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `shoot_location` SET TAGS ('dbx_business_glossary_term' = 'Principal Photography Location');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `shoot_start_date` SET TAGS ('dbx_business_glossary_term' = 'Principal Photography Start Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `showrunner_name` SET TAGS ('dbx_business_glossary_term' = 'Showrunner Name');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Language Codes');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `target_running_time_sec` SET TAGS ('dbx_business_glossary_term' = 'Target Running Time (Seconds)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `vfx_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Visual Effects (VFX) Completion Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ALTER COLUMN `writer_name` SET TAGS ('dbx_business_glossary_term' = 'Writer Name');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` SET TAGS ('dbx_subdomain' = 'content_development');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `script_id` SET TAGS ('dbx_business_glossary_term' = 'Script Identifier');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Identifier');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `sponsorship_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Underlying Rights Holder Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Script Approval Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_business_glossary_term' = 'Copyright Holder');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `copyright_year` SET TAGS ('dbx_business_glossary_term' = 'Copyright Year');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `dalet_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Document Reference');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `distribution_restriction` SET TAGS ('dbx_business_glossary_term' = 'Distribution Restriction');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `draft_type` SET TAGS ('dbx_business_glossary_term' = 'Draft Type');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `draft_type` SET TAGS ('dbx_value_regex' = 'outline|first draft|revised draft|shooting script|post-production script|final draft');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `estimated_runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Runtime in Minutes');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'Script File Format');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'PDF|DOCX|FDX|FOUNTAIN|TXT');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size in Megabytes (MB)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Script Format');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `genre` SET TAGS ('dbx_business_glossary_term' = 'Script Genre');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Script Language');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `lock_date` SET TAGS ('dbx_business_glossary_term' = 'Script Lock Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `lock_status` SET TAGS ('dbx_business_glossary_term' = 'Script Lock Status');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Script Notes');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Script Page Count');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Script Revision Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `revision_notes` SET TAGS ('dbx_business_glossary_term' = 'Revision Notes');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Status');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|restricted|expired');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `scene_count` SET TAGS ('dbx_business_glossary_term' = 'Scene Count');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `script_number` SET TAGS ('dbx_business_glossary_term' = 'Script Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `script_status` SET TAGS ('dbx_business_glossary_term' = 'Script Status');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `script_status` SET TAGS ('dbx_value_regex' = 'draft|in review|approved|locked|archived|rejected');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Script Version Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `wga_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Writers Guild of America (WGA) Registration Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ALTER COLUMN `writer_credits` SET TAGS ('dbx_business_glossary_term' = 'Writer Credits');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` SET TAGS ('dbx_subdomain' = 'delivery_workflow');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `post_production_task_id` SET TAGS ('dbx_business_glossary_term' = 'Post-Production Task Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `clearance_request_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance Request Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `delivery_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Policy Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `format_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Format Spec Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `ingest_job_id` SET TAGS ('dbx_business_glossary_term' = 'Ingest Job Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Output Asset Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `parent_task_post_production_task_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Task Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Vendor Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `script_id` SET TAGS ('dbx_business_glossary_term' = 'Script Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Target Schedule Slot Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `transcode_job_id` SET TAGS ('dbx_business_glossary_term' = 'Transcode Job Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `actual_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration Hours');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `dalet_workflow_task_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Workflow Task Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `dependency_type` SET TAGS ('dbx_business_glossary_term' = 'Dependency Type');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `dependency_type` SET TAGS ('dbx_value_regex' = 'finish_to_start|start_to_start|finish_to_finish|start_to_finish|none');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Amount');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Hours');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `output_media_path` SET TAGS ('dbx_business_glossary_term' = 'Output Media Path');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Task Priority');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `qc_pass_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Pass Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `scheduled_due_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Due Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `source_media_path` SET TAGS ('dbx_business_glossary_term' = 'Source Media Path');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `task_notes` SET TAGS ('dbx_business_glossary_term' = 'Task Notes');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `task_number` SET TAGS ('dbx_business_glossary_term' = 'Task Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ALTER COLUMN `workstation_code` SET TAGS ('dbx_business_glossary_term' = 'Workstation Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` SET TAGS ('dbx_subdomain' = 'delivery_workflow');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Abr Profile Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `delivery_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Drm Policy Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `format_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Production Format Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `ingest_job_id` SET TAGS ('dbx_business_glossary_term' = 'Ingest Job Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `partner_content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Content Window Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `release_window_id` SET TAGS ('dbx_business_glossary_term' = 'Release Window Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `sponsorship_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Target Ott Platform Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `territory_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Grant Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `audio_channels` SET TAGS ('dbx_business_glossary_term' = 'Audio Channels');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `audio_description_flag` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'Checksum Message Digest 5 (MD5)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{32}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `closed_caption_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `compliance_certificate_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certificate Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `deliverable_name` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Name');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `deliverable_type` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Type');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration in Seconds');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `eidr_code` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `eidr_code` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `qc_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Notes');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `qc_operator_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Operator Name');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `qc_operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `qc_operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `qc_pass_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Pass Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `qc_performed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Performed Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `revision_notes` SET TAGS ('dbx_business_glossary_term' = 'Revision Notes');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `scheduled_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Languages');
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` SET TAGS ('dbx_subdomain' = 'delivery_workflow');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `qc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `closed_caption_record_id` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Record Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `delivery_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Asset Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `post_production_task_id` SET TAGS ('dbx_business_glossary_term' = 'Post Production Task Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `qc_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Qc Inspection Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Target Abr Profile Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `audio_channel_configuration` SET TAGS ('dbx_business_glossary_term' = 'Audio Channel Configuration');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `audio_description_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Compliance Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `closed_caption_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Compliance Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Workflow ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `error_codes` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Error Codes');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `final_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `final_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Status');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `final_approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending_approval|conditional_approval');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `loudness_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Loudness Compliance Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `loudness_lufs` SET TAGS ('dbx_business_glossary_term' = 'Loudness Level (LUFS)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `p1_critical_error_count` SET TAGS ('dbx_business_glossary_term' = 'Priority 1 (P1) Critical Error Count');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `p2_major_error_count` SET TAGS ('dbx_business_glossary_term' = 'Priority 2 (P2) Major Error Count');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `p3_minor_error_count` SET TAGS ('dbx_business_glossary_term' = 'Priority 3 (P3) Minor Error Count');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `qc_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Notes');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `qc_platform` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Platform');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `qc_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Result');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `qc_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|pending_review');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `qc_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Type');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `qc_type` SET TAGS ('dbx_value_regex' = 'technical_qc|editorial_qc|compliance_qc|accessibility_qc|loudness_qc|format_qc');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `re_qc_date` SET TAGS ('dbx_business_glossary_term' = 'Re-Quality Control (Re-QC) Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `remediation_notes` SET TAGS ('dbx_business_glossary_term' = 'Remediation Notes');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `review_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Duration (Minutes)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `review_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review End Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `review_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Start Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Status');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|on_hold|cancelled');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `total_error_count` SET TAGS ('dbx_business_glossary_term' = 'Total Error Count');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `video_frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Video Frame Rate');
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ALTER COLUMN `video_resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Identifier');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `coproduction_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Coproduction Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `delivery_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `predecessor_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Milestone Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Program Schedule Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `release_window_id` SET TAGS ('dbx_business_glossary_term' = 'Release Window Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Name');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Milestone Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `budget_impact_usd` SET TAGS ('dbx_business_glossary_term' = 'Budget Impact in United States Dollars (USD)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `budget_impact_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Workflow Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `dependency_count` SET TAGS ('dbx_business_glossary_term' = 'Dependency Count');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Milestone Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_value_regex' = 'upcoming|in_progress|at_risk|achieved|missed|cancelled');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Milestone Notes');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Milestone Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_business_glossary_term' = 'SAP Work Breakdown Structure (WBS) Element');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `stakeholder_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Notification Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ALTER COLUMN `variance_days` SET TAGS ('dbx_business_glossary_term' = 'Milestone Variance in Days');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` SET TAGS ('dbx_subdomain' = 'content_development');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `base_camp_capacity` SET TAGS ('dbx_business_glossary_term' = 'Base Camp Capacity');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Location Fee Amount');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Location Fee Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'scouted|approved|contracted|active|wrapped|rejected');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'practical_interior|practical_exterior|backlot|remote|international|studio_exterior');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `manager_notes` SET TAGS ('dbx_business_glossary_term' = 'Location Manager Notes');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `noise_assessment` SET TAGS ('dbx_business_glossary_term' = 'Noise Assessment');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `noise_assessment` SET TAGS ('dbx_value_regex' = 'quiet|moderate|noisy|unacceptable');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Owner Contact Email Address');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Owner Contact Phone Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `parking_capacity` SET TAGS ('dbx_business_glossary_term' = 'Parking Capacity');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `permit_authority` SET TAGS ('dbx_business_glossary_term' = 'Permit Authority');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiry Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `permit_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Issue Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `permit_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|denied|expired');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `power_availability` SET TAGS ('dbx_business_glossary_term' = 'Power Availability');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `power_availability` SET TAGS ('dbx_value_regex' = 'grid|generator_required|limited|none');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `restoration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Restoration Required Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `restroom_facilities` SET TAGS ('dbx_business_glossary_term' = 'Restroom Facilities');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `restroom_facilities` SET TAGS ('dbx_value_regex' = 'on_site|portable_required|nearby|none');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `safety_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Assessment Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `safety_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Assessment Status');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `safety_assessment_status` SET TAGS ('dbx_value_regex' = 'not_assessed|in_progress|passed|failed|conditional');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `scout_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Scout Approval Status');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `scout_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `water_availability` SET TAGS ('dbx_business_glossary_term' = 'Water Availability');
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ALTER COLUMN `water_availability` SET TAGS ('dbx_value_regex' = 'available|limited|trucked_in_required|none');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` SET TAGS ('dbx_subdomain' = 'content_development');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `format_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Format Spec Identifier');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Abr Profile Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Format Specification Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `abr_profile` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Profile');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `audio_bit_depth` SET TAGS ('dbx_business_glossary_term' = 'Audio Bit Depth');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `audio_configuration` SET TAGS ('dbx_business_glossary_term' = 'Audio Channel Configuration');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `audio_configuration` SET TAGS ('dbx_value_regex' = 'mono|stereo|5.1|7.1|7.1.4|Atmos|immersive');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `audio_sample_rate_khz` SET TAGS ('dbx_business_glossary_term' = 'Audio Sample Rate (Kilohertz)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `bit_depth` SET TAGS ('dbx_business_glossary_term' = 'Color Bit Depth');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `broadcast_standard` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Standard');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `broadcast_standard` SET TAGS ('dbx_value_regex' = 'ATSC|DVB|ISDB|NTSC|PAL|SECAM');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `chroma_subsampling` SET TAGS ('dbx_business_glossary_term' = 'Chroma Subsampling');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `closed_caption_standard` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Standard');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `color_space` SET TAGS ('dbx_business_glossary_term' = 'Color Space Standard');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `color_space` SET TAGS ('dbx_value_regex' = 'Rec.601|Rec.709|Rec.2020|DCI-P3|Adobe_RGB');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `container_format` SET TAGS ('dbx_business_glossary_term' = 'Container Format');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `dalet_format_profile_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Format Profile ID');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `drm_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Compatibility');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `file_size_gb` SET TAGS ('dbx_business_glossary_term' = 'Estimated File Size (Gigabytes)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `format_code` SET TAGS ('dbx_business_glossary_term' = 'Format Specification Code');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `format_name` SET TAGS ('dbx_business_glossary_term' = 'Format Specification Name');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `format_status` SET TAGS ('dbx_business_glossary_term' = 'Format Specification Status');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `format_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|deprecated|retired');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `format_type` SET TAGS ('dbx_business_glossary_term' = 'Format Type');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `format_type` SET TAGS ('dbx_value_regex' = 'capture|delivery|master|proxy|mezzanine|distribution');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate (Frames Per Second)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `hdr_standard` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Standard');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `hdr_standard` SET TAGS ('dbx_value_regex' = 'SDR|HDR10|HDR10_Plus|Dolby_Vision|HLG');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `is_default_format` SET TAGS ('dbx_business_glossary_term' = 'Is Default Format Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `resolution` SET TAGS ('dbx_value_regex' = 'SD|HD_720p|HD_1080i|HD_1080p|UHD_4K|UHD_8K');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `technical_notes` SET TAGS ('dbx_business_glossary_term' = 'Technical Notes');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `timecode_format` SET TAGS ('dbx_business_glossary_term' = 'Timecode Format');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `timecode_format` SET TAGS ('dbx_value_regex' = 'drop_frame|non_drop_frame|PAL|film');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `video_bitrate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Video Bitrate (Megabits Per Second)');
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_item` SET TAGS ('dbx_subdomain' = 'resource_coordination');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_item` ALTER COLUMN `equipment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Item Identifier');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_item` ALTER COLUMN `parent_equipment_item_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_item` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_item` ALTER COLUMN `current_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_item` ALTER COLUMN `daily_rental_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_item` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_call` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_call` SET TAGS ('dbx_subdomain' = 'resource_coordination');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_call` SET TAGS ('dbx_association_edges' = 'production.crew_assignment,production.shoot_schedule');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_call` ALTER COLUMN `crew_call_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Call Identifier');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_call` ALTER COLUMN `crew_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Call - Crew Assignment Id');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_call` ALTER COLUMN `shoot_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Call - Shoot Schedule Id');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_call` ALTER COLUMN `actual_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours Worked');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_call` ALTER COLUMN `call_status` SET TAGS ('dbx_business_glossary_term' = 'Call Status');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_call` ALTER COLUMN `call_time` SET TAGS ('dbx_business_glossary_term' = 'Individual Call Time');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_call` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_call` ALTER COLUMN `day_out_of_days_type` SET TAGS ('dbx_business_glossary_term' = 'Day Out of Days Designation');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_call` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_call` ALTER COLUMN `meal_penalty_flag` SET TAGS ('dbx_business_glossary_term' = 'Meal Penalty Incurred Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_call` ALTER COLUMN `overtime_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Incurred Flag');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_call` ALTER COLUMN `travel_to_location_flag` SET TAGS ('dbx_business_glossary_term' = 'Travel to Location Required');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_call` ALTER COLUMN `turnaround_hours` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Hours');
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_call` ALTER COLUMN `wrap_time` SET TAGS ('dbx_business_glossary_term' = 'Individual Wrap Time');
