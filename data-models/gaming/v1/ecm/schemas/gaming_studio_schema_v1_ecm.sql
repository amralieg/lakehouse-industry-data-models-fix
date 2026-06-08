-- Schema for Domain: studio | Business: Gaming | Version: v1_ecm
-- Generated on: 2026-05-08 06:58:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `gaming_ecm`.`studio` COMMENT 'Manages internal and external development studio entities, production pipelines, sprint/milestone tracking, and game development project management. Owns Jira-driven backlogs, Perforce version control repositories, build pipelines, QA/playtesting cycles, UAT sign-off, CI/CD release gates, and first-party/third-party studio relationships. Supports GaaS live operations cadence and resource allocation.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `gaming_ecm`.`studio`.`game_studio` (
    `game_studio_id` BIGINT COMMENT 'Unique surrogate identifier for the game development studio entity. Primary key for the game_studio master record across the enterprise. Role: MASTER_PARTY — represents an organisational party (internal or external studio) that the business interacts with as a counterparty in development, co-development, or licensing relationships.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Studios operate under specific jurisdictions for tax, labor, data protection compliance. Hq_country_code denormalizes jurisdiction data; direct link enables jurisdiction-specific compliance obligation',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Studios operate under legal entities. Required for financial consolidation, intercompany transaction processing, regulatory reporting, tax compliance, and studio P&L roll-up to corporate financials.',
    `parent_studio_game_studio_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent studio entity when this studio is a subsidiary, satellite office, or acquired label operating under a parent studio umbrella. Null for top-level independent studios. Enables hierarchical studio organisation modelling for consolidated reporting and M&A tracking.',
    `acquisition_date` DATE COMMENT 'Date on which this studio was acquired by the parent publishing organisation, if applicable. Null for studios that have not been acquired. Used for M&A integration tracking, financial consolidation timelines, and IP ownership transition management.',
    `active_project_count` STRING COMMENT 'Number of active game development projects currently assigned to this studio. Sourced from Jira project tracking. Used for capacity planning, resource allocation decisions, and studio workload management. This is a point-in-time operational field, not a calculated aggregate — it reflects the current count as maintained in the source system.',
    `cicd_pipeline_enabled` BOOLEAN COMMENT 'Indicates whether the studios production pipeline is integrated with the enterprise CI/CD (Continuous Integration/Continuous Deployment) release gate infrastructure. True if automated build, test, and deployment pipelines are active for this studios projects. Drives release governance and gold master certification workflows.',
    `contract_end_date` DATE COMMENT 'Date on which the master development or partnership agreement with this studio expires or is scheduled to terminate. Null for open-ended agreements. Used for renewal pipeline management and vendor risk assessment.',
    `contract_start_date` DATE COMMENT 'Date on which the master development or partnership agreement with this studio became effective. Used for contract lifecycle management, renewal tracking, and tenure-based commercial term escalation.',
    `contract_tier` STRING COMMENT 'Classification of the studios contractual relationship tier with the publishing organisation. Strategic partners receive preferential terms, dedicated producer support, and co-marketing; preferred partners have established multi-title agreements; standard partners operate under standard development agreements; transactional partners are engaged for specific work-for-hire deliverables. Drives commercial terms, SLA commitments, and resource allocation priority.. Valid values are `strategic|preferred|standard|transactional`',
    `coppa_compliant` BOOLEAN COMMENT 'Indicates whether the studios data collection and processing practices comply with COPPA (Childrens Online Privacy Protection Act) requirements for titles directed at or likely to attract players under 13. Required for studios publishing mobile or online titles in the US market.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the studio master record was first created in the enterprise data platform. Serves as the RECORD_AUDIT_CREATED marker for the MASTER_PARTY role. Used for data lineage, audit trails, and Silver layer ingestion tracking.',
    `crm_account_reference` STRING COMMENT 'External account identifier for this studio in Salesforce CRM. Used to link studio master data to CRM account records for partner relationship management, campaign tracking, and case management. Enables cross-system reconciliation between the enterprise data lakehouse and Salesforce.',
    `data_processing_agreement` BOOLEAN COMMENT 'Indicates whether a Data Processing Agreement (DPA) has been executed with this studio as required under GDPR Article 28 for studios that process personal data of EU players on behalf of the publisher. True if a valid DPA is in place. Critical for GDPR compliance and data protection audit trails.',
    `dissolution_date` DATE COMMENT 'Date on which the studio was formally dissolved, closed, or ceased operations. Null for active studios. Used for historical record retention, contract wind-down tracking, and regulatory compliance archiving.',
    `engine_primary` STRING COMMENT 'Primary game engine technology used by the studio for production. Drives toolchain compatibility assessment, CI/CD pipeline configuration, asset pipeline standards, and engine licensing cost allocation. Unity and Unreal Engine are the primary operational systems of record for game development.. Valid values are `unity|unreal|proprietary|godot|cryengine|other`',
    `erp_vendor_reference` STRING COMMENT 'Vendor master identifier for this studio in SAP S/4HANA. Used for purchase order processing, accounts payable, contract milestone payments, and financial reporting. Enables reconciliation between studio master data and ERP financial transactions.',
    `esrb_registered` BOOLEAN COMMENT 'Indicates whether the studio is registered with the ESRB (Entertainment Software Rating Board) for North American content rating submissions. Required for all studios publishing titles on North American console and PC platforms. Drives rating submission workflow eligibility.',
    `founding_date` DATE COMMENT 'Calendar date on which the studio was legally incorporated or formally established. Used for studio tenure analysis, partnership longevity reporting, and due diligence in acquisition assessments.',
    `gaas_capable` BOOLEAN COMMENT 'Indicates whether the studio has demonstrated capability to support live operations and Game-as-a-Service (GaaS) post-launch cadence, including live events, seasonal content drops, balance patches, and in-game monetisation updates. True if the studio has shipped or is actively supporting a GaaS title.',
    `headcount_range` STRING COMMENT 'Approximate employee headcount band for the studio. Used for capacity planning, resource allocation sizing, and vendor risk tiering. Expressed as a range rather than exact count to accommodate external studios where precise headcount is not contractually disclosed.. Valid values are `1_10|11_50|51_200|201_500|501_1000|1001_plus`',
    `hq_city` STRING COMMENT 'City name of the studios primary headquarters. Used for geographic reporting, time zone determination for sprint ceremonies, and partner directory listings.',
    `hq_state_province` STRING COMMENT 'State or province of the studios primary headquarters. Used for sub-national regulatory compliance, tax jurisdiction, and geographic segmentation in partner reporting.',
    `ip_ownership_model` STRING COMMENT 'Defines the intellectual property ownership arrangement for titles developed by this studio. Publisher-owned means all IP vests in the publishing entity; studio-owned means the studio retains IP with a publishing licence granted; co-owned means shared IP rights; licensed_in means the studio develops under a third-party IP licence; licensed_out means the studios IP is licensed to the publisher. Critical for legal, finance, and M&A due diligence.. Valid values are `publisher_owned|studio_owned|co_owned|licensed_in|licensed_out`',
    `iso27001_certified` BOOLEAN COMMENT 'Indicates whether the studio holds a current ISO/IEC 27001 Information Security Management System certification. Used for vendor risk tiering, security due diligence, and determining whether enhanced security controls are required in the development agreement.',
    `jira_project_key` STRING COMMENT 'Jira project key prefix associated with this studios primary project board. Used to link sprint backlogs, epics, and release planning artefacts to the studio entity. Enables cross-system traceability between studio master data and project management workflows.. Valid values are `^[A-Z][A-Z0-9]{1,9}$`',
    `pci_dss_compliant` BOOLEAN COMMENT 'Indicates whether the studio is PCI DSS (Payment Card Industry Data Security Standard) compliant. Required for studios that handle in-app purchase (IAP) payment flows or store payment card data. Drives payment processing eligibility and monetisation integration approvals.',
    `pegi_registered` BOOLEAN COMMENT 'Indicates whether the studio is registered with PEGI (Pan European Game Information) for European content rating submissions. Required for studios publishing titles in European markets. Drives rating submission workflow eligibility and Digital Services Act compliance.',
    `platform_focus` STRING COMMENT 'Primary target platform(s) for which the studio develops games. Console includes PlayStation, Xbox, Nintendo; PC includes Steam and Epic Games Store; mobile includes iOS and Android; cross_platform spans multiple platforms; VR/AR (Virtual Reality/Augmented Reality) includes Meta Quest and PSVR; cloud includes streaming platforms. Used for platform certification routing (TRC/TCR) and Steamworks/Console SDK capability assessment.. Valid values are `console|pc|mobile|cross_platform|vr_ar|cloud`',
    `primary_contact_email` STRING COMMENT 'Primary operational email address for the studios designated point of contact. Used for contract communications, milestone notifications, and partner relationship management via Salesforce CRM. Classified as confidential organisational contact data.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact or account manager at the studio. Used for partner relationship management, contract correspondence, and escalation routing in Salesforce CRM and Zendesk.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the studios designated point of contact. Used for urgent escalations and partner communications. Classified as confidential organisational contact data.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `qa_embedded` BOOLEAN COMMENT 'Indicates whether the studio has an embedded Quality Assurance (QA) and playtesting function operating within its production pipeline. True if the studio runs internal QA cycles; False if QA is fully outsourced or handled by the publisher. Drives QA resource allocation and test plan ownership in the quality domain.',
    `revenue_share_pct` DECIMAL(18,2) COMMENT 'Contractually agreed revenue share percentage payable to the studio from net game revenues. Expressed as a percentage (e.g., 25.00 for 25%). Used for royalty calculation, financial forecasting, and P&L attribution in SAP S/4HANA CO module.',
    `soc2_compliant` BOOLEAN COMMENT 'Indicates whether the studio has achieved SOC 2 (Service Organization Controls Type 2) compliance for cloud-hosted development infrastructure and services. Used for vendor security risk assessment, particularly for studios operating cloud build pipelines or hosting player-facing services.',
    `specialization` STRING COMMENT 'Primary production specialization of the studio indicating the game tier or platform focus. AAA studios produce high-budget console/PC titles; indie studios produce lower-budget creative titles; mobile studios focus on iOS/Android; VR/AR (Virtual Reality/Augmented Reality) studios focus on immersive platforms; casual studios produce mass-market titles; mid-core studios target engaged but non-hardcore audiences; esports studios build competitive titles; engine_tech studios focus on game engine tooling. Drives project assignment eligibility and capability matching. [ENUM-REF-CANDIDATE: aaa|indie|mobile|vr_ar|casual|mid_core|esports|engine_tech — 8 candidates stripped; promote to reference product]',
    `studio_code` STRING COMMENT 'Short alphanumeric business identifier used to reference the studio in internal systems, Jira project keys, Perforce depot paths, and reporting. Externally known unique code that uniquely identifies the studio across operational systems. Must be uppercase alphanumeric with underscores, 2–20 characters.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `studio_name` STRING COMMENT 'Official registered or trade name of the game development studio as it appears in corporate directories, contracts, and partner-facing communications. Serves as the primary IDENTITY_LABEL for the studio party. Sourced from corporate directory and contract management system (Agiloft/Ironclad).',
    `studio_status` STRING COMMENT 'Current operational lifecycle state of the studio entity. Active studios are engaged in production or live operations; inactive studios have no current projects; on_hold studios are temporarily paused; dissolved studios have ceased operations; acquired studios have been absorbed into the parent organisation; divested studios have been sold or spun off. Drives eligibility for new project assignments and resource allocation.. Valid values are `active|inactive|on_hold|dissolved|acquired|divested`',
    `studio_type` STRING COMMENT 'Classification of the studios relationship tier with the publishing entity. First-party studios are wholly owned; second-party studios are exclusive partners; third-party studios are independent external developers; co-development studios share production responsibilities; indie studios are self-funded independents; work-for-hire studios deliver contracted deliverables. Drives contractual treatment, revenue sharing, and IP ownership rules. [ENUM-REF-CANDIDATE: first_party|second_party|third_party|co_development|indie|work_for_hire — promote to reference product if additional values are needed]. Valid values are `first_party|second_party|third_party|co_development|indie|work_for_hire`',
    `titles_shipped_count` STRING COMMENT 'Total number of commercially released game titles shipped by this studio across all platforms and publishing relationships. Used as a proxy for studio experience and production maturity in partner evaluation and project assignment decisions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the studio master record was most recently modified in the enterprise data platform. Used for change data capture, incremental ETL processing, and audit trail maintenance in the Databricks Lakehouse Silver layer.',
    `vcs_depot_path` STRING COMMENT 'Root depot path in Perforce Helix Core assigned to this studio for version control and digital asset management. Used to scope code reviews, build triggers, and access control policies. Enables traceability from studio entity to source code and asset repositories.',
    `website_url` STRING COMMENT 'Official public website URL for the studio. Used for partner directory listings, due diligence research, and marketing co-promotion materials.. Valid values are `^https?://[^s/$.?#].[^s]*$`',
    CONSTRAINT pk_game_studio PRIMARY KEY(`game_studio_id`)
) COMMENT 'Master record for all internal and external game development studios. Captures studio identity, type (first-party, second-party, third-party, co-development), founding date, headquarters location, headcount range, specialization (AAA, indie, mobile, VR/AR), active status, and contractual relationship tier. SSOT for studio entity across the enterprise. Sourced from corporate directory and contract management system (Agiloft/Ironclad). Referenced by dev_project, partnership, resource_allocation, and vendor_work_package.';

CREATE OR REPLACE TABLE `gaming_ecm`.`studio`.`dev_project` (
    `dev_project_id` BIGINT COMMENT 'Unique surrogate identifier for each game development project record in the studio domain. Primary key for the dev_project data product.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Projects must track age rating certifications to gate ship milestones and platform submissions; esrb_rating/pegi_rating fields denormalize cert data. Direct link enables compliance verification before',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Projects track cost centers for budget allocation, actuals tracking, and financial reporting. Core project accounting process in gaming studios—every project must roll up to a cost center for P&L.',
    `developer_account_id` BIGINT COMMENT 'Foreign key linking to platform.developer_account. Business justification: Studios enroll platform developer accounts to publish titles. Each dev project must be associated with the platform account used for certification submissions, build uploads, and storefront publishing',
    `game_studio_id` BIGINT COMMENT 'Reference to the internal or external development studio responsible for this project. Links to the studio master record.',
    `game_title_id` BIGINT COMMENT 'Reference to the associated game title Stock Keeping Unit (SKU) that this development project is producing or updating. Links to the game title master record.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Game projects routinely license third-party IP (middleware, music, brands). Tracking the governing agreement enables royalty calculation, compliance verification, and platform certification. Essential',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Projects directly reference licensed IP assets (game engines like Unreal, middleware like Wwise, brand partnerships). Required for SDK version tracking, compliance audits, and royalty attribution in d',
    `marketing_campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Marketing campaigns are launched for specific game projects. Real business process: launch campaign planning, UA budget allocation, and performance tracking tied to project milestones and ship dates. ',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Projects target specific network regions for deployment and compliance (data residency, GDPR). Critical for regional rollout planning, latency optimization, and regulatory compliance tracking in gamin',
    `privacy_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_impact_assessment. Business justification: GaaS projects processing player data require PIAs under GDPR/COPPA before launch. Dev_project.coppa_applicable signals PIA requirement; direct link enables tracking PIA completion as project gate.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Projects contribute to profit center P&L for title-level financial reporting. Standard gaming finance practice—projects are the primary cost accumulation unit for title profitability analysis.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Projects must comply with specific regulatory obligations (COPPA for kids games, loot box disclosure laws). Dev_project.coppa_applicable signals obligation; direct link enables project-level complian',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Game projects deploy to specific server fleets for live operations. Essential for capacity planning, deployment tracking, and operational monitoring. Projects need to know which fleet hosts their game',
    `actual_ship_date` DATE COMMENT 'Actual date the game title or update was released to players. Compared against target_ship_date to measure schedule adherence. Populated upon post-launch phase entry.',
    `cert_approval_date` DATE COMMENT 'Date on which the platform certification submission was approved by the first-party platform holder. Null until certification is granted. Drives final release scheduling.',
    `cert_submission_date` DATE COMMENT 'Date on which the build was submitted to first-party platform holders (e.g., Sony, Microsoft, Nintendo) for Technical Requirements Checklist (TRC) / Technical Certification Requirements (TCR) review via Steamworks or Console SDKs.',
    `cicd_pipeline_url` STRING COMMENT 'URL or identifier of the Continuous Integration/Continuous Deployment (CI/CD) build pipeline associated with this project. Used for build automation, release gate management, and deployment tracking.',
    `coppa_applicable` BOOLEAN COMMENT 'Indicates whether this project is subject to Childrens Online Privacy Protection Act (COPPA) compliance requirements due to targeting players under 13 years of age. Triggers additional data privacy controls and parental consent workflows.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this development project record was first created in the system, corresponding to the Jira project creation date/time. Supports audit trail and data lineage requirements.',
    `critical_bug_count` STRING COMMENT 'Current count of critical or blocker severity defect tickets in Jira for this project. A non-zero value typically blocks Gold Master (GM) approval and first-party certification submission.',
    `current_sprint_number` STRING COMMENT 'The sequential number of the currently active sprint for this development project as tracked in Jira. Used for progress reporting and velocity analysis.',
    `development_methodology` STRING COMMENT 'Software development methodology adopted for this project. Determines sprint cadence, backlog management approach, and release planning structure within Jira.. Valid values are `agile|scrum|kanban|waterfall|hybrid`',
    `engine_version` STRING COMMENT 'Specific version of the game engine in use for this project (e.g., 5.3.2 for Unreal Engine 5.3.2 or 2023.2.1 for Unity). Critical for build pipeline compatibility and Technical Requirements Checklist (TRC) compliance.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `game_engine` STRING COMMENT 'Primary game engine technology used for development. Determines asset pipeline, rendering, physics, and scripting toolchain. Sourced from project configuration in Unity or Unreal Engine.. Valid values are `unity|unreal_engine|proprietary|godot|other`',
    `gold_master_date` DATE COMMENT 'Date on which the Gold Master (GM) build was approved and locked for manufacturing or digital distribution. Represents the final Quality Assurance (QA) sign-off milestone. Null until the project reaches gold_master phase.',
    `has_mtx` BOOLEAN COMMENT 'Indicates whether this project includes in-game Microtransactions (MTX) or In-App Purchases (IAP) as part of its monetization model. Triggers additional regulatory review requirements under FTC consumer protection and COPPA compliance for titles targeting minors.',
    `has_ugc` BOOLEAN COMMENT 'Indicates whether this project includes User-Generated Content (UGC) features. Triggers content moderation requirements, GDPR data processing obligations, and compliance review under the European Commission Digital Services Act.',
    `headcount_allocated` STRING COMMENT 'Number of full-time equivalent (FTE) staff allocated to this development project at the current point in time. Used for resource planning and capacity management.',
    `is_first_party` BOOLEAN COMMENT 'Indicates whether this project is developed by a first-party studio (owned by the console manufacturer or platform holder) as opposed to a third-party external developer/publisher. Affects certification requirements and publishing agreements.',
    `is_gaas_title` BOOLEAN COMMENT 'Indicates whether this project is operating under a Game-as-a-Service (GaaS) live operations model with ongoing post-launch content updates and live service management. Drives live ops cadence planning and resource allocation.',
    `jira_project_key` STRING COMMENT 'The unique alphanumeric project key assigned in Jira (e.g., GAME1, DLCX2) that serves as the external business identifier for this development project. Sourced from Jira project configuration and used to cross-reference all sprints, epics, and backlogs.. Valid values are `^[A-Z][A-Z0-9]{1,9}$`',
    `milestone_completion_pct` DECIMAL(18,2) COMMENT 'Percentage of project milestones completed relative to total planned milestones, as tracked in Jira. Provides a high-level progress indicator for executive reporting and stakeholder updates.',
    `open_bug_count` STRING COMMENT 'Current count of open defect tickets in Jira for this project across all severity levels. Key Quality Assurance (QA) health indicator used in milestone readiness reviews.',
    `perforce_depot_path` STRING COMMENT 'Root depot path in Perforce Helix Core version control system for this projects digital assets and source code (e.g., //depot/games/project-titan/main). Used for build pipeline integration and digital asset management.',
    `project_code` STRING COMMENT 'Internal alphanumeric code used for budget tracking, SAP S/4HANA cost center allocation, and cross-system referencing of this development project.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `project_description` STRING COMMENT 'Free-text description of the development project scope, objectives, and key deliverables as documented in Jira project configuration. Used for stakeholder communication and project onboarding.',
    `project_name` STRING COMMENT 'Human-readable name of the game development project as configured in Jira (e.g., Project Titan — Season 3 Live Ops Update). Used in reporting, dashboards, and stakeholder communications.',
    `project_phase` STRING COMMENT 'Current phase in the game development lifecycle. Values: pre_production, production, alpha, beta, gold_master (Gold Master (GM) — final build approved for manufacturing/distribution), post_launch. Sourced from Jira project status and milestone tracking.. Valid values are `pre_production|production|alpha|beta|gold_master|post_launch`',
    `project_status` STRING COMMENT 'Current operational lifecycle status of the development project. Distinct from project_phase (which tracks development stage); this field tracks the administrative state of the project record.. Valid values are `active|on_hold|cancelled|completed|archived`',
    `project_type` STRING COMMENT 'Classification of the development project by its production scope. Values: new_ip (original Intellectual Property (IP)), sequel (follow-up to existing title), dlc (Downloadable Content (DLC) expansion), gaas_live_ops (Game-as-a-Service (GaaS) live operations update), port (platform port), remaster (remastered edition).. Valid values are `new_ip|sequel|dlc|gaas_live_ops|port|remaster`',
    `soft_launch_date` DATE COMMENT 'Date of the soft launch — a limited regional or audience release used to validate live operations, monetization, and stability before the full hard launch. Applicable primarily to mobile and GaaS titles.',
    `sprint_cadence_weeks` STRING COMMENT 'Duration of each sprint in weeks as configured in Jira for Scrum or Agile projects (typically 1, 2, or 3 weeks). Drives sprint planning, backlog grooming, and velocity tracking.',
    `start_date` DATE COMMENT 'Official start date of the development project, marking the beginning of active production work. Corresponds to the project start date configured in Jira.',
    `target_platforms` STRING COMMENT 'Comma-separated list of target distribution platforms for this project (e.g., PS5,Xbox Series X,PC,Switch,iOS,Android). Drives platform certification (Technical Requirements Checklist (TRC) / Technical Certification Requirements (TCR)) planning and Steamworks/Console SDK integration scope. [ENUM-REF-CANDIDATE: ps5|xbox_series_x|xbox_series_s|pc|switch|ios|android|ps4|xbox_one|vr — promote to reference product]',
    `target_ship_date` DATE COMMENT 'Planned release or ship date for the game title or update produced by this project. Used for milestone planning, first-party certification scheduling, and marketing campaign alignment.',
    `uat_sign_off_date` DATE COMMENT 'Date on which User Acceptance Testing (UAT) was formally signed off by the designated approver, confirming the build meets acceptance criteria prior to first-party certification submission.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this development project record. Used for change tracking, incremental data pipeline processing, and audit compliance.',
    CONSTRAINT pk_dev_project PRIMARY KEY(`dev_project_id`)
) COMMENT 'Master record for each game development project managed within a studio. Tracks project name, associated game title SKU, project type (new IP, sequel, DLC, GaaS live ops update, port), target platforms, development methodology (Agile, Scrum, Kanban), project phase (pre-production, production, alpha, beta, gold master, post-launch), start date, target ship date, and current status. Sourced from Jira project configuration.';

