-- Schema for Domain: talent | Business: Advertising | Version: v1_ecm
-- Generated on: 2026-05-08 02:28:06

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `advertising_ecm`.`talent` COMMENT 'Manages the agency workforce — including FTE employees, freelancers, contractors, influencers, actors, photographers, directors, and production crews. Owns HR records, resource planning, time tracking, payroll, talent acquisition, rates, rights management, usage rights, and capacity planning. Integrates with Workday HCM and Workfront resource management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`worker` (
    `worker_id` BIGINT COMMENT 'Unique surrogate identifier for each workforce member record in the agency talent master. Primary key for the worker data product, sourced from Workday HCM Core HR module.',
    `manager_worker_id` BIGINT COMMENT 'The worker_id of the direct line manager or supervisor for this worker, enabling organizational hierarchy traversal. Used for approval workflows, performance management, and org chart reporting in Workday HCM.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the worker record was first created in the Workday HCM Core HR system and ingested into the Silver Layer. Used for data lineage, audit trails, and GDPR data retention compliance.',
    `date_of_birth` DATE COMMENT 'The workers date of birth. Used for age verification, benefits eligibility determination, and compliance with child labor laws. Stored in compliance with GDPR Article 9 and CCPA data minimization principles.',
    `department_code` STRING COMMENT 'The agency department or cost center code to which the worker is assigned, aligned with SAP S/4HANA CO cost center structure. Used for P&L reporting, budget allocation, and internal chargebacks.',
    `employment_type` STRING COMMENT 'Broad classification of the workers engagement model with the agency. Full-Time Employee (FTE) indicates a permanent headcount position; freelancer and contractor indicate non-permanent engagements. Drives payroll processing, benefits eligibility, and resource planning in Workday HCM and Workfront.. Valid values are `FTE|freelancer|contractor|intern|agency_temp`',
    `fte_percentage` DECIMAL(18,2) COMMENT 'The workers Full-Time Equivalent (FTE) percentage representing their capacity relative to a standard full-time position (e.g., 100.00 for full-time, 50.00 for half-time). Used for headcount reporting, capacity planning, and P&L cost allocation.',
    `gender_identity` STRING COMMENT 'The workers self-identified gender, collected voluntarily for DEI (Diversity, Equity, and Inclusion) reporting and workforce analytics. Stored in compliance with GDPR Article 9 special category data protections. [ENUM-REF-CANDIDATE: male|female|non_binary|prefer_not_to_say|other — promote to reference product]',
    `hire_date` DATE COMMENT 'The official date the worker commenced employment or engagement with the agency, as recorded in Workday HCM. Used for tenure calculations, benefits eligibility, probation period tracking, and anniversary reporting.',
    `insurance_certificate_ref` STRING COMMENT 'Document reference identifier for the workers professional liability, general liability, or errors and omissions insurance certificate. Required for freelancers and contractors engaged on client-facing production work. Stored as a DAM reference to the Workfront DAM or agency document management system.',
    `job_family` STRING COMMENT 'The functional grouping of the workers role within the agency talent taxonomy (e.g., Creative, Media, Account Management, Strategy, Production, Technology, Finance, Operations). Used for capacity planning, FTE headcount reporting, and P&L allocation.',
    `job_title` STRING COMMENT 'The official job title of the worker as defined in Workday HCM. Reflects the workers functional role within the agency (e.g., Art Director, Media Planner, Account Executive, Copywriter, Director of Photography). Used for resource planning and client-facing team rosters.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent update to the worker record in Workday HCM Core HR. Used for incremental ETL processing, change data capture, and audit trail maintenance in the Databricks Silver Layer.',
    `legal_first_name` STRING COMMENT 'The workers legal given name as it appears on government-issued identification documents. Used for payroll, tax filings, and work authorization verification.',
    `legal_last_name` STRING COMMENT 'The workers legal family name as it appears on government-issued identification documents. Used for payroll, tax filings, and work authorization verification.',
    `mobile_phone` STRING COMMENT 'The workers primary mobile phone number in E.164 international format. Used for emergency contact, two-factor authentication, and urgent production communications.. Valid values are `^+?[1-9]d{1,14}$`',
    `national_id_reference` STRING COMMENT 'A tokenized or masked reference to the workers national identification number (e.g., SSN, NIN, SIN). The actual value is stored in Workday HCM encrypted vault; this field holds a non-reversible reference token for cross-system reconciliation without exposing the raw identifier.',
    `nationality` STRING COMMENT 'The workers nationality expressed as an ISO 3166-1 alpha-3 country code (e.g., USA, GBR, DEU). Used for work authorization verification, tax treaty eligibility, and international assignment management.. Valid values are `^[A-Z]{3}$`',
    `office_location_code` STRING COMMENT 'The agency office or work location code where the worker is primarily based (e.g., NYC-HQ, LAX-WEST, LON-SOHO). Used for tax jurisdiction determination, resource planning, and facilities management.',
    `onboarding_date` DATE COMMENT 'The date on which the worker completed all required onboarding activities including I-9/right-to-work verification, system access provisioning, compliance training, and policy acknowledgements. Distinct from hire_date which is the contractual start date.',
    `pay_frequency` STRING COMMENT 'The frequency at which the worker is compensated. Drives payroll run scheduling in Workday HCM Payroll and SAP S/4HANA FI. project_based applies to freelancers and contractors paid upon milestone or project completion.. Valid values are `weekly|bi_weekly|semi_monthly|monthly|project_based`',
    `pay_rate` DECIMAL(18,2) COMMENT 'The workers base compensation rate as stored in Workday HCM Payroll. For FTEs this represents annual salary; for freelancers and contractors this represents the agreed hourly or daily rate. Used for budget forecasting, P&L reporting, and SOW cost estimation.',
    `pay_rate_currency` STRING COMMENT 'The ISO 4217 three-letter currency code for the workers pay rate (e.g., USD, GBP, EUR). Required for multi-currency payroll processing and international contractor management.. Valid values are `^[A-Z]{3}$`',
    `personal_email` STRING COMMENT 'The workers personal email address used for onboarding communications, offboarding notifications, and contact when work email is unavailable (e.g., for freelancers and contractors).. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `preferred_name` STRING COMMENT 'The name the worker prefers to be addressed by in day-to-day agency operations, project assignments, and internal communications. May differ from legal name.',
    `standard_weekly_hours` DECIMAL(18,2) COMMENT 'The contracted or expected number of working hours per week for the worker. Used for capacity planning in Workfront resource management, overtime threshold calculations, and FTE equivalency reporting.',
    `talent_specialization` STRING COMMENT 'The workers primary creative or technical specialization relevant to advertising and marketing production (e.g., Art Director, Copywriter, Director of Photography, Influencer, Actor, Motion Designer, Media Planner, Programmatic Trader, Data Analyst). Used for talent matching and resource allocation in Workfront.',
    `tax_classification` STRING COMMENT 'The IRS or applicable tax authority classification governing how the worker is compensated and taxed. Determines payroll withholding obligations, 1099 reporting requirements, and SAP S/4HANA FI vendor setup for corp-to-corp engagements.. Valid values are `W2|1099|corp_to_corp|international_contractor|statutory_employee`',
    `tax_jurisdiction_country` STRING COMMENT 'The primary country tax jurisdiction for the worker expressed as an ISO 3166-1 alpha-3 country code. Determines applicable tax treaties, withholding rates, and payroll processing rules in SAP S/4HANA FI.. Valid values are `^[A-Z]{3}$`',
    `tax_jurisdiction_state` STRING COMMENT 'The state or province tax jurisdiction for the worker (e.g., NY, CA, TX for US workers). Used for state income tax withholding, nexus determination, and multi-state payroll compliance in SAP S/4HANA Payroll.',
    `termination_date` DATE COMMENT 'The date the workers employment or engagement with the agency ended, as recorded in Workday HCM. Null for active workers. Triggers offboarding workflows, system access revocation, and final payroll processing.',
    `termination_reason` STRING COMMENT 'The categorized reason for the workers departure from the agency. Used for attrition analytics, workforce planning, and compliance reporting. Null for active workers.. Valid values are `voluntary_resignation|involuntary_termination|contract_end|retirement|redundancy|mutual_agreement`',
    `visa_expiry_date` DATE COMMENT 'The expiration date of the workers visa or work permit. Used to trigger renewal workflows and ensure continuous work authorization compliance. Null for workers with unrestricted authorization.',
    `visa_type` STRING COMMENT 'The type of visa or work permit held by the worker where applicable (e.g., H-1B, L-1, O-1, Tier 2, EU Blue Card). Null for workers with unrestricted work authorization. Used for immigration compliance tracking.',
    `work_arrangement` STRING COMMENT 'The workers approved work location arrangement. Impacts tax nexus determination, facilities planning, and collaboration tool provisioning. Particularly relevant for multi-jurisdiction agencies operating under GDPR and CCPA.. Valid values are `on_site|remote|hybrid`',
    `work_authorization_status` STRING COMMENT 'The current work authorization status of the worker in their primary work jurisdiction. Critical for compliance with immigration laws and I-9/right-to-work verification requirements. Triggers alerts when visa or permit expiry is approaching.. Valid values are `authorized|visa_required|pending_verification|expired|not_applicable`',
    `work_email` STRING COMMENT 'The agency-issued or primary professional email address for the worker. Used for system access provisioning, Workfront project assignments, and internal communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `work_permit_ref` STRING COMMENT 'Document reference identifier for the workers work permit or right-to-work documentation stored in the agencys DAM or Workday HCM document vault. Used for immigration compliance audits and I-9 reverification tracking.',
    `workday_worker_reference` STRING COMMENT 'The native worker identifier assigned by Workday HCM Core HR module. Used for system-of-record cross-referencing and integration with Workday Payroll, Time Tracking, and Talent Management modules.',
    `worker_status` STRING COMMENT 'Current lifecycle status of the worker record within the agency. Drives access provisioning, payroll processing, and resource availability in Workfront. pending_onboard indicates pre-start date; on_leave covers parental, medical, and sabbatical leave.. Valid values are `active|on_leave|terminated|suspended|pending_onboard`',
    CONSTRAINT pk_worker PRIMARY KEY(`worker_id`)
) COMMENT 'Master record for all agency workforce members — FTEs, freelancers, contractors, influencers, actors, photographers, directors, and production crew. Serves as the SSOT for talent identity, employment classification (W-2, 1099, Corp-to-Corp, international contractor), contact details, work authorization status, tax jurisdiction, emergency contacts, and onboarding/offboarding lifecycle. Includes document references for work permits, visa status, and insurance certificates where applicable. Sourced from Workday HCM Core HR module.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`position` (
    `position_id` BIGINT COMMENT 'Unique surrogate identifier for an authorized headcount position within the agency organizational structure. Primary key sourced from Workday HCM position management.',
    `acquisition_id` BIGINT COMMENT 'Reference to the active job requisition in Workday HCM Recruiting associated with filling this open position. Links position management to the talent acquisition workflow.',
    `address_id` BIGINT COMMENT 'Reference to the physical or virtual office location where the position is based. Supports geographic workforce distribution reporting and compliance with local labor regulations.',
    `cost_center_id` BIGINT COMMENT 'Reference to the SAP S/4HANA cost center to which the positions labor costs are allocated. Enables financial reporting, P&L attribution, and budget reconciliation at the department or client level.',
    `capacity_plan_id` BIGINT COMMENT 'Reference to the annual or quarterly headcount plan under which this position was authorized. Links to the agencys workforce planning cycle in SAP S/4HANA or Workday HCM.',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: Position can be filled by a worker (the incumbent). This is the current occupant of the position. One position has one current incumbent; one worker can hold one primary position at a time. The FK col',
    `job_profile_id` BIGINT COMMENT 'Reference to the standardized Workday HCM job profile that defines the competencies, qualifications, and pay range associated with this position. Enables consistent role definition across the agency.',
    `org_unit_id` BIGINT COMMENT 'Reference to the agency department to which this position belongs (e.g., Creative, Media, Account Management, Analytics, PR). Links to the department master in Workday HCM.',
    `position_supervisory_org_org_unit_id` BIGINT COMMENT 'Reference to the Workday HCM supervisory organization unit that owns this position. Defines the management hierarchy and reporting structure within the agency.',
    `reports_to_position_id` BIGINT COMMENT 'Self-referencing identifier of the parent position in the organizational hierarchy to which this position reports. Enables org chart traversal, span-of-control analysis, and management reporting.',
    `available_for_overlap` BOOLEAN COMMENT 'Indicates whether the position allows an overlap period where both an outgoing and incoming worker can be simultaneously active. True = overlap permitted; False = single occupancy only. Supports transition planning.',
    `budgeted_annual_salary` DECIMAL(18,2) COMMENT 'The approved annual salary budget allocated for this position in the agency headcount plan. Used for P&L, EBITDA reporting, and budget reconciliation in SAP S/4HANA. Expressed in the agencys base currency.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this position record was first created in the system of record (Workday HCM). Used for audit trail, data lineage, and compliance reporting.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the budgeted salary and compensation values associated with this position (e.g., USD, GBP, EUR). Supports multi-currency agency operations.. Valid values are `^[A-Z]{3}$`',
    `discipline` STRING COMMENT 'Functional discipline or craft area of the position within the agency (e.g., Art Direction, Copywriting, Media Planning, Media Buying, Account Management, Strategy, Data Analytics, Public Relations, Production, Digital Marketing). [ENUM-REF-CANDIDATE: art_direction|copywriting|media_planning|media_buying|account_management|strategy|data_analytics|public_relations|production|digital_marketing|brand_strategy|project_management — promote to reference product]',
    `effective_date` DATE COMMENT 'The date from which this position is authorized and active within the agency organizational structure. Used for workforce planning, budget activation, and compliance reporting.',
    `employment_type` STRING COMMENT 'Nature of the employment arrangement for the position — full-time, part-time, fixed-term, or casual. Distinct from worker_type; governs scheduling, benefits, and labor law compliance.. Valid values are `full_time|part_time|fixed_term|casual`',
    `end_date` DATE COMMENT 'The date on which this position is scheduled to be eliminated or closed. Null for permanent positions. Used for fixed-term headcount planning and budget forecasting.',
    `fte_capacity` DECIMAL(18,2) COMMENT 'The authorized FTE capacity of the position expressed as a decimal (e.g., 1.0 = full-time, 0.5 = half-time). Used for resource planning, capacity planning, and FTE headcount reporting.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether the labor cost of this position is directly billable to a client account or Statement of Work (SOW). True = billable; False = non-billable overhead. Drives client billing and P&L attribution.',
    `is_budgeted` BOOLEAN COMMENT 'Indicates whether this position has an approved budget allocation in the agencys annual headcount plan. True = budgeted; False = unbudgeted or pending approval. Used for P&L and EBITDA reporting.',
    `is_critical_role` BOOLEAN COMMENT 'Flags whether this position is designated as a critical or key role within the agencys talent strategy. Critical roles receive priority in succession planning and talent acquisition pipelines.',
    `is_filled` BOOLEAN COMMENT 'Indicates whether the position is currently occupied by an active worker. True = filled; False = vacant. Supports headcount gap analysis and capacity planning in Workfront resource management.',
    `job_family` STRING COMMENT 'Broad grouping of related job functions within the agency (e.g., Creative, Media, Client Services, Technology, Finance, Operations). Used for compensation benchmarking, career pathing, and workforce analytics in Workday HCM.',
    `max_incumbents` STRING COMMENT 'The maximum number of workers that can simultaneously occupy this position. Typically 1 for standard positions; may be greater for shared or pooled roles. Enforced in Workday HCM position restrictions.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this position record was last modified in the system of record (Workday HCM). Supports change tracking, data quality monitoring, and incremental ETL processing.',
    `pay_grade` STRING COMMENT 'Compensation grade or band assigned to the position, defining the salary range and benefits tier. Confidential business data used for compensation benchmarking and P&L management. Sourced from Workday HCM compensation structure.',
    `position_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the position as assigned in Workday HCM (e.g., POS-ART001). Used for cross-system referencing, reporting, and integration with Workfront resource management.. Valid values are `^POS-[A-Z0-9]{4,12}$`',
    `position_status` STRING COMMENT 'Current lifecycle state of the position within the agency headcount plan. Open = authorized and vacant; Filled = occupied by a worker; Frozen = authorized but hiring suspended; Eliminated = decommissioned; Proposed = pending budget approval.. Valid values are `open|filled|frozen|eliminated|proposed`',
    `seniority_level` STRING COMMENT 'Seniority classification of the position within the agency hierarchy, indicating career level and scope of responsibility. Used for resource planning, compensation benchmarking, and capacity planning. [ENUM-REF-CANDIDATE: junior|mid|senior|lead|director|vp|c_level — 7 candidates stripped; promote to reference product]',
    `standard_hours_per_week` DECIMAL(18,2) COMMENT 'The standard contracted working hours per week for this position. Used for time tracking, capacity planning, and overtime compliance in Workday HCM and Workfront resource management.',
    `target_fill_date` DATE COMMENT 'The target date by which an open position should be filled. Used by talent acquisition teams to track recruiting timelines and manage agency capacity gaps.',
    `title` STRING COMMENT 'Official job title associated with the position as defined in the agency organizational structure (e.g., Art Director, Media Planner, Account Manager, Copywriter, Creative Director). Sourced from Workday HCM.',
    `work_arrangement` STRING COMMENT 'The approved work arrangement for the position — on-site, remote, or hybrid. Reflects post-pandemic workforce policies and impacts resource planning and office capacity management.. Valid values are `on_site|remote|hybrid`',
    `workday_position_reference` STRING COMMENT 'The native position identifier from the Workday HCM source system. Used for system-of-record traceability, ETL reconciliation, and integration with Workfront resource management.',
    `worker_type` STRING COMMENT 'Classification of the position by employment arrangement — Full-Time Equivalent (FTE), contractor, freelancer, intern, or agency temp. Drives payroll processing, benefits eligibility, and FTE headcount reporting in Workday HCM.. Valid values are `fte|contractor|freelancer|intern|agency_temp`',
    `workfront_role_reference` STRING COMMENT 'The corresponding job role identifier in Workfront resource management that maps to this position. Enables cross-system resource allocation, capacity planning, and project staffing.',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Authorized headcount positions within the agency organizational structure — including job title, department, discipline (e.g., Art Director, Media Planner, Account Manager, Copywriter), seniority level, FTE/contractor classification, and budgeted vs. filled status. Sourced from Workday HCM position management.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`talent_profile` (
    `talent_profile_id` BIGINT COMMENT 'Unique surrogate identifier for the talent profile record in the Silver Layer lakehouse. Primary key for this entity. Role classification: MASTER_RESOURCE — this entity represents a professional capability and market-value profile for a worker or influencer managed by the agency.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Talent profiles track brand specialization and certification for specific brand identities. Agencies need to match talent with brand expertise for staffing decisions, pitch teams, and client presentat',
    `worker_id` BIGINT COMMENT 'Reference to the parent worker identity record (employee, freelancer, contractor, influencer, actor, photographer, director, or crew member). This profile is distinct from the identity record and captures professional capability dimensions.',
    `audience_primary_age_range` STRING COMMENT 'The dominant age demographic of the influencers audience, used for campaign audience targeting alignment and media planning. Sourced from platform analytics dashboards. Applicable to influencer talent type only.. Valid values are `13-17|18-24|25-34|35-44|45-54|55+`',
    `audience_primary_gender` STRING COMMENT 'The dominant gender composition of the influencers audience (male, female, or mixed when no single gender exceeds 60%). Used for campaign audience alignment and GRP/TRP planning. Applicable to influencer talent type only.. Valid values are `male|female|mixed`',
    `availability_status` STRING COMMENT 'Current resource availability status for campaign assignment and capacity planning. Sourced from Workfront resource management and Workday HCM time-off records. Used by resource planners to staff campaigns.. Valid values are `available|partially_available|unavailable|on_leave`',
    `award_count` STRING COMMENT 'Total number of industry awards won by the talent (e.g., Cannes Lions, Clio Awards, D&AD, One Show, Effie Awards). Used as a market-value indicator for talent positioning, new business pitches, and rate negotiations.',
    `capacity_hours_per_week` DECIMAL(18,2) COMMENT 'Standard weekly available hours for campaign work, used in Workfront resource planning and FTE (Full-Time Equivalent) capacity calculations. For part-time or fractional workers, reflects contracted hours.',
    `certification_expiry_date` DATE COMMENT 'The earliest expiry date among the talents active certifications. Used to trigger renewal workflows and ensure compliance with client contractual requirements for certified practitioners.',
    `certifications` STRING COMMENT 'Pipe-delimited list of active professional certifications held by the talent (e.g., Google Ads Certified|IAB Digital Media Buying|Meta Blueprint|The Trade Desk Edge Academy|HubSpot Inbound). Used for compliance verification and capability credentialing.',
    `content_niche` STRING COMMENT 'The primary content category or vertical the influencer creates content in (e.g., beauty, fitness, gaming, finance, travel, food, fashion, technology, parenting). Used for brand-audience alignment and campaign targeting strategy. [ENUM-REF-CANDIDATE: beauty|fitness|gaming|finance|travel|food|fashion|technology|parenting|lifestyle — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the talent profile record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail, data lineage, and GDPR data subject request processing.',
    `day_rate_usd` DECIMAL(18,2) COMMENT 'The standard daily billing rate for the talent in US Dollars. Used for project cost estimation, SOW budgeting, and P&L management. For FTE employees, this is the internal cost rate; for freelancers and contractors, this is the contracted rate.',
    `display_name` STRING COMMENT 'The professional or stage name by which the talent is known in the market and on creative briefs, campaign credits, and influencer contracts. May differ from legal name on the worker identity record.',
    `engagement_rate` DECIMAL(18,2) COMMENT 'Average engagement rate (likes + comments + shares divided by impressions or followers) across the influencers primary platform, expressed as a decimal (e.g., 0.0325 = 3.25%). A key KPI for influencer selection and CPM/CPA rate negotiation. Applicable to influencer talent type only.',
    `exclusivity_expiry_date` DATE COMMENT 'The date on which the current exclusivity restriction expires, enabling the talent to work with competing brands. Used to trigger availability alerts and plan future campaign assignments.',
    `exclusivity_restrictions` STRING COMMENT 'Description of any active brand category exclusivity restrictions on the talent (e.g., exclusive to automotive category through 2025-12-31, no competing beverage brands). Critical for conflict-of-interest checks during campaign staffing and IO execution. Applicable primarily to influencer and on-screen talent.',
    `influencer_tier` STRING COMMENT 'Industry-standard tier classification for influencer talent based on total follower count across platforms: nano (<10K), micro (10K–100K), macro (100K–1M), mega (>1M). Drives influencer rate card selection, campaign eligibility, and brand partnership strategy. Null for non-influencer talent types.. Valid values are `nano|micro|macro|mega`',
    `instagram_handle` STRING COMMENT 'The talents Instagram social media handle (username prefixed with @). Used for influencer campaign trafficking, audience verification, and platform-specific performance tracking. Applicable to influencer talent type only.. Valid values are `^@[A-Za-z0-9_.]{1,30}$`',
    `language_capabilities` STRING COMMENT 'Pipe-delimited list of languages the talent can work in professionally, using ISO 639-1 codes (e.g., en|es|fr|de|zh). Essential for multilingual campaign staffing and international client servicing.',
    `media_channel_expertise` STRING COMMENT 'Pipe-delimited list of media channels in which the talent has demonstrated expertise (e.g., SEM|programmatic|OOH|CTV|DOOH|social|print|radio). Used for campaign staffing and capability gap analysis. Stored as a delimited string per Silver Layer conventions; normalized in Gold Layer.',
    `notable_award_names` STRING COMMENT 'Pipe-delimited list of the most significant industry awards won by the talent (e.g., Cannes Lions Gold|D&AD Black Pencil|Effie Gold). Used in agency credentials, pitch decks, and talent marketing materials.',
    `notable_brand_credits` STRING COMMENT 'Pipe-delimited list of notable brand or client names the talent has worked with in prior campaigns. Used for capability demonstration in new business pitches and talent positioning. Excludes current client names subject to confidentiality.',
    `past_brand_partnerships` STRING COMMENT 'Pipe-delimited list of notable past brand partnership names for influencer talent (e.g., Nike|LOreal|Samsung). Used for brand alignment assessment, conflict-of-interest screening, and influencer credentialing in pitch materials.',
    `portfolio_url` STRING COMMENT 'URL to the talents professional portfolio, showreel, or Digital Asset Management (DAM) collection in Workfront. Used during pitching, new business development, and talent acquisition evaluation.. Valid values are `^https?://.+`',
    `primary_discipline` STRING COMMENT 'The principal creative or functional discipline of the talent (e.g., Art Direction, Copywriting, Motion Design, Media Planning, Programmatic Buying, Account Management, Photography, Film Direction). Used for resource planning and capability matching in Workfront. [ENUM-REF-CANDIDATE: art_direction|copywriting|motion_design|media_planning|programmatic_buying|account_management|photography|film_direction|strategy|data_analytics — promote to reference product]',
    `profile_status` STRING COMMENT 'Current lifecycle state of the talent profile record. Active profiles are eligible for campaign assignment and resource planning. Inactive or archived profiles are retained for historical reporting and rights audit purposes.. Valid values are `active|inactive|on_hold|pending_review|archived`',
    `rate_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the talents day rate (e.g., USD, GBP, EUR). Supports multi-currency rate management for international talent and global campaign staffing.. Valid values are `^[A-Z]{3}$`',
    `seniority_level` STRING COMMENT 'Professional seniority classification used for rate card assignment, billing tier determination, and resource planning capacity calculations. Aligns with Workday HCM job grade levels. [ENUM-REF-CANDIDATE: junior|mid|senior|lead|director|vp|c_level — 7 candidates stripped; promote to reference product]',
    `software_proficiencies` STRING COMMENT 'Pipe-delimited list of software tools and platforms the talent is proficient in (e.g., Adobe CC|The Trade Desk|CM360|Salesforce|Workfront|Mediaocean Prisma|Google Analytics|DV360). Critical for project staffing and tool-specific campaign execution.',
    `specialization` STRING COMMENT 'Secondary or niche specialization within the primary discipline (e.g., CTV/OTT media buying, DOOH planning, SEM campaign management, influencer strategy, brand identity design). Enables granular capability matching for complex campaign requirements.',
    `talent_type` STRING COMMENT 'Categorical classification of the talent worker type, determining applicable rate cards, rights management rules, and compliance requirements. [ENUM-REF-CANDIDATE: employee|freelancer|contractor|influencer|actor|photographer|director|production_crew — promote to reference product]',
    `tiktok_handle` STRING COMMENT 'The talents TikTok social media handle. Used for influencer campaign trafficking, content verification, and short-form video performance analytics. Applicable to influencer talent type only.. Valid values are `^@[A-Za-z0-9_.]{1,24}$`',
    `total_follower_count` BIGINT COMMENT 'Aggregate follower count across all active social media platforms for influencer talent. Used for influencer tier classification, CPM rate card assignment, and campaign reach estimation. Refreshed periodically from platform APIs.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent update to the talent profile record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for data freshness monitoring, change detection in ETL pipelines, and audit compliance.',
    `usage_rights_expiry_date` DATE COMMENT 'The date on which the talents current usage rights grant expires. After this date, creative assets featuring the talent may not be used without renegotiation. Triggers rights renewal workflows and asset retirement processes.',
    `usage_rights_summary` STRING COMMENT 'Summary of the talents granted usage rights for creative assets produced (e.g., digital worldwide 2 years, broadcast North America 1 year, social media unlimited). Governs how produced creative assets may be deployed across channels and geographies. Critical for rights management and compliance.',
    `x_handle` STRING COMMENT 'The talents X (formerly Twitter) social media handle. Used for influencer campaign trafficking and social listening integration. Applicable to influencer talent type only.. Valid values are `^@[A-Za-z0-9_]{1,15}$`',
    `years_of_experience` STRING COMMENT 'Total years of professional experience in the talents primary discipline. Used for rate benchmarking, capability assessment, and talent acquisition scoring.',
    `youtube_channel_url` STRING COMMENT 'The talents YouTube channel URL. Used for influencer campaign trafficking, video content verification, and CTV/OTT audience analytics. Applicable to influencer talent type only.. Valid values are `^https?://(www.)?youtube.com/.+`',
    CONSTRAINT pk_talent_profile PRIMARY KEY(`talent_profile_id`)
) COMMENT 'Skills, competencies, certifications, portfolio credits, and specialization metadata for each worker — including creative disciplines, media channel expertise (SEM, programmatic, OOH, CTV), software proficiencies (Adobe CC, The Trade Desk, CM360), language capabilities, and award history. For influencer talent: social platform handles, follower counts per platform (Instagram, TikTok, YouTube, X), engagement rates, audience demographics, content niche/vertical, past brand partnerships, exclusivity restrictions, and influencer tier classification (nano, micro, macro, mega). Distinct from the worker identity record; captures the full professional capability and market-value dimension across all talent types including external influencers with platform-specific commercial attributes.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`talent_engagement` (
    `talent_engagement_id` BIGINT COMMENT 'Unique system-generated identifier for each talent engagement record. Serves as the primary key for the contractual engagement entity linking talent to commercial work.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client account on whose behalf this talent engagement is executed, enabling client-level cost attribution and reporting.',
    `agreement_id` BIGINT COMMENT 'Reference to the underlying contract or Statement of Work (SOW) that governs the terms of this talent engagement.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Engagements represent talent assignments to specific brand identities within advertiser portfolios. Tracks which brand the talent is representing for compliance, usage rights, and brand guideline adhe',
    `campaign_id` BIGINT COMMENT 'Reference to the client campaign or project this engagement supports, linking the talent assignment to the commercial delivery context.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Engagement cost tracking: Freelancer and contractor engagements charged to cost centers for project costing, profitability analysis, and budget management. Enables labor cost rollup and utilization re',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Talent engagements (contracts for freelancers/contractors on campaigns) execute through project initiatives. Linking enables resource planning, cost reconciliation between engagement fees and project ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Talent engagements (freelancers, influencers, crew) are often sourced through vendor suppliers (talent agencies, production companies, staffing firms). Critical for vendor management, payment routing,',
    `actual_end_date` DATE COMMENT 'The actual date the engagement concluded, which may differ from the contracted end date due to early termination, extension, or project completion. Used for variance analysis against planned end date.',
    `agreed_rate` DECIMAL(18,2) COMMENT 'The contractually agreed compensation rate for this engagement, expressed in the billing arrangement unit (per hour, per day, per project, per month for retainer, or per usage unit). This is the base rate before adjustments or markups.',
    `allocated_hours` DECIMAL(18,2) COMMENT 'The total number of hours budgeted or contracted for this engagement over its full duration. Used for time tracking, capacity planning, and billing reconciliation against actuals.',
    `approval_date` DATE COMMENT 'The date on which this talent engagement was formally approved by the authorized manager. Used for audit trails, compliance reporting, and engagement lifecycle tracking.',
    `approved_by` STRING COMMENT 'Name or identifier of the agency manager or account lead who approved this talent engagement. Required for authorization audit trails and financial governance.',
    `billing_arrangement` STRING COMMENT 'The commercial billing model governing how the talent is compensated or charged — hourly rate, day rate, fixed project fee, retainer, or usage-based (e.g., residuals, licensing). Drives invoice generation and financial reconciliation.. Valid values are `hourly|day_rate|project_fee|retainer|usage_based`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this engagement record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides the audit trail creation anchor for data lineage and compliance reporting.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the agreed rate and all financial values for this engagement are denominated (e.g., USD, GBP, EUR). Required for multi-currency financial reconciliation.. Valid values are `^[A-Z]{3}$`',
    `department` STRING COMMENT 'The agency department or practice area to which this engagement is assigned (e.g., Creative, Media, Strategy, Production, Account Management). Used for resource planning, capacity management, and departmental cost allocation.',
    `end_date` DATE COMMENT 'The contractually agreed date on which the talent engagement concludes. Nullable for open-ended FTE engagements. Used for capacity planning and resource availability forecasting.',
    `engagement_type` STRING COMMENT 'Classification of the contractual engagement arrangement — Full-Time Equivalent (FTE) employment, freelance Statement of Work (SOW), contractor agreement, influencer partnership, or production crew booking. Drives billing, compliance, and HR treatment.. Valid values are `fte_employment|freelance_sow|contractor_agreement|influencer_partnership|production_crew_booking`',
    `exclusivity_category` STRING COMMENT 'The product or industry category within which the talent exclusivity applies (e.g., Automotive, Financial Services, FMCG). Defines the competitive scope of the exclusivity restriction.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this engagement includes an exclusivity clause preventing the talent from working with competing brands or agencies during the engagement period. Impacts talent availability and conflict-of-interest management.',
    `fte_equivalent` DECIMAL(18,2) COMMENT 'The Full-Time Equivalent (FTE) fraction representing the proportion of a full working week this talent is allocated to this engagement (e.g., 1.0 = full-time, 0.5 = half-time). Used for capacity planning and resource utilization reporting.',
    `gdpr_consent_obtained` BOOLEAN COMMENT 'Indicates whether the required GDPR consent for processing the talents personal data in connection with this engagement has been obtained. Mandatory for engagements involving EU/EEA-based talent under GDPR Article 6.',
    `io_number` STRING COMMENT 'The Insertion Order (IO) number linking this talent engagement to a specific media buy or production booking, used when talent is engaged for a specific media placement or campaign execution.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'The percentage markup applied by the agency on top of the talents base rate when billing the client. Represents the agencys margin on talent costs and is used for Profit and Loss (P&L) and Return on Investment (ROI) analysis.',
    `on_site_required` BOOLEAN COMMENT 'Indicates whether the talent is required to work on-site at the agency, client premises, or production location, as opposed to working remotely. Impacts resource logistics, travel budgeting, and production planning.',
    `payment_terms` STRING COMMENT 'The agreed payment terms governing when the talent or vendor is paid relative to invoice date or milestone completion. Used for accounts payable scheduling and cash flow management.. Valid values are `net_15|net_30|net_45|net_60|upon_completion|milestone_based`',
    `reference` STRING COMMENT 'Externally-known alphanumeric reference code for this engagement, used in purchase orders, invoices, and communications with talent or agencies. Corresponds to the work order or booking reference number.',
    `role_title` STRING COMMENT 'The specific job title or role designation for this engagement (e.g., Art Director, Copywriter, Director of Photography, Social Media Influencer, Production Coordinator). Distinct from the talents permanent job title.',
    `source_system` STRING COMMENT 'The operational system of record from which this engagement record originated (e.g., Workday HCM, Workfront, Salesforce CRM). Supports data lineage tracking and reconciliation across integrated platforms in the Silver Layer.. Valid values are `workday_hcm|workfront|salesforce_crm|sap_s4hana|mediaocean_prisma|manual`',
    `source_system_code` STRING COMMENT 'The native record identifier from the originating source system (e.g., Workday assignment ID, Workfront task ID). Enables traceability and reconciliation between the lakehouse Silver Layer and operational systems.',
    `sow_number` STRING COMMENT 'The reference number of the Statement of Work (SOW) document governing the scope, deliverables, and terms of this freelance or contractor engagement. Applicable for non-FTE engagement types.',
    `start_date` DATE COMMENT 'The date on which the talent engagement becomes effective and the talent is expected to begin work. Corresponds to the assignment start date in Workday HCM.',
    `talent_engagement_status` STRING COMMENT 'Current lifecycle state of the talent engagement. Draft indicates the engagement is being configured; active means the talent is currently assigned; on_hold indicates a temporary pause; completed means the engagement concluded successfully; terminated indicates early cessation.. Valid values are `draft|active|on_hold|completed|terminated`',
    `tax_classification` STRING COMMENT 'The tax treatment classification for this engagement, determining withholding obligations, VAT applicability, and reporting requirements (e.g., W-2 employee, 1099 contractor, corp-to-corp, VAT registered). Critical for payroll and tax compliance.. Valid values are `w2_employee|1099_contractor|corp_to_corp|vat_registered|exempt`',
    `termination_reason` STRING COMMENT 'The documented reason for early termination of the engagement, if applicable (e.g., project cancellation, budget cut, performance issue, mutual agreement). Populated only when status is terminated. Used for workforce analytics and contract risk management.',
    `total_engagement_value` DECIMAL(18,2) COMMENT 'The total contracted monetary value of this engagement for its full duration (e.g., total project fee, total retainer value, or estimated total for hourly/day-rate engagements). Used for budget management, Profit and Loss (P&L) reporting, and financial forecasting.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent modification to this engagement record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change tracking, data synchronization, and audit compliance.',
    `usage_rights_included` BOOLEAN COMMENT 'Indicates whether usage rights for creative output (e.g., image, video, likeness) are included in the agreed engagement rate. When True, no separate usage licensing fee applies. Critical for talent rights management and compliance.',
    `usage_rights_scope` STRING COMMENT 'Description of the permitted usage scope for creative output produced under this engagement, including media channels, geographic territories, and duration of use (e.g., Digital only, North America, 12 months). Governs rights management and residual payments.',
    `work_location` STRING COMMENT 'The primary work location for this engagement — office name, production studio, client site, or Remote. Used for resource logistics, travel expense management, and capacity planning by location.',
    CONSTRAINT pk_talent_engagement PRIMARY KEY(`talent_engagement_id`)
) COMMENT 'Contractual engagement record for each talent assignment — covering engagement type (FTE employment, freelance SOW, contractor agreement, influencer partnership, production crew booking), start/end dates, engagement status (draft, active, on-hold, completed, terminated), billing arrangement (hourly, day rate, project fee, retainer, usage-based), agreed rate, currency, and the client campaign or project it supports. Bridges talent identity to commercial work and serves as the commercial spine linking worker availability to project delivery.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`talent_rate_card` (
    `talent_rate_card_id` BIGINT COMMENT 'Unique surrogate identifier for each talent rate card record in the Databricks Silver Layer. Primary key for this entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the specific client for whom this rate card was negotiated. Null for market-standard rate cards that are not client-specific. Used to apply client-specific pricing during SOW development and billing reconciliation in Salesforce CRM and Mediaocean Prisma.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Rate cards for external talent (freelancers, influencers, specialized crew) are negotiated with and managed by vendor suppliers (talent agencies, representation firms). Essential for rate negotiation,',
    `approval_date` DATE COMMENT 'Date on which this rate card was formally approved by the designated authority. Used in audit trails and compliance reporting.',
    `approved_by` STRING COMMENT 'Name or identifier of the agency authority (e.g., Finance Director, Head of Talent) who approved this rate card for use in SOW pricing and payroll. Supports governance and audit requirements.',
    `cancellation_fee_pct` DECIMAL(18,2) COMMENT 'Percentage of the agreed day rate or booking fee charged as a cancellation penalty if a booking is cancelled within the notice period defined in the associated contract or SOW. Used in financial reconciliation and dispute management.',
    `channel_specialization` STRING COMMENT 'The media or delivery channel for which this rate applies, reflecting the talents area of expertise (e.g., digital, social, OOH, CTV, OTT, DOOH, print, radio, experiential). Enables channel-specific cost estimation in media planning and campaign budgeting. [ENUM-REF-CANDIDATE: digital|social|ooh|ctv|ott|dooh|print|radio|experiential|search|programmatic — promote to reference product]',
    `cost_center_code` STRING COMMENT 'SAP S/4HANA cost center code associated with this rate card for financial reporting, budget allocation, and P&L reconciliation. Enables accurate cost attribution in agency financial management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate card record was first created in the system. Supports audit trail, data lineage, and compliance reporting requirements under GDPR and CCPA.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the day rate and hourly rate are denominated (e.g., USD, GBP, EUR). Supports multi-market rate card management and financial reconciliation in SAP S/4HANA.. Valid values are `^[A-Z]{3}$`',
    `day_rate` DECIMAL(18,2) COMMENT 'Standard or negotiated billing rate per full working day for this talent role, seniority tier, and channel specialization. Used in SOW pricing, resource cost estimation, and Workday HCM payroll reconciliation. Serves as the principal MEASUREMENT_OR_VALUE for this MASTER_RESOURCE entity.',
    `department_code` STRING COMMENT 'Internal agency department or practice area code to which this rate card belongs (e.g., Creative, Media, Strategy, Production, Analytics). Used for P&L reporting and resource cost allocation in SAP S/4HANA CO.',
    `effective_from` DATE COMMENT 'The date from which this rate card becomes valid and applicable for billing, SOW pricing, and payroll reconciliation. Supports temporal rate management and historical rate lookups.',
    `effective_until` DATE COMMENT 'The date on which this rate card expires and is no longer valid for new engagements. Nullable for open-ended rate cards. Used to enforce rate versioning and prevent billing at outdated rates.',
    `half_day_rate` DECIMAL(18,2) COMMENT 'Billing rate for a half-day engagement (typically 4 hours). Used in production scheduling and SOW pricing where partial-day bookings are standard practice for talent such as photographers, directors, and actors.',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Standard or negotiated billing rate per hour for this talent role and tier. Used for partial-day engagements, time-tracking reconciliation in Workfront, and overtime calculations.',
    `market_region` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the geographic market for which this rate card applies (e.g., USA, GBR, DEU). Supports multi-market agency operations and regional rate differentiation.. Valid values are `^[A-Z]{3}$`',
    `minimum_booking_hours` DECIMAL(18,2) COMMENT 'Minimum number of hours that must be booked and billed for a single engagement under this rate card. Prevents under-billing for short engagements and is used in Workfront resource planning and SOW cost estimation.',
    `notes` STRING COMMENT 'Free-text field for additional context, negotiation history, special conditions, or exceptions associated with this rate card (e.g., Rate includes post-production supervision, Client-specific discount agreed in QBR). Used by account management and finance teams.',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to the hourly or day rate for overtime hours (e.g., 1.5 for time-and-a-half, 2.0 for double time). Used in payroll reconciliation and SOW cost estimation for production-heavy engagements.',
    `rate_card_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this rate card schedule, used in SOW pricing documents, Mediaocean Prisma billing, and Workday HCM compensation references. Serves as the BUSINESS_IDENTIFIER for this MASTER_RESOURCE entity.. Valid values are `^RC-[A-Z0-9]{4,12}$`',
    `rate_card_name` STRING COMMENT 'Human-readable label for the rate card schedule (e.g., FY2025 Senior Creative Standard Rates, Q3 Freelance Digital Specialist Rates). Serves as the IDENTITY_LABEL for this MASTER_RESOURCE entity.',
    `rate_card_status` STRING COMMENT 'Current lifecycle state of the rate card. draft indicates under review; active means currently in use for billing and SOW pricing; superseded means replaced by a newer version; expired means past effective end date; archived means retired from use. Serves as the LIFECYCLE_STATUS for this MASTER_RESOURCE entity.. Valid values are `draft|active|superseded|expired|archived`',
    `rate_tier_type` STRING COMMENT 'Indicates whether this rate card represents a market-standard rate, a client-specific negotiated rate, a preferred vendor rate, a blended rate across seniority levels, or a custom negotiated rate. Drives which rate schedule is applied during SOW pricing and resource cost estimation.. Valid values are `market_standard|client_specific|preferred_vendor|negotiated|blended`',
    `role_type` STRING COMMENT 'The functional role category this rate card applies to (e.g., Art Director, Copywriter, Media Planner, Account Manager, Director, Photographer, Motion Designer, Data Analyst, Producer). Serves as the primary CLASSIFICATION_OR_TYPE for this MASTER_RESOURCE entity. [ENUM-REF-CANDIDATE: art_director|copywriter|media_planner|account_manager|director|photographer|motion_designer|data_analyst|producer|strategist|editor|developer — promote to reference product]',
    `seniority_tier` STRING COMMENT 'Experience and seniority level associated with this rate card, used to differentiate billing rates and resource cost estimation in SOW pricing. Maps to Workday HCM compensation grade levels.. Valid values are `junior|mid|senior|lead|director|executive`',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this rate card record originated (e.g., Workday HCM, Mediaocean Prisma, Workfront, manual entry). Supports data lineage and ETL reconciliation in the Databricks Silver Layer.. Valid values are `workday_hcm|mediaocean_prisma|workfront|manual|salesforce_crm`',
    `talent_category` STRING COMMENT 'Broad workforce classification indicating the engagement model for the talent: Full-Time Equivalent (FTE) employee, freelancer, contractor, influencer, actor, or production crew. Drives payroll treatment, billing rules, and compliance obligations under GDPR/CCPA.. Valid values are `fte|freelancer|contractor|influencer|actor|production_crew`',
    `travel_day_rate` DECIMAL(18,2) COMMENT 'Billing rate applicable for travel days when talent is in transit for production or client engagements. Typically a reduced rate versus the standard day rate, used in production crew and director rate cards.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this rate card record. Used for change tracking, data freshness monitoring, and audit compliance in the Databricks Silver Layer.',
    `usage_rights_duration_days` STRING COMMENT 'Number of days for which usage rights are granted under this rate card. Relevant for talent categories such as actors, influencers, and photographers where time-limited usage rights are standard practice.',
    `usage_rights_included` BOOLEAN COMMENT 'Indicates whether usage rights for creative output (e.g., talent likeness, photography, video performance) are included in the stated rate. When False, usage rights fees must be negotiated separately per talent rights management policy.',
    `usage_rights_scope` STRING COMMENT 'Defines the scope of media usage rights included in or associated with this rate card when usage_rights_included is True. Drives additional licensing fees and talent rights management in contract negotiations.. Valid values are `none|digital_only|broadcast_only|print_only|all_media|custom`',
    `version` STRING COMMENT 'Sequential version number of this rate card, incremented each time rates are renegotiated or updated. Enables historical rate lookups and audit trails for billing disputes and SOW reconciliation.',
    `weekly_rate` DECIMAL(18,2) COMMENT 'Negotiated flat weekly billing rate for sustained engagements, typically offering a discount versus the sum of five day rates. Used for long-term freelancer and contractor engagements in Workday HCM payroll.',
    `workday_compensation_grade` STRING COMMENT 'The compensation grade identifier from Workday HCM that this rate card maps to, enabling synchronization between the rate card schedule and the HR compensation structure for payroll reconciliation.',
    `workfront_role_reference` STRING COMMENT 'The job role identifier from Workfront Resource Planning that corresponds to this rate card, enabling accurate resource cost estimation and capacity planning in project management workflows.',
    CONSTRAINT pk_talent_rate_card PRIMARY KEY(`talent_rate_card_id`)
) COMMENT 'Standard and negotiated billing rate schedules for talent categories — including role type, seniority tier, channel specialization, day rate, hourly rate, overtime multiplier, currency, effective date range, and client-specific or market-standard rate tiers. Used for resource cost estimation, SOW pricing, and payroll reconciliation.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`resource_allocation` (
    `resource_allocation_id` BIGINT COMMENT 'Unique system-generated identifier for each resource allocation record. Serves as the primary key for the resource_allocation data product in the talent domain. Entity role: TRANSACTION_HEADER — represents a discrete booking/assignment event with a clear lifecycle (tentative through released).',
    `advertiser_id` BIGINT COMMENT 'Reference to the client account for which the resource is being allocated. Supports client-level capacity planning, billing reconciliation, and account management reporting.',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign associated with this resource allocation. Enables campaign-level resource utilization reporting and budget reconciliation.',
    `client_brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Resource allocations in advertising frequently target specific brands within multi-brand advertiser accounts. Brand-level resource planning, utilization reporting, and brand P&L analysis require direc',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Resource cost allocation: Resource allocations tied to cost centers for labor cost forecasting, capacity planning financial impact, and utilization-based budget tracking. Supports project-based costin',
    `initiative_id` BIGINT COMMENT 'Reference to the Workfront project, campaign, production shoot, or client account to which the worker is being allocated. Links the allocation to the broader campaign or production context.',
    `project_assignment_id` BIGINT COMMENT 'The native assignment or resource pool record identifier from Workfront, used for system-of-record traceability and data lineage back to the source project management system.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Resource allocations must validate against SOW scope and budget for billing accuracy and capacity planning. Proper FK enables tracking SOW utilization, validating allocations against contracted scope,',
    `talent_engagement_id` BIGINT COMMENT 'Foreign key linking to talent.engagement. Business justification: Resource allocation is the operational execution of a contractual engagement. One allocation can be tied to one engagement; one engagement can have many allocations (e.g., multiple shoot days, multipl',
    `worker_id` BIGINT COMMENT 'Reference to the worker (Full-Time Equivalent employee, freelancer, contractor, influencer, actor, photographer, director, or crew member) being allocated. Maps to the Workday HCM worker record and serves as the PARTY_REFERENCE for this transaction.',
    `allocated_hours_per_week` DECIMAL(18,2) COMMENT 'The number of hours per week the worker is allocated to this project or campaign. Used for capacity planning, utilization tracking, and resource conflict detection. Typically ranges from 0.00 to 40.00 for FTE workers.',
    `allocation_number` STRING COMMENT 'Externally-known business identifier for the allocation record, used in Workfront and cross-system references. Format: RA-{YYYY}-{NNNNNN}. Serves as the BUSINESS_IDENTIFIER for this transaction header.. Valid values are `^RA-[0-9]{4}-[0-9]{6}$`',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the workers total available capacity allocated to this project or campaign (0.00–100.00). Enables multi-project allocation tracking and over-allocation detection. Complements allocated_hours_per_week for percentage-based resource planning.',
    `allocation_status` STRING COMMENT 'Current lifecycle state of the resource allocation. Tentative: initial soft interest; Planned: formally scheduled but not yet confirmed; Confirmed: hard-booked and committed; Released: worker has been released from the assignment; Cancelled: allocation voided. Serves as the LIFECYCLE_STATUS for this transaction header.. Valid values are `tentative|planned|confirmed|released|cancelled`',
    `approved_by` STRING COMMENT 'Name or identifier of the resource manager, department head, or account lead who approved this allocation. Supports governance and audit trail for resource commitment decisions.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this resource allocation was formally approved by the resource manager or account lead. Null if not yet approved or if approval is not required for this booking type.',
    `assignment_type` STRING COMMENT 'Categorizes the nature of the work assignment. Project Work: standard campaign or creative project; Production Shoot: on-location or studio production; Client Account: ongoing account management retainer; New Business: pitch or proposal work; Internal: agency internal initiative.. Valid values are `project_work|production_shoot|client_account|new_business|internal`',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the allocated hours for this resource are billable to the client. True: hours are client-billable; False: hours are internal/non-billable (e.g., new business pitches, internal projects, overhead). Critical for financial reconciliation and client invoicing.',
    `booking_type` STRING COMMENT 'Indicates the commitment level of the resource booking. Hard Book: firm, committed allocation; Soft Book: provisional hold subject to confirmation; Option: first right of refusal on the workers availability. Critical for production scheduling and talent management.. Valid values are `hard_book|soft_book|option`',
    `call_time` TIMESTAMP COMMENT 'For production shoot assignments: the scheduled time the worker is required to report to the set or location (call time). Null for non-production office-based assignments. Critical for production crew scheduling and logistics.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this resource allocation record was first created in the system. Serves as the RECORD_AUDIT_CREATED timestamp for audit trail and data lineage purposes.',
    `crew_role_designation` STRING COMMENT 'For production shoot assignments: the specific on-set crew role designation (e.g., Director of Photography, Gaffer, Key Grip, Production Assistant, Makeup Artist, Wardrobe Stylist). More granular than worker_role and specific to production context. Null for non-production assignments. [ENUM-REF-CANDIDATE: director_of_photography|gaffer|key_grip|production_assistant|makeup_artist|wardrobe_stylist|sound_mixer|camera_operator — promote to reference product]',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the bill_rate and cost_rate for this allocation (e.g., USD, GBP, EUR). Supports multi-currency agency operations and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `department` STRING COMMENT 'The agency department or practice area to which the worker belongs for this allocation (e.g., Creative, Strategy, Media, Account Management, Production, Analytics, Technology). Used for departmental capacity planning and cross-departmental resource sharing.',
    `end_date` DATE COMMENT 'The date on which the workers allocation to the project or campaign ends. Nullable for open-ended allocations. Used for capacity planning and resource release scheduling. Serves as the EFFECTIVE_UNTIL date for this allocation.',
    `notes` STRING COMMENT 'Free-text field for resource managers to capture additional context, special instructions, or conditions associated with this allocation (e.g., Worker available mornings only, Subject to union call sheet requirements, Pending client SOW approval).',
    `priority_level` STRING COMMENT 'Numeric priority ranking for this allocation when a worker has multiple concurrent assignments (1 = highest priority). Used by resource managers to resolve scheduling conflicts and determine which project takes precedence for the workers time.',
    `shoot_location` STRING COMMENT 'For production shoot assignments: the physical location or studio address where the production takes place (e.g., Studio A - Soho, NYC, Location: Malibu Beach, CA). Null for office-based project work. Used for crew logistics and travel planning.',
    `start_date` DATE COMMENT 'The date on which the workers allocation to the project or campaign begins. Used for capacity planning, scheduling, and utilization reporting. Serves as the EFFECTIVE_FROM date for this allocation.',
    `total_allocated_hours` DECIMAL(18,2) COMMENT 'The total number of hours allocated for the entire duration of this assignment (from start_date to end_date). Calculated at booking time and stored for scheduling and billing purposes. Distinct from allocated_hours_per_week which is the weekly rate.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this resource allocation record was last modified. Serves as the RECORD_AUDIT_UPDATED timestamp for change tracking, incremental ETL processing, and audit compliance.',
    `utilization_target_percentage` DECIMAL(18,2) COMMENT 'The target billable utilization percentage for this worker on this allocation, as set by resource management. Used to measure actual vs. planned utilization and inform capacity planning decisions. Distinct from allocation_percentage which reflects scheduled capacity.',
    `wbs_code` STRING COMMENT 'The SAP Work Breakdown Structure (WBS) element code identifying the specific project phase or deliverable to which this allocation is assigned. Enables granular project cost tracking and financial reconciliation at the deliverable level.',
    `worker_type` STRING COMMENT 'Classification of the workers employment relationship for this allocation. Full-Time Equivalent (FTE): salaried employee; Freelancer: independent creative professional; Contractor: third-party contracted resource; Influencer: paid social/content talent; Talent: on-screen actor/model/spokesperson; Crew: production crew member (grip, gaffer, PA, etc.).. Valid values are `fte|freelancer|contractor|influencer|talent|crew`',
    `wrap_time` TIMESTAMP COMMENT 'For production shoot assignments: the scheduled time the worker is expected to complete their duties and wrap for the day. Null for non-production assignments. Used for crew scheduling, overtime calculation, and production logistics.',
    CONSTRAINT pk_resource_allocation PRIMARY KEY(`resource_allocation_id`)
) COMMENT 'Planned and confirmed assignment of workers to campaigns, projects, production shoots, or client accounts — including allocated hours per week, allocation percentage, role on the project, start/end dates, allocation status (tentative, planned, confirmed, released), utilization target, and booking type (hard book, soft book, option). For production assignments: call times, wrap times, shoot locations, and crew role designations. Sourced from Workfront resource management and Workday HCM. Serves as the single scheduling system for both office-based project work and on-location production crew bookings.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`timesheet` (
    `timesheet_id` BIGINT COMMENT 'Unique system-generated identifier for each timesheet record. Serves as the primary key for the timesheet entity in the Workday HCM Time Tracking module silver layer.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client (advertiser) for whom the majority of work on this timesheet was performed. Used for client-level billing reconciliation and account profitability reporting.',
    `worker_id` BIGINT COMMENT 'Reference to the manager or supervisor who approved or rejected this timesheet. Links to the worker/employee master record for the approving party.',
    `cost_center_id` BIGINT COMMENT 'Reference to the primary cost center against which the workers time is charged for this pay period. Supports P&L reporting and granular cost allocation in SAP S/4HANA.',
    `holiday_calendar_id` BIGINT COMMENT 'Reference to the jurisdiction-specific holiday calendar applied to this timesheet for holiday hours identification and overtime rule application. Supports multi-jurisdiction time capture.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Timesheets capture hours worked by workers; linking to initiative enables project-level cost accounting, billing reconciliation, utilization reporting by project, and labor cost actuals for project bu',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational department to which the worker belongs for this pay period. Used for internal cost allocation and utilization reporting.',
    `original_timesheet_id` BIGINT COMMENT 'For amended timesheets (is_amended = true), references the original timesheet record that this amendment supersedes. Null for original submissions. Supports audit trail and payroll adjustment reconciliation.',
    `payroll_run_id` BIGINT COMMENT 'Identifier of the payroll processing run in which this timesheets hours were included. Populated after payroll processing. Used for payroll reconciliation and audit traceability back to SAP S/4HANA payroll runs.',
    `resource_allocation_id` BIGINT COMMENT 'Foreign key linking to talent.resource_allocation. Business justification: Timesheet hours are logged against a specific resource allocation (the planned booking). One timesheet references one allocation; one allocation can have many timesheets over its duration. This links ',
    `sow_id` BIGINT COMMENT 'Reference to the Statement of Work (SOW) or contract under which the workers time is being billed. Links timesheet hours to contractual scope and budget for client billing validation.',
    `task_id` BIGINT COMMENT 'Foreign key linking to project.task. Business justification: Timesheets often capture task-level time detail for granular tracking. Linking enables task cost actuals calculation, earned value analysis, task completion validation, and detailed project accounting',
    `timesheet_worker_id` BIGINT COMMENT 'Reference to the worker (employee, freelancer, contractor, or production crew member) who submitted this timesheet. Links to the talent/worker master record in Workday HCM.',
    `approval_status` STRING COMMENT 'Current workflow lifecycle state of the timesheet. Drives payroll processing eligibility and client billing readiness. Values: draft (in progress), submitted (pending review), approved (cleared for payroll/billing), rejected (returned for correction), recalled (withdrawn by worker after submission).. Valid values are `draft|submitted|approved|rejected|recalled`',
    `approved_timestamp` TIMESTAMP COMMENT 'Precise date and time when the approving manager approved the timesheet. Null if not yet approved. Used for approval cycle-time analytics and payroll processing triggers.',
    `billable_hours` DECIMAL(18,2) COMMENT 'Total hours within this timesheet classified as billable to clients. Foundation for client invoicing, ROAS analysis, and agency utilization rate calculations.',
    `billing_rate` DECIMAL(18,2) COMMENT 'The hourly rate at which the workers billable time is charged to clients for this pay period. Used in conjunction with billable_hours to calculate client invoice amounts. Confidential commercial rate data.',
    `cost_rate` DECIMAL(18,2) COMMENT 'The internal hourly cost rate for the worker during this pay period, used for P&L analysis, margin calculation, and cost allocation to campaigns and clients. Confidential internal financial data.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the timesheet record was first created in the system (typically when the worker initiates a draft). Provides the audit trail creation anchor for the timesheet lifecycle.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the workers compensation for this timesheet period. Supports multi-currency payroll processing for global agency operations.. Valid values are `^[A-Z]{3}$`',
    `holiday_hours` DECIMAL(18,2) COMMENT 'Total hours worked on public holidays within this pay period, as determined by the jurisdiction-specific holiday calendar. Used for holiday pay premium calculations.',
    `is_amended` BOOLEAN COMMENT 'Indicates whether this timesheet is an amendment to a previously approved timesheet. Amended timesheets trigger payroll adjustment processing and client billing correction workflows.',
    `is_late_submission` BOOLEAN COMMENT 'Indicates whether the timesheet was submitted after the defined deadline for the pay period. Used for compliance monitoring, payroll delay risk management, and manager escalation workflows.',
    `jurisdiction_code` STRING COMMENT 'The regulatory jurisdiction governing overtime rules, holiday calendars, and labor law compliance for this timesheet. Typically an ISO 3166-1 alpha-2 country code or a state/province code (e.g., US-CA, GB, DE). Determines which overtime thresholds and holiday schedules apply.. Valid values are `^[A-Z]{2,5}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the timesheet record was most recently updated. Tracks the full edit history anchor for change data capture (CDC) in the Databricks silver layer pipeline.',
    `non_billable_hours` DECIMAL(18,2) COMMENT 'Total hours within this timesheet classified as non-billable (internal meetings, training, admin, business development). Used for overhead cost analysis and FTE utilization benchmarking.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Total overtime hours recorded in this timesheet, calculated per applicable jurisdiction-specific overtime rules. Drives overtime pay calculations in payroll and flags capacity issues in resource planning.',
    `pay_period_end_date` DATE COMMENT 'The last calendar date of the pay period covered by this timesheet. Together with pay_period_start_date defines the billing and payroll window.',
    `pay_period_start_date` DATE COMMENT 'The first calendar date of the pay period covered by this timesheet. Used to align time entries with payroll cycles and client billing periods.',
    `pay_period_type` STRING COMMENT 'The frequency classification of the pay period covered by this timesheet. Determines payroll processing cadence and aligns with Workday HCM payroll group configurations.. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `rejection_reason` STRING COMMENT 'Free-text explanation provided by the approver when rejecting a timesheet. Null for approved or pending timesheets. Used for worker feedback and compliance audit trails.',
    `submission_date` DATE COMMENT 'The calendar date on which the worker formally submitted the timesheet for approval. Used for compliance tracking against submission deadlines and late-submission reporting.',
    `submission_method` STRING COMMENT 'Channel or interface through which the timesheet was submitted. Supports audit and system integration analysis. Values: web (Workday web portal), mobile (Workday mobile app), api (programmatic submission via API integration), manual_entry (back-office data entry).. Valid values are `web|mobile|api|manual_entry`',
    `submitted_timestamp` TIMESTAMP COMMENT 'Precise date and time when the worker submitted the timesheet. Provides audit trail for SLA compliance and payroll cut-off adherence.',
    `timesheet_number` STRING COMMENT 'Externally-known business identifier for the timesheet, used in payroll processing, client billing, and audit references. Formatted as TS-{YYYY}-{NNNNNN}.. Valid values are `^TS-[0-9]{4}-[0-9]{6}$`',
    `total_hours` DECIMAL(18,2) COMMENT 'Sum of all hours recorded across all time entries within this timesheet for the pay period. Used as the header-level control total for payroll processing and utilization reporting.',
    `utilization_rate` DECIMAL(18,2) COMMENT 'The ratio of billable hours to total hours for this timesheet period (billable_hours / total_hours). A key FTE productivity KPI used in agency capacity planning, QBR reporting, and resource optimization. Stored as a decimal (e.g., 0.7500 = 75%).',
    `wip_code` STRING COMMENT 'The Work in Progress (WIP) accounting code associated with this timesheet for financial reconciliation. Used in SAP S/4HANA project accounting to track unbilled labor costs against active client engagements.',
    `worker_notes` STRING COMMENT 'Free-text notes entered by the worker at the timesheet header level to provide context for the pay periods time allocation. May include project status updates, absence explanations, or billing clarifications.',
    `worker_type` STRING COMMENT 'Classification of the worker submitting the timesheet. Determines applicable overtime rules, billing rates, and payroll processing logic. [ENUM-REF-CANDIDATE: fte|freelancer|contractor|influencer|actor|photographer|director|production_crew — promote to reference product]',
    CONSTRAINT pk_timesheet PRIMARY KEY(`timesheet_id`)
) COMMENT 'Time tracking records submitted by workers — containing both header-level metadata (pay period, submission date, approval status, approver, submission method) and line-level entries (hours per project/campaign/cost center, activity type such as creative production, media planning, client meetings, or admin, billable vs. non-billable classification, overtime hours, task-level project codes, and date of work). Each timesheet encompasses all individual time entries for a pay period. Sourced from Workday HCM Time Tracking module. Foundation for client billing, payroll processing, utilization reporting, and granular cost allocation to campaigns and clients. Supports multi-project, multi-jurisdiction time capture with jurisdiction-specific overtime rules and holiday calendars.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`payroll_record` (
    `payroll_record_id` BIGINT COMMENT 'Unique surrogate identifier for each processed payroll record in the Workday HCM Payroll module. Primary key for the payroll_record data product. TRANSACTION_HEADER role — canonical entity for compensation disbursement history.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Labor cost allocation: Payroll costs must be allocated to cost centers for departmental P&L reporting, budget variance analysis, and client billing/cost recovery. Standard practice in advertising agen',
    `original_payroll_record_id` BIGINT COMMENT 'Self-referencing identifier pointing to the original payroll record that this record corrects or reverses. Null for original records. Enables audit trail reconstruction for payroll corrections and compliance investigations.',
    `payroll_run_id` BIGINT COMMENT 'Reference to the payroll run batch that generated this record. A single payroll run processes all eligible workers for a given pay period and company code.',
    `worker_id` BIGINT COMMENT 'Reference to the worker (FTE employee, freelancer, contractor, actor, photographer, director, or production crew member) for whom this payroll record was processed. Links to the talent/worker master record in Workday HCM.',
    `bank_account_last4` STRING COMMENT 'Last four digits of the workers bank account number to which direct deposit was made. Stored for reconciliation and worker inquiry resolution without exposing full account details. Full account data is managed in Workday HCM.. Valid values are `^[0-9]{4}$`',
    `base_pay_amount` DECIMAL(18,2) COMMENT 'The fixed salary or hourly wage component of gross pay for the pay period, excluding variable compensation such as overtime, bonuses, and commissions. Used for FTE cost benchmarking and P&L labor cost analysis.',
    `benefits_deduction_amount` DECIMAL(18,2) COMMENT 'Total employee-paid benefits contributions deducted in this pay period, including health insurance premiums, dental, vision, life insurance, and flexible spending account (FSA) contributions. Sourced from Workday HCM Benefits module elections.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Discretionary or performance-based bonus payment included in this pay period disbursement. May reflect campaign performance bonuses, new business win incentives, or annual performance awards tied to KPI achievement.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Variable compensation earned based on sales or account revenue performance, included in this pay period. Applicable to account managers and business development staff whose compensation includes commission on client billings or new business.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this payroll record was first created in the Workday HCM Payroll module. RECORD_AUDIT_CREATED field for the TRANSACTION_HEADER. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX per platform convention.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this payroll record (e.g., USD, GBP, EUR). Required for multi-currency payroll processing for international talent and production crews.. Valid values are `^[A-Z]{3}$`',
    `employer_tax_contribution` DECIMAL(18,2) COMMENT 'Total employer-side payroll tax obligations for this worker in this pay period, including employer FICA (Social Security and Medicare match) and FUTA/SUTA contributions. Used for total labor cost reporting in SAP S/4HANA CO.',
    `federal_tax_withheld` DECIMAL(18,2) COMMENT 'Amount of federal income tax withheld from the workers gross pay in this pay period. Calculated based on the workers W-4 elections and applicable IRS tax tables. Required for IRS Form W-2 and 941 reporting.',
    `gl_account_code` STRING COMMENT 'SAP S/4HANA FI general ledger account code for the payroll expense posting. Maps payroll disbursements to the correct expense accounts in the agencys chart of accounts for financial reporting.',
    `gross_pay_amount` DECIMAL(18,2) COMMENT 'Total compensation earned by the worker before any deductions, taxes, or withholdings for the pay period. Includes base salary/wages, overtime, bonuses, commissions, and allowances. Core component of the MONETARY_TRIPLET for this transaction.',
    `hours_worked` DECIMAL(18,2) COMMENT 'Total regular hours worked by the worker during the pay period as recorded in Workday HCM Time Tracking or Workfront resource management. Used for hourly rate reconciliation, project cost allocation, and FLSA compliance.',
    `is_off_cycle` BOOLEAN COMMENT 'Indicates whether this payroll record was generated as part of an off-cycle payroll run (e.g., termination pay, correction run, bonus payout) rather than the standard scheduled payroll cycle. Off-cycle runs require additional approval in Workday HCM.',
    `medicare_tax_withheld` DECIMAL(18,2) COMMENT 'Employee portion of Medicare (HI) tax withheld in this pay period, including the Additional Medicare Tax for high earners where applicable. Required for IRS Form W-2 reporting.',
    `net_pay_amount` DECIMAL(18,2) COMMENT 'The take-home amount disbursed to the worker after all deductions, tax withholdings, and benefits contributions have been subtracted from gross pay. Represents the actual cash transferred to the worker. Core component of the MONETARY_TRIPLET.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of hours worked beyond the standard scheduled hours in the pay period that qualify for overtime pay. Sourced from Workday HCM Time Tracking. Required for FLSA compliance and production cost reporting.',
    `overtime_pay_amount` DECIMAL(18,2) COMMENT 'Compensation paid for hours worked beyond the standard work schedule in the pay period. Relevant for production crews, shoot days, and campaign crunch periods. Tracked separately for FLSA compliance and project cost allocation.',
    `pay_date` DATE COMMENT 'The actual date on which compensation was disbursed to the worker. This is the BUSINESS_EVENT_TIMESTAMP (date-precision) for the payroll transaction — the real-world event date when funds were released.',
    `pay_frequency` STRING COMMENT 'The cadence at which the worker is paid. Drives payroll run scheduling and annualization of compensation figures for P&L reporting and FTE cost analysis.. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `pay_period_end_date` DATE COMMENT 'The last calendar date of the pay period covered by this payroll record. Defines the closing boundary of the earnings window.',
    `pay_period_start_date` DATE COMMENT 'The first calendar date of the pay period covered by this payroll record. Together with pay_period_end_date, defines the earnings window for gross pay calculation.',
    `pay_rate` DECIMAL(18,2) COMMENT 'The workers compensation rate applicable for this pay period — expressed as hourly rate for non-exempt workers or as the annualized salary divided by pay periods for exempt employees. Sourced from Workday HCM Compensation module.',
    `pay_rate_type` STRING COMMENT 'Indicates whether the workers compensation is structured as an hourly rate, fixed salary, daily rate (common for freelancers and production crew), or project-based flat rate. Determines how pay_rate is applied to calculate base_pay_amount.. Valid values are `hourly|salary|daily_rate|project_rate`',
    `payment_method` STRING COMMENT 'The mechanism by which net pay was disbursed to the worker. Direct deposit is standard for FTE employees; wire transfer may be used for international contractors and production talent.. Valid values are `direct_deposit|check|wire_transfer|prepaid_card`',
    `payroll_number` STRING COMMENT 'Externally-known business identifier for this payroll record, formatted as PR-{YYYY}-{MM}-{sequence}. Used for reconciliation with SAP S/4HANA FI/CO postings and Mediaocean Prisma billing reconciliation.. Valid values are `^PR-[0-9]{4}-[0-9]{2}-[0-9]{6}$`',
    `payroll_run_status` STRING COMMENT 'Current lifecycle state of this payroll record within the payroll processing workflow. Tracks progression from initial calculation through final disbursement or reversal. LIFECYCLE_STATUS for this TRANSACTION_HEADER entity.. Valid values are `pending|processing|completed|reversed|on_hold`',
    `retirement_contribution_amount` DECIMAL(18,2) COMMENT 'Employee pre-tax or Roth retirement plan contribution (e.g., 401(k), 403(b)) deducted from gross pay in this pay period. Tracked separately from other benefits deductions for IRS Form W-2 Box 12 reporting.',
    `reversal_indicator` BOOLEAN COMMENT 'Flags whether this payroll record represents a reversal of a previously processed payroll disbursement. Reversals occur due to overpayments, incorrect bank details, or payroll corrections. Linked to the original record via original_payroll_record_id.',
    `social_security_tax_withheld` DECIMAL(18,2) COMMENT 'Employee portion of Social Security (OASDI) tax withheld in this pay period. Calculated at the statutory rate on wages up to the annual wage base. Required for IRS Form W-2 reporting.',
    `state_tax_withheld` DECIMAL(18,2) COMMENT 'Amount of state income tax withheld from the workers gross pay in this pay period. Varies by state of employment. Relevant for agencies with multi-state operations and talent working across production locations.',
    `tax_jurisdiction_code` STRING COMMENT 'The primary tax jurisdiction code applicable to this payroll record, identifying the state/locality combination for tax withholding purposes. Critical for agencies with talent working across multiple states and production locations.',
    `total_deductions_amount` DECIMAL(18,2) COMMENT 'Aggregate of all pre-tax and post-tax deductions applied in this pay period, including benefits contributions, garnishments, and voluntary deductions. Represents the adjustment component of the MONETARY_TRIPLET (gross_pay_amount minus total_deductions_amount yields net_pay_amount).',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent modification to this payroll record in the Workday HCM Payroll module. RECORD_AUDIT_UPDATED field for the TRANSACTION_HEADER. Tracks corrections, status changes, and reversals.',
    `worker_type` STRING COMMENT 'Classification of the worker receiving this payroll disbursement. Determines applicable tax withholding rules, benefits eligibility, and payment processing logic. [ENUM-REF-CANDIDATE: FTE|contractor|freelancer|influencer|actor|photographer|director|production_crew — promote to reference product]',
    `ytd_gross_pay` DECIMAL(18,2) COMMENT 'Cumulative gross pay earned by the worker from the start of the calendar year through this pay period. Required for W-2 preparation, Social Security wage base tracking, and annual compensation reporting.',
    `ytd_tax_withheld` DECIMAL(18,2) COMMENT 'Cumulative total of all federal, state, and local taxes withheld from the workers pay from the start of the calendar year through this pay period. Required for W-2 preparation and tax reconciliation.',
    CONSTRAINT pk_payroll_record PRIMARY KEY(`payroll_record_id`)
) COMMENT 'Processed payroll records for FTE and contractor workers — including gross pay, net pay, deductions, tax withholdings, benefits contributions, pay period, pay date, payment method, and payroll run status. Sourced from Workday HCM Payroll module. SSOT for compensation disbursement history.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`acquisition` (
    `acquisition_id` BIGINT COMMENT 'Unique surrogate identifier for each talent acquisition (recruiting) record in the Workday HCM Talent Acquisition module. Primary key for the talent_acquisition data product.',
    `candidate_id` BIGINT COMMENT 'Reference to the candidate profile record associated with this talent acquisition pipeline entry. Links to the candidate master record in the talent domain.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to talent.org_unit. Business justification: Talent acquisition requisition is for a position within a specific organizational unit. One requisition targets one org_unit; one org_unit can have many requisitions over time. This links the recruitm',
    `requisition_id` BIGINT COMMENT 'Reference to the parent job requisition that initiated this talent acquisition record. Links to the requisition that authorized the open headcount.',
    `worker_id` BIGINT COMMENT 'Reference to the internal employee record of the hiring manager responsible for this requisition and candidate evaluation.',
    `actual_start_date` DATE COMMENT 'Actual date on which the hired employee or contractor commenced their engagement. May differ from target_start_date due to notice periods, background check delays, or onboarding scheduling.',
    `agency_fee_pct` DECIMAL(18,2) COMMENT 'Agreed fee percentage of the hired candidates first-year base salary payable to the external staffing agency upon successful placement. Used for cost-per-hire calculation and vendor cost management.',
    `agency_name` STRING COMMENT 'Name of the external staffing or executive search agency engaged to source candidates for this requisition, if applicable. Null for direct-sourced or internally recruited positions.',
    `application_date` DATE COMMENT 'Date on which the candidate submitted their application for the position. Marks the entry point of the candidate into the recruiting pipeline for this requisition.',
    `approved_headcount_count` STRING COMMENT 'Number of approved positions authorized under this requisition. Most requisitions are for a single hire, but bulk requisitions for production crews, campaign teams, or seasonal staff may authorize multiple hires.',
    `background_check_status` STRING COMMENT 'Current status of the pre-employment background screening process for the candidate. Required for compliance with agency client contracts and regulatory requirements. Blocks onboarding until Passed or Waived.. Valid values are `Not Initiated|In Progress|Passed|Failed|Waived`',
    `compensation_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the offered compensation amounts. Required for multi-currency agencies operating across global markets. Examples: USD, GBP, EUR.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this talent acquisition record was first created in the Workday HCM system. Serves as the audit trail creation marker and is used for data lineage and pipeline velocity reporting.',
    `decline_reason` STRING COMMENT 'Reason recorded when a candidate declines an offer or is rejected during the pipeline. Examples include Compensation Below Expectation, Accepted Competing Offer, Skills Mismatch, Culture Fit. Used for pipeline quality analysis and offer competitiveness benchmarking. [ENUM-REF-CANDIDATE: Compensation Below Expectation|Accepted Competing Offer|Skills Mismatch|Culture Fit|Role Changed|Candidate Withdrew|Failed Assessment — promote to reference product]',
    `employment_type` STRING COMMENT 'Classification of the engagement type for the open position. FTE (Full-Time Equivalent) indicates a permanent headcount addition; Freelancer and Contractor indicate project-based or time-limited engagements common in advertising production and campaign delivery.. Valid values are `FTE|Freelancer|Contractor|Intern|Part-Time|Temporary`',
    `headcount_type` STRING COMMENT 'Classification of whether this requisition represents a replacement for a departing employee (Backfill), a net-new addition to the team (New Headcount), a conversion from contractor to FTE (Conversion), or a role upgrade/reclassification (Upgrade). Drives budget approval workflows.. Valid values are `Backfill|New Headcount|Conversion|Upgrade`',
    `interview_rounds_count` STRING COMMENT 'Total number of interview rounds completed for this candidate on this requisition. Used to measure interview process efficiency and candidate experience quality.',
    `is_remote_eligible` BOOLEAN COMMENT 'Indicates whether the position is eligible for fully remote or hybrid work arrangements. Relevant for talent pool expansion and workforce flexibility planning in the advertising industry.',
    `job_family` STRING COMMENT 'Broad functional grouping of the role within the agencys workforce taxonomy. Examples include Creative, Media, Account Management, Analytics, Technology, Finance, Talent. [ENUM-REF-CANDIDATE: Creative|Media|Account Management|Analytics|Technology|Finance|Talent|Strategy|Production|Operations — promote to reference product]',
    `job_level` STRING COMMENT 'Seniority level of the open position within the agencys career framework. Drives compensation banding, approval workflows, and resource planning capacity calculations. [ENUM-REF-CANDIDATE: Junior|Mid-Level|Senior|Lead|Manager|Director|VP|C-Suite — 8 candidates stripped; promote to reference product]',
    `job_title` STRING COMMENT 'Official job title for the open position as defined in the requisition. Examples include Senior Media Planner, Creative Director, Programmatic Campaign Manager, Account Executive.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this talent acquisition record in the Workday HCM system. Used for incremental data extraction (ETL) and audit trail compliance.',
    `offer_date` DATE COMMENT 'Date on which the formal employment offer was extended to the candidate. Used to calculate offer-to-acceptance cycle time and to track offer expiry.',
    `offer_expiry_date` DATE COMMENT 'Date by which the candidate must accept or decline the offer. After this date, the offer is automatically rescinded if no response is received.',
    `offer_status` STRING COMMENT 'Current status of the employment offer extended to the candidate. Tracks the offer lifecycle from issuance through acceptance or decline. Critical for headcount forecasting and onboarding planning.. Valid values are `Not Issued|Pending Approval|Issued|Accepted|Declined|Rescinded`',
    `offered_base_salary` DECIMAL(18,2) COMMENT 'Annual base salary amount offered to the candidate in the employment offer. Expressed in the local currency of the office location. Sensitive compensation data used in offer approval workflows and P&L headcount cost planning.',
    `offered_bonus_target_pct` DECIMAL(18,2) COMMENT 'Target annual bonus as a percentage of base salary included in the offer. Reflects the variable compensation component of the total compensation package offered to the candidate.',
    `pipeline_stage` STRING COMMENT 'Current stage of the candidate in the recruiting pipeline as tracked in Workday HCM. Represents the candidates progression from application through onboarding. Drives recruiter workflow and hiring velocity reporting. [ENUM-REF-CANDIDATE: Applied|Screening|Interview|Assessment|Offer|Onboarding|Withdrawn|Rejected — 8 candidates stripped; promote to reference product]',
    `posting_channel` STRING COMMENT 'Primary external channel on which the job was posted to attract candidates. Examples include LinkedIn, Indeed, Glassdoor, Agency Website, Industry Boards (4As, ANA). Distinct from source_of_hire which tracks where the hired candidate originated. [ENUM-REF-CANDIDATE: LinkedIn|Indeed|Glassdoor|Agency Website|4As Job Board|ANA Job Board|Campus Portal|Internal Portal — promote to reference product]',
    `recruiter_name` STRING COMMENT 'Name of the internal recruiter or talent acquisition specialist assigned to manage this requisition and candidate pipeline. Used for workload distribution and recruiter performance reporting.',
    `requisition_close_date` DATE COMMENT 'Date on which the requisition was formally closed, either because the position was filled, cancelled, or put on indefinite hold. Used to calculate time-to-fill metrics.',
    `requisition_number` STRING COMMENT 'Externally visible, human-readable requisition number assigned by Workday HCM at the time the job requisition is created. Used in communications with candidates, agencies, and job boards.. Valid values are `^REQ-[0-9]{6,10}$`',
    `requisition_open_date` DATE COMMENT 'Date on which the job requisition was formally opened and approved for recruiting. Used as the start point for time-to-fill and time-to-hire KPI calculations.',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the job requisition. Tracks whether the headcount need is actively being recruited against, paused, or resolved. Used in open headcount reporting and budget reconciliation.. Valid values are `Draft|Open|On Hold|Filled|Cancelled|Closed`',
    `salary_band_max` DECIMAL(18,2) COMMENT 'Maximum of the approved compensation band for this job level and family. Used to validate that the offered salary falls within the approved range and to support pay equity analysis.',
    `salary_band_min` DECIMAL(18,2) COMMENT 'Minimum of the approved compensation band for this job level and family. Used to validate that the offered salary falls within the approved range and to support pay equity analysis.',
    `source_of_hire` STRING COMMENT 'Channel or method through which the candidate was sourced. Examples include LinkedIn, Employee Referral, Agency, Job Board, Direct Application, Campus Recruiting. Used to measure recruiting channel effectiveness and cost-per-hire by source. [ENUM-REF-CANDIDATE: LinkedIn|Employee Referral|Staffing Agency|Job Board|Direct Application|Campus Recruiting|Internal Transfer|Social Media — promote to reference product]',
    `target_start_date` DATE COMMENT 'Planned date on which the hired candidate is expected to begin employment. Used for onboarding scheduling, resource capacity planning in Workfront, and campaign staffing alignment.',
    `work_authorization_status` STRING COMMENT 'Candidates legal authorization to work in the country of the office location. Determines whether visa sponsorship is required and impacts time-to-start planning. Relevant for global advertising agencies with international talent pools.. Valid values are `Authorized|Requires Sponsorship|Pending Verification|Not Authorized`',
    CONSTRAINT pk_acquisition PRIMARY KEY(`acquisition_id`)
) COMMENT 'Recruitment and hiring pipeline records — including requisition details, job posting channels, candidate pipeline stage, hiring manager, target start date, offer status, compensation offered, and source of hire. Sourced from Workday HCM Talent Acquisition (Recruiting) module. Tracks open headcount from requisition through onboarding.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`usage_right` (
    `usage_right_id` BIGINT COMMENT 'Unique system-generated identifier for the usage right record. Primary key for the usage_right data product within the talent domain.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent talent contract or Statement of Work (SOW) under which this usage right was granted. Links to the contract data product in the Contract domain.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Usage rights are granted for specific brand identities, not just campaigns. Critical for brand compliance checks, exclusivity enforcement across brand portfolios, and rights clearance workflows. Adver',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign for which this usage right was acquired. Enables campaign-level rights compliance tracking and reporting.',
    `conversion_event_id` BIGINT COMMENT 'Foreign key linking to performance.conversion_event. Business justification: Supports talent performance attribution—measuring which on-screen talent (actors, influencers) drive conversions to justify usage rights investments and inform renewal/rate negotiations. Standard ROI ',
    `creative_asset_id` BIGINT COMMENT 'Reference to the specific creative asset (advertisement, photograph, video, audio recording) to which this usage right applies. Links to the creative domain asset registry.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Usage rights are often negotiated within SOW scope; proper FK enables tracking which SOW governs talent usage rights, critical for rights clearance workflows, compliance audits, and ensuring usage ter',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Usage rights for talent (actors, influencers, models) are negotiated through and managed by vendor suppliers (talent agencies, rights management firms). Critical for rights clearance workflows, paymen',
    `worker_id` BIGINT COMMENT 'The Workday HCM system worker identifier for the talent, enabling integration between the usage rights record and the talents HR, payroll, and time-tracking records in Workday. Supports residual payment processing through the payroll module.',
    `approved_by` STRING COMMENT 'The name or identifier of the business affairs manager, legal counsel, or authorized agency representative who formally approved and cleared this usage right. Provides audit trail for rights clearance accountability.',
    `ccpa_opt_out_status` STRING COMMENT 'The California Consumer Privacy Act (CCPA) opt-out status for the talents personal data usage in California-targeted campaigns. opted_in permits use; opted_out restricts use of personal data for California audiences; not_applicable for non-California markets.. Valid values are `opted_in|opted_out|not_applicable`',
    `clearance_date` DATE COMMENT 'The date on which the usage right was formally cleared by the legal or business affairs team, confirming all contractual and union obligations have been satisfied and the creative asset may be deployed.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this usage right record was first created in the system. Corresponds to the MASTER_AGREEMENT RECORD_AUDIT_CREATED category. Supports data lineage, audit trails, and compliance reporting.',
    `exclusivity_category` STRING COMMENT 'The product or service category within which exclusivity applies when exclusivity_scope is category_exclusive (e.g., automotive, financial services, consumer packaged goods). Null when exclusivity_scope is exclusive or non_exclusive.',
    `exclusivity_scope` STRING COMMENT 'Defines whether the usage right is exclusive to this agency/client, non-exclusive (talent may appear in competing campaigns), or category-exclusive (exclusive within a specific product/service category). Exclusive rights typically command higher fees and restrict talent from competitor engagements.. Valid values are `exclusive|non_exclusive|category_exclusive`',
    `fee_amount` DECIMAL(18,2) COMMENT 'The agreed monetary fee paid to the talent or their representative for this usage right grant. For buyout structures, this is the total one-time fee. For residual structures, this is the base session fee. Expressed in the currency specified by fee_currency_code.',
    `fee_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the fee amount (e.g., USD, GBP, EUR, CAD). Required for multi-territory rights where fees may be denominated in local currency.. Valid values are `^[A-Z]{3}$`',
    `gdpr_consent_obtained` BOOLEAN COMMENT 'Indicates whether explicit GDPR-compliant consent has been obtained from the talent for processing and using their personal data (including likeness, voice, and biometric data) in the specified territories. Mandatory for EU/EEA market usage.',
    `influencer_disclosure_required` BOOLEAN COMMENT 'Indicates whether the talent (influencer) is contractually and regulatorily required to disclose the paid/sponsored nature of content under FTC Endorsement Guidelines or ASA CAP Code. Applicable primarily when talent_role is influencer. Critical for regulatory compliance.',
    `is_perpetual` BOOLEAN COMMENT 'Indicates whether this usage right is granted in perpetuity with no expiration date. When True, rights_end_date should be null. Perpetual rights are typically associated with full buyout arrangements and carry higher upfront fees.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this usage right record was most recently modified, including status changes, renewals, fee updates, or clearance decisions. Supports change tracking and audit compliance.',
    `original_grant_date` DATE COMMENT 'The date on which the usage right was first granted, regardless of subsequent renewals or extensions. Provides the anchor point for tracking the full lifecycle of the rights relationship with the talent.',
    `payment_structure` STRING COMMENT 'The fee arrangement governing talent compensation for this usage right. buyout means a one-time payment granting unlimited use within agreed scope; residual means ongoing payments per use cycle per union scale; session_fee means payment for the recording session only with limited use; hybrid combines upfront buyout with residual obligations for certain use categories.. Valid values are `buyout|residual|session_fee|hybrid`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The contractually stipulated financial penalty payable to the talent or their union if the usage right is violated (e.g., unauthorized use beyond territory, media type, or expiry date). Expressed in fee_currency_code. Critical for financial risk management and compliance monitoring.',
    `platform_restrictions` STRING COMMENT 'Specific digital platforms or media outlets explicitly excluded from or restricted within this usage right (e.g., no TikTok, YouTube only, no competitor-owned media). Null if no platform-specific restrictions apply beyond the usage_type classification.',
    `renewal_count` STRING COMMENT 'The number of times this usage right has been renewed or extended since the original grant. Tracks the full renewal history lifecycle and informs cumulative cost analysis and talent relationship management.',
    `renewal_option_deadline` DATE COMMENT 'The date by which the agency must exercise the renewal option to extend the usage right period. Missing this deadline forfeits the renewal option and may require renegotiation at potentially higher rates. Critical for proactive rights management.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the contract includes an option to renew or extend the usage right period beyond the original rights_end_date. When True, renewal_option_deadline and renewal_fee_amount should be populated.',
    `residual_rate` DECIMAL(18,2) COMMENT 'The per-use or per-cycle residual payment rate applicable when payment_structure is residual or hybrid. Expressed as a monetary amount per broadcast cycle or as a percentage of the original session fee per union scale. Null for pure buyout arrangements.',
    `right_reference_number` STRING COMMENT 'Externally-known alphanumeric identifier for this usage right, used in correspondence with talent unions, legal teams, and talent agencies. Follows the agencys internal rights numbering convention (e.g., UR-2024-00123).. Valid values are `^UR-[A-Z0-9]{4,20}$`',
    `right_status` STRING COMMENT 'Current lifecycle status of the usage right. active indicates rights are cleared and in use; pending_clearance indicates awaiting legal or union approval; expired indicates the usage period has lapsed; suspended indicates rights are temporarily halted pending dispute resolution; renewed indicates an extension has been executed; terminated indicates rights have been revoked or cancelled.. Valid values are `active|expired|pending_clearance|suspended|renewed|terminated`',
    `rights_clearance_status` STRING COMMENT 'The legal clearance status of this usage right as determined by the agencys legal or business affairs team. cleared indicates all rights have been legally verified and approved for use; pending indicates clearance is in progress; rejected indicates rights could not be cleared; under_review indicates a dispute or ambiguity is being resolved.. Valid values are `cleared|pending|rejected|under_review`',
    `rights_end_date` DATE COMMENT 'The date on which the usage right expires and the talents likeness or creative output must be withdrawn from all specified media and territories. Null for perpetual buyout rights. Corresponds to the MASTER_AGREEMENT EFFECTIVE_UNTIL category. Critical for compliance monitoring to prevent unauthorized usage.',
    `rights_start_date` DATE COMMENT 'The date on which the usage right becomes effective and the talents likeness or creative output may legally be used in the specified media and territory. Corresponds to the MASTER_AGREEMENT EFFECTIVE_FROM category.',
    `talent_role` STRING COMMENT 'The professional role or category of the talent whose rights are being managed. Determines applicable union agreements, rate scales, and rights clearance requirements. [ENUM-REF-CANDIDATE: actor|model|photographer|director|influencer|voice_talent|musician|dancer|stunt_performer|extra|presenter — promote to reference product]',
    `territory_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code(s) or region designator indicating the geographic market(s) where the usage right is valid. Multiple territories may be pipe-delimited (e.g., USA|CAN|GBR). WW denotes worldwide rights. Critical for determining applicable union agreements and residual payment obligations.. Valid values are `^[A-Z]{2,3}(|[A-Z]{2,3})*$`',
    `union_agreement_code` STRING COMMENT 'The talent union or guild agreement governing this usage right and its associated payment obligations. Determines applicable scale rates, residual schedules, and usage restrictions. NON-UNION indicates talent not covered by a collective bargaining agreement.. Valid values are `SAG-AFTRA|ACTRA|BECTU|EQUITY|AFTRA|NON-UNION`',
    `union_contract_number` STRING COMMENT 'The specific union contract or signatory agreement number under which this usage right is administered. Required for SAG-AFTRA, ACTRA, and BECTU residual reporting and audit compliance. Null for non-union talent.',
    `usage_limitation_notes` STRING COMMENT 'Free-text field capturing any specific usage restrictions, conditions, or limitations not captured in structured fields (e.g., talent must be credited, no political advertising use, no alteration of likeness permitted, must not be used in conjunction with alcohol brands).',
    `usage_period_months` STRING COMMENT 'The total duration of the usage right period expressed in months, calculated from rights_start_date to rights_end_date. Used for residual cycle calculations, budget forecasting, and rights expiry alerting.',
    `usage_subtype` STRING COMMENT 'Granular classification within the usage type, specifying the exact format or placement (e.g., pre-roll video, banner display, story ad, billboard static, magazine full-page). Provides precision for rights clearance and union residual calculations.',
    `usage_type` STRING COMMENT 'The media channel or format category for which the talents likeness or creative output may be used. Broadcast covers TV and streaming; digital covers online display and video; OOH (Out-of-Home) covers billboards and transit; social covers social media platforms; print covers magazines and newspapers; radio covers audio-only placements. [ENUM-REF-CANDIDATE: broadcast|digital|ooh|social|print|radio|cinema|podcast|dooh|ctv — promote to reference product]. Valid values are `broadcast|digital|ooh|social|print|radio`',
    CONSTRAINT pk_usage_right PRIMARY KEY(`usage_right_id`)
) COMMENT 'Rights and licensing records governing how talent (actors, models, photographers, directors, influencers) and their creative output may be used — including usage type (broadcast, digital, OOH, social, print), territory/market, exclusivity scope, usage period start/end, fee structure, buyout vs. residual payment terms, rights clearance status, and renewal/extension history. Tracks the full lifecycle from initial grant through renewals and expirations. Critical for compliance with talent union agreements (SAG-AFTRA, ACTRA, BECTU) and influencer contracts. Unauthorized usage triggers significant financial penalties.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`capacity_plan` (
    `capacity_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the capacity plan record. Primary key for the capacity_plan data product in the talent domain.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the specific team or squad within the department for which capacity is being planned (e.g., Brand Creative Team, Programmatic Buying Team). More granular than department.',
    `primary_capacity_org_unit_id` BIGINT COMMENT 'Identifier of the agency department or business unit for which this capacity plan is prepared (e.g., Creative, Media, Strategy, Account Management, Production). Links to the organizational hierarchy.',
    `worker_id` BIGINT COMMENT 'Identifier of the employee (typically a Resource Manager, Department Head, or Operations Lead) responsible for authoring, maintaining, and approving this capacity plan. Maps to Workday HCM worker record.',
    `plan_id` BIGINT COMMENT 'External reference identifier for the corresponding resource plan record in Workfront Resource Planning module. Enables bi-directional synchronization between the lakehouse silver layer and the operational system of record.',
    `approved_date` DATE COMMENT 'Calendar date on which the capacity plan was formally approved by the designated approver. Nullable until plan status transitions to approved.',
    `available_hours` DECIMAL(18,2) COMMENT 'Total available productive hours across all planned FTE-equivalent resources for the planning period, net of holidays, PTO, and non-billable overhead. Primary supply-side metric for capacity gap analysis.',
    `campaign_pipeline_ids` STRING COMMENT 'Comma-separated list of pipeline campaign or pitch identifiers whose forecasted resource demand is incorporated into this capacity plan. Links capacity planning to new business development activity.',
    `capacity_gap_hours` DECIMAL(18,2) COMMENT 'Net difference between available_hours and forecasted_demand_hours for the planning period. Negative values indicate a capacity shortfall requiring freelancer augmentation or scope negotiation; positive values indicate surplus bench capacity.',
    `confirmed_demand_hours` DECIMAL(18,2) COMMENT 'Hours of resource demand backed by signed SOWs, confirmed Insertion Orders (IOs), or approved campaign briefs. Subset of forecasted_demand_hours representing firm commitments, used for conservative capacity planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity plan record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which labor_cost_budget and related financial figures are denominated (e.g., USD, GBP, EUR). Supports multi-currency agency operations.. Valid values are `^[A-Z]{3}$`',
    `discipline` STRING COMMENT 'Functional discipline or craft specialty covered by this capacity plan (e.g., Art Direction, Copywriting, Media Planning, Data Analytics, Account Management, Production, UX Design). Aligns with Workday HCM job families. [ENUM-REF-CANDIDATE: art_direction|copywriting|media_planning|data_analytics|account_management|production|ux_design|strategy|public_relations|digital_marketing — promote to reference product]',
    `forecasted_demand_hours` DECIMAL(18,2) COMMENT 'Total estimated hours of resource demand for the planning period, derived from confirmed SOWs, active campaign schedules, and pipeline-weighted new business opportunities. Primary demand-side metric for capacity gap analysis.',
    `freelancer_hours_planned` DECIMAL(18,2) COMMENT 'Total hours planned to be sourced from freelancers and contractors (non-FTE resources) during the planning period. Informs freelancer budget allocation and vendor management.',
    `freelancer_pool_size` STRING COMMENT 'Number of freelance or contract resources planned to be available in the talent pool for this discipline/team during the planning period. Used for bench management and rapid campaign ramp-up planning.',
    `fte_headcount_contractor` STRING COMMENT 'Count of fixed-term contractors and agency-of-record staff included in this capacity plan. Distinct from permanent FTEs and freelancers for cost classification and P&L reporting purposes.',
    `fte_headcount_permanent` STRING COMMENT 'Count of permanent, full-time employees included in this capacity plan for the planning period. Excludes contractors and freelancers. Used for P&L headcount reporting and EBITDA margin analysis.',
    `is_new_business_pitch` BOOLEAN COMMENT 'Indicates whether this capacity plan was created specifically to support a new business pitch or RFP response, as opposed to ongoing campaign delivery. Enables separate tracking of pitch-related resource commitments.',
    `labor_cost_budget` DECIMAL(18,2) COMMENT 'Total planned labor cost (in base currency) for the team/discipline during the planning period, covering salaries, contractor fees, and freelancer rates. Key input to finance for margin planning and P&L forecasting.',
    `pipeline_demand_hours` DECIMAL(18,2) COMMENT 'Hours of resource demand attributable to pipeline opportunities (RFPs, pitches, and proposals in progress) weighted by probability of conversion. Supports new business pitch resourcing and bench management decisions.',
    `plan_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the capacity plan, used in cross-system references, SOW alignment, and finance reporting (e.g., CP-BRAND01-2025).. Valid values are `^CP-[A-Z0-9]{4,12}-[0-9]{4}$`',
    `plan_end_date` DATE COMMENT 'Last calendar date of the planning period covered by this capacity plan. Defines the effective end of the capacity window. Nullable for rolling/open-ended plans.',
    `plan_name` STRING COMMENT 'Human-readable name describing the capacity plan, typically referencing the team, discipline, campaign, or planning period (e.g., Q3 2025 Creative Studio Capacity Plan).',
    `plan_notes` STRING COMMENT 'Free-text field for resource managers to document planning assumptions, risk factors, scenario rationale, or escalation notes associated with this capacity plan version.',
    `plan_start_date` DATE COMMENT 'First calendar date of the planning period covered by this capacity plan. Defines the effective start of the capacity window for resource allocation and demand matching.',
    `plan_status` STRING COMMENT 'Current lifecycle state of the capacity plan, governing whether it is editable, under review, approved for use in resource allocation, or replaced by a newer version.. Valid values are `draft|submitted|approved|active|superseded|archived`',
    `plan_version` STRING COMMENT 'Monotonically incrementing version number of the capacity plan, enabling scenario comparison and audit of plan revisions over time. Version 1 is the initial baseline.',
    `planned_headcount_fte` DECIMAL(18,2) COMMENT 'Total planned headcount expressed in Full-Time Equivalent (FTE) units for the planning period, combining permanent employees, contractors, and freelancers normalized to a standard 40-hour work week. Core input to utilization target setting.',
    `planning_period_type` STRING COMMENT 'Granularity of the planning horizon covered by this capacity plan — weekly for sprint-level resource management, monthly for campaign ramp-ups, quarterly for QBR-aligned forecasting, or annual for strategic workforce planning.. Valid values are `weekly|monthly|quarterly|annual`',
    `revenue_forecast_amount` DECIMAL(18,2) COMMENT 'Projected revenue attributable to the team/discipline for the planning period, derived from confirmed SOW values and pipeline-weighted opportunities. Used by finance for revenue forecasting and EBITDA planning.',
    `scenario_type` STRING COMMENT 'Scenario modeling classification for this capacity plan version — best case (maximum pipeline win rate), expected (most likely outcome), worst case (minimum pipeline conversion), or base (approved baseline). Supports sensitivity analysis for finance margin planning.. Valid values are `best_case|expected|worst_case|base`',
    `sow_reference_ids` STRING COMMENT 'Comma-separated list of SOW identifiers whose confirmed resource demand is incorporated into this capacity plan. Provides traceability between capacity commitments and contractual obligations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this capacity plan record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used to detect stale plans and trigger re-approval workflows.',
    `utilization_target_pct` DECIMAL(18,2) COMMENT 'Target billable utilization rate (as a percentage of available hours) set by finance for this team/discipline during the planning period. Drives margin planning and FTE sizing decisions. Typically 65–85% for agency talent.',
    CONSTRAINT pk_capacity_plan PRIMARY KEY(`capacity_plan_id`)
) COMMENT 'Forward-looking workforce capacity plans by team, discipline, or department — including planned headcount, available FTE-equivalent hours, forecasted demand from pipeline campaigns and confirmed SOWs, capacity gap or surplus analysis, planning period (weekly/monthly/quarterly), plan version, and scenario modeling (best case, expected, worst case). Supports resource planning for new business pitches, campaign ramp-ups, bench management, and freelancer pool sizing. Key input to finance for revenue forecasting, margin planning, and utilization target setting.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'Unique system-generated identifier for each employee leave and absence request record in the Workday HCM Absence Management module. Serves as the primary key for this entity.',
    `worker_id` BIGINT COMMENT 'Reference to the manager or HR representative who reviewed and approved or rejected this leave request. Supports approval workflow tracking and accountability.',
    `initiative_id` BIGINT COMMENT 'Reference to the primary Workfront project most impacted by this leave request. Enables direct linkage between absence management and project resource allocation, supporting capacity planning and WIP (Work in Progress) management for advertising campaigns.',
    `primary_leave_worker_id` BIGINT COMMENT 'Reference to the employee (Full-Time Equivalent, freelancer, contractor, or production crew member) who submitted this leave request. Links to the talent/employee master record.',
    `actual_return_date` DATE COMMENT 'The actual date the employee returned to work, which may differ from the planned return_to_work_date due to early return, extension, or medical clearance requirements. Used for reconciling capacity plans and updating resource availability in Workfront.',
    `approval_notes` STRING COMMENT 'Free-text comments entered by the approver during the review process, documenting conditions, modifications, or reasons for approval or rejection. Sourced from Workday HCM Absence Management workflow comments.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the approver formally approved or rejected the leave request in Workday HCM. Null if the request is still pending or has been withdrawn.',
    `approved_duration_days` DECIMAL(18,2) COMMENT 'Total number of working days formally approved for the leave period. May differ from requested_duration_days if the approver modified the leave window or partial approval was granted.',
    `approved_end_date` DATE COMMENT 'The last calendar date of the leave period as formally approved. May differ from the requested end date if the approver modified the leave window.',
    `approved_start_date` DATE COMMENT 'The first calendar date of the leave period as formally approved by the manager or HR. May differ from the requested start date if the approver modified the leave window.',
    `backfill_required` BOOLEAN COMMENT 'Indicates whether a temporary replacement (freelancer, contractor, or internal reallocation) is required to cover the employees responsibilities during the leave period. Triggers talent acquisition or resource reallocation workflows.',
    `backfill_type` STRING COMMENT 'The type of resource used to cover the employees responsibilities during the leave period. Supports financial reconciliation in SAP S/4HANA and talent cost tracking for the P&L (Profit and Loss) of the talent domain.. Valid values are `internal|freelancer|contractor|agency_staff|none`',
    `cancellation_reason` STRING COMMENT 'The reason provided when a leave request is cancelled or withdrawn, either by the employee or by HR. Populated only when request_status is cancelled or withdrawn. Supports HR audit trails and leave management reporting.',
    `cost_center_code` STRING COMMENT 'The SAP S/4HANA CO cost center code associated with the employees organizational unit. Used for financial allocation of leave costs and payroll charges during the absence period.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this leave request record was first created in the source system (Workday HCM). Used for audit trail and data lineage tracking in the Silver Layer.',
    `department_name` STRING COMMENT 'The name of the organizational department to which the employee belongs at the time of the leave request, as recorded in Workday HCM. Used for HR reporting, capacity planning by department, and resource availability dashboards.',
    `employee_notes` STRING COMMENT 'Free-text comments entered by the employee when submitting the leave request, providing additional context or supporting information. May contain sensitive personal information; classified as confidential per GDPR Article 5 data minimisation principles.',
    `intermittent_leave` BOOLEAN COMMENT 'Indicates whether the leave is taken intermittently (non-consecutive days or partial days) rather than as a continuous block. Common for FMLA qualifying conditions. Affects capacity planning granularity and Workfront resource scheduling.',
    `is_fmla_qualifying` BOOLEAN COMMENT 'Indicates whether this leave request qualifies under the Family and Medical Leave Act (FMLA), entitling the employee to job-protected unpaid leave. Relevant for US-based employees. Drives compliance reporting and payroll processing in SAP S/4HANA.',
    `is_paid` BOOLEAN COMMENT 'Indicates whether the approved leave is paid (True) or unpaid (False). Drives payroll processing in Workday HCM Payroll and SAP S/4HANA FI/CO for accurate compensation calculations during the leave period.',
    `job_profile` STRING COMMENT 'The employees job profile or role title as defined in Workday HCM at the time of the leave request (e.g., Creative Director, Media Planner, Account Manager, FTE). Used to assess skill-based resource impact and inform backfill sourcing decisions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this leave request record was most recently updated in the source system (Workday HCM). Supports change detection and incremental data loading in the Databricks Silver Layer.',
    `leave_balance_after_days` DECIMAL(18,2) COMMENT 'The employees remaining leave balance in days for the applicable leave type after the approved leave is deducted. Sourced from Workday HCM Absence Management. Used for capacity planning and leave entitlement monitoring.',
    `leave_balance_before_days` DECIMAL(18,2) COMMENT 'The employees available leave balance in days for the applicable leave type at the time the request was submitted. Sourced from Workday HCM Absence Management leave accrual records. Supports leave entitlement validation and HR reporting.',
    `leave_reason` STRING COMMENT 'Free-text or coded reason provided by the employee for the leave request, as captured in Workday HCM. May contain sensitive health or personal information; classified as confidential. Used for HR reporting and compliance with FMLA and GDPR Article 9 sensitive data provisions.',
    `leave_subtype` STRING COMMENT 'Further classification within a leave type, such as maternity, paternity, or adoption under parental leave; or short-term versus long-term under sick leave. Sourced from Workday HCM Absence Management leave plan configuration.',
    `leave_type` STRING COMMENT 'Classification of the leave request by category as defined in Workday HCM Absence Management. Common types include annual (vacation), sick, parental, unpaid, FMLA (Family and Medical Leave Act), and bereavement. [ENUM-REF-CANDIDATE: annual|sick|parental|unpaid|fmla|bereavement|jury_duty|military|sabbatical|personal — promote to reference product]. Valid values are `annual|sick|parental|unpaid|fmla|bereavement`',
    `medical_certification_received` BOOLEAN COMMENT 'Indicates whether the required medical certification or documentation has been received and validated by HR. Null or False when medical_certification_required is False. Supports FMLA compliance tracking and leave approval gating.',
    `medical_certification_required` BOOLEAN COMMENT 'Indicates whether a medical certificate or healthcare provider documentation is required to support this leave request (e.g., for extended sick leave or FMLA qualifying events). Drives HR compliance workflows in Workday HCM.',
    `request_status` STRING COMMENT 'Current lifecycle state of the leave request within the Workday HCM approval workflow. Drives capacity planning and resource availability calculations in Workfront resource management.. Valid values are `draft|submitted|approved|rejected|cancelled|withdrawn`',
    `requested_duration_days` DECIMAL(18,2) COMMENT 'Total number of working days requested for the leave period, as calculated by Workday HCM based on the employees work schedule and calendar. Supports capacity planning and leave balance deduction calculations.',
    `requested_end_date` DATE COMMENT 'The last calendar date of the leave period as requested by the employee. Combined with requested_start_date to determine the total requested leave duration.',
    `requested_start_date` DATE COMMENT 'The first calendar date of the leave period as requested by the employee. Used for scheduling, capacity planning, and project allocation impact assessment in Workfront.',
    `resource_impact_assessment` STRING COMMENT 'Assessment of the operational impact this leave request has on active campaign projects and resource allocations in Workfront. Levels range from none (no active project assignments) to critical (key FTE on active campaign delivery). Informs backfill and freelancer sourcing decisions.. Valid values are `none|low|medium|high|critical`',
    `return_to_work_date` DATE COMMENT 'The confirmed or expected date on which the employee is scheduled to return to active work following the leave period. Critical for resource availability calculations in Workfront and capacity planning for campaign and production teams.',
    `source_system` STRING COMMENT 'Identifies the originating system from which this leave request record was sourced into the Databricks Silver Layer. Primarily Workday HCM Absence Management, but may include manual entries or API integrations for legacy data migration.. Valid values are `workday_hcm|manual|api_integration`',
    `submission_timestamp` TIMESTAMP COMMENT 'The date and time when the employee formally submitted the leave request in Workday HCM. Represents the principal business event timestamp for this transaction.',
    `workday_absence_request_reference` STRING COMMENT 'The externally-known unique identifier assigned by Workday HCM Absence Management to this leave request. Used for cross-system traceability and reconciliation with the source system of record.',
    `worker_type` STRING COMMENT 'Classification of the employees engagement type within the agency workforce as defined in Workday HCM. Determines applicable leave entitlements, payroll treatment, and regulatory compliance requirements (e.g., FMLA eligibility for FTEs). [ENUM-REF-CANDIDATE: fte|freelancer|contractor|influencer|actor|photographer|director|production_crew — promote to reference product]. Valid values are `fte|freelancer|contractor|influencer|production_crew`',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Employee leave and absence requests — including leave type (annual, sick, parental, unpaid, FMLA), requested dates, approved dates, leave status, approver, and impact on project allocations. Sourced from Workday HCM Absence Management. Feeds into capacity planning and resource availability calculations.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique surrogate identifier for each formal talent performance evaluation record in the Workday HCM Talent Management module.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Performance reviews assess talent effectiveness on specific brand accounts. Agencies evaluate brand-specific competencies, client relationship strength, and brand guideline adherence. Essential for ta',
    `worker_id` BIGINT COMMENT 'Reference to the talent record of the employee being evaluated in this performance review cycle.',
    `review_cycle_id` BIGINT COMMENT 'Reference to the performance review cycle definition (e.g., Annual FY2024, Mid-Year H1 2024, Probationary 90-Day) under which this evaluation was conducted.',
    `reviewer_worker_id` BIGINT COMMENT 'Reference to the talent record of the manager or designated reviewer who conducted and submitted this performance evaluation.',
    `calibrated_rating` STRING COMMENT 'The final performance rating assigned after the HR calibration session, which may differ from the reviewers initial overall_rating. This is the authoritative rating used for compensation and talent decisions.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `calibration_status` STRING COMMENT 'Status of the HR calibration process for this review, ensuring rating consistency and fairness across the agency workforce. Calibration is typically conducted by HR Business Partners before reviews are finalized.. Valid values are `not_started|in_calibration|calibrated|approved`',
    `client_service_competency_score` DECIMAL(18,2) COMMENT 'Numeric score for the client service and account management competency dimension, reflecting the employees effectiveness in managing client relationships, QBRs, and SOW delivery.',
    `collaboration_score` DECIMAL(18,2) COMMENT 'Numeric score for the collaboration and teamwork competency dimension, assessing cross-functional cooperation across campaign, media, creative, and analytics teams.',
    `competency_score_avg` DECIMAL(18,2) COMMENT 'Average numeric score across all evaluated competency dimensions (e.g., strategic thinking, client service, creative excellence, collaboration, leadership) for this review period.',
    `completion_date` DATE COMMENT 'The actual date on which the performance review was finalized and marked as completed in Workday HCM, after all required approvals and employee acknowledgement.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this performance review record was first created in Workday HCM, establishing the audit trail for the review lifecycle.',
    `creative_excellence_score` DECIMAL(18,2) COMMENT 'Numeric score for the creative excellence competency dimension, evaluating the quality, originality, and effectiveness of creative output produced during the review period.',
    `development_areas_summary` STRING COMMENT 'Narrative text identifying the employees key development areas, skill gaps, and recommended improvement actions for the next review period, as documented by the reviewer.',
    `digital_analytics_score` DECIMAL(18,2) COMMENT 'Numeric score for the digital marketing and data analytics competency dimension, reflecting proficiency in performance optimization, DSP/SSP platforms, ROAS analysis, and data-driven decision-making.',
    `due_date` DATE COMMENT 'The deadline by which the performance review must be completed and submitted by the reviewer, as defined in the review cycle configuration in Workday HCM.',
    `employee_acknowledgement_date` DATE COMMENT 'The date on which the employee formally acknowledged receipt and review of their performance evaluation in Workday HCM. Null if not yet acknowledged.',
    `employee_self_assessment` STRING COMMENT 'Free-text self-evaluation submitted by the employee prior to the manager review, capturing their own perspective on goal attainment, contributions, and development needs.',
    `goal_attainment_score` DECIMAL(18,2) COMMENT 'Percentage or weighted score (0.00–100.00) reflecting the degree to which the employee achieved their defined KPI and business goals during the review period, as assessed in Workday HCM.',
    `goals_achieved_count` STRING COMMENT 'Number of formally defined performance goals that the employee fully achieved during the review period, as assessed by the reviewer in Workday HCM.',
    `goals_set_count` STRING COMMENT 'Total number of formal performance goals established for the employee at the start of or during the review period, as recorded in Workday HCM goal management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time at which this performance review record was most recently updated in Workday HCM, supporting audit trail requirements and Silver layer incremental load processing.',
    `leadership_competency_score` DECIMAL(18,2) COMMENT 'Numeric score for the leadership and people management competency dimension, assessing the employees ability to inspire, direct, and develop team members on campaigns and accounts.',
    `merit_increase_pct` DECIMAL(18,2) COMMENT 'Recommended merit salary increase expressed as a percentage of the employees current base compensation. Populated only when merit_increase_recommended is True and subject to HR calibration approval.',
    `merit_increase_recommended` BOOLEAN COMMENT 'Indicates whether the reviewing manager has recommended a merit-based salary increase for the employee as an outcome of this performance review, subject to compensation calibration.',
    `overall_rating` STRING COMMENT 'The holistic performance rating assigned to the employee for the review period, reflecting aggregate assessment across all competencies and goals. Sourced from Workday HCM rating scale. [ENUM-REF-CANDIDATE: exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory — promote to reference product if rating scale changes]. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `overall_rating_score` DECIMAL(18,2) COMMENT 'Numeric score corresponding to the overall performance rating on the agencys defined scale (e.g., 1.00–5.00), enabling quantitative ranking, trend analysis, and compensation calibration.',
    `pip_required` BOOLEAN COMMENT 'Indicates whether a formal Performance Improvement Plan (PIP) has been initiated as a result of this review, typically triggered by an unsatisfactory or needs_improvement overall rating.',
    `promotion_recommended` BOOLEAN COMMENT 'Indicates whether the reviewing manager has formally recommended the employee for promotion to a higher job level or title as an outcome of this performance review.',
    `promotion_target_level` STRING COMMENT 'The proposed job level or title to which the employee is recommended for promotion (e.g., Senior Account Manager, Associate Creative Director). Populated only when promotion_recommended is True.',
    `review_number` STRING COMMENT 'Externally-known business identifier for this performance review record, used in HR correspondence, audit trails, and Workday HCM reference. Format: PR-{YYYY}-{NNNNNN}.. Valid values are `^PR-[0-9]{4}-[0-9]{6}$`',
    `review_period_end_date` DATE COMMENT 'The last date of the performance evaluation period being assessed in this review (e.g., 2024-12-31 for an annual review covering calendar year 2024).',
    `review_period_start_date` DATE COMMENT 'The first date of the performance evaluation period being assessed in this review (e.g., 2024-01-01 for an annual review covering calendar year 2024).',
    `review_status` STRING COMMENT 'Current lifecycle state of the performance review record: draft (initiated but not submitted), in_progress (reviewer actively completing), pending_acknowledgement (awaiting employee sign-off), completed (fully finalized), or cancelled (voided).. Valid values are `draft|in_progress|pending_acknowledgement|completed|cancelled`',
    `review_template_version` STRING COMMENT 'Version identifier of the performance review template used in Workday HCM for this evaluation (e.g., v2024.1), enabling tracking of template changes and ensuring consistent year-over-year comparisons.',
    `review_type` STRING COMMENT 'Classification of the review cycle type: annual (full-year evaluation), mid_year (half-year check-in), probationary (new hire or role transition), project_based (post-campaign or project completion), or pip (Performance Improvement Plan review). [ENUM-REF-CANDIDATE: annual|mid_year|probationary|project_based|pip|ad_hoc — promote to reference product if additional types are added]. Valid values are `annual|mid_year|probationary|project_based|pip`',
    `reviewer_comments` STRING COMMENT 'Free-text overall commentary provided by the reviewing manager, capturing holistic assessment, context, and qualitative observations not captured in structured competency scores.',
    `strengths_summary` STRING COMMENT 'Narrative text summarizing the employees key strengths and notable achievements during the review period, as documented by the reviewer in Workday HCM.',
    `submitted_timestamp` TIMESTAMP COMMENT 'The date and time at which the reviewer formally submitted the completed performance review in Workday HCM, marking the transition from in_progress to pending_acknowledgement status.',
    `succession_candidate` BOOLEAN COMMENT 'Indicates whether the employee has been identified as a succession candidate for a critical role within the agency as an outcome of this performance review cycle.',
    `talent_segment` STRING COMMENT 'HR talent segmentation classification assigned to the employee as an outcome of this review and calibration, used for succession planning, retention strategy, and FTE investment decisions. [ENUM-REF-CANDIDATE: high_potential|key_talent|core_talent|developing|at_risk — promote to reference product]. Valid values are `high_potential|key_talent|core_talent|developing|at_risk`',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Formal talent performance evaluation records — including review cycle (annual, mid-year, probationary), reviewer, overall rating, competency scores, goal attainment, development areas, promotion recommendation, and review completion date. Sourced from Workday HCM Talent Management module.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique surrogate identifier for the organizational unit record within the agency. Primary key for the org_unit entity.',
    `parent_org_unit_id` BIGINT COMMENT 'Self-referencing identifier pointing to the immediate parent organizational unit in the agency hierarchy. Enables traversal of the full organizational tree for headcount, financial, and capacity roll-ups.',
    `worker_id` BIGINT COMMENT 'Identifier of the employee who is the designated manager or head of this organizational unit. References the talent/employee entity for reporting line and org chart construction.',
    `tertiary_org_manager_employee_worker_id` BIGINT COMMENT 'FK to talent.worker',
    `annual_budget_usd` DECIMAL(18,2) COMMENT 'The total annual operating budget allocated to this organizational unit in US dollars for the current fiscal year. Used for P&L management, EBITDA tracking, and QBR financial reporting.',
    `approved_headcount` STRING COMMENT 'The total approved headcount (FTE plus contractors and freelancers) authorized for this organizational unit in the current fiscal period. Distinct from actual FTE count; used for budget and capacity gap analysis.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether this organizational unit is a billable entity whose time and resources can be charged directly to client accounts and Insertion Orders (IOs). Non-billable units include internal support functions.',
    `capacity_utilization_target_pct` DECIMAL(18,2) COMMENT 'The target resource utilization rate (as a percentage) for this organizational unit, representing the proportion of available FTE hours expected to be allocated to billable or productive work. Used in Workfront resource planning.',
    `cost_center_code` STRING COMMENT 'The SAP S/4HANA CO cost center code associated with this organizational unit. Used for financial P&L roll-ups, budget allocation, and EBITDA reporting by business unit.. Valid values are `^[A-Z0-9]{4,12}$`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary country in which this organizational unit operates. Used for regulatory compliance (GDPR, CCPA), regional P&L roll-ups, and multi-market reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this organizational unit record was first created in the system of record (Workday HCM). Supports audit trail, data lineage, and compliance reporting requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code representing the primary operating currency for this organizational units budget and financial reporting (e.g., USD, GBP, EUR). Supports multi-currency P&L consolidation.. Valid values are `^[A-Z]{3}$`',
    `data_privacy_region` STRING COMMENT 'The primary data privacy regulatory framework applicable to this organizational unit based on its operating jurisdiction (e.g., GDPR for EU-based units, CCPA for California-based units). Governs data handling and consent management practices.. Valid values are `GDPR|CCPA|PIPEDA|LGPD|PDPA|Other`',
    `discipline` STRING COMMENT 'The primary agency discipline or functional practice area this organizational unit belongs to (e.g., Creative, Media, Strategy, Analytics, PR, Production). Drives capacity planning and talent allocation. [ENUM-REF-CANDIDATE: Creative|Media|Strategy|Analytics|PR|Production|Digital|Account|Finance|Technology — promote to reference product]',
    `effective_end_date` DATE COMMENT 'The date on which this organizational unit was dissolved, merged, or deactivated. Null for currently active units. Supports historical org structure analysis and workforce transition tracking.',
    `effective_start_date` DATE COMMENT 'The date on which this organizational unit became operationally active within the agency. Used for historical headcount analysis, org change tracking, and compliance reporting.',
    `external_reporting_flag` BOOLEAN COMMENT 'Indicates whether this organizational units performance metrics and financials are included in external client-facing reporting, QBR presentations, or regulatory submissions to bodies such as the FTC or ASA.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which the current budget and headcount figures for this organizational unit apply (e.g., 2024). Aligns with the agencys SAP S/4HANA fiscal calendar.',
    `gl_account_code` STRING COMMENT 'The General Ledger account code in SAP S/4HANA FI linked to this organizational unit for financial reconciliation, budget management, and P&L reporting.',
    `head_count_fte` STRING COMMENT 'The current approved Full-Time Equivalent (FTE) headcount for this organizational unit as maintained in Workday HCM. Used for capacity planning, resource utilization, and workforce analytics.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this organizational unit within the agency hierarchy tree. Level 1 represents the top-level entity (e.g., the agency holding company or division); higher numbers represent deeper sub-units.',
    `hierarchy_path` STRING COMMENT 'Delimited string representing the full ancestry path of the organizational unit from root to current node (e.g., Agency > Creative > Studio > Motion). Supports hierarchical filtering and reporting without recursive queries.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent update to this organizational unit record in the system of record (Workday HCM). Used for change detection, incremental ETL processing, and audit compliance.',
    `office_location` STRING COMMENT 'The physical office or geographic location where this organizational unit is primarily based (e.g., New York – Hudson Yards, London – Soho, Singapore – Marina Bay). Supports regional headcount and capacity reporting.',
    `org_unit_description` STRING COMMENT 'Free-text narrative description of the organizational units mandate, scope of services, and primary business functions within the agency (e.g., Responsible for all programmatic media buying and DSP/SSP management for North American clients).',
    `profit_center_code` STRING COMMENT 'SAP S/4HANA CO profit center code assigned to this organizational unit. Enables revenue and cost attribution for P&L reporting at the business unit level, supporting QBR financial analysis.. Valid values are `^[A-Z0-9]{4,12}$`',
    `region` STRING COMMENT 'Broad geographic region classification for the organizational unit. Used for regional performance reporting, media planning alignment, and multi-market campaign resource allocation.. Valid values are `North America|EMEA|APAC|LATAM|Global`',
    `reorganization_date` DATE COMMENT 'The date of the most recent organizational restructuring event affecting this unit (e.g., merger with another department, split into sub-units, reclassification of discipline). Supports change management and audit trails.',
    `shared_services_flag` BOOLEAN COMMENT 'Indicates whether this organizational unit operates as a shared services center providing support across multiple client accounts or practice groups (e.g., centralized analytics, production services, finance operations).',
    `sow_ownership_flag` BOOLEAN COMMENT 'Indicates whether this organizational unit is designated as the primary owner and delivery accountable party for client Statements of Work (SOWs). Used in account management and contract attribution.',
    `time_zone` STRING COMMENT 'The IANA time zone identifier for the primary operating time zone of this organizational unit (e.g., America/New_York, Europe/London). Used for scheduling, resource planning, and cross-market campaign coordination.',
    `unit_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the organizational unit across agency systems. Used in financial reporting, headcount roll-ups, and resource planning integrations (e.g., Workfront, SAP S/4HANA CO).. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `unit_name` STRING COMMENT 'Full human-readable name of the organizational unit as defined in Workday HCM (e.g., Creative Studio – North America, Programmatic Media Buying, Analytics & Audience Insights).',
    `unit_status` STRING COMMENT 'Current lifecycle status of the organizational unit. active indicates the unit is operational; dissolved indicates it has been disbanded; restructuring indicates it is undergoing reorganization.. Valid values are `active|inactive|pending|dissolved|restructuring`',
    `unit_type` STRING COMMENT 'Classifies the organizational unit into its structural category within the agency hierarchy. [ENUM-REF-CANDIDATE: department|practice_group|discipline|cost_center|office|team|division — promote to reference product]',
    `workday_org_unit_reference` STRING COMMENT 'The native identifier assigned to this organizational unit within Workday HCM organizational management module. Used for system-of-record cross-referencing and integration.',
    `workfront_group_reference` STRING COMMENT 'The corresponding group or team identifier in Workfront project management and resource planning. Used to synchronize capacity planning, resource allocation, and WIP tracking between Workday HCM and Workfront.',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational hierarchy units within the agency — including practice groups, departments, disciplines (Creative, Media, Strategy, Analytics, PR, Production), cost centers, office locations, and reporting lines. Provides the structural context for headcount, capacity, and financial roll-ups. Sourced from Workday HCM organizational management.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`guild_membership` (
    `guild_membership_id` BIGINT COMMENT 'Unique identifier for the guild membership record. Primary key.',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent (worker) who holds this guild membership. Links to the talent_profile or worker entity.',
    `renewed_guild_membership_id` BIGINT COMMENT 'Self-referencing FK on guild_membership (renewed_guild_membership_id)',
    `annual_dues_amount` DECIMAL(18,2) COMMENT 'Annual membership dues amount required for this membership tier.',
    `availability_restriction` STRING COMMENT 'Free-text description of any availability restrictions imposed by union rules (e.g., mandatory rest periods, maximum consecutive work days, blackout dates).',
    `booking_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the talent is currently eligible for booking based on their guild membership status and compliance (True/False). Critical for production compliance.',
    `compliance_notes` STRING COMMENT 'Free-text notes regarding compliance requirements, special conditions, or exceptions related to this guild membership.',
    `contract_agreement_code` STRING COMMENT 'Code or reference number of the collective bargaining agreement (CBA) or master contract that governs this membership (e.g., SAG-AFTRA Commercials Contract 2022).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this guild membership record was first created in the system.',
    `dues_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for membership dues (e.g., USD, CAD, GBP for UK unions).. Valid values are `USD|CAD|GBP|EUR`',
    `dues_status` STRING COMMENT 'Current status of membership dues payment obligations (e.g., current, overdue, delinquent, exempt for honorary members).. Valid values are `current|overdue|delinquent|exempt|waived`',
    `effective_date` DATE COMMENT 'Date from which the membership benefits and obligations become active and enforceable.',
    `exclusivity_category` STRING COMMENT 'Specific product or brand categories subject to exclusivity restrictions (e.g., automotive, beverage, financial services). Null if no category-specific restrictions apply.',
    `exclusivity_restriction` STRING COMMENT 'Level of exclusivity restrictions imposed by union rules (e.g., none, partial exclusivity for certain product categories, full exclusivity).. Valid values are `none|partial|full|category_specific`',
    `expiry_date` DATE COMMENT 'Date when the membership expires or requires renewal. Null for lifetime memberships.',
    `health_benefits_eligible` BOOLEAN COMMENT 'Indicates whether this membership tier qualifies the talent for union-sponsored health insurance benefits (True/False).',
    `join_date` DATE COMMENT 'Date when the talent officially joined or was admitted to the union or guild.',
    `jurisdiction_code` STRING COMMENT 'Three-letter country code representing the primary jurisdiction of the union or guild (e.g., USA for SAG-AFTRA, CAN for ACTRA, GBR for BECTU).. Valid values are `USA|CAN|GBR|AUS`',
    `last_dues_payment_date` DATE COMMENT 'Date of the most recent membership dues payment received by the union.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this guild membership record was last modified or updated.',
    `local_chapter_code` STRING COMMENT 'Code identifying the local chapter, branch, or regional office of the union to which this membership is affiliated.',
    `membership_number` STRING COMMENT 'The externally-issued membership number or identifier assigned by the union or guild (e.g., SAG-AFTRA membership card number).',
    `membership_status` STRING COMMENT 'Current lifecycle status of the guild membership (e.g., active, inactive, suspended due to non-payment, lapsed, pending approval).. Valid values are `active|inactive|suspended|lapsed|pending|withdrawn`',
    `membership_type` STRING COMMENT 'Classification of the membership level or tier within the union (e.g., full member, associate member, honorary member, lifetime member).. Valid values are `full|associate|honorary|lifetime|apprentice|journeyman`',
    `minimum_rate_schedule` STRING COMMENT 'Reference to the union minimum rate schedule or scale that applies to this membership (e.g., SAG-AFTRA Scale 2023, DGA Minimum Basic Agreement rates).',
    `next_dues_due_date` DATE COMMENT 'Date when the next membership dues payment is due.',
    `pension_eligible` BOOLEAN COMMENT 'Indicates whether this membership tier qualifies the talent for union pension plan contributions (True/False).',
    `residual_payment_eligible` BOOLEAN COMMENT 'Indicates whether this membership entitles the talent to residual payments for reuse of their work (True/False).',
    `signatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether the talent can only work with union signatory production companies (True) or can work with non-signatory companies (False).',
    `termination_date` DATE COMMENT 'Date when the membership was terminated, withdrawn, or cancelled. Null for active memberships.',
    `union_code` STRING COMMENT 'Code representing the union or guild affiliation (e.g., SAG-AFTRA for Screen Actors Guild - American Federation of Television and Radio Artists, DGA for Directors Guild of America). [ENUM-REF-CANDIDATE: SAG-AFTRA|ACTRA|BECTU|DGA|WGA|IATSE|AEA|AFM|OTHER — 9 candidates stripped; promote to reference product]',
    `union_name` STRING COMMENT 'Full legal name of the union or guild organization (e.g., Screen Actors Guild - American Federation of Television and Radio Artists).',
    `verification_date` DATE COMMENT 'Date when the membership credentials were last verified with the union or guild.',
    `verification_status` STRING COMMENT 'Status of internal verification of the membership credentials (e.g., verified with union, pending verification, unverified, expired credentials).. Valid values are `verified|pending|unverified|expired`',
    `verified_by` STRING COMMENT 'Name or identifier of the internal user or system that performed the membership verification.',
    `work_permit_required` BOOLEAN COMMENT 'Indicates whether a special work permit or clearance is required from the union for certain types of engagements (True/False).',
    CONSTRAINT pk_guild_membership PRIMARY KEY(`guild_membership_id`)
) COMMENT 'Union and guild membership records for talent — including SAG-AFTRA, ACTRA, BECTU, DGA, and other entertainment/advertising industry unions. Captures membership ID, union affiliation, membership status, dues payment status, signatory requirements, residual payment obligations, and exclusivity/availability restrictions imposed by union rules. Critical for production compliance and talent booking eligibility.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`talent_assignment` (
    `talent_assignment_id` BIGINT COMMENT 'Primary key for talent_assignment',
    `initiative_id` BIGINT COMMENT 'Foreign key to project.initiative identifying the project to which the worker is assigned.',
    `worker_id` BIGINT COMMENT 'Foreign key to talent.worker identifying the workforce member assigned to this initiative.',
    `actual_hours` DECIMAL(18,2) COMMENT 'The cumulative actual hours worked by this worker on this initiative, typically sourced from time tracking systems (Workfront, Monday.com, or timesheets). Updated continuously as time is logged.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the workers total capacity allocated to this initiative (e.g., 50.00 means half-time). Used for resource utilization tracking and capacity planning. Sum of all concurrent allocations for a worker should not exceed 100% in healthy resource plans.',
    `assignment_code` BIGINT COMMENT 'Unique surrogate identifier for each worker-to-initiative assignment record. Primary key.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this assignment. Planned = forecasted but not yet started; Active = worker currently engaged; On Hold = temporarily paused; Completed = assignment finished; Cancelled = assignment terminated before completion.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether this workers time on this initiative is billable to the client (true) or non-billable/internal (false). Drives revenue recognition and client invoicing. May differ from initiative.is_billable if specific roles are non-billable on an otherwise billable project.',
    `billing_rate` DECIMAL(18,2) COMMENT 'The hourly or daily rate at which this workers time is billed to the client for this specific initiative. May differ from the workers standard pay rate and can vary by project, client, or contract terms. Used for revenue calculation and client invoicing.',
    `cost_rate` DECIMAL(18,2) COMMENT 'The internal cost rate for this worker on this initiative, used for project profitability analysis and margin calculation. Typically derived from the workers pay_rate plus burden (benefits, overhead allocation). May be assignment-specific if special compensation applies.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this assignment record was created in the source system or data platform.',
    `end_date` DATE COMMENT 'The planned or actual date when the workers assignment to this initiative ends. May be null for ongoing assignments. Used for resource forecasting and assignment lifecycle management.',
    `planned_hours` DECIMAL(18,2) COMMENT 'The total number of hours planned or budgeted for this worker on this initiative. Used for capacity planning, budget estimation, and variance analysis against actual hours.',
    `priority` STRING COMMENT 'Priority level of this assignment relative to the workers other concurrent assignments. Used for resource conflict resolution and workload balancing when a worker is over-allocated.',
    `role` STRING COMMENT 'The specific role or function the worker performs on this initiative (e.g., Creative Director, Account Manager, Designer, Media Planner). This is assignment-specific and may differ from the workers job title—a Senior Designer may serve as Lead Designer on one project and Contributing Designer on another.',
    `source_system_code` STRING COMMENT 'The unique assignment or resource allocation identifier from the originating project management system (Workfront, Monday.com). Used for data lineage and system reconciliation.',
    `start_date` DATE COMMENT 'The date when the workers assignment to this initiative begins. Used for resource planning, availability tracking, and billing period determination.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this assignment record was last modified in the source system or data platform.',
    CONSTRAINT pk_talent_assignment PRIMARY KEY(`talent_assignment_id`)
) COMMENT 'This association product represents the assignment of agency workforce members to project initiatives. It captures the operational reality of resource allocation, tracking which workers are assigned to which projects, in what capacity, for what duration, and at what rates. Each record links one worker to one initiative with attributes that exist only in the context of this specific assignment relationship—role, dates, hours, allocation percentage, and billing/cost rates.. Existence Justification: In advertising agency operations, workers are routinely assigned to multiple concurrent initiatives (an account director may oversee 5 campaigns simultaneously, a designer may contribute to 3 projects), and initiatives require multiple workers across creative, account, and production teams. The detection reasoning explicitly states that the assignment relationship tracks role, dates, hours, rates, and billability—all relationship-specific data and notes that the business calls this project assignment or resource assignment. This is a textbook operational M:N relationship where the assignment itself is a managed business entity.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`representation` (
    `representation_id` BIGINT COMMENT 'Unique surrogate identifier for the representation agreement record. Primary key for the association.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to the supplier (talent agency or management firm) providing representation',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to the talent profile being represented',
    `commission_rate` DECIMAL(18,2) COMMENT 'The commission percentage charged by the supplier agency for bookings made under this representation agreement, expressed as a decimal (e.g., 0.15 for 15%). Varies by supplier-talent combination based on negotiated terms.',
    `contract_reference` STRING COMMENT 'External reference number or identifier for the legal representation contract document stored in the contract management system or document repository.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the representation agreement record was created in the data platform.',
    `end_date` DATE COMMENT 'The termination or expiry date of the representation agreement. Null indicates an open-ended or currently active agreement. Used for historical tracking and commission cutoff.',
    `exclusivity_scope` STRING COMMENT 'Defines the exclusivity terms of the representation agreement. Values: exclusive (sole representation across all markets), non_exclusive (talent can have multiple agencies), category_exclusive (exclusive within specific industry verticals), territory_exclusive (exclusive within defined geographic territories).',
    `primary_contact_flag` BOOLEAN COMMENT 'Indicates whether this supplier is the primary or preferred agency contact for the talent when multiple non-exclusive representation agreements exist. Used to route initial booking inquiries and campaign briefs.',
    `representation_status` STRING COMMENT 'Current lifecycle state of the representation agreement. Values: active (currently in force), suspended (temporarily inactive), terminated (ended), pending (signed but not yet effective). Only active agreements are used for commission calculation and booking workflow.',
    `start_date` DATE COMMENT 'The effective start date of the representation agreement. Used to determine active representation periods for talent booking and commission calculation.',
    `territory_restrictions` STRING COMMENT 'Pipe-delimited list of ISO 3166-1 alpha-3 country codes or region identifiers defining the geographic scope of the representation agreement (e.g., USA|CAN|MEX for North America). Used to determine which agency to contact for bookings in specific markets.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when the representation agreement record was last modified in the data platform.',
    CONSTRAINT pk_representation PRIMARY KEY(`representation_id`)
) COMMENT 'This association product represents the contractual representation relationship between talent profiles and supplier agencies in the advertising ecosystem. It captures the commercial terms, territorial scope, and lifecycle of representation agreements. Each record links one talent_profile to one supplier (talent agency, management firm) with attributes that exist only in the context of this specific representation contract, including commission structures, exclusivity terms, territory restrictions, and representation periods.. Existence Justification: In the advertising industry, talent (actors, influencers, models, directors, creatives) are commonly represented by multiple agencies simultaneously for different geographic territories, media types, or under non-exclusive arrangements. Conversely, each talent agency or management firm (supplier) represents many talent profiles. The representation relationship is a contractual business entity with specific commercial terms (commission rates, exclusivity scope, territory restrictions) that vary by each talent-agency pairing and cannot be stored on either entity alone.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Primary key for payroll_run',
    `cost_center_id` BIGINT COMMENT 'Reference to the primary cost center to which payroll expenses from this run are allocated for management accounting.',
    `created_by_user_worker_id` BIGINT COMMENT 'Reference to the user who initiated or created this payroll run.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity (company, subsidiary, or branch) under which this payroll run is executed for tax and compliance purposes.',
    `modified_by_user_worker_id` BIGINT COMMENT 'Reference to the user who last modified this payroll run record.',
    `org_unit_id` BIGINT COMMENT 'Reference to the department or organizational unit for which this payroll run is executed, used for segmentation and reporting.',
    `original_payroll_run_id` BIGINT COMMENT 'Reference to the original payroll run that this run reverses or corrects, populated only when is_reversal is true.',
    `payroll_calendar_id` BIGINT COMMENT 'Reference to the payroll calendar that governs the schedule and timing rules for this payroll run.',
    `worker_id` BIGINT COMMENT 'Reference to the user (typically HR manager or payroll administrator) who approved this payroll run for processing.',
    `correction_of_payroll_run_id` BIGINT COMMENT 'Self-referencing FK on payroll_run (correction_of_payroll_run_id)',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run was approved for processing.',
    `batch_number` STRING COMMENT 'External batch identifier assigned by the payroll processing system for tracking and reconciliation purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which payroll amounts are denominated (e.g., USD, GBP, EUR).',
    `employee_count` STRING COMMENT 'Number of employees, contractors, freelancers, and talent included in this payroll run.',
    `employer_tax_amount` DECIMAL(18,2) COMMENT 'Total employer-side tax obligations for this payroll run including employer portion of social security, Medicare, unemployment taxes, and other statutory contributions.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month or quarter) within the fiscal year to which this payroll run is attributed.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this payroll run is attributed for financial reporting and tax compliance purposes.',
    `frequency` STRING COMMENT 'The recurring schedule frequency for this payroll run: weekly, biweekly (every two weeks), semimonthly (twice per month), monthly, quarterly, or annual.',
    `general_ledger_posting_date` DATE COMMENT 'Date on which payroll expenses and liabilities from this run are posted to the general ledger for financial accounting.',
    `gross_pay_amount` DECIMAL(18,2) COMMENT 'Total gross compensation amount for all employees and talent included in this payroll run before any deductions.',
    `is_reversal` BOOLEAN COMMENT 'Boolean flag indicating whether this payroll run is a reversal or correction of a previous payroll run.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run record was last modified or updated.',
    `net_pay_amount` DECIMAL(18,2) COMMENT 'Total net compensation amount disbursed to employees and talent after all deductions, representing the actual payment amount.',
    `notes` STRING COMMENT 'Free-text notes or comments about this payroll run, including special circumstances, adjustments, or processing instructions.',
    `pay_period_end_date` DATE COMMENT 'The last date of the pay period covered by this payroll run.',
    `pay_period_start_date` DATE COMMENT 'The first date of the pay period covered by this payroll run.',
    `payment_date` DATE COMMENT 'The date on which payments from this payroll run are scheduled to be disbursed to employees, contractors, and talent.',
    `payment_method` STRING COMMENT 'Primary payment disbursement method used for this payroll run: direct deposit (ACH), physical check, wire transfer, payroll card, or cash.',
    `processed_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run completed processing and payments were initiated.',
    `processing_system` STRING COMMENT 'Name or identifier of the payroll processing system or platform used to execute this payroll run (e.g., Workday HCM, ADP, internal system).',
    `run_number` STRING COMMENT 'Business identifier for the payroll run, typically formatted as PR-YYYYMMDD or similar convention used for external reference and reporting.',
    `run_type` STRING COMMENT 'Classification of the payroll run indicating the purpose: regular scheduled payroll, off-cycle payment, bonus distribution, commission payout, adjustment run, or final settlement.',
    `payroll_run_status` STRING COMMENT 'Current lifecycle status of the payroll run indicating its workflow state from draft through completion or cancellation.',
    `submitted_to_bank_timestamp` TIMESTAMP COMMENT 'Date and time when payment instructions were transmitted to the banking institution for disbursement.',
    `tax_jurisdiction` STRING COMMENT 'Primary tax jurisdiction or geographic region governing tax withholding and reporting requirements for this payroll run (e.g., state, province, country).',
    `total_deductions_amount` DECIMAL(18,2) COMMENT 'Sum of all deductions applied in this payroll run including taxes, benefits, garnishments, and other withholdings.',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Master reference table for payroll_run. Referenced by payroll_run_id.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`review_cycle` (
    `review_cycle_id` BIGINT COMMENT 'Primary key for review_cycle',
    `created_by_user_worker_id` BIGINT COMMENT 'Identifier of the user who created this review cycle record.',
    `modified_by_user_worker_id` BIGINT COMMENT 'Identifier of the user who last modified this review cycle record.',
    `review_template_id` BIGINT COMMENT 'Identifier of the review form template used for this cycle.',
    `worker_id` BIGINT COMMENT 'Employee responsible for administering and managing this review cycle (typically HR Business Partner or Talent Manager).',
    `calibration_due_date` DATE COMMENT 'Deadline for completing calibration sessions to normalize ratings across teams.',
    `completed_reviews_count` STRING COMMENT 'Number of reviews that have been completed and finalized in this cycle.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this review cycle record was first created in the system.',
    `cycle_code` STRING COMMENT 'Externally-known unique code for the review cycle (e.g., RC-2024-Q1, ANN-2024).',
    `cycle_name` STRING COMMENT 'Human-readable name of the review cycle (e.g., Q1 2024 Performance Review, 2024 Annual Review).',
    `cycle_type` STRING COMMENT 'Classification of the review cycle based on frequency and purpose.',
    `review_cycle_description` STRING COMMENT 'Detailed description of the review cycle purpose, scope, and objectives.',
    `end_date` DATE COMMENT 'Date when the review cycle officially ends and is closed.',
    `feedback_delivery_due_date` DATE COMMENT 'Deadline by which managers must deliver final review feedback to employees.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter to which this review cycle belongs, if applicable.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this review cycle belongs (e.g., 2024).',
    `includes_compensation_review` BOOLEAN COMMENT 'Indicates whether this review cycle includes compensation adjustments (salary, bonus).',
    `includes_promotion_review` BOOLEAN COMMENT 'Indicates whether this review cycle includes promotion considerations.',
    `manager_review_due_date` DATE COMMENT 'Deadline by which managers must complete employee performance reviews.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this review cycle record was last modified.',
    `notes` STRING COMMENT 'Additional administrative notes or comments about the review cycle.',
    `notification_enabled` BOOLEAN COMMENT 'Indicates whether automated email/system notifications are enabled for this review cycle.',
    `rating_scale_type` STRING COMMENT 'Type of rating scale used for this cycle (e.g., 5-point scale, exceeds/meets/below, numeric 1-10).',
    `requires_calibration` BOOLEAN COMMENT 'Indicates whether calibration sessions are required to normalize ratings across the organization.',
    `requires_peer_feedback` BOOLEAN COMMENT 'Indicates whether peer feedback collection is required for this review cycle.',
    `requires_self_assessment` BOOLEAN COMMENT 'Indicates whether employees are required to complete a self-assessment as part of this cycle.',
    `review_period_end_date` DATE COMMENT 'End date of the performance period being evaluated (distinct from cycle end date).',
    `review_period_start_date` DATE COMMENT 'Start date of the performance period being evaluated (distinct from cycle start date).',
    `self_review_due_date` DATE COMMENT 'Deadline by which employees must complete their self-assessment.',
    `start_date` DATE COMMENT 'Date when the review cycle officially begins and becomes active.',
    `review_cycle_status` STRING COMMENT 'Current lifecycle status of the review cycle.',
    `target_population` STRING COMMENT 'Classification of which talent segments are included in this review cycle.',
    `total_participants_count` STRING COMMENT 'Total number of employees/talent included in this review cycle.',
    `workday_integration_enabled` BOOLEAN COMMENT 'Indicates whether this review cycle is integrated with Workday Human Capital Management (HCM) system.',
    `workfront_integration_enabled` BOOLEAN COMMENT 'Indicates whether this review cycle is integrated with Workfront resource management system.',
    CONSTRAINT pk_review_cycle PRIMARY KEY(`review_cycle_id`)
) COMMENT 'Master reference table for review_cycle. Referenced by review_cycle_id.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`job_profile` (
    `job_profile_id` BIGINT COMMENT 'Primary key for job_profile',
    `reports_to_profile_id` BIGINT COMMENT 'Job profile identifier of the direct supervisor role in the organizational hierarchy.',
    `parent_job_profile_id` BIGINT COMMENT 'Self-referencing FK on job_profile (parent_job_profile_id)',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this job profile for use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this job profile was approved for use in the organization.',
    `capacity_unit` STRING COMMENT 'Unit of measure used for capacity planning and resource allocation for this job profile.',
    `job_profile_category` STRING COMMENT 'Primary classification of the job profile indicating the type of talent resource.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this job profile record was first created in the system.',
    `department` STRING COMMENT 'Primary organizational department or division to which this job profile belongs (e.g., Creative, Strategy, Media, Production).',
    `job_profile_description` STRING COMMENT 'Comprehensive description of the job profile including key responsibilities, scope of work, and expected deliverables.',
    `education_requirement` STRING COMMENT 'Minimum educational qualification required for this job profile (e.g., Bachelors Degree in Marketing, Portfolio-based, No formal requirement).',
    `eeo_category` STRING COMMENT 'EEO-1 job category for regulatory reporting and diversity analytics.',
    `effective_end_date` DATE COMMENT 'Date when this job profile is no longer active. Null for open-ended profiles.',
    `effective_start_date` DATE COMMENT 'Date when this job profile becomes active and available for use in hiring and resource planning.',
    `flsa_classification` STRING COMMENT 'FLSA classification indicating whether the job profile is exempt or non-exempt from overtime regulations.',
    `job_family` STRING COMMENT 'Broader grouping of related job profiles for career pathing and compensation planning (e.g., Creative, Account Management, Strategy, Production, Media).',
    `job_level` STRING COMMENT 'Hierarchical level of the job profile within the organization indicating seniority and responsibility.',
    `minimum_experience_years` STRING COMMENT 'Minimum number of years of relevant professional experience required for this job profile.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this job profile record was last modified.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether resources in this job profile are eligible for overtime compensation.',
    `preferred_skills` STRING COMMENT 'Additional desirable skills that enhance candidate suitability but are not mandatory for the role.',
    `profile_code` STRING COMMENT 'Externally-known unique code for the job profile used in HR systems and resource planning tools.',
    `rate_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the standard rate.',
    `rate_unit` STRING COMMENT 'Unit of measure for the standard rate indicating how the rate is applied (e.g., per hour, per day, per project).',
    `remote_work_eligible` BOOLEAN COMMENT 'Indicates whether this job profile can be performed remotely or requires on-site presence.',
    `required_skills` STRING COMMENT 'Core competencies and technical skills required for this job profile, used for talent matching and capacity planning.',
    `standard_capacity_per_period` DECIMAL(18,2) COMMENT 'Standard available capacity per planning period (e.g., 40 hours per week, 160 hours per month) for resource planning.',
    `standard_rate` DECIMAL(18,2) COMMENT 'Standard billing or compensation rate for this job profile used in resource planning and project budgeting. Currency is USD unless otherwise specified in rate_currency.',
    `job_profile_status` STRING COMMENT 'Current lifecycle status of the job profile indicating whether it is available for use in hiring and resource planning.',
    `title` STRING COMMENT 'Official title of the job profile as used in job postings, contracts, and organizational charts.',
    `travel_requirement_percentage` STRING COMMENT 'Expected percentage of time requiring business travel for this job profile (0-100).',
    `union_affiliation` STRING COMMENT 'Labor union or guild affiliation applicable to this job profile (e.g., SAG-AFTRA, DGA, IATSE), if any.',
    `usage_rights_required` BOOLEAN COMMENT 'Indicates whether this job profile requires explicit usage rights management for work produced (e.g., actors, photographers, directors).',
    `version` STRING COMMENT 'Version number of this job profile record for tracking changes and maintaining history.',
    CONSTRAINT pk_job_profile PRIMARY KEY(`job_profile_id`)
) COMMENT 'Master reference table for job_profile. Referenced by job_profile_id.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`requisition` (
    `requisition_id` BIGINT COMMENT 'Primary key for requisition',
    `approved_by_worker_id` BIGINT COMMENT 'Reference to the executive or manager who provided final approval for this requisition.',
    `created_by_worker_id` BIGINT COMMENT 'Reference to the user who initially created the requisition record.',
    `location_id` BIGINT COMMENT 'Reference to the primary work location for this position.',
    `org_unit_id` BIGINT COMMENT 'Reference to the department or business unit that owns this requisition.',
    `recruiter_worker_id` BIGINT COMMENT 'Reference to the talent acquisition specialist assigned to manage this requisition.',
    `worker_id` BIGINT COMMENT 'Reference to the employee who is the hiring manager responsible for this requisition.',
    `replacement_requisition_id` BIGINT COMMENT 'Self-referencing FK on requisition (replacement_requisition_id)',
    `approval_status` STRING COMMENT 'Current state of the requisition in the approval workflow (HR, Finance, Executive).',
    `approved_date` DATE COMMENT 'Date when the requisition received final approval to proceed with recruitment.',
    `budget_approved` BOOLEAN COMMENT 'Indicates whether the financial budget for this requisition has been formally approved.',
    `closed_date` DATE COMMENT 'Date when the requisition was closed (filled, cancelled, or withdrawn).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the requisition record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the salary range (e.g., USD, GBP, EUR).',
    `education_level_required` STRING COMMENT 'Minimum educational qualification required for the position.',
    `headcount_type` STRING COMMENT 'Indicates whether this requisition is for a new role, replacing a departing employee, or expanding capacity.',
    `hourly_rate_maximum` DECIMAL(18,2) COMMENT 'Upper bound of the approved hourly rate for contractor or freelancer positions.',
    `hourly_rate_minimum` DECIMAL(18,2) COMMENT 'Lower bound of the approved hourly rate for contractor or freelancer positions.',
    `job_description` STRING COMMENT 'Detailed narrative describing the role, responsibilities, qualifications, and expectations for the position.',
    `job_family` STRING COMMENT 'Broad functional category that groups similar roles together for workforce planning and career pathing.',
    `job_level` STRING COMMENT 'Seniority or career level of the position within the organizational hierarchy.',
    `job_title` STRING COMMENT 'The official title of the position being recruited for (e.g., Senior Art Director, Copywriter, Production Manager).',
    `minimum_years_experience` STRING COMMENT 'Minimum number of years of relevant professional experience required for the role.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the requisition record was last updated.',
    `opened_date` DATE COMMENT 'Date when the requisition was officially opened and made available for candidate sourcing.',
    `position_count` STRING COMMENT 'Number of positions to be filled under this single requisition (typically 1, but may be higher for bulk hiring).',
    `posting_title` STRING COMMENT 'Public-facing job title used in external job postings and advertisements (may differ from internal job title).',
    `posting_visibility` STRING COMMENT 'Defines whether the requisition is advertised internally only, externally, or both.',
    `preferred_skills` STRING COMMENT 'Comma-separated or structured list of desirable but not mandatory skills or qualifications.',
    `priority_level` STRING COMMENT 'Business urgency assigned to this requisition for resource allocation and recruiter prioritization.',
    `remote_work_policy` STRING COMMENT 'Defines the remote work arrangement permitted for this position.',
    `required_skills` STRING COMMENT 'Comma-separated or structured list of mandatory skills, competencies, or certifications required for the role.',
    `requisition_number` STRING COMMENT 'Externally-known business identifier for the requisition, typically used in communications and approvals.',
    `requisition_status` STRING COMMENT 'Current lifecycle state of the requisition in the recruitment workflow.',
    `requisition_type` STRING COMMENT 'Classification of the employment relationship being recruited for.',
    `salary_range_maximum` DECIMAL(18,2) COMMENT 'Upper bound of the approved salary range for this position in the agencys base currency.',
    `salary_range_minimum` DECIMAL(18,2) COMMENT 'Lower bound of the approved salary range for this position in the agencys base currency.',
    `target_fill_date` DATE COMMENT 'Desired or planned date by which the position should be filled.',
    `time_to_fill_days` STRING COMMENT 'Number of calendar days from requisition opening to closure, used for recruiting performance metrics.',
    CONSTRAINT pk_requisition PRIMARY KEY(`requisition_id`)
) COMMENT 'Master reference table for requisition. Referenced by requisition_id.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`candidate` (
    `candidate_id` BIGINT COMMENT 'Primary key for candidate',
    `hiring_manager_worker_id` BIGINT COMMENT 'Identifier of the hiring manager or department head who is evaluating this candidate.',
    `requisition_id` BIGINT COMMENT 'Identifier of the job requisition or open position the candidate is being considered for.',
    `worker_id` BIGINT COMMENT 'Identifier of the internal recruiter or talent acquisition specialist assigned to this candidate.',
    `referred_by_candidate_id` BIGINT COMMENT 'Self-referencing FK on candidate (referred_by_candidate_id)',
    `application_date` DATE COMMENT 'The date when the candidate submitted their application or was first entered into the system.',
    `availability_date` DATE COMMENT 'The date when the candidate is available to start work if hired.',
    `candidate_type` STRING COMMENT 'Classification of the candidate based on the type of talent role they are being considered for (employee, freelancer, contractor, influencer, actor, photographer, director, production crew).',
    `certifications` STRING COMMENT 'List of professional certifications, licenses, or credentials held by the candidate.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the candidate record was first created in the system.',
    `current_employer` STRING COMMENT 'Name of the candidates current employer or most recent employer if currently unemployed.',
    `current_job_title` STRING COMMENT 'The candidates current or most recent job title or role.',
    `degree_field` STRING COMMENT 'The primary field of study or major for the candidates highest degree.',
    `desired_salary` DECIMAL(18,2) COMMENT 'The candidates desired or expected salary amount for the position.',
    `email` STRING COMMENT 'Primary email address for candidate communication and correspondence.',
    `first_name` STRING COMMENT 'The first name or given name of the candidate.',
    `highest_education_level` STRING COMMENT 'The highest level of education attained by the candidate (high school, associate, bachelor, master, doctorate, professional degree).',
    `interview_count` STRING COMMENT 'Total number of interviews conducted with this candidate.',
    `languages` STRING COMMENT 'List of languages the candidate speaks and their proficiency levels.',
    `last_interview_date` DATE COMMENT 'Date of the most recent interview conducted with the candidate.',
    `last_name` STRING COMMENT 'The last name or family name of the candidate.',
    `linkedin_profile` STRING COMMENT 'URL to the candidates LinkedIn professional profile.',
    `location_city` STRING COMMENT 'City where the candidate is currently located or resides.',
    `location_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the candidates current location (e.g., USA, GBR, CAN).',
    `location_state` STRING COMMENT 'State, province, or region where the candidate is currently located.',
    `notes` STRING COMMENT 'Free-form text notes and comments about the candidate from recruiters, interviewers, or hiring managers.',
    `offer_accepted_date` DATE COMMENT 'Date when the candidate accepted the job offer.',
    `offer_extended_date` DATE COMMENT 'Date when a job offer was extended to the candidate.',
    `phone` STRING COMMENT 'Primary contact phone number for the candidate.',
    `portfolio_url` STRING COMMENT 'URL to the candidates online portfolio showcasing their creative work, projects, or professional samples.',
    `referral_source` STRING COMMENT 'Name of the person or entity who referred the candidate, if applicable.',
    `rejection_reason` STRING COMMENT 'Reason or explanation for why the candidate was rejected or not selected for the position.',
    `resume_url` STRING COMMENT 'URL or file path to the candidates resume or curriculum vitae document.',
    `salary_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the desired salary (e.g., USD, EUR, GBP).',
    `screening_score` DECIMAL(18,2) COMMENT 'Numerical score assigned during initial screening or assessment of the candidates qualifications (0-100 scale).',
    `skills` STRING COMMENT 'Comma-separated list or text description of the candidates key skills, competencies, and areas of expertise relevant to advertising and marketing roles.',
    `source` STRING COMMENT 'The channel or source through which the candidate was acquired (job board, referral, agency, direct application, social media, career site).',
    `candidate_status` STRING COMMENT 'Current lifecycle status of the candidate in the recruitment process (new, screening, interviewing, offer extended, hired, rejected, withdrawn).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the candidate record was last modified or updated.',
    `willing_to_relocate` BOOLEAN COMMENT 'Indicates whether the candidate is willing to relocate for the position (True/False).',
    `work_authorization_status` STRING COMMENT 'The candidates current work authorization status in the target country (citizen, permanent resident, work visa, requires sponsorship, not authorized).',
    `years_of_experience` DECIMAL(18,2) COMMENT 'Total number of years of relevant professional experience the candidate possesses.',
    CONSTRAINT pk_candidate PRIMARY KEY(`candidate_id`)
) COMMENT 'Master reference table for candidate. Referenced by candidate_id.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`holiday_calendar` (
    `holiday_calendar_id` BIGINT COMMENT 'Primary key for holiday_calendar',
    `org_unit_id` BIGINT COMMENT 'Reference to the organization or business unit that owns and uses this holiday calendar. Applicable for organizational and production calendars; nullable for national/regional calendars.',
    `derived_from_holiday_calendar_id` BIGINT COMMENT 'Self-referencing FK on holiday_calendar (derived_from_holiday_calendar_id)',
    `applies_to_contractors` BOOLEAN COMMENT 'Indicates whether this holiday calendar applies to contractors and freelancers. True if contractors observe these holidays; false if they follow different schedules.',
    `applies_to_full_time_employees` BOOLEAN COMMENT 'Indicates whether this holiday calendar applies to full-time employees. True if FTE staff observe these holidays; false if excluded.',
    `applies_to_production_crew` BOOLEAN COMMENT 'Indicates whether this holiday calendar applies to production crews (directors, photographers, actors, production staff). True if production schedules must respect these holidays; false if production operates independently.',
    `approval_date` DATE COMMENT 'The date on which this holiday calendar was formally approved for use in resource planning, payroll, and time tracking systems.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this holiday calendar for use. Typically an HR manager, operations director, or authorized administrator.',
    `calendar_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the calendar for system integration and reference (e.g., US_FED_2024, UK_BANK, PROD_CAL).',
    `calendar_name` STRING COMMENT 'Business-friendly name of the holiday calendar (e.g., US Federal Holidays 2024, UK Bank Holidays, Agency Production Calendar).',
    `calendar_type` STRING COMMENT 'Classification of the holiday calendar indicating its scope and purpose: national (country-wide public holidays), regional (state/province holidays), organizational (company-specific holidays), production (shoot/production blackout dates), project (campaign-specific non-working days).',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the primary country jurisdiction for this holiday calendar (e.g., USA, GBR, CAN, FRA). Used for national and regional calendars.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this holiday calendar record was first created in the system. Used for audit trail and data lineage.',
    `holiday_calendar_description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and applicability of this holiday calendar, including any special rules or exceptions.',
    `effective_end_date` DATE COMMENT 'The last date on which this holiday calendar is applicable. Nullable for open-ended calendars that remain in effect until superseded.',
    `effective_start_date` DATE COMMENT 'The first date on which this holiday calendar becomes applicable for resource planning, payroll, and time tracking purposes.',
    `external_calendar_code` STRING COMMENT 'The unique identifier for this holiday calendar in the source system (e.g., Workday calendar ID, Workfront calendar GUID). Used for integration and synchronization with upstream systems.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this is the default holiday calendar for the organization or region. True if this calendar should be automatically applied to new employees or projects; false otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this holiday calendar record was last updated. Used for change tracking and synchronization with downstream systems.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or exceptions related to this holiday calendar (e.g., Includes floating holidays, Production blackout dates for Q4 campaign).',
    `observance_rule` STRING COMMENT 'Defines how holidays that fall on weekends are observed. Values: actual_date (holiday observed on the actual date regardless of day of week), nearest_weekday (shifted to nearest weekday), following_monday (shifted to following Monday if on weekend), preceding_friday (shifted to preceding Friday if on weekend).',
    `region_code` STRING COMMENT 'State, province, or regional subdivision code for calendars that apply to specific geographic regions within a country (e.g., CA for California, ON for Ontario, NSW for New South Wales). Nullable for national or organizational calendars.',
    `source_system` STRING COMMENT 'The system of record from which this holiday calendar was sourced or integrated (e.g., Workday HCM, Workfront, Manual Entry, Government API). Used for data lineage and reconciliation.',
    `holiday_calendar_status` STRING COMMENT 'Current lifecycle status of the holiday calendar. Active calendars are in use for resource planning and time tracking; draft calendars are under review; inactive calendars are temporarily disabled; archived calendars are retained for historical reference only.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for this holiday calendar (e.g., America/New_York, Europe/London, Asia/Tokyo). Used to determine exact holiday start/end times for global operations.',
    `total_holidays` STRING COMMENT 'The total number of distinct holiday dates defined in this calendar. Used for quick reference and capacity planning calculations.',
    `version_number` STRING COMMENT 'Sequential version number for this holiday calendar. Incremented each time the calendar is updated or revised. Supports change tracking and audit history.',
    `weekend_pattern` STRING COMMENT 'Defines the standard weekend days for this calendar. Values: sat_sun (Saturday and Sunday, common in Western countries), fri_sat (Friday and Saturday, common in Middle East), sun_only (Sunday only), none (no standard weekend, e.g., shift-based operations).',
    `working_days_per_year` STRING COMMENT 'The calculated number of working days in the calendar year after excluding weekends and holidays. Used for resource capacity planning, project scheduling, and workload forecasting.',
    `year` STRING COMMENT 'The calendar year (YYYY) for which this holiday calendar is defined. Many organizations maintain separate calendar records per year to accommodate year-specific holiday variations.',
    CONSTRAINT pk_holiday_calendar PRIMARY KEY(`holiday_calendar_id`)
) COMMENT 'Master reference table for holiday_calendar. Referenced by holiday_calendar_id.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`review_template` (
    `review_template_id` BIGINT COMMENT 'Primary key for review_template',
    `derived_from_review_template_id` BIGINT COMMENT 'Self-referencing FK on review_template (derived_from_review_template_id)',
    `approval_workflow_enabled` BOOLEAN COMMENT 'Indicates whether completed reviews using this template require approval from senior management or HR before being finalized and shared with the reviewee.',
    `approved_by_user_id` BIGINT COMMENT 'Identifier of the user who approved this review template for active use. Typically an HR leader or senior manager. Null if template is not yet approved.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this review template was approved for active use. Null if template is not yet approved.',
    `calibration_required` BOOLEAN COMMENT 'Indicates whether reviews using this template must go through a calibration process where managers meet to ensure consistent rating standards across the organization.',
    `compensation_impact` BOOLEAN COMMENT 'Indicates whether the results of reviews using this template directly influence compensation decisions such as merit increases, bonuses, or promotions.',
    `competency_framework_id` BIGINT COMMENT 'Reference to the competency framework that defines the skills and behaviors evaluated in this review template. Links to the competency model used for assessment.',
    `created_by_user_id` BIGINT COMMENT 'Identifier of the user who created this review template record. Links to the user or employee who authored the template.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this review template record was first created in the system.',
    `review_template_description` STRING COMMENT 'Detailed description of the review template purpose, scope, and intended use cases. Explains when and how this template should be applied.',
    `development_plan_required` BOOLEAN COMMENT 'Indicates whether the review process requires creation of a formal development plan or individual development plan (IDP) as an output.',
    `effective_from_date` DATE COMMENT 'Date when this review template becomes active and available for use in review cycles.',
    `effective_to_date` DATE COMMENT 'Date when this review template is no longer active. Null for templates with no planned end date.',
    `employment_type` STRING COMMENT 'The employment classification this template is intended for (full-time employee, contractor, freelancer, temporary worker, intern, or all types).',
    `goal_setting_enabled` BOOLEAN COMMENT 'Indicates whether this review template includes a goal-setting component for defining future objectives and development plans.',
    `is_default_template` BOOLEAN COMMENT 'Indicates whether this is the default review template for its target role category and employment type. Only one template per category/type combination should be marked as default.',
    `language_code` STRING COMMENT 'ISO 639-1 language code (with optional ISO 3166-1 country code) indicating the language of the review template content (e.g., en, en-US, es, fr-CA).',
    `last_modified_by_user_id` BIGINT COMMENT 'Identifier of the user who last modified this review template record. Links to the user or employee who made the most recent update.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this review template record was last modified in the system.',
    `notes` STRING COMMENT 'Additional notes, instructions, or guidance for administrators and managers using this review template. May include best practices, tips, or special considerations.',
    `peer_feedback_required` BOOLEAN COMMENT 'Indicates whether the review process requires input from peers or colleagues as part of a 360-degree feedback approach.',
    `rating_scale_max` STRING COMMENT 'Maximum value of the numeric rating scale (e.g., 5 for a 1-5 scale). Null if rating scale is not numeric.',
    `rating_scale_min` STRING COMMENT 'Minimum value of the numeric rating scale (e.g., 1 for a 1-5 scale). Null if rating scale is not numeric.',
    `rating_scale_type` STRING COMMENT 'The type of rating scale used in this template (numeric scale like 1-5, letter grades like A-F, descriptive labels like Exceeds/Meets/Below, or no formal rating).',
    `review_duration_minutes` STRING COMMENT 'Expected duration in minutes for completing a review using this template. Used for scheduling and capacity planning.',
    `review_frequency` STRING COMMENT 'The typical cadence at which this review template is used (annual, semi-annual, quarterly, monthly, project-based, or ad-hoc).',
    `self_assessment_required` BOOLEAN COMMENT 'Indicates whether the review process requires the reviewee to complete a self-assessment before the manager review.',
    `review_template_status` STRING COMMENT 'Current lifecycle status of the review template. Draft templates are under development, active templates are in use, inactive templates are temporarily disabled, archived templates are retained for historical purposes, deprecated templates are replaced by newer versions.',
    `target_role_category` STRING COMMENT 'The primary role category this review template is designed for. Allows templates to be tailored to specific talent segments (e.g., creative roles, production crews, account managers, strategists, media planners, technology staff, operations, leadership).',
    `template_code` STRING COMMENT 'Unique business identifier code for the review template used in external systems and integrations (e.g., PERF-ANNUAL, FRLNC-90D, DIR-EVAL).',
    `template_name` STRING COMMENT 'Human-readable name of the review template (e.g., Annual Performance Review, 90-Day Freelancer Check-In, Creative Director Evaluation).',
    `template_type` STRING COMMENT 'Classification of the review template by its primary purpose (performance evaluation, competency assessment, project retrospective, onboarding review, offboarding interview, probation review).',
    `upward_feedback_enabled` BOOLEAN COMMENT 'Indicates whether the review template includes upward feedback where direct reports can provide feedback on their manager.',
    `usage_count` STRING COMMENT 'Total number of times this review template has been used to conduct reviews. Tracks template adoption and popularity.',
    `version_number` STRING COMMENT 'Semantic version number of the review template (e.g., 1.0, 2.1, 3.0.1) to track template evolution and changes over time.',
    `workday_integration_enabled` BOOLEAN COMMENT 'Indicates whether this review template is integrated with Workday HCM for automated data synchronization, review initiation, and results storage.',
    `workfront_integration_enabled` BOOLEAN COMMENT 'Indicates whether this review template is integrated with Workfront resource management for project-based performance data and resource utilization metrics.',
    CONSTRAINT pk_review_template PRIMARY KEY(`review_template_id`)
) COMMENT 'Master reference table for review_template. Referenced by template_id.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`location` (
    `location_id` BIGINT COMMENT 'Primary key for location',
    `accessibility_features` STRING COMMENT 'Description of accessibility features available at the location (e.g., wheelchair access, elevators, accessible restrooms).',
    `address_line_1` STRING COMMENT 'Primary street address line for the location (street number and name).',
    `address_line_2` STRING COMMENT 'Secondary address line for the location (suite, floor, building name).',
    `capacity_headcount` STRING COMMENT 'Maximum number of people (employees, contractors, freelancers) that can be accommodated at the location.',
    `city` STRING COMMENT 'City or municipality where the location is situated.',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which location expenses are allocated.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the location is situated (e.g., USA, GBR, CAN).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the location record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for financial amounts associated with the location (e.g., USD, GBP, EUR).',
    `effective_from_date` DATE COMMENT 'Date from which the location record became active and operational.',
    `effective_to_date` DATE COMMENT 'Date until which the location record is active; null for currently active locations.',
    `email_address` STRING COMMENT 'Primary email address for the location (e.g., general inquiries, reception).',
    `fax_number` STRING COMMENT 'Fax number for the location, if applicable.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the location in decimal degrees.',
    `lease_end_date` DATE COMMENT 'Date when the lease or occupancy agreement for the location ends or is scheduled to end.',
    `lease_start_date` DATE COMMENT 'Date when the lease or occupancy agreement for the location began.',
    `lease_type` STRING COMMENT 'Ownership or lease arrangement for the location.',
    `location_code` STRING COMMENT 'Externally-known unique code for the location (e.g., office code, studio code, facility code).',
    `location_name` STRING COMMENT 'Human-readable name of the location (e.g., New York Creative Studio, London Office).',
    `location_status` STRING COMMENT 'Current operational status of the location in its lifecycle.',
    `location_type` STRING COMMENT 'Classification of the location based on its primary function within the agency.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the location in decimal degrees.',
    `manager_employee_id` BIGINT COMMENT 'Reference to the employee who manages or oversees this location.',
    `monthly_rent_amount` DECIMAL(18,2) COMMENT 'Monthly rental cost for the location in the local currency.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the location.',
    `parent_location_id` BIGINT COMMENT 'Reference to a parent location if this location is part of a hierarchical structure (e.g., a satellite office under a regional headquarters).',
    `parking_available` BOOLEAN COMMENT 'Indicates whether parking facilities are available at the location.',
    `parking_spaces_count` STRING COMMENT 'Number of parking spaces available at the location.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the location.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the location address.',
    `region` STRING COMMENT 'Business region or geographic market segment to which the location belongs (e.g., North America, EMEA, APAC).',
    `security_level` STRING COMMENT 'Classification of the security measures and access controls in place at the location.',
    `square_footage` DECIMAL(18,2) COMMENT 'Total floor area of the location in square feet.',
    `state_province` STRING COMMENT 'State, province, or region where the location is situated.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the location (e.g., America/New_York, Europe/London).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the location record was last modified in the system.',
    CONSTRAINT pk_location PRIMARY KEY(`location_id`)
) COMMENT 'Master reference table for location. Referenced by location_id.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`payroll_calendar` (
    `payroll_calendar_id` BIGINT COMMENT 'Primary key for payroll_calendar',
    `prior_payroll_calendar_id` BIGINT COMMENT 'Self-referencing FK on payroll_calendar (prior_payroll_calendar_id)',
    `applies_to_employee_types` STRING COMMENT 'Comma-separated list of employee types this calendar applies to (e.g., FTE,Contractor,Freelancer,Temporary).',
    `approved_by_user_id` BIGINT COMMENT 'Identifier of the user who approved this payroll calendar for operational use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll calendar was approved for use by authorized personnel.',
    `calendar_code` STRING COMMENT 'Externally-known unique code or identifier for the payroll calendar used in payroll systems and HR integrations.',
    `calendar_name` STRING COMMENT 'Human-readable name or label for the payroll calendar (e.g., US Biweekly 2024, UK Monthly 2024).',
    `calendar_type` STRING COMMENT 'Classification of the payroll calendar based on payment frequency (weekly, biweekly, semimonthly, monthly, quarterly, annual).',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the jurisdiction or country for which this payroll calendar is configured (e.g., USA, GBR, CAN).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll calendar record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for payroll transactions processed under this calendar (e.g., USD, GBP, EUR).',
    `default_pay_date_offset_days` STRING COMMENT 'Number of days after the pay period end date that payment is typically issued (e.g., 5 days for processing).',
    `payroll_calendar_description` STRING COMMENT 'Detailed description of the payroll calendar including its purpose, scope, and any special processing rules.',
    `effective_end_date` DATE COMMENT 'The date when this payroll calendar ceases to be active. Nullable for open-ended calendars.',
    `effective_start_date` DATE COMMENT 'The date when this payroll calendar becomes active and begins governing payroll processing.',
    `first_pay_period_start_date` DATE COMMENT 'The start date of the first pay period in this payroll calendar, used as the anchor for calculating subsequent periods.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this payroll calendar applies (e.g., 2024).',
    `holiday_calendar_id` BIGINT COMMENT 'Reference to the holiday calendar used to adjust pay dates when they fall on non-working days.',
    `is_default_calendar` BOOLEAN COMMENT 'Flag indicating whether this is the default payroll calendar for the organization or region.',
    `is_locked` BOOLEAN COMMENT 'Flag indicating whether this payroll calendar is locked from further modifications (typically after payroll processing has begun).',
    `last_pay_period_end_date` DATE COMMENT 'The end date of the final pay period in this payroll calendar.',
    `locked_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll calendar was locked from further changes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll calendar record was last modified or updated.',
    `notes` STRING COMMENT 'Additional notes or comments about the payroll calendar for internal reference and documentation.',
    `pay_frequency` STRING COMMENT 'Number of pay periods per year for this calendar (e.g., 52 for weekly, 26 for biweekly, 24 for semimonthly, 12 for monthly).',
    `region_code` STRING COMMENT 'Regional or state/province code within the country for localized payroll calendars (e.g., CA for California, ON for Ontario).',
    `payroll_calendar_status` STRING COMMENT 'Current lifecycle status of the payroll calendar indicating whether it is in use, archived, or under development.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the payroll calendar (e.g., America/New_York, Europe/London) used for scheduling and cutoff times.',
    `version_number` STRING COMMENT 'Version number of the payroll calendar to track changes and revisions over time.',
    `workday_hcm_calendar_id` STRING COMMENT 'External identifier for the corresponding payroll calendar in Workday HCM system for integration and synchronization.',
    `workfront_calendar_id` STRING COMMENT 'External identifier for the corresponding resource calendar in Workfront resource management system.',
    CONSTRAINT pk_payroll_calendar PRIMARY KEY(`payroll_calendar_id`)
) COMMENT 'Master reference table for payroll_calendar. Referenced by payroll_calendar_id.';

