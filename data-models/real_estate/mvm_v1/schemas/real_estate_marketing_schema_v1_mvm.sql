-- Schema for Domain: marketing | Business: Real Estate | Version: v1_mvm
-- Generated on: 2026-05-02 05:06:37

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `real_estate_ecm`.`marketing` COMMENT 'Manages property marketing campaigns, digital listings, lead generation, market research, brand management, and advertising spend across commercial and residential portfolios. Tracks marketing channels, campaign performance, lead attribution, and competitive market intelligence.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Unique system-generated identifier for the marketing campaign. Primary key for the campaign master record across all marketing activities.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to property.asset. Business justification: Asset-specific lease-up campaigns and disposition marketing campaigns are a core real estate marketing process. A campaign is often scoped to a single asset (e.g., new multifamily lease-up). Campaign ',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Real estate marketing campaigns are funded from approved finance budgets (property opex or leasing budget lines). Linking campaign to finance.budget enables budget utilization tracking and prevents ov',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: campaign currently stores primary_channel as a free-text STRING field, which is not normalized. The channel table is the authoritative reference master for all marketing channels. Adding channel_id as',
    `green_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.green_certification. Business justification: ESG-aligned marketing campaigns are built around specific LEED/BREEAM certifications. Linking the campaign to the actual certification record enables verification that advertised green credentials are',
    `requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.requirement. Business justification: Marketing campaigns in real estate must satisfy specific compliance requirements (fair housing equal opportunity language, state advertising disclosure mandates). Linking a campaign to its governing c',
    `cost_center_id` BIGINT COMMENT 'Reference to the finance cost center to which campaign spend is allocated in the General Ledger (GL). Enables P&L attribution by business unit, property type, or geographic market.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Campaign budget approval and financial reporting requires a normalized currency reference for multi-currency real estate portfolios. Normalizing enables FX conversion for consolidated marketing spend ',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Pre-sales and lease-up campaigns are launched for specific development projects. Marketing directors track campaign spend and lead generation by dev_project for project-level ROI reporting and budget ',
    `fund_id` BIGINT COMMENT 'Foreign key linking to investment.fund. Business justification: Fund marketing campaigns (LP fundraising, fund launch, investor roadshows) are tied to a specific fund. Fund managers require fund-level marketing spend and campaign performance reporting. A real esta',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Real estate campaigns are scoped to geographic markets (MSA, submarket, city). Normalizing enables market-level campaign performance reporting, budget allocation by geography, and comparison against m',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Real estate marketing campaigns must comply with jurisdiction-specific advertising regulations (fair housing disclosures, state-mandated language, TCPA/CAN-SPAM rules). Compliance officers reviewing c',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: Real estate campaigns are structured around lease type (NNN investment campaigns vs. gross lease office campaigns). Lease type determines campaign compliance requirements (ASC 842 disclosure), channel',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: In multi-entity REIT and fund structures, marketing campaigns are run under specific legal entities for tax, compliance, and cost allocation. AP invoices for campaigns must be booked to the correct le',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to reference.market_segment. Business justification: Real estate campaigns are designed for specific investment strategies (core, value-add, opportunistic). Normalizing portfolio_segment to reference.market_segment enables campaign ROI reporting by inve',
    `owner_agreement_id` BIGINT COMMENT 'Foreign key linking to owner.owner_agreement. Business justification: Property management agreements define marketing fee structures, approval thresholds, and authorized spend. Linking campaigns to the governing owner agreement enables compliance reporting, fee reconcil',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: Real estate fund managers run portfolio-level marketing campaigns for investor relations and leasing strategy (e.g., a value-add multifamily portfolio launch). campaign_flight has portfolio_id at the ',
    `prior_campaign_id` BIGINT COMMENT 'Self-referencing FK on campaign (prior_campaign_id)',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Campaign planning and performance reporting in real estate is organized by property type (office, industrial, multifamily). Normalizing property_type_focus to reference.property_type enables cross-cam',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Real estate marketing campaigns are fundamentally organized by transaction type (For Sale, For Lease, 1031 Exchange, Investment). Campaign budgets, compliance requirements (fair housing, SEC disclosur',
    `actual_end_date` DATE COMMENT 'The actual date the campaign concluded. Used to calculate true campaign duration and compare against planned timeline for post-campaign performance analysis.',
    `actual_start_date` DATE COMMENT 'The actual date the campaign went live and began generating impressions or leads. May differ from planned start date due to creative approval delays or market timing adjustments.',
    `approval_date` DATE COMMENT 'The date on which the campaign received final budget and compliance approval. Used for SOX audit trails and to measure planning-to-launch lead time.',
    `approval_status` STRING COMMENT 'The current state of the campaigns internal approval workflow, including budget authorization and compliance sign-off. Distinct from campaign lifecycle status — a campaign may be approved but not yet active.. Valid values are `pending_approval|approved|rejected|revision_required`',
    `approved_budget_amount` DECIMAL(18,2) COMMENT 'Total approved Capital Expenditure (CAPEX) / Operating Expenditure (OPEX) budget allocated to the campaign, expressed in the operating currency. Sourced from SAP S/4HANA budget approval workflow and reconciled against finance.budget.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who granted final budget and compliance approval for the campaign. Supports SOX audit trail requirements for marketing spend authorization.',
    `campaign_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the campaign, used in cross-system references, purchase orders, and vendor invoices. Format: MARKET-YEAR-SEQUENCE (e.g., CRE-2024-QTRQ1).. Valid values are `^[A-Z]{2,6}-[0-9]{4}-[A-Z0-9]{4,12}$`',
    `campaign_name` STRING COMMENT 'Human-readable name of the marketing campaign as displayed in Salesforce CRM and internal reporting dashboards (e.g., Q1 2024 Downtown Office Leasing Drive).',
    `campaign_status` STRING COMMENT 'Current lifecycle state of the campaign. Controls visibility in active reporting, spend authorization, and lead attribution routing within Salesforce CRM.. Valid values are `draft|active|paused|completed|cancelled`',
    `campaign_type` STRING COMMENT 'Classification of the marketing channel or medium used for the campaign. Drives channel-specific performance benchmarking and spend allocation. [ENUM-REF-CANDIDATE: digital|print|out_of_home|email|social_media|event|direct_mail|broadcast — promote to reference product if additional types are needed]. Valid values are `digital|print|out_of_home|email|social_media|event`',
    `channel_mix` STRING COMMENT 'Comma-separated list of marketing channels deployed within this campaign (e.g., google_ads,facebook,email,mls_syndication). Provides a high-level channel inventory for multi-channel campaign analysis without requiring a separate channel line table.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the campaign record was first created in the system. Serves as the audit trail creation marker for the Silver Layer and supports SOX compliance audit requirements.',
    `creative_theme` STRING COMMENT 'The overarching creative concept or messaging theme of the campaign (e.g., Urban Living Redefined, Prime Office Space Available, ESG-Certified Buildings). Used for brand consistency audits and creative performance analysis.',
    `digital_platform` STRING COMMENT 'Name of the primary digital advertising platform used for the campaign (e.g., Google Ads, Meta Ads Manager, LinkedIn Campaign Manager, CoStar Advertise). Supports platform-level spend and performance reconciliation.',
    `esg_aligned_flag` BOOLEAN COMMENT 'Indicates whether the campaign promotes Environmental, Social, and Governance (ESG) credentials such as Leadership in Energy and Environmental Design (LEED) certification, Building Research Establishment Environmental Assessment Method (BREEAM) ratings, or sustainability initiatives.',
    `fair_housing_compliant_flag` BOOLEAN COMMENT 'Indicates whether the campaign has been reviewed and confirmed compliant with the Fair Housing Act and U.S. Department of Housing and Urban Development (HUD) advertising guidelines. Mandatory for all residential marketing campaigns.',
    `gdpr_compliant_flag` BOOLEAN COMMENT 'Indicates whether the campaigns audience targeting, data collection, and lead capture processes comply with General Data Protection Regulation (GDPR) requirements. Required for campaigns targeting EU-based prospects.',
    `mls_syndication_flag` BOOLEAN COMMENT 'Indicates whether the campaign includes syndication of property listings to Multiple Listing Service (MLS) platforms (e.g., Zillow, Realtor.com, CoStar). Drives integration with brokerage.mls_syndication records.',
    `notes` STRING COMMENT 'Free-text field for campaign managers to record strategic context, special instructions, vendor notes, or post-campaign observations not captured in structured fields.',
    `objective` STRING COMMENT 'Primary business objective the campaign is designed to achieve. Used to align campaign KPIs and measure success against strategic marketing goals across commercial and residential portfolios.. Valid values are `lead_generation|brand_awareness|listing_promotion|market_penetration|tenant_retention`',
    `planned_end_date` DATE COMMENT 'The originally approved end date for the campaign. Used for budget period alignment, Weighted Average Lease Term (WALT) correlation analysis, and campaign lifecycle management.',
    `planned_start_date` DATE COMMENT 'The originally approved start date for the campaign as defined during the planning and budget approval process. Used for campaign scheduling and budget period alignment.',
    `source_system` STRING COMMENT 'The operational system of record from which this campaign record originated (e.g., Salesforce CRM, CoStar Suite, SAP S/4HANA). Supports data lineage tracking in the Databricks Silver Layer.. Valid values are `salesforce_crm|costar|sap_s4hana|manual`',
    `source_system_campaign_code` STRING COMMENT 'The native campaign identifier from the originating operational system (e.g., Salesforce CRM Campaign ID). Enables reconciliation between the Silver Layer and source systems during ETL validation.',
    `target_impression_count` BIGINT COMMENT 'The planned number of ad impressions or audience reach exposures targeted for the campaign. Used for brand awareness campaigns and digital media planning benchmarks.',
    `target_lead_count` STRING COMMENT 'The planned number of qualified leads the campaign is expected to generate. Set during campaign planning and used as the primary lead generation KPI benchmark in Salesforce CRM pipeline reporting.',
    `total_spend_to_date` DECIMAL(18,2) COMMENT 'Cumulative actual spend incurred against the campaign budget as of the last reconciliation date. Sourced from SAP S/4HANA Accounts Payable (AP) and reconciled with finance.ap_invoice records. Enables real-time budget utilization monitoring.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the campaign record was most recently modified. Used for incremental data loading in the Databricks Silver Layer and change data capture (CDC) processing.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Master record for every marketing campaign executed across commercial and residential portfolios. Captures campaign name, type (digital, print, OOH, email, social, event), objective (lead generation, brand awareness, listing promotion, market penetration), target audience segment, geographic market, property type focus, campaign status (draft, active, paused, completed), planned start and end dates, actual run dates, total approved budget, total spend to date, campaign owner, and associated brand or sub-brand. SSOT for campaign identity across all marketing activities.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`campaign_flight` (
    `campaign_flight_id` BIGINT COMMENT 'Unique surrogate identifier for a discrete campaign flight execution record within the marketing domain. Primary key for this transactional entity.',
    `ad_creative_id` BIGINT COMMENT 'Foreign key linking to marketing.ad_creative. Business justification: campaign_flight.creative_asset_ref is a STRING reference to the creative asset used in the flight. Normalizing to ad_creative_id FK links the flight to the authoritative creative master, enabling retr',
    `asset_id` BIGINT COMMENT 'Reference to the specific property asset being marketed in this flight, if applicable. Enables property-level marketing spend attribution and ROI analysis per asset.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Individual campaign flights have discrete budget allocations tracked against finance_budget line items. Marketing ops teams reconcile flight-level actual spend against approved budget; this enables gr',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Campaign flights in commercial RE are targeted at specific buildings for building-level leasing campaigns. campaign_flight has asset_id but building-level flight targeting (e.g., a specific tower in a',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign under which this flight is executed. A campaign may contain multiple flights across different channels or time periods.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: campaign_flight.channel_type and channel_subtype are STRING fields. Normalizing to channel_id FK links the flight to the authoritative channel master, enabling retrieval of channel cost models, UTM pa',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Campaign flights represent discrete spend commitments coded to GL accounts for accrual and opex reporting. campaign_flight.gl_account_code is a denormalized string. A FK to chart_of_accounts enables a',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `event_id` BIGINT COMMENT 'Foreign key linking to marketing.event. Business justification: A campaign flight can be specifically designed to promote or support a marketing event (e.g., a pre-open-house digital advertising burst, an investor event promotional flight). Adding event_id to camp',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Campaign flights in real estate are geo-targeted to specific submarkets or MSAs. Normalizing target_geography enables flight performance analysis by geographic hierarchy node and media mix optimizatio',
    `listing_id` BIGINT COMMENT 'Reference to the specific property listing being promoted by this flight, if the flight is tied to a single listing (e.g., a Zillow or LoopNet featured listing flight). Null for portfolio-level or brand awareness flights.',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment or property portfolio being marketed, for portfolio-level brand or awareness flights not tied to a single property. Supports AUM-level marketing spend reporting.',
    `prior_campaign_flight_id` BIGINT COMMENT 'Self-referencing FK on campaign_flight (prior_campaign_flight_id)',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Campaign flights are targeted at specific property types; media buyers and marketing analysts filter flight performance by property type for ROI reporting and budget optimization across asset classes.',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Campaign flights can target different transaction types within a parent campaign (e.g., a portfolio campaign with separate sale and lease flights). Flight-level transaction type enables precise attrib',
    `actual_spend` DECIMAL(18,2) COMMENT 'Total media spend actually incurred for this flight to date, in the operating currency (USD). Sourced from ad platform billing or vendor invoices. Used for budget pacing, ROI analysis, and OPEX reporting.',
    `approval_status` STRING COMMENT 'Workflow approval state for this flight prior to launch. Tracks the internal review and sign-off process for creative, budget, compliance, and targeting parameters. Values: pending, approved, rejected, revision_required.. Valid values are `pending|approved|rejected|revision_required`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this flight received final approval for execution. Distinct from the flight start date; captures the authorization event for audit and compliance purposes.',
    `clicks` BIGINT COMMENT 'Total number of user clicks on the ad creative during this flight. Primary engagement metric for digital channels. Used in CPC (Cost Per Click) calculations and click-through rate (CTR) analysis for lead generation attribution.',
    `cpc_rate` DECIMAL(18,2) COMMENT 'Negotiated or platform-set cost per click (CPC) for this flight, in the operating currency. Used for click-based channel cost benchmarking and ROI analysis on lead generation flights.',
    `cpm_rate` DECIMAL(18,2) COMMENT 'Negotiated or platform-set cost per one thousand impressions (CPM) for this flight, in the operating currency. Used for media buy pricing benchmarking and impression-based channel cost analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this campaign flight record was first created in the system. Audit trail field for data lineage and record provenance tracking.',
    `creative_format` STRING COMMENT 'Format type of the creative asset deployed in this flight. Determines rendering requirements and platform compatibility. Values: image, video, carousel, text, html5, direct_mail_piece, email_template, outdoor (billboard/signage). [ENUM-REF-CANDIDATE: image|video|carousel|text|html5|direct_mail_piece|email_template|outdoor — 8 candidates stripped; promote to reference product]',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this flight record (flight_budget, actual_spend, cpm_rate, cpc_rate). Defaults to USD for domestic US real estate operations.. Valid values are `^[A-Z]{3}$`',
    `end_date` DATE COMMENT 'The calendar date on which this campaign flight is scheduled to stop delivering. Nullable for open-ended or evergreen flights. Used for budget pacing, expiry alerts, and WALT-style weighted average flight term calculations.',
    `esg_aligned` BOOLEAN COMMENT 'Indicates whether this flight promotes ESG-certified or sustainability-focused properties (e.g., LEED, BREEAM certified assets). Supports ESG marketing reporting and green portfolio brand positioning.',
    `fair_housing_compliant` BOOLEAN COMMENT 'Indicates whether this flights creative, targeting, and placement have been reviewed and confirmed compliant with the Fair Housing Act (FHA) and HUD advertising guidelines. Mandatory for residential property marketing flights. True = compliant, False = pending review or non-compliant.',
    `flight_budget` DECIMAL(18,2) COMMENT 'Total approved budget allocated to this specific flight in the operating currency (USD). Represents the planned CAPEX/OPEX marketing spend for this channel activation. Used for budget vs. actual spend variance analysis.',
    `flight_name` STRING COMMENT 'Human-readable descriptive name for this flight, typically including the channel, property portfolio, and run period (e.g., Q3-2024 Google Ads — Downtown Office Portfolio).',
    `flight_number` STRING COMMENT 'Externally-known business identifier for this flight, used in media buy orders, vendor invoices, and campaign tracking systems. Format: FLT- followed by 4–12 alphanumeric characters.. Valid values are `^FLT-[A-Z0-9]{4,12}$`',
    `flight_status` STRING COMMENT 'Current lifecycle state of the campaign flight. Tracks progression from planning through execution to closure. Values: draft (being configured), scheduled (approved, not yet started), active (currently running), paused (temporarily halted), completed (run period ended), cancelled (terminated before completion).. Valid values are `draft|scheduled|active|paused|completed|cancelled`',
    `impressions_delivered` BIGINT COMMENT 'Total number of ad impressions served to target audiences during this flight. A key reach metric for brand awareness campaigns across digital channels (Google Ads, Meta, CoStar, Zillow, LoopNet). Used in CPM (Cost Per Mille) performance calculations.',
    `landing_page_url` STRING COMMENT 'The destination URL to which users are directed upon clicking the ad in this flight. Typically a property listing page, microsite, or lead capture form. Used for conversion tracking and digital experience analysis.',
    `leads_generated` STRING COMMENT 'Number of qualified leads (prospect inquiries, form submissions, or contact requests) directly attributed to this flight. Core lead generation KPI linking marketing spend to brokerage pipeline activity in Salesforce CRM.',
    `notes` STRING COMMENT 'Free-text field for campaign managers to capture contextual notes, special instructions, vendor negotiation details, or performance observations related to this flight. Not used for structured analytics.',
    `placement_name` STRING COMMENT 'Specific placement, ad unit, or inventory position within the channel where the flight is served (e.g., CoStar Featured Listing — Office, Zillow Premier Agent Slot, Google Search — Brand Keywords, Billboard I-95 Northbound).',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this flight record originated. Supports data lineage tracking and multi-source reconciliation in the Databricks Silver Layer. Values: salesforce_crm, costar, google_ads, meta_ads, yardi, manual.. Valid values are `salesforce_crm|costar|google_ads|meta_ads|yardi|manual`',
    `start_date` DATE COMMENT 'The calendar date on which this campaign flight begins delivering impressions or activating the media buy. Used for scheduling, pacing analysis, and campaign timeline reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this campaign flight record was last modified. Used for incremental data pipeline processing, change detection, and audit trail maintenance in the Databricks Silver Layer.',
    `utm_campaign` STRING COMMENT 'UTM campaign parameter identifying the specific campaign name or code for this flight in web analytics. Enables end-to-end attribution from ad impression to website visit to lead conversion.',
    `utm_medium` STRING COMMENT 'UTM medium parameter identifying the marketing medium for this flight (e.g., cpc, display, email, social, direct_mail). Used alongside utm_source for multi-touch attribution modeling.',
    `utm_source` STRING COMMENT 'Urchin Tracking Module (UTM) source parameter appended to landing page URLs for this flight, identifying the originating platform (e.g., google, meta, costar, zillow). Enables web analytics attribution and lead source tracking in CRM.',
    `vendor_order_number` STRING COMMENT 'The vendor-assigned order, insertion order (IO), or contract number for this media buy. Used to reconcile flight spend against AP invoices and vendor billing statements.',
    CONSTRAINT pk_campaign_flight PRIMARY KEY(`campaign_flight_id`)
) COMMENT 'Transactional record representing a discrete execution flight or burst within a parent campaign — a specific channel activation, media buy, or ad run period. Captures flight name, channel type (Google Ads, Meta, CoStar, Zillow, LoopNet, email, direct mail, billboard), flight start and end dates, flight budget, impressions delivered, clicks, spend, placement details, creative asset reference, and flight status. Enables multi-channel campaign decomposition and channel-level performance tracking.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`ad_creative` (
    `ad_creative_id` BIGINT COMMENT 'Unique system-generated identifier for each marketing creative asset record. Primary key for the ad_creative master resource.',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Commercial real estate building brand campaigns produce ad creatives specific to a building (e.g., 123 Main St — Premier Office Space). Creative compliance review and fair housing audits require lin',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign this creative asset is assigned to. Links the creative to its parent campaign for performance attribution and spend tracking.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: ad_creative.channel is a STRING denoting the marketing channel (e.g., Digital, Social, Print). Normalizing to channel_id FK links the creative to the authoritative channel master, enabling chann',
    `currency_code_id` BIGINT COMMENT 'ISO 4217 three-letter currency code for the production_cost amount (e.g., USD, GBP, EUR). Required for multi-currency portfolio operations.',
    `derived_ad_creative_id` BIGINT COMMENT 'Self-referencing FK on ad_creative (derived_ad_creative_id)',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Renderings, virtual tours, and floor plan creatives are produced specifically for a development projects pre-leasing/pre-sales marketing. Project-level creative spend tracking and brand compliance au',
    `event_id` BIGINT COMMENT 'Foreign key linking to marketing.event. Business justification: Ad creatives are frequently produced specifically for marketing events — open house promotional graphics, investor briefing banners, property launch event imagery. Adding event_id to ad_creative enabl',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Ad creatives must comply with jurisdiction-specific advertising rules including required fair housing statements, language requirements, and state-mandated disclosures. Compliance review of ad creativ',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: Real estate ad creatives are designed for specific lease structures (NNN investment ads vs. gross lease office ads). Lease type drives creative compliance requirements (ASC 842 disclosures), messaging',
    `asset_id` BIGINT COMMENT 'Reference to the specific property this creative asset is associated with. Null if the creative is portfolio-level or brand-level rather than property-specific.',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Ad creatives are produced for specific property types (e.g., industrial warehouse vs. luxury residential). Brand compliance and fair housing review processes require knowing which property type a crea',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Ad creatives in real estate must comply with specific regulatory obligations (Fair Housing Act, RESPA, state advertising laws). Linking each creative to its governing obligation enables compliance rev',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: Residential RE ad creatives are produced for specific units: unit photography, virtual staging, floor plan renders. Linking creatives to units enables unit-level creative asset management and ensures ',
    `accessibility_compliant` BOOLEAN COMMENT 'Indicates whether the creative asset meets web accessibility standards (WCAG 2.1 AA), including alt-text for images, captions for video, and sufficient color contrast. Required for ADA compliance in digital marketing.',
    `agency_name` STRING COMMENT 'Name of the external creative agency, photography studio, or freelance vendor responsible for producing this creative asset. Used for vendor performance tracking and procurement reporting.',
    `approval_date` DATE COMMENT 'Date on which the creative asset received final approval for deployment. Used for compliance audit trails and to calculate time-to-market for creative production workflows.',
    `approval_status` STRING COMMENT 'Current workflow state of the creative asset in the brand compliance and legal approval lifecycle. Controls whether the asset may be deployed in active campaigns. Serves as the LIFECYCLE_STATUS for this master resource.. Valid values are `draft|pending_review|approved|rejected|expired|archived`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual (marketing manager, legal reviewer, or brand officer) who granted final approval for the creative asset. Supports audit trail requirements for SOX-compliant marketing spend controls.',
    `aspect_ratio` STRING COMMENT 'Aspect ratio of the creative asset expressed as width:height (e.g., 16:9, 1:1, 4:3). Used for responsive ad placement and social media platform compliance.. Valid values are `^[0-9]+:[0-9]+$`',
    `brand_compliance_status` STRING COMMENT 'Indicates whether the creative asset has been reviewed and confirmed to meet corporate brand guidelines, including logo usage, color palette, typography, and fair housing statement requirements.. Valid values are `compliant|non_compliant|under_review|waived`',
    `call_to_action` STRING COMMENT 'The primary call-to-action (CTA) instruction embedded in the creative asset. Used to measure conversion intent alignment and to standardize CTA taxonomy across campaigns. [ENUM-REF-CANDIDATE: schedule_tour|contact_agent|view_listing|download_brochure|request_info|apply_now|learn_more|get_quote — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this creative asset record was first created in the system. Serves as the RECORD_AUDIT_CREATED field for this master resource. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `creative_code` STRING COMMENT 'Externally-known unique business code assigned to the creative asset for cross-system reference, DAM cataloguing, and agency handoff (e.g., MKT-PROP001-001). Serves as the BUSINESS_IDENTIFIER for this master resource.. Valid values are `^[A-Z]{2,6}-[A-Z0-9]{4,12}-[0-9]{3}$`',
    `creative_name` STRING COMMENT 'Human-readable name or title of the creative asset as used by the marketing team (e.g., Downtown Tower Q3 Banner 728x90, Luxury Residences Email Header v2).',
    `creative_subtype` STRING COMMENT 'Granular classification of the creative asset within its format type, specific to real estate marketing use cases. [ENUM-REF-CANDIDATE: listing_photo|virtual_tour|brochure|video_walkthrough|banner_ad|email_template|social_graphic|signage_artwork|floor_plan|aerial_photo|site_plan|renderings — promote to reference product]',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Duration of the creative asset in seconds. Applicable to video and audio format types. Used to validate platform-specific length requirements (e.g., 15s, 30s, 60s pre-roll) and broadcast standards.',
    `effective_start_date` DATE COMMENT 'Date from which the creative asset is authorized for use in active campaigns. Assets must not be deployed before this date. Aligns with campaign flight dates and property listing go-live schedules.',
    `expiry_date` DATE COMMENT 'Date after which the creative asset must be retired from active use. Triggered by property sale/lease completion, campaign end, pricing changes, or brand refresh cycles. Prevents use of outdated or non-compliant materials.',
    `fair_housing_compliant` BOOLEAN COMMENT 'Indicates whether the creative asset includes the required Equal Housing Opportunity (EHO) logo or statement as mandated by the Fair Housing Act. Critical compliance flag for all residential marketing materials.',
    `file_size_kb` DECIMAL(18,2) COMMENT 'Size of the creative asset file in kilobytes (KB). Used to enforce channel-specific file size limits (e.g., email max 200KB, display ad max 150KB) and to manage DAM storage capacity.',
    `file_url` STRING COMMENT 'Fully qualified URL or Digital Asset Management (DAM) system reference path to the source file of the creative asset. May be a CDN URL, cloud storage URI, or DAM permalink. Confidential as it exposes internal asset storage infrastructure.',
    `format_type` STRING COMMENT 'Primary format classification of the creative asset. Drives rendering, storage, and delivery logic. [ENUM-REF-CANDIDATE: image|video|pdf|html5|copy|audio|interactive|3d_tour — promote to reference product if additional formats are needed]. Valid values are `image|video|pdf|html5|copy|audio`',
    `headline_copy` STRING COMMENT 'Primary headline or tagline text used in the creative asset. Captured as a business attribute to enable copy performance analysis, A/B testing tracking, and brand compliance review without opening the asset file.',
    `height_px` STRING COMMENT 'Height dimension of the creative asset in pixels. Applicable to image, HTML5, and video formats. Used alongside width_px to confirm IAB standard ad unit compliance.',
    `is_archived` BOOLEAN COMMENT 'Indicates whether the creative asset has been archived and is no longer available for active campaign use. Archived assets are retained for historical reference and compliance audit purposes but excluded from active creative libraries.',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this creative asset is designated as the primary or hero asset for its associated property or campaign. Used to select the default display image in MLS syndication, listing portals, and email campaigns.',
    `language_code` STRING COMMENT 'ISO 639-1 language code of the creative asset content (e.g., en, es, fr, zh-CN). Supports multilingual campaign management and audience targeting for diverse tenant and buyer demographics.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this creative asset record was most recently updated. Tracks the latest change for version control, cache invalidation, and audit purposes. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `mime_type` STRING COMMENT 'IANA MIME type of the creative asset file (e.g., image/jpeg, video/mp4, application/pdf, text/html). Drives rendering engine selection and platform compatibility validation.',
    `platform_target` STRING COMMENT 'Specific platform or publisher for which this creative is sized and formatted (e.g., Instagram, Facebook, Google Display Network, Zillow, CoStar, LoopNet, Realtor.com). Distinct from channel — a social_media channel creative may target Instagram or LinkedIn specifically.',
    `portfolio_scope` STRING COMMENT 'Indicates whether the creative asset is scoped to a single property, a portfolio of properties, a brand-level campaign, or a specific market/geography. Determines the breadth of the creatives applicability.. Valid values are `single_property|portfolio|brand|market`',
    `production_cost` DECIMAL(18,2) COMMENT 'Total cost incurred to produce this creative asset, including agency fees, photography, videography, and design costs. Expressed in the operating currency. Used for marketing Capital Expenditure (CAPEX) and Operating Expenditure (OPEX) tracking and Return on Investment (ROI) analysis.',
    `source_system` STRING COMMENT 'Identifies the originating operational system of record from which this creative asset record was sourced or created. Supports data lineage tracking in the Databricks Silver Layer.. Valid values are `salesforce_crm|yardi_voyager|dam_system|manual_upload|procore|mri_software`',
    `tags_keywords` STRING COMMENT 'Comma-separated list of searchable tags and keywords associated with the creative asset (e.g., luxury, downtown, high-rise, 2BR, pet-friendly). Enables DAM search, campaign targeting, and content taxonomy management.',
    `version_label` STRING COMMENT 'Human-readable semantic version label for the creative asset (e.g., v1.0, v2.3). Used in agency communications and DAM systems alongside the numeric version_number.. Valid values are `^v[0-9]+.[0-9]+(.[0-9]+)?$`',
    `version_number` STRING COMMENT 'Sequential integer version number of the creative asset, incremented each time the asset is revised and re-approved. Enables version history tracking and rollback to prior approved versions.',
    `width_px` STRING COMMENT 'Width dimension of the creative asset in pixels. Applicable to image, HTML5, and video formats. Used to validate IAB standard ad unit dimensions and platform-specific size requirements.',
    CONSTRAINT pk_ad_creative PRIMARY KEY(`ad_creative_id`)
) COMMENT 'Master record for all marketing creative assets used in campaigns — property listing photos, virtual tour links, brochure PDFs, video walkthroughs, banner ads, email templates, social media graphics, and signage artwork. Captures creative name, format (image, video, PDF, HTML5, copy), dimensions or specs, file URL or DAM reference, associated property or portfolio, brand compliance status, approval status, version number, expiry date, and creative performance metadata. SSOT for creative asset inventory.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`listing_syndication` (
    `listing_syndication_id` BIGINT COMMENT 'Unique surrogate identifier for each listing syndication record. Primary key for the marketing.listing_syndication data product.',
    `ad_creative_id` BIGINT COMMENT 'Foreign key linking to marketing.ad_creative. Business justification: A listing syndication to an external portal (Zillow, Realtor.com, CoStar) can use a specific ad creative asset — particularly for featured/paid placements that include custom imagery, virtual tour ass',
    `asset_id` BIGINT COMMENT 'Reference to the property associated with this syndication record, enabling portfolio-level syndication reporting.',
    `building_class_id` BIGINT COMMENT 'Foreign key linking to reference.building_class. Business justification: Listing syndication feeds to CoStar, LoopNet, and MLS include building class. Normalizing property_class to reference.building_class ensures consistent class codes are transmitted to external platform',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Commercial real estate listing syndication (CoStar, LoopNet) operates at the building level. Brokers syndicate building-level availability listings. A domain expert expects listing_syndication to refe',
    `campaign_flight_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_flight. Business justification: A listing syndication record can be executed as part of a specific campaign flight (a discrete burst of campaign activity). listing_syndication already has campaign_id but lacks campaign_flight_id, wh',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that initiated or governs this syndication activity, enabling campaign-level performance attribution.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: listing_syndication tracks syndication to external portals (Zillow, Realtor.com, CoStar). Each portal maps to a marketing channel in the channel master. Adding channel_id FK enables channel-level synd',
    `requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.requirement. Business justification: Listing syndications must satisfy specific compliance requirements (MLS disclosure rules, fair housing advertising mandates, state-specific listing content regulations). Linking listing_syndication to',
    `currency_code_id` BIGINT COMMENT 'ISO 4217 three-letter currency code applicable to the asking price and rent figures published on the target platform (e.g., USD, CAD, GBP).',
    `event_id` BIGINT COMMENT 'Foreign key linking to marketing.event. Business justification: A listing syndication record can be directly associated with a marketing event — most commonly an open house event where the syndicated listing on Zillow, Realtor.com, or MLS portals includes open hou',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Syndicated listings must include jurisdiction-mandated disclosures (e.g., state-specific fair housing language, MLS disclosure rules). Compliance teams validate syndicated listing content against the ',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: Commercial listing syndication feeds (CoStar, LoopNet, CREXi) require lease type classification (NNN, gross, modified gross) as a mandatory field. Lease type drives search filtering on destination pla',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Land and parcel listings are syndicated on platforms like LandWatch and Lands of America. Raw land parcels may not have an asset record. Land sale listing syndication is a named business process requi',
    `listing_id` BIGINT COMMENT 'Reference to the source property listing being syndicated. Links to the canonical listing record in the marketing or brokerage domain.',
    `space_id` BIGINT COMMENT 'Foreign key linking to property.space. Business justification: Commercial RE listing syndication to CoStar and LoopNet is performed at the space/suite level. Each syndicated commercial listing represents a specific leasable space. This link enables space-level sy',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Listing syndication platforms require property type classification for feed routing (residential MLS vs. commercial CoStar/LoopNet). Property type determines syndication channel eligibility, RESO comp',
    `superseded_listing_syndication_id` BIGINT COMMENT 'Self-referencing FK on listing_syndication (superseded_listing_syndication_id)',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: listing_syndication.listing_type is a denormalized text field. Syndication platforms categorize listings by transaction type (for sale, for lease, sublease). This FK enables proper feed routing, compl',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: MLS and portal syndication for residential properties is done at the unit level. Each syndicated listing represents a specific available unit. This link enables unit-level syndication status tracking ',
    `asking_price` DECIMAL(18,2) COMMENT 'The listed asking price for sale listings as published on the target platform. Expressed in the operating currency. May be overridden per platform.',
    `asking_rent_psf` DECIMAL(18,2) COMMENT 'The advertised rental rate expressed as a Per Square Foot (PSF) annual or monthly figure for lease listings. Used for market comparability and CoStar/LoopNet feed requirements.',
    `available_sqft` DECIMAL(18,2) COMMENT 'The total available square footage (SQF) of the space being marketed on the target platform. For partial-floor or suite listings, reflects the specific available area rather than the total building size.',
    `click_count` BIGINT COMMENT 'Total number of user click-throughs on the syndicated listing on the target platform. Used for engagement rate calculation and lead attribution analysis.',
    `compliance_verified` BOOLEAN COMMENT 'Indicates whether the syndicated listing has been reviewed and confirmed compliant with applicable fair housing, advertising, and platform-specific content policies prior to publication.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this syndication record was first created in the system. Serves as the audit trail creation marker per SOX and data governance requirements.',
    `days_on_market` STRING COMMENT 'Number of calendar days the listing has been live on the target platform since the publish_date. A key real estate market performance indicator tracked per platform.',
    `error_message` STRING COMMENT 'The error message or rejection reason returned by the target platform when syndication_status is error. Used for operational troubleshooting and feed quality management.',
    `expiry_date` DATE COMMENT 'The date on which the syndication is scheduled to expire or be automatically removed from the target platform. Null indicates an open-ended syndication.',
    `fair_housing_compliant` BOOLEAN COMMENT 'Indicates whether the listing content (description, photos, targeting) has been verified as compliant with the Fair Housing Act, prohibiting discriminatory advertising language or targeting.',
    `featured_listing` BOOLEAN COMMENT 'Indicates whether this listing is designated as a featured or premium placement on the target platform, typically associated with additional advertising spend.',
    `feed_type` STRING COMMENT 'Technical protocol or method used to deliver the listing data to the target platform. RETS = Real Estate Transaction Standard; RESO_WEB_API = RESO Web API; IDX = Internet Data Exchange; MANUAL = human-entered; FTP = file-based transfer; DIRECT_API = proprietary platform API.. Valid values are `RETS|RESO_WEB_API|IDX|MANUAL|FTP|DIRECT_API`',
    `idx_feed_code` STRING COMMENT 'The Internet Data Exchange (IDX) feed identifier used when syndicating via IDX protocol. Enables tracking of IDX-specific feed configurations and broker reciprocity agreements.',
    `impression_count` BIGINT COMMENT 'Total number of times the syndicated listing has been displayed to users on the target platform. Retrieved via platform API or reporting feed for campaign performance measurement.',
    `last_sync_timestamp` TIMESTAMP COMMENT 'The most recent date and time at which the listing data was successfully synchronized or refreshed on the target platform via the configured feed type.',
    `lead_count` STRING COMMENT 'Number of inbound leads (inquiries, contact form submissions, or calls) generated from this syndicated listing on the target platform. Key metric for lead attribution and channel ROI.',
    `listing_description` STRING COMMENT 'The marketing description text published on the target platform for this listing. May be a platform-specific override of the master listing description.',
    `listing_title` STRING COMMENT 'The headline or title of the listing as published on the target platform. May differ from the internal listing name due to platform-specific character limits or SEO optimization.',
    `mls_number` STRING COMMENT 'The Multiple Listing Service (MLS) identifier assigned to this listing when syndicated to an MLS-affiliated platform. Required for NAR-compliant MLS submissions.',
    `next_sync_timestamp` TIMESTAMP COMMENT 'The scheduled date and time for the next automated data synchronization push to the target platform. Used by the feed scheduler to manage sync cadence.',
    `override_active` BOOLEAN COMMENT 'Indicates whether platform-specific field overrides (e.g., custom title, description, price) are active for this syndication record, superseding the master listing values.',
    `override_notes` STRING COMMENT 'Free-text notes documenting the reason for platform-specific field overrides, such as character limit compliance, SEO adjustments, or platform policy requirements.',
    `paid_placement` BOOLEAN COMMENT 'Indicates whether this syndication involves a paid advertising placement (e.g., sponsored listing, premium slot) on the target platform, as opposed to a standard free syndication.',
    `photo_count` STRING COMMENT 'Number of photos included in the syndicated listing on the target platform. Platforms often have minimum photo requirements; this field supports compliance monitoring.',
    `placement_cost` DECIMAL(18,2) COMMENT 'The advertising or placement cost incurred for this syndication on the target platform. Applicable when paid_placement is true. Used for marketing spend tracking and ROI analysis.',
    `platform_name` STRING COMMENT 'Name of the external marketing portal or platform to which the listing is syndicated (e.g., Zillow, Realtor.com, LoopNet, CoStar, Apartments.com, MLS). [ENUM-REF-CANDIDATE: Zillow|Realtor.com|LoopNet|CoStar|Apartments.com|MLS|Homes.com|Trulia|Redfin|CREXi|Ten-X|proprietary — promote to reference product]. Valid values are `Zillow|Realtor.com|LoopNet|CoStar|Apartments.com|MLS`',
    `platform_url` STRING COMMENT 'The publicly accessible URL of the listing on the target platform. Used for link verification, marketing collateral, and click-through tracking.. Valid values are `^https?://[^s]+$`',
    `publish_date` DATE COMMENT 'The date on which the listing was first published live on the target platform. Used for time-on-market calculations and campaign performance reporting.',
    `pull_reason` STRING COMMENT 'Reason code explaining why the listing was pulled from the target platform before expiry. Supports compliance auditing and platform relationship management. [ENUM-REF-CANDIDATE: sold|leased|withdrawn|duplicate|policy_violation|owner_request|other — 7 candidates stripped; promote to reference product]',
    `pulled_date` DATE COMMENT 'The date on which the listing was manually removed or pulled from the target platform prior to its scheduled expiry. Populated only when syndication_status is pulled.',
    `syndication_ref` STRING COMMENT 'Externally-known business identifier for this syndication record, used for cross-system reconciliation and support tickets (e.g., SYN-2024-00123).',
    `syndication_source_system` STRING COMMENT 'The operational system of record from which the listing data originates for this syndication (e.g., Yardi Voyager, MRI Software, CoStar Suite, Salesforce CRM, or manual entry).. Valid values are `Yardi|MRI|CoStar|Salesforce|Manual|Proprietary`',
    `syndication_status` STRING COMMENT 'Current lifecycle state of the syndication record on the target platform. pending = submitted but not yet confirmed live; live = actively published; expired = past expiry date; pulled = manually removed; error = feed or API failure; paused = temporarily suspended.. Valid values are `pending|live|expired|pulled|error|paused`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this syndication record was last modified. Used for incremental data pipeline processing and audit trail maintenance.',
    `virtual_tour_url` STRING COMMENT 'URL of the virtual tour or 3D walkthrough associated with this syndicated listing. Included in the platform feed when available to enhance listing engagement.. Valid values are `^https?://[^s]+$`',
    CONSTRAINT pk_listing_syndication PRIMARY KEY(`listing_syndication_id`)
) COMMENT 'Transactional record tracking the syndication of a property listing to external marketing portals and platforms — Zillow, Realtor.com, LoopNet, CoStar, Apartments.com, MLS, and proprietary websites. Captures listing reference, target platform, syndication status (pending, live, expired, pulled), publish date, expiry date, listing URL on platform, feed type (RETS, RESO Web API, IDX, manual), last sync timestamp, and any platform-specific override fields. Distinct from brokerage.mls_syndication which is brokerage-owned; this entity is marketing-owned for campaign-driven syndication.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`lead` (
    `lead_id` BIGINT COMMENT 'Unique system-generated identifier for each inbound marketing lead record. Primary key for the marketing.lead data product.',
    `asset_id` BIGINT COMMENT 'Reference to the specific property the lead expressed interest in, used for property-level lead funnel reporting.',
    `broker_id` BIGINT COMMENT 'Foreign key linking to brokerage.brokerage_broker. Business justification: Lead routing and broker assignment is a named CRM workflow in real estate: leads are assigned to specific agents for follow-up, and agent conversion rates by lead source are a standard performance rep',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that generated this lead, enabling campaign attribution and ROI analysis.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: lead.channel is a STRING denoting the marketing channel through which the lead was generated. Normalizing to channel_id FK links the lead to the authoritative channel master, enabling channel-level le',
    `investor_id` BIGINT COMMENT 'Foreign key linking to investment.investor. Business justification: When a marketing lead (prospective LP) converts to a committed investor, linking the lead to the investor record enables full-funnel tracking from first marketing touch to capital commitment — a stand',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: In new development sales, leads are captured on pre-sales interest lists tied to specific projects. Linking lead to dev_project enables sales velocity reporting by project, absorption rate tracking, a',
    `fund_id` BIGINT COMMENT 'Foreign key linking to investment.fund. Business justification: Capital raise teams track prospective LP investor leads against specific funds for fundraising pipeline management and investor relations reporting. This is a named business process in real estate fun',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Lead qualification in real estate requires a normalized geographic preference for broker routing, market demand analysis, and pipeline reporting by submarket. Normalizing preferred_location enables ge',
    `industry_classification_id` BIGINT COMMENT 'Foreign key linking to reference.industry_classification. Business justification: Commercial real estate tenant leads are classified by industry (NAICS/SIC/GICS) for space matching, co-tenancy compliance, and anchor tenant analysis. Leasing teams and brokers require industry classi',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: Leasing teams qualify leads by preferred lease structure (NNN vs. gross). This FK enables CRM pipeline reporting by lease type, supports matching leads to available spaces, and drives targeted follow-',
    `listing_syndication_id` BIGINT COMMENT 'Foreign key linking to marketing.listing_syndication. Business justification: A lead can be directly attributed to a specific listing syndication record (e.g., a prospect who clicked on a Zillow or Realtor.com syndicated listing). lead already has campaign_id and channel_id but',
    `master_lead_id` BIGINT COMMENT 'Reference to the canonical (master) lead record when is_duplicate = True. Enables deduplication merge tracking and ensures analytics roll up to the correct master record.',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Land sale leads (buyers interested in a specific parcel) are a distinct business process in real estate brokerage. lead has asset_id but raw land parcels may not have an asset record. Land acquisition',
    `primary_duplicate_lead_id` BIGINT COMMENT 'Self-referencing FK on lead (duplicate_lead_id)',
    `space_id` BIGINT COMMENT 'Foreign key linking to property.space. Business justification: Commercial leasing leads are tracked against specific spaces of interest. Brokers manage pipeline by space to avoid double-booking tours and to report space-level demand. This link is fundamental to c',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Lead qualification and pipeline reporting in CRE requires segmenting leads by property type interest (office, retail, multifamily). Normalizing enables broker assignment routing and conversion rate an',
    `uom_id` BIGINT COMMENT 'Foreign key linking to reference.uom. Business justification: lead.size_requirement_min_sqf and size_requirement_max_sqf are area measurements. International leads may specify requirements in sqm. A size_uom_id FK enables proper unit conversion when matching lea',
    `space_use_type_id` BIGINT COMMENT 'Foreign key linking to reference.space_use_type. Business justification: Commercial leasing leads are qualified by space use type (medical office, retail, industrial flex). This FK enables lead routing to specialized brokers, co-tenancy compliance checks, and targeted camp',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Lead qualification in real estate requires knowing whether a prospect is interested in buying, leasing, or investing. Normalizing transaction_type_interest enables pipeline reporting and broker routin',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: Residential leasing CRM tracks which specific unit a prospect inquired about. Unit-level lead tracking drives follow-up workflows, availability management, and conversion-to-lease reporting. A leasing',
    `budget_max` DECIMAL(18,2) COMMENT 'Maximum financial budget the lead has indicated for the transaction (purchase price or annual rent), expressed in the operating currency. Used for property matching and lead qualification.',
    `budget_min` DECIMAL(18,2) COMMENT 'Minimum financial budget the lead has indicated for the transaction (purchase price or annual rent), expressed in the operating currency. Used for property matching and lead qualification.',
    `company_name` STRING COMMENT 'Name of the organization or company the lead represents, relevant for commercial real estate (CRE) tenant and investor leads.',
    `conversion_date` DATE COMMENT 'The date on which the lead was converted to a prospect, deal, or tenant record. Populated only when lead_status = converted. Used to calculate lead-to-conversion cycle time.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the lead record was first created in the system, representing the moment the inbound inquiry was captured. Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `desired_move_in_date` DATE COMMENT 'The target date by which the lead wishes to occupy or close on the property. Used for urgency scoring and inventory availability matching.',
    `disqualification_reason` STRING COMMENT 'Reason the lead was marked as disqualified (e.g., budget mismatch, no longer interested, duplicate, outside service area). Populated only when lead_status = disqualified. Used for funnel analysis and source quality improvement.',
    `do_not_contact` BOOLEAN COMMENT 'Indicates whether the lead has opted out of all marketing and sales communications. When True, no outbound contact should be initiated. Required for GDPR and CAN-SPAM compliance.',
    `email` STRING COMMENT 'Primary email address of the lead contact, used for follow-up communications and CRM deduplication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_contact_date` DATE COMMENT 'The date on which the first outbound contact attempt was made to the lead by an agent or leasing representative. Used to measure response time SLA compliance.',
    `first_name` STRING COMMENT 'First (given) name of the individual who submitted the lead inquiry.',
    `gdpr_consent` BOOLEAN COMMENT 'Indicates whether the lead has provided explicit consent for data processing and marketing communications under GDPR. Mandatory for leads originating from EU/EEA jurisdictions.',
    `gdpr_consent_date` DATE COMMENT 'The date on which the lead provided GDPR consent. Required for audit trail and consent expiry management under GDPR Article 7.',
    `grade` STRING COMMENT 'Qualitative grade (A–D) assigned to the lead based on overall qualification assessment. A = highly qualified, D = low probability. Complements the numeric lead_score for agent prioritization.. Valid values are `A|B|C|D`',
    `is_duplicate` BOOLEAN COMMENT 'Indicates whether this lead record has been identified as a duplicate of another lead in the system. Used for data quality management and deduplication workflows in Salesforce CRM.',
    `last_activity_date` DATE COMMENT 'The date of the most recent interaction or activity recorded against this lead (call, email, showing, note). Used to identify stale leads and trigger re-engagement workflows.',
    `last_name` STRING COMMENT 'Last (family) name of the individual who submitted the lead inquiry.',
    `lead_number` STRING COMMENT 'Human-readable, externally referenceable business identifier for the lead (e.g., LD-202400012345). Used in correspondence, CRM, and reporting.. Valid values are `^LD-[0-9]{8,12}$`',
    `lead_source` STRING COMMENT 'The originating channel or mechanism through which the lead was generated (e.g., Zillow portal, open house sign-in, social media DM). Used for channel attribution and marketing spend analysis. [ENUM-REF-CANDIDATE: web_inquiry|portal|email|open_house|social_media|referral|event|direct — promote to reference product]',
    `lead_status` STRING COMMENT 'Current lifecycle state of the lead within the marketing and sales funnel. Drives CRM workflow automation and pipeline reporting. [ENUM-REF-CANDIDATE: new|contacted|qualified|disqualified|converted|nurturing|lost — promote to reference product]',
    `lead_type` STRING COMMENT 'Classification of the leads intent and role in the real estate transaction. Drives routing logic and follow-up workflows. [ENUM-REF-CANDIDATE: buyer|tenant|investor|seller|landlord|other — promote to reference product]. Valid values are `buyer|tenant|investor|seller|landlord|other`',
    `notes` STRING COMMENT 'Free-text field capturing additional context, special requirements, or agent observations about the lead that do not fit structured fields (e.g., Needs ground-floor access, Relocating from NYC).',
    `phone` STRING COMMENT 'Primary contact phone number for the lead, used for outbound follow-up calls by leasing or sales agents.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `referral_source_name` STRING COMMENT 'Name of the individual, broker, or organization that referred this lead when lead_source = referral. Used for referral partner tracking and commission attribution.',
    `score` STRING COMMENT 'Numeric score (typically 0–100) assigned to the lead based on qualification criteria such as budget, timeline, engagement level, and source quality. Used to prioritize agent follow-up and predict conversion likelihood.',
    `size_requirement_max_sqf` STRING COMMENT 'Maximum space requirement expressed in square feet (SQF) as stated by the lead. Used for property matching against available GLA/NLA inventory.',
    `size_requirement_min_sqf` STRING COMMENT 'Minimum space requirement expressed in square feet (SQF) as stated by the lead. Used for property matching against available GLA/NLA inventory.',
    `source_portal` STRING COMMENT 'Specific third-party listing portal or platform from which the lead originated when lead_source is portal (e.g., Zillow, CoStar, LoopNet). Enables portal-level ROI and lead quality benchmarking. [ENUM-REF-CANDIDATE: zillow|costar|loopnet|realtor_com|apartments_com|crexi|mls|other — promote to reference product]',
    `source_system` STRING COMMENT 'The operational system of record from which this lead record originated (e.g., Salesforce CRM, portal API, manual entry). Used for data lineage tracking in the Silver Layer. [ENUM-REF-CANDIDATE: salesforce|yardi|mri|building_engines|manual|portal_api|other — 7 candidates stripped; promote to reference product]',
    `source_system_lead_code` STRING COMMENT 'The native identifier of this lead record in the originating source system (e.g., Salesforce Lead ID 00Q...). Used for cross-system reconciliation and data lineage.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the lead record was most recently modified. Used for incremental data pipeline processing and audit trail in the Databricks Silver Layer.',
    `utm_campaign` STRING COMMENT 'Urchin Tracking Module (UTM) campaign name parameter captured from the inbound URL. Links the digital lead directly to a specific marketing campaign for spend attribution.',
    `utm_medium` STRING COMMENT 'Urchin Tracking Module (UTM) medium parameter captured from the inbound URL (e.g., cpc, organic, email, social). Used alongside utm_source for digital campaign attribution.',
    `utm_source` STRING COMMENT 'Urchin Tracking Module (UTM) source parameter captured from the inbound URL when the lead originated from a digital channel (e.g., google, facebook, email_newsletter). Enables granular digital attribution.',
    CONSTRAINT pk_lead PRIMARY KEY(`lead_id`)
) COMMENT 'SSOT master record for every inbound marketing lead generated across all channels — web inquiries, portal leads (Zillow, CoStar, LoopNet), email responses, open house sign-ins, social media DMs, referral submissions, and event registrations. Captures lead source, channel, campaign attribution, lead type (buyer, tenant, investor, seller), property of interest, contact details, lead status (new, contacted, qualified, disqualified, converted), lead score, assigned agent or leasing rep, first contact date, and last activity date. Distinct from brokerage.prospect (brokerage-owned pipeline) and tenant.prospect (tenancy-specific).';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`lead_activity` (
    `lead_activity_id` BIGINT COMMENT 'Unique surrogate identifier for each discrete lead activity or touchpoint record in the marketing domain. Primary key for the lead_activity data product.',
    `ad_creative_id` BIGINT COMMENT 'Foreign key linking to marketing.ad_creative. Business justification: A lead activity touchpoint (e.g., a banner ad click, a display ad view) can be attributed to a specific ad creative asset. Adding ad_creative_id to lead_activity enables precise creative-level attribu',
    `asset_id` BIGINT COMMENT 'Reference to the property listing or asset that the lead activity is associated with, such as a portal page view of a specific listing or a call inquiry about a property.',
    `campaign_flight_id` BIGINT COMMENT 'Reference to the specific campaign flight or ad flight within a campaign, representing a time-bounded execution window. Enables granular attribution to a specific flight period.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign under which this activity was generated. Supports campaign-level attribution modeling and spend analysis.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: lead_activity.channel is a STRING. Each lead activity touchpoint occurs through a specific marketing channel. Normalizing to channel_id FK links the activity to the authoritative channel master, enabl',
    `event_id` BIGINT COMMENT 'Foreign key linking to marketing.event. Business justification: A lead activity can represent an event-related touchpoint — such as attending an open house, checking in at a property tour event, or participating in a virtual investor briefing. Adding event_id to l',
    `event_registration_id` BIGINT COMMENT 'Foreign key linking to marketing.event_registration. Business justification: A lead activity can be specifically tied to an event registration action (e.g., the act of registering for an open house is a discrete lead touchpoint). Linking lead_activity to event_registration ena',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Lead activity attribution in real estate is segmented by geographic market for channel effectiveness reporting. Normalizing enables market-level funnel analysis and identification of high-demand subma',
    `lead_id` BIGINT COMMENT 'Reference to the marketing lead associated with this activity. Links the touchpoint back to the originating prospect or inquiry record tracked in Salesforce CRM.',
    `listing_id` BIGINT COMMENT 'Reference to the specific property listing (MLS or internal) that triggered or is associated with this lead activity. Supports listing-level lead attribution and conversion funnel analysis.',
    `listing_syndication_id` BIGINT COMMENT 'Foreign key linking to marketing.listing_syndication. Business justification: A lead activity (e.g., a click, a form submission, a virtual tour view) can be attributed to a specific listing syndication record. This enables tracking which syndicated listing portal touchpoints dr',
    `parent_lead_activity_id` BIGINT COMMENT 'Self-referencing FK on lead_activity (parent_lead_activity_id)',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Lead activity attribution and funnel analysis in real estate is segmented by property type. Marketing teams report engagement rates and conversion events by property type to optimize channel spend.',
    `space_id` BIGINT COMMENT 'Foreign key linking to property.space. Business justification: Commercial leasing prospect space tours and RFP responses are tracked at the specific space level. Leasing pipeline reports and broker commission calculations require knowing which space a prospect to',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Lead activity attribution reporting requires transaction type context (sale vs. lease conversion events). Marketing teams measure funnel conversion rates by transaction type to optimize channel spend ',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: Residential leasing prospect tracking requires recording which specific unit a prospect toured, applied for, or inquired about. Unit-level lead activity tracking drives leasing velocity reports and co',
    `activity_direction` STRING COMMENT 'Indicates whether the activity was initiated by the lead (inbound, e.g., a form submission or portal page view) or by the agent/system (outbound, e.g., an email send or call attempt). Critical for distinguishing lead-initiated engagement from agent-driven nurture.. Valid values are `inbound|outbound`',
    `activity_status` STRING COMMENT 'Current lifecycle state of the activity record, indicating whether the touchpoint was successfully completed, attempted but not delivered, failed, or is pending execution.. Valid values are `completed|attempted|failed|pending|cancelled`',
    `activity_timestamp` TIMESTAMP COMMENT 'The precise date and time (with timezone offset) at which the lead activity or touchpoint occurred. This is the principal real-world event time used for funnel sequencing, nurture cadence analysis, and time-to-conversion calculations.',
    `activity_type` STRING COMMENT 'Categorical classification of the discrete touchpoint or interaction recorded. Drives funnel stage analysis and channel attribution. [ENUM-REF-CANDIDATE: email_open|link_click|portal_page_view|call_attempt|sms_response|chatbot_interaction|form_submission — promote to reference product]',
    `attribution_model` STRING COMMENT 'The marketing attribution model applied to this activity for credit assignment in conversion analysis (e.g., first touch, last touch, linear, time decay, position-based). Supports multi-touch attribution reporting.. Valid values are `first_touch|last_touch|linear|time_decay|position_based`',
    `attribution_weight` DECIMAL(18,2) COMMENT 'The fractional credit weight (0.0000 to 1.0000) assigned to this activity under the applied attribution model. Used in multi-touch attribution calculations to distribute conversion credit across touchpoints.',
    `call_duration_seconds` STRING COMMENT 'The duration in seconds of a phone call activity, applicable when activity_type is call_attempt. Used to assess call quality, agent engagement depth, and lead qualification effectiveness.',
    `channel_subtype` STRING COMMENT 'Further classification of the marketing channel, such as distinguishing between organic search, paid search, display advertising, or social platform (e.g., Facebook, LinkedIn) within the broader channel category.',
    `consent_status` STRING COMMENT 'The consent status of the lead for marketing communications at the time of this activity, as required under GDPR and applicable privacy regulations. Ensures only consented leads receive outbound marketing activities.. Valid values are `granted|withdrawn|not_required|pending`',
    `content_reference` STRING COMMENT 'Identifier or URL of the content asset, page, or listing that was viewed, clicked, or interacted with during this activity (e.g., a property listing URL, email template ID, or landing page path). Supports content performance analysis.',
    `content_type` STRING COMMENT 'Classification of the content asset or page involved in the activity (e.g., listing page, email template, landing page, virtual tour). Enables content-level engagement analytics. [ENUM-REF-CANDIDATE: listing_page|email_template|landing_page|brochure|video|virtual_tour|floor_plan — promote to reference product]',
    `conversion_type` STRING COMMENT 'When is_conversion_event is true, classifies the type of conversion achieved (e.g., showing request, Letter of Intent (LOI) submitted, lease inquiry, purchase inquiry). Enables conversion type analysis by channel and campaign. [ENUM-REF-CANDIDATE: showing_request|loi_submitted|lease_inquiry|purchase_inquiry|callback_booked|tour_scheduled — promote to reference product]. Valid values are `showing_request|loi_submitted|lease_inquiry|purchase_inquiry|callback_booked|tour_scheduled`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this lead activity record was first created in the system. Serves as the audit creation timestamp for data lineage, SOX compliance, and record management purposes.',
    `device_type` STRING COMMENT 'The type of device used by the lead when the activity occurred (e.g., desktop, mobile, tablet). Supports device-level engagement analysis and responsive marketing optimization.. Valid values are `desktop|mobile|tablet|unknown`',
    `email_subject` STRING COMMENT 'The subject line of the email associated with this activity, applicable when activity_type is email_open or link_click. Supports email content performance analysis and A/B testing evaluation.',
    `form_name` STRING COMMENT 'The name or identifier of the web form submitted during a form_submission activity (e.g., Contact Agent Form, Schedule a Tour, Request Brochure). Supports form-level conversion analysis.',
    `funnel_stage` STRING COMMENT 'The marketing and sales funnel stage at which this activity occurred, enabling conversion funnel analysis and stage-level attribution modeling. Aligned with the lead nurture journey from awareness through conversion.. Valid values are `awareness|interest|consideration|intent|evaluation|conversion`',
    `is_conversion_event` BOOLEAN COMMENT 'Indicates whether this activity represents a conversion event (e.g., a form submission that resulted in a qualified lead, a showing request, or a signed Letter of Intent). Used to identify conversion touchpoints in funnel analysis.',
    `lead_score_at_activity` STRING COMMENT 'The numeric lead score assigned to the lead at the time this activity was recorded, as calculated by the CRM or marketing automation platform. Captures the point-in-time score for trend analysis and nurture effectiveness measurement.',
    `next_action` STRING COMMENT 'The next recommended or scheduled follow-up action for the lead as determined by the agent or CRM automation following this activity (e.g., Schedule showing, Send brochure, Follow-up call in 3 days).',
    `next_action_due_date` DATE COMMENT 'The scheduled date by which the next follow-up action should be completed. Used for lead nurture cadence management and agent task scheduling.',
    `opt_out_flag` BOOLEAN COMMENT 'Indicates whether this activity resulted in or was associated with the lead opting out of marketing communications. Critical for compliance with CAN-SPAM, GDPR, and TCPA regulations governing marketing consent.',
    `outcome` STRING COMMENT 'The result or disposition of the activity, indicating how the lead responded or what occurred as a result of the touchpoint (e.g., engaged, no response, bounced, opted out, converted). Drives lead scoring and funnel stage transitions. [ENUM-REF-CANDIDATE: engaged|no_response|bounced|opted_out|converted|disqualified — promote to reference product]. Valid values are `engaged|no_response|bounced|opted_out|converted|disqualified`',
    `outcome_notes` STRING COMMENT 'Free-text notes recorded by the agent or system describing the qualitative result of the activity, such as voicemail left, callback requested, or specific objection raised by the prospect.',
    `page_view_duration_seconds` STRING COMMENT 'The time in seconds the lead spent viewing a portal page or listing during a portal_page_view activity. Indicates engagement depth with a specific property listing or content asset.',
    `performer_type` STRING COMMENT 'Classifies whether the activity was performed by a human agent, an automated system, a chatbot, or the prospect themselves. Distinguishes human-initiated nurture from automated marketing sequences.. Valid values are `agent|system|chatbot|prospect`',
    `sequence_number` STRING COMMENT 'The ordinal position of this activity within the leads overall touchpoint sequence, enabling chronological ordering of the full lead journey and nurture cadence analysis.',
    `session_code` STRING COMMENT 'The web or app session identifier associated with this activity, used to group multiple touchpoints within a single browsing session for session-level engagement analysis and journey mapping.',
    `source_activity_ref` STRING COMMENT 'The native identifier of this activity record in the originating source system (e.g., Salesforce Task ID, Yardi activity reference). Enables traceability and reconciliation back to the system of record.',
    `source_system` STRING COMMENT 'The operational system of record from which this activity record originated (e.g., Salesforce CRM, Yardi Voyager, CoStar). Supports data lineage tracking and cross-system reconciliation.. Valid values are `salesforce_crm|yardi_voyager|mri_software|costar|building_engines|manual`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this lead activity record was last modified. Supports incremental data loading, audit trails, and change detection in the Databricks Silver Layer pipeline.',
    `utm_campaign` STRING COMMENT 'The Urchin Tracking Module (UTM) campaign parameter captured from the URL, identifying the specific campaign name or code associated with the digital activity. Enables campaign-level digital attribution.',
    `utm_medium` STRING COMMENT 'The Urchin Tracking Module (UTM) medium parameter captured from the URL, identifying the marketing medium (e.g., cpc, email, organic, social). Complements utm_source for full digital attribution.',
    `utm_source` STRING COMMENT 'The Urchin Tracking Module (UTM) source parameter captured from the URL at the time of the activity, identifying the traffic source (e.g., google, zillow, loopnet, newsletter). Standard digital marketing attribution parameter.',
    CONSTRAINT pk_lead_activity PRIMARY KEY(`lead_activity_id`)
) COMMENT 'Transactional record capturing every discrete activity or touchpoint associated with a marketing lead — email opens, link clicks, portal page views, call attempts, SMS responses, chatbot interactions, and form submissions. Captures lead reference, activity type, activity timestamp, channel, campaign flight reference, content or page viewed, outcome, and agent or system that performed the action. Enables lead nurture tracking, attribution modeling, and conversion funnel analysis.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`market_research` (
    `market_research_id` BIGINT COMMENT 'Unique system-generated identifier for each market research record. Primary key for the market_research data product.',
    `uom_id` BIGINT COMMENT 'Foreign key linking to reference.uom. Business justification: Market research reports track net_absorption_sqft, new_supply_sqft, total_inventory_sqft. International research requires explicit UOM to distinguish sqft from sqm. Role-prefixed area_uom_id clarifi',
    `asset_id` BIGINT COMMENT 'Foreign key linking to property.asset. Business justification: Market research reports are frequently commissioned for specific assets (pre-acquisition feasibility, lease-up strategy, disposition support). Asset managers expect research to be retrievable by asset',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Market research reports for international real estate portfolios are scoped by country. Normalizing country_code enables joining research data with country-level attributes (REIT framework, foreign ow',
    `currency_code_id` BIGINT COMMENT 'ISO 4217 three-letter currency code applicable to all monetary metrics reported in the research study (e.g., USD, GBP, EUR). Ensures consistent financial interpretation across multi-market research assets.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Feasibility and absorption studies are commissioned to support go/no-go decisions on specific development projects. Development analysts expect market research records to be traceable to the dev_proje',
    `fund_id` BIGINT COMMENT 'Foreign key linking to investment.fund. Business justification: Market research commissioned to support fund-level investment strategy decisions (new market entry, sector allocation) must be traceable to the commissioning fund. Fund managers use this research in I',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Market research reports are fundamentally geographic — vacancy rates, absorption, and cap rates are reported by submarket or MSA. Normalizing to geographic_hierarchy enables joining research data with',
    `investment_deal_id` BIGINT COMMENT 'Foreign key linking to investment.investment_deal. Business justification: Deal teams commission market research during acquisition due diligence and disposition analysis — a named business process in real estate investment. Linking research to investment_deal enables deal-l',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: Market research reports in real estate are scoped by lease type (e.g., NNN investment sales vs. gross lease office absorption reports). Research teams and investment advisors depend on lease type clas',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to reference.market_segment. Business justification: Market research reports are scoped to investment market segments (institutional core vs. opportunistic). Fund managers and investment committees require market segment classification to validate resea',
    `owner_id` BIGINT COMMENT 'Foreign key linking to owner.owner. Business justification: Market research in real estate is routinely commissioned by specific owners for acquisition, disposition, or portfolio valuation decisions. Linking research to the commissioning owner enables owner-le',
    `portfolio_asset_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio_asset. Business justification: Asset managers commission market research to support hold/sell/reposition decisions on specific portfolio assets. Linking research directly to portfolio_asset enables asset-level due diligence trackin',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: Portfolio managers commission submarket research to evaluate expansion, repositioning, or disposition strategies for specific portfolios. This is a named business process in real estate investment man',
    `primary_superseded_by_market_research_id` BIGINT COMMENT 'Reference to the market_research_id of the newer research record that supersedes or replaces this study. Enables version chaining and ensures users are directed to the most current market intelligence.',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Market research reports (vacancy, absorption, cap rates) are fundamentally scoped to a property type. Normalizing enables cross-report aggregation and comparison against reference benchmarks like cap_',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to finance.reporting_period. Business justification: Market research reports (quarterly cap rate surveys, absorption studies) are produced for specific fiscal reporting periods. Finance teams consume period-aligned market research for NOI underwriting a',
    `space_use_type_id` BIGINT COMMENT 'Foreign key linking to reference.space_use_type. Business justification: Market research reports are frequently scoped to a specific space use type (e.g., life science vs. traditional office). Research teams and asset managers require this dimension to produce targeted inv',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Market research reports are scoped to transaction types (investment sales market report vs. leasing activity report). Research teams and investment advisors produce separate reports by transaction typ',
    `avg_asking_rent_psf` DECIMAL(18,2) COMMENT 'Average asking rent per square foot (PSF) for the subject market or submarket as reported in the research study. Expressed in the local currency. Core metric for rent benchmarking and lease negotiation support.',
    `cap_rate` DECIMAL(18,2) COMMENT 'Market or submarket prevailing capitalization rate (CAP Rate) as reported in the research study (e.g., 0.0550 = 5.50%). Used for investment valuation benchmarking and portfolio performance comparison.',
    `commission_cost` DECIMAL(18,2) COMMENT 'Total cost incurred to commission or procure the market research study from a third-party provider. Expressed in the currency defined by currency_code. Used for marketing budget tracking and vendor spend analysis.',
    `competitive_set_count` STRING COMMENT 'Number of comparable or competitive properties included in the research studys competitive set or comparable universe. Indicates the breadth and statistical robustness of the competitive analysis.',
    `confidentiality_level` STRING COMMENT 'Data classification and distribution restriction level assigned to the market research report. Controls access permissions and sharing protocols in accordance with GDPR and internal data governance policies.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the market research record was first created in the data platform. Supports audit trail, data lineage, and SOX compliance requirements.',
    `data_sources` STRING COMMENT 'Comma-separated or narrative description of the primary data sources used in the research study (e.g., CoStar Suite, MLS, Census Bureau, Yardi Voyager). Supports data lineage, reproducibility, and quality assessment.',
    `distribution_list` STRING COMMENT 'Comma-separated list of internal teams, roles, or named stakeholders authorized to receive or access the market research report. Supports information governance and need-to-know access controls.',
    `esg_focus_flag` BOOLEAN COMMENT 'Indicates whether the market research study specifically addresses Environmental, Social, and Governance (ESG) factors such as green building certifications, sustainability metrics, or social impact. True = ESG-focused research.',
    `external_publication_flag` BOOLEAN COMMENT 'Indicates whether the market research report has been approved for external publication or distribution to clients, investors, or the public. True = approved for external release; False = internal use only.',
    `key_findings_summary` STRING COMMENT 'Executive-level narrative summary of the principal findings, conclusions, and market insights from the research study. Enables rapid consumption of intelligence without accessing the full report document.',
    `net_absorption_sqft` DECIMAL(18,2) COMMENT 'Net absorption in square feet (SQF) for the subject market or submarket during the study period. Measures the net change in occupied space and is a primary indicator of market demand health.',
    `new_supply_sqft` DECIMAL(18,2) COMMENT 'Total new construction deliveries in square feet (SQF) completed in the subject market during the study period. Measures supply-side pressure on vacancy and rent levels.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or refresh of the market research study. Ensures market intelligence remains current and triggers renewal workflows for time-sensitive research assets.',
    `peer_reviewed_flag` BOOLEAN COMMENT 'Indicates whether the market research study has undergone formal peer review or quality assurance validation by a qualified analyst or external reviewer. True = peer reviewed; False = not yet reviewed.',
    `provider_name` STRING COMMENT 'Name of the organization or internal team that produced the market research report (e.g., CoStar Group, CBRE Research, Internal Market Intelligence Team). Used for vendor tracking and research attribution.',
    `provider_type` STRING COMMENT 'Indicates whether the market research was produced internally by the marketing team, commissioned from a third-party research firm, or produced jointly. Drives cost attribution and vendor management workflows.. Valid values are `internal|third_party|joint`',
    `publication_status` STRING COMMENT 'Current lifecycle state of the market research report within the publication workflow. Controls visibility and distribution of the research asset across the organization.. Valid values are `draft|under_review|approved|published|archived|withdrawn`',
    `publish_date` DATE COMMENT 'Date on which the market research report was formally published and made available to internal or external stakeholders. Distinct from research_date (data as-of date) and created_timestamp (system record creation).',
    `report_file_url` STRING COMMENT 'Secure URL or cloud storage path to the full market research report document (PDF, XLSX, or presentation). Links to the authoritative source document stored in the document management system.. Valid values are `^https?://.+`',
    `report_format` STRING COMMENT 'File format of the market research report document. Used for document management, rendering, and distribution workflow routing.. Valid values are `PDF|XLSX|PPTX|DOCX|HTML`',
    `research_code` STRING COMMENT 'Externally-known alphanumeric business identifier assigned to the market research engagement (e.g., MR-2024-00123). Used for cross-referencing with CoStar Suite reports, Argus Enterprise studies, and internal filing systems.. Valid values are `^MR-[0-9]{4}-[0-9]{5}$`',
    `research_date` DATE COMMENT 'The principal date on which the market research was conducted, data was collected, or the study period ends. Represents the as-of date for all findings and market metrics within the report.',
    `research_methodology` STRING COMMENT 'Description of the analytical methodology employed in the research study (e.g., Comparable transaction analysis, Survey-based demand study, DCF-based absorption model). Supports reproducibility and peer review.',
    `research_type` STRING COMMENT 'Classification of the market research study by its analytical purpose. Drives filtering and categorization in the market intelligence repository. [ENUM-REF-CANDIDATE: submarket_analysis|competitive_landscape|demand_study|absorption_study|rent_survey|buyer_sentiment — promote to reference product if additional types are needed]. Valid values are `submarket_analysis|competitive_landscape|demand_study|absorption_study|rent_survey|buyer_sentiment`',
    `study_period_end` DATE COMMENT 'End date of the market data observation window covered by the research study. Together with study_period_start, defines the temporal scope of the market analysis.',
    `study_period_start` DATE COMMENT 'Start date of the market data observation window covered by the research study. Used for time-series analysis and trend identification in absorption, rent, and demand studies.',
    `submarket_name` STRING COMMENT 'Specific submarket or neighborhood within the geographic market that is the focus of the research (e.g., Midtown Manhattan, River North). Aligns with CoStar Suite submarket definitions for granular competitive intelligence.',
    `tags` STRING COMMENT 'Free-text comma-separated keywords or topic tags associated with the market research study (e.g., ESG, LEED, sustainability, office, hybrid work). Supports full-text search and thematic categorization in the market intelligence repository.',
    `title` STRING COMMENT 'Full descriptive title of the market research study or report (e.g., Q3 2024 Downtown Office Submarket Absorption Study). Human-readable label used in dashboards, portals, and executive reporting.',
    `total_inventory_sqft` DECIMAL(18,2) COMMENT 'Total rentable building area (RBA) or gross leasable area (GLA) in square feet (SQF) for the subject market or submarket as reported in the research study. Provides market size context for all relative metrics.',
    `under_construction_sqft` DECIMAL(18,2) COMMENT 'Total square footage (SQF) of space currently under construction in the subject market as of the research date. Forward-looking supply pipeline metric used in demand and absorption forecasting.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the market research record was last modified in the data platform. Supports change tracking, audit trail, and data quality monitoring.',
    `vacancy_rate` DECIMAL(18,2) COMMENT 'Market or submarket vacancy rate (as a decimal proportion, e.g., 0.1250 = 12.50%) reported in the research study. Key metric for supply-demand analysis and investment underwriting in CRE markets.',
    `version_number` STRING COMMENT 'Version identifier for the market research report (e.g., 1.0, 2.3). Tracks revisions and updates to the research study over its lifecycle, supporting audit trail and change management.. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_market_research PRIMARY KEY(`market_research_id`)
) COMMENT 'Master record for formal market research studies, competitive intelligence reports, and market analysis engagements commissioned or produced by the marketing team. Captures research title, research type (submarket analysis, competitive landscape, demand study, absorption study, rent survey, buyer sentiment), geographic market or submarket, property type focus, research date, research provider (internal or third-party firm), key findings summary, report file URL, data sources used, and publication status. SSOT for market intelligence assets.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`market_survey` (
    `market_survey_id` BIGINT COMMENT 'Unique system-generated identifier for each market survey record. Primary key for the market_survey data product.',
    `uom_id` BIGINT COMMENT 'Foreign key linking to reference.uom. Business justification: Market surveys report inventory, absorption, and availability in area units (sqft vs sqm). Cross-border and cross-market survey comparisons require explicit UOM tracking. Role-prefixed area_uom_id d',
    `asset_id` BIGINT COMMENT 'Foreign key linking to property.asset. Business justification: Market surveys are commissioned for specific assets to support leasing strategy, rent setting, and investment committee reporting. Linking surveys to the subject asset enables asset-level market intel',
    `building_class_id` BIGINT COMMENT 'Foreign key linking to reference.building_class. Business justification: Market surveys in CRE report rent and vacancy by building class. Normalizing property_class to reference.building_class enables joining survey data with reference class benchmarks for investment under',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Competitive building-level rent surveys (CoStar, CBRE comp sets) are a core commercial real estate market survey process. Surveyors track individual buildings in a competitive set. A domain expert exp',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Market surveys for international real estate require country context for measurement standards, currency, and regulatory reporting. Normalizing country_code enables joining survey data with country-le',
    `currency_code_id` BIGINT COMMENT 'ISO 4217 three-letter currency code in which all monetary survey values (rents, concessions) are denominated (e.g., USD, CAD, GBP). Required for multi-currency portfolio reporting.',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Market surveys are scoped to specific submarkets or MSAs. Normalizing submarket_name and submarket_code to geographic_hierarchy enables time-series market trend analysis and comparison across geograph',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: Market surveys in real estate are segmented by lease structure (NNN, gross, modified gross) to produce comparable rent benchmarks. Analysts and brokers always filter survey data by lease type when pro',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to reference.market_segment. Business justification: Market surveys are segmented by investment strategy (core, value-add, opportunistic) to benchmark cap rates and returns by risk profile. Investment advisors and fund managers require market segment cl',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: Portfolio managers use market surveys to benchmark their portfolios rent, occupancy, and cap rates against market conditions — a standard real estate investment reporting and performance monitoring p',
    `prior_market_survey_id` BIGINT COMMENT 'Self-referencing FK on market_survey (prior_market_survey_id)',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Market surveys (rent, vacancy, absorption) are scoped to a property type. Normalizing enables joining survey data with reference benchmarks (ti_allowance_benchmark_psf, cap_rate_benchmark_pct) for inv',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to finance.reporting_period. Business justification: Market surveys (vacancy rates, asking rents, cap rates) are produced on a periodic basis aligned to fiscal reporting periods. Finance uses survey data for budget assumptions and NOI forecasts; real es',
    `space_use_type_id` BIGINT COMMENT 'Foreign key linking to reference.space_use_type. Business justification: Market surveys segment inventory and absorption by space use type (medical office vs. general office, flex vs. R&D industrial). This is a standard CoStar/CBRE/JLL survey dimension enabling precise sub',
    `availability_rate` DECIMAL(18,2) COMMENT 'Percentage of total rentable square footage that is available for lease, including both vacant space and occupied space being marketed for sublease. Broader than vacancy rate; expressed as a decimal. Used for forward-looking supply analysis.',
    `avg_asking_rent_psf` DECIMAL(18,2) COMMENT 'Weighted or simple average of the quoted/advertised asking rent across all surveyed properties, expressed on a per-square-foot (PSF) annual basis. Represents the gross market asking rate before concessions or negotiation.',
    `avg_concession_value_psf` DECIMAL(18,2) COMMENT 'Average total value of landlord concessions offered per square foot across the surveyed competitive set, including free rent periods (converted to PSF equivalent) and tenant improvement (TI) allowances. Measures the gap between asking and effective rents.',
    `avg_effective_rent_psf` DECIMAL(18,2) COMMENT 'Average net rent actually achievable after accounting for concessions such as free rent periods, tenant improvement (TI) allowances, and other landlord incentives. Reflects true market pricing and is used in Discounted Cash Flow (DCF) and Net Operating Income (NOI) modeling.',
    `avg_free_rent_months` DECIMAL(18,2) COMMENT 'Average number of months of rent abatement (free rent) offered by landlords as a concession across the surveyed competitive set. A key component of the concession package used in effective rent calculations.',
    `avg_lease_term_months` DECIMAL(18,2) COMMENT 'Average lease duration in months for new leases executed in the surveyed competitive set during the survey period. Informs Weighted Average Lease Term (WALT) benchmarking and portfolio duration risk analysis.',
    `avg_ti_allowance_psf` DECIMAL(18,2) COMMENT 'Average Tenant Improvement (TI) allowance offered by landlords per square foot across the surveyed competitive set. TI allowances fund tenant fit-out costs and are a primary negotiating lever in commercial leasing.',
    `cap_rate` DECIMAL(18,2) COMMENT 'Prevailing market Capitalization Rate (CAP Rate) observed in the surveyed submarket for the applicable property type, expressed as a decimal (e.g., 0.0550 = 5.50%). Used for property valuation benchmarking and investment return analysis.',
    `confidence_level` STRING COMMENT 'Qualitative assessment of the reliability and completeness of the survey data, based on sample size, data source quality, and surveyor judgment. High confidence indicates robust sample and verified data; low confidence indicates limited sample or unverified sources.. Valid values are `high|medium|low`',
    `costar_market_code` STRING COMMENT 'CoStar Suites proprietary market or submarket identifier corresponding to the geographic area surveyed. Enables direct cross-referencing with CoStar market analytics, comparable data, and benchmarking reports.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this market survey record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_source` STRING COMMENT 'Primary source from which the market survey data was obtained. Indicates data provenance and reliability tier. CoStar and MLS (Multiple Listing Service) represent third-party verified data; internal represents proprietary field research.. Valid values are `CoStar|internal|broker_survey|third_party|MLS|public_record`',
    `gross_absorption_sqft` DECIMAL(18,2) COMMENT 'Total square footage of all new leases and lease renewals executed in the surveyed competitive set during the survey period, without netting out vacated space. Measures total leasing activity volume.',
    `metro_area` STRING COMMENT 'The Metropolitan Statistical Area (MSA) or major market in which the surveyed submarket is located (e.g., New York-Newark-Jersey City, Chicago-Naperville-Elgin). Used for macro-level market aggregation and portfolio benchmarking.',
    `net_absorption_sqft` DECIMAL(18,2) COMMENT 'Net change in occupied square footage across the surveyed competitive set during the survey period. Positive values indicate demand exceeding supply (space being absorbed); negative values indicate tenants vacating more space than is being leased.',
    `new_supply_sqft` DECIMAL(18,2) COMMENT 'Total square footage of new construction delivered to the surveyed submarket during the survey period. Tracks supply-side additions that affect vacancy and rent levels.',
    `properties_surveyed_count` STRING COMMENT 'Total count of individual properties included in the competitive set for this survey period. Indicates the statistical sample size and reliability of the survey findings.',
    `published_date` DATE COMMENT 'Date on which the market survey was formally published and made available to internal stakeholders, investors, or external parties. Marks the transition from internal research to actionable market intelligence.',
    `rent_basis` STRING COMMENT 'The lease structure basis on which the surveyed rents are quoted. NNN (Triple Net) means tenant pays operating expenses; Gross means landlord covers expenses; Full Service Gross (FSG) includes all services. Critical for accurate rent comparisons across the competitive set.. Valid values are `NNN|gross|modified_gross|FSG|net`',
    `review_date` DATE COMMENT 'Date on which the market survey was reviewed and approved by the designated reviewer. Used for quality assurance workflow tracking and audit compliance.',
    `reviewed_by` STRING COMMENT 'Name or identifier of the senior analyst, asset manager (AM), or research director who reviewed and approved the survey findings before publication. Supports quality control and audit trail requirements.',
    `state_code` STRING COMMENT 'Two-letter U.S. state abbreviation (or equivalent jurisdiction code) for the geographic area covered by the survey. Used for regulatory compliance reporting and geographic segmentation.. Valid values are `^[A-Z]{2}$`',
    `survey_date` DATE COMMENT 'The point-in-time date on which the market survey data was collected or observed. This is the principal business event date used for trend analysis and time-series comparisons.',
    `survey_notes` STRING COMMENT 'Free-text field for the surveyor to record qualitative observations, market commentary, anomalies, methodology notes, or contextual factors affecting the survey results (e.g., seasonal effects, major tenant move-outs, new development announcements).',
    `survey_period_end_date` DATE COMMENT 'End date of the observation period covered by this market survey. Defines the closing boundary of the measurement window for activity-based metrics such as absorption and new supply.',
    `survey_period_start_date` DATE COMMENT 'Start date of the observation period covered by this market survey. Together with survey_period_end_date, defines the window during which market activity (absorption, new leases, deliveries) was measured.',
    `survey_period_type` STRING COMMENT 'Frequency classification of the survey cycle, indicating whether this is a monthly, quarterly, semi-annual, annual, or ad-hoc point-in-time survey. Determines how the record is used in trend analysis and time-series reporting.. Valid values are `monthly|quarterly|semi_annual|annual|ad_hoc`',
    `survey_ref` STRING COMMENT 'Externally-known business identifier for the market survey, used in reports, correspondence, and cross-system references. Format: MS-{YYYY}-{NNNNNN}.. Valid values are `^MS-[0-9]{4}-[0-9]{6}$`',
    `survey_status` STRING COMMENT 'Current lifecycle state of the market survey record, tracking progression from initial data collection through review, publication, and archival. [ENUM-REF-CANDIDATE: draft|in_progress|completed|reviewed|published|archived — promote to reference product]. Valid values are `draft|in_progress|completed|reviewed|published|archived`',
    `survey_type` STRING COMMENT 'Classification of the survey by the type of market data being captured. Rent surveys track asking and effective rents; vacancy surveys track occupancy; absorption surveys track net space take-up; concession surveys track landlord incentives; sales comp surveys track transaction comparables.. Valid values are `rent_survey|vacancy_survey|absorption_survey|concession_survey|sales_comp_survey`',
    `surveyor_company` STRING COMMENT 'Name of the firm or organization that conducted the market survey, relevant when surveys are sourced from third-party research providers such as CoStar, CBRE, or JLL.',
    `surveyor_name` STRING COMMENT 'Full name of the analyst, researcher, or broker who conducted and recorded the market survey. Used for accountability, quality review, and attribution of market intelligence.',
    `total_inventory_sqft` DECIMAL(18,2) COMMENT 'Aggregate rentable square footage (SQF) of all properties included in the surveyed competitive set. Provides the denominator for vacancy rate and absorption rate calculations at the submarket level.',
    `under_construction_sqft` DECIMAL(18,2) COMMENT 'Total square footage of properties currently under construction in the surveyed submarket as of the survey date. Represents the forward supply pipeline and is used in market forecasting and investment analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this market survey record was most recently modified. Used for change tracking, audit compliance, and incremental data pipeline processing.',
    `vacancy_rate` DECIMAL(18,2) COMMENT 'Percentage of total rentable square footage in the surveyed competitive set that is currently unoccupied and available for lease. Expressed as a decimal (e.g., 0.1250 = 12.50%). Key indicator of market supply-demand balance.',
    CONSTRAINT pk_market_survey PRIMARY KEY(`market_survey_id`)
) COMMENT 'Transactional record of a periodic market survey event capturing point-in-time competitive market data for a defined submarket or competitive set — rent surveys, vacancy surveys, absorption surveys, and concession surveys. Captures survey date, submarket or geographic area, property type, survey type, surveyor name, number of properties surveyed, average asking rent, average effective rent, vacancy rate, absorption rate, average concession value, and survey notes. Enables trend tracking and market positioning decisions.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`event` (
    `event_id` BIGINT COMMENT 'Unique surrogate identifier for the marketing event record in the lakehouse silver layer. Primary key for this entity.',
    `asset_id` BIGINT COMMENT 'Reference to the specific property being featured or promoted at this event (e.g., open house, property launch). Nullable when the event is portfolio-level or brand-level.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Marketing events (open houses, investor days, broker events) have dedicated budget allocations in finance_budget. Real estate marketing directors and controllers reconcile event actual spend against a',
    `building_class_id` BIGINT COMMENT 'Foreign key linking to reference.building_class. Business justification: Marketing events in CRE (open houses, broker tours) are targeted at specific building classes. Normalizing property_class enables event ROI reporting by asset quality tier and audience targeting by bu',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Property tours, broker open houses, and tenant events are held at specific buildings. Building-level event tracking enables access coordination, amenity booking, and post-event lead attribution by bui',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign under which this event is organized. Links event-level activity to campaign-level spend and performance tracking.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: Marketing events are promoted and distributed through specific marketing channels (e.g., email, social media, MLS open house listings, digital display). Adding channel_id to event enables tracking whi',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Marketing events (open houses, broker events, investor days) incur costs posted to property cost centers for NOI and opex reporting. marketing_event has cost_center_code as a plain string — a denormal',
    `currency_code_id` BIGINT COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this event record (e.g., USD, CAD, GBP). Supports multi-currency portfolio reporting.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Groundbreaking ceremonies, hard-hat tours, pre-sales launch events, and grand openings are marketing events directly tied to a specific development project. marketing_event has asset_id but not dev_pr',
    `fund_id` BIGINT COMMENT 'Foreign key linking to investment.fund. Business justification: Fund roadshows, LP annual meetings, and investor days are marketing events tied to a specific fund. Fund managers track event attendance and LP engagement per fund for investor relations reporting and',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Events have venue_city, venue_country, venue_state as denormalized text. Linking to geographic_hierarchy enables market-level event ROI reporting, lead attribution by submarket, and integration with g',
    `broker_id` BIGINT COMMENT 'Foreign key linking to brokerage.brokerage_broker. Business justification: Open houses and broker tours require a named hosting agent for MLS open house records, commission attribution, and agent performance reporting. marketing.event has no FK to brokerage_broker. Role pref',
    `investment_deal_id` BIGINT COMMENT 'Foreign key linking to investment.investment_deal. Business justification: Real estate firms host deal-specific events — investor roadshows, deal launch presentations, and property tours — tied to specific investment deals. Linking event to investment_deal enables deal-level',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Real estate marketing events (open houses, investor days, property tours) must comply with jurisdiction-specific regulations including local event permits, fair housing requirements for open houses, a',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Events (investor days, broker open houses) incur costs that must be booked to a specific legal entity for tax and compliance in fund/REIT structures. A real estate controller expects event costs to ca',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to reference.market_segment. Business justification: Real estate events target specific investor/tenant market segments (institutional investor forums, retail tenant mixers, core-plus acquisition seminars). Market segment classification enables event RO',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Ground-breaking ceremonies, land auction events, and site tour events are tied to a specific parcel in real estate development marketing. event has dev_project_id but not parcel_id. Ground-breaking ev',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment or property portfolio associated with this event when the event spans multiple properties (e.g., investor day, portfolio roadshow). Nullable for single-property events.',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Real estate events are property-type specific (multifamily investor day, office leasing event, industrial site tour). Property type classification enables event ROI attribution by asset class, targete',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Real estate events are organized around specific transaction types (open houses for sale, tenant mixers for leasing, investment seminars for acquisitions). Transaction type drives event compliance req',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: Residential open house events and model unit tours are tied to a specific unit (event.mls_open_house_code confirms this). MLS open house reporting and leasing pipeline tracking require linking the eve',
    `actual_attendance` STRING COMMENT 'Confirmed number of individuals who physically or virtually attended the event. Populated post-event. Used to calculate attendance rate and measure event effectiveness.',
    `budgeted_cost` DECIMAL(18,2) COMMENT 'Planned budget allocated for the marketing event at the time of event approval. Compared against total_event_cost for variance analysis and OPEX management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this marketing event record was first created in the system. Used for audit trail, data lineage, and SLA compliance tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `end_timestamp` TIMESTAMP COMMENT 'Date and time when the marketing event is scheduled to end or actually ended. Used to calculate event duration and schedule non-overlapping events at the same venue.',
    `event_date` DATE COMMENT 'Calendar date of the marketing event, used for day-level scheduling, reporting, and calendar integrations independent of precise start/end times.',
    `event_description` STRING COMMENT 'Detailed narrative description of the event purpose, agenda, and key highlights. Used in invitations, press releases, and post-event reporting.',
    `event_name` STRING COMMENT 'Human-readable name of the marketing event as it appears in promotional materials, invitations, and internal reporting (e.g., Q3 Broker Preview — Downtown Tower, Annual Investor Day 2024).',
    `event_number` STRING COMMENT 'Externally-visible business identifier for the marketing event, used in communications, vendor contracts, and reporting. Format: EVT-YYYY-NNNNNN.. Valid values are `^EVT-[0-9]{4}-[0-9]{6}$`',
    `event_status` STRING COMMENT 'Current lifecycle state of the marketing event from planning through execution and closure. Drives workflow routing and reporting filters.. Valid values are `draft|confirmed|in_progress|completed|cancelled|postponed`',
    `event_type` STRING COMMENT 'Classification of the marketing event by format and purpose. Drives reporting segmentation and lead attribution logic. [ENUM-REF-CANDIDATE: open_house|broker_preview|investor_day|property_launch|community_outreach|trade_show|webinar|networking|other — promote to reference product]',
    `expected_attendance` STRING COMMENT 'Planned or forecasted number of attendees for the event, set during event planning. Used for venue capacity planning, catering, and budget estimation.',
    `invitation_sent_date` DATE COMMENT 'Date on which event invitations were distributed to the target audience. Used to measure lead time and optimize future event marketing timelines.',
    `is_public` BOOLEAN COMMENT 'Indicates whether the event is open to the general public (True) or restricted to invited guests only (False). Drives listing on public event portals and MLS open house feeds.',
    `is_virtual` BOOLEAN COMMENT 'Indicates whether the event is conducted entirely online (webinar, virtual tour, virtual investor day) rather than at a physical venue. Drives channel segmentation and platform cost allocation.',
    `leads_generated` STRING COMMENT 'Number of new prospect leads captured or attributed to this event. Populated post-event from CRM lead attribution. Key metric for event-driven lead generation ROI analysis.',
    `mls_open_house_code` STRING COMMENT 'Identifier assigned by the Multiple Listing Service (MLS) when the event is published as an open house on the MLS feed. Nullable for non-open-house events.',
    `post_event_notes` STRING COMMENT 'Free-text field capturing qualitative observations, outcomes, and follow-up actions recorded by the event owner after the event concludes. Supports knowledge management and future event planning.',
    `registration_count` STRING COMMENT 'Total number of individuals who registered or RSVPd for the event prior to the event date. Used to measure pre-event demand and plan logistics.',
    `registration_deadline` DATE COMMENT 'Last date by which attendees must register for the event. Used to close registration forms and finalize logistics planning.',
    `requires_registration` BOOLEAN COMMENT 'Indicates whether attendees must pre-register to attend the event. Drives registration workflow activation and capacity management.',
    `source_event_code` STRING COMMENT 'Native identifier of this event record in the originating source system (e.g., Salesforce Event ID, Yardi event reference). Enables cross-system reconciliation and deduplication.',
    `source_system` STRING COMMENT 'Operational system of record from which this event record originated (e.g., Salesforce CRM, Yardi Voyager, manual entry). Supports data lineage and reconciliation.. Valid values are `salesforce|yardi|mri|manual|other`',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the marketing event is scheduled to begin or actually began. Principal real-world event time used for scheduling, lead attribution, and timeline reporting. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `theme` STRING COMMENT 'Marketing theme or brand message associated with the event (e.g., Sustainable Living, Prime CRE Investment Opportunities). Supports brand consistency and campaign alignment.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the event location (e.g., America/New_York, America/Los_Angeles). Ensures accurate scheduling and reporting across multi-market portfolios.',
    `total_event_cost` DECIMAL(18,2) COMMENT 'Total actual expenditure incurred for the marketing event including venue rental, catering, AV equipment, marketing collateral, speaker fees, and travel. Used for OPEX tracking and marketing budget reconciliation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this marketing event record was last modified. Used for incremental data pipeline processing, audit trails, and change detection in the lakehouse silver layer. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `venue_address` STRING COMMENT 'Full street address of the event venue for in-person events. Used in invitations, wayfinding, and compliance records.',
    `venue_name` STRING COMMENT 'Name of the physical or virtual venue where the event is held (e.g., property address, hotel conference room, Zoom webinar). Used for logistics coordination and attendee communications.',
    `virtual_event_url` STRING COMMENT 'Registration or join link for virtual events. Distributed to registrants and used for attendance tracking. Nullable for in-person events.. Valid values are `^https?://.+`',
    `virtual_platform` STRING COMMENT 'Technology platform used to host the virtual event when is_virtual is True (e.g., Zoom, Microsoft Teams, Webex). Nullable for in-person events.. Valid values are `zoom|teams|webex|gotowebinar|youtube_live|other`',
    CONSTRAINT pk_event PRIMARY KEY(`event_id`)
) COMMENT 'Master record for marketing events organized or sponsored by the real estate enterprise — open houses, broker previews, investor days, property launch events, community outreach events, trade show participations, and webinars. Captures event name, event type, property or portfolio reference, venue, event date and time, target audience, expected attendance, actual attendance, registration count, event status, event owner, associated campaign reference, and total event cost. Enables event-driven lead generation tracking.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`event_registration` (
    `event_registration_id` BIGINT COMMENT 'Unique surrogate identifier for each event registration record in the marketing domain. Primary key for the event_registration data product.',
    `brokerage_prospect_id` BIGINT COMMENT 'Foreign key linking to brokerage.brokerage_prospect. Business justification: Open house and broker event registrations are a named lead qualification process: when a registrant is identified as a qualified prospect, linking the event_registration to the brokerage_prospect reco',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that drove or is associated with this event registration, enabling campaign-level ROI attribution and lead source tracking.',
    `currency_code_id` BIGINT COMMENT 'ISO 4217 three-letter currency code applicable to the registration fee amount (e.g., USD, EUR, GBP). Supports multi-currency event management for international portfolios.',
    `event_id` BIGINT COMMENT 'Reference to the parent marketing event (e.g., property showcase, investor briefing, broker open house, tenant networking event) for which this registration was created.',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: event_registration.preferred_market is a denormalized text field. A geographic_hierarchy_id FK enables market-level analysis of registrant geographic preferences, supporting targeted post-event campai',
    `investor_id` BIGINT COMMENT 'Foreign key linking to investment.investor. Business justification: When an existing LP/investor registers for a fund event (annual meeting, roadshow, investor day), linking event_registration to investor enables LP engagement tracking and relationship management — a ',
    `lead_id` BIGINT COMMENT 'Reference to the CRM lead record if this registrant has been converted to or matched with an existing lead, enabling post-event pipeline attribution and deal tracking.',
    `owner_contact_id` BIGINT COMMENT 'Foreign key linking to owner.owner_contact. Business justification: Owner contacts (authorized signatories, key principals) are invited to and attend investor days, property showcases, and market briefings. Tracking owner contact attendance at events supports relation',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: event_registration.property_interest is a denormalized text field. A property_type_id FK enables proper segmentation of registrant interests for post-event lead routing, targeted follow-up campaigns, ',
    `transferred_event_registration_id` BIGINT COMMENT 'Self-referencing FK on event_registration (transferred_event_registration_id)',
    `accessibility_needs` STRING COMMENT 'Any accessibility or accommodation requirements noted by the registrant (e.g., wheelchair access, hearing loop, sign language interpreter). Supports ADA compliance and inclusive event management.',
    `attendance_status` STRING COMMENT 'Current lifecycle state of the registration indicating whether the registrant ultimately attended, did not show, cancelled, or is on a waitlist. Core field for event ROI measurement and follow-up segmentation.. Valid values are `registered|attended|no_show|cancelled|waitlisted|transferred`',
    `badge_printed` BOOLEAN COMMENT 'Indicates whether a name badge has been printed for this registrant for an in-person event. Used by event operations staff to manage check-in logistics and badge inventory.',
    `budget_range` STRING COMMENT 'Self-reported budget or investment capacity range of the registrant (e.g., $1M–$5M, $10M+, Under $500K). Used for lead qualification and matching to appropriate properties or investment opportunities.',
    `cancellation_date` DATE COMMENT 'Date on which the registrant cancelled their registration. Populated only when attendance_status is cancelled. Used for cancellation rate analysis and waitlist management.',
    `cancellation_reason` STRING COMMENT 'Reason provided by the registrant or recorded by staff for cancelling the registration. Supports event planning improvements and re-engagement strategy.. Valid values are `scheduling_conflict|not_interested|duplicate_registration|travel_issue|other`',
    `check_in_timestamp` TIMESTAMP COMMENT 'Date and time at which the registrant physically or virtually checked in to the event. Null if the registrant did not attend. Used to confirm actual attendance and calculate event attendance rates.',
    `check_out_timestamp` TIMESTAMP COMMENT 'Date and time at which the registrant departed or disconnected from the event. Used to calculate dwell time and engagement depth for event analytics.',
    `company_name` STRING COMMENT 'Name of the organization or firm the registrant represents. Used for B2B segmentation, investor/tenant profiling, and brokerage relationship management.',
    `consent_date` DATE COMMENT 'Date on which the registrant provided or withdrew marketing communications consent. Required for GDPR audit trail and consent lifecycle management.',
    `consent_marketing` BOOLEAN COMMENT 'Indicates whether the registrant has provided explicit consent to receive future marketing communications from the firm. Mandatory for GDPR and CAN-SPAM compliance in post-event outreach campaigns.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this event registration record was first created in the data platform. Used for audit trail, data lineage, and SLA compliance tracking.',
    `dietary_requirements` STRING COMMENT 'Special dietary requirements or restrictions noted by the registrant for in-person events with catering (e.g., vegetarian, halal, gluten-free, nut allergy). Supports event logistics and duty-of-care obligations.',
    `email` STRING COMMENT 'Primary email address of the registrant. Used for confirmation, event reminders, post-event follow-up communications, and CRM lead deduplication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_name` STRING COMMENT 'Given name of the individual registrant. Required for personalized communications, check-in, and name badge generation.',
    `follow_up_date` DATE COMMENT 'Scheduled date for the next or completed post-event follow-up action (call, email, meeting) with the registrant. Supports pipeline management and SLA tracking for lead response.',
    `follow_up_status` STRING COMMENT 'Current status of post-event follow-up activities assigned to the marketing or brokerage team for this registrant. Drives CRM task management and ensures no warm leads are missed.. Valid values are `pending|in_progress|completed|not_required`',
    `job_title` STRING COMMENT 'Professional title or role of the registrant within their organization (e.g., Asset Manager, Portfolio Director, Leasing Agent). Supports audience qualification and follow-up prioritization.',
    `last_name` STRING COMMENT 'Family name of the individual registrant. Used in combination with first_name for full identity resolution, CRM matching, and formal correspondence.',
    `lead_converted` BOOLEAN COMMENT 'Indicates whether this event registration has been converted into a qualified CRM lead or opportunity. True when a deal pipeline record has been created from this registration. Key metric for event ROI measurement.',
    `payment_status` STRING COMMENT 'Current payment status for the registration fee. not_required for complimentary events. Drives accounts receivable follow-up and event access control.. Valid values are `not_required|pending|paid|refunded|waived`',
    `phone` STRING COMMENT 'Primary contact phone number of the registrant in E.164 international format. Used for event reminders, broker outreach, and post-event follow-up calls.. Valid values are `^+?[1-9]d{1,14}$`',
    `referral_source_name` STRING COMMENT 'Name of the individual, broker, or organization that referred this registrant to the event. Supports referral attribution, broker relationship management, and co-marketing analysis.',
    `registrant_type` STRING COMMENT 'Classification of the registrant by their business relationship to the firm. Drives segmentation, follow-up workflows, and event ROI analysis by audience type. [ENUM-REF-CANDIDATE: prospect|broker|investor|tenant|media|internal_staff|sponsor|other — promote to reference product if additional types are needed]. Valid values are `prospect|broker|investor|tenant|media|other`',
    `registration_date` TIMESTAMP COMMENT 'The exact date and time (with timezone offset) at which the registrant completed their event registration. Serves as the principal business event timestamp for this transaction.',
    `registration_fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee charged to the registrant for attending the event, if applicable (e.g., paid investor summits, CRE conferences). Zero for complimentary events. Supports event revenue tracking.',
    `registration_number` STRING COMMENT 'Externally visible, human-readable registration confirmation number issued to the registrant at the time of sign-up. Used for check-in, correspondence, and audit trail purposes.. Valid values are `^REG-[0-9]{8}-[A-Z0-9]{6}$`',
    `registration_source` STRING COMMENT 'The channel or touchpoint through which the registrant signed up for the event. Enables multi-channel attribution analysis and optimization of event promotion spend. [ENUM-REF-CANDIDATE: web_form|email_invite|broker_referral|social_media|direct_outreach|phone|walk_in|partner_portal|other — promote to reference product if additional sources are needed]',
    `source_system` STRING COMMENT 'Operational system of record from which this event registration record originated (e.g., Salesforce CRM Campaign Member, Yardi Voyager). Supports data lineage, reconciliation, and Silver layer provenance tracking.. Valid values are `salesforce_crm|yardi_voyager|mri_software|manual|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this event registration record was most recently modified. Used for change detection, incremental data loads, and audit trail compliance.',
    `utm_campaign` STRING COMMENT 'UTM campaign parameter captured from the registration URL, identifying the specific marketing campaign that drove the registration (e.g., q4_investor_summit_2024). Enables campaign-level digital attribution.',
    `utm_medium` STRING COMMENT 'UTM medium parameter captured from the registration URL, identifying the marketing channel type (e.g., email, cpc, social, organic). Complements utm_source for full digital attribution.',
    `utm_source` STRING COMMENT 'Urchin Tracking Module (UTM) source parameter captured from the registration URL, identifying the originating platform or publisher (e.g., google, linkedin, costar). Enables digital marketing attribution.',
    `virtual_join_url` STRING COMMENT 'Unique personalized URL issued to the registrant for joining a virtual or hybrid event (e.g., webinar, virtual property tour, online investor briefing). Null for in-person-only events.',
    CONSTRAINT pk_event_registration PRIMARY KEY(`event_registration_id`)
) COMMENT 'Transactional record of an individual registrant or attendee for a marketing event — capturing registration date, registrant contact details, registrant type (prospect, broker, investor, tenant, media), registration source, attendance status (registered, attended, no-show, cancelled), lead reference if converted, and post-event follow-up status. Enables event ROI measurement and lead capture from event-driven marketing activities.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`channel` (
    `channel_id` BIGINT COMMENT 'Unique system-generated identifier for a marketing channel record. Primary key for the channel reference master. [REFERENCE_LOOKUP role — canonical_skip_reason: This entity is a reference master / taxonomy table defining standardized marketing channel types; per-role minimums for REFERENCE_LOOKUP are exempt, but full attribute coverage is still applied for business completeness.]',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Marketing channels (email, SMS, digital) are subject to jurisdiction-specific regulations (GDPR, TCPA, state privacy laws). Real estate compliance teams must validate that channels deployed in a juris',
    `parent_channel_id` BIGINT COMMENT 'Self-referencing FK on channel (parent_channel_id)',
    `activation_date` DATE COMMENT 'The date on which this marketing channel was first activated and made available for campaign use within the enterprise. Used for channel lifecycle tracking and historical attribution analysis.',
    `audience_type` STRING COMMENT 'The primary audience segment this channel is designed to reach: tenant (prospective lessees), buyer (property purchasers), investor (REIT/fund/private investors), broker (co-broker and referral network), owner (property owners seeking management or disposition), general (broad public awareness). Supports audience-based channel selection.. Valid values are `tenant|buyer|investor|broker|owner|general`',
    `benchmark_cpc_amount` DECIMAL(18,2) COMMENT 'The enterprises internal benchmark or contracted rate for Cost Per Click (CPC) on this channel. Used for paid digital channel budget planning and performance benchmarking against actual campaign spend.',
    `benchmark_cpl_amount` DECIMAL(18,2) COMMENT 'The enterprises internal benchmark or contracted rate for Cost Per Lead (CPL) on this channel, expressed in the channels cost currency. Used for budget planning, campaign ROI benchmarking, and vendor performance evaluation. Not a calculated metric — this is the agreed or target rate.',
    `benchmark_cpm_amount` DECIMAL(18,2) COMMENT 'The enterprises internal benchmark or contracted rate for Cost Per Mille (CPM — cost per 1,000 impressions) on this channel. Used for media planning and spend efficiency comparisons across digital and OOH channels.',
    `call_tracking_number` STRING COMMENT 'Dedicated phone number assigned to this channel for call attribution tracking (e.g., a unique number displayed on a billboard or portal listing to measure inbound call volume from that channel). Confidential as it is a business operational asset.',
    `can_spam_compliant` BOOLEAN COMMENT 'Indicates whether this channel (specifically email channels) complies with the CAN-SPAM Act requirements for commercial email, including unsubscribe mechanisms, sender identification, and subject line accuracy. Applicable to email marketing channels.',
    `channel_category` STRING COMMENT 'Standardized top-level taxonomy category classifying the channel by its nature and reach method. Enables consistent spend categorization and cross-channel attribution analysis. Values: digital_paid (paid search/display), digital_organic (SEO/content), social_media, email, direct_mail, ooh (Out-of-Home), events, referral, broker_network, mls_portal. [ENUM-REF-CANDIDATE: digital_paid|digital_organic|social_media|email|direct_mail|ooh|events|referral|broker_network|mls_portal — promote to reference product]',
    `channel_code` STRING COMMENT 'Short, unique alphanumeric code used to identify the channel across systems, campaign tagging, and UTM parameter construction (e.g., GOOG_PAID, EMAIL_DRIP, MLS_PORTAL). Serves as the externally-known business identifier for the channel.. Valid values are `^[A-Z0-9_]{2,30}$`',
    `channel_description` STRING COMMENT 'Detailed narrative description of the channels purpose, audience reach, typical use cases within the real estate portfolio, and any operational notes relevant to campaign planners and marketing analysts.',
    `channel_name` STRING COMMENT 'Human-readable name of the marketing channel as displayed in campaign management tools, dashboards, and reports (e.g., Google Paid Search, CoStar Listings Portal, Email Newsletter, Broker Referral Network).',
    `channel_status` STRING COMMENT 'Current operational lifecycle status of the marketing channel record. Active channels are available for campaign assignment. Inactive channels are suspended. Pending channels are being onboarded. Deprecated channels are retired from use but retained for historical attribution. Under_review channels are being evaluated.. Valid values are `active|inactive|pending|deprecated|under_review`',
    `contract_end_date` DATE COMMENT 'The date on which the enterprises contract or agreement with the channel platform or vendor expires or is scheduled to terminate. Used for vendor renewal management and budget cycle planning.',
    `contract_start_date` DATE COMMENT 'The date on which the enterprises contract or agreement with the channel platform or vendor becomes effective. Relevant for channels with formal vendor agreements (e.g., CoStar, LoopNet, Zillow Premier Agent).',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to cost benchmarks and rate cards for this channel (e.g., USD, CAD, GBP). Ensures consistent financial reporting across multi-currency portfolios.. Valid values are `^[A-Z]{3}$`',
    `cost_model` STRING COMMENT 'The pricing or billing model under which this channel charges for marketing activity. CPM (Cost Per Mille/Thousand Impressions), CPC (Cost Per Click), CPL (Cost Per Lead), flat_fee (fixed periodic fee), revenue_share (percentage of transaction), CPA (Cost Per Acquisition), free (no direct cost). Drives budget planning and ROI benchmarking. [ENUM-REF-CANDIDATE: cpm|cpc|cpl|flat_fee|revenue_share|cpa|free — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this channel record was first created in the system, in ISO 8601 format with timezone offset (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides audit trail for reference data governance.',
    `deactivation_date` DATE COMMENT 'The date on which this marketing channel was deactivated or retired from active use. Null for currently active channels. Used for lifecycle management and ensuring deprecated channels are not assigned to new campaigns.',
    `digital_flag` BOOLEAN COMMENT 'Indicates whether this is a digital channel (True) or a traditional/offline channel (False). Used to segment digital vs. non-digital spend reporting and to apply digital-specific tracking and compliance rules.',
    `esg_aligned` BOOLEAN COMMENT 'Indicates whether this channel has been designated as ESG-aligned, meaning it supports sustainable or socially responsible marketing practices (e.g., digital-first channels reducing paper waste, channels promoting LEED-certified properties). Supports ESG reporting for publicly traded REITs.',
    `fair_housing_compliant` BOOLEAN COMMENT 'Indicates whether this channels targeting and advertising practices comply with the Fair Housing Act, prohibiting discriminatory targeting based on protected classes (race, color, religion, sex, national origin, disability, familial status). Mandatory for all residential marketing channels.',
    `gdpr_compliant` BOOLEAN COMMENT 'Indicates whether this channels data collection and tracking practices have been reviewed and confirmed as compliant with GDPR requirements. Relevant for digital channels collecting prospect data from EU-based audiences. Required for compliance reporting.',
    `geographic_scope` STRING COMMENT 'The geographic reach of this marketing channel — local (single market/city), regional (multi-market/state), national (country-wide), or international. Used to match channel selection to campaign geographic targeting requirements.. Valid values are `local|regional|national|international`',
    `idx_feed_supported` BOOLEAN COMMENT 'Indicates whether this channel supports automated IDX (Internet Data Exchange) listing feed syndication. True for portals that accept automated property data feeds from MLS or internal listing systems.',
    `lead_attribution_weight` DECIMAL(18,2) COMMENT 'The fractional weight (0.0000 to 1.0000) assigned to this channel in the enterprises multi-touch lead attribution model. Used by the analytics layer to distribute lead credit across channels in the prospect journey. A value of 1.0 indicates single-touch attribution. This is a configured business rule, not a calculated metric.',
    `min_spend_amount` DECIMAL(18,2) COMMENT 'The minimum spend commitment required to activate or maintain this channel, as defined by the vendor contract or platform policy. Used in budget planning to ensure channel activation thresholds are met.',
    `mls_affiliated` BOOLEAN COMMENT 'Indicates whether this channel is affiliated with or operates through a Multiple Listing Service (MLS) network. True for MLS portals and IDX-feed-based platforms. Relevant for compliance with MLS rules and NAR data sharing policies.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or contextual information about this channel that does not fit structured fields (e.g., vendor contact details, known limitations, seasonal availability, special targeting restrictions).',
    `owned_paid_earned` STRING COMMENT 'Classifies the channel within the standard marketing OPE (Owned, Paid, Earned) framework. Owned: channels the enterprise controls directly (website, email list, social profiles). Paid: channels requiring direct media spend (Google Ads, CoStar paid placement). Earned: channels driven by third-party advocacy (organic referrals, press, broker word-of-mouth).. Valid values are `owned|paid|earned`',
    `pixel_tag_code` STRING COMMENT 'The unique identifier of the conversion or retargeting pixel deployed for this channel (e.g., Facebook Pixel ID, Google Tag Manager container ID, LinkedIn Insight Tag ID). Used for pixel-based attribution and audience retargeting configuration.',
    `platform_name` STRING COMMENT 'Name of the technology platform, media vendor, or network through which this channel operates (e.g., Google Ads, CoStar, LoopNet, Zillow, Apartments.com, LinkedIn, Facebook, Mailchimp, Constant Contact, Salesforce Marketing Cloud). Used for vendor management and spend reconciliation.',
    `promo_code` STRING COMMENT 'Unique promotional or vanity code associated with this channel for offline or print attribution (e.g., DIRECT2024, BROKER10). Prospects entering this code during inquiry or application are attributed to this channel.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `property_type_applicability` STRING COMMENT 'Indicates whether this marketing channel is applicable to commercial real estate (CRE), residential, industrial, mixed-use, or all property types. Guides campaign planners in selecting appropriate channels for specific portfolio segments.. Valid values are `commercial|residential|both|industrial|mixed_use`',
    `sort_order` STRING COMMENT 'Integer value controlling the display sequence of this channel in dropdown menus, reports, and campaign planning interfaces. Lower values appear first. Used to prioritize frequently used or strategically important channels in UI and reporting tools.',
    `source_system` STRING COMMENT 'The operational system of record from which this channel record was originated or is primarily managed (e.g., salesforce for Salesforce CRM campaign channel taxonomy, yardi for Yardi Voyager marketing module, manual for manually maintained reference data). Supports data lineage and integration governance. [ENUM-REF-CANDIDATE: salesforce|yardi|mri|manual|costar|argus|other — 7 candidates stripped; promote to reference product]',
    `source_system_channel_code` STRING COMMENT 'The native identifier of this channel record in the originating source system (e.g., Salesforce Campaign Source ID, Yardi Marketing Channel Code). Used for cross-system reconciliation and ETL lineage tracing.',
    `subcategory` STRING COMMENT 'Secondary classification providing finer granularity within the channel category (e.g., Paid Search, Display Advertising, Retargeting, Instagram Stories, LinkedIn Sponsored, Cold Email, Drip Campaign, Postcard, Billboard, Trade Show). Supports detailed attribution and spend reporting.',
    `tcpa_compliant` BOOLEAN COMMENT 'Indicates whether this channel (specifically call tracking, SMS, and direct outreach channels) complies with TCPA requirements for prior express written consent before automated calls or texts. Applicable to call tracking and SMS channels.',
    `tracking_capability` STRING COMMENT 'The primary tracking mechanism supported by this channel for attribution and performance measurement. UTM (Urchin Tracking Module parameters for digital links), pixel (conversion/retargeting pixel), call_tracking (dedicated phone number tracking), qr_code, promo_code, none (no tracking available), multiple (supports more than one method). Critical for lead attribution accuracy. [ENUM-REF-CANDIDATE: utm|pixel|call_tracking|qr_code|promo_code|none|multiple — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this channel record was most recently modified, in ISO 8601 format with timezone offset (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change tracking, cache invalidation, and incremental data pipeline processing.',
    `utm_medium` STRING COMMENT 'The standardized UTM medium parameter value assigned to this channel (e.g., cpc, organic, email, social, display, referral). Used in conjunction with utm_source to provide consistent multi-channel attribution in analytics reporting.',
    `utm_source` STRING COMMENT 'The standardized UTM source parameter value assigned to this channel for consistent URL tagging across all campaigns (e.g., google, costar, zillow, email, linkedin). Ensures consistent attribution in web analytics platforms when UTM tracking is used.',
    CONSTRAINT pk_channel PRIMARY KEY(`channel_id`)
) COMMENT 'Reference master for all marketing channels used to reach prospects, tenants, buyers, and investors — defining the standardized channel taxonomy across the enterprise. Captures channel name, channel category (digital paid, digital organic, social media, email, direct mail, OOH, events, referral, broker network, MLS/portal), channel description, platform or vendor name, tracking capability (UTM, pixel, call tracking), cost model (CPM, CPC, CPL, flat fee), and channel status. Enables consistent channel attribution and spend categorization.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `real_estate_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_prior_campaign_id` FOREIGN KEY (`prior_campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_ad_creative_id` FOREIGN KEY (`ad_creative_id`) REFERENCES `real_estate_ecm`.`marketing`.`ad_creative`(`ad_creative_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `real_estate_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_event_id` FOREIGN KEY (`event_id`) REFERENCES `real_estate_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_prior_campaign_flight_id` FOREIGN KEY (`prior_campaign_flight_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign_flight`(`campaign_flight_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `real_estate_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_derived_ad_creative_id` FOREIGN KEY (`derived_ad_creative_id`) REFERENCES `real_estate_ecm`.`marketing`.`ad_creative`(`ad_creative_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_event_id` FOREIGN KEY (`event_id`) REFERENCES `real_estate_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_ad_creative_id` FOREIGN KEY (`ad_creative_id`) REFERENCES `real_estate_ecm`.`marketing`.`ad_creative`(`ad_creative_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_campaign_flight_id` FOREIGN KEY (`campaign_flight_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign_flight`(`campaign_flight_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `real_estate_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_event_id` FOREIGN KEY (`event_id`) REFERENCES `real_estate_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_superseded_listing_syndication_id` FOREIGN KEY (`superseded_listing_syndication_id`) REFERENCES `real_estate_ecm`.`marketing`.`listing_syndication`(`listing_syndication_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `real_estate_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_listing_syndication_id` FOREIGN KEY (`listing_syndication_id`) REFERENCES `real_estate_ecm`.`marketing`.`listing_syndication`(`listing_syndication_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_master_lead_id` FOREIGN KEY (`master_lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_primary_duplicate_lead_id` FOREIGN KEY (`primary_duplicate_lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_ad_creative_id` FOREIGN KEY (`ad_creative_id`) REFERENCES `real_estate_ecm`.`marketing`.`ad_creative`(`ad_creative_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_campaign_flight_id` FOREIGN KEY (`campaign_flight_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign_flight`(`campaign_flight_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `real_estate_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_event_id` FOREIGN KEY (`event_id`) REFERENCES `real_estate_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_event_registration_id` FOREIGN KEY (`event_registration_id`) REFERENCES `real_estate_ecm`.`marketing`.`event_registration`(`event_registration_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_listing_syndication_id` FOREIGN KEY (`listing_syndication_id`) REFERENCES `real_estate_ecm`.`marketing`.`listing_syndication`(`listing_syndication_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_parent_lead_activity_id` FOREIGN KEY (`parent_lead_activity_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead_activity`(`lead_activity_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_primary_superseded_by_market_research_id` FOREIGN KEY (`primary_superseded_by_market_research_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_research`(`market_research_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ADD CONSTRAINT `fk_marketing_market_survey_prior_market_survey_id` FOREIGN KEY (`prior_market_survey_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_survey`(`market_survey_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `real_estate_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ADD CONSTRAINT `fk_marketing_event_registration_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ADD CONSTRAINT `fk_marketing_event_registration_event_id` FOREIGN KEY (`event_id`) REFERENCES `real_estate_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ADD CONSTRAINT `fk_marketing_event_registration_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ADD CONSTRAINT `fk_marketing_event_registration_transferred_event_registration_id` FOREIGN KEY (`transferred_event_registration_id`) REFERENCES `real_estate_ecm`.`marketing`.`event_registration`(`event_registration_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ADD CONSTRAINT `fk_marketing_channel_parent_channel_id` FOREIGN KEY (`parent_channel_id`) REFERENCES `real_estate_ecm`.`marketing`.`channel`(`channel_id`);