CREATE OR REPLACE TABLE `gaming_ecm`.`studio`.`sprint` (
    `sprint_id` BIGINT COMMENT 'Unique surrogate identifier for each sprint record in the Databricks Silver Layer. Primary key for the sprint data product sourced from Jira sprint management.',
    `cicd_pipeline_id` BIGINT COMMENT 'Identifier of the Continuous Integration/Continuous Deployment (CI/CD) pipeline build associated with this sprints release gate. Links sprint delivery to the automated build and deployment workflow.',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: GaaS sprints deliver content drops as primary deliverable. Sprint planning, velocity tracking, and release coordination require linking sprint work to the content release it produces. Critical for liv',
    `dev_project_id` BIGINT COMMENT 'Identifier of the game development project associated with this sprint. Links the sprint to the broader production pipeline and game title context.',
    `game_studio_id` BIGINT COMMENT 'Identifier of the internal or external development studio responsible for executing this sprint. Supports multi-studio production tracking and resource allocation reporting.',
    `milestone_id` BIGINT COMMENT 'Identifier of the production milestone (e.g., Alpha, Beta, Gold Master, Launch) to which this sprint contributes. Enables milestone-level aggregation of sprint velocity and delivery progress.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Sprint ceremonies and retrospectives require tracking the assigned Scrum Master employee for accountability, capacity planning, and agile methodology compliance. The scrum_master text field denormaliz',
    `added_story_points` STRING COMMENT 'Story points added to the sprint scope after sprint planning commenced (scope creep). Tracks mid-sprint additions that affect velocity accuracy and predictability.',
    `blockers_count` STRING COMMENT 'Number of active impediments or blockers logged against this sprint in Jira. High blocker counts are a leading indicator of sprint failure and are tracked for escalation and retrospective analysis.',
    `board_reference` BIGINT COMMENT 'Identifier of the Jira Scrum board to which this sprint belongs. A board typically maps to a single game development project or studio team.',
    `bug_issues` STRING COMMENT 'Number of Jira issues classified as bugs within the sprint. Tracks QA debt and defect injection rate, which is critical for game quality assurance and release gate readiness.',
    `build_number` STRING COMMENT 'Internal build identifier generated by the CI/CD pipeline for the sprints primary deliverable build. Used to correlate sprint output with QA test executions and release gate assessments.',
    `committed_story_points` STRING COMMENT 'Total story points committed to the sprint at sprint planning. Represents the teams planned velocity and capacity for the sprint. Core input for velocity tracking and capacity planning.',
    `completed_date` DATE COMMENT 'Actual date the sprint was closed or completed in Jira. May differ from end_date when sprints are extended or closed early. Null for active or future sprints.',
    `completed_issues` STRING COMMENT 'Number of Jira issues resolved or closed within the sprint. Used alongside completed_story_points to assess sprint throughput and team delivery rate.',
    `completed_story_points` STRING COMMENT 'Total story points for issues marked as Done by the end of the sprint. Represents actual velocity delivered. Used for sprint-over-sprint velocity trending and team performance analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sprint record was first created in the source system (Jira). Represents the business event time of sprint creation, used for audit trail and data lineage in the Silver Layer.',
    `duration_days` STRING COMMENT 'Planned duration of the sprint in calendar days, derived from the difference between start_date and end_date at sprint creation. Standard sprint durations in game development are typically 7, 14, or 21 days.',
    `end_date` DATE COMMENT 'Planned or actual end date of the sprint (yyyy-MM-dd). Used to determine sprint duration, identify overruns, and align with milestone and release gate schedules.',
    `epic_key` BIGINT COMMENT 'Identifier of the primary Jira Epic associated with this sprint. Supports epic-level rollup of sprint delivery and feature progress tracking across the production backlog.',
    `goal` STRING COMMENT 'Textual description of the primary objective or deliverable targeted for this sprint, as defined by the Scrum team in Jira. Supports retrospective analysis and milestone alignment.',
    `health` STRING COMMENT 'Qualitative health indicator for the sprint as assessed by the Scrum Master or project manager. on_track indicates delivery is proceeding as planned; at_risk indicates potential blockers; off_track indicates significant impediments to goal achievement.. Valid values are `on_track|at_risk|off_track`',
    `incomplete_issues` STRING COMMENT 'Number of Jira issues not completed by sprint end. Carried-over issues impact the next sprints planning and are a key indicator of sprint health and scope management.',
    `is_gaas_sprint` BOOLEAN COMMENT 'Indicates whether this sprint is part of a live operations (GaaS) cadence rather than a pre-launch development cycle. Enables segmentation of live-ops velocity from core development velocity in analytics.',
    `jira_sprint_key` BIGINT COMMENT 'Native sprint identifier assigned by Jira. Used to trace the record back to the operational source system (Jira Software) for reconciliation and lineage purposes.',
    `perforce_changelist` STRING COMMENT 'Perforce Helix Core changelist number representing the code/asset snapshot associated with the sprints final build. Provides version control traceability from sprint delivery to the digital asset management system.',
    `qa_sign_off` BOOLEAN COMMENT 'Indicates whether the Quality Assurance team has formally signed off on the sprint deliverables. A prerequisite for release gate passage and first-party platform certification submission.',
    `release_gate_status` STRING COMMENT 'Status of the CI/CD release gate evaluation for this sprints build. pending means evaluation not yet complete; passed means all criteria met; failed means blocking issues exist; waived means gate bypassed with approval.. Valid values are `pending|passed|failed|waived`',
    `release_version` STRING COMMENT 'Semantic version number of the game build or patch targeted by this sprint (e.g., 1.4.2, 2.0.0.1). Aligns sprint work with the release pipeline and CI/CD deployment gates.. Valid values are `^[0-9]+.[0-9]+.[0-9]+(.[0-9]+)?$`',
    `removed_story_points` STRING COMMENT 'Story points removed from the sprint scope after sprint planning commenced. Tracks descoping decisions that affect velocity accuracy and sprint health.',
    `retrospective_notes` STRING COMMENT 'Free-text summary of key findings, action items, and process improvement decisions captured during the sprint retrospective. Supports continuous improvement tracking and GaaS cadence optimization.',
    `source_system` STRING COMMENT 'Identifies the originating operational system for this sprint record. Primarily jira for Jira Software-sourced records; manual for records entered directly; import for bulk-loaded historical data.. Valid values are `jira|manual|import`',
    `sprint_name` STRING COMMENT 'Human-readable name of the sprint as defined in Jira (e.g., Alpha-Sprint-14, LiveOps-Week-22). Used for display in dashboards, velocity reports, and GaaS cadence tracking.',
    `sprint_number` STRING COMMENT 'Sequential ordinal number of the sprint within its project or board. Enables sprint-over-sprint velocity trending and milestone progression analysis.',
    `sprint_state` STRING COMMENT 'Current lifecycle state of the sprint as reported by Jira. active indicates the sprint is in progress; closed indicates it has been completed; future indicates it is planned but not yet started.. Valid values are `active|closed|future`',
    `sprint_type` STRING COMMENT 'Classification of the sprint by its primary purpose within the game development lifecycle. development covers feature work; live_ops covers GaaS live operations cadence; qa covers Quality Assurance cycles; hardening covers stability and bug-fix sprints; release covers gold master and launch preparation; spike covers research or proof-of-concept work.. Valid values are `development|live_ops|qa|hardening|release|spike`',
    `start_date` DATE COMMENT 'Planned or actual start date of the sprint (yyyy-MM-dd). Used for timeline planning, capacity scheduling, and sprint cadence reporting.',
    `team_capacity_points` STRING COMMENT 'Total story point capacity available to the team for this sprint, accounting for planned absences, holidays, and part-time allocations. Used to assess commitment accuracy and identify over- or under-commitment patterns.',
    `team_size` STRING COMMENT 'Number of active team members participating in this sprint. Supports per-capita velocity normalization and resource allocation analysis across studios.',
    `total_issues` STRING COMMENT 'Total number of Jira issues (stories, tasks, bugs, sub-tasks) included in the sprint at any point. Provides a count-based complement to story-point-based velocity metrics.',
    `uat_sign_off` BOOLEAN COMMENT 'Indicates whether User Acceptance Testing (UAT) has been completed and signed off for this sprints deliverables. Required for release gate approval and production deployment authorization.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the sprint record in the source system (Jira). Used for incremental ETL processing, change detection, and audit compliance in the Databricks Silver Layer.',
    CONSTRAINT pk_sprint PRIMARY KEY(`sprint_id`)
) COMMENT 'Jira-sourced sprint records for each development project. Captures sprint name, sprint number, sprint goal, start date, end date, velocity (story points committed vs. completed), sprint state (active, closed, future), and associated board. Enables sprint-over-sprint velocity tracking and GaaS live ops cadence management.';

CREATE OR REPLACE TABLE `gaming_ecm`.`studio`.`backlog_item` (
    `backlog_item_id` BIGINT COMMENT 'Unique surrogate identifier for the backlog item record in the lakehouse silver layer. Primary key for this entity. Entity role: TRANSACTION_HEADER — represents a discrete development work unit with a clear lifecycle (open → in-progress → done/closed).',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Backlog items created to remediate audit findings. Backlog_item.compliance_flag and compliance_reference suggest this link; direct FK enables tracking finding remediation status through sprint workflo',
    `dev_project_id` BIGINT COMMENT 'Reference to the development project (game title or internal initiative) this backlog item belongs to. Links the work item to its parent project context for sprint velocity and capacity planning.',
    `game_studio_id` BIGINT COMMENT 'Reference to the internal or external development studio responsible for this backlog item. Supports producer capacity planning and cross-studio resource allocation reporting.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Individual Jira tickets reference specific licensed assets (Unreal Engine features, Wwise audio middleware, brand elements) for implementation tracking. Required for sprint planning and compliance ver',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to studio.milestone. Business justification: Backlog items are often tied to specific production milestones (delivery gates). The backlog_item table currently has milestone_name (STRING) but no FK. Adding milestone_id FK allows proper referentia',
    `employee_id` BIGINT COMMENT 'Reference to the team member (developer, artist, designer, QA engineer) currently assigned to work on this backlog item. Maps to PARTY_REFERENCE category for TRANSACTION_HEADER role. Core field for capacity planning and workload distribution.',
    `remediation_action_id` BIGINT COMMENT 'Foreign key linking to compliance.remediation_action. Business justification: Backlog items implement remediation actions from compliance incidents/audits. Compliance_reference field can store remediation_action_id; direct link enables tracking action completion through dev wor',
    `sprint_id` BIGINT COMMENT 'Reference to the active sprint to which this backlog item is assigned. Used for sprint velocity calculation and burn-down tracking. Null if the item is in the product backlog and not yet sprint-committed.',
    `acceptance_criteria` STRING COMMENT 'Structured definition-of-done criteria that must be satisfied for this backlog item to be accepted by the product owner or QA team. Sourced from Jira custom field. Drives UAT sign-off and release gate decisions.',
    `affected_version` STRING COMMENT 'The game build version in which a defect or regression was first observed. Applicable primarily to Bug issue types. Supports root-cause analysis and regression tracking across release branches.',
    `backlog_item_description` STRING COMMENT 'Full narrative description of the backlog item including acceptance criteria, technical notes, and business context. Sourced from the Jira description field; may include references to design documents or Perforce changelists.',
    `blocker_reason` STRING COMMENT 'Free-text description of the impediment or dependency causing this backlog item to be blocked. Populated when is_blocked is True. Used by Scrum Masters and producers to track and resolve impediments.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether this backlog item is associated with a regulatory or platform compliance requirement (e.g., GDPR data handling, COPPA age-gating, ESRB rating descriptor implementation, PCI DSS payment flow, TRC/TCR certification). Compliance-flagged items receive elevated priority and mandatory QA sign-off.',
    `component` STRING COMMENT 'The game system or technical component this backlog item relates to (e.g., Rendering, Networking, UI/UX, Audio, Physics, Monetization, FTUE). Maps to Jira Components field. Enables component-level defect density and velocity analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this backlog item was first created in Jira. Maps to RECORD_AUDIT_CREATED category for TRANSACTION_HEADER role. Used for aging analysis, backlog health metrics, and audit trails.',
    `due_date` DATE COMMENT 'The target completion date for this backlog item as set by the producer or product owner. Used for milestone tracking, release planning, and escalation triggers when items approach or exceed their due date.',
    `environment` STRING COMMENT 'The deployment environment context for this backlog item. Particularly relevant for Bug and Tech Debt items to indicate where the issue was observed or where the fix must be validated before promotion to production/live.. Valid values are `Development|Staging|QA|Production|Live`',
    `epic_key` BIGINT COMMENT 'Reference to the parent epic that groups this backlog item under a larger feature or initiative. Enables roll-up reporting of story points and progress at the epic level.',
    `fix_version` STRING COMMENT 'The game build version or release milestone in which this backlog item is targeted to be delivered (e.g., 1.4.0, Season 3 Patch). Used for release planning, version-level burn-down, and first-party certification submission tracking.',
    `gaas_live_ops_flag` BOOLEAN COMMENT 'Indicates whether this backlog item is part of the GaaS live operations cadence (e.g., seasonal content update, live event, hotfix, balance patch). GaaS-flagged items follow an expedited review and deployment pipeline distinct from standard release cycles.',
    `is_blocked` BOOLEAN COMMENT 'Indicates whether this backlog item is currently blocked by a dependency, external factor, or unresolved impediment. Blocked items are escalated in daily stand-ups and producer dashboards to prevent sprint velocity degradation.',
    `is_regression` BOOLEAN COMMENT 'Indicates whether this Bug backlog item represents a regression — a defect that was previously fixed and has reappeared. Regression tracking is critical for release quality metrics and CI/CD gate enforcement.',
    `issue_key` STRING COMMENT 'The externally-known Jira issue key (e.g., GAME-1234) that uniquely identifies this backlog item within the project. Used by developers, producers, and QA to reference work items across tools and communications. Maps to BUSINESS_IDENTIFIER category for TRANSACTION_HEADER role.. Valid values are `^[A-Z][A-Z0-9]+-[0-9]+$`',
    `issue_type` STRING COMMENT 'Classification of the work item within the Agile/Scrum taxonomy. Drives workflow routing, estimation norms, and reporting segmentation. In Kanban or waterfall studios this maps to the equivalent work unit type (ticket, task, work order). [ENUM-REF-CANDIDATE: Epic|Story|Task|Sub-task|Bug|Spike|Tech Debt|Change Request|Improvement — promote to reference product]',
    `jira_issue_key` STRING COMMENT 'The internal numeric identifier assigned by Jira to this issue (distinct from the human-readable issue_key). Used for API-level integration, webhook event correlation, and bidirectional sync between Jira and the lakehouse.',
    `labels` STRING COMMENT 'Comma-separated free-text labels applied to the backlog item for cross-cutting classification (e.g., GaaS, MTX, GDPR, TRC, performance, accessibility). Sourced from Jira Labels field. Supports ad-hoc filtering and compliance tagging.',
    `original_estimate_hours` DECIMAL(18,2) COMMENT 'Initial time estimate in hours logged in Jira at the time of issue creation or sprint planning. Used alongside story points for studios that track both relative and absolute effort estimates.',
    `perforce_changelist` STRING COMMENT 'The Perforce Helix Core changelist number(s) linked to this backlog item for code traceability. Enables bidirectional traceability between Jira work items and version-controlled source code changes. May contain multiple changelist references as a comma-separated string.',
    `platform_target` STRING COMMENT 'The deployment platform(s) this backlog item is scoped to. Drives platform-specific QA routing, TRC/TCR compliance checks, and first-party certification workflows. [ENUM-REF-CANDIDATE: PC|Console|Mobile|Cross-Platform|VR/AR|Cloud — promote to reference product]. Valid values are `PC|Console|Mobile|Cross-Platform|VR/AR`',
    `priority` STRING COMMENT 'Business and technical priority of the backlog item as set by the product owner or producer. Blocker and Critical items trigger escalation workflows and may gate sprint completion or release sign-off.. Valid values are `Blocker|Critical|Major|Minor|Trivial`',
    `qa_sign_off_date` DATE COMMENT 'The date on which the QA team formally signed off on this backlog item as meeting acceptance criteria. Required for release gate passage and first-party certification submission. Null if QA sign-off has not yet occurred.',
    `resolution` STRING COMMENT 'The outcome recorded when a backlog item is closed or resolved. Distinguishes genuinely completed work from items closed for other reasons (duplicate, out of scope, cannot reproduce). Critical for QA defect metrics and release quality reporting.. Valid values are `Fixed|Wont Fix|Duplicate|Cannot Reproduce|Done|Invalid`',
    `resolved_timestamp` TIMESTAMP COMMENT 'The date and time when this backlog item transitioned to a resolved or done state. Maps to BUSINESS_EVENT_TIMESTAMP category for TRANSACTION_HEADER role. Used to calculate cycle time, lead time, and sprint velocity metrics.',
    `source_system` STRING COMMENT 'Identifies the originating system from which this backlog item record was ingested into the lakehouse. Primarily Jira for standard Agile studios; may be Manual for waterfall studios or Migration for legacy project management system imports.. Valid values are `Jira|Manual|Migration|External`',
    `sprint_committed_date` DATE COMMENT 'The date on which this backlog item was committed to a sprint during sprint planning. Distinguishes items that were planned from the start of the sprint versus those added mid-sprint (scope creep indicator).',
    `started_timestamp` TIMESTAMP COMMENT 'The date and time when work on this backlog item was first started (transitioned to In Progress). Used to calculate cycle time (started to resolved) distinct from lead time (created to resolved). Key metric for flow efficiency analysis.',
    `story_points` STRING COMMENT 'Relative effort estimate assigned to this backlog item using the Fibonacci or T-shirt sizing scale. Core input for sprint velocity calculation and producer capacity planning. Null for items not yet estimated (e.g., items in the icebox).',
    `summary` STRING COMMENT 'Short, human-readable title of the backlog item as entered in Jira (e.g., Implement loot box drop-rate display per ESRB guidelines). The primary label used in sprint boards, backlogs, and producer dashboards.',
    `time_spent_hours` DECIMAL(18,2) COMMENT 'Actual hours logged against this backlog item via Jira work logs. Compared against original_estimate_hours to measure estimation accuracy and identify scope creep. Feeds into SAP S/4HANA project cost accounting.',
    `uat_sign_off_date` DATE COMMENT 'The date on which the product owner or designated stakeholder completed UAT and formally accepted this backlog item. Distinct from QA sign-off; represents business acceptance rather than technical verification.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this backlog item was last modified in Jira. Maps to RECORD_AUDIT_UPDATED category for TRANSACTION_HEADER role. Used for change detection in ETL pipelines and audit compliance.',
    `workflow_status` STRING COMMENT 'Current state of the backlog item in its Jira workflow lifecycle. Maps to LIFECYCLE_STATUS category for TRANSACTION_HEADER role. Drives sprint burn-down charts, release readiness gates, and CI/CD pipeline triggers. [ENUM-REF-CANDIDATE: Backlog|To Do|In Progress|In Review|QA|Done|Closed|Cancelled|Blocked — promote to reference product]',
    CONSTRAINT pk_backlog_item PRIMARY KEY(`backlog_item_id`)
) COMMENT 'Jira-sourced work items (epics, stories, tasks, sub-tasks, bugs, spikes, tech debt items) for each development project. Captures issue key, issue type, summary, priority, story points, assignee, reporter, sprint assignment, epic link, fix version, labels, component, resolution, and workflow status. Linked to changelists for code traceability. Core operational entity for tracking all development work, sprint velocity calculation, and producer capacity planning. Note: product name uses Agile/Scrum terminology; in Kanban or waterfall studios this entity represents the equivalent work unit (ticket, task, work order).';