CREATE OR REPLACE TABLE `advertising_ecm`.`talent`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Primary key for legal_entity',
    `annual_revenue_amount` DECIMAL(18,2) COMMENT 'Total annual revenue for the most recent fiscal year, in the primary currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this legal entity record was first created in the system.',
    `credit_rating` STRING COMMENT 'External credit rating assigned by a rating agency (e.g., Moodys, S&P, Fitch).',
    `dissolution_date` DATE COMMENT 'The date on which the legal entity was officially dissolved or ceased operations, if applicable.',
    `doing_business_as_name` STRING COMMENT 'Trade name or fictitious business name under which the entity operates, if different from legal name.',
    `duns_number` STRING COMMENT 'Nine-digit Dun & Bradstreet identifier used for business credit and vendor management.',
    `employee_count` STRING COMMENT 'Total number of employees (FTE and contractors) associated with this legal entity.',
    `entity_status` STRING COMMENT 'Current operational and legal status of the entity in its lifecycle.',
    `fiscal_year_end_day` STRING COMMENT 'Day of month (1-31) when the entitys fiscal year ends.',
    `fiscal_year_end_month` STRING COMMENT 'Month number (1-12) when the entitys fiscal year ends for financial reporting purposes.',
    `incorporation_date` DATE COMMENT 'The date on which the legal entity was officially incorporated or registered.',
    `industry_classification_code` STRING COMMENT 'Standard industry classification code (e.g., NAICS, SIC) identifying the entitys primary business activity.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this legal entity record is currently active and in use for business operations.',
    `is_publicly_traded` BOOLEAN COMMENT 'Indicates whether the entitys shares are traded on a public stock exchange.',
    `is_tax_exempt` BOOLEAN COMMENT 'Indicates whether the entity has tax-exempt status (e.g., non-profit, charitable organization).',
    `jurisdiction_country_code` STRING COMMENT 'Three-letter ISO country code of the primary jurisdiction where the entity is incorporated.',
    `jurisdiction_state_province` STRING COMMENT 'State, province, or regional subdivision within the country where the entity is registered.',
    `legal_entity_type` STRING COMMENT 'The legal structure classification of the entity (e.g., corporation, LLC, partnership).',
    `legal_name` STRING COMMENT 'The official registered legal name of the entity as it appears on incorporation documents and legal contracts.',
    `lei_code` STRING COMMENT '20-character ISO 17442 Legal Entity Identifier for global entity identification in financial transactions.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this legal entity record was last updated.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of ownership held by the parent entity, if applicable (0.00 to 100.00).',
    `parent_entity_id` BIGINT COMMENT 'Reference to the parent legal entity if this entity is a subsidiary or branch.',
    `primary_contact_email` STRING COMMENT 'Main email address for official correspondence with the legal entity.',
    `primary_contact_phone` STRING COMMENT 'Main telephone number for contacting the legal entity.',
    `primary_currency_code` STRING COMMENT 'Three-letter ISO currency code for the entitys primary operating currency.',
    `registered_address_line_1` STRING COMMENT 'First line of the official registered address on file with the business registry.',
    `registered_address_line_2` STRING COMMENT 'Second line of the registered address (suite, floor, building name), if applicable.',
    `registered_city` STRING COMMENT 'City or municipality of the registered address.',
    `registered_country_code` STRING COMMENT 'Three-letter ISO country code of the registered address.',
    `registered_postal_code` STRING COMMENT 'Postal or ZIP code of the registered address.',
    `registration_number` STRING COMMENT 'Official registration or incorporation number assigned by the jurisdictions business registry.',
    `stock_exchange_code` STRING COMMENT 'Four-letter ISO Market Identifier Code (MIC) of the primary stock exchange where shares are listed.',
    `stock_exchange_symbol` STRING COMMENT 'Ticker symbol under which the entitys shares are traded, if publicly traded.',
    `tax_identification_number` STRING COMMENT 'Government-issued tax identifier for the legal entity (e.g., EIN in USA, VAT number in EU).',
    `ultimate_parent_entity_id` BIGINT COMMENT 'Reference to the top-level parent entity in the corporate hierarchy.',
    `website_url` STRING COMMENT 'Official website URL of the legal entity.',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Master reference table for legal_entity. Referenced by legal_entity_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `advertising_ecm`.`talent`.`worker` ADD CONSTRAINT `fk_talent_worker_manager_worker_id` FOREIGN KEY (`manager_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`position` ADD CONSTRAINT `fk_talent_position_acquisition_id` FOREIGN KEY (`acquisition_id`) REFERENCES `advertising_ecm`.`talent`.`acquisition`(`acquisition_id`);
ALTER TABLE `advertising_ecm`.`talent`.`position` ADD CONSTRAINT `fk_talent_position_capacity_plan_id` FOREIGN KEY (`capacity_plan_id`) REFERENCES `advertising_ecm`.`talent`.`capacity_plan`(`capacity_plan_id`);
ALTER TABLE `advertising_ecm`.`talent`.`position` ADD CONSTRAINT `fk_talent_position_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`position` ADD CONSTRAINT `fk_talent_position_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `advertising_ecm`.`talent`.`job_profile`(`job_profile_id`);
ALTER TABLE `advertising_ecm`.`talent`.`position` ADD CONSTRAINT `fk_talent_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `advertising_ecm`.`talent`.`org_unit`(`org_unit_id`);
ALTER TABLE `advertising_ecm`.`talent`.`position` ADD CONSTRAINT `fk_talent_position_position_supervisory_org_org_unit_id` FOREIGN KEY (`position_supervisory_org_org_unit_id`) REFERENCES `advertising_ecm`.`talent`.`org_unit`(`org_unit_id`);
ALTER TABLE `advertising_ecm`.`talent`.`position` ADD CONSTRAINT `fk_talent_position_reports_to_position_id` FOREIGN KEY (`reports_to_position_id`) REFERENCES `advertising_ecm`.`talent`.`position`(`position_id`);
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ADD CONSTRAINT `fk_talent_talent_profile_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ADD CONSTRAINT `fk_talent_resource_allocation_talent_engagement_id` FOREIGN KEY (`talent_engagement_id`) REFERENCES `advertising_ecm`.`talent`.`talent_engagement`(`talent_engagement_id`);
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ADD CONSTRAINT `fk_talent_resource_allocation_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ADD CONSTRAINT `fk_talent_timesheet_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ADD CONSTRAINT `fk_talent_timesheet_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `advertising_ecm`.`talent`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ADD CONSTRAINT `fk_talent_timesheet_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `advertising_ecm`.`talent`.`org_unit`(`org_unit_id`);
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ADD CONSTRAINT `fk_talent_timesheet_original_timesheet_id` FOREIGN KEY (`original_timesheet_id`) REFERENCES `advertising_ecm`.`talent`.`timesheet`(`timesheet_id`);
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ADD CONSTRAINT `fk_talent_timesheet_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `advertising_ecm`.`talent`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ADD CONSTRAINT `fk_talent_timesheet_resource_allocation_id` FOREIGN KEY (`resource_allocation_id`) REFERENCES `advertising_ecm`.`talent`.`resource_allocation`(`resource_allocation_id`);
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ADD CONSTRAINT `fk_talent_timesheet_timesheet_worker_id` FOREIGN KEY (`timesheet_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ADD CONSTRAINT `fk_talent_payroll_record_original_payroll_record_id` FOREIGN KEY (`original_payroll_record_id`) REFERENCES `advertising_ecm`.`talent`.`payroll_record`(`payroll_record_id`);
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ADD CONSTRAINT `fk_talent_payroll_record_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `advertising_ecm`.`talent`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ADD CONSTRAINT `fk_talent_payroll_record_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ADD CONSTRAINT `fk_talent_acquisition_candidate_id` FOREIGN KEY (`candidate_id`) REFERENCES `advertising_ecm`.`talent`.`candidate`(`candidate_id`);
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ADD CONSTRAINT `fk_talent_acquisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `advertising_ecm`.`talent`.`org_unit`(`org_unit_id`);
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ADD CONSTRAINT `fk_talent_acquisition_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `advertising_ecm`.`talent`.`requisition`(`requisition_id`);
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ADD CONSTRAINT `fk_talent_acquisition_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ADD CONSTRAINT `fk_talent_usage_right_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ADD CONSTRAINT `fk_talent_capacity_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `advertising_ecm`.`talent`.`org_unit`(`org_unit_id`);
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ADD CONSTRAINT `fk_talent_capacity_plan_primary_capacity_org_unit_id` FOREIGN KEY (`primary_capacity_org_unit_id`) REFERENCES `advertising_ecm`.`talent`.`org_unit`(`org_unit_id`);
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ADD CONSTRAINT `fk_talent_capacity_plan_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ADD CONSTRAINT `fk_talent_leave_request_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ADD CONSTRAINT `fk_talent_leave_request_primary_leave_worker_id` FOREIGN KEY (`primary_leave_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ADD CONSTRAINT `fk_talent_performance_review_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ADD CONSTRAINT `fk_talent_performance_review_review_cycle_id` FOREIGN KEY (`review_cycle_id`) REFERENCES `advertising_ecm`.`talent`.`review_cycle`(`review_cycle_id`);
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ADD CONSTRAINT `fk_talent_performance_review_reviewer_worker_id` FOREIGN KEY (`reviewer_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ADD CONSTRAINT `fk_talent_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `advertising_ecm`.`talent`.`org_unit`(`org_unit_id`);
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ADD CONSTRAINT `fk_talent_org_unit_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ADD CONSTRAINT `fk_talent_org_unit_tertiary_org_manager_employee_worker_id` FOREIGN KEY (`tertiary_org_manager_employee_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ADD CONSTRAINT `fk_talent_guild_membership_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `advertising_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ADD CONSTRAINT `fk_talent_guild_membership_renewed_guild_membership_id` FOREIGN KEY (`renewed_guild_membership_id`) REFERENCES `advertising_ecm`.`talent`.`guild_membership`(`guild_membership_id`);
ALTER TABLE `advertising_ecm`.`talent`.`talent_assignment` ADD CONSTRAINT `fk_talent_talent_assignment_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`representation` ADD CONSTRAINT `fk_talent_representation_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `advertising_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `advertising_ecm`.`talent`.`payroll_run` ADD CONSTRAINT `fk_talent_payroll_run_created_by_user_worker_id` FOREIGN KEY (`created_by_user_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`payroll_run` ADD CONSTRAINT `fk_talent_payroll_run_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `advertising_ecm`.`talent`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `advertising_ecm`.`talent`.`payroll_run` ADD CONSTRAINT `fk_talent_payroll_run_modified_by_user_worker_id` FOREIGN KEY (`modified_by_user_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`payroll_run` ADD CONSTRAINT `fk_talent_payroll_run_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `advertising_ecm`.`talent`.`org_unit`(`org_unit_id`);
ALTER TABLE `advertising_ecm`.`talent`.`payroll_run` ADD CONSTRAINT `fk_talent_payroll_run_original_payroll_run_id` FOREIGN KEY (`original_payroll_run_id`) REFERENCES `advertising_ecm`.`talent`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `advertising_ecm`.`talent`.`payroll_run` ADD CONSTRAINT `fk_talent_payroll_run_payroll_calendar_id` FOREIGN KEY (`payroll_calendar_id`) REFERENCES `advertising_ecm`.`talent`.`payroll_calendar`(`payroll_calendar_id`);
ALTER TABLE `advertising_ecm`.`talent`.`payroll_run` ADD CONSTRAINT `fk_talent_payroll_run_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`payroll_run` ADD CONSTRAINT `fk_talent_payroll_run_correction_of_payroll_run_id` FOREIGN KEY (`correction_of_payroll_run_id`) REFERENCES `advertising_ecm`.`talent`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `advertising_ecm`.`talent`.`review_cycle` ADD CONSTRAINT `fk_talent_review_cycle_created_by_user_worker_id` FOREIGN KEY (`created_by_user_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`review_cycle` ADD CONSTRAINT `fk_talent_review_cycle_modified_by_user_worker_id` FOREIGN KEY (`modified_by_user_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`review_cycle` ADD CONSTRAINT `fk_talent_review_cycle_review_template_id` FOREIGN KEY (`review_template_id`) REFERENCES `advertising_ecm`.`talent`.`review_template`(`review_template_id`);
ALTER TABLE `advertising_ecm`.`talent`.`review_cycle` ADD CONSTRAINT `fk_talent_review_cycle_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`job_profile` ADD CONSTRAINT `fk_talent_job_profile_reports_to_profile_id` FOREIGN KEY (`reports_to_profile_id`) REFERENCES `advertising_ecm`.`talent`.`job_profile`(`job_profile_id`);
ALTER TABLE `advertising_ecm`.`talent`.`job_profile` ADD CONSTRAINT `fk_talent_job_profile_parent_job_profile_id` FOREIGN KEY (`parent_job_profile_id`) REFERENCES `advertising_ecm`.`talent`.`job_profile`(`job_profile_id`);
ALTER TABLE `advertising_ecm`.`talent`.`requisition` ADD CONSTRAINT `fk_talent_requisition_approved_by_worker_id` FOREIGN KEY (`approved_by_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`requisition` ADD CONSTRAINT `fk_talent_requisition_created_by_worker_id` FOREIGN KEY (`created_by_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`requisition` ADD CONSTRAINT `fk_talent_requisition_location_id` FOREIGN KEY (`location_id`) REFERENCES `advertising_ecm`.`talent`.`location`(`location_id`);
ALTER TABLE `advertising_ecm`.`talent`.`requisition` ADD CONSTRAINT `fk_talent_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `advertising_ecm`.`talent`.`org_unit`(`org_unit_id`);
ALTER TABLE `advertising_ecm`.`talent`.`requisition` ADD CONSTRAINT `fk_talent_requisition_recruiter_worker_id` FOREIGN KEY (`recruiter_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`requisition` ADD CONSTRAINT `fk_talent_requisition_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`requisition` ADD CONSTRAINT `fk_talent_requisition_replacement_requisition_id` FOREIGN KEY (`replacement_requisition_id`) REFERENCES `advertising_ecm`.`talent`.`requisition`(`requisition_id`);
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ADD CONSTRAINT `fk_talent_candidate_hiring_manager_worker_id` FOREIGN KEY (`hiring_manager_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ADD CONSTRAINT `fk_talent_candidate_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `advertising_ecm`.`talent`.`requisition`(`requisition_id`);
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ADD CONSTRAINT `fk_talent_candidate_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ADD CONSTRAINT `fk_talent_candidate_referred_by_candidate_id` FOREIGN KEY (`referred_by_candidate_id`) REFERENCES `advertising_ecm`.`talent`.`candidate`(`candidate_id`);
ALTER TABLE `advertising_ecm`.`talent`.`holiday_calendar` ADD CONSTRAINT `fk_talent_holiday_calendar_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `advertising_ecm`.`talent`.`org_unit`(`org_unit_id`);
ALTER TABLE `advertising_ecm`.`talent`.`holiday_calendar` ADD CONSTRAINT `fk_talent_holiday_calendar_derived_from_holiday_calendar_id` FOREIGN KEY (`derived_from_holiday_calendar_id`) REFERENCES `advertising_ecm`.`talent`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `advertising_ecm`.`talent`.`review_template` ADD CONSTRAINT `fk_talent_review_template_derived_from_review_template_id` FOREIGN KEY (`derived_from_review_template_id`) REFERENCES `advertising_ecm`.`talent`.`review_template`(`review_template_id`);
ALTER TABLE `advertising_ecm`.`talent`.`payroll_calendar` ADD CONSTRAINT `fk_talent_payroll_calendar_prior_payroll_calendar_id` FOREIGN KEY (`prior_payroll_calendar_id`) REFERENCES `advertising_ecm`.`talent`.`payroll_calendar`(`payroll_calendar_id`);

-- ========= TAGS =========
ALTER SCHEMA `advertising_ecm`.`talent` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `advertising_ecm`.`talent` SET TAGS ('dbx_domain' = 'talent');
ALTER TABLE `advertising_ecm`.`talent`.`worker` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`talent`.`worker` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `manager_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Worker ID');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'FTE|freelancer|contractor|intern|agency_temp');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Percentage');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `gender_identity` SET TAGS ('dbx_business_glossary_term' = 'Gender Identity');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `gender_identity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `gender_identity` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `insurance_certificate_ref` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Reference');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_business_glossary_term' = 'Legal First Name');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Last Name');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `national_id_reference` SET TAGS ('dbx_business_glossary_term' = 'National Identification Reference');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `national_id_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `national_id_reference` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Nationality');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `nationality` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `nationality` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `office_location_code` SET TAGS ('dbx_business_glossary_term' = 'Office Location Code');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Completion Date');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|bi_weekly|semi_monthly|monthly|project_based');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `pay_rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate Currency');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `pay_rate_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `personal_email` SET TAGS ('dbx_business_glossary_term' = 'Personal Email Address');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `personal_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `personal_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `personal_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `standard_weekly_hours` SET TAGS ('dbx_business_glossary_term' = 'Standard Weekly Hours');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `talent_specialization` SET TAGS ('dbx_business_glossary_term' = 'Talent Specialization');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `tax_classification` SET TAGS ('dbx_business_glossary_term' = 'Tax Classification');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `tax_classification` SET TAGS ('dbx_value_regex' = 'W2|1099|corp_to_corp|international_contractor|statutory_employee');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `tax_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `tax_jurisdiction_country` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Country');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `tax_jurisdiction_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `tax_jurisdiction_country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `tax_jurisdiction_state` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction State or Province');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `tax_jurisdiction_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'voluntary_resignation|involuntary_termination|contract_end|retirement|redundancy|mutual_agreement');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `visa_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Visa Expiry Date');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `visa_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `visa_type` SET TAGS ('dbx_business_glossary_term' = 'Visa Type');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `visa_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `work_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Work Arrangement');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `work_arrangement` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Status');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_value_regex' = 'authorized|visa_required|pending_verification|expired|not_applicable');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `work_email` SET TAGS ('dbx_business_glossary_term' = 'Work Email Address');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `work_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `work_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `work_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `work_permit_ref` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Document Reference');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `work_permit_ref` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `workday_worker_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday Worker ID');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `worker_status` SET TAGS ('dbx_business_glossary_term' = 'Worker Status');
ALTER TABLE `advertising_ecm`.`talent`.`worker` ALTER COLUMN `worker_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|terminated|suspended|pending_onboard');
ALTER TABLE `advertising_ecm`.`talent`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`talent`.`position` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `acquisition_id` SET TAGS ('dbx_business_glossary_term' = 'Job Requisition ID');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `capacity_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan ID');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Incumbent Worker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `position_supervisory_org_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Organization ID');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `reports_to_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Position ID');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `available_for_overlap` SET TAGS ('dbx_business_glossary_term' = 'Available For Overlap');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `budgeted_annual_salary` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Annual Salary');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `budgeted_annual_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Position Discipline');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Position Effective Date');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|fixed_term|casual');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Position End Date');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `fte_capacity` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Capacity');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable Position');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `is_budgeted` SET TAGS ('dbx_business_glossary_term' = 'Is Budgeted Position');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `is_critical_role` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Role');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `is_filled` SET TAGS ('dbx_business_glossary_term' = 'Is Filled Position');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `max_incumbents` SET TAGS ('dbx_business_glossary_term' = 'Maximum Incumbents');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^POS-[A-Z0-9]{4,12}$');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'open|filled|frozen|eliminated|proposed');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `seniority_level` SET TAGS ('dbx_business_glossary_term' = 'Seniority Level');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `standard_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Standard Hours Per Week');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `target_fill_date` SET TAGS ('dbx_business_glossary_term' = 'Target Fill Date');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `work_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Work Arrangement');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `work_arrangement` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `workday_position_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday Position ID');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `worker_type` SET TAGS ('dbx_business_glossary_term' = 'Worker Type (Full-Time Equivalent)');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `worker_type` SET TAGS ('dbx_value_regex' = 'fte|contractor|freelancer|intern|agency_temp');
ALTER TABLE `advertising_ecm`.`talent`.`position` ALTER COLUMN `workfront_role_reference` SET TAGS ('dbx_business_glossary_term' = 'Workfront Role ID');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile ID');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `audience_primary_age_range` SET TAGS ('dbx_business_glossary_term' = 'Audience Primary Age Range');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `audience_primary_age_range` SET TAGS ('dbx_value_regex' = '13-17|18-24|25-34|35-44|45-54|55+');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `audience_primary_gender` SET TAGS ('dbx_business_glossary_term' = 'Audience Primary Gender');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `audience_primary_gender` SET TAGS ('dbx_value_regex' = 'male|female|mixed');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `audience_primary_gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `audience_primary_gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'available|partially_available|unavailable|on_leave');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `award_count` SET TAGS ('dbx_business_glossary_term' = 'Industry Award Count');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `capacity_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Capacity Hours Per Week');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `certifications` SET TAGS ('dbx_business_glossary_term' = 'Professional Certifications');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `content_niche` SET TAGS ('dbx_business_glossary_term' = 'Content Niche / Vertical');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Created Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `day_rate_usd` SET TAGS ('dbx_business_glossary_term' = 'Day Rate (USD)');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `day_rate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `display_name` SET TAGS ('dbx_business_glossary_term' = 'Talent Display Name');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `display_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `display_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `engagement_rate` SET TAGS ('dbx_business_glossary_term' = 'Engagement Rate');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `exclusivity_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Expiry Date');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `exclusivity_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `exclusivity_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Restrictions');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `exclusivity_restrictions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `influencer_tier` SET TAGS ('dbx_business_glossary_term' = 'Influencer Tier Classification');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `influencer_tier` SET TAGS ('dbx_value_regex' = 'nano|micro|macro|mega');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `instagram_handle` SET TAGS ('dbx_business_glossary_term' = 'Instagram Handle');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `instagram_handle` SET TAGS ('dbx_value_regex' = '^@[A-Za-z0-9_.]{1,30}$');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `instagram_handle` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `language_capabilities` SET TAGS ('dbx_business_glossary_term' = 'Language Capabilities');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `media_channel_expertise` SET TAGS ('dbx_business_glossary_term' = 'Media Channel Expertise');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `notable_award_names` SET TAGS ('dbx_business_glossary_term' = 'Notable Award Names');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `notable_brand_credits` SET TAGS ('dbx_business_glossary_term' = 'Notable Brand Credits');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `past_brand_partnerships` SET TAGS ('dbx_business_glossary_term' = 'Past Brand Partnerships');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `portfolio_url` SET TAGS ('dbx_business_glossary_term' = 'Portfolio URL');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `portfolio_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `primary_discipline` SET TAGS ('dbx_business_glossary_term' = 'Primary Creative Discipline');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Status');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_hold|pending_review|archived');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `rate_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `seniority_level` SET TAGS ('dbx_business_glossary_term' = 'Seniority Level');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `software_proficiencies` SET TAGS ('dbx_business_glossary_term' = 'Software Proficiencies');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `specialization` SET TAGS ('dbx_business_glossary_term' = 'Talent Specialization');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `talent_type` SET TAGS ('dbx_business_glossary_term' = 'Talent Type');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `tiktok_handle` SET TAGS ('dbx_business_glossary_term' = 'TikTok Handle');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `tiktok_handle` SET TAGS ('dbx_value_regex' = '^@[A-Za-z0-9_.]{1,24}$');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `tiktok_handle` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `total_follower_count` SET TAGS ('dbx_business_glossary_term' = 'Total Follower Count');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `usage_rights_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Expiry Date');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `usage_rights_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `usage_rights_summary` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Summary');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `usage_rights_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `x_handle` SET TAGS ('dbx_business_glossary_term' = 'X (Twitter) Handle');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `x_handle` SET TAGS ('dbx_value_regex' = '^@[A-Za-z0-9_]{1,15}$');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `x_handle` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Experience');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `youtube_channel_url` SET TAGS ('dbx_business_glossary_term' = 'YouTube Channel URL');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `youtube_channel_url` SET TAGS ('dbx_value_regex' = '^https?://(www.)?youtube.com/.+');
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ALTER COLUMN `youtube_channel_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `talent_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement ID');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Engagement End Date');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `agreed_rate` SET TAGS ('dbx_business_glossary_term' = 'Agreed Engagement Rate');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `agreed_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `allocated_hours` SET TAGS ('dbx_business_glossary_term' = 'Allocated Hours');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `billing_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Billing Arrangement');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `billing_arrangement` SET TAGS ('dbx_value_regex' = 'hourly|day_rate|project_fee|retainer|usage_based');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Engagement Department');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `engagement_type` SET TAGS ('dbx_business_glossary_term' = 'Engagement Type');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `engagement_type` SET TAGS ('dbx_value_regex' = 'fte_employment|freelance_sow|contractor_agreement|influencer_partnership|production_crew_booking');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `exclusivity_category` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Category');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `fte_equivalent` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `gdpr_consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'GDPR Consent Obtained Flag');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `io_number` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) Number');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Agency Markup Percentage');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `on_site_required` SET TAGS ('dbx_business_glossary_term' = 'On-Site Required Flag');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_15|net_30|net_45|net_60|upon_completion|milestone_based');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Engagement Reference Number');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `role_title` SET TAGS ('dbx_business_glossary_term' = 'Engagement Role Title');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'workday_hcm|workfront|salesforce_crm|sap_s4hana|mediaocean_prisma|manual');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `sow_number` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Number');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `talent_engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Status');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `talent_engagement_status` SET TAGS ('dbx_value_regex' = 'draft|active|on_hold|completed|terminated');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `tax_classification` SET TAGS ('dbx_business_glossary_term' = 'Tax Classification');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `tax_classification` SET TAGS ('dbx_value_regex' = 'w2_employee|1099_contractor|corp_to_corp|vat_registered|exempt');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `total_engagement_value` SET TAGS ('dbx_business_glossary_term' = 'Total Engagement Value');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `total_engagement_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `usage_rights_included` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Included Flag');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `usage_rights_scope` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Scope');
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ALTER COLUMN `work_location` SET TAGS ('dbx_business_glossary_term' = 'Work Location');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` SET TAGS ('dbx_subdomain' = 'resource_operations');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `talent_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Rate Card ID');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `cancellation_fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Fee Percentage');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `cancellation_fee_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `channel_specialization` SET TAGS ('dbx_business_glossary_term' = 'Channel Specialization');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `day_rate` SET TAGS ('dbx_business_glossary_term' = 'Day Rate');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `day_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `half_day_rate` SET TAGS ('dbx_business_glossary_term' = 'Half Day Rate');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `half_day_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `market_region` SET TAGS ('dbx_business_glossary_term' = 'Market Region');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `market_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `minimum_booking_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Booking Hours');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Notes');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Multiplier');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `rate_card_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Code');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `rate_card_code` SET TAGS ('dbx_value_regex' = '^RC-[A-Z0-9]{4,12}$');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `rate_card_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Name');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `rate_card_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Status');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `rate_card_status` SET TAGS ('dbx_value_regex' = 'draft|active|superseded|expired|archived');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `rate_tier_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Tier Type');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `rate_tier_type` SET TAGS ('dbx_value_regex' = 'market_standard|client_specific|preferred_vendor|negotiated|blended');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Talent Role Type');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `seniority_tier` SET TAGS ('dbx_business_glossary_term' = 'Seniority Tier');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `seniority_tier` SET TAGS ('dbx_value_regex' = 'junior|mid|senior|lead|director|executive');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'workday_hcm|mediaocean_prisma|workfront|manual|salesforce_crm');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `talent_category` SET TAGS ('dbx_business_glossary_term' = 'Talent Category');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `talent_category` SET TAGS ('dbx_value_regex' = 'fte|freelancer|contractor|influencer|actor|production_crew');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `travel_day_rate` SET TAGS ('dbx_business_glossary_term' = 'Travel Day Rate');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `travel_day_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `usage_rights_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Duration (Days)');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `usage_rights_included` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Included Flag');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `usage_rights_scope` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Scope');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `usage_rights_scope` SET TAGS ('dbx_value_regex' = 'none|digital_only|broadcast_only|print_only|all_media|custom');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Version');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `weekly_rate` SET TAGS ('dbx_business_glossary_term' = 'Weekly Rate');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `weekly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `workday_compensation_grade` SET TAGS ('dbx_business_glossary_term' = 'Workday Compensation Grade');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `workday_compensation_grade` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `workday_compensation_grade` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ALTER COLUMN `workfront_role_reference` SET TAGS ('dbx_business_glossary_term' = 'Workfront Role ID');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` SET TAGS ('dbx_subdomain' = 'resource_operations');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `resource_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Allocation ID');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `project_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Workfront Assignment ID');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `talent_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `allocated_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Allocated Hours Per Week');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Resource Allocation Number');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_value_regex' = '^RA-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Resource Allocation Status');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'tentative|planned|confirmed|released|cancelled');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'project_work|production_shoot|client_account|new_business|internal');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `booking_type` SET TAGS ('dbx_business_glossary_term' = 'Booking Type');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `booking_type` SET TAGS ('dbx_value_regex' = 'hard_book|soft_book|option');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `call_time` SET TAGS ('dbx_business_glossary_term' = 'Production Call Time');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `crew_role_designation` SET TAGS ('dbx_business_glossary_term' = 'Crew Role Designation');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority Level');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `shoot_location` SET TAGS ('dbx_business_glossary_term' = 'Shoot Location');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `total_allocated_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Allocated Hours');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `utilization_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Utilization Target Percentage');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `worker_type` SET TAGS ('dbx_business_glossary_term' = 'Worker Type');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `worker_type` SET TAGS ('dbx_value_regex' = 'fte|freelancer|contractor|influencer|talent|crew');
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ALTER COLUMN `wrap_time` SET TAGS ('dbx_business_glossary_term' = 'Production Wrap Time');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` SET TAGS ('dbx_subdomain' = 'resource_operations');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `timesheet_id` SET TAGS ('dbx_business_glossary_term' = 'Timesheet ID');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar ID');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `original_timesheet_id` SET TAGS ('dbx_business_glossary_term' = 'Original Timesheet ID');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `resource_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Allocation Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) ID');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `task_id` SET TAGS ('dbx_business_glossary_term' = 'Task Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `timesheet_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Approval Status');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|recalled');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Approved Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `billable_hours` SET TAGS ('dbx_business_glossary_term' = 'Billable Hours');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `billing_rate` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `billing_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Rate');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `cost_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `holiday_hours` SET TAGS ('dbx_business_glossary_term' = 'Holiday Hours');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `is_amended` SET TAGS ('dbx_business_glossary_term' = 'Is Amended Flag');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `is_late_submission` SET TAGS ('dbx_business_glossary_term' = 'Is Late Submission Flag');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,5}$');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `non_billable_hours` SET TAGS ('dbx_business_glossary_term' = 'Non-Billable Hours');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `pay_period_type` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Type');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `pay_period_type` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Submission Date');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Submission Method');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'web|mobile|api|manual_entry');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Submitted Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `timesheet_number` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Number');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `timesheet_number` SET TAGS ('dbx_value_regex' = '^TS-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `total_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Hours');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `utilization_rate` SET TAGS ('dbx_business_glossary_term' = 'Utilization Rate');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `wip_code` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Code');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `worker_notes` SET TAGS ('dbx_business_glossary_term' = 'Worker Notes');
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ALTER COLUMN `worker_type` SET TAGS ('dbx_business_glossary_term' = 'Worker Type');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` SET TAGS ('dbx_subdomain' = 'payroll_compensation');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `payroll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record ID');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `original_payroll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Original Payroll Record ID');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `bank_account_last4` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Last 4 Digits');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `bank_account_last4` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `bank_account_last4` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `bank_account_last4` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `base_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Pay Amount');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `base_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `base_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `benefits_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Benefits Deduction Amount');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `benefits_deduction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `benefits_deduction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `commission_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `employer_tax_contribution` SET TAGS ('dbx_business_glossary_term' = 'Employer Tax Contribution Amount');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `employer_tax_contribution` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `employer_tax_contribution` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `federal_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Federal Tax Withheld Amount');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `federal_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `federal_tax_withheld` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay Amount');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Hours Worked');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `is_off_cycle` SET TAGS ('dbx_business_glossary_term' = 'Off-Cycle Payroll Indicator');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `medicare_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Medicare Tax Withheld Amount');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `medicare_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `medicare_tax_withheld` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Amount');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `overtime_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Overtime Pay Amount');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `overtime_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `overtime_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `pay_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Date');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `pay_rate` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `pay_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate Type');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `pay_rate_type` SET TAGS ('dbx_value_regex' = 'hourly|salary|daily_rate|project_rate');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'direct_deposit|check|wire_transfer|prepaid_card');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `payroll_number` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record Number');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `payroll_number` SET TAGS ('dbx_value_regex' = '^PR-[0-9]{4}-[0-9]{2}-[0-9]{6}$');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `payroll_run_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Status');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `payroll_run_status` SET TAGS ('dbx_value_regex' = 'pending|processing|completed|reversed|on_hold');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `retirement_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Retirement Contribution Amount');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `retirement_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `retirement_contribution_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Payroll Reversal Indicator');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `social_security_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Social Security Tax Withheld Amount');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `social_security_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `social_security_tax_withheld` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `state_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'State Tax Withheld Amount');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `state_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `state_tax_withheld` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `total_deductions_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Deductions Amount');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `total_deductions_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `total_deductions_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `worker_type` SET TAGS ('dbx_business_glossary_term' = 'Worker Type');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `ytd_gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Gross Pay');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `ytd_gross_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `ytd_gross_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `ytd_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Tax Withheld');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `ytd_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ALTER COLUMN `ytd_tax_withheld` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `acquisition_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Acquisition ID');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `candidate_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Org Unit Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Job Requisition ID');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager ID');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `agency_fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Staffing Agency Fee Percentage');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `agency_fee_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Staffing Agency Name');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `approved_headcount_count` SET TAGS ('dbx_business_glossary_term' = 'Approved Headcount Count');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'Not Initiated|In Progress|Passed|Failed|Waived');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency (ISO 4217)');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Decline or Rejection Reason');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type (Full-Time Equivalent)');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'FTE|Freelancer|Contractor|Intern|Part-Time|Temporary');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `headcount_type` SET TAGS ('dbx_business_glossary_term' = 'Headcount Type');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `headcount_type` SET TAGS ('dbx_value_regex' = 'Backfill|New Headcount|Conversion|Upgrade');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `interview_rounds_count` SET TAGS ('dbx_business_glossary_term' = 'Interview Rounds Count');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `is_remote_eligible` SET TAGS ('dbx_business_glossary_term' = 'Remote Eligible Flag');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Date');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `offer_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Expiry Date');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `offer_status` SET TAGS ('dbx_value_regex' = 'Not Issued|Pending Approval|Issued|Accepted|Declined|Rescinded');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `offered_base_salary` SET TAGS ('dbx_business_glossary_term' = 'Offered Base Salary');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `offered_base_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `offered_bonus_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Offered Bonus Target Percentage');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `offered_bonus_target_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `pipeline_stage` SET TAGS ('dbx_business_glossary_term' = 'Candidate Pipeline Stage');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `posting_channel` SET TAGS ('dbx_business_glossary_term' = 'Job Posting Channel');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `recruiter_name` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Name');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `requisition_close_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Close Date');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Job Requisition Number');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{6,10}$');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `requisition_open_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Open Date');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_value_regex' = 'Draft|Open|On Hold|Filled|Cancelled|Closed');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `salary_band_max` SET TAGS ('dbx_business_glossary_term' = 'Salary Band Maximum');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `salary_band_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `salary_band_min` SET TAGS ('dbx_business_glossary_term' = 'Salary Band Minimum');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `salary_band_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `source_of_hire` SET TAGS ('dbx_business_glossary_term' = 'Source of Hire');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Status');
ALTER TABLE `advertising_ecm`.`talent`.`acquisition` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_value_regex' = 'Authorized|Requires Sponsorship|Pending Verification|Not Authorized');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` SET TAGS ('dbx_subdomain' = 'resource_operations');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `usage_right_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Right ID');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `conversion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset ID');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Workday Worker ID');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `ccpa_opt_out_status` SET TAGS ('dbx_business_glossary_term' = 'CCPA Opt-Out Status');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `ccpa_opt_out_status` SET TAGS ('dbx_value_regex' = 'opted_in|opted_out|not_applicable');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Date');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `exclusivity_category` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Category');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_value_regex' = 'exclusive|non_exclusive|category_exclusive');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Usage Right Fee Amount');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `gdpr_consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'GDPR Consent Obtained Flag');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `influencer_disclosure_required` SET TAGS ('dbx_business_glossary_term' = 'Influencer Disclosure Required Flag');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `is_perpetual` SET TAGS ('dbx_business_glossary_term' = 'Is Perpetual Rights Flag');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `original_grant_date` SET TAGS ('dbx_business_glossary_term' = 'Original Grant Date');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `payment_structure` SET TAGS ('dbx_business_glossary_term' = 'Payment Structure');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `payment_structure` SET TAGS ('dbx_value_regex' = 'buyout|residual|session_fee|hybrid');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Unauthorized Usage Penalty Amount');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `platform_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Platform Restrictions');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `renewal_count` SET TAGS ('dbx_business_glossary_term' = 'Renewal Count');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `renewal_option_deadline` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Deadline');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `residual_rate` SET TAGS ('dbx_business_glossary_term' = 'Residual Rate');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `residual_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `right_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Usage Right Reference Number');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `right_reference_number` SET TAGS ('dbx_value_regex' = '^UR-[A-Z0-9]{4,20}$');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `right_status` SET TAGS ('dbx_business_glossary_term' = 'Usage Right Status');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `right_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending_clearance|suspended|renewed|terminated');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Status');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|rejected|under_review');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `rights_end_date` SET TAGS ('dbx_business_glossary_term' = 'Rights End Date');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `rights_start_date` SET TAGS ('dbx_business_glossary_term' = 'Rights Start Date');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `talent_role` SET TAGS ('dbx_business_glossary_term' = 'Talent Role');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory / Market Code');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}(|[A-Z]{2,3})*$');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `union_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Code');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `union_agreement_code` SET TAGS ('dbx_value_regex' = 'SAG-AFTRA|ACTRA|BECTU|EQUITY|AFTRA|NON-UNION');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `union_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Union Contract Number');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `usage_limitation_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Limitation Notes');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `usage_period_months` SET TAGS ('dbx_business_glossary_term' = 'Usage Period (Months)');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `usage_subtype` SET TAGS ('dbx_business_glossary_term' = 'Usage Subtype');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `usage_type` SET TAGS ('dbx_business_glossary_term' = 'Usage Type');
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ALTER COLUMN `usage_type` SET TAGS ('dbx_value_regex' = 'broadcast|digital|ooh|social|print|radio');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` SET TAGS ('dbx_subdomain' = 'resource_operations');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `capacity_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan ID');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `primary_capacity_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner ID');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Workfront Plan ID');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `available_hours` SET TAGS ('dbx_business_glossary_term' = 'Available FTE-Equivalent Hours');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `campaign_pipeline_ids` SET TAGS ('dbx_business_glossary_term' = 'Campaign Pipeline IDs');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `capacity_gap_hours` SET TAGS ('dbx_business_glossary_term' = 'Capacity Gap Hours');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `confirmed_demand_hours` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Demand Hours');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Talent Discipline');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `forecasted_demand_hours` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Demand Hours');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `freelancer_hours_planned` SET TAGS ('dbx_business_glossary_term' = 'Freelancer Hours Planned');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `freelancer_pool_size` SET TAGS ('dbx_business_glossary_term' = 'Freelancer Pool Size');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `fte_headcount_contractor` SET TAGS ('dbx_business_glossary_term' = 'Contractor Full-Time Equivalent (FTE) Headcount');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `fte_headcount_permanent` SET TAGS ('dbx_business_glossary_term' = 'Permanent Full-Time Equivalent (FTE) Headcount');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `is_new_business_pitch` SET TAGS ('dbx_business_glossary_term' = 'Is New Business Pitch Flag');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `labor_cost_budget` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Budget');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `labor_cost_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `pipeline_demand_hours` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Demand Hours');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Code');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^CP-[A-Z0-9]{4,12}-[0-9]{4}$');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `plan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan End Date');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Name');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `plan_notes` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Notes');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `plan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Start Date');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Status');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|active|superseded|archived');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Version');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `planned_headcount_fte` SET TAGS ('dbx_business_glossary_term' = 'Planned Headcount Full-Time Equivalent (FTE)');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `planning_period_type` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Type');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `planning_period_type` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|annual');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `revenue_forecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Forecast Amount');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `revenue_forecast_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `scenario_type` SET TAGS ('dbx_business_glossary_term' = 'Scenario Type');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `scenario_type` SET TAGS ('dbx_value_regex' = 'best_case|expected|worst_case|base');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `sow_reference_ids` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Reference IDs');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ALTER COLUMN `utilization_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Utilization Target Percentage');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` SET TAGS ('dbx_subdomain' = 'resource_operations');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `leave_request_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Request ID');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Workfront Project ID');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `primary_leave_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `actual_return_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Return to Work Date');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Approval Notes');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Approval Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `approved_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Approved Leave Duration (Days)');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `approved_end_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Leave End Date');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `approved_start_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Leave Start Date');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `backfill_required` SET TAGS ('dbx_business_glossary_term' = 'Backfill Required Indicator');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `backfill_type` SET TAGS ('dbx_business_glossary_term' = 'Backfill Type');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `backfill_type` SET TAGS ('dbx_value_regex' = 'internal|freelancer|contractor|agency_staff|none');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `employee_notes` SET TAGS ('dbx_business_glossary_term' = 'Employee Notes');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `employee_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `intermittent_leave` SET TAGS ('dbx_business_glossary_term' = 'Intermittent Leave Indicator');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `is_fmla_qualifying` SET TAGS ('dbx_business_glossary_term' = 'Family and Medical Leave Act (FMLA) Qualifying Indicator');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `is_fmla_qualifying` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `is_paid` SET TAGS ('dbx_business_glossary_term' = 'Paid Leave Indicator');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `job_profile` SET TAGS ('dbx_business_glossary_term' = 'Job Profile');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `leave_balance_after_days` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance After Request (Days)');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `leave_balance_before_days` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance Before Request (Days)');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `leave_reason` SET TAGS ('dbx_business_glossary_term' = 'Leave Reason');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `leave_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `leave_subtype` SET TAGS ('dbx_business_glossary_term' = 'Leave Subtype');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_value_regex' = 'annual|sick|parental|unpaid|fmla|bereavement');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Received Indicator');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Required Indicator');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Status');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `request_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|cancelled|withdrawn');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `requested_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Requested Leave Duration (Days)');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `requested_end_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Leave End Date');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `requested_start_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Leave Start Date');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `resource_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Resource Impact Assessment');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `resource_impact_assessment` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|critical');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'workday_hcm|manual|api_integration');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Submission Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `workday_absence_request_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday Absence Request ID');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `worker_type` SET TAGS ('dbx_business_glossary_term' = 'Worker Type');
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ALTER COLUMN `worker_type` SET TAGS ('dbx_value_regex' = 'fte|freelancer|contractor|influencer|production_crew');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `review_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle ID');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `reviewer_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `calibrated_rating` SET TAGS ('dbx_business_glossary_term' = 'Calibrated Performance Rating');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `calibrated_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `calibrated_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'not_started|in_calibration|calibrated|approved');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `client_service_competency_score` SET TAGS ('dbx_business_glossary_term' = 'Client Service Competency Score');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `collaboration_score` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Competency Score');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `competency_score_avg` SET TAGS ('dbx_business_glossary_term' = 'Average Competency Score');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `creative_excellence_score` SET TAGS ('dbx_business_glossary_term' = 'Creative Excellence Competency Score');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `development_areas_summary` SET TAGS ('dbx_business_glossary_term' = 'Development Areas Summary');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `development_areas_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `digital_analytics_score` SET TAGS ('dbx_business_glossary_term' = 'Digital and Analytics Competency Score');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `employee_acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Date');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `employee_self_assessment` SET TAGS ('dbx_business_glossary_term' = 'Employee Self-Assessment');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `employee_self_assessment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `goal_attainment_score` SET TAGS ('dbx_business_glossary_term' = 'Goal Attainment Score');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `goals_achieved_count` SET TAGS ('dbx_business_glossary_term' = 'Goals Achieved Count');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `goals_set_count` SET TAGS ('dbx_business_glossary_term' = 'Goals Set Count');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `leadership_competency_score` SET TAGS ('dbx_business_glossary_term' = 'Leadership Competency Score');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `merit_increase_pct` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Percentage');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `merit_increase_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `merit_increase_recommended` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Recommendation Flag');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `merit_increase_recommended` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `overall_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating Score');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `pip_required` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Required Flag');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `pip_required` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `promotion_recommended` SET TAGS ('dbx_business_glossary_term' = 'Promotion Recommendation Flag');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `promotion_recommended` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `promotion_target_level` SET TAGS ('dbx_business_glossary_term' = 'Promotion Target Level');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `promotion_target_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Number');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `review_number` SET TAGS ('dbx_value_regex' = '^PR-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Status');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|pending_acknowledgement|completed|cancelled');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `review_template_version` SET TAGS ('dbx_business_glossary_term' = 'Review Template Version');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Type');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'annual|mid_year|probationary|project_based|pip');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `strengths_summary` SET TAGS ('dbx_business_glossary_term' = 'Performance Strengths Summary');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `strengths_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Submitted Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `succession_candidate` SET TAGS ('dbx_business_glossary_term' = 'Succession Candidate Flag');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `succession_candidate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `talent_segment` SET TAGS ('dbx_business_glossary_term' = 'Talent Segment');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `talent_segment` SET TAGS ('dbx_value_regex' = 'high_potential|key_talent|core_talent|developing|at_risk');
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ALTER COLUMN `talent_segment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `tertiary_org_manager_employee_worker_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `annual_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget (USD)');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `annual_budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `approved_headcount` SET TAGS ('dbx_business_glossary_term' = 'Approved Headcount');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Unit Flag');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `capacity_utilization_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Capacity Utilization Target Percentage');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `data_privacy_region` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Regulatory Region');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `data_privacy_region` SET TAGS ('dbx_value_regex' = 'GDPR|CCPA|PIPEDA|LGPD|PDPA|Other');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Agency Discipline');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `external_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Flag');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `head_count_fte` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Headcount');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Organizational Hierarchy Level');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Organizational Hierarchy Path');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `office_location` SET TAGS ('dbx_business_glossary_term' = 'Office Location');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `org_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Description');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = 'North America|EMEA|APAC|LATAM|Global');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `reorganization_date` SET TAGS ('dbx_business_glossary_term' = 'Reorganization Date');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `shared_services_flag` SET TAGS ('dbx_business_glossary_term' = 'Shared Services Flag');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `sow_ownership_flag` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Ownership Flag');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|dissolved|restructuring');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `workday_org_unit_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday Organizational Unit ID');
ALTER TABLE `advertising_ecm`.`talent`.`org_unit` ALTER COLUMN `workfront_group_reference` SET TAGS ('dbx_business_glossary_term' = 'Workfront Group ID');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `guild_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Membership Identifier (ID)');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Identifier (ID)');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `renewed_guild_membership_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `annual_dues_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Dues Amount');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `availability_restriction` SET TAGS ('dbx_business_glossary_term' = 'Availability Restriction Notes');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `booking_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Booking Eligibility Flag');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `contract_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement Code');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `dues_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Dues Currency Code');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `dues_currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|GBP|EUR');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `dues_status` SET TAGS ('dbx_business_glossary_term' = 'Dues Payment Status');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `dues_status` SET TAGS ('dbx_value_regex' = 'current|overdue|delinquent|exempt|waived');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Effective Date');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `exclusivity_category` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Category');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `exclusivity_restriction` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Restriction Level');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `exclusivity_restriction` SET TAGS ('dbx_value_regex' = 'none|partial|full|category_specific');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Expiry Date');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `health_benefits_eligible` SET TAGS ('dbx_business_glossary_term' = 'Health Benefits Eligible Flag');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `health_benefits_eligible` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `health_benefits_eligible` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `join_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Join Date');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Union Jurisdiction Code');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|GBR|AUS');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `last_dues_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dues Payment Date');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `local_chapter_code` SET TAGS ('dbx_business_glossary_term' = 'Local Chapter or Branch Code');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `membership_number` SET TAGS ('dbx_business_glossary_term' = 'Guild Membership Number');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|lapsed|pending|withdrawn');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `membership_type` SET TAGS ('dbx_business_glossary_term' = 'Membership Type');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `membership_type` SET TAGS ('dbx_value_regex' = 'full|associate|honorary|lifetime|apprentice|journeyman');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `minimum_rate_schedule` SET TAGS ('dbx_business_glossary_term' = 'Minimum Rate Schedule Reference');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `next_dues_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Dues Due Date');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `pension_eligible` SET TAGS ('dbx_business_glossary_term' = 'Pension Eligible Flag');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `residual_payment_eligible` SET TAGS ('dbx_business_glossary_term' = 'Residual Payment Eligible Flag');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `signatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Signatory Requirement Flag');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Termination Date');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union or Guild Code');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `union_name` SET TAGS ('dbx_business_glossary_term' = 'Union or Guild Full Name');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Verification Date');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Verification Status');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|unverified|expired');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By User Name');
ALTER TABLE `advertising_ecm`.`talent`.`guild_membership` ALTER COLUMN `work_permit_required` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Required Flag');
ALTER TABLE `advertising_ecm`.`talent`.`talent_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`talent`.`talent_assignment` SET TAGS ('dbx_subdomain' = 'resource_operations');
ALTER TABLE `advertising_ecm`.`talent`.`talent_assignment` SET TAGS ('dbx_association_edges' = 'talent.worker,project.initiative');
ALTER TABLE `advertising_ecm`.`talent`.`talent_assignment` ALTER COLUMN `talent_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'talent_assignment Identifier');
ALTER TABLE `advertising_ecm`.`talent`.`talent_assignment` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Identifier');
ALTER TABLE `advertising_ecm`.`talent`.`talent_assignment` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Worker Identifier');
ALTER TABLE `advertising_ecm`.`talent`.`talent_assignment` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours');
ALTER TABLE `advertising_ecm`.`talent`.`talent_assignment` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `advertising_ecm`.`talent`.`talent_assignment` ALTER COLUMN `assignment_code` SET TAGS ('dbx_business_glossary_term' = 'Assignment Identifier');
ALTER TABLE `advertising_ecm`.`talent`.`talent_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `advertising_ecm`.`talent`.`talent_assignment` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `advertising_ecm`.`talent`.`talent_assignment` ALTER COLUMN `billing_rate` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate');
ALTER TABLE `advertising_ecm`.`talent`.`talent_assignment` ALTER COLUMN `cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Rate');
ALTER TABLE `advertising_ecm`.`talent`.`talent_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`talent_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `advertising_ecm`.`talent`.`talent_assignment` ALTER COLUMN `planned_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Hours');
ALTER TABLE `advertising_ecm`.`talent`.`talent_assignment` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `advertising_ecm`.`talent`.`talent_assignment` ALTER COLUMN `role` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role');
ALTER TABLE `advertising_ecm`.`talent`.`talent_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Assignment ID');
ALTER TABLE `advertising_ecm`.`talent`.`talent_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `advertising_ecm`.`talent`.`talent_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Updated Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`representation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`talent`.`representation` SET TAGS ('dbx_subdomain' = 'resource_operations');
ALTER TABLE `advertising_ecm`.`talent`.`representation` SET TAGS ('dbx_association_edges' = 'talent.talent_profile,vendor.supplier');
ALTER TABLE `advertising_ecm`.`talent`.`representation` ALTER COLUMN `representation_id` SET TAGS ('dbx_business_glossary_term' = 'Representation Agreement Identifier');
ALTER TABLE `advertising_ecm`.`talent`.`representation` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Representation - Supplier Id');
ALTER TABLE `advertising_ecm`.`talent`.`representation` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Representation - Talent Profile Id');
ALTER TABLE `advertising_ecm`.`talent`.`representation` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission Rate');
ALTER TABLE `advertising_ecm`.`talent`.`representation` ALTER COLUMN `commission_rate` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`representation` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Representation Contract Reference Number');
ALTER TABLE `advertising_ecm`.`talent`.`representation` ALTER COLUMN `contract_reference` SET TAGS ('dbx_pii_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`representation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`representation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Representation End Date');
ALTER TABLE `advertising_ecm`.`talent`.`representation` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Representation Exclusivity Scope');
ALTER TABLE `advertising_ecm`.`talent`.`representation` ALTER COLUMN `primary_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Representation Contact Flag');
ALTER TABLE `advertising_ecm`.`talent`.`representation` ALTER COLUMN `representation_status` SET TAGS ('dbx_business_glossary_term' = 'Representation Agreement Status');
ALTER TABLE `advertising_ecm`.`talent`.`representation` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Representation Start Date');
ALTER TABLE `advertising_ecm`.`talent`.`representation` ALTER COLUMN `territory_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Representation Territory Restrictions');
ALTER TABLE `advertising_ecm`.`talent`.`representation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_run` SET TAGS ('dbx_subdomain' = 'payroll_compensation');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_run` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Identifier');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_run` ALTER COLUMN `correction_of_payroll_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`review_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`talent`.`review_cycle` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `advertising_ecm`.`talent`.`job_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`talent`.`job_profile` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `advertising_ecm`.`talent`.`job_profile` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Identifier');
ALTER TABLE `advertising_ecm`.`talent`.`job_profile` ALTER COLUMN `parent_job_profile_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`job_profile` ALTER COLUMN `standard_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`requisition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`talent`.`requisition` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `advertising_ecm`.`talent`.`requisition` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Identifier');
ALTER TABLE `advertising_ecm`.`talent`.`requisition` ALTER COLUMN `replacement_requisition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`requisition` ALTER COLUMN `hourly_rate_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`requisition` ALTER COLUMN `hourly_rate_minimum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`requisition` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`requisition` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`candidate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`talent`.`candidate` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ALTER COLUMN `candidate_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate Identifier');
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ALTER COLUMN `referred_by_candidate_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ALTER COLUMN `current_employer` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ALTER COLUMN `current_job_title` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ALTER COLUMN `desired_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ALTER COLUMN `desired_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ALTER COLUMN `location_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ALTER COLUMN `location_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ALTER COLUMN `location_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ALTER COLUMN `location_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ALTER COLUMN `resume_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`candidate` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`holiday_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`talent`.`holiday_calendar` SET TAGS ('dbx_subdomain' = 'resource_operations');
ALTER TABLE `advertising_ecm`.`talent`.`holiday_calendar` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Identifier');
ALTER TABLE `advertising_ecm`.`talent`.`holiday_calendar` ALTER COLUMN `derived_from_holiday_calendar_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`review_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`talent`.`review_template` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `advertising_ecm`.`talent`.`review_template` ALTER COLUMN `review_template_id` SET TAGS ('dbx_business_glossary_term' = 'Review Template Identifier');
ALTER TABLE `advertising_ecm`.`talent`.`review_template` ALTER COLUMN `derived_from_review_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`talent`.`location` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `advertising_ecm`.`talent`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `advertising_ecm`.`talent`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`location` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`location` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`location` ALTER COLUMN `monthly_rent_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_calendar` SET TAGS ('dbx_subdomain' = 'payroll_compensation');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_calendar` ALTER COLUMN `payroll_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Calendar Identifier');
ALTER TABLE `advertising_ecm`.`talent`.`payroll_calendar` ALTER COLUMN `prior_payroll_calendar_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`talent`.`legal_entity` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `advertising_ecm`.`talent`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `advertising_ecm`.`talent`.`legal_entity` ALTER COLUMN `annual_revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`legal_entity` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`legal_entity` ALTER COLUMN `registered_address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`legal_entity` ALTER COLUMN `registered_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`legal_entity` ALTER COLUMN `registered_address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`legal_entity` ALTER COLUMN `registered_address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`talent`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