-- ========= TAGS =========
ALTER SCHEMA `real_estate_ecm`.`marketing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `real_estate_ecm`.`marketing` SET TAGS ('dbx_domain' = 'marketing');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `green_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Green Certification Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `owner_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Agreement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `prior_campaign_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Campaign End Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Campaign Start Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Approval Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Approval Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected|revision_required');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Campaign Budget Amount');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Campaign Approved By');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}-[0-9]{4}-[A-Z0-9]{4,12}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|completed|cancelled');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'digital|print|out_of_home|email|social_media|event');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `channel_mix` SET TAGS ('dbx_business_glossary_term' = 'Campaign Channel Mix');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `creative_theme` SET TAGS ('dbx_business_glossary_term' = 'Campaign Creative Theme');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `digital_platform` SET TAGS ('dbx_business_glossary_term' = 'Digital Advertising Platform');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `esg_aligned_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Aligned Campaign Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `fair_housing_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Housing Compliance Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `gdpr_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `mls_syndication_flag` SET TAGS ('dbx_business_glossary_term' = 'Multiple Listing Service (MLS) Syndication Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Campaign Notes');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Campaign Objective');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `objective` SET TAGS ('dbx_value_regex' = 'lead_generation|brand_awareness|listing_promotion|market_penetration|tenant_retention');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Campaign End Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Campaign Start Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|costar|sap_s4hana|manual');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `source_system_campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `target_impression_count` SET TAGS ('dbx_business_glossary_term' = 'Target Impression Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `target_lead_count` SET TAGS ('dbx_business_glossary_term' = 'Target Lead Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `total_spend_to_date` SET TAGS ('dbx_business_glossary_term' = 'Total Campaign Spend to Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `total_spend_to_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `campaign_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `ad_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Creative Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Event Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `prior_campaign_flight_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Actual Spend');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `actual_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Flight Approval Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_required');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Flight Approval Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `clicks` SET TAGS ('dbx_business_glossary_term' = 'Ad Clicks');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `cpc_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Click (CPC) Rate');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `cpc_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `cpm_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM) Rate');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `cpm_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `creative_format` SET TAGS ('dbx_business_glossary_term' = 'Creative Format');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `esg_aligned` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Aligned Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `fair_housing_compliant` SET TAGS ('dbx_business_glossary_term' = 'Fair Housing Compliance Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `flight_budget` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Budget');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `flight_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `flight_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^FLT-[A-Z0-9]{4,12}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `flight_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `flight_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|paused|completed|cancelled');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `impressions_delivered` SET TAGS ('dbx_business_glossary_term' = 'Impressions Delivered');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `landing_page_url` SET TAGS ('dbx_business_glossary_term' = 'Landing Page URL');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `leads_generated` SET TAGS ('dbx_business_glossary_term' = 'Leads Generated');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Flight Notes');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `placement_name` SET TAGS ('dbx_business_glossary_term' = 'Ad Placement Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|costar|google_ads|meta_ads|yardi|manual');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'UTM Campaign Parameter');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'UTM Medium Parameter');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'UTM Source Parameter');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `vendor_order_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Media Order Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `ad_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Creative ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `derived_ad_creative_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Event Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `accessibility_compliant` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Compliance Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Creative Agency Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Creative Approval Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Creative Approval Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|expired|archived');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Creative Aspect Ratio');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_value_regex' = '^[0-9]+:[0-9]+$');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `brand_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Compliance Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `brand_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|waived');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `call_to_action` SET TAGS ('dbx_business_glossary_term' = 'Call to Action (CTA)');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `creative_code` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `creative_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}-[A-Z0-9]{4,12}-[0-9]{3}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `creative_name` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `creative_subtype` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Subtype');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Creative Duration (Seconds)');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Creative Effective Start Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Creative Expiry Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `fair_housing_compliant` SET TAGS ('dbx_business_glossary_term' = 'Fair Housing Compliance Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'Creative File Size (Kilobytes)');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `file_url` SET TAGS ('dbx_business_glossary_term' = 'Creative File URL');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `file_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `format_type` SET TAGS ('dbx_business_glossary_term' = 'Creative Format Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `format_type` SET TAGS ('dbx_value_regex' = 'image|video|pdf|html5|copy|audio');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `headline_copy` SET TAGS ('dbx_business_glossary_term' = 'Creative Headline Copy');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `height_px` SET TAGS ('dbx_business_glossary_term' = 'Creative Height (Pixels)');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `is_archived` SET TAGS ('dbx_business_glossary_term' = 'Archived Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Creative Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Creative Language Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `mime_type` SET TAGS ('dbx_business_glossary_term' = 'Creative MIME Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `platform_target` SET TAGS ('dbx_business_glossary_term' = 'Target Platform');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `portfolio_scope` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Scope');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `portfolio_scope` SET TAGS ('dbx_value_regex' = 'single_property|portfolio|brand|market');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `production_cost` SET TAGS ('dbx_business_glossary_term' = 'Creative Production Cost');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `production_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|yardi_voyager|dam_system|manual_upload|procore|mri_software');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `tags_keywords` SET TAGS ('dbx_business_glossary_term' = 'Creative Tags and Keywords');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `version_label` SET TAGS ('dbx_business_glossary_term' = 'Creative Version Label');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `version_label` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Creative Version Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `width_px` SET TAGS ('dbx_business_glossary_term' = 'Creative Width (Pixels)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `listing_syndication_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Syndication ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `ad_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Creative Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `building_class_id` SET TAGS ('dbx_business_glossary_term' = 'Building Class Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `campaign_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Event Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Property Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `superseded_listing_syndication_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `asking_price` SET TAGS ('dbx_business_glossary_term' = 'Asking Price');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `asking_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `asking_rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Asking Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `asking_rent_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `available_sqft` SET TAGS ('dbx_business_glossary_term' = 'Available Square Footage (SQF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `click_count` SET TAGS ('dbx_business_glossary_term' = 'Click Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `compliance_verified` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verified Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `days_on_market` SET TAGS ('dbx_business_glossary_term' = 'Days on Market (DOM)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Syndication Error Message');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Syndication Expiry Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `fair_housing_compliant` SET TAGS ('dbx_business_glossary_term' = 'Fair Housing Compliant Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `featured_listing` SET TAGS ('dbx_business_glossary_term' = 'Featured Listing Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `feed_type` SET TAGS ('dbx_business_glossary_term' = 'Feed Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `feed_type` SET TAGS ('dbx_value_regex' = 'RETS|RESO_WEB_API|IDX|MANUAL|FTP|DIRECT_API');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `idx_feed_code` SET TAGS ('dbx_business_glossary_term' = 'Internet Data Exchange (IDX) Feed ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `impression_count` SET TAGS ('dbx_business_glossary_term' = 'Impression Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `last_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Synchronization Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `lead_count` SET TAGS ('dbx_business_glossary_term' = 'Lead Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `listing_description` SET TAGS ('dbx_business_glossary_term' = 'Listing Description');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `listing_title` SET TAGS ('dbx_business_glossary_term' = 'Listing Title');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `mls_number` SET TAGS ('dbx_business_glossary_term' = 'Multiple Listing Service (MLS) Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `next_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Synchronization Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `override_active` SET TAGS ('dbx_business_glossary_term' = 'Platform Override Active Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `override_notes` SET TAGS ('dbx_business_glossary_term' = 'Platform Override Notes');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `paid_placement` SET TAGS ('dbx_business_glossary_term' = 'Paid Placement Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `photo_count` SET TAGS ('dbx_business_glossary_term' = 'Published Photo Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `placement_cost` SET TAGS ('dbx_business_glossary_term' = 'Platform Placement Cost');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `placement_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `platform_name` SET TAGS ('dbx_business_glossary_term' = 'Target Platform Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `platform_name` SET TAGS ('dbx_value_regex' = 'Zillow|Realtor.com|LoopNet|CoStar|Apartments.com|MLS');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `platform_url` SET TAGS ('dbx_business_glossary_term' = 'Platform Listing URL');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `platform_url` SET TAGS ('dbx_value_regex' = '^https?://[^s]+$');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `publish_date` SET TAGS ('dbx_business_glossary_term' = 'Publish Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `pull_reason` SET TAGS ('dbx_business_glossary_term' = 'Pull Reason');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `pulled_date` SET TAGS ('dbx_business_glossary_term' = 'Pulled Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `syndication_ref` SET TAGS ('dbx_business_glossary_term' = 'Syndication Reference Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `syndication_source_system` SET TAGS ('dbx_business_glossary_term' = 'Syndication Source System');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `syndication_source_system` SET TAGS ('dbx_value_regex' = 'Yardi|MRI|CoStar|Salesforce|Manual|Proprietary');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `syndication_status` SET TAGS ('dbx_business_glossary_term' = 'Syndication Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `syndication_status` SET TAGS ('dbx_value_regex' = 'pending|live|expired|pulled|error|paused');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `virtual_tour_url` SET TAGS ('dbx_business_glossary_term' = 'Virtual Tour URL');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `virtual_tour_url` SET TAGS ('dbx_value_regex' = '^https?://[^s]+$');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` SET TAGS ('dbx_subdomain' = 'lead_management');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Lead ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Brokerage Broker Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `investor_id` SET TAGS ('dbx_business_glossary_term' = 'Converted Investor Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `industry_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Classification Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `listing_syndication_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Syndication Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `master_lead_id` SET TAGS ('dbx_business_glossary_term' = 'Master Lead ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `primary_duplicate_lead_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Property Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Size Uom Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `space_use_type_id` SET TAGS ('dbx_business_glossary_term' = 'Space Use Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `budget_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Budget');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `budget_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `budget_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Budget');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `budget_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `company_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Company Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `company_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Lead Conversion Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `desired_move_in_date` SET TAGS ('dbx_business_glossary_term' = 'Desired Move-In Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `disqualification_reason` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Reason');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `do_not_contact` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Lead Email Address');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `first_contact_date` SET TAGS ('dbx_business_glossary_term' = 'First Contact Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Lead First Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `gdpr_consent` SET TAGS ('dbx_business_glossary_term' = 'GDPR Consent Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `gdpr_consent_date` SET TAGS ('dbx_business_glossary_term' = 'GDPR Consent Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `grade` SET TAGS ('dbx_business_glossary_term' = 'Lead Grade');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `grade` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `is_duplicate` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Lead Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Last Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `lead_number` SET TAGS ('dbx_business_glossary_term' = 'Lead Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `lead_number` SET TAGS ('dbx_value_regex' = '^LD-[0-9]{8,12}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `lead_source` SET TAGS ('dbx_business_glossary_term' = 'Lead Source');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `lead_status` SET TAGS ('dbx_business_glossary_term' = 'Lead Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `lead_type` SET TAGS ('dbx_business_glossary_term' = 'Lead Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `lead_type` SET TAGS ('dbx_value_regex' = 'buyer|tenant|investor|seller|landlord|other');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lead Notes');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Lead Phone Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `referral_source_name` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `referral_source_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Lead Score');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `size_requirement_max_sqf` SET TAGS ('dbx_business_glossary_term' = 'Maximum Size Requirement (Square Feet)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `size_requirement_min_sqf` SET TAGS ('dbx_business_glossary_term' = 'Minimum Size Requirement (Square Feet)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `source_portal` SET TAGS ('dbx_business_glossary_term' = 'Source Portal');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `source_system_lead_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Lead ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'UTM Campaign');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'UTM Medium');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'UTM Source');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` SET TAGS ('dbx_subdomain' = 'lead_management');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `lead_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Activity ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `ad_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Creative Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `campaign_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Event Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `event_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Event Registration Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Lead ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `listing_syndication_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Syndication Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `parent_lead_activity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `activity_direction` SET TAGS ('dbx_business_glossary_term' = 'Activity Direction');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `activity_direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_business_glossary_term' = 'Lead Activity Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_value_regex' = 'completed|attempted|failed|pending|cancelled');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `activity_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lead Activity Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Lead Activity Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `attribution_model` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `attribution_model` SET TAGS ('dbx_value_regex' = 'first_touch|last_touch|linear|time_decay|position_based');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `attribution_weight` SET TAGS ('dbx_business_glossary_term' = 'Attribution Weight');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `call_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Call Duration (Seconds)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `channel_subtype` SET TAGS ('dbx_business_glossary_term' = 'Channel Subtype');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|not_required|pending');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `content_reference` SET TAGS ('dbx_business_glossary_term' = 'Content Reference');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `conversion_type` SET TAGS ('dbx_business_glossary_term' = 'Conversion Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `conversion_type` SET TAGS ('dbx_value_regex' = 'showing_request|loi_submitted|lease_inquiry|purchase_inquiry|callback_booked|tour_scheduled');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|unknown');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `email_subject` SET TAGS ('dbx_business_glossary_term' = 'Email Subject Line');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `email_subject` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `email_subject` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `form_name` SET TAGS ('dbx_business_glossary_term' = 'Form Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `funnel_stage` SET TAGS ('dbx_business_glossary_term' = 'Lead Funnel Stage');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `funnel_stage` SET TAGS ('dbx_value_regex' = 'awareness|interest|consideration|intent|evaluation|conversion');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `is_conversion_event` SET TAGS ('dbx_business_glossary_term' = 'Is Conversion Event Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `lead_score_at_activity` SET TAGS ('dbx_business_glossary_term' = 'Lead Score at Activity');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `next_action` SET TAGS ('dbx_business_glossary_term' = 'Next Recommended Action');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `next_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Action Due Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Activity Outcome');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'engaged|no_response|bounced|opted_out|converted|disqualified');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `outcome_notes` SET TAGS ('dbx_business_glossary_term' = 'Activity Outcome Notes');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `page_view_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Page View Duration (Seconds)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `performer_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Performer Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `performer_type` SET TAGS ('dbx_value_regex' = 'agent|system|chatbot|prospect');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Activity Sequence Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'Web Session ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `source_activity_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Activity Reference');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|yardi_voyager|mri_software|costar|building_engines|manual');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'UTM Campaign');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'UTM Medium');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'UTM Source');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` SET TAGS ('dbx_subdomain' = 'market_intelligence');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `market_research_id` SET TAGS ('dbx_business_glossary_term' = 'Market Research ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Area Uom Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `investment_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Deal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `portfolio_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `primary_superseded_by_market_research_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Market Research ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `space_use_type_id` SET TAGS ('dbx_business_glossary_term' = 'Space Use Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `avg_asking_rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Average Asking Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `cap_rate` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Rate (CAP Rate)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `commission_cost` SET TAGS ('dbx_business_glossary_term' = 'Research Commission Cost');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `commission_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `competitive_set_count` SET TAGS ('dbx_business_glossary_term' = 'Competitive Set Property Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `data_sources` SET TAGS ('dbx_business_glossary_term' = 'Data Sources');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Distribution List');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `distribution_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `esg_focus_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Focus Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `external_publication_flag` SET TAGS ('dbx_business_glossary_term' = 'External Publication Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `key_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Key Findings Summary');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `net_absorption_sqft` SET TAGS ('dbx_business_glossary_term' = 'Net Absorption Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `new_supply_sqft` SET TAGS ('dbx_business_glossary_term' = 'New Supply Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `peer_reviewed_flag` SET TAGS ('dbx_business_glossary_term' = 'Peer Reviewed Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Research Provider Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `provider_type` SET TAGS ('dbx_business_glossary_term' = 'Research Provider Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `provider_type` SET TAGS ('dbx_value_regex' = 'internal|third_party|joint');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `publication_status` SET TAGS ('dbx_business_glossary_term' = 'Publication Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `publication_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|published|archived|withdrawn');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `publish_date` SET TAGS ('dbx_business_glossary_term' = 'Publish Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `report_file_url` SET TAGS ('dbx_business_glossary_term' = 'Report File URL');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `report_file_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `report_file_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `report_format` SET TAGS ('dbx_business_glossary_term' = 'Report File Format');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `report_format` SET TAGS ('dbx_value_regex' = 'PDF|XLSX|PPTX|DOCX|HTML');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `research_code` SET TAGS ('dbx_business_glossary_term' = 'Market Research Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `research_code` SET TAGS ('dbx_value_regex' = '^MR-[0-9]{4}-[0-9]{5}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `research_date` SET TAGS ('dbx_business_glossary_term' = 'Research Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `research_methodology` SET TAGS ('dbx_business_glossary_term' = 'Research Methodology');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `research_type` SET TAGS ('dbx_business_glossary_term' = 'Research Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `research_type` SET TAGS ('dbx_value_regex' = 'submarket_analysis|competitive_landscape|demand_study|absorption_study|rent_survey|buyer_sentiment');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `study_period_end` SET TAGS ('dbx_business_glossary_term' = 'Study Period End Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `study_period_start` SET TAGS ('dbx_business_glossary_term' = 'Study Period Start Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `submarket_name` SET TAGS ('dbx_business_glossary_term' = 'Submarket Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Research Tags');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Research Title');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `total_inventory_sqft` SET TAGS ('dbx_business_glossary_term' = 'Total Inventory Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `under_construction_sqft` SET TAGS ('dbx_business_glossary_term' = 'Under Construction Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `vacancy_rate` SET TAGS ('dbx_business_glossary_term' = 'Vacancy Rate');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` SET TAGS ('dbx_subdomain' = 'market_intelligence');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `market_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Market Survey ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Area Uom Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `building_class_id` SET TAGS ('dbx_business_glossary_term' = 'Building Class Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `prior_market_survey_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `space_use_type_id` SET TAGS ('dbx_business_glossary_term' = 'Space Use Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `availability_rate` SET TAGS ('dbx_business_glossary_term' = 'Availability Rate');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `avg_asking_rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Average Asking Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `avg_concession_value_psf` SET TAGS ('dbx_business_glossary_term' = 'Average Concession Value Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `avg_effective_rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Average Effective Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `avg_free_rent_months` SET TAGS ('dbx_business_glossary_term' = 'Average Free Rent Months');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `avg_lease_term_months` SET TAGS ('dbx_business_glossary_term' = 'Average Lease Term (Months)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `avg_ti_allowance_psf` SET TAGS ('dbx_business_glossary_term' = 'Average Tenant Improvement (TI) Allowance Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `cap_rate` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Rate (CAP Rate)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Survey Confidence Level');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `costar_market_code` SET TAGS ('dbx_business_glossary_term' = 'CoStar Market ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Survey Data Source');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'CoStar|internal|broker_survey|third_party|MLS|public_record');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `gross_absorption_sqft` SET TAGS ('dbx_business_glossary_term' = 'Gross Absorption Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `metro_area` SET TAGS ('dbx_business_glossary_term' = 'Metropolitan Statistical Area (MSA)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `net_absorption_sqft` SET TAGS ('dbx_business_glossary_term' = 'Net Absorption Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `new_supply_sqft` SET TAGS ('dbx_business_glossary_term' = 'New Supply Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `properties_surveyed_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Properties Surveyed');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `published_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Published Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `rent_basis` SET TAGS ('dbx_business_glossary_term' = 'Rent Basis');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `rent_basis` SET TAGS ('dbx_value_regex' = 'NNN|gross|modified_gross|FSG|net');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Review Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Market Survey Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `survey_notes` SET TAGS ('dbx_business_glossary_term' = 'Survey Notes');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `survey_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Period End Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `survey_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Period Start Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `survey_period_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Period Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `survey_period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|ad_hoc');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `survey_ref` SET TAGS ('dbx_business_glossary_term' = 'Market Survey Reference Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `survey_ref` SET TAGS ('dbx_value_regex' = '^MS-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_business_glossary_term' = 'Market Survey Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|completed|reviewed|published|archived');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Market Survey Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'rent_survey|vacancy_survey|absorption_survey|concession_survey|sales_comp_survey');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `surveyor_company` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Company');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `surveyor_name` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `surveyor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `total_inventory_sqft` SET TAGS ('dbx_business_glossary_term' = 'Total Inventory Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `under_construction_sqft` SET TAGS ('dbx_business_glossary_term' = 'Under Construction Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `vacancy_rate` SET TAGS ('dbx_business_glossary_term' = 'Vacancy Rate');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` SET TAGS ('dbx_subdomain' = 'lead_management');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `building_class_id` SET TAGS ('dbx_business_glossary_term' = 'Building Class Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Hosting Brokerage Broker Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `investment_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Deal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `actual_attendance` SET TAGS ('dbx_business_glossary_term' = 'Actual Attendance');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `budgeted_cost` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Event Cost');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `budgeted_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event End Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `event_name` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `event_number` SET TAGS ('dbx_value_regex' = '^EVT-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'draft|confirmed|in_progress|completed|cancelled|postponed');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `expected_attendance` SET TAGS ('dbx_business_glossary_term' = 'Expected Attendance');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `invitation_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Invitation Sent Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `is_public` SET TAGS ('dbx_business_glossary_term' = 'Is Public Event Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `is_virtual` SET TAGS ('dbx_business_glossary_term' = 'Is Virtual Event Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `leads_generated` SET TAGS ('dbx_business_glossary_term' = 'Leads Generated');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `mls_open_house_code` SET TAGS ('dbx_business_glossary_term' = 'Multiple Listing Service (MLS) Open House ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `post_event_notes` SET TAGS ('dbx_business_glossary_term' = 'Post-Event Notes');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `registration_count` SET TAGS ('dbx_business_glossary_term' = 'Registration Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `registration_deadline` SET TAGS ('dbx_business_glossary_term' = 'Registration Deadline');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `requires_registration` SET TAGS ('dbx_business_glossary_term' = 'Requires Registration Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `source_event_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Event ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce|yardi|mri|manual|other');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Start Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `theme` SET TAGS ('dbx_business_glossary_term' = 'Event Theme');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Event Time Zone');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `total_event_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Event Cost');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `total_event_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `venue_address` SET TAGS ('dbx_business_glossary_term' = 'Event Venue Address');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `venue_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `venue_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `venue_name` SET TAGS ('dbx_business_glossary_term' = 'Event Venue Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `virtual_event_url` SET TAGS ('dbx_business_glossary_term' = 'Virtual Event URL');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `virtual_event_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `virtual_platform` SET TAGS ('dbx_business_glossary_term' = 'Virtual Event Platform');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `virtual_platform` SET TAGS ('dbx_value_regex' = 'zoom|teams|webex|gotowebinar|youtube_live|other');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` SET TAGS ('dbx_subdomain' = 'lead_management');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `event_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Event Registration ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `brokerage_prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Brokerage Prospect Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `investor_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Lead ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `owner_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Contact Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `transferred_event_registration_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `accessibility_needs` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Requirements');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `accessibility_needs` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `attendance_status` SET TAGS ('dbx_business_glossary_term' = 'Attendance Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `attendance_status` SET TAGS ('dbx_value_regex' = 'registered|attended|no_show|cancelled|waitlisted|transferred');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `badge_printed` SET TAGS ('dbx_business_glossary_term' = 'Name Badge Printed Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `budget_range` SET TAGS ('dbx_business_glossary_term' = 'Registrant Budget Range');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `budget_range` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'scheduling_conflict|not_interested|duplicate_registration|travel_issue|other');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `check_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-Out Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `company_name` SET TAGS ('dbx_business_glossary_term' = 'Registrant Company Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `company_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `consent_marketing` SET TAGS ('dbx_business_glossary_term' = 'Marketing Communications Consent Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `dietary_requirements` SET TAGS ('dbx_business_glossary_term' = 'Dietary Requirements');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `dietary_requirements` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Registrant Email Address');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Registrant First Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Scheduled Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `follow_up_status` SET TAGS ('dbx_business_glossary_term' = 'Post-Event Follow-Up Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `follow_up_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|not_required');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Registrant Job Title');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `job_title` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Registrant Last Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `lead_converted` SET TAGS ('dbx_business_glossary_term' = 'Lead Converted Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Payment Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|paid|refunded|waived');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Registrant Phone Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `referral_source_name` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `registrant_type` SET TAGS ('dbx_business_glossary_term' = 'Registrant Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `registrant_type` SET TAGS ('dbx_value_regex' = 'prospect|broker|investor|tenant|media|other');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date and Time');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `registration_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Registration Fee Amount');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `registration_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `registration_fee_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `registration_number` SET TAGS ('dbx_value_regex' = '^REG-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `registration_source` SET TAGS ('dbx_business_glossary_term' = 'Registration Source Channel');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|yardi_voyager|mri_software|manual|other');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'UTM Campaign');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'UTM Medium');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'UTM Source');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `virtual_join_url` SET TAGS ('dbx_business_glossary_term' = 'Virtual Event Join URL');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` SET TAGS ('dbx_subdomain' = 'market_intelligence');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `parent_channel_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Channel Activation Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `audience_type` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `audience_type` SET TAGS ('dbx_value_regex' = 'tenant|buyer|investor|broker|owner|general');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `benchmark_cpc_amount` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Cost Per Click (CPC) Amount');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `benchmark_cpl_amount` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Cost Per Lead (CPL) Amount');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `benchmark_cpm_amount` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Cost Per Mille (CPM) Amount');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `call_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Call Tracking Phone Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `call_tracking_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `can_spam_compliant` SET TAGS ('dbx_business_glossary_term' = 'CAN-SPAM Act Compliant Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `channel_category` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel Category');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,30}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `channel_description` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel Description');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_business_glossary_term' = 'Channel Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|deprecated|under_review');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Channel Contract End Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Channel Contract Start Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `cost_model` SET TAGS ('dbx_business_glossary_term' = 'Channel Cost Model');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Channel Deactivation Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `digital_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Channel Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `esg_aligned` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Aligned Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `fair_housing_compliant` SET TAGS ('dbx_business_glossary_term' = 'Fair Housing Act Compliant Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `gdpr_compliant` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Channel Geographic Scope');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'local|regional|national|international');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `idx_feed_supported` SET TAGS ('dbx_business_glossary_term' = 'Internet Data Exchange (IDX) Feed Supported Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `lead_attribution_weight` SET TAGS ('dbx_business_glossary_term' = 'Lead Attribution Weight');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `min_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Spend Amount');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `mls_affiliated` SET TAGS ('dbx_business_glossary_term' = 'Multiple Listing Service (MLS) Affiliated Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Channel Notes');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `owned_paid_earned` SET TAGS ('dbx_business_glossary_term' = 'Owned Paid Earned Channel Classification');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `owned_paid_earned` SET TAGS ('dbx_value_regex' = 'owned|paid|earned');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `pixel_tag_code` SET TAGS ('dbx_business_glossary_term' = 'Tracking Pixel Tag ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `platform_name` SET TAGS ('dbx_business_glossary_term' = 'Platform or Vendor Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `promo_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Promotional Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `promo_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `property_type_applicability` SET TAGS ('dbx_business_glossary_term' = 'Property Type Applicability');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `property_type_applicability` SET TAGS ('dbx_value_regex' = 'commercial|residential|both|industrial|mixed_use');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Channel Display Sort Order');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `source_system_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Channel ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel Subcategory');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `tcpa_compliant` SET TAGS ('dbx_business_glossary_term' = 'Telephone Consumer Protection Act (TCPA) Compliant Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `tracking_capability` SET TAGS ('dbx_business_glossary_term' = 'Channel Tracking Capability');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'UTM Medium Parameter');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'UTM Source Parameter');