CREATE OR REPLACE TABLE `gaming_ecm`.`studio`.`milestone` (
    `milestone_id` BIGINT COMMENT 'Unique surrogate identifier for the production milestone record in the studio domain. Primary key for the milestone data product.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Milestones gate on age rating cert approval (e.g., cert submission/approval dates). Direct link enables tracking which cert blocked/cleared which milestone, critical for ship schedule management.',
    `dev_project_id` BIGINT COMMENT 'Reference to the game development project this milestone belongs to. Links the milestone to its parent production project.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Milestones have dedicated budget allocations and trigger milestone payments. Required for budget consumption tracking, variance analysis, and publisher payment processing in development contracts.',
    `game_studio_id` BIGINT COMMENT 'Reference to the internal or external development studio responsible for delivering this milestone.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title associated with this production milestone, enabling cross-domain reporting between studio and game title domains.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Milestones trigger IP compliance checkpoints (rating submissions, DRM integration, content approval) and royalty payment events specified in licensing agreements. Critical for greenlight gates and pub',
    `marketing_campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Marketing campaigns are synchronized with development milestones (alpha, beta, launch). Real business process: coordinated go-to-market planning where campaign timing and creative production depend on',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Milestone approval workflows require tracking which employee is accountable for sign-off to enforce greenlight gates, publisher deliverables, and certification submissions. The sign_off_owner text fie',
    `actual_date` DATE COMMENT 'The actual calendar date on which the milestone was achieved and accepted. Null if the milestone has not yet been completed. Used to calculate schedule variance against planned and revised dates.',
    `blocker_count` STRING COMMENT 'The number of open blocking issues (P0/P1 bugs or critical dependencies) preventing milestone completion at the time of last update. Sourced from Jira bug tracking. A non-zero value typically prevents sign-off and triggers escalation.',
    `build_version` STRING COMMENT 'The game build version number or label associated with the milestone submission (e.g., 1.0.0.4521). Sourced from the CI/CD pipeline or Perforce Helix Core version control. Critical for first-party submission and QA traceability.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this milestone record was first created in the system, sourced from Jira or the studio production management tool. Used for audit trail and data lineage tracking.',
    `critical_bug_count` STRING COMMENT 'The number of critical severity (P1) defects open against this milestone at the time of last update, as tracked in Jira. Distinct from blocker_count which captures only hard-blocking issues. Used for QA readiness assessment.',
    `deliverables_checklist_url` STRING COMMENT 'URL or deep-link reference to the associated deliverables checklist document for this milestone (e.g., a Confluence page, Shotgrid task list, or Jira epic). Captures the list of required artifacts and acceptance criteria for milestone completion.',
    `deliverables_completed` STRING COMMENT 'The number of deliverable items in the milestone checklist that have been completed and accepted at the time of last update. Used with deliverables_total for progress tracking.',
    `deliverables_total` STRING COMMENT 'The total number of discrete deliverable items defined in the milestone checklist. Used alongside deliverables_completed to calculate completion percentage for progress reporting.',
    `epic_key` STRING COMMENT 'The Jira epic identifier grouping the feature work associated with this milestone. Enables traceability from milestone to epic-level scope in the Jira backlog.',
    `is_greenlight_gate` BOOLEAN COMMENT 'Boolean flag indicating whether this milestone serves as a greenlight decision point requiring executive or publisher approval to proceed to the next production phase. Greenlight gates are critical for go/no-go decisions.',
    `is_publisher_facing` BOOLEAN COMMENT 'Boolean flag indicating whether this milestone is a contractual publisher-facing delivery gate (True) or an internal studio milestone (False). Publisher-facing milestones trigger formal reporting and may have contractual payment implications.',
    `is_signed_off` BOOLEAN COMMENT 'Boolean flag indicating whether the milestone has received formal sign-off approval. True when sign-off is complete; False when pending. Enables quick filtering for release gate dashboards.',
    `jira_release_key` STRING COMMENT 'The externally-known Jira release or version identifier corresponding to this milestone (e.g., the Jira Fix Version ID). Serves as the business identifier linking this record to the source system of record.',
    `milestone_description` STRING COMMENT 'Free-text description of the milestone scope, acceptance criteria, and key deliverables as defined in the production plan. Provides context for publisher reporting and greenlight decision-making.',
    `milestone_name` STRING COMMENT 'Human-readable name of the production milestone as defined in the studio production plan or Jira release (e.g., Alpha Build, Gold Master, First Playable). Serves as the primary identity label for the milestone.',
    `milestone_status` STRING COMMENT 'Current lifecycle state of the milestone within the production workflow. Tracks progression from not started through in-progress, at-risk, missed, completed, and final sign-off. Used for release planning dashboards and publisher reporting.. Valid values are `not_started|in_progress|at_risk|missed|completed|signed_off`',
    `milestone_type` STRING COMMENT 'Categorical classification of the milestone representing its role in the game development lifecycle delivery gate. Standard types include concept approval, pre-production sign-off, vertical slice, first playable, alpha, beta, content complete, gold master (GM), and first-party submission. [ENUM-REF-CANDIDATE: concept_approval|pre_production|vertical_slice|first_playable|alpha|beta|content_complete|gold_master|first_party_submission — promote to reference product]',
    `open_issue_count` STRING COMMENT 'Total number of open Jira issues (across all severities) associated with this milestone at the time of last update. Provides a broad health indicator for milestone readiness.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The contractual payment amount due from the publisher upon successful sign-off of this milestone, if applicable. Sourced from the publishing agreement. Null for internal milestones with no associated payment trigger.',
    `perforce_changelist` STRING COMMENT 'The Perforce Helix Core changelist number representing the code and asset snapshot submitted for this milestone. Provides version control traceability for the milestone build.',
    `phase` STRING COMMENT 'The high-level production phase to which this milestone belongs. Segments milestones into pre-production, production, post-production, and live operations (GaaS) phases for portfolio-level reporting.. Valid values are `pre_production|production|post_production|live_ops`',
    `planned_date` DATE COMMENT 'The originally scheduled calendar date by which this milestone was planned to be achieved, as defined in the production schedule. Used for schedule variance analysis and publisher reporting.',
    `platform_target` STRING COMMENT 'The target gaming platform(s) for which this milestone applies (e.g., PS5, Xbox Series X, PC, iOS, Android, Nintendo Switch). Relevant for first-party submission milestones where platform-specific Technical Requirements Checklist (TRC) compliance is required.',
    `qa_sign_off_status` STRING COMMENT 'The Quality Assurance (QA) teams sign-off status for this milestone, indicating whether the build has passed QA acceptance criteria. Distinct from the overall milestone sign-off which may involve additional stakeholders.. Valid values are `pending|in_review|approved|rejected`',
    `revised_date` DATE COMMENT 'The most recently revised target date for milestone completion, reflecting any approved schedule changes or re-planning events. Distinct from the original planned date to support schedule slip tracking.',
    `risk_level` STRING COMMENT 'The assessed risk level for on-time delivery of this milestone, as evaluated by the production team. Used for escalation management and executive reporting.. Valid values are `low|medium|high|critical`',
    `risk_notes` STRING COMMENT 'Free-text field capturing the primary risk factors or blockers threatening on-time milestone delivery. Populated by the production manager or project lead during milestone reviews.',
    `schedule_variance_days` STRING COMMENT 'The number of calendar days by which the actual completion date deviated from the planned date. Positive values indicate lateness; negative values indicate early delivery. Sourced from production management tooling and used for publisher reporting and greenlight decisions.',
    `sign_off_timestamp` TIMESTAMP COMMENT 'The precise date and time at which the milestone received formal sign-off approval from the designated owner. Null if sign-off has not yet occurred. Critical for publisher reporting and contractual compliance.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this milestone record was sourced (e.g., Jira, Shotgrid, Productive, or manually entered). Supports data lineage and ETL audit requirements in the Databricks Silver layer.. Valid values are `jira|shotgrid|productive|manual`',
    `trc_compliance_status` STRING COMMENT 'The compliance status of this milestone against the first-party platform Technical Requirements Checklist (TRC) or Technical Certification Requirements (TCR). Applicable primarily to first-party submission milestones for console platforms.. Valid values are `not_applicable|pending|in_review|passed|failed|waived`',
    `uat_status` STRING COMMENT 'The User Acceptance Testing (UAT) status for this milestone, reflecting whether the build has been validated by the publisher or internal stakeholders against acceptance criteria. UAT sign-off is typically required before milestone payment release.. Valid values are `not_started|in_progress|passed|failed`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this milestone record was most recently modified, sourced from Jira or the studio production management tool. Used for incremental data loading and change tracking in the Silver layer.',
    CONSTRAINT pk_milestone PRIMARY KEY(`milestone_id`)
) COMMENT 'Production milestone records for a development project, representing major delivery gates such as concept approval, pre-production sign-off, vertical slice, first playable, alpha, beta, content complete, gold master (GM), and first-party submission. Captures milestone name, milestone type, planned date, actual date, completion status, sign-off owner, associated deliverables checklist, and blocker count. Sourced from Jira release planning or studio production management tools (Shotgrid/Productive). Critical for release planning, publisher reporting, and greenlight decision-making.';

CREATE OR REPLACE TABLE `gaming_ecm`.`studio`.`build` (
    `build_id` BIGINT COMMENT 'Unique surrogate identifier for each game build record generated by the CI/CD pipeline. Primary key for the build data product.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Builds submitted for platform certification must reference the age rating cert. Build.certification_status and content_rating denormalize cert data; direct link enables cert-gated build promotion work',
    `asset_bundle_id` BIGINT COMMENT 'Foreign key linking to content.asset_bundle. Business justification: Builds package specific asset bundles into distributable artifacts. Build composition tracking, platform certification documentation, and rollback procedures require direct linkage to bundled content.',
    `build_submission_id` BIGINT COMMENT 'The external submission identifier assigned by the platform holder (e.g., Sony, Microsoft, Nintendo, Apple, Google) when this build was submitted for certification review. Enables tracking of the build through the first-party certification pipeline.',
    `changelist_id` BIGINT COMMENT 'Foreign key linking to studio.changelist. Business justification: Builds are triggered by specific Perforce changelists. The build table has changelist_number (BIGINT) but no FK to changelist. Adding changelist_id FK provides proper referential integrity and removes',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Builds are generated for specific development projects. The build table has game_title_id and studio_id but no direct FK to dev_project. Adding dev_project_id FK provides proper referential integrity ',
    `employee_id` BIGINT COMMENT 'Reference to the engineer or automated service account that initiated this build in the CI/CD pipeline. Supports build provenance and accountability tracking.',
    `game_server_id` BIGINT COMMENT 'Foreign key linking to infrastructure.game_server. Business justification: Builds are deployed to specific game servers for testing and production. Fundamental for version tracking, rollback operations, and incident investigation. Operations teams need to know which build ru',
    `game_studio_id` BIGINT COMMENT 'Reference to the development studio responsible for producing this build. Supports multi-studio and co-development scenarios.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this build belongs to. Links the build record to the specific game product being compiled and packaged.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Builds must track which IP agreements govern included licensed content (middleware, music, brands) for platform certification (TRC/TCR compliance) and distribution rights verification before submissio',
    `milestone_id` BIGINT COMMENT 'Reference to the project milestone or sprint this build is associated with in the project management system (Jira). Links build provenance to the production schedule and release gate framework.',
    `repo_id` BIGINT COMMENT 'Foreign key linking to studio.repo. Business justification: Builds are generated from code in a specific Perforce repository. The build table does not have a repo_id FK. Adding repo_id FK provides proper referential integrity. No columns to remove - branch_nam',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Builds are deployed to server fleets for live operations. Core deployment tracking relationship required for fleet version management, rollback procedures, and capacity planning in multiplayer gaming ',
    `agent` STRING COMMENT 'Identifier of the build farm agent or machine that executed this build (e.g., build-agent-ps5-03). Used for build farm health monitoring, agent utilization analysis, and diagnosing machine-specific build failures.',
    `artifact_size_mb` DECIMAL(18,2) COMMENT 'Total size of the build artifact package in megabytes. Used to monitor build bloat, enforce platform submission size limits (e.g., console disc capacity, mobile store limits), and track storage consumption trends.',
    `artifact_storage_path` STRING COMMENT 'Fully qualified path or URI to the build artifact package in the artifact repository or cloud storage (e.g., s3://builds-bucket/game-title/2.4.1/ps5/shipping/). Used by QA, release engineering, and platform submission workflows to locate the build package.',
    `branch_name` STRING COMMENT 'Name of the Perforce Helix Core stream or branch from which this build was compiled (e.g., main, release/2.4, feature/new-map). Critical for build provenance, hotfix tracking, and release gate validation.',
    `build_number` BIGINT COMMENT 'Monotonically incrementing integer build number assigned by the CI/CD system (e.g., Jenkins, TeamCity, or Unreal Build Tool). Used as the externally-known sequential identifier for this build within the pipeline.',
    `build_status` STRING COMMENT 'Current lifecycle state of the build as reported by the CI/CD pipeline. success indicates all compilation, linking, and packaging steps completed without error; failed indicates a pipeline error; in_progress indicates an active run; cancelled indicates a user-aborted run; queued indicates the build is pending execution.. Valid values are `success|failed|in_progress|cancelled|queued`',
    `build_type` STRING COMMENT 'Classification of the build configuration controlling compiler optimizations, logging verbosity, and feature flags. debug includes full symbols and assertions; development enables profiling and console commands; shipping is the production-optimized release candidate; test is used for automated QA pipelines.. Valid values are `debug|development|shipping|test`',
    `completed_timestamp` TIMESTAMP COMMENT 'The exact date and time (UTC) when the build pipeline run reached a terminal state (success, failed, or cancelled). Used for build duration calculation, SLA compliance, and release gate scheduling.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) when this build record was first inserted into the data platform. Audit trail field for data lineage and Silver layer ingestion tracking.',
    `dlc_identifier` STRING COMMENT 'Identifier of the specific DLC or content pack this build packages, if applicable. Null for base game builds. Enables tracking of DLC build pipelines separately from the base game build pipeline.',
    `duration_seconds` STRING COMMENT 'Total elapsed time in seconds from build trigger to pipeline completion (success or failure). Key operational metric for CI/CD performance monitoring, build farm capacity planning, and developer productivity analysis.',
    `engine_type` STRING COMMENT 'The game engine used to compile this build. Determines the toolchain, build configuration options, and platform support matrix applicable to this build.. Valid values are `Unity|Unreal|Custom|Godot|CryEngine`',
    `engine_version` STRING COMMENT 'The specific version of the game engine used to produce this build (e.g., 5.3.2 for Unreal Engine 5.3.2 or 2022.3.10f1 for Unity). Critical for reproducing builds, diagnosing engine-specific bugs, and managing engine upgrade cycles.. Valid values are `^d+.d+(.d+)?(.d+)?$`',
    `error_count` STRING COMMENT 'Total number of compiler or linker errors reported during this build run. A non-zero value on a failed build provides a quantitative signal for build health dashboards and trend analysis.',
    `failure_message` STRING COMMENT 'A concise summary of the primary error or failure reason reported by the CI/CD pipeline for a failed build. Null for successful builds. Supports rapid triage by build engineers without requiring access to full pipeline logs.',
    `failure_stage` STRING COMMENT 'The pipeline stage at which this build failed, if applicable (e.g., compile, link, package, cook, sign, upload, test, deploy). Null for successful builds. Enables root-cause categorization of build failures for engineering productivity analysis. [ENUM-REF-CANDIDATE: compile|link|package|cook|sign|upload|test|deploy — 8 candidates stripped; promote to reference product]',
    `gaas_live_update` BOOLEAN COMMENT 'Indicates whether this build is a live operations update (patch, hotfix, content drop) for a GaaS title rather than a full game build. Distinguishes live service cadence builds from full release builds for operational reporting.',
    `is_automated_trigger` BOOLEAN COMMENT 'Indicates whether this build was triggered automatically by the CI/CD system (e.g., on Perforce changelist submit, scheduled nightly build) as opposed to being manually triggered by a user. Supports build frequency analysis and pipeline automation coverage metrics.',
    `is_gold_master` BOOLEAN COMMENT 'Indicates whether this build has been designated as the Gold Master (GM) — the final approved build submitted to platform holders for manufacturing or digital distribution. A True value signifies this build passed all TRC/TCR certification requirements and received internal sign-off.',
    `is_release_candidate` BOOLEAN COMMENT 'Indicates whether this build has been promoted to Release Candidate status, meaning it is a candidate for Gold Master designation pending final QA sign-off and platform certification. Distinct from Gold Master — an RC may still fail certification.',
    `jira_release_version` STRING COMMENT 'The Jira fix version or release label associated with this build (e.g., v2.4.0-RC1). Enables traceability between build artifacts and the set of Jira issues resolved in this release.',
    `notes` STRING COMMENT 'Free-text notes or annotations added by the build engineer or release manager regarding this build (e.g., known issues, special packaging instructions, waiver justifications). Supports release communication and audit trail.',
    `pipeline_job_name` STRING COMMENT 'Name of the CI/CD pipeline job or workflow definition that produced this build (e.g., nightly-shipping-ps5, pr-validation-pc). Enables filtering and aggregation of build metrics by pipeline configuration.',
    `pipeline_run_reference` STRING COMMENT 'External identifier of the specific pipeline execution run in the CI/CD system (e.g., Jenkins build ID, TeamCity build ID). Enables deep-linking back to the originating pipeline run for log retrieval and debugging.',
    `queued_duration_seconds` STRING COMMENT 'Time in seconds the build spent waiting in the CI/CD queue before execution began. Distinguishes queue wait time from active compilation time for build farm capacity analysis.',
    `release_gate_status` STRING COMMENT 'The outcome of the release gate evaluation for this build. pending means gate checks are in progress; passed means all automated and manual gate criteria were met; failed means one or more criteria were not met; waived means a gate failure was formally overridden by an authorized approver. SSOT for CI/CD release gate tracking.. Valid values are `pending|passed|failed|waived`',
    `sdk_version` STRING COMMENT 'The version of the platform SDK used to compile this build (e.g., PS5 SDK 5.00, GDK 221000). Required for platform certification compliance and for diagnosing SDK-specific compatibility issues.',
    `started_timestamp` TIMESTAMP COMMENT 'The exact date and time (UTC) when the build agent began executing the pipeline steps, after any queue wait. Distinct from triggered_timestamp; used to calculate queue wait time and active build duration.',
    `target_platform` STRING COMMENT 'The hardware or software platform this build was compiled and packaged for (e.g., PS5, XboxSeriesX, PC_Win64, iOS, Android, Switch). Determines platform-specific SDK toolchain, certification requirements, and distribution channel. [ENUM-REF-CANDIDATE: PS5|XboxSeriesX|PC_Win64|iOS|Android|Switch|PC_Win32|MacOS|Linux|PS4|XboxOne|Stadia — promote to reference product]',
    `triggered_timestamp` TIMESTAMP COMMENT 'The exact date and time (UTC) when the build was triggered in the CI/CD pipeline. The principal business event timestamp for this build record, used for build frequency analysis, release cadence reporting, and SLA tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) when this build record was last modified in the data platform (e.g., status update from in_progress to success). Supports incremental ETL processing and change data capture.',
    `version_string` STRING COMMENT 'Human-readable semantic version string for this build (e.g., 2.4.1.18342 or 1.0.0-rc.3). Used in release notes, platform submission packages, and player-facing version displays.. Valid values are `^d+.d+.d+(.d+)?(-[a-zA-Z0-9._-]+)?$`',
    `warning_count` STRING COMMENT 'Total number of compiler or linker warnings reported during this build run. Tracked separately from errors to monitor code quality degradation trends and enforce warning-as-error policies.',
    CONSTRAINT pk_build PRIMARY KEY(`build_id`)
) COMMENT 'Game build records generated by the CI/CD pipeline (Unity/Unreal Engine build system integrated with Perforce). Captures build number, build version string, target platform, build type (debug, development, shipping), branch name, changelist number, build status (success, failed, in-progress), build duration, artifact storage path, and triggered-by user. SSOT for build provenance and release gate tracking.';

CREATE OR REPLACE TABLE `gaming_ecm`.`studio`.`repo` (
    `repo_id` BIGINT COMMENT 'Unique surrogate identifier for the Perforce Helix Core depot (repository) record in the Silver Layer lakehouse. Primary key for the studio.repo data product.',
    `cicd_pipeline_id` BIGINT COMMENT 'Foreign key linking to infrastructure.cicd_pipeline. Business justification: Repos are built by CI/CD pipelines. Completes the build chain (repo→pipeline→fleet). Essential for automated build tracking, source-to-deployment traceability, and DevOps workflow management.',
    `dev_project_id` BIGINT COMMENT 'Reference to the game development project (Jira project / production title) that this depot primarily serves.',
    `game_studio_id` BIGINT COMMENT 'Reference to the internal or external development studio that owns and administers this Perforce depot.',
    `access_control_tier` STRING COMMENT 'Data classification and access control level applied to this depot. public allows broad read access; internal restricts to all studio employees; restricted limits to project team members only; confidential applies to IP-sensitive or pre-announcement titles requiring NDA-level access.. Valid values are `public|internal|restricted|confidential`',
    `active_workspace_count` STRING COMMENT 'Number of currently active Perforce client workspaces (p4 clients) mapped to this depot. Indicates the size of the active development team and server load contribution.',
    `archived_date` DATE COMMENT 'The date on which this depot was transitioned to archived (read-only) status following project completion or title ship. Null for active depots. Used for storage lifecycle and cost management.',
    `backup_policy` STRING COMMENT 'The backup frequency policy applied to this depots data. Determines recovery point objective (RPO) for disaster recovery. continuous applies to commit servers with journal replication; daily and hourly apply to checkpoint-based backups.. Valid values are `daily|hourly|weekly|continuous|none`',
    `branch_count` STRING COMMENT 'Total number of active streams or branches currently configured in this depot. High branch counts may indicate complex release management or technical debt requiring stream consolidation.',
    `build_system` STRING COMMENT 'The CI/CD build automation system integrated with this depot for automated compilation, packaging, and deployment of game builds. Determines the toolchain for build pipeline management. [ENUM-REF-CANDIDATE: Jenkins|TeamCity|Buildkite|GitHub Actions|Azure DevOps|Custom|None — 7 candidates stripped; promote to reference product]',
    `changelist_count` BIGINT COMMENT 'Total number of submitted changelists in this depot. A changelist in Perforce is the atomic unit of work (equivalent to a commit), and this count reflects overall development activity volume.',
    `ci_cd_pipeline_enabled` BOOLEAN COMMENT 'Indicates whether a Continuous Integration/Continuous Deployment (CI/CD) pipeline is actively configured and running against this depots mainline stream. Enables automated build, test, and release gate enforcement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this depot record was first created in the Silver Layer lakehouse data product. Supports data lineage, audit trail, and ETL pipeline monitoring.',
    `depot_description` STRING COMMENT 'Free-text business description of the depots purpose, scope, and contents (e.g., Main source depot for Project Titan — PC and console builds including all engine customizations).',
    `depot_name` STRING COMMENT 'The canonical Perforce depot name as it appears in the server, prefixed with // per Helix Core naming conventions (e.g., //GameTitle_Main). Acts as the human-readable business identifier for the repository.. Valid values are `^//[A-Za-z0-9_-.]+$`',
    `depot_type` STRING COMMENT 'Perforce depot storage type that determines how files are stored and accessed. local stores files on the server filesystem; stream enables stream-based branching topology; remote proxies to another Perforce server; spec stores form specifications; archive holds archived revisions; unload holds unloaded workspaces/labels; graph stores Git-compatible repos. [ENUM-REF-CANDIDATE: local|stream|remote|spec|archive|unload|graph — promote to reference product]',
    `exclusive_checkout_enabled` BOOLEAN COMMENT 'Indicates whether exclusive file locking (exclusive checkout) is enforced for binary assets in this depot, preventing simultaneous edits to non-mergeable files such as art assets, audio files, and level files.',
    `file_count` BIGINT COMMENT 'Total number of files (all revisions, all streams) currently tracked in this depot. Indicates depot complexity and is used for performance benchmarking and migration planning.',
    `gaas_live_ops_enabled` BOOLEAN COMMENT 'Indicates whether this depot supports a live Game-as-a-Service (GaaS) title requiring continuous live operations (live ops) delivery cadence, including hotfix branches, content update streams, and rapid patch deployment pipelines.',
    `game_engine` STRING COMMENT 'Primary game engine used in the project associated with this depot. Determines asset pipeline conventions, binary file handling requirements (e.g., LFS-equivalent for large assets), and build system integration patterns.. Valid values are `Unreal Engine|Unity|Custom|Godot|CryEngine|Other`',
    `gdpr_applicable` BOOLEAN COMMENT 'Indicates whether this depot may contain personal data subject to GDPR obligations (e.g., developer PII in commit metadata, playtester feedback files). Triggers data protection impact assessment (DPIA) requirements.',
    `gold_master_branch` STRING COMMENT 'The stream or branch path designated as the Gold Master (GM) release candidate branch for this depot (e.g., //GameTitle_Main/release/gm). The Gold Master is the final approved build submitted for first-party certification.',
    `ip_classification` STRING COMMENT 'Classification of the intellectual property (IP) contained in this depot. core_ip covers proprietary game engine and title source; licensed_ip covers content under third-party IP licenses; third_party covers externally sourced middleware; tools and pipeline cover internal tooling. Drives access control and legal review requirements. [ENUM-REF-CANDIDATE: core_ip|licensed_ip|third_party|middleware|tools|pipeline|none — promote to reference product]',
    `jira_project_key` STRING COMMENT 'The Jira project key associated with this depot, enabling traceability between Perforce changelists and Jira issues (epics, stories, bugs). Supports sprint velocity reporting and release planning.. Valid values are `^[A-Z][A-Z0-9]{1,9}$`',
    `last_submit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent changelist submission to this depot. Indicates recency of active development; depots with no recent submissions may be candidates for archival.',
    `last_sync_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent successful synchronization event recorded for this depot (either a client sync or a replication sync). Used to detect stale depots and validate CI/CD pipeline freshness.',
    `lfs_enabled` BOOLEAN COMMENT 'Indicates whether Perforce Large File System (LFS) or equivalent binary asset management is enabled for this depot. Critical for game development depots containing large binary assets (textures, audio, video, compiled shaders).',
    `mainline_stream_path` STRING COMMENT 'The depot-relative path of the mainline (trunk) stream, which is the authoritative integration target for all development work (e.g., //GameTitle_Main/mainline). Null for non-stream depots.',
    `obliterate_protection` BOOLEAN COMMENT 'Indicates whether the depot is protected against the p4 obliterate command, which permanently deletes file history. Enabled for depots containing IP-critical or compliance-relevant source history.',
    `provisioned_date` DATE COMMENT 'The calendar date on which this Perforce depot was initially provisioned and made available to the development team. Used for depot age analysis and lifecycle management.',
    `replication_role` STRING COMMENT 'The role of the server hosting this depot within the Perforce replication topology. commit is the authoritative write server; edge is a distributed edge server for remote studios; replica is a read-only mirror; standby is a failover replica; none applies to standalone servers.. Valid values are `commit|edge|replica|standby|none`',
    `repo_status` STRING COMMENT 'Current lifecycle state of the Perforce depot. active indicates ongoing development use; archived means the project is complete and the depot is read-only; deprecated marks depots scheduled for deletion; suspended indicates temporarily locked depots; initializing covers newly provisioned depots being configured.. Valid values are `active|archived|deprecated|suspended|initializing`',
    `retention_policy_years` STRING COMMENT 'Number of years that file history and changelists in this depot must be retained per the studios data governance and IP protection policy. Informs archival scheduling and storage cost forecasting.',
    `revision_count` BIGINT COMMENT 'Total number of file revisions stored across all files in this depot. High revision counts indicate long-lived, active depots and affect server performance and backup duration.',
    `root_path` STRING COMMENT 'Server-side filesystem root path where the depots files are physically stored on the Perforce server (e.g., /perforce/depots/GameTitle_Main). Critical for storage management and disaster recovery planning.',
    `server_address` STRING COMMENT 'Network address (host:port) of the Perforce server hosting this depot (e.g., ssl:p4.studio.gaming.com:1666). Required for client workspace configuration and CI/CD pipeline connectivity.',
    `server_reference` STRING COMMENT 'Identifier of the Perforce Helix Core server instance hosting this depot (e.g., p4-studio-us-east-01). Supports multi-server topologies including edge servers, replicas, and commit servers.',
    `source_system_depot_reference` STRING COMMENT 'The native depot identifier as assigned by the Perforce Helix Core server (typically the depot name without // prefix or the internal depot counter value). Enables reconciliation between the lakehouse Silver Layer record and the operational Perforce system of record.',
    `storage_quota_gb` DECIMAL(18,2) COMMENT 'Maximum allocated storage capacity for this depot in gigabytes, as provisioned by the infrastructure team. Used for capacity planning and chargeback to the owning studio or project.',
    `storage_used_gb` DECIMAL(18,2) COMMENT 'Current actual storage consumed by this depot in gigabytes, as reported by the Perforce server at the last sync. Enables quota utilization monitoring and proactive capacity management.',
    `stream_structure` STRING COMMENT 'Describes the branching/stream topology configured for this depot. mainline_only has a single trunk; mainline_release adds release branches; mainline_dev_release includes dev, mainline, and release streams; full_hierarchy includes feature, dev, mainline, release, and hotfix streams; none applies to non-stream depots.. Valid values are `mainline_only|mainline_release|mainline_dev_release|full_hierarchy|none`',
    `target_platforms` STRING COMMENT 'Comma-separated list of target distribution platforms for the project in this depot (e.g., PC,PS5,XboxSeriesX,Switch,iOS,Android). Informs platform-specific branch requirements and first-party certification (TRC/TCR) workflows.',
    `typemap_applied` BOOLEAN COMMENT 'Indicates whether a Perforce typemap (file type mapping configuration) has been applied to this depot to correctly handle binary vs. text files, exclusive checkout locks, and compression settings for game assets.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this depot record in the Silver Layer lakehouse. Used for incremental ETL processing, change detection, and data freshness monitoring.',
    CONSTRAINT pk_repo PRIMARY KEY(`repo_id`)
) COMMENT 'Perforce Helix Core repository (depot) master records for each project. Captures depot name, depot type (local, stream, remote), root path, associated project, stream structure (mainline, release, dev branches), access control tier, storage quota, and last sync timestamp. SSOT for version control topology across all studios.';

CREATE OR REPLACE TABLE `gaming_ecm`.`studio`.`changelist` (
    `changelist_id` BIGINT COMMENT 'Unique surrogate identifier for the Perforce Helix Core changelist record in the Silver layer lakehouse. Primary key for this data product.',
    `backlog_item_id` BIGINT COMMENT 'Foreign key linking to studio.backlog_item. Business justification: Changelists reference the Jira backlog items (issues) they address. The changelist table has jira_issue_key (STRING) but no FK to backlog_item. Adding backlog_item_id FK provides proper referential in',
    `compliance_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Changelists may be root cause of compliance incidents (e.g., accidental PII exposure, COPPA violation in code). Incident investigation traces back to specific CLs; direct link enables root cause analy',
    `dev_project_id` BIGINT COMMENT 'Reference to the game development project (studio.dev_project) that owns the Perforce depot path associated with this changelist. Enables traceability from code change to project.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Code commits integrate licensed middleware/engine components (SDK updates, plugin integrations). IP asset tracking enables audit trails for license compliance and royalty calculation based on actual u',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to studio.milestone. Business justification: Changelists may be tagged to milestones for release tracking and delivery gate management. The changelist table has milestone_name (STRING) but no FK to milestone. Adding milestone_id FK provides prop',
    `sprint_id` BIGINT COMMENT 'Foreign key linking to studio.sprint. Business justification: Changelists are often associated with specific sprints for tracking and release management. The changelist table has sprint_name (STRING) and sprint_number (INT) but no FK to sprint. Adding sprint_id ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Code authorship tracking for performance reviews, IP ownership audits, and defect root cause analysis requires linking changesets to employee records. The submitter_username and submitter_display_name',
    `bug_severity` STRING COMMENT 'The severity level of the bug resolved by this changelist, as classified in Jira. Populated only when the changelist is a bug fix (linked_bug_id is not null). Enables analysis of critical bug fix velocity and release readiness.. Valid values are `critical|high|medium|low`',
    `build_number` STRING COMMENT 'The CI/CD pipeline build number that first incorporated this changelist. Links the code change to a specific build artifact, enabling build-to-changelist traceability for QA and release management.',
    `change_category` STRING COMMENT 'Classification of the primary content type of the changelist. Distinguishes code changes from art/audio asset submissions, configuration changes, shader updates, build scripts, documentation, or test files. Enables domain-specific change volume analysis. [ENUM-REF-CANDIDATE: code|art_asset|audio|config|shader|build_script|documentation|test — promote to reference product]',
    `change_status` STRING COMMENT 'Current lifecycle state of the changelist as tracked by Perforce Helix Core. pending = opened but not yet submitted; submitted = committed to the depot; shelved = files stored on the server without committing (used for code review and CI gating).. Valid values are `pending|submitted|shelved`',
    `change_type` STRING COMMENT 'Perforce changelist visibility type. public = visible to all users with depot access; restricted = visible only to the submitter and users with list permission on the files.. Valid values are `public|restricted`',
    `cicd_pipeline_status` STRING COMMENT 'The outcome of the CI/CD pipeline run triggered by this changelist. passed = all gates cleared; failed = one or more gates failed (build break, test failure); pending = pipeline in progress; skipped = no pipeline configured; cancelled = run aborted.. Valid values are `passed|failed|pending|skipped|cancelled`',
    `cl_description` STRING COMMENT 'Free-text description entered by the submitter summarizing the purpose of the changelist (e.g., Fix crash in NPC pathfinding on Level 3, Add LOD meshes for environment assets). Primary human-readable context for the change.',
    `cl_number` BIGINT COMMENT 'The native Perforce Helix Core changelist number — the externally-known, monotonically increasing integer identifier assigned by the Perforce server at submission time. Used by engineers and build systems to reference a specific code or asset snapshot.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) when the changelist was first opened/created in Perforce by the submitter. Distinct from submit_timestamp — a changelist may be open for days before submission.',
    `engine_version` STRING COMMENT 'The version of the game engine (Unity or Unreal Engine) active in the project at the time of this changelist submission (e.g., UE5.3.2, Unity2022.3.10f1). Enables correlation of engine upgrades with change volume and build stability.',
    `file_count` STRING COMMENT 'Total number of files (code, assets, configs, shaders, etc.) included in this changelist. Used for change size analysis, risk assessment, and build impact estimation.',
    `game_area` STRING COMMENT 'The game system or area affected by this changelist (e.g., Combat, UI, Networking, AI/NPC, Audio, Rendering, Physics, FTUE). Derived from the depot path or Jira issue component. Enables area-level change density and bug correlation analysis.',
    `integration_type` STRING COMMENT 'The Perforce integration action type for this changelist when it represents a branch integration. direct = direct integration; copy = copy integration; merge = merge integration; branch = new branch creation; none = not an integration changelist.. Valid values are `direct|copy|merge|branch|none`',
    `is_gaas_live_op` BOOLEAN COMMENT 'Indicates whether this changelist is associated with a GaaS (Game as a Service) live operations update (e.g., seasonal content drop, live event patch, balance update) rather than a standard development sprint. Enables separation of live ops cadence from core development velocity.',
    `is_hotfix` BOOLEAN COMMENT 'Indicates whether this changelist is classified as a hotfix — an urgent, out-of-cycle fix submitted to a release or live branch to address a critical production issue. Hotfixes bypass normal sprint cadence and require expedited QA and cert processes.',
    `jira_issue_type` STRING COMMENT 'The type of the linked Jira issue (Story, Bug, Task, Epic, Sub-task, Improvement). Enables analysis of what proportion of changelists are bug fixes vs. feature work vs. technical debt.. Valid values are `Story|Bug|Task|Epic|Sub-task|Improvement`',
    `lines_added` STRING COMMENT 'Number of lines of code or text added across all files in this changelist. Used for developer productivity metrics and code churn analysis. Applicable to text/code files; may be zero for binary asset-only changelists.',
    `lines_deleted` STRING COMMENT 'Number of lines of code or text deleted across all files in this changelist. Used alongside lines_added for code churn and refactoring analysis.',
    `perforce_server_reference` STRING COMMENT 'The identifier of the Perforce Helix Core server instance from which this changelist originates. Relevant for studios operating multiple Perforce servers (e.g., per-studio, per-region, or edge servers). Enables multi-server federation and data lineage.',
    `qa_validation_status` STRING COMMENT 'The Quality Assurance (QA) validation outcome for this changelist, indicating whether the change has been verified by the QA team. not_required = change type exempt from QA gate; pending = awaiting QA; passed = QA approved; failed = QA identified issues.. Valid values are `not_required|pending|passed|failed`',
    `reverts_cl_number` BIGINT COMMENT 'If this changelist is a revert of a previous submission, this field stores the original Perforce CL number that was reverted. Enables revert chain analysis and build stability tracking. Null if this is not a revert.',
    `review_approved_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) when the code or asset review for this changelist was approved. Used to measure review cycle time and enforce pre-submit review gates.',
    `review_status` STRING COMMENT 'The current status of the code/asset review process for this changelist (e.g., via Swarm or equivalent review tool integrated with Perforce). Tracks whether peer review has been completed before or after submission.. Valid values are `not_required|pending|approved|rejected|needs_revision`',
    `reviewer_username` STRING COMMENT 'The Perforce/Swarm username of the primary code or asset reviewer assigned to this changelist. Used for review workload analysis and accountability tracking.',
    `shelved_for_review` BOOLEAN COMMENT 'Indicates whether this changelist was shelved specifically to facilitate a pre-submit code or asset review (as opposed to being shelved for backup or work-in-progress purposes). Used to track review-gated submission workflows.',
    `source_branch` STRING COMMENT 'The source branch or stream from which this changelist was integrated or merged (e.g., //GameTitle/dev integrated into //GameTitle/main). Populated for integration changelists. Enables branch merge history and integration tracking.',
    `stream_name` STRING COMMENT 'The Perforce stream (e.g., //GameTitle/main, //GameTitle/dev, //GameTitle/release/1.5) to which this changelist belongs. Streams represent branching strategy and are critical for build pipeline routing and release management.',
    `submit_timestamp` TIMESTAMP COMMENT 'The exact date and time (UTC) at which the changelist was submitted to the Perforce depot. This is the principal real-world business event timestamp for this transaction. Null for pending or shelved changelists.',
    `target_platform` STRING COMMENT 'The target gaming platform(s) affected by this changelist (e.g., PC, PS5, XboxSeriesX, iOS, Android, Switch, All). Used to route changes through platform-specific QA and TRC/TCR certification validation pipelines.',
    `total_file_size_bytes` BIGINT COMMENT 'The aggregate size in bytes of all files included in this changelist. Used for depot storage impact analysis, CDN pre-warming estimation for patches, and identifying large binary asset submissions that may impact build times.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) when the changelist record was last modified in the source system (e.g., description edited, files added/removed, status changed). Used for incremental ETL and audit.',
    `workspace_name` STRING COMMENT 'The Perforce client workspace name from which the changelist was submitted. Identifies the developers local workspace configuration and maps to a specific machine/environment.',
    CONSTRAINT pk_changelist PRIMARY KEY(`changelist_id`)
) COMMENT 'Perforce Helix Core changelist (commit) records capturing every code and asset submission to version control. Tracks changelist number, description, submitter, submit timestamp, depot path, file count, change type (pending, submitted, shelved), associated task/backlog item, and review status. Enables traceability from code change to backlog item to build.';

CREATE OR REPLACE TABLE `gaming_ecm`.`studio`.`resource_allocation` (
    `resource_allocation_id` BIGINT COMMENT 'Unique surrogate identifier for each resource allocation record in the studio domain. Primary key for the resource_allocation data product. Entity role: TRANSACTION_HEADER — represents a discrete business event (a team member assigned to a project for a defined period) with its own lifecycle.',
    `dev_project_id` BIGINT COMMENT 'Reference to the game development project to which this resource is allocated. Links the allocation to the studio.dev_project master record for capacity planning and burn-down forecasting.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Resource allocations consume specific budget line items. Required for headcount budget tracking, budget vs. actual labor cost analysis, and project financial forecasting.',
    `game_studio_id` BIGINT COMMENT 'Reference to the studio entity (internal or external/third-party) to which the allocated team member belongs. Supports cross-studio resource balancing and capacity reporting.',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to studio.milestone. Business justification: Resource allocations may be tied to specific production milestones for milestone-based staffing and capacity planning. The resource_allocation table has milestone_name (STRING) but no FK to milestone.',
    `employee_id` BIGINT COMMENT 'Reference to the workforce domain employee record for the team member being allocated. Identity and personal data are owned by the workforce domain; this field is the cross-domain join key. Aligns with SAP S/4HANA HR module personnel number.',
    `sprint_id` BIGINT COMMENT 'Foreign key linking to studio.sprint. Business justification: Resource allocations are often sprint-specific, tracking how team members are allocated to specific sprint iterations. The resource_allocation table has sprint_number (INT) but no FK to sprint. Adding',
    `tertiary_resource_replacement_employee_id` BIGINT COMMENT 'Reference to the workforce domain employee record of the team member who replaced this allocation when it was released or cancelled. Supports continuity planning and backfill tracking.',
    `allocated_role` STRING COMMENT 'The functional role the team member is performing on this project during the allocation period (e.g., Lead Engineer, Senior Artist, Technical Designer, Producer, QA Analyst, Gameplay Programmer). Distinct from the employees HR job title — captures the project-specific role. [ENUM-REF-CANDIDATE: engineer|artist|designer|producer|qa_analyst|programmer|animator|technical_artist|audio_engineer|narrative_designer|devops_engineer|project_manager — promote to reference product]',
    `allocation_code` STRING COMMENT 'Externally-known business identifier for this allocation record, used in resource management tools (Shotgrid, Float, Productive) and studio production spreadsheets. Enables traceability back to the source system record.. Valid values are `^ALLOC-[A-Z0-9]{4,12}$`',
    `allocation_pct` DECIMAL(18,2) COMMENT 'The fraction of the team members full-time equivalent (FTE) capacity committed to this project during the allocation period, expressed as a percentage (0.00–100.00). A value of 50.00 means the person is half-time on this project. Enables FTE burn-down forecasting and over-allocation detection.',
    `allocation_source` STRING COMMENT 'The operational system of record from which this allocation was sourced (e.g., Shotgrid, Float, Productive, or a studio production spreadsheet). Supports data lineage tracking and ETL reconciliation in the Silver layer. [ENUM-REF-CANDIDATE: shotgrid|float|productive|spreadsheet|jira|manual|other — 7 candidates stripped; promote to reference product]',
    `allocation_status` STRING COMMENT 'Current lifecycle state of the allocation record. confirmed = formally approved and locked; tentative = planned but not yet approved; released = team member has been released from the project; on_hold = temporarily paused; cancelled = allocation was voided before start.. Valid values are `confirmed|tentative|released|on_hold|cancelled`',
    `approval_date` DATE COMMENT 'The date on which this allocation was formally approved by the responsible manager or producer. Marks the transition from tentative to confirmed status and is used for audit and governance purposes.',
    `cicd_pipeline_access` BOOLEAN COMMENT 'Indicates whether the allocated team member has been granted access to the projects CI/CD pipeline (True) or not (False). Relevant for DevOps and engineering allocations; supports access governance and release gate compliance.',
    `cost_center_code` STRING COMMENT 'SAP S/4HANA cost center code to which this allocations labour cost is attributed. Enables financial reporting, project cost tracking, and EBITDA analysis at the studio and project level.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this resource allocation record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides the audit trail creation anchor for data governance and lineage purposes.',
    `daily_rate_usd` DECIMAL(18,2) COMMENT 'The daily cost rate in US Dollars for this allocation, representing the blended or contracted daily cost of the team members time. Used for project budget burn-down forecasting and cost-to-complete calculations. Stored as confidential business data.',
    `end_date` DATE COMMENT 'The calendar date on which the team members allocation to this project ends. Nullable for open-ended allocations. Used for capacity forecasting and identifying when resources will become available for reallocation.',
    `fte_hours_per_day` DECIMAL(18,2) COMMENT 'The number of working hours per day this allocation represents, derived from the studios standard working day and the allocation percentage. Stored explicitly to support scheduling tools that operate in hours rather than percentages.',
    `gaas_live_ops_flag` BOOLEAN COMMENT 'Indicates whether this allocation is associated with a GaaS live operations cadence (True) rather than a finite game development project (False). Enables separate capacity planning and reporting for live service teams versus new title development teams.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether this allocation is billable to an external client or publisher (True) or is an internal cost centre allocation (False). Relevant for third-party studio engagements and co-development arrangements where costs are recharged.',
    `is_contractor` BOOLEAN COMMENT 'Indicates whether the allocated team member is an external contractor or freelancer (True) rather than a full-time employee (False). Affects cost modelling, compliance obligations, and workforce reporting.',
    `is_remote` BOOLEAN COMMENT 'Indicates whether the team member is working remotely (True) or on-site at a studio location (False) for this allocation. Relevant for studio capacity planning, collaboration tooling, and compliance with remote work policies.',
    `jira_epic_key` STRING COMMENT 'The Jira epic key (e.g., GAME-42) to which this allocations work is primarily attributed. Enables traceability between resource allocation records and Jira-driven backlogs for capacity vs. scope analysis.. Valid values are `^[A-Z][A-Z0-9]+-[0-9]+$`',
    `notes` STRING COMMENT 'Free-text notes entered by the producer or resource manager providing additional context for this allocation (e.g., special conditions, partial-week schedules, cross-studio arrangement details, or reasons for tentative status).',
    `overtime_approved` BOOLEAN COMMENT 'Indicates whether overtime hours have been formally approved for this allocation (True) or not (False). Relevant for crunch period management, labour compliance, and cost forecasting during intensive production phases such as gold master preparation.',
    `perforce_depot_access` BOOLEAN COMMENT 'Indicates whether the allocated team member has been granted access to the projects Perforce Helix Core depot (True) or not (False). Supports version control access governance and onboarding/offboarding workflows.',
    `primary_tool` STRING COMMENT 'The primary game development tool or engine the team member is using in this allocation. Supports tooling-based capacity planning and ensures the right skill set is matched to the projects technology stack. [ENUM-REF-CANDIDATE: unity|unreal_engine|perforce|maya|blender|photoshop|houdini|fmod|wwise|other — 10 candidates stripped; promote to reference product]',
    `priority_rank` STRING COMMENT 'Numeric priority rank for this allocation relative to other allocations for the same team member (1 = highest priority). Used to resolve conflicts when a team member is over-allocated across multiple projects and a release decision must be made.',
    `project_phase` STRING COMMENT 'The game development phase during which this allocation is active. Aligns with standard game production lifecycle phases. Enables phase-level capacity analysis and supports GaaS live operations cadence planning. [ENUM-REF-CANDIDATE: pre_production|production|alpha|beta|gold_master|live_ops|post_launch|cancelled — 8 candidates stripped; promote to reference product]',
    `release_date` DATE COMMENT 'The actual date on which the team member was released from this allocation, which may differ from the planned end_date. Populated when allocation_status transitions to released. Enables actual vs. planned capacity analysis.',
    `requested_date` DATE COMMENT 'The date on which the resource allocation was originally requested by the project team or producer. Enables measurement of resource request lead times and planning efficiency.',
    `role_discipline` STRING COMMENT 'High-level discipline grouping for the allocated role, used for capacity planning dashboards and cross-studio resource balancing. Enables aggregation across specific role titles within a discipline (e.g., all engineering roles regardless of seniority). [ENUM-REF-CANDIDATE: engineering|art|design|production|qa|audio|narrative|devops|marketing|other — 10 candidates stripped; promote to reference product]',
    `seniority_level` STRING COMMENT 'Seniority tier of the team member in the context of this allocation. Used for capacity planning, cost modelling, and ensuring appropriate skill levels are assigned to project phases.. Valid values are `junior|mid|senior|lead|principal|director`',
    `skill_tags` STRING COMMENT 'Comma-separated list of skill or technology tags associated with this allocation (e.g., Unreal Engine 5, C++, Gameplay Systems, Multiplayer Networking). Sourced from the resource management tools skill taxonomy. Enables skill-based resource search and gap analysis. Stored as a delimited string per Silver layer conventions (no ARRAY type).',
    `source_record_reference` STRING COMMENT 'The native identifier of this allocation record in the originating source system (Shotgrid booking ID, Float assignment ID, Productive task ID, or spreadsheet row reference). Enables reverse traceability from the Silver layer back to the operational system.',
    `start_date` DATE COMMENT 'The calendar date on which the team members allocation to this project begins. Used for timeline planning, sprint capacity calculations, and resource availability windows.',
    `total_allocated_days` DECIMAL(18,2) COMMENT 'The total number of working days this team member is allocated to the project across the full allocation period, accounting for the allocation percentage. Calculated at source system ingestion and stored for reporting efficiency. Supports capacity burn-down forecasting.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this resource allocation record was most recently modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports change detection in ETL pipelines and audit trail completeness for the Silver layer.',
    `work_location_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country where the team member is physically working during this allocation. Used for cross-border compliance, GDPR data residency considerations, and international studio cost reporting.. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_resource_allocation PRIMARY KEY(`resource_allocation_id`)
) COMMENT 'Studio resource allocation records tracking how team members (engineers, artists, designers, producers, QA) are assigned to projects over time periods. Captures allocated role, allocation percentage (FTE fraction), start/end dates, project phase, skill tags, and allocation status (confirmed, tentative, released). Sourced from resource management tools (Shotgrid/Float/Productive) or studio production spreadsheets. Enables capacity planning, burn-down forecasting, and cross-studio resource balancing without duplicating workforce master data (employee identity owned by workforce domain).';

CREATE OR REPLACE TABLE `gaming_ecm`.`studio`.`live_ops_cycle` (
    `live_ops_cycle_id` BIGINT COMMENT 'Primary key for live_ops_cycle',
    `build_id` BIGINT COMMENT 'Foreign key linking to studio.build. Business justification: GaaS live operations cycles deploy specific builds. The live_ops_cycle table has build_version (STRING) but no FK to build. Adding build_id FK provides proper referential integrity and removes the red',
    `content_release_id` BIGINT COMMENT 'Unique surrogate identifier for a GaaS live operations cycle record. Standardized from gaas_live_ops_cycle_id per entity-scoped naming convention. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Live ops cycles are independent cost tracking units with dedicated budgets. Required for GaaS financial reporting, season P&L analysis, and live service cost management.',
    `dev_project_id` BIGINT COMMENT 'Reference to the parent development project (GaaS title) that this live ops cycle belongs to. Links the cycle to the studio production context in the dev_project entity.',
    `employee_id` BIGINT COMMENT 'Reference to the internal workforce record of the lead producer or live ops content owner responsible for delivering this cycle. Supports accountability tracking and resource allocation reporting.',
    `forum_id` BIGINT COMMENT 'Foreign key linking to community.forum. Business justification: Seasonal community engagement: live ops cycles (seasons, battle passes) have dedicated forum sections for discussion. Community teams create forums per cycle to centralize feedback and announcements.',
    `infrastructure_deployment_id` BIGINT COMMENT 'Foreign key linking to infrastructure.infrastructure_deployment. Business justification: Live ops releases are infrastructure deployments. Direct operational relationship required for release tracking, rollback procedures, and coordinating content updates with infrastructure changes in Ga',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Live operations content drops (seasons, events) frequently include licensed music, brand collaborations, or middleware features. Agreement tracking enables per-cycle royalty calculation and compliance',
    `marketing_campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Live ops content releases (seasons, events, battle passes) require dedicated marketing campaigns. Real business process: UA teams plan paid acquisition and influencer campaigns around content drops to',
    `patch_release_id` BIGINT COMMENT 'Foreign key linking to platform.patch_release. Business justification: Live-ops cycles deploy content updates via platform patches. Each GaaS cycle results in a platform-specific patch submission for certification and distribution. Essential for tracking which platform p',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Live ops cycles contribute revenue and costs to title profit centers. Required for season-level P&L reporting, MTX revenue attribution, and live service profitability analysis.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Live ops cycles may trigger regulatory filings (e.g., age rating amendments for new content, esports betting licenses). Esrb_content_descriptor/pegi_content_descriptor fields signal filing need; direc',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Live ops cycles (seasons, events) deploy to specific server fleets. Essential for GaaS operations, capacity planning for events, and coordinating content releases with infrastructure readiness.',
    `tournament_id` BIGINT COMMENT 'Foreign key linking to esports.tournament. Business justification: Live ops cycles often align with esports tournament schedules for content releases, balance patches, and competitive meta management. This links development cycles to the competitive calendar, enablin',
    `actual_dev_hours` STRING COMMENT 'Actual development effort in person-hours consumed to produce this live ops cycle. Compared against estimated_dev_hours to measure estimation accuracy and inform future sprint planning.',
    `actual_release_date` DATE COMMENT 'The date the live ops cycle was actually deployed to production. Null if not yet deployed. Compared against planned_release_date to calculate release slip and inform future planning accuracy.',
    `cert_approval_date` DATE COMMENT 'Date the build for this live ops cycle received certification approval from first-party platform holders. Null if not yet approved or not applicable. Used to track certification lead time and release gate compliance.',
    `cert_submission_date` DATE COMMENT 'Date the build for this live ops cycle was submitted to first-party platform holders (e.g., Sony, Microsoft, Nintendo) for technical certification review. Null for PC/mobile-only cycles that do not require console certification.',
    `cicd_pipeline_run_reference` STRING COMMENT 'Identifier of the CI/CD pipeline run that produced and validated the deployable build for this cycle. Enables traceability from the live ops cycle to the automated build, test, and deployment pipeline execution.',
    `content_scope_summary` STRING COMMENT 'Free-text summary of the content included in this live ops cycle (e.g., new maps, characters, weapons, story chapters, balance changes, bug fixes). Sourced from the live ops calendar or Jira epic descriptions. Used for player communication and internal scope tracking.',
    `coppa_applicable` BOOLEAN COMMENT 'Indicates whether this cycle introduces content or data collection features that trigger COPPA compliance obligations (e.g., content targeting players under 13, new data collection from child accounts). True = COPPA review required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this live ops cycle record was first created in the system (ISO 8601 format with timezone offset). Audit trail field for data lineage and record provenance tracking.',
    `critical_bug_count_at_release` STRING COMMENT 'Number of critical-severity bugs open at the time of release for this cycle. A non-zero value may indicate a waived release gate. Used for post-release incident risk assessment and QA process improvement.',
    `cycle_code` STRING COMMENT 'Short alphanumeric business identifier for the cycle used in Jira release planning, build pipelines, and internal tracking (e.g., S04, PATCH-2.3, EVT-WINTER-2024). Externally known code referenced across production tools.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `cycle_end_date` DATE COMMENT 'Date the live ops cycle ends and content is retired or replaced. Defines the active window for limited-time events, seasons, and battle pass rotations. Null for open-ended cycles such as permanent patches.',
    `cycle_name` STRING COMMENT 'Human-readable name of the live ops cycle as communicated to players and internal teams (e.g., Season 4: Shadow Realm, Patch 2.3, Event: Winter Festival). Used in player communications, marketing materials, and internal planning.',
    `cycle_start_date` DATE COMMENT 'Date the live ops cycle becomes active and visible to players (e.g., season start date, event start date). May differ from actual_release_date if a deployment precedes the in-game activation window.',
    `cycle_status` STRING COMMENT 'Current lifecycle state of the live ops cycle. planned = scheduled but not yet in active development; in_development = content being built; deployed = live and active for players; retired = cycle has ended and content is no longer active.. Valid values are `planned|in_development|deployed|retired`',
    `cycle_type` STRING COMMENT 'Classification of the live ops cycle by its operational nature. Drives planning cadence, resource allocation, and monetization strategy. [ENUM-REF-CANDIDATE: season|major_patch|hotfix|limited_time_event|battle_pass_rotation|expansion|minor_patch|maintenance — promote to reference product]. Valid values are `season|major_patch|hotfix|limited_time_event|battle_pass_rotation|expansion`',
    `deployment_region` STRING COMMENT 'Geographic region or rollout scope for this cycle deployment (e.g., GLOBAL, NA, EU, APAC, or specific country codes for soft-launch or staged rollouts). Supports regional compliance and staggered deployment strategies.',
    `esrb_content_descriptor` STRING COMMENT 'ESRB content descriptor applicable to new content introduced in this cycle (e.g., Violence, In-Game Purchases, Users Interact). Required for compliance with ESRB rating maintenance obligations when new content changes the rating profile of the game.',
    `estimated_dev_hours` STRING COMMENT 'Total estimated development effort in person-hours allocated to produce this live ops cycle. Used for resource planning, sprint capacity management, and post-cycle retrospective analysis of estimation accuracy.',
    `gdpr_data_processing_note` STRING COMMENT 'Free-text note documenting any new or changed player data processing activities introduced by this cycle (e.g., new telemetry events, new player data collection). Required for GDPR Article 30 Records of Processing Activities compliance review.',
    `has_battle_pass` BOOLEAN COMMENT 'Indicates whether this cycle includes a battle pass product offering. Distinct from the general MTX tie-in flag as battle passes have specific revenue recognition, player engagement, and retention analytics implications.',
    `has_mtx_tie_in` BOOLEAN COMMENT 'Indicates whether this live ops cycle includes a direct microtransaction (MTX) monetization component such as a battle pass, limited-time store bundle, or premium currency event. True = monetization tie-in present; False = no direct MTX component.',
    `is_limited_time` BOOLEAN COMMENT 'Indicates whether this cycle is a time-bounded limited-time event (LTE) with a hard end date after which content is no longer accessible. Drives urgency-based player communication and FOMO-driven engagement strategies.',
    `is_soft_launch` BOOLEAN COMMENT 'Indicates whether this cycle is deployed as a soft launch (limited regional or audience rollout) before a full global hard launch. Soft launches are used for live testing, performance validation, and player feedback collection prior to global deployment.',
    `jira_release_key` STRING COMMENT 'The Jira release/version identifier associated with this live ops cycle in the project management system (e.g., Jira Fix Version ID). Enables traceability from the live ops cycle back to the Jira backlog, epics, and sprint planning artifacts.',
    `open_bug_count_at_release` STRING COMMENT 'Number of open (unresolved) bugs in Jira at the time this cycle was released to production. Captures the known-issues baseline at deployment, used for post-release quality tracking and player support readiness.',
    `patch_notes_url` STRING COMMENT 'URL to the published patch notes or release notes document for this cycle. Used by community management, player support (Zendesk), and analytics teams to correlate player behavior changes with specific content updates.',
    `pegi_content_descriptor` STRING COMMENT 'PEGI content descriptor applicable to new content introduced in this cycle for European markets. Required for compliance with PEGI rating maintenance obligations when live content updates affect the games rating classification.',
    `perforce_label` STRING COMMENT 'The Perforce Helix Core label or changelist snapshot associated with the build deployed for this cycle. Provides version control traceability for the exact codebase and asset state shipped.',
    `planned_release_date` DATE COMMENT 'Originally scheduled calendar date for deploying this live ops cycle to production. Used for production planning, player communication scheduling, and release gate tracking. Compared against actual_release_date to measure release predictability.',
    `player_comms_plan_ref` STRING COMMENT 'Reference identifier or URL pointing to the player communication plan document for this cycle (e.g., patch notes document ID, community blog post URL, CRM campaign reference). Links production planning to community management and marketing execution.',
    `qa_sign_off_date` DATE COMMENT 'Date the QA team formally signed off on the build for this live ops cycle, confirming it meets quality thresholds for release. Prerequisite for CI/CD release gate approval and platform certification submission.',
    `release_gate_status` STRING COMMENT 'Current status of the CI/CD release gate for this cycle. pending = gate checks not yet complete; passed = all gates cleared for deployment; failed = one or more gates blocked; waived = gate bypassed with documented approval.. Valid values are `pending|passed|failed|waived`',
    `rollback_version` STRING COMMENT 'The build version to which the game would be rolled back if this cycle deployment fails or causes critical issues. Defined as part of the deployment risk management plan for each live ops cycle.. Valid values are `^d+.d+(.d+)?(.d+)?$`',
    `season_number` STRING COMMENT 'Sequential season number for cycles of type season or battle_pass_rotation. Null for non-seasonal cycle types. Used for player-facing season tracking, analytics cohort segmentation, and historical season comparison.',
    `sprint_count` STRING COMMENT 'Number of Jira sprints consumed to develop and deliver this live ops cycle. Used for production cadence analysis and GaaS live operations velocity benchmarking.',
    `target_platforms` STRING COMMENT 'Comma-separated list of platforms for which this cycle is deployed (e.g., PC,PS5,XSX,iOS,Android). A cycle may deploy to all platforms simultaneously or in a staggered rollout. Used for platform certification tracking and deployment coordination.',
    `uat_sign_off_date` DATE COMMENT 'Date the UAT sign-off was completed for this live ops cycle, confirming that internal stakeholders and/or external partners have accepted the content and functionality. Required release gate before deployment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this live ops cycle record (ISO 8601 format with timezone offset). Used for change tracking, data freshness monitoring, and incremental ETL processing in the Databricks Silver Layer.',
    CONSTRAINT pk_live_ops_cycle PRIMARY KEY(`live_ops_cycle_id`)
) COMMENT 'GaaS (Game-as-a-Service) live operations cycle records representing planned content update cadences for live games (e.g., Season 1, Patch 2.3, Event: Winter Festival). Captures cycle name, cycle type (season, major patch, hotfix, limited-time event, battle pass rotation), planned release date, actual release date, associated build version, content scope summary, monetization tie-in flag, player communication plan reference, and cycle status (planned, in-development, deployed, retired). Sourced from studio production planning tools (Jira release planning or dedicated live ops calendar such as LiveOps/PlayFab). Bridges studio production pipeline with live game operations. Note: PK gaas_live_ops_cycle_id should be standardized to live_ops_cycle_id per entity-scoped naming convention.';

CREATE OR REPLACE TABLE `gaming_ecm`.`studio`.`partnership` (
    `partnership_id` BIGINT COMMENT 'Primary key for partnership',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Studio partnership management requires tracking the internal employee responsible for contract oversight, milestone negotiations, and revenue share reconciliation. The account_manager_name field denor',
    `dev_project_id` BIGINT COMMENT 'Reference to the game development project (dev_project) associated with this partnership, if the partnership is scoped to a specific title or production effort.',
    `developer_account_id` BIGINT COMMENT 'Foreign key linking to platform.developer_account. Business justification: Co-publishing partnerships require shared or delegated platform developer accounts for submission rights. Partnership contracts specify which party holds the platform account credentials and revenue-s',
    `invoice_line_id` BIGINT COMMENT 'Foreign key linking to billing.invoice_line. Business justification: Partner revenue share calculation requires invoice-level tracking to compute payouts based on actual sales per revenue-sharing agreements—mandatory for contract compliance and partner financial reconc',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Studio partnerships (co-development, publishing deals) often involve IP licensing terms (engine rights, brand usage, revenue share). Linking partnership to master IP agreement ensures consistent terms',
    `game_studio_id` BIGINT COMMENT 'Reference to the internal publishing studio entity (Gaming) that is the publishing party in this partnership agreement.',
    `partnership_partner_studio_game_studio_id` BIGINT COMMENT 'Reference to the external or co-development studio entity that is the counterpart in this partnership agreement.',
    `payout_line_id` BIGINT COMMENT 'Foreign key linking to billing.payout_line. Business justification: Partner payout reconciliation requires direct linkage between partnership agreements and payout lines to verify revenue share calculations, audit partner payments, and ensure contract compliance—essen',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Publisher partnerships are contracts between legal entities. Required for intercompany accounting, contract liability tracking, consolidation elimination, and royalty payment processing.',
    `third_party_processor_id` BIGINT COMMENT 'Foreign key linking to compliance.third_party_processor. Business justification: Partner studios may be third-party processors under GDPR when processing player data on behalf of publisher. Partnership.gdpr_data_processing_agreement signals this; direct link enables DPA tracking.',
    `advance_recoupable_usd` DECIMAL(18,2) COMMENT 'The upfront advance payment made to the partner studio that is recoupable against future royalty earnings. Common in publisher-developer agreements. Tracked in SAP S/4HANA for recoupment accounting.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the partnership agreement contains an automatic renewal clause that extends the term without requiring a new executed agreement. True = auto-renews; False = requires explicit renewal action.',
    `contract_document_url` STRING COMMENT 'Secure URL or document management system reference pointing to the executed partnership agreement document stored in Agiloft/Ironclad or the enterprise document repository. Provides traceability to the source legal instrument.',
    `contract_reference_number` STRING COMMENT 'Externally-known contract or agreement number as recorded in the contract management system (Agiloft/Ironclad). Serves as the primary business identifier linking this record to the executed legal document.',
    `coppa_applicable` BOOLEAN COMMENT 'Indicates whether the partnership scope involves titles or features subject to Childrens Online Privacy Protection Act (COPPA) compliance obligations, requiring additional data handling controls.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this partnership record was first created in the source contract management system (Agiloft/Ironclad) and ingested into the Gaming lakehouse Silver layer. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the primary currency in which the partnership financial terms are denominated (e.g., USD, EUR, GBP). Enables multi-currency reporting in SAP S/4HANA.. Valid values are `^[A-Z]{3}$`',
    `dispute_resolution_mechanism` STRING COMMENT 'The contractually agreed method for resolving disputes between Gaming and the partner studio. Arbitration: binding private arbitration; Litigation: court proceedings; Mediation: non-binding facilitated negotiation; Expert Determination: specialist third-party ruling.. Valid values are `arbitration|litigation|mediation|expert_determination`',
    `effective_end_date` DATE COMMENT 'The date on which the partnership agreement is scheduled to expire or terminate. Nullable for open-ended or evergreen agreements. Sourced from Agiloft/Ironclad.',
    `effective_start_date` DATE COMMENT 'The date on which the partnership agreement becomes legally binding and operational. Corresponds to the contract commencement date in Agiloft/Ironclad.',
    `esrb_compliance_required` BOOLEAN COMMENT 'Indicates whether the partner studio is contractually obligated to comply with Entertainment Software Rating Board (ESRB) content rating requirements for North American distribution of the associated title.',
    `exclusivity_type` STRING COMMENT 'Defines whether the partner studio is bound by exclusivity obligations under this partnership. Exclusive: studio works only with Gaming during the term; Non-Exclusive: studio may work with other publishers; Platform Exclusive: exclusivity limited to specific platforms; Genre Exclusive: exclusivity within a specific game genre; None: no exclusivity clause.. Valid values are `exclusive|non_exclusive|platform_exclusive|genre_exclusive|none`',
    `gaas_support_flag` BOOLEAN COMMENT 'Indicates whether the partnership scope includes ongoing live operations and Game as a Service (GaaS) support activities (e.g., seasonal content, live events, balance patches) beyond the initial ship date.',
    `gaming_revenue_share_pct` DECIMAL(18,2) COMMENT 'The percentage of net revenue retained by Gaming (the publisher) under the agreed revenue share model. Expressed as a decimal percentage (e.g., 70.00 = 70%). Applicable when revenue_share_model is royalty_percentage, profit_share, or hybrid.',
    `gdpr_data_processing_agreement` BOOLEAN COMMENT 'Indicates whether a General Data Protection Regulation (GDPR)-compliant Data Processing Agreement (DPA) has been executed with the partner studio, required when the partner processes EU player personal data.',
    `governing_law_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction whose laws govern the partnership agreement (e.g., USA, GBR, DEU). Determines applicable regulatory and legal frameworks for dispute resolution.. Valid values are `^[A-Z]{3}$`',
    `ip_ownership_arrangement` STRING COMMENT 'Defines which party holds Intellectual Property (IP) rights for assets created under this partnership. Critical for downstream licensing, sequel rights, and asset reuse decisions. Distinct from the licensing domain — this captures only the studio-to-studio IP ownership metadata.. Valid values are `gaming_owned|partner_owned|jointly_owned|licensed_to_gaming|licensed_to_partner`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this partnership record in the source system or lakehouse. Used for incremental ETL processing and audit trail maintenance. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `milestone_count` STRING COMMENT 'Total number of contractually defined delivery milestones specified in the partnership agreement. Used for milestone-based payment tracking and project governance alignment with Jira.',
    `milestones_completed` STRING COMMENT 'Number of contractual milestones that have been formally accepted and signed off by Gaming as of the last update. Enables tracking of partnership delivery progress and payment eligibility.',
    `mtx_revenue_rights_flag` BOOLEAN COMMENT 'Indicates whether the partner studio has contractual rights to a share of Microtransaction (MTX) and In-App Purchase (IAP) revenues generated by the title. Relevant for GaaS titles with ongoing monetization.',
    `nda_executed_flag` BOOLEAN COMMENT 'Indicates whether a Non-Disclosure Agreement (NDA) has been fully executed between Gaming and the partner studio prior to or concurrent with the partnership agreement.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, negotiation history, strategic rationale, or operational notes about the partnership that are not captured in structured fields. Sourced from Agiloft/Ironclad or Salesforce CRM notes.',
    `partner_primary_contact_email` STRING COMMENT 'Business email address of the primary contact at the partner studio. Used for formal communications and contract notifications. Sourced from Salesforce CRM.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `partner_primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the partner studio for this partnership. Used for communication and escalation. Sourced from Salesforce CRM contact records.',
    `partner_revenue_share_pct` DECIMAL(18,2) COMMENT 'The percentage of net revenue allocated to the partner studio under the agreed revenue share model. Should sum to 100% with gaming_revenue_share_pct for royalty/profit-share models.',
    `partner_studio_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the partner studios primary place of business. Used for regulatory compliance scoping (GDPR, COPPA), tax withholding determination, and geographic reporting.. Valid values are `^[A-Z]{3}$`',
    `partnership_name` STRING COMMENT 'Human-readable name or title of the partnership agreement (e.g., Studio X Co-Development Agreement — Title Y). Used for display and reporting purposes.',
    `partnership_status` STRING COMMENT 'Current lifecycle state of the partnership agreement. Draft: under negotiation; Active: fully executed and in force; Suspended: temporarily paused by mutual or unilateral action; Terminated: ended before natural expiry; Expired: reached end date without renewal; Pending Renewal: in renegotiation at term end.. Valid values are `draft|active|suspended|terminated|expired|pending_renewal`',
    `partnership_type` STRING COMMENT 'Classification of the studio-to-studio relationship structure. Defines the nature of the engagement: co_development (joint IP creation), work_for_hire (contracted deliverables, IP owned by Gaming), licensed_developer (studio licensed to develop on Gaming IP), publisher_developer_agreement (standard pub-dev deal), first_party_exclusive (console-manufacturer-aligned exclusive), third_party_publishing (external developer publishing deal). [ENUM-REF-CANDIDATE: co_development|work_for_hire|licensed_developer|publisher_developer_agreement|first_party_exclusive|third_party_publishing — promote to reference product]. Valid values are `co_development|work_for_hire|licensed_developer|publisher_developer_agreement|first_party_exclusive|third_party_publishing`',
    `pegi_compliance_required` BOOLEAN COMMENT 'Indicates whether the partner studio is contractually obligated to comply with Pan European Game Information (PEGI) content rating requirements for European distribution.',
    `renewal_notice_days` STRING COMMENT 'Number of calendar days prior to effective_end_date by which either party must provide written notice of intent to renew or terminate. Drives contract management workflow alerts in Agiloft/Ironclad.',
    `revenue_share_model` STRING COMMENT 'The commercial model governing how revenues generated from the partnership are distributed between Gaming and the partner studio. Fixed Fee: lump-sum payment; Royalty Percentage: percentage of net/gross revenue; Milestone Based: payments tied to delivery milestones; Profit Share: split of net profit; Hybrid: combination of models.. Valid values are `fixed_fee|royalty_percentage|milestone_based|profit_share|hybrid`',
    `signed_date` DATE COMMENT 'The date on which all parties executed (signed) the partnership agreement. May differ from effective_start_date if the agreement has a retroactive or future effective date.',
    `termination_date` DATE COMMENT 'The actual date on which the partnership was terminated early, if applicable. Null if the partnership expired naturally or is still active. Distinct from effective_end_date which is the planned expiry.',
    `termination_reason` STRING COMMENT 'Reason code for early termination of the partnership, if applicable. Null for active or naturally expired agreements. Sourced from contract management system. [ENUM-REF-CANDIDATE: mutual_agreement|breach_of_contract|project_cancellation|financial_default|regulatory|acquisition|convenience — 7 candidates stripped; promote to reference product]',
    `total_contract_value_usd` DECIMAL(18,2) COMMENT 'The total committed financial value of the partnership agreement in US Dollars (USD), as stated in the executed contract. Includes all milestone payments, advances, and guaranteed minimums. Sourced from Agiloft/Ironclad and reconciled in SAP S/4HANA.',
    `ugc_rights_flag` BOOLEAN COMMENT 'Indicates whether the partnership agreement grants or restricts User-Generated Content (UGC) creation rights for the partner studio or end players on the associated title.',
    CONSTRAINT pk_partnership PRIMARY KEY(`partnership_id`)
) COMMENT 'Records the formal relationship between the publishing entity (Gaming) and external or co-development studios, capturing partnership type (co-dev, work-for-hire, licensed developer, publisher-developer agreement), partnership start date, end date, contractual terms reference, revenue share model, IP ownership arrangement, and partnership status. Sourced from contract management system (Agiloft/Ironclad). Distinct from workforce domain (no employee data) and licensing domain (no IP licensing terms — only the studio-to-studio relationship metadata).';

CREATE OR REPLACE TABLE `gaming_ecm`.`studio`.`project_budget_allocation` (
    `project_budget_allocation_id` BIGINT COMMENT 'Unique surrogate identifier for each budget allocation record assigned to a development project. Primary key for this entity. Entity role: TRANSACTION_HEADER — represents a discrete approved funding event with its own lifecycle (draft → approved → active → closed/revised).',
    `dev_project_id` BIGINT COMMENT 'Reference to the development project (studio.dev_project) to which this budget allocation is assigned. Links the funding record to the specific game development initiative.',
    `employee_id` BIGINT COMMENT 'Reference to the workforce member (e.g., Executive Producer, Head of Studio, Finance Controller) who formally approved this budget allocation. Supports approval audit trail and accountability.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Project budget allocations reference master budget records. Core budget management process—links project spending authorizations to approved budget line items for variance tracking and approval workfl',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Project cost accounting requires linking budget allocations to invoices for marketing/publishing spend tracking, budget variance analysis, and cost reconciliation—standard financial control process fo',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Budget allocations post to GL via journal entries. Required for financial audit trail, budget commitment accounting, and SOX compliance—links budget authorization to actual GL posting.',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to studio.milestone. Business justification: Budget allocations may be tied to specific production milestones for milestone-based funding and payment tracking. The project_budget_allocation table does not have a milestone_id FK. Adding milestone',
    `prior_allocation_project_budget_allocation_id` BIGINT COMMENT 'Self-referencing identifier pointing to the previous version of this budget allocation when allocation_type is reallocation, supplemental, or carryover. Enables full revision chain traceability and budget change history reconstruction.',
    `actual_amount_spent` DECIMAL(18,2) COMMENT 'The actual expenditure recorded against this budget allocation to date, sourced from the finance domain general ledger reconciliation. Used to compute variance and burn rate. Distinct from allocated_amount (planned) — supports TARGET vs ACTUAL analysis for producer decision-making.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The gross approved funding amount assigned to this project phase and budget category for the fiscal period. Represents the authorized spend ceiling as approved by the designated approver. This is the planned/budgeted figure before any actuals are recorded.',
    `allocation_reference_code` STRING COMMENT 'Externally-known human-readable identifier for this budget allocation record, used in finance reconciliation, producer communications, and GL cross-referencing. Format: BA-{PROJECT_CODE}-{FISCAL_YEAR}-{SEQUENCE}. Sourced from the studio production budgeting tool (e.g., Forecast/Productive).. Valid values are `^BA-[A-Z0-9]{4,12}-[0-9]{4}-[0-9]{3}$`',
    `allocation_type` STRING COMMENT 'Classifies the nature of this budget allocation event: initial (first approved budget for the phase/category), supplemental (additional funding approved mid-cycle), reallocation (transfer from another category), contingency (reserve funding), carryover (unspent funds rolled from prior period). Supports budget history and change management tracking.. Valid values are `initial|supplemental|reallocation|contingency|carryover`',
    `approval_date` DATE COMMENT 'The calendar date on which this budget allocation was formally approved by the designated approver. Marks the point at which spend authorization becomes effective. Used for approval SLA tracking and audit trail.',
    `approval_status` STRING COMMENT 'Current workflow state of the budget allocation record. Tracks the lifecycle from initial draft through finance approval to active use and eventual closure or revision. Drives producer and finance dashboard views and controls spend authorization.. Valid values are `draft|pending_approval|approved|rejected|revised|closed`',
    `approved_timestamp` TIMESTAMP COMMENT 'The precise date and time when this budget allocation was formally approved. Distinct from approval_date (day-level) — provides exact approval time for audit trail, SLA measurement, and compliance reporting.',
    `budget_category` STRING COMMENT 'Classification of the budget allocation by spend type. Segments funding into operational categories: personnel (salaries, contractors), tools_middleware (engine licenses, SDKs, dev tools), outsourcing (third-party studios, art vendors), qa (Quality Assurance and playtesting), localization (translation, cultural adaptation), platform_fees (first-party certification, store fees). Drives cost-center reporting and variance analysis.. Valid values are `personnel|tools_middleware|outsourcing|qa|localization|platform_fees`',
    `budget_consumed_usd` DECIMAL(18,2) COMMENT 'Total budget expenditure recorded against this project to date in US Dollars (USD), sourced from SAP S/4HANA actual cost postings. Used for budget burn rate analysis and financial reporting. [Moved from dev_project: This attribute tracks total budget expenditure for the project, which should be calculated by summing actual consumption across all budget allocations. It is a derived metric that aggregates allocation-level actuals. Storing it on dev_project creates redundancy and potential inconsistency with allocation-level variance tracking.]',
    `committed_amount` DECIMAL(18,2) COMMENT 'The portion of the allocated budget that has been formally committed via purchase orders, contracts, or vendor agreements but not yet invoiced or paid. Distinct from actual_amount_spent (invoiced/paid) — enables accurate available-to-spend calculation for producers.',
    `cost_center_code` STRING COMMENT 'The SAP S/4HANA cost center code to which this budget allocation is charged. Maps the studio production spend to the finance domains organizational cost structure for GL reconciliation, management reporting, and EBITDA analysis.. Valid values are `^CC-[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget allocation record was first created in the system. Serves as the audit trail creation marker for data lineage, Silver layer ingestion tracking, and compliance purposes.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the allocated and actual amounts (e.g., USD, EUR, GBP). Required for multi-currency studio operations and finance domain reconciliation. All monetary fields in this record are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `effective_from_date` DATE COMMENT 'The start date from which this budget allocation is active and spend can be drawn against it. Defines the beginning of the allocations validity window for the fiscal period. May differ from approval_date if pre-approved for a future period.',
    `effective_until_date` DATE COMMENT 'The end date after which this budget allocation expires and unspent funds may be subject to carryover or lapse policy. Defines the closing boundary of the allocations validity window. Nullable for open-ended allocations.',
    `finance_sign_off_date` DATE COMMENT 'The date on which the Finance domain provided its formal sign-off for this budget allocation, applicable when requires_finance_sign_off is True. Completes the dual-approval governance requirement for high-value or cross-domain allocations.',
    `fiscal_period` STRING COMMENT 'The fiscal period (quarter or accounting period) within the fiscal year to which this allocation applies, e.g., Q2-2024 or P06-2024. Enables sub-annual budget tracking, burn-rate monitoring, and period-close reconciliation against the finance domain general ledger.. Valid values are `^(Q[1-4]|P(0[1-9]|1[0-2]))-[0-9]{4}$`',
    `fiscal_year` STRING COMMENT 'The fiscal year (e.g., 2024) in which this budget allocation is active and reportable. Used for annual budget planning, year-end close reconciliation, and finance domain GL alignment. Conforms to the companys fiscal calendar.',
    `gl_account_code` STRING COMMENT 'The General Ledger account code from SAP S/4HANA FI-GL that this budget allocation maps to. Enables direct reconciliation between the studio-facing operational budget view and the finance domains canonical GL entries. Critical for period-close and audit compliance.. Valid values are `^[0-9]{6,10}$`',
    `headcount_funded` STRING COMMENT 'The number of full-time equivalent (FTE) or contractor headcount positions funded by this budget allocation when budget_category is personnel. Enables workforce planning alignment with budget and supports resource allocation decisions by producers.',
    `is_contingency_reserve` BOOLEAN COMMENT 'Indicates whether this budget allocation represents a contingency reserve (risk buffer) rather than planned operational spend. True = contingency reserve held for unforeseen project risks; False = planned operational allocation. Supports risk-adjusted budget reporting.',
    `notes` STRING COMMENT 'Free-text field for producer or finance team annotations, context, or justification associated with this budget allocation. Captures business rationale for supplemental requests, reallocation decisions, or special circumstances not covered by structured fields.',
    `outsource_vendor_name` STRING COMMENT 'Name of the external vendor, third-party studio, or outsourcing partner associated with this allocation when budget_category is outsourcing. Provides producer visibility into which external partner the funds are designated for. Nullable for non-outsourcing categories.',
    `project_phase` STRING COMMENT 'Game development lifecycle phase to which this budget allocation applies. Aligns with standard game production phases: pre_production (concept, prototyping), production (full development), alpha (feature-complete), beta (content-complete), gold_master (final build certification), post_launch (live operations, patches, DLC). Enables phase-gated budget tracking.. Valid values are `pre_production|production|alpha|beta|gold_master|post_launch`',
    `rejection_reason` STRING COMMENT 'Free-text explanation provided by the approver when a budget allocation request is rejected (approval_status = rejected). Captures the business rationale for rejection to support resubmission, producer decision-making, and governance audit trail.',
    `remaining_amount` DECIMAL(18,2) COMMENT 'The uncommitted balance remaining in this allocation (allocated_amount minus actual_amount_spent). Provides the studio-facing operational view of available spend for the period and category. Supports real-time producer budget management and re-forecasting decisions.',
    `requires_finance_sign_off` BOOLEAN COMMENT 'Indicates whether this budget allocation requires additional sign-off from the Finance domain (beyond the studio approver) due to amount thresholds, allocation type, or governance policy. Drives workflow routing in the approval process.',
    `revision_number` STRING COMMENT 'Sequential version counter tracking how many times this budget allocation has been revised or reforecast. Starts at 0 for the initial approved allocation. Enables change history analysis and supports budget governance by identifying frequently revised allocations.',
    `source_system_ref` STRING COMMENT 'The native record identifier from the originating studio production budgeting tool (e.g., Forecast.app budget line ID, Productive.io budget entry ID). Enables traceability and reconciliation back to the source system of record for audit and data lineage purposes.',
    `submitted_timestamp` TIMESTAMP COMMENT 'The precise date and time when this budget allocation request was submitted for approval in the production budgeting tool. Supports approval cycle time measurement and SLA compliance tracking.',
    `total_budget_usd` DECIMAL(18,2) COMMENT 'Total approved development budget for this project in US Dollars (USD), as recorded in SAP S/4HANA Project System. Includes all labor, licensing, tooling, and infrastructure costs allocated to the project. [Moved from dev_project: This attribute represents the total approved budget for the project, which is actually the SUM of all allocation_amount values across all budget allocations for this project. It is a derived/aggregated value that should be calculated from the association table, not stored redundantly on dev_project. Keeping it on dev_project creates a synchronization risk where total_budget_usd could become inconsistent with the sum of allocations.]',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget allocation record was most recently modified. Tracks revisions, reforecasts, and status changes for audit trail and incremental data pipeline processing in the Databricks Silver layer.',
    `variance_pct` DECIMAL(18,2) COMMENT 'The percentage difference between the allocated budget amount and the actual amount spent, expressed as a signed decimal (positive = over budget, negative = under budget). Sourced from the studio production budgeting tool reconciliation. Key KPI for producer budget health monitoring and finance reporting.',
    `wbs_element_code` STRING COMMENT 'The Work Breakdown Structure element code from SAP S/4HANA Project System (PS) that this allocation is associated with. Provides granular project cost tracking at the deliverable or milestone level, enabling detailed budget-to-actual analysis by work package.',
    CONSTRAINT pk_project_budget_allocation PRIMARY KEY(`project_budget_allocation_id`)
) COMMENT 'Development budget allocation records representing approved funding assigned to a project by phase and category. Captures allocated amount, currency, budget category (personnel, tools/middleware, outsourcing, QA, localization, platform fees), fiscal period, approval status, variance-to-actual percentage, and approver. Sourced from studio production budgeting tool (e.g., Forecast/Productive) with reconciliation against finance domains general ledger. Provides the studio-facing operational budget view for producer decision-making; finance domain owns the canonical GL entries.';

CREATE OR REPLACE TABLE `gaming_ecm`.`studio`.`engine_config` (
    `engine_config_id` BIGINT COMMENT 'Unique surrogate identifier for the engine configuration record. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Engine configuration approval workflows for platform certification and build pipeline stability require tracking which technical lead or architect authorized each config version. The approved_by text ',
    `dev_project_id` BIGINT COMMENT 'Reference to the development project this engine configuration is associated with. A single project may have multiple versioned engine configs over its lifecycle.',
    `repo_id` BIGINT COMMENT 'Foreign key linking to studio.repo. Business justification: Engine configurations are stored in specific Perforce repositories. The engine_config table has perforce_depot_path (STRING) but no FK to repo. Adding repo_id FK provides proper referential integrity ',
    `animation_system` STRING COMMENT 'Animation system module enabled in this engine configuration, e.g., Unity Animator/Mecanim, Unreal Control Rig, Unreal Sequencer, or a custom animation pipeline. Affects character fidelity, memory budget, and asset pipeline tooling.. Valid values are `Animator|Mecanim|Control Rig|Sequencer|Custom|None`',
    `api_backend` STRING COMMENT 'Graphics API (Application Programming Interface) backend configured for this engine, e.g., DirectX 12, Vulkan, Metal (Apple), GNM/AGC (PlayStation). Determines platform compatibility, driver requirements, and rendering feature availability. [ENUM-REF-CANDIDATE: DirectX12|DirectX11|Vulkan|Metal|OpenGL|GNM|AGC — 7 candidates stripped; promote to reference product]',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this engine configuration was formally approved as the authoritative build baseline. Marks the transition from draft to active status and triggers CI/CD pipeline adoption.',
    `audio_middleware` STRING COMMENT 'Audio middleware or engine audio module enabled in this configuration, e.g., FMOD Studio, Wwise, Unity Audio, Unreal Audio Engine. Determines spatial audio capabilities, memory budget for audio assets, and platform audio certification requirements.. Valid values are `FMOD|Wwise|Unity Audio|Unreal Audio|Custom|None`',
    `build_configuration` STRING COMMENT 'Build configuration mode for this engine configuration, e.g., Debug (full symbols, logging), Development (profiling enabled), Shipping/Release (optimized, DRM-enabled, no debug symbols). Determines compiler optimization level, logging verbosity, and certification eligibility.. Valid values are `Debug|Development|Shipping|Release|Profile`',
    `change_notes` STRING COMMENT 'Free-text notes describing what changed in this version of the engine configuration relative to the previous version. Supports configuration diff review, sprint retrospectives, and post-mortem analysis.',
    `cicd_pipeline_url` STRING COMMENT 'URL of the Continuous Integration/Continuous Deployment (CI/CD) pipeline job that consumes this engine configuration as its authoritative build settings baseline. Used by build engineers to trace configuration-to-pipeline linkage.',
    `compression_method` STRING COMMENT 'Asset compression algorithm configured for this engine build, e.g., LZ4 (fast decompression), Oodle (high ratio), LZMA (maximum compression). Affects package size, load times, and platform distribution requirements (e.g., app store size limits).. Valid values are `None|LZ4|Zlib|LZMA|Oodle|Brotli`',
    `config_code` STRING COMMENT 'Externally-known short code or slug uniquely identifying this configuration artifact across build systems and CI/CD pipelines, e.g., ALPHA-UE5-PC-003. Used as the business identifier in Perforce depot paths and Jira references.. Valid values are `^[A-Z0-9_-]{3,50}$`',
    `config_description` STRING COMMENT 'Free-text description of the purpose, scope, and notable settings of this engine configuration record. Provides context for build engineers, QA teams, and technical directors reviewing configuration history.',
    `config_name` STRING COMMENT 'Human-readable name identifying this engine configuration record, e.g., ProjectAlpha_UE5_PC_v3. Used as the primary identity label for the configuration artifact in Perforce and build pipeline references.',
    `config_status` STRING COMMENT 'Current lifecycle status of the engine configuration record. draft indicates work-in-progress; active is the current authoritative baseline; deprecated indicates superseded by a newer version; archived is retained for historical reference; locked indicates a gold-master-frozen state.. Valid values are `draft|active|deprecated|archived|locked`',
    `config_version` STRING COMMENT 'Semantic version of this engine configuration artifact, e.g., v1.0.0, v2.3.1. Incremented when configuration parameters change. Enables versioned rollback and diff comparison in Perforce.. Valid values are `^v[0-9]+.[0-9]+(.[0-9]+)?$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this engine configuration record was first created in the system. Audit trail field supporting configuration lifecycle tracking and data lineage.',
    `deprecated_timestamp` TIMESTAMP COMMENT 'Date and time when this engine configuration was deprecated and superseded by a newer version. Null if still active. Supports lifecycle management and audit trail for configuration change history.',
    `draw_call_budget` STRING COMMENT 'Maximum allowed GPU draw calls per frame defined in this engine configuration. A key rendering performance budget threshold used to enforce LOD, batching, and culling strategies during QA and build pipeline validation.',
    `drm_solution` STRING COMMENT 'Digital Rights Management (DRM) solution integrated in this engine configurations shipping build, e.g., Denuvo, Steam DRM, Epic Games Store DRM, or platform-native DRM (PlayStation, Xbox). Affects build pipeline steps, certification requirements, and performance overhead.. Valid values are `None|Denuvo|Steam DRM|EGS DRM|Platform Native|Custom`',
    `engine_platform` STRING COMMENT 'The game engine platform used for this project configuration, e.g., Unity, Unreal Engine, or a proprietary in-house engine. Drives build pipeline toolchain selection and SDK compatibility requirements.. Valid values are `Unity|Unreal Engine|Proprietary|Godot|CryEngine|O3DE`',
    `engine_version` STRING COMMENT 'Specific version string of the game engine used, e.g., 5.3.2, 2022.3.10f1. Critical for build reproducibility, platform certification compliance, and dependency management in Perforce.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?(.[0-9]+)?(-[a-zA-Z0-9]+)?$`',
    `gaas_live_ops_enabled` BOOLEAN COMMENT 'Indicates whether this engine configuration includes live operations (GaaS) modules such as hot-patch delivery, remote config, live event scripting, or over-the-air asset streaming. Relevant for GaaS titles requiring post-launch content updates without full re-certification.',
    `is_template` BOOLEAN COMMENT 'Indicates whether this engine configuration record is a reusable template that can be applied across multiple projects. Template configs are maintained centrally and referenced by project-specific configs to enforce studio-wide engine standards.',
    `jira_config_ticket` STRING COMMENT 'Jira ticket key associated with the change request or epic that introduced or last modified this engine configuration, e.g., ALPHA-1042. Provides traceability between configuration changes and sprint/backlog items in the project management system.. Valid values are `^[A-Z]+-[0-9]+$`',
    `lod_config_enabled` BOOLEAN COMMENT 'Indicates whether Level of Detail (LOD) mesh reduction and streaming is enabled in this engine configuration. LOD management is critical for maintaining target FPS across hardware tiers and reducing GPU draw call budgets.',
    `lod_levels` STRING COMMENT 'Number of LOD levels configured for mesh assets in this engine configuration, e.g., 3 or 4 levels. Higher LOD level counts improve performance on lower-end hardware but increase asset pipeline complexity and storage requirements.',
    `memory_budget_mb` STRING COMMENT 'Maximum allowed runtime memory consumption in megabytes (MB) for this engine configuration. Enforced as a performance budget threshold in build pipeline checks and QA stability benchmarks. Varies by target platform hardware tier.',
    `min_os_version` STRING COMMENT 'Minimum operating system or firmware version required to run a build produced from this engine configuration, e.g., iOS 15.0, Android 10, Windows 10 21H2. Drives app store metadata, platform certification eligibility, and player hardware requirement disclosures.',
    `networking_sdk` STRING COMMENT 'Networking SDK or middleware module enabled in this configuration, e.g., Photon, Mirror, Unity Netcode for GameObjects, Unreal Online Subsystem, EOS (Epic Online Services), PlayFab. Determines multiplayer architecture and CCU/PCU scalability characteristics.',
    `perforce_changelist` BIGINT COMMENT 'Perforce changelist number at which this engine configuration version was submitted. Enables precise point-in-time reconstruction of the build environment for QA, certification, and post-mortem analysis.',
    `physics_engine` STRING COMMENT 'Physics simulation engine module enabled in this configuration, e.g., PhysX (Unity/Unreal legacy), Chaos (Unreal 5+), Havok, or a custom physics solution. Affects simulation fidelity, CPU budget, and platform compatibility.. Valid values are `PhysX|Chaos|Havok|Bullet|Custom|None`',
    `rendering_pipeline` STRING COMMENT 'The rendering pipeline module enabled for this engine configuration, e.g., Unity URP (Universal Render Pipeline), Unity HDRP (High Definition Render Pipeline), Unreal Lumen/Nanite, or a custom deferred/forward renderer. Determines visual fidelity capabilities and GPU performance budget. [ENUM-REF-CANDIDATE: URP|HDRP|Built-In|Lumen|Nanite|Custom|Deferred|Forward — 8 candidates stripped; promote to reference product]',
    `scripting_backend` STRING COMMENT 'Scripting backend or language runtime used in this engine configuration, e.g., Unity Mono, Unity IL2CPP, Unreal Blueprints, Unreal C++. Affects build times, runtime performance, platform compatibility, and DRM/obfuscation capabilities.. Valid values are `Mono|IL2CPP|C++|Blueprints|C#|Lua`',
    `sdk_versions` STRING COMMENT 'JSON-serialized or comma-delimited map of platform SDK versions included in this engine configuration, e.g., PS5SDK:10.0.0,GDK:221000,iOS:17.0. Required for platform certification (TRC/TCR) compliance verification and first-party submission readiness.',
    `shader_model_version` STRING COMMENT 'DirectX Shader Model version targeted by this engine configuration, e.g., SM5, SM6. Determines GPU feature set availability (ray tracing, mesh shaders) and minimum hardware requirements for platform certification.. Valid values are `^SM[0-9](_[0-9])?$`',
    `target_fps` STRING COMMENT 'Target rendering frame rate in frames per second (FPS) for this engine configuration, e.g., 30, 60, 120. Defines the primary performance budget threshold against which QA stability benchmarks and platform certification tests are evaluated.',
    `target_platforms` STRING COMMENT 'Comma-separated list of target hardware/OS platforms this configuration builds for, e.g., PC,PS5,XboxSeriesX,iOS,Android,Switch. Drives platform-specific compiler flags, SDK inclusions, and first-party certification requirements (TRC/TCR). [ENUM-REF-CANDIDATE: PC|PS5|XboxSeriesX|iOS|Android|Switch|PS4|XboxOne|macOS|Linux|VR|AR — promote to reference product]',
    `template_source_reference` BIGINT COMMENT 'Reference to the parent template engine configuration from which this project-specific configuration was derived. Null if this record is itself a template or was created from scratch. Enables template lineage tracking and bulk template update propagation.',
    `texture_budget_mb` STRING COMMENT 'Maximum allowed GPU texture memory in megabytes (MB) for this engine configuration. Enforced during asset pipeline validation and QA performance benchmarking to prevent VRAM overflow on target platform hardware.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this engine configuration record was last modified. Audit trail field used to detect stale configurations and trigger downstream pipeline refresh notifications.',
    CONSTRAINT pk_engine_config PRIMARY KEY(`engine_config_id`)
) COMMENT 'Game engine configuration records per project capturing the authoritative engine setup baseline for each projects build pipeline. Records engine platform (Unity, Unreal Engine, proprietary), engine version, licensed modules enabled (rendering pipeline, physics engine, networking SDK, animation system), target platform build settings, LOD configuration, and performance budget thresholds (target FPS, memory budget, draw call budget). Maintained as a versioned configuration artifact in Perforce alongside project source. Exists as a standalone entity because engine configs are versioned independently of project metadata, may be templated across multiple projects, and are referenced by build pipeline for compilation settings.';

CREATE OR REPLACE TABLE `gaming_ecm`.`studio`.`vendor_work_package` (
    `vendor_work_package_id` BIGINT COMMENT 'Unique identifier for the vendor work package record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Vendor packages are cost tracking units with dedicated cost center assignments. Required for outsourcing cost management, accrual tracking, and vendor invoice reconciliation.',
    `dev_project_id` BIGINT COMMENT 'Reference to the game development project to which this vendor work package is associated.',
    `employee_id` BIGINT COMMENT 'Reference to the internal producer or project manager responsible for overseeing this vendor work package.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Vendor packages consume outsourcing budget line items. Required for vendor budget tracking, commitment accounting, and outsourcing spend analysis against approved budgets.',
    `game_studio_id` BIGINT COMMENT 'Reference to the external co-development studio, art house, audio contractor, or QA (Quality Assurance) vendor assigned to this work package.',
    `infrastructure_deployment_id` BIGINT COMMENT 'Foreign key linking to infrastructure.infrastructure_deployment. Business justification: Vendor deliverables (outsourced content, DLC) require infrastructure deployment. Tracks external content deployment, vendor acceptance criteria tied to production deployment, and outsourced asset deli',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: External vendor deliverables (outsourced art, audio, code) may include licensed IP (brand assets, middleware). Agreement tracking ensures compliance with usage restrictions and royalty obligations for',
    `milestone_id` BIGINT COMMENT 'Reference to the project milestone to which this vendor work package is aligned or contributes.',
    `repo_id` BIGINT COMMENT 'Foreign key linking to studio.repo. Business justification: Vendor deliverables are submitted to specific Perforce repositories. The vendor_work_package table has perforce_depot_path (STRING) but no FK to repo. Adding repo_id FK provides proper referential int',
    `test_plan_id` BIGINT COMMENT 'Foreign key linking to quality.test_plan. Business justification: Vendor deliverables require acceptance testing; studios create test plans to validate vendor work packages before payment. Vendor payment milestones require test plan sign-off on deliverables. Creatin',
    `third_party_processor_id` BIGINT COMMENT 'Foreign key linking to compliance.third_party_processor. Business justification: Vendor studios processing player data (e.g., QA testing with live data) are third-party processors under GDPR. Vendor_work_package.nda_executed hints at data handling; direct link enables processor co',
    `parent_vendor_work_package_id` BIGINT COMMENT 'Self-referencing FK on vendor_work_package (parent_vendor_work_package_id)',
    `acceptance_criteria` STRING COMMENT 'Detailed acceptance criteria and quality standards that the vendor deliverable must meet for sign-off.',
    `actual_delivery_date` DATE COMMENT 'Actual date on which the vendor delivered the work package to the internal studio.',
    `asset_count` STRING COMMENT 'Number of individual assets (models, textures, audio files, animations, etc.) included in this vendor work package deliverable.',
    `contracted_amount` DECIMAL(18,2) COMMENT 'Total contracted or agreed-upon cost for this vendor work package in the specified currency.',
    `cost_allocation_reference` STRING COMMENT 'Reference code or identifier linking this work package to the project budget allocation or purchase order for cost tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor work package record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the contracted amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deliverable_type` STRING COMMENT 'Category of deliverable being outsourced: art assets, audio, animation, level design, porting, QA (Quality Assurance), programming, VFX (Visual Effects), cinematics, or localization. [ENUM-REF-CANDIDATE: art-assets|audio|animation|level-design|porting|qa|programming|vfx|cinematics|localization — 10 candidates stripped; promote to reference product]',
    `delivery_milestone_date` DATE COMMENT 'Planned or contractual date by which the vendor is expected to deliver the work package.',
    `gaas_live_ops_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this vendor work package is part of a GaaS (Game as a Service) live operations content update or seasonal release.',
    `game_engine` STRING COMMENT 'Game engine technology the vendor is using or targeting for this work package (Unity, Unreal, Proprietary, CryEngine, Godot, Other).. Valid values are `Unity|Unreal|Proprietary|CryEngine|Godot|Other`',
    `ip_ownership_terms` STRING COMMENT 'Intellectual property ownership terms and rights assignment for the deliverables produced by the vendor under this work package.',
    `jira_epic_key` STRING COMMENT 'Jira epic identifier linking this vendor work package to the project management backlog and sprint planning.',
    `nda_executed` BOOLEAN COMMENT 'Boolean flag indicating whether a Non-Disclosure Agreement has been executed with the vendor for this work package.',
    `notes` STRING COMMENT 'Free-form notes or comments providing additional context, instructions, or observations about this vendor work package.',
    `package_code` STRING COMMENT 'Unique business identifier or reference code for the work package, used for tracking and invoicing.',
    `package_name` STRING COMMENT 'Human-readable name or title of the vendor work package, identifying the deliverable scope.',
    `package_status` STRING COMMENT 'Current lifecycle status of the vendor work package: scoped, in-progress, delivered, accepted, rejected, on-hold, or cancelled. [ENUM-REF-CANDIDATE: scoped|in-progress|delivered|accepted|rejected|on-hold|cancelled — 7 candidates stripped; promote to reference product]',
    `perforce_changelist` STRING COMMENT 'Perforce changelist number associated with the integration or submission of the vendor deliverable into the version control system.',
    `priority_rank` STRING COMMENT 'Numeric priority ranking of this work package relative to other vendor deliverables, used for resource allocation and scheduling.',
    `qa_sign_off_date` DATE COMMENT 'Date on which the internal QA (Quality Assurance) team approved the vendor deliverable.',
    `qa_sign_off_status` STRING COMMENT 'Quality assurance sign-off status indicating whether the deliverable has passed internal QA (Quality Assurance) review: pending, in-review, approved, rejected, or not-required.. Valid values are `pending|in-review|approved|rejected|not-required`',
    `rejection_reason` STRING COMMENT 'Detailed explanation or reason provided when the vendor deliverable was rejected during QA (Quality Assurance) or UAT (User Acceptance Testing) review.',
    `revision_count` STRING COMMENT 'Number of revision cycles or iterations the vendor work package has undergone due to feedback or rejection.',
    `risk_level` STRING COMMENT 'Assessed risk level for this vendor work package based on complexity, vendor track record, and schedule criticality: low, medium, high, or critical.. Valid values are `low|medium|high|critical`',
    `risk_notes` STRING COMMENT 'Detailed notes describing identified risks, mitigation strategies, and contingency plans for this vendor work package.',
    `schedule_variance_days` STRING COMMENT 'Number of days the actual delivery date deviated from the planned milestone date. Positive indicates delay, negative indicates early delivery.',
    `scope_description` STRING COMMENT 'Detailed textual description of the work package scope, deliverables, and technical requirements.',
    `source_record_reference` STRING COMMENT 'Unique identifier of this work package record in the source vendor management or production tracking system.',
    `source_system` STRING COMMENT 'Name of the vendor management or production tracking system from which this work package record was sourced (e.g., Shotgrid, Monday.com, Jira).',
    `target_platform` STRING COMMENT 'Target gaming platform(s) for which the vendor deliverable is being produced (e.g., PC, PlayStation, Xbox, Nintendo Switch, mobile).',
    `uat_sign_off_date` DATE COMMENT 'Date on which the UAT (User Acceptance Testing) team or stakeholders approved the vendor deliverable.',
    `uat_sign_off_status` STRING COMMENT 'User acceptance testing sign-off status indicating whether the deliverable has passed UAT (User Acceptance Testing) review: pending, in-review, approved, rejected, or not-required.. Valid values are `pending|in-review|approved|rejected|not-required`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor work package record was last modified or updated.',
    `vendor_contact_email` STRING COMMENT 'Email address of the primary vendor contact for communication and coordination on this work package.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `vendor_contact_name` STRING COMMENT 'Name of the primary contact person at the vendor studio responsible for this work package.',
    CONSTRAINT pk_vendor_work_package PRIMARY KEY(`vendor_work_package_id`)
) COMMENT 'Outsourced deliverable package records tracking work assigned to external co-development studios, art houses, audio contractors, and QA vendors. Captures package name, vendor studio (FK to game_studio), associated project (FK to dev_project), deliverable type (art assets, audio, animation, level design, porting, QA), acceptance criteria, delivery milestone date, actual delivery date, package status (scoped, in-progress, delivered, accepted, rejected), revision count, and cost allocation reference. Sourced from vendor management portals (Shotgrid/Monday.com) or studio production tracking. Essential for AAA co-development workflows where 30-60% of production is outsourced.';

CREATE OR REPLACE TABLE `gaming_ecm`.`studio`.`certification_test_run` (
    `certification_test_run_id` BIGINT COMMENT 'Unique identifier for this certification test run record. Primary key.',
    `build_id` BIGINT COMMENT 'Foreign key linking to the game build being tested for platform certification compliance',
    `certification_checklist_id` BIGINT COMMENT 'Foreign key linking to the platform certification checklist (TRC/TCR) being applied to this build',
    `employee_id` BIGINT COMMENT 'Reference to the QA engineer or certification specialist who executed this test run.',
    `advisory_failure_count` STRING COMMENT 'The number of advisory (non-blocking) requirements that failed in this test run.',
    `certification_outcome` STRING COMMENT 'The final outcome decision from the platform holder for this certification test run. Values: approved (build certified for release), rejected (build failed certification), resubmission_required (build must be fixed and resubmitted), pending_review (awaiting platform holder decision).',
    `certification_status` STRING COMMENT 'Current status of the platform certification review for this build with the relevant first-party platform holder. Tracks the build through the TRC/TCR certification lifecycle from submission to approval or rejection. [Moved from build: This attribute represents the certification review status for a specific build-checklist pairing. A single build can have different certification statuses for different platform checklists (e.g., passed PlayStation TRC but failed Xbox TCR). The status belongs to the test run association, not the build entity.]. Valid values are `not_submitted|submitted|in_review|approved|rejected`',
    `compliance_status` STRING COMMENT 'Current compliance status of this build against this checklist. Values: pending (not yet tested), in_progress (testing underway), passed (all requirements met), failed (one or more mandatory requirements failed), conditional_pass (passed with conditions), waived (failed requirements waived by platform holder).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) when this certification test run record was first created in the data platform.',
    `failure_count` STRING COMMENT 'The number of certification requirements that failed in this test run.',
    `mandatory_pass_count` STRING COMMENT 'The number of mandatory requirements that passed in this test run.',
    `notes` STRING COMMENT 'Free-text notes from the certification testing process, including tester observations, platform holder feedback, or waiver justifications.',
    `platform_submission_reference` STRING COMMENT 'The external submission identifier or tracking number assigned by the platform holder for this certification test run.',
    `resubmission_number` STRING COMMENT 'The sequential resubmission attempt number for this build-checklist pairing (1 for first submission, 2 for first resubmission, etc.).',
    `test_completed_timestamp` TIMESTAMP COMMENT 'The exact date and time (UTC) when certification testing was completed for this build-checklist pairing.',
    `test_execution_date` DATE COMMENT 'The date when this certification test run was executed against the build.',
    `test_started_timestamp` TIMESTAMP COMMENT 'The exact date and time (UTC) when certification testing began for this build-checklist pairing.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) when this certification test run record was last modified in the data platform.',
    `waiver_count` STRING COMMENT 'The number of certification requirements for which waivers were requested or granted in this test run.',
    CONSTRAINT pk_certification_test_run PRIMARY KEY(`certification_test_run_id`)
) COMMENT 'This association product represents the execution event of testing a specific game build against a specific platform certification checklist (TRC/TCR/Lotcheck). It captures the compliance evaluation results, test execution metadata, waiver requests, and certification outcomes that exist only in the context of this build-checklist pairing. Each record links one build to one certification checklist with attributes tracking the testing process and results.. Existence Justification: In gaming platform certification, a single game build must be tested against multiple platform certification checklists (PlayStation TRC, Xbox TCR, Nintendo Lotcheck, etc.) because games are typically released on multiple platforms. Conversely, each certification checklist is applied to many different builds over time as new games and updates are submitted. The business actively manages certification test runs as operational records, tracking compliance status, test results, waivers, and outcomes for each build-checklist pairing.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ADD CONSTRAINT `fk_studio_game_studio_parent_studio_game_studio_id` FOREIGN KEY (`parent_studio_game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ADD CONSTRAINT `fk_studio_dev_project_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ADD CONSTRAINT `fk_studio_sprint_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ADD CONSTRAINT `fk_studio_sprint_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ADD CONSTRAINT `fk_studio_sprint_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `gaming_ecm`.`studio`.`milestone`(`milestone_id`);
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ADD CONSTRAINT `fk_studio_backlog_item_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ADD CONSTRAINT `fk_studio_backlog_item_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ADD CONSTRAINT `fk_studio_backlog_item_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `gaming_ecm`.`studio`.`milestone`(`milestone_id`);
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ADD CONSTRAINT `fk_studio_backlog_item_sprint_id` FOREIGN KEY (`sprint_id`) REFERENCES `gaming_ecm`.`studio`.`sprint`(`sprint_id`);
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ADD CONSTRAINT `fk_studio_milestone_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ADD CONSTRAINT `fk_studio_milestone_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`studio`.`build` ADD CONSTRAINT `fk_studio_build_changelist_id` FOREIGN KEY (`changelist_id`) REFERENCES `gaming_ecm`.`studio`.`changelist`(`changelist_id`);
ALTER TABLE `gaming_ecm`.`studio`.`build` ADD CONSTRAINT `fk_studio_build_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`studio`.`build` ADD CONSTRAINT `fk_studio_build_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`studio`.`build` ADD CONSTRAINT `fk_studio_build_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `gaming_ecm`.`studio`.`milestone`(`milestone_id`);
ALTER TABLE `gaming_ecm`.`studio`.`build` ADD CONSTRAINT `fk_studio_build_repo_id` FOREIGN KEY (`repo_id`) REFERENCES `gaming_ecm`.`studio`.`repo`(`repo_id`);
ALTER TABLE `gaming_ecm`.`studio`.`repo` ADD CONSTRAINT `fk_studio_repo_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`studio`.`repo` ADD CONSTRAINT `fk_studio_repo_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ADD CONSTRAINT `fk_studio_changelist_backlog_item_id` FOREIGN KEY (`backlog_item_id`) REFERENCES `gaming_ecm`.`studio`.`backlog_item`(`backlog_item_id`);
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ADD CONSTRAINT `fk_studio_changelist_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ADD CONSTRAINT `fk_studio_changelist_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `gaming_ecm`.`studio`.`milestone`(`milestone_id`);
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ADD CONSTRAINT `fk_studio_changelist_sprint_id` FOREIGN KEY (`sprint_id`) REFERENCES `gaming_ecm`.`studio`.`sprint`(`sprint_id`);
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ADD CONSTRAINT `fk_studio_resource_allocation_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ADD CONSTRAINT `fk_studio_resource_allocation_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ADD CONSTRAINT `fk_studio_resource_allocation_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `gaming_ecm`.`studio`.`milestone`(`milestone_id`);
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ADD CONSTRAINT `fk_studio_resource_allocation_sprint_id` FOREIGN KEY (`sprint_id`) REFERENCES `gaming_ecm`.`studio`.`sprint`(`sprint_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ADD CONSTRAINT `fk_studio_partnership_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ADD CONSTRAINT `fk_studio_partnership_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ADD CONSTRAINT `fk_studio_partnership_partnership_partner_studio_game_studio_id` FOREIGN KEY (`partnership_partner_studio_game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ADD CONSTRAINT `fk_studio_project_budget_allocation_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ADD CONSTRAINT `fk_studio_project_budget_allocation_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `gaming_ecm`.`studio`.`milestone`(`milestone_id`);
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ADD CONSTRAINT `fk_studio_project_budget_allocation_prior_allocation_project_budget_allocation_id` FOREIGN KEY (`prior_allocation_project_budget_allocation_id`) REFERENCES `gaming_ecm`.`studio`.`project_budget_allocation`(`project_budget_allocation_id`);
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ADD CONSTRAINT `fk_studio_engine_config_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ADD CONSTRAINT `fk_studio_engine_config_repo_id` FOREIGN KEY (`repo_id`) REFERENCES `gaming_ecm`.`studio`.`repo`(`repo_id`);
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ADD CONSTRAINT `fk_studio_vendor_work_package_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ADD CONSTRAINT `fk_studio_vendor_work_package_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ADD CONSTRAINT `fk_studio_vendor_work_package_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `gaming_ecm`.`studio`.`milestone`(`milestone_id`);
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ADD CONSTRAINT `fk_studio_vendor_work_package_repo_id` FOREIGN KEY (`repo_id`) REFERENCES `gaming_ecm`.`studio`.`repo`(`repo_id`);
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ADD CONSTRAINT `fk_studio_vendor_work_package_parent_vendor_work_package_id` FOREIGN KEY (`parent_vendor_work_package_id`) REFERENCES `gaming_ecm`.`studio`.`vendor_work_package`(`vendor_work_package_id`);
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ADD CONSTRAINT `fk_studio_certification_test_run_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);

-- ========= TAGS =========
ALTER SCHEMA `gaming_ecm`.`studio` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `gaming_ecm`.`studio` SET TAGS ('dbx_domain' = 'studio');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` SET TAGS ('dbx_subdomain' = 'studio_operations');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Game Studio ID');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `parent_studio_game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Studio ID');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Studio Acquisition Date');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `active_project_count` SET TAGS ('dbx_business_glossary_term' = 'Active Project Count');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `cicd_pipeline_enabled` SET TAGS ('dbx_business_glossary_term' = 'Continuous Integration/Continuous Deployment (CI/CD) Pipeline Enabled');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `contract_tier` SET TAGS ('dbx_business_glossary_term' = 'Contractual Relationship Tier');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `contract_tier` SET TAGS ('dbx_value_regex' = 'strategic|preferred|standard|transactional');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `contract_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `coppa_compliant` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Compliant');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `crm_account_reference` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM Account ID');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `data_processing_agreement` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Agreement (DPA) Executed');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Studio Dissolution Date');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `engine_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Game Engine');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `engine_primary` SET TAGS ('dbx_value_regex' = 'unity|unreal|proprietary|godot|cryengine|other');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `erp_vendor_reference` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Vendor ID');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `esrb_registered` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Software Rating Board (ESRB) Registered');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `founding_date` SET TAGS ('dbx_business_glossary_term' = 'Studio Founding Date');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `gaas_capable` SET TAGS ('dbx_business_glossary_term' = 'Game as a Service (GaaS) Capable');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `headcount_range` SET TAGS ('dbx_business_glossary_term' = 'Studio Headcount Range');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `headcount_range` SET TAGS ('dbx_value_regex' = '1_10|11_50|51_200|201_500|501_1000|1001_plus');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `hq_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `hq_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `ip_ownership_model` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Ownership Model');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `ip_ownership_model` SET TAGS ('dbx_value_regex' = 'publisher_owned|studio_owned|co_owned|licensed_in|licensed_out');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `ip_ownership_model` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `iso27001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO/IEC 27001 Information Security Certified');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `jira_project_key` SET TAGS ('dbx_business_glossary_term' = 'Jira Project Key');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `jira_project_key` SET TAGS ('dbx_value_regex' = '^[A-Z][A-Z0-9]{1,9}$');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `pci_dss_compliant` SET TAGS ('dbx_business_glossary_term' = 'Payment Card Industry Data Security Standard (PCI DSS) Compliant');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `pegi_registered` SET TAGS ('dbx_business_glossary_term' = 'Pan European Game Information (PEGI) Registered');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `platform_focus` SET TAGS ('dbx_business_glossary_term' = 'Platform Focus');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `platform_focus` SET TAGS ('dbx_value_regex' = 'console|pc|mobile|cross_platform|vr_ar|cloud');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Studio Primary Contact Email');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Studio Primary Contact Name');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Studio Primary Contact Phone');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `qa_embedded` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Embedded');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `revenue_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `revenue_share_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `soc2_compliant` SET TAGS ('dbx_business_glossary_term' = 'SOC 2 Compliant');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `specialization` SET TAGS ('dbx_business_glossary_term' = 'Studio Specialization');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `studio_code` SET TAGS ('dbx_business_glossary_term' = 'Studio Code');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `studio_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `studio_name` SET TAGS ('dbx_business_glossary_term' = 'Studio Name');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `studio_status` SET TAGS ('dbx_business_glossary_term' = 'Studio Lifecycle Status');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `studio_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_hold|dissolved|acquired|divested');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `studio_type` SET TAGS ('dbx_business_glossary_term' = 'Studio Type');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `studio_type` SET TAGS ('dbx_value_regex' = 'first_party|second_party|third_party|co_development|indie|work_for_hire');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `titles_shipped_count` SET TAGS ('dbx_business_glossary_term' = 'Titles Shipped Count');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `vcs_depot_path` SET TAGS ('dbx_business_glossary_term' = 'Version Control System (VCS) Depot Path');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Studio Website URL');
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://[^s/$.?#].[^s]*$');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` SET TAGS ('dbx_subdomain' = 'studio_operations');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Development Project ID');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `developer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Developer Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `privacy_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Impact Assessment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `cert_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Platform Certification Approval Date');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `cert_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Platform Certification Submission Date');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `cicd_pipeline_url` SET TAGS ('dbx_business_glossary_term' = 'Continuous Integration/Continuous Deployment (CI/CD) Pipeline URL');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `coppa_applicable` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Applicable Flag');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `critical_bug_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Bug Count');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `current_sprint_number` SET TAGS ('dbx_business_glossary_term' = 'Current Sprint Number');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `development_methodology` SET TAGS ('dbx_business_glossary_term' = 'Development Methodology');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `development_methodology` SET TAGS ('dbx_value_regex' = 'agile|scrum|kanban|waterfall|hybrid');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `engine_version` SET TAGS ('dbx_business_glossary_term' = 'Game Engine Version');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `engine_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `game_engine` SET TAGS ('dbx_business_glossary_term' = 'Game Engine');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `game_engine` SET TAGS ('dbx_value_regex' = 'unity|unreal_engine|proprietary|godot|other');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `gold_master_date` SET TAGS ('dbx_business_glossary_term' = 'Gold Master (GM) Date');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `has_mtx` SET TAGS ('dbx_business_glossary_term' = 'Microtransactions (MTX) Flag');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `has_ugc` SET TAGS ('dbx_business_glossary_term' = 'User-Generated Content (UGC) Flag');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `headcount_allocated` SET TAGS ('dbx_business_glossary_term' = 'Headcount Allocated');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `is_first_party` SET TAGS ('dbx_business_glossary_term' = 'First-Party Studio Flag');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `is_gaas_title` SET TAGS ('dbx_business_glossary_term' = 'Game-as-a-Service (GaaS) Title Flag');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `jira_project_key` SET TAGS ('dbx_business_glossary_term' = 'Jira Project Key');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `jira_project_key` SET TAGS ('dbx_value_regex' = '^[A-Z][A-Z0-9]{1,9}$');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `milestone_completion_pct` SET TAGS ('dbx_business_glossary_term' = 'Milestone Completion Percentage');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `open_bug_count` SET TAGS ('dbx_business_glossary_term' = 'Open Bug Count');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `perforce_depot_path` SET TAGS ('dbx_business_glossary_term' = 'Perforce Depot Path');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Development Project Code');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `project_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Development Project Description');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Development Project Name');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Development Project Phase');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `project_phase` SET TAGS ('dbx_value_regex' = 'pre_production|production|alpha|beta|gold_master|post_launch');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Development Project Status');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `project_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|cancelled|completed|archived');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Development Project Type');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'new_ip|sequel|dlc|gaas_live_ops|port|remaster');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `soft_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Soft Launch Date');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `sprint_cadence_weeks` SET TAGS ('dbx_business_glossary_term' = 'Sprint Cadence (Weeks)');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `target_platforms` SET TAGS ('dbx_business_glossary_term' = 'Target Platforms');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `target_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Target Ship Date');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `uat_sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'User Acceptance Testing (UAT) Sign-Off Date');
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` SET TAGS ('dbx_subdomain' = 'agile_delivery');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `sprint_id` SET TAGS ('dbx_business_glossary_term' = 'Sprint ID');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `cicd_pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'CI/CD Pipeline ID');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone ID');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Scrum Master Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `added_story_points` SET TAGS ('dbx_business_glossary_term' = 'Added Story Points');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `blockers_count` SET TAGS ('dbx_business_glossary_term' = 'Blockers Count');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `board_reference` SET TAGS ('dbx_business_glossary_term' = 'Jira Board ID');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `bug_issues` SET TAGS ('dbx_business_glossary_term' = 'Bug Issues Count');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `build_number` SET TAGS ('dbx_business_glossary_term' = 'Build Number');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `committed_story_points` SET TAGS ('dbx_business_glossary_term' = 'Committed Story Points');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `completed_date` SET TAGS ('dbx_business_glossary_term' = 'Sprint Completed Date');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `completed_issues` SET TAGS ('dbx_business_glossary_term' = 'Completed Issues');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `completed_story_points` SET TAGS ('dbx_business_glossary_term' = 'Completed Story Points');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Sprint Duration (Days)');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Sprint End Date');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `epic_key` SET TAGS ('dbx_business_glossary_term' = 'Epic ID');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `goal` SET TAGS ('dbx_business_glossary_term' = 'Sprint Goal');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `health` SET TAGS ('dbx_business_glossary_term' = 'Sprint Health');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `health` SET TAGS ('dbx_value_regex' = 'on_track|at_risk|off_track');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `health` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `health` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `incomplete_issues` SET TAGS ('dbx_business_glossary_term' = 'Incomplete Issues');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `is_gaas_sprint` SET TAGS ('dbx_business_glossary_term' = 'Game as a Service (GaaS) Sprint Flag');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `jira_sprint_key` SET TAGS ('dbx_business_glossary_term' = 'Jira Sprint ID');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `perforce_changelist` SET TAGS ('dbx_business_glossary_term' = 'Perforce Changelist Number');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `qa_sign_off` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Sign-Off Flag');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `release_gate_status` SET TAGS ('dbx_business_glossary_term' = 'Release Gate Status');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `release_gate_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|waived');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `release_version` SET TAGS ('dbx_business_glossary_term' = 'Release Version');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `release_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `removed_story_points` SET TAGS ('dbx_business_glossary_term' = 'Removed Story Points');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `retrospective_notes` SET TAGS ('dbx_business_glossary_term' = 'Sprint Retrospective Notes');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'jira|manual|import');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `sprint_name` SET TAGS ('dbx_business_glossary_term' = 'Sprint Name');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `sprint_number` SET TAGS ('dbx_business_glossary_term' = 'Sprint Number');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `sprint_state` SET TAGS ('dbx_business_glossary_term' = 'Sprint State');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `sprint_state` SET TAGS ('dbx_value_regex' = 'active|closed|future');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `sprint_type` SET TAGS ('dbx_business_glossary_term' = 'Sprint Type');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `sprint_type` SET TAGS ('dbx_value_regex' = 'development|live_ops|qa|hardening|release|spike');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Sprint Start Date');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `team_capacity_points` SET TAGS ('dbx_business_glossary_term' = 'Team Capacity (Story Points)');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `team_size` SET TAGS ('dbx_business_glossary_term' = 'Team Size');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `total_issues` SET TAGS ('dbx_business_glossary_term' = 'Total Issues');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `uat_sign_off` SET TAGS ('dbx_business_glossary_term' = 'User Acceptance Testing (UAT) Sign-Off Flag');
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` SET TAGS ('dbx_subdomain' = 'agile_delivery');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `backlog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Backlog Item ID');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assignee ID');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `remediation_action_id` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `sprint_id` SET TAGS ('dbx_business_glossary_term' = 'Sprint ID');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `affected_version` SET TAGS ('dbx_business_glossary_term' = 'Affected Version');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `backlog_item_description` SET TAGS ('dbx_business_glossary_term' = 'Issue Description');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `blocker_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocker Reason');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `component` SET TAGS ('dbx_business_glossary_term' = 'Game Component');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `environment` SET TAGS ('dbx_business_glossary_term' = 'Target Environment');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `environment` SET TAGS ('dbx_value_regex' = 'Development|Staging|QA|Production|Live');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `epic_key` SET TAGS ('dbx_business_glossary_term' = 'Epic ID');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `fix_version` SET TAGS ('dbx_business_glossary_term' = 'Fix Version');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `gaas_live_ops_flag` SET TAGS ('dbx_business_glossary_term' = 'Game as a Service (GaaS) Live Operations Flag');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `is_blocked` SET TAGS ('dbx_business_glossary_term' = 'Is Blocked Flag');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `is_regression` SET TAGS ('dbx_business_glossary_term' = 'Is Regression Flag');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `issue_key` SET TAGS ('dbx_business_glossary_term' = 'Jira Issue Key');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `issue_key` SET TAGS ('dbx_value_regex' = '^[A-Z][A-Z0-9]+-[0-9]+$');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `issue_type` SET TAGS ('dbx_business_glossary_term' = 'Issue Type');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `jira_issue_key` SET TAGS ('dbx_business_glossary_term' = 'Jira Issue ID');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `labels` SET TAGS ('dbx_business_glossary_term' = 'Issue Labels');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `original_estimate_hours` SET TAGS ('dbx_business_glossary_term' = 'Original Time Estimate (Hours)');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `perforce_changelist` SET TAGS ('dbx_business_glossary_term' = 'Perforce Changelist Reference');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `platform_target` SET TAGS ('dbx_business_glossary_term' = 'Target Platform');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `platform_target` SET TAGS ('dbx_value_regex' = 'PC|Console|Mobile|Cross-Platform|VR/AR');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Issue Priority');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'Blocker|Critical|Major|Minor|Trivial');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `qa_sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Sign-Off Date');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Issue Resolution');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `resolution` SET TAGS ('dbx_value_regex' = 'Fixed|Wont Fix|Duplicate|Cannot Reproduce|Done|Invalid');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolved Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Jira|Manual|Migration|External');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `sprint_committed_date` SET TAGS ('dbx_business_glossary_term' = 'Sprint Committed Date');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Started Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `story_points` SET TAGS ('dbx_business_glossary_term' = 'Story Points');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `summary` SET TAGS ('dbx_business_glossary_term' = 'Issue Summary');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `time_spent_hours` SET TAGS ('dbx_business_glossary_term' = 'Time Spent (Hours)');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `uat_sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'User Acceptance Testing (UAT) Sign-Off Date');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ALTER COLUMN `workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Workflow Status');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` SET TAGS ('dbx_subdomain' = 'agile_delivery');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone ID');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sign Off Owner Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Completion Date');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `blocker_count` SET TAGS ('dbx_business_glossary_term' = 'Blocker Count');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `build_version` SET TAGS ('dbx_business_glossary_term' = 'Build Version');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `critical_bug_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Bug Count');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `deliverables_checklist_url` SET TAGS ('dbx_business_glossary_term' = 'Deliverables Checklist URL');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `deliverables_completed` SET TAGS ('dbx_business_glossary_term' = 'Completed Deliverables Count');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `deliverables_total` SET TAGS ('dbx_business_glossary_term' = 'Total Deliverables Count');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `epic_key` SET TAGS ('dbx_business_glossary_term' = 'Jira Epic ID');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `is_greenlight_gate` SET TAGS ('dbx_business_glossary_term' = 'Is Greenlight Gate');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `is_publisher_facing` SET TAGS ('dbx_business_glossary_term' = 'Is Publisher-Facing Milestone');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `is_signed_off` SET TAGS ('dbx_business_glossary_term' = 'Is Signed Off');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `jira_release_key` SET TAGS ('dbx_business_glossary_term' = 'Jira Release ID');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|at_risk|missed|completed|signed_off');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `open_issue_count` SET TAGS ('dbx_business_glossary_term' = 'Open Issue Count');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Milestone Payment Amount');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `perforce_changelist` SET TAGS ('dbx_business_glossary_term' = 'Perforce Changelist Number');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `phase` SET TAGS ('dbx_business_glossary_term' = 'Milestone Phase');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `phase` SET TAGS ('dbx_value_regex' = 'pre_production|production|post_production|live_ops');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Milestone Date');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `platform_target` SET TAGS ('dbx_business_glossary_term' = 'Target Platform');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `qa_sign_off_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Sign-Off Status');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `qa_sign_off_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|approved|rejected');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `revised_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Milestone Date');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Milestone Risk Level');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `risk_notes` SET TAGS ('dbx_business_glossary_term' = 'Risk Notes');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `schedule_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance (Days)');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `sign_off_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'jira|shotgrid|productive|manual');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `trc_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Technical Requirements Checklist (TRC) Compliance Status');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `trc_compliance_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|in_review|passed|failed|waived');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `uat_status` SET TAGS ('dbx_business_glossary_term' = 'User Acceptance Testing (UAT) Status');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `uat_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|passed|failed');
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`build` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`studio`.`build` SET TAGS ('dbx_subdomain' = 'engineering_pipeline');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Build ID');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `asset_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `build_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Submission ID');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `changelist_id` SET TAGS ('dbx_business_glossary_term' = 'Changelist Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Triggered By User ID');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `game_server_id` SET TAGS ('dbx_business_glossary_term' = 'Game Server Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone ID');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `repo_id` SET TAGS ('dbx_business_glossary_term' = 'Repo Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `agent` SET TAGS ('dbx_business_glossary_term' = 'Build Agent Identifier');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `artifact_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Build Artifact Size (MB)');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `artifact_storage_path` SET TAGS ('dbx_business_glossary_term' = 'Build Artifact Storage Path');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `branch_name` SET TAGS ('dbx_business_glossary_term' = 'Source Control Branch Name');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `build_number` SET TAGS ('dbx_business_glossary_term' = 'Build Number');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `build_status` SET TAGS ('dbx_business_glossary_term' = 'Build Status');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `build_status` SET TAGS ('dbx_value_regex' = 'success|failed|in_progress|cancelled|queued');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `build_type` SET TAGS ('dbx_business_glossary_term' = 'Build Type');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `build_type` SET TAGS ('dbx_value_regex' = 'debug|development|shipping|test');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Build Completed Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `dlc_identifier` SET TAGS ('dbx_business_glossary_term' = 'Downloadable Content (DLC) Identifier');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Build Duration (Seconds)');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `engine_type` SET TAGS ('dbx_business_glossary_term' = 'Game Engine Type');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `engine_type` SET TAGS ('dbx_value_regex' = 'Unity|Unreal|Custom|Godot|CryEngine');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `engine_version` SET TAGS ('dbx_business_glossary_term' = 'Game Engine Version');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `engine_version` SET TAGS ('dbx_value_regex' = '^d+.d+(.d+)?(.d+)?$');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `error_count` SET TAGS ('dbx_business_glossary_term' = 'Build Error Count');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `failure_message` SET TAGS ('dbx_business_glossary_term' = 'Build Failure Message');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `failure_stage` SET TAGS ('dbx_business_glossary_term' = 'Build Failure Stage');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `gaas_live_update` SET TAGS ('dbx_business_glossary_term' = 'Game as a Service (GaaS) Live Update Flag');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `is_automated_trigger` SET TAGS ('dbx_business_glossary_term' = 'Automated Trigger Flag');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `is_gold_master` SET TAGS ('dbx_business_glossary_term' = 'Gold Master Flag');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `is_release_candidate` SET TAGS ('dbx_business_glossary_term' = 'Release Candidate (RC) Flag');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `jira_release_version` SET TAGS ('dbx_business_glossary_term' = 'Jira Release Version');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Build Notes');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `pipeline_job_name` SET TAGS ('dbx_business_glossary_term' = 'CI/CD Pipeline Job Name');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `pipeline_run_reference` SET TAGS ('dbx_business_glossary_term' = 'CI/CD Pipeline Run ID');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `queued_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Build Queue Wait Duration (Seconds)');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `release_gate_status` SET TAGS ('dbx_business_glossary_term' = 'Release Gate Status');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `release_gate_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|waived');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `sdk_version` SET TAGS ('dbx_business_glossary_term' = 'Platform SDK (Software Development Kit) Version');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Build Started Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `target_platform` SET TAGS ('dbx_business_glossary_term' = 'Target Platform');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `triggered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Build Triggered Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `version_string` SET TAGS ('dbx_business_glossary_term' = 'Build Version String');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `version_string` SET TAGS ('dbx_value_regex' = '^d+.d+.d+(.d+)?(-[a-zA-Z0-9._-]+)?$');
ALTER TABLE `gaming_ecm`.`studio`.`build` ALTER COLUMN `warning_count` SET TAGS ('dbx_business_glossary_term' = 'Build Warning Count');
ALTER TABLE `gaming_ecm`.`studio`.`repo` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`studio`.`repo` SET TAGS ('dbx_subdomain' = 'engineering_pipeline');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `repo_id` SET TAGS ('dbx_business_glossary_term' = 'Repository ID');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `cicd_pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'Cicd Pipeline Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `access_control_tier` SET TAGS ('dbx_business_glossary_term' = 'Access Control Tier');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `access_control_tier` SET TAGS ('dbx_value_regex' = 'public|internal|restricted|confidential');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `active_workspace_count` SET TAGS ('dbx_business_glossary_term' = 'Active Workspace Count');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `archived_date` SET TAGS ('dbx_business_glossary_term' = 'Archived Date');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `backup_policy` SET TAGS ('dbx_business_glossary_term' = 'Backup Policy');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `backup_policy` SET TAGS ('dbx_value_regex' = 'daily|hourly|weekly|continuous|none');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `branch_count` SET TAGS ('dbx_business_glossary_term' = 'Branch Count');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `build_system` SET TAGS ('dbx_business_glossary_term' = 'Build System');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `changelist_count` SET TAGS ('dbx_business_glossary_term' = 'Changelist Count');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `ci_cd_pipeline_enabled` SET TAGS ('dbx_business_glossary_term' = 'CI/CD Pipeline Enabled');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `depot_description` SET TAGS ('dbx_business_glossary_term' = 'Depot Description');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `depot_name` SET TAGS ('dbx_business_glossary_term' = 'Depot Name');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `depot_name` SET TAGS ('dbx_value_regex' = '^//[A-Za-z0-9_-.]+$');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `depot_type` SET TAGS ('dbx_business_glossary_term' = 'Depot Type');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `exclusive_checkout_enabled` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Checkout Enabled');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `file_count` SET TAGS ('dbx_business_glossary_term' = 'File Count');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `gaas_live_ops_enabled` SET TAGS ('dbx_business_glossary_term' = 'Game as a Service (GaaS) Live Operations Enabled');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `game_engine` SET TAGS ('dbx_business_glossary_term' = 'Game Engine');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `game_engine` SET TAGS ('dbx_value_regex' = 'Unreal Engine|Unity|Custom|Godot|CryEngine|Other');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_business_glossary_term' = 'GDPR Applicable');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `gold_master_branch` SET TAGS ('dbx_business_glossary_term' = 'Gold Master Branch');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `ip_classification` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Classification');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `ip_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `jira_project_key` SET TAGS ('dbx_business_glossary_term' = 'Jira Project Key');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `jira_project_key` SET TAGS ('dbx_value_regex' = '^[A-Z][A-Z0-9]{1,9}$');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `last_submit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Submit Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `last_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Sync Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `lfs_enabled` SET TAGS ('dbx_business_glossary_term' = 'Large File Storage (LFS) Enabled');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `mainline_stream_path` SET TAGS ('dbx_business_glossary_term' = 'Mainline Stream Path');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `obliterate_protection` SET TAGS ('dbx_business_glossary_term' = 'Obliterate Protection');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_business_glossary_term' = 'Provisioned Date');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `replication_role` SET TAGS ('dbx_business_glossary_term' = 'Replication Role');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `replication_role` SET TAGS ('dbx_value_regex' = 'commit|edge|replica|standby|none');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `repo_status` SET TAGS ('dbx_business_glossary_term' = 'Repository Status');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `repo_status` SET TAGS ('dbx_value_regex' = 'active|archived|deprecated|suspended|initializing');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `retention_policy_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy (Years)');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `revision_count` SET TAGS ('dbx_business_glossary_term' = 'Revision Count');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `root_path` SET TAGS ('dbx_business_glossary_term' = 'Depot Root Path');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `server_address` SET TAGS ('dbx_business_glossary_term' = 'Perforce Server Address');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `server_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `server_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `server_reference` SET TAGS ('dbx_business_glossary_term' = 'Perforce Server ID');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `source_system_depot_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Depot ID');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `storage_quota_gb` SET TAGS ('dbx_business_glossary_term' = 'Storage Quota (GB)');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `storage_used_gb` SET TAGS ('dbx_business_glossary_term' = 'Storage Used (GB)');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `stream_structure` SET TAGS ('dbx_business_glossary_term' = 'Stream Structure');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `stream_structure` SET TAGS ('dbx_value_regex' = 'mainline_only|mainline_release|mainline_dev_release|full_hierarchy|none');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `target_platforms` SET TAGS ('dbx_business_glossary_term' = 'Target Platforms');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `typemap_applied` SET TAGS ('dbx_business_glossary_term' = 'Typemap Applied');
ALTER TABLE `gaming_ecm`.`studio`.`repo` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` SET TAGS ('dbx_subdomain' = 'engineering_pipeline');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `changelist_id` SET TAGS ('dbx_business_glossary_term' = 'Changelist ID');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `backlog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Backlog Item Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `compliance_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Development Project ID');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `sprint_id` SET TAGS ('dbx_business_glossary_term' = 'Sprint Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitter Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `bug_severity` SET TAGS ('dbx_business_glossary_term' = 'Bug Severity');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `bug_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `build_number` SET TAGS ('dbx_business_glossary_term' = 'Build Number');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Change Category');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `change_status` SET TAGS ('dbx_business_glossary_term' = 'Changelist Status');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `change_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|shelved');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Changelist Type');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'public|restricted');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `cicd_pipeline_status` SET TAGS ('dbx_business_glossary_term' = 'CI/CD Pipeline Status');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `cicd_pipeline_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|skipped|cancelled');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `cl_description` SET TAGS ('dbx_business_glossary_term' = 'Changelist Description');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `cl_number` SET TAGS ('dbx_business_glossary_term' = 'Changelist (CL) Number');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Changelist Created Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `engine_version` SET TAGS ('dbx_business_glossary_term' = 'Game Engine Version');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `file_count` SET TAGS ('dbx_business_glossary_term' = 'File Count');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `game_area` SET TAGS ('dbx_business_glossary_term' = 'Game Area / System');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `integration_type` SET TAGS ('dbx_business_glossary_term' = 'Integration Type');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `integration_type` SET TAGS ('dbx_value_regex' = 'direct|copy|merge|branch|none');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `is_gaas_live_op` SET TAGS ('dbx_business_glossary_term' = 'Is GaaS Live Operations Change Flag');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `is_hotfix` SET TAGS ('dbx_business_glossary_term' = 'Is Hotfix Flag');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `jira_issue_type` SET TAGS ('dbx_business_glossary_term' = 'Jira Issue Type');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `jira_issue_type` SET TAGS ('dbx_value_regex' = 'Story|Bug|Task|Epic|Sub-task|Improvement');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `lines_added` SET TAGS ('dbx_business_glossary_term' = 'Lines Added');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `lines_deleted` SET TAGS ('dbx_business_glossary_term' = 'Lines Deleted');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `perforce_server_reference` SET TAGS ('dbx_business_glossary_term' = 'Perforce Server ID');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `qa_validation_status` SET TAGS ('dbx_business_glossary_term' = 'QA Validation Status');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `qa_validation_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|passed|failed');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `reverts_cl_number` SET TAGS ('dbx_business_glossary_term' = 'Reverts Changelist Number');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `review_approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Approved Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Code Review Status');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected|needs_revision');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `reviewer_username` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Username');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `reviewer_username` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `shelved_for_review` SET TAGS ('dbx_business_glossary_term' = 'Shelved for Review Flag');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `source_branch` SET TAGS ('dbx_business_glossary_term' = 'Source Branch');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `stream_name` SET TAGS ('dbx_business_glossary_term' = 'Perforce Stream Name');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `submit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submit Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `target_platform` SET TAGS ('dbx_business_glossary_term' = 'Target Platform');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `total_file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Total File Size (Bytes)');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Changelist Last Updated Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ALTER COLUMN `workspace_name` SET TAGS ('dbx_business_glossary_term' = 'Perforce Workspace (Client) Name');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` SET TAGS ('dbx_subdomain' = 'studio_operations');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `resource_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Allocation ID');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Development Project ID');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `sprint_id` SET TAGS ('dbx_business_glossary_term' = 'Sprint Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `tertiary_resource_replacement_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Employee ID');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `tertiary_resource_replacement_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `tertiary_resource_replacement_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `allocated_role` SET TAGS ('dbx_business_glossary_term' = 'Allocated Role');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `allocation_code` SET TAGS ('dbx_business_glossary_term' = 'Resource Allocation Code');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `allocation_code` SET TAGS ('dbx_value_regex' = '^ALLOC-[A-Z0-9]{4,12}$');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage (FTE Fraction)');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `allocation_source` SET TAGS ('dbx_business_glossary_term' = 'Allocation Source System');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Resource Allocation Status');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'confirmed|tentative|released|on_hold|cancelled');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Approval Date');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `cicd_pipeline_access` SET TAGS ('dbx_business_glossary_term' = 'CI/CD Pipeline Access');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `daily_rate_usd` SET TAGS ('dbx_business_glossary_term' = 'Daily Rate (USD)');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `daily_rate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `fte_hours_per_day` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Hours Per Day');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `gaas_live_ops_flag` SET TAGS ('dbx_business_glossary_term' = 'Game as a Service (GaaS) Live Operations Flag');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable Allocation');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `is_contractor` SET TAGS ('dbx_business_glossary_term' = 'Is Contractor');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `is_remote` SET TAGS ('dbx_business_glossary_term' = 'Is Remote Worker');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `jira_epic_key` SET TAGS ('dbx_business_glossary_term' = 'Jira Epic Key');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `jira_epic_key` SET TAGS ('dbx_value_regex' = '^[A-Z][A-Z0-9]+-[0-9]+$');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `overtime_approved` SET TAGS ('dbx_business_glossary_term' = 'Overtime Approved');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `perforce_depot_access` SET TAGS ('dbx_business_glossary_term' = 'Perforce Depot Access');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `primary_tool` SET TAGS ('dbx_business_glossary_term' = 'Primary Development Tool');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority Rank');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Resource Release Date');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Requested Date');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `role_discipline` SET TAGS ('dbx_business_glossary_term' = 'Role Discipline');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `seniority_level` SET TAGS ('dbx_business_glossary_term' = 'Seniority Level');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `seniority_level` SET TAGS ('dbx_value_regex' = 'junior|mid|senior|lead|principal|director');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `skill_tags` SET TAGS ('dbx_business_glossary_term' = 'Skill Tags');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `total_allocated_days` SET TAGS ('dbx_business_glossary_term' = 'Total Allocated Days');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `work_location_country` SET TAGS ('dbx_business_glossary_term' = 'Work Location Country');
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ALTER COLUMN `work_location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` SET TAGS ('dbx_subdomain' = 'agile_delivery');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `live_ops_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Live Ops Cycle Identifier');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Build Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Live Operations (Live Ops) Cycle ID');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Development Project ID');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Content Creator / Lead Producer ID');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `forum_id` SET TAGS ('dbx_business_glossary_term' = 'Forum Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `infrastructure_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Deployment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `patch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Patch Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `actual_dev_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Development Hours');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `actual_release_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Release Date');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `cert_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Approval Date');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `cert_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Submission Date');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `cicd_pipeline_run_reference` SET TAGS ('dbx_business_glossary_term' = 'CI/CD Pipeline Run ID');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `content_scope_summary` SET TAGS ('dbx_business_glossary_term' = 'Content Scope Summary');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `coppa_applicable` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Applicable Flag');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `critical_bug_count_at_release` SET TAGS ('dbx_business_glossary_term' = 'Critical Bug Count at Release');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Live Ops Cycle Code');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `cycle_end_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle End Date');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Live Ops Cycle Name');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `cycle_start_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle Start Date');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Live Ops Cycle Status');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_value_regex' = 'planned|in_development|deployed|retired');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Live Ops Cycle Type');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `cycle_type` SET TAGS ('dbx_value_regex' = 'season|major_patch|hotfix|limited_time_event|battle_pass_rotation|expansion');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `deployment_region` SET TAGS ('dbx_business_glossary_term' = 'Deployment Region');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `esrb_content_descriptor` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Software Rating Board (ESRB) Content Descriptor');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `estimated_dev_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Development Hours');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `gdpr_data_processing_note` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Data Processing Note');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `has_battle_pass` SET TAGS ('dbx_business_glossary_term' = 'Battle Pass Flag');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `has_mtx_tie_in` SET TAGS ('dbx_business_glossary_term' = 'Monetization Tie-In (MTX) Flag');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `is_limited_time` SET TAGS ('dbx_business_glossary_term' = 'Limited-Time Event (LTE) Flag');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `is_soft_launch` SET TAGS ('dbx_business_glossary_term' = 'Soft Launch Flag');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `jira_release_key` SET TAGS ('dbx_business_glossary_term' = 'Jira Release ID');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `open_bug_count_at_release` SET TAGS ('dbx_business_glossary_term' = 'Open Bug Count at Release');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `patch_notes_url` SET TAGS ('dbx_business_glossary_term' = 'Patch Notes URL');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `pegi_content_descriptor` SET TAGS ('dbx_business_glossary_term' = 'Pan European Game Information (PEGI) Content Descriptor');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `perforce_label` SET TAGS ('dbx_business_glossary_term' = 'Perforce Label');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `planned_release_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Release Date');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `player_comms_plan_ref` SET TAGS ('dbx_business_glossary_term' = 'Player Communication Plan Reference');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `qa_sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Sign-Off Date');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `release_gate_status` SET TAGS ('dbx_business_glossary_term' = 'Release Gate Status');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `release_gate_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|waived');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `rollback_version` SET TAGS ('dbx_business_glossary_term' = 'Rollback Version');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `rollback_version` SET TAGS ('dbx_value_regex' = '^d+.d+(.d+)?(.d+)?$');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `season_number` SET TAGS ('dbx_business_glossary_term' = 'Season Number');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `sprint_count` SET TAGS ('dbx_business_glossary_term' = 'Sprint Count');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `target_platforms` SET TAGS ('dbx_business_glossary_term' = 'Target Platforms');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `uat_sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'User Acceptance Testing (UAT) Sign-Off Date');
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` SET TAGS ('dbx_subdomain' = 'studio_operations');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `partnership_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Identifier');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Development Project ID');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `developer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Developer Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher Studio ID');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `partnership_partner_studio_game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Studio ID');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `payout_line_id` SET TAGS ('dbx_business_glossary_term' = 'Payout Line Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `third_party_processor_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Processor Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `advance_recoupable_usd` SET TAGS ('dbx_business_glossary_term' = 'Recoupable Advance Amount (USD)');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `advance_recoupable_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `coppa_applicable` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Applicable Flag');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Currency Code');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_value_regex' = 'arbitration|litigation|mediation|expert_determination');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Partnership Effective End Date');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Partnership Effective Start Date');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `esrb_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Software Rating Board (ESRB) Compliance Required Flag');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `exclusivity_type` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Type');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `exclusivity_type` SET TAGS ('dbx_value_regex' = 'exclusive|non_exclusive|platform_exclusive|genre_exclusive|none');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `gaas_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Game as a Service (GaaS) Support Flag');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `gaming_revenue_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Gaming Revenue Share Percentage');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `gaming_revenue_share_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `gdpr_data_processing_agreement` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Data Processing Agreement Flag');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `governing_law_country` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Country');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `governing_law_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `ip_ownership_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Ownership Arrangement');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `ip_ownership_arrangement` SET TAGS ('dbx_value_regex' = 'gaming_owned|partner_owned|jointly_owned|licensed_to_gaming|licensed_to_partner');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `ip_ownership_arrangement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `milestone_count` SET TAGS ('dbx_business_glossary_term' = 'Contractual Milestone Count');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `milestones_completed` SET TAGS ('dbx_business_glossary_term' = 'Milestones Completed Count');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `mtx_revenue_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Microtransaction (MTX) Revenue Rights Flag');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `nda_executed_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) Executed Flag');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Partnership Notes');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `partner_primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Partner Primary Contact Email');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `partner_primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `partner_primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `partner_primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `partner_primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Primary Contact Name');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `partner_primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `partner_revenue_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Partner Revenue Share Percentage');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `partner_revenue_share_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `partner_studio_country` SET TAGS ('dbx_business_glossary_term' = 'Partner Studio Country');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `partner_studio_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `partnership_name` SET TAGS ('dbx_business_glossary_term' = 'Partnership Name');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `partnership_status` SET TAGS ('dbx_business_glossary_term' = 'Partnership Status');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `partnership_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired|pending_renewal');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `partnership_type` SET TAGS ('dbx_business_glossary_term' = 'Partnership Type');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `partnership_type` SET TAGS ('dbx_value_regex' = 'co_development|work_for_hire|licensed_developer|publisher_developer_agreement|first_party_exclusive|third_party_publishing');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `pegi_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Pan European Game Information (PEGI) Compliance Required Flag');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `revenue_share_model` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Model');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `revenue_share_model` SET TAGS ('dbx_value_regex' = 'fixed_fee|royalty_percentage|milestone_based|profit_share|hybrid');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `revenue_share_model` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Partnership Signed Date');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Partnership Termination Date');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Partnership Termination Reason');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `total_contract_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value (USD)');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `total_contract_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ALTER COLUMN `ugc_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'User-Generated Content (UGC) Rights Flag');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` SET TAGS ('dbx_subdomain' = 'studio_operations');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `project_budget_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Allocation ID');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Development Project ID');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `prior_allocation_project_budget_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Budget Allocation ID');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `actual_amount_spent` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount Spent');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `actual_amount_spent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Budget Amount');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `allocation_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Reference Code');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `allocation_reference_code` SET TAGS ('dbx_value_regex' = '^BA-[A-Z0-9]{4,12}-[0-9]{4}-[0-9]{3}$');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Type');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'initial|supplemental|reallocation|contingency|carryover');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|revised|closed');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Approved Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'personnel|tools_middleware|outsourcing|qa|localization|platform_fees');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `budget_consumed_usd` SET TAGS ('dbx_business_glossary_term' = 'Budget Consumed (USD)');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `budget_consumed_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `committed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^CC-[A-Z0-9]{4,10}$');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective From Date');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective Until Date');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `finance_sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Finance Sign-Off Date');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^(Q[1-4]|P(0[1-9]|1[0-2]))-[0-9]{4}$');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `headcount_funded` SET TAGS ('dbx_business_glossary_term' = 'Headcount Funded');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `is_contingency_reserve` SET TAGS ('dbx_business_glossary_term' = 'Is Contingency Reserve Flag');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Notes');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `outsource_vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Outsource Vendor Name');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `project_phase` SET TAGS ('dbx_value_regex' = 'pre_production|production|alpha|beta|gold_master|post_launch');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Budget Rejection Reason');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `remaining_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Budget Amount');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `remaining_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `requires_finance_sign_off` SET TAGS ('dbx_business_glossary_term' = 'Requires Finance Sign-Off Flag');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Revision Number');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference ID');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Submission Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `total_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Development Budget (USD)');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `total_budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Percentage');
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ALTER COLUMN `wbs_element_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Code');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` SET TAGS ('dbx_subdomain' = 'engineering_pipeline');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `engine_config_id` SET TAGS ('dbx_business_glossary_term' = 'Engine Configuration ID');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Development Project ID');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `repo_id` SET TAGS ('dbx_business_glossary_term' = 'Repo Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `animation_system` SET TAGS ('dbx_business_glossary_term' = 'Animation System Module');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `animation_system` SET TAGS ('dbx_value_regex' = 'Animator|Mecanim|Control Rig|Sequencer|Custom|None');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `api_backend` SET TAGS ('dbx_business_glossary_term' = 'Graphics Application Programming Interface (API) Backend');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configuration Approval Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `audio_middleware` SET TAGS ('dbx_business_glossary_term' = 'Audio Middleware Module');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `audio_middleware` SET TAGS ('dbx_value_regex' = 'FMOD|Wwise|Unity Audio|Unreal Audio|Custom|None');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `build_configuration` SET TAGS ('dbx_business_glossary_term' = 'Build Configuration Type');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `build_configuration` SET TAGS ('dbx_value_regex' = 'Debug|Development|Shipping|Release|Profile');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `change_notes` SET TAGS ('dbx_business_glossary_term' = 'Configuration Change Notes');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `cicd_pipeline_url` SET TAGS ('dbx_business_glossary_term' = 'CI/CD Pipeline URL');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `compression_method` SET TAGS ('dbx_business_glossary_term' = 'Asset Compression Method');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `compression_method` SET TAGS ('dbx_value_regex' = 'None|LZ4|Zlib|LZMA|Oodle|Brotli');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `config_code` SET TAGS ('dbx_business_glossary_term' = 'Engine Configuration Code');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `config_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,50}$');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `config_description` SET TAGS ('dbx_business_glossary_term' = 'Engine Configuration Description');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `config_name` SET TAGS ('dbx_business_glossary_term' = 'Engine Configuration Name');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `config_status` SET TAGS ('dbx_business_glossary_term' = 'Engine Configuration Status');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `config_status` SET TAGS ('dbx_value_regex' = 'draft|active|deprecated|archived|locked');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `config_version` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `config_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `deprecated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configuration Deprecation Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `draw_call_budget` SET TAGS ('dbx_business_glossary_term' = 'Draw Call Budget');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `drm_solution` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Solution');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `drm_solution` SET TAGS ('dbx_value_regex' = 'None|Denuvo|Steam DRM|EGS DRM|Platform Native|Custom');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `engine_platform` SET TAGS ('dbx_business_glossary_term' = 'Game Engine Platform');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `engine_platform` SET TAGS ('dbx_value_regex' = 'Unity|Unreal Engine|Proprietary|Godot|CryEngine|O3DE');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `engine_version` SET TAGS ('dbx_business_glossary_term' = 'Game Engine Version');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `engine_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?(.[0-9]+)?(-[a-zA-Z0-9]+)?$');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `gaas_live_ops_enabled` SET TAGS ('dbx_business_glossary_term' = 'Game as a Service (GaaS) Live Operations Enabled');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `is_template` SET TAGS ('dbx_business_glossary_term' = 'Is Template Configuration');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `jira_config_ticket` SET TAGS ('dbx_business_glossary_term' = 'Jira Configuration Change Ticket');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `jira_config_ticket` SET TAGS ('dbx_value_regex' = '^[A-Z]+-[0-9]+$');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `lod_config_enabled` SET TAGS ('dbx_business_glossary_term' = 'Level of Detail (LOD) Configuration Enabled');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `lod_levels` SET TAGS ('dbx_business_glossary_term' = 'Level of Detail (LOD) Levels Count');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `memory_budget_mb` SET TAGS ('dbx_business_glossary_term' = 'Memory Budget (MB)');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `min_os_version` SET TAGS ('dbx_business_glossary_term' = 'Minimum Operating System Version');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `networking_sdk` SET TAGS ('dbx_business_glossary_term' = 'Networking Software Development Kit (SDK)');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `perforce_changelist` SET TAGS ('dbx_business_glossary_term' = 'Perforce Changelist Number');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `physics_engine` SET TAGS ('dbx_business_glossary_term' = 'Physics Engine Module');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `physics_engine` SET TAGS ('dbx_value_regex' = 'PhysX|Chaos|Havok|Bullet|Custom|None');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `rendering_pipeline` SET TAGS ('dbx_business_glossary_term' = 'Rendering Pipeline');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `scripting_backend` SET TAGS ('dbx_business_glossary_term' = 'Scripting Backend');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `scripting_backend` SET TAGS ('dbx_value_regex' = 'Mono|IL2CPP|C++|Blueprints|C#|Lua');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `sdk_versions` SET TAGS ('dbx_business_glossary_term' = 'Platform Software Development Kit (SDK) Versions');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `shader_model_version` SET TAGS ('dbx_business_glossary_term' = 'Shader Model Version');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `shader_model_version` SET TAGS ('dbx_value_regex' = '^SM[0-9](_[0-9])?$');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `target_fps` SET TAGS ('dbx_business_glossary_term' = 'Target Frames Per Second (FPS)');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `target_platforms` SET TAGS ('dbx_business_glossary_term' = 'Target Build Platforms');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `template_source_reference` SET TAGS ('dbx_business_glossary_term' = 'Template Source Engine Configuration ID');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `texture_budget_mb` SET TAGS ('dbx_business_glossary_term' = 'Texture Memory Budget (MB)');
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` SET TAGS ('dbx_subdomain' = 'studio_operations');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `vendor_work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Work Package ID');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Development Project ID');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Producer ID');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Studio ID');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `infrastructure_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Deployment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone ID');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `repo_id` SET TAGS ('dbx_business_glossary_term' = 'Repo Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `test_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Test Plan Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `third_party_processor_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Processor Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `parent_vendor_work_package_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `asset_count` SET TAGS ('dbx_business_glossary_term' = 'Asset Count');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `contracted_amount` SET TAGS ('dbx_business_glossary_term' = 'Contracted Amount');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `cost_allocation_reference` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Reference');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `deliverable_type` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Type');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `delivery_milestone_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Milestone Date');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `gaas_live_ops_flag` SET TAGS ('dbx_business_glossary_term' = 'GaaS (Game as a Service) Live Operations Flag');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `game_engine` SET TAGS ('dbx_business_glossary_term' = 'Game Engine');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `game_engine` SET TAGS ('dbx_value_regex' = 'Unity|Unreal|Proprietary|CryEngine|Godot|Other');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `ip_ownership_terms` SET TAGS ('dbx_business_glossary_term' = 'IP (Intellectual Property) Ownership Terms');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `ip_ownership_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `jira_epic_key` SET TAGS ('dbx_business_glossary_term' = 'Jira Epic Key');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `nda_executed` SET TAGS ('dbx_business_glossary_term' = 'NDA (Non-Disclosure Agreement) Executed');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `package_code` SET TAGS ('dbx_business_glossary_term' = 'Work Package Code');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `package_name` SET TAGS ('dbx_business_glossary_term' = 'Work Package Name');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `package_status` SET TAGS ('dbx_business_glossary_term' = 'Work Package Status');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `perforce_changelist` SET TAGS ('dbx_business_glossary_term' = 'Perforce Changelist');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `qa_sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'QA (Quality Assurance) Sign-Off Date');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `qa_sign_off_status` SET TAGS ('dbx_business_glossary_term' = 'QA (Quality Assurance) Sign-Off Status');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `qa_sign_off_status` SET TAGS ('dbx_value_regex' = 'pending|in-review|approved|rejected|not-required');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `revision_count` SET TAGS ('dbx_business_glossary_term' = 'Revision Count');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `risk_notes` SET TAGS ('dbx_business_glossary_term' = 'Risk Notes');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `schedule_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance Days');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `target_platform` SET TAGS ('dbx_business_glossary_term' = 'Target Platform');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `uat_sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'UAT (User Acceptance Testing) Sign-Off Date');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `uat_sign_off_status` SET TAGS ('dbx_business_glossary_term' = 'UAT (User Acceptance Testing) Sign-Off Status');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `uat_sign_off_status` SET TAGS ('dbx_value_regex' = 'pending|in-review|approved|rejected|not-required');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Email');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Name');
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` SET TAGS ('dbx_subdomain' = 'engineering_pipeline');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` SET TAGS ('dbx_association_edges' = 'studio.build,platform.certification_checklist');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ALTER COLUMN `certification_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Test Run ID');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Test Run - Build Id');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ALTER COLUMN `certification_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Test Run - Certification Checklist Id');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Tester Employee ID');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ALTER COLUMN `advisory_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Advisory Failure Count');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ALTER COLUMN `certification_outcome` SET TAGS ('dbx_business_glossary_term' = 'Certification Outcome');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Platform Certification Status');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|in_review|approved|rejected');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ALTER COLUMN `failure_count` SET TAGS ('dbx_business_glossary_term' = 'Failure Count');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ALTER COLUMN `mandatory_pass_count` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Pass Count');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Test Run Notes');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ALTER COLUMN `platform_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Platform Submission Reference');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ALTER COLUMN `resubmission_number` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Number');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ALTER COLUMN `test_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Completed Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ALTER COLUMN `test_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Date');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ALTER COLUMN `test_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Started Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ALTER COLUMN `waiver_count` SET TAGS ('dbx_business_glossary_term' = 'Waiver Count');
