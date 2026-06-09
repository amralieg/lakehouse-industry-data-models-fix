-- Schema for Domain: marketing | Business: Real Estate | Version: v1_ecm
-- Generated on: 2026-05-02 01:46:58

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `real_estate_ecm`.`marketing` COMMENT 'Manages property marketing campaigns, digital listings, lead generation, market research, brand management, and advertising spend across commercial and residential portfolios. Tracks marketing channels, campaign performance, lead attribution, and competitive market intelligence.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Unique system-generated identifier for the marketing campaign. Primary key for the campaign master record across all marketing activities.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: campaign.target_audience_segment is a STRING. Normalizing to audience_segment_id FK links the campaign to the authoritative audience segment master, enabling retrieval of segment demographics, geograp',
    `brand_id` BIGINT COMMENT 'FK to marketing.brand',
    `green_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.green_certification. Business justification: ESG-aligned marketing campaigns are built around specific LEED/BREEAM certifications. Linking the campaign to the actual certification record enables verification that advertised green credentials are',
    `compliance_program_id` BIGINT COMMENT 'Foreign key linking to compliance.program. Business justification: Marketing campaigns in real estate are governed by compliance programs (Fair Housing Program, ESG Program, GDPR Program). Linking campaigns to their governing compliance program enables program-level ',
    `cost_center_id` BIGINT COMMENT 'Reference to the finance cost center to which campaign spend is allocated in the General Ledger (GL). Enables P&L attribution by business unit, property type, or geographic market.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Campaign budget approval and financial reporting requires a normalized currency reference for multi-currency real estate portfolios. Normalizing enables FX conversion for consolidated marketing spend ',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Real estate marketing campaigns are funded from approved finance budgets (property opex or leasing budget lines). Linking campaign to finance.budget enables budget utilization tracking and prevents ov',
    `fund_id` BIGINT COMMENT 'Foreign key linking to investment.fund. Business justification: Fund marketing campaigns (LP fundraising, fund launch, investor roadshows) are tied to a specific fund. Fund managers require fund-level marketing spend and campaign performance reporting. A real esta',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Real estate campaigns are scoped to geographic markets (MSA, submarket, city). Normalizing enables market-level campaign performance reporting, budget allocation by geography, and comparison against m',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to reference.market_segment. Business justification: Real estate campaigns are designed for specific investment strategies (core, value-add, opportunistic). Normalizing portfolio_segment to reference.market_segment enables campaign ROI reporting by inve',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Campaign ROI reporting by division and budget accountability require linking each marketing campaign to the org unit (regional office, brokerage division) that owns it. Real estate firms allocate mark',
    `owner_id` BIGINT COMMENT 'Foreign key linking to owner.owner. Business justification: Owner-directed marketing campaigns are a core real estate process: property owners mandate and fund campaigns for their assets (e.g., lease-up, disposition). Owner attribution on campaigns enables own',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Campaign planning and performance reporting in real estate is organized by property type (office, industrial, multifamily). Normalizing property_type_focus to reference.property_type enables cross-cam',
    `prior_campaign_id` BIGINT COMMENT 'Self-referencing FK on campaign (prior_campaign_id)',
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
    `primary_channel` STRING COMMENT 'The dominant marketing channel driving the majority of campaign spend and reach. Used for channel-level performance benchmarking and budget allocation optimization. [ENUM-REF-CANDIDATE: paid_search|paid_social|email|display|out_of_home|print|event|mls_syndication|direct_mail|broadcast — promote to reference product]',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Media buying approval and budget authorization for campaign flights require a traceable FK to the approving employee. Real estate marketing budget controls mandate employee-level approval accountabili',
    `asset_id` BIGINT COMMENT 'Reference to the specific property asset being marketed in this flight, if applicable. Enables property-level marketing spend attribution and ROI analysis per asset.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: campaign_flight.target_audience_segment is a STRING. Flights can target different audience segments than the parent campaign (e.g., a retargeting flight targets a different segment than the awareness ',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Campaign flights in commercial RE are targeted at specific buildings for building-level leasing campaigns. campaign_flight has asset_id but building-level flight targeting (e.g., a specific tower in a',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign under which this flight is executed. A campaign may contain multiple flights across different channels or time periods.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: campaign_flight.channel_type and channel_subtype are STRING fields. Normalizing to channel_id FK links the flight to the authoritative channel master, enabling retrieval of channel cost models, UTM pa',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Campaign flights represent discrete spend commitments coded to GL accounts for accrual and opex reporting. campaign_flight.gl_account_code is a denormalized string. A FK to chart_of_accounts enables a',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Campaign flights in real estate are geo-targeted to specific submarkets or MSAs. Normalizing target_geography enables flight performance analysis by geographic hierarchy node and media mix optimizatio',
    `listing_id` BIGINT COMMENT 'Reference to the specific property listing being promoted by this flight, if the flight is tied to a single listing (e.g., a Zillow or LoopNet featured listing flight). Null for portfolio-level or brand awareness flights.',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment or property portfolio being marketed, for portfolio-level brand or awareness flights not tied to a single property. Supports AUM-level marketing spend reporting.',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Campaign flights are targeted at specific property types; media buyers and marketing analysts filter flight performance by property type for ROI reporting and budget optimization across asset classes.',
    `vendor_id` BIGINT COMMENT 'FK to marketing.marketing_vendor',
    `prior_campaign_flight_id` BIGINT COMMENT 'Self-referencing FK on campaign_flight (prior_campaign_flight_id)',
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
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Ad creatives must comply with brand guidelines (brand_compliance_status already exists on ad_creative). Normalizing to brand_id FK enables enforcement of brand standards, retrieval of logo assets, col',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign this creative asset is assigned to. Links the creative to its parent campaign for performance attribution and spend tracking.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: ad_creative.channel is a STRING denoting the marketing channel (e.g., Digital, Social, Print). Normalizing to channel_id FK links the creative to the authoritative channel master, enabling chann',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Brand compliance and fair housing audit processes require knowing which employee created each ad creative. Role-prefixed created_by_employee_id used because a second employee FK (approver) is also n',
    `asset_id` BIGINT COMMENT 'Reference to the specific property this creative asset is associated with. Null if the creative is portfolio-level or brand-level rather than property-specific.',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Ad creatives are produced for specific property types (e.g., industrial warehouse vs. luxury residential). Brand compliance and fair housing review processes require knowing which property type a crea',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Ad creatives in real estate must comply with specific regulatory obligations (Fair Housing Act, RESPA, state advertising laws). Linking each creative to its governing obligation enables compliance rev',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: Residential RE ad creatives are produced for specific units: unit photography, virtual staging, floor plan renders. Linking creatives to units enables unit-level creative asset management and ensures ',
    `derived_ad_creative_id` BIGINT COMMENT 'Self-referencing FK on ad_creative (derived_ad_creative_id)',
    `accessibility_compliant` BOOLEAN COMMENT 'Indicates whether the creative asset meets web accessibility standards (WCAG 2.1 AA), including alt-text for images, captions for video, and sufficient color contrast. Required for ADA compliance in digital marketing.',
    `agency_name` STRING COMMENT 'Name of the external creative agency, photography studio, or freelance vendor responsible for producing this creative asset. Used for vendor performance tracking and procurement reporting.',
    `alt_text` STRING COMMENT 'Alternative text description of the creative asset for screen readers and accessibility compliance. Required for all image and banner ad assets per ADA Section 508 and WCAG 2.1 AA standards.',
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
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the production_cost amount (e.g., USD, GBP, EUR). Required for multi-currency portfolio operations.. Valid values are `^[A-Z]{3}$`',
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
    `asset_id` BIGINT COMMENT 'Reference to the property associated with this syndication record, enabling portfolio-level syndication reporting.',
    `building_class_id` BIGINT COMMENT 'Foreign key linking to reference.building_class. Business justification: Listing syndication feeds to CoStar, LoopNet, and MLS include building class. Normalizing property_class to reference.building_class ensures consistent class codes are transmitted to external platform',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that initiated or governs this syndication activity, enabling campaign-level performance attribution.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: listing_syndication tracks syndication to external portals (Zillow, Realtor.com, CoStar). Each portal maps to a marketing channel in the channel master. Adding channel_id FK enables channel-level synd',
    `digital_listing_id` BIGINT COMMENT 'Foreign key linking to marketing.digital_listing. Business justification: listing_syndication syndicates a property listing to external portals. digital_listing is the marketing-owned master record for the digital presentation of that listing. Linking listing_syndication to',
    `listing_id` BIGINT COMMENT 'Reference to the source property listing being syndicated. Links to the canonical listing record in the marketing or brokerage domain.',
    `space_id` BIGINT COMMENT 'Foreign key linking to property.space. Business justification: Commercial RE listing syndication to CoStar and LoopNet is performed at the space/suite level. Each syndicated commercial listing represents a specific leasable space. This link enables space-level sy',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: MLS and portal syndication for residential properties is done at the unit level. Each syndicated listing represents a specific available unit. This link enables unit-level syndication status tracking ',
    `superseded_listing_syndication_id` BIGINT COMMENT 'Self-referencing FK on listing_syndication (superseded_listing_syndication_id)',
    `asking_price` DECIMAL(18,2) COMMENT 'The listed asking price for sale listings as published on the target platform. Expressed in the operating currency. May be overridden per platform.',
    `asking_rent_psf` DECIMAL(18,2) COMMENT 'The advertised rental rate expressed as a Per Square Foot (PSF) annual or monthly figure for lease listings. Used for market comparability and CoStar/LoopNet feed requirements.',
    `available_sqft` DECIMAL(18,2) COMMENT 'The total available square footage (SQF) of the space being marketed on the target platform. For partial-floor or suite listings, reflects the specific available area rather than the total building size.',
    `click_count` BIGINT COMMENT 'Total number of user click-throughs on the syndicated listing on the target platform. Used for engagement rate calculation and lead attribution analysis.',
    `compliance_verified` BOOLEAN COMMENT 'Indicates whether the syndicated listing has been reviewed and confirmed compliant with applicable fair housing, advertising, and platform-specific content policies prior to publication.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this syndication record was first created in the system. Serves as the audit trail creation marker per SOX and data governance requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the asking price and rent figures published on the target platform (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
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
    `listing_type` STRING COMMENT 'Classification of the listing being syndicated — whether it is offered for sale, lease, sublease, or auction. Drives platform-specific field mapping and category placement.. Valid values are `sale|lease|sublease|auction`',
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
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that generated this lead, enabling campaign attribution and ROI analysis.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: lead.channel is a STRING denoting the marketing channel through which the lead was generated. Normalizing to channel_id FK links the lead to the authoritative channel master, enabling channel-level le',
    `investor_id` BIGINT COMMENT 'Foreign key linking to investment.investor. Business justification: When a marketing lead (prospective LP) converts to a committed investor, linking the lead to the investor record enables full-funnel tracking from first marketing touch to capital commitment — a stand',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: In new development sales, leads are captured on pre-sales interest lists tied to specific projects. Linking lead to dev_project enables sales velocity reporting by project, absorption rate tracking, a',
    `digital_listing_id` BIGINT COMMENT 'Foreign key linking to marketing.digital_listing. Business justification: Leads are frequently generated from digital property listings (web inquiries, listing page form submissions). Linking lead to digital_listing enables tracking which specific digital listing presentati',
    `employee_id` BIGINT COMMENT 'Reference to the leasing representative or sales agent assigned to follow up on this lead.',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Lead qualification in real estate requires a normalized geographic preference for broker routing, market demand analysis, and pipeline reporting by submarket. Normalizing preferred_location enables ge',
    `master_lead_id` BIGINT COMMENT 'Reference to the canonical (master) lead record when is_duplicate = True. Enables deduplication merge tracking and ensures analytics roll up to the correct master record.',
    `space_id` BIGINT COMMENT 'Foreign key linking to property.space. Business justification: Commercial leasing leads are tracked against specific spaces of interest. Brokers manage pipeline by space to avoid double-booking tours and to report space-level demand. This link is fundamental to c',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Lead qualification and pipeline reporting in CRE requires segmenting leads by property type interest (office, retail, multifamily). Normalizing enables broker assignment routing and conversion rate an',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Lead qualification in real estate requires knowing whether a prospect is interested in buying, leasing, or investing. Normalizing transaction_type_interest enables pipeline reporting and broker routin',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: Residential leasing CRM tracks which specific unit a prospect inquired about. Unit-level lead tracking drives follow-up workflows, availability management, and conversion-to-lease reporting. A leasing',
    `duplicate_lead_id` BIGINT COMMENT 'Self-referencing FK on lead (duplicate_lead_id)',
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
    `asset_id` BIGINT COMMENT 'Reference to the property listing or asset that the lead activity is associated with, such as a portal page view of a specific listing or a call inquiry about a property.',
    `campaign_flight_id` BIGINT COMMENT 'Reference to the specific campaign flight or ad flight within a campaign, representing a time-bounded execution window. Enables granular attribution to a specific flight period.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign under which this activity was generated. Supports campaign-level attribution modeling and spend analysis.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: lead_activity.channel is a STRING. Each lead activity touchpoint occurs through a specific marketing channel. Normalizing to channel_id FK links the activity to the authoritative channel master, enabl',
    `digital_listing_id` BIGINT COMMENT 'Foreign key linking to marketing.digital_listing. Business justification: Lead activities frequently involve interactions with digital listings (page views, virtual tour views, inquiry form submissions). Linking lead_activity to digital_listing enables tracking which specif',
    `employee_id` BIGINT COMMENT 'Reference to the agent, broker, or system actor who performed or initiated this activity. Used for agent performance tracking and lead nurture accountability.',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Lead activity attribution in real estate is segmented by geographic market for channel effectiveness reporting. Normalizing enables market-level funnel analysis and identification of high-demand subma',
    `lead_id` BIGINT COMMENT 'Reference to the marketing lead associated with this activity. Links the touchpoint back to the originating prospect or inquiry record tracked in Salesforce CRM.',
    `listing_id` BIGINT COMMENT 'Reference to the specific property listing (MLS or internal) that triggered or is associated with this lead activity. Supports listing-level lead attribution and conversion funnel analysis.',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Lead activity attribution and funnel analysis in real estate is segmented by property type. Marketing teams report engagement rates and conversion events by property type to optimize channel spend.',
    `parent_lead_activity_id` BIGINT COMMENT 'Self-referencing FK on lead_activity (parent_lead_activity_id)',
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

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`lead_attribution` (
    `lead_attribution_id` BIGINT COMMENT 'Unique surrogate identifier for each lead attribution record in the Silver Layer lakehouse. Primary key for the lead_attribution data product.',
    `asset_id` BIGINT COMMENT 'Reference to the property that was the subject of the marketing campaign and the converted lead, enabling property-level ROI measurement.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Marketing attribution analysis in real estate must identify which agent/broker employee is credited with converting an attributed lead, directly feeding commission calculations and agent performance r',
    `brokerage_deal_id` BIGINT COMMENT 'Reference to the brokerage deal or transaction record in Salesforce CRM or Yardi Voyager that resulted from the converted lead, enabling end-to-end attribution from marketing spend to closed transaction.',
    `brokerage_prospect_id` BIGINT COMMENT 'Reference to the prospect or contact record in Salesforce CRM associated with the converted lead, linking attribution data to the tenant/buyer relationship management lifecycle.',
    `building_class_id` BIGINT COMMENT 'Foreign key linking to reference.building_class. Business justification: Marketing attribution reporting in CRE is segmented by building class to measure channel ROI by asset quality tier. Normalizing property_class enables attribution analysis comparing Class A vs. Class ',
    `campaign_id` BIGINT COMMENT 'Reference to the primary marketing campaign credited with this attribution record. In multi-touch models, additional campaign references are captured via the campaign_ref_list field.',
    `channel_id` BIGINT COMMENT 'Reference to the marketing channel (e.g., paid search, email, social, MLS syndication, CoStar) through which the lead was generated and attributed.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Lead attribution deal value reporting for cross-border real estate transactions requires normalized currency. Normalizing attributed_deal_value and weighted_attributed_value enables FX-adjusted market',
    `fund_id` BIGINT COMMENT 'Foreign key linking to investment.fund. Business justification: Lead attribution for fund marketing (LP fundraising campaigns) must be reported at the fund level. Fund managers and IR teams need to know which marketing channels and campaigns drove investor commitm',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Marketing attribution reporting in real estate is segmented by geographic market to measure ROI by submarket. Normalizing market_area_code enables joining attribution data with geographic hierarchy de',
    `lead_id` BIGINT COMMENT 'Reference to the originating lead record that was converted and is being attributed to one or more marketing campaigns and channels.',
    `listing_id` BIGINT COMMENT 'Reference to the property listing (MLS or internal) that the lead engaged with, connecting attribution to the specific listing syndication record and enabling listing-level marketing performance analysis.',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio or asset management portfolio to which the attributed property belongs. Enables portfolio-level marketing spend and ROI aggregation for Asset Manager (AM) reporting.',
    `property_sale_id` BIGINT COMMENT 'Foreign key linking to transaction.property_sale. Business justification: Marketing attribution reporting: lead_attribution tracks attributed_deal_value but must reference the actual closed property_sale as the definitive conversion event. Required for campaign ROI, cost-pe',
    `prior_lead_attribution_id` BIGINT COMMENT 'Self-referencing FK on lead_attribution (prior_lead_attribution_id)',
    `attributed_deal_value` DECIMAL(18,2) COMMENT 'The gross deal value (purchase price or total lease value) of the converted transaction attributed to this campaign/channel record. For leases, this represents the total contract value (TCV) over the lease term. For sales, this is the transaction price. Used for ROI (Return on Investment) and campaign revenue attribution reporting.',
    `attribution_calculation_timestamp` TIMESTAMP COMMENT 'The date and time at which the attribution model was executed and the attribution weights were calculated for this record. Used for audit trail, model versioning, and recalculation tracking in the Silver Layer pipeline.',
    `attribution_model` STRING COMMENT 'Multi-touch attribution model applied to distribute credit across campaigns and channels. First-touch assigns 100% credit to the first interaction; last-touch to the final interaction; linear distributes equally; time-decay weights recent touches more heavily; data-driven uses algorithmic weighting; position-based applies U-shaped weighting.. Valid values are `first_touch|last_touch|linear|time_decay|data_driven|position_based`',
    `attribution_model_version` STRING COMMENT 'Version identifier of the attribution model algorithm used to calculate weights for this record (e.g., v1.0, v2.3). Enables reproducibility, model comparison, and audit of attribution methodology changes over time.. Valid values are `^v[0-9]+.[0-9]+$`',
    `attribution_ref` STRING COMMENT 'Externally-known business identifier for this attribution record, used for cross-system reconciliation between Salesforce CRM, Yardi Voyager, and the marketing analytics platform.. Valid values are `^ATT-[0-9]{8,12}$`',
    `attribution_status` STRING COMMENT 'Current lifecycle state of the attribution record. Pending indicates awaiting confirmation; confirmed indicates validated attribution; disputed indicates under review; voided indicates invalidated; superseded indicates replaced by a revised attribution.. Valid values are `pending|confirmed|disputed|voided|superseded`',
    `attribution_weight` DECIMAL(18,2) COMMENT 'Fractional credit weight assigned to this campaign/channel combination under the selected attribution model, expressed as a decimal between 0.0000 and 1.0000. The sum of all attribution weights for a single lead must equal 1.0000 across all attribution records for that lead.',
    `campaign_cost_attributed` DECIMAL(18,2) COMMENT 'The portion of the total campaign spend (OPEX/CAPEX marketing expenditure) allocated to this attribution record based on the attribution weight. Used to compute cost-per-lead, cost-per-conversion, and campaign ROI metrics.',
    `conversion_date` DATE COMMENT 'The calendar date on which the conversion event occurred (e.g., date the lease was signed, purchase agreement executed, or showing was booked). Used for time-series ROI reporting and campaign performance trending.',
    `conversion_event_type` STRING COMMENT 'The specific business event that constitutes a conversion for this attribution record. Examples include lease signed (ASC 842 / IFRS 16 commencement), purchase agreement executed, showing booked, Letter of Intent (LOI) submitted, rental application submitted, or tour completed. [ENUM-REF-CANDIDATE: lease_signed|purchase_agreement|showing_booked|loi_submitted|application_submitted|tour_completed|inquiry_submitted|offer_accepted — promote to reference product]. Valid values are `lease_signed|purchase_agreement|showing_booked|loi_submitted|application_submitted|tour_completed`',
    `conversion_timestamp` TIMESTAMP COMMENT 'Precise date and time at which the conversion event was recorded in the source system (Salesforce CRM or Yardi Voyager), enabling intraday attribution analysis and time-decay model calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this attribution record was first created in the Silver Layer data product. Supports audit trail, data lineage, and SOX compliance requirements.',
    `crm_campaign_ref` STRING COMMENT 'The external campaign identifier from Salesforce CRM (Campaign ID or Campaign Name) used to reconcile this attribution record with the source CRM system. Supports data lineage and cross-system audit.',
    `days_to_conversion` STRING COMMENT 'Number of calendar days elapsed between the leads first recorded marketing touchpoint (first_touch_date) and the conversion event date. Used to measure sales cycle length and inform time-decay attribution model calibration.',
    `first_touch_date` DATE COMMENT 'The date of the leads first recorded interaction with any marketing campaign or channel, used as the anchor point for first-touch attribution models and lead journey analysis.',
    `is_cross_channel` BOOLEAN COMMENT 'Indicates whether the leads conversion journey involved multiple distinct marketing channels (True) or a single channel (False). Used to identify cross-channel conversion patterns and inform integrated campaign strategy.',
    `is_primary_attribution` BOOLEAN COMMENT 'Indicates whether this attribution record represents the primary (highest-weighted) campaign/channel credit for the converted lead. True for the single record with the highest attribution weight; False for all secondary attribution records. Simplifies reporting for single-touch views.',
    `last_touch_date` DATE COMMENT 'The date of the leads most recent interaction with a marketing campaign or channel prior to conversion, used as the anchor point for last-touch attribution models.',
    `notes` STRING COMMENT 'Free-text field for analyst or system-generated notes regarding this attribution record, such as reasons for manual override, dispute resolution details, or model recalculation rationale.',
    `source_system` STRING COMMENT 'The operational system of record from which this attribution record was sourced or calculated. Supports data lineage tracking in the Databricks Silver Layer pipeline.. Valid values are `salesforce_crm|yardi_voyager|mri_software|costar|argus|manual`',
    `touch_count` STRING COMMENT 'Total number of marketing touchpoints (interactions across all campaigns and channels) recorded for this lead prior to conversion. Used to assess lead nurturing depth and inform time-decay attribution model weighting.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this attribution record was most recently modified, such as when attribution weights were recalculated or the status was updated. Supports audit trail and change tracking.',
    `weighted_attributed_value` DECIMAL(18,2) COMMENT 'The portion of the attributed deal value allocated to this specific campaign/channel record after applying the attribution weight (attributed_deal_value × attribution_weight). Enables per-campaign revenue contribution reporting and ROI calculation.',
    CONSTRAINT pk_lead_attribution PRIMARY KEY(`lead_attribution_id`)
) COMMENT 'Attribution record linking a converted lead to one or more marketing campaigns and channels using multi-touch attribution models (first-touch, last-touch, linear, time-decay, data-driven). Captures lead reference, conversion event type (lease signed, purchase agreement, showing booked), conversion date, attributed campaign references, attribution model used, attribution weight per campaign, attributed revenue or deal value, and attribution calculation timestamp. Enables ROI measurement per campaign and channel.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`digital_listing` (
    `digital_listing_id` BIGINT COMMENT 'Unique surrogate identifier for the digital listing record in the marketing layer. Primary key for this entity. MASTER_RESOURCE role — serves as the canonical marketing content record for a property listing published across owned and paid channels.',
    `asset_id` BIGINT COMMENT 'Reference to the underlying property asset that this digital listing promotes. Links the marketing content layer to the physical property master record.',
    `brokerage_broker_id` BIGINT COMMENT 'Reference to the broker or leasing agent responsible for this listing from a marketing coordination perspective. Used for lead routing, inquiry response assignment, and listing ownership tracking.',
    `building_class_id` BIGINT COMMENT 'Foreign key linking to reference.building_class. Business justification: Digital listings display building class to prospective tenants and buyers. Normalizing property_class to reference.building_class ensures consistent class labeling across listing platforms and enables',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign under which this digital listing is being promoted. Links the listing to campaign budget, channel strategy, and performance attribution in the marketing domain.',
    `green_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.green_certification. Business justification: Digital listings advertise green certifications (LEED Gold, BREEAM Excellent) as key selling points. Linking to the certification record ensures advertised credentials are verified, current, and not e',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Digital listings for properties under development or renovation require a valid Certificate of Occupancy or building permit before publication. Real estate marketing teams verify permit status before ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Digital listing content approval is a named compliance process in real estate — fair housing and MLS accuracy requirements mandate that a licensed employee approves listing content. content_approved_',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Digital listings for new developments must reference the dev_project to display accurate construction completion dates, unit availability, and project status. This is a standard new-development market',
    `space_id` BIGINT COMMENT 'Foreign key linking to property.space. Business justification: Commercial RE digital listings advertise specific leasable spaces (suites, floors). Brokers and leasing agents create space-level listings for CoStar/LoopNet. This link enables space-level leasing pip',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: Residential and multifamily digital listings advertise specific available units. Leasing teams publish unit-level listings (with unit number, floor, configuration) to portals. This link enables unit-l',
    `superseded_digital_listing_id` BIGINT COMMENT 'Self-referencing FK on digital_listing (superseded_digital_listing_id)',
    `asking_price` DECIMAL(18,2) COMMENT 'Advertised sale price for the property in the listing currency. Applicable when listing_type is for_sale or auction. Represents the marketing-layer asking price, which may differ from the appraised or transacted value.',
    `asking_rent_max` DECIMAL(18,2) COMMENT 'Maximum advertised annual or monthly rent for the property. Applicable when listing_type is for_lease. Represents the upper bound of the marketed rent range.',
    `asking_rent_min` DECIMAL(18,2) COMMENT 'Minimum advertised annual or monthly rent for the property. Applicable when listing_type is for_lease. Represents the lower bound of the marketed rent range.',
    `asking_rent_psf` DECIMAL(18,2) COMMENT 'Advertised rent rate expressed on a Per Square Foot (PSF) basis, the standard commercial real estate pricing metric. Used for CRE portal display and market comparability analysis.',
    `available_from_date` DATE COMMENT 'The earliest date on which the property is available for occupancy or transfer of possession. Displayed on portal listings and used in tenant/buyer search filtering.',
    `available_sqft` DECIMAL(18,2) COMMENT 'Total square footage of space available for lease or sale as marketed in this listing. Expressed in Square Feet (SQF). May represent Net Leasable Area (NLA) or Gross Leasable Area (GLA) depending on property class.',
    `available_sqm` DECIMAL(18,2) COMMENT 'Total square meters of space available for lease or sale as marketed in this listing. Expressed in Square Meters (SQM) for international portal syndication and cross-border investor reporting.',
    `bathroom_count` DECIMAL(18,2) COMMENT 'Number of bathrooms in the property, expressed as a decimal to accommodate half-baths (e.g., 2.5). Applicable to residential listings and standard MLS search criteria.',
    `bedroom_count` STRING COMMENT 'Number of bedrooms in the property. Applicable to residential listings. Standard search filter on residential portals (MLS, Zillow, Realtor.com).',
    `content_approved_date` DATE COMMENT 'Date on which the listing content was formally approved for publication by the designated approver. Part of the editorial governance and compliance audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this digital listing record was first created in the marketing system. Audit field supporting data lineage, SLA measurement, and listing lifecycle analytics.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to all monetary fields on this listing (asking_price, asking_rent_min, asking_rent_max, asking_rent_psf). Supports multi-currency international portfolio marketing.. Valid values are `^[A-Z]{3}$`',
    `exclusive_listing` BOOLEAN COMMENT 'Indicates whether this is an exclusive off-market or pre-market listing not syndicated to external portals. Exclusive listings are marketed only through proprietary channels to select investor or tenant audiences.',
    `expiry_date` DATE COMMENT 'The date on which this digital listing is scheduled to expire or be automatically archived. Supports time-limited marketing campaigns and listing agreement term enforcement.',
    `fair_housing_compliant` BOOLEAN COMMENT 'Indicates whether the listing content has been reviewed and confirmed compliant with the Fair Housing Act (FHA) and applicable anti-discrimination advertising regulations. Mandatory compliance checkpoint before publication.',
    `featured_listing` BOOLEAN COMMENT 'Indicates whether this listing has been designated as a featured or premium listing on owned digital channels. Featured listings receive elevated placement, homepage exposure, and priority in search results.',
    `floor_count` STRING COMMENT 'Number of floors included in the available space being marketed. Relevant for multi-floor commercial listings where a tenant may occupy partial or full floors.',
    `floor_plan_url` STRING COMMENT 'URL to the floor plan document or interactive floor plan viewer for the property. Supports PDF, SVG, or BIM-derived floor plan formats. Critical for commercial leasing marketing.. Valid values are `^https?://.+`',
    `key_selling_points` STRING COMMENT 'Pipe-delimited or structured summary of the top 3–5 marketing highlights for the property (e.g., Corner unit|Panoramic views|LEED Gold certified). Used for bullet-point display in portal listings and digital ads.',
    `listing_code` STRING COMMENT 'Externally-visible alphanumeric business identifier for this digital listing, used in marketing collateral, URLs, and cross-channel references. Distinct from the brokerage MLS number — this is the marketing content identifier.. Valid values are `^MKT-[A-Z0-9]{4,20}$`',
    `listing_headline` STRING COMMENT 'Short, attention-grabbing marketing headline for the property listing, displayed as the primary title across digital channels, portals, and search results. Typically 60–120 characters.',
    `listing_status` STRING COMMENT 'Current lifecycle state of the digital listing as published in the marketing channel. Controls visibility and editorial workflow: draft (not yet published), active (live and searchable), under_offer (offer received, still visible), leased/sold (transaction completed), archived (removed from active channels).. Valid values are `draft|active|under_offer|leased|sold|archived`',
    `listing_type` STRING COMMENT 'Indicates whether the property is being marketed for sale, lease, or both. Drives channel routing, pricing display logic, and lead qualification workflows.. Valid values are `for_sale|for_lease|for_sale_or_lease|auction`',
    `marketing_description` STRING COMMENT 'Full-length marketing copy describing the propertys features, location advantages, and investment or occupancy appeal. Used in portal listings, email campaigns, and brochures. Distinct from legal property descriptions.',
    `parking_spaces` STRING COMMENT 'Number of dedicated parking spaces included or available with the marketed property. Key amenity field for both commercial and residential listings.',
    `photo_count` STRING COMMENT 'Total number of approved marketing photos associated with this listing. Used to assess listing completeness and portal compliance (many portals require a minimum photo count for featured placement).',
    `photo_gallery_url` STRING COMMENT 'URL to the curated photo gallery or media asset folder for this listing. May reference a CDN path, DAM system folder, or portal-specific media endpoint. Primary visual marketing asset reference.. Valid values are `^https?://.+`',
    `publish_date` DATE COMMENT 'The date on which this digital listing was first made publicly visible across marketing channels. Used to calculate days on market (DOM) and measure listing freshness for SEO and portal ranking.',
    `seo_keywords` STRING COMMENT 'Comma-separated list of target search keywords associated with this listing for organic search optimization. Used by the marketing team to track keyword targeting strategy per listing.',
    `seo_meta_description` STRING COMMENT 'Search Engine Optimization (SEO) meta description tag for the listings web page. Typically 150–160 characters. Used by search engines for snippet display and influences organic click-through rates.',
    `seo_slug` STRING COMMENT 'URL-friendly slug for the listings canonical web page (e.g., 123-main-street-downtown-office-for-lease). Used to construct the listings permanent URL and supports SEO link equity.. Valid values are `^[a-z0-9-]+$`',
    `seo_title` STRING COMMENT 'Search Engine Optimization (SEO) page title tag for the listings web page. Typically 50–60 characters. Distinct from the listing_headline — optimized for search engine indexing and click-through rate.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this digital listing record originated or was last updated. Supports data lineage tracking in the Silver layer lakehouse architecture.. Valid values are `salesforce|yardi|mri|manual|api`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this digital listing record was last modified. Used to detect stale listings, trigger re-syndication workflows, and support incremental ETL processing in the Databricks Silver layer.',
    `video_url` STRING COMMENT 'URL to the property marketing video (drone footage, walkthrough video, or brand video). Hosted on YouTube, Vimeo, or proprietary CDN. Supports video-first digital advertising campaigns.. Valid values are `^https?://.+`',
    `virtual_tour_url` STRING COMMENT 'Publicly accessible URL to the 3D virtual tour or interactive walkthrough of the property. Supports Matterport, iGUIDE, and similar virtual tour platforms. Drives engagement and reduces unnecessary physical showings.. Valid values are `^https?://.+`',
    `year_built` STRING COMMENT 'The calendar year in which the property was originally constructed. Used in marketing copy, portal search filters, and comparative market analysis (CMA).',
    CONSTRAINT pk_digital_listing PRIMARY KEY(`digital_listing_id`)
) COMMENT 'Marketing-owned master record for the digital presentation of a property listing as published across owned and paid channels — the marketing-layer representation of a property for promotional purposes. Captures property reference, listing headline, marketing description copy, key selling points, asking price or rent range, property highlights, virtual tour URL, photo gallery references, floor plan URL, video URL, listing status (draft, active, under offer, leased, sold, archived), publish date, and SEO metadata. Distinct from brokerage.listing (brokerage transaction record) — this is the marketing content layer.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`market_research` (
    `market_research_id` BIGINT COMMENT 'Unique system-generated identifier for each market research record. Primary key for the market_research data product.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to property.asset. Business justification: Market research reports are frequently commissioned for specific assets (pre-acquisition feasibility, lease-up strategy, disposition support). Asset managers expect research to be retrievable by asset',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Market research reports for international real estate portfolios are scoped by country. Normalizing country_code enables joining research data with country-level attributes (REIT framework, foreign ow',
    `fund_id` BIGINT COMMENT 'Foreign key linking to investment.fund. Business justification: Market research commissioned to support fund-level investment strategy decisions (new market entry, sector allocation) must be traceable to the commissioning fund. Fund managers use this research in I',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Market research reports are fundamentally geographic — vacancy rates, absorption, and cap rates are reported by submarket or MSA. Normalizing to geographic_hierarchy enables joining research data with',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Market research publication and distribution processes require proper employee attribution for the lead analyst and commissioning manager. Role-prefixed lead_analyst_employee_id used; lead_analyst',
    `owner_id` BIGINT COMMENT 'Foreign key linking to owner.owner. Business justification: Market research in real estate is routinely commissioned by specific owners for acquisition, disposition, or portfolio valuation decisions. Linking research to the commissioning owner enables owner-le',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Market research reports (vacancy, absorption, cap rates) are fundamentally scoped to a property type. Normalizing enables cross-report aggregation and comparison against reference benchmarks like cap_',
    `superseded_by_market_research_id` BIGINT COMMENT 'Reference to the market_research_id of the newer research record that supersedes or replaces this study. Enables version chaining and ensures users are directed to the most current market intelligence.',
    `prior_market_research_id` BIGINT COMMENT 'Self-referencing FK on market_research (prior_market_research_id)',
    `avg_asking_rent_psf` DECIMAL(18,2) COMMENT 'Average asking rent per square foot (PSF) for the subject market or submarket as reported in the research study. Expressed in the local currency. Core metric for rent benchmarking and lease negotiation support.',
    `cap_rate` DECIMAL(18,2) COMMENT 'Market or submarket prevailing capitalization rate (CAP Rate) as reported in the research study (e.g., 0.0550 = 5.50%). Used for investment valuation benchmarking and portfolio performance comparison.',
    `commission_cost` DECIMAL(18,2) COMMENT 'Total cost incurred to commission or procure the market research study from a third-party provider. Expressed in the currency defined by currency_code. Used for marketing budget tracking and vendor spend analysis.',
    `competitive_set_count` STRING COMMENT 'Number of comparable or competitive properties included in the research studys competitive set or comparable universe. Indicates the breadth and statistical robustness of the competitive analysis.',
    `confidentiality_level` STRING COMMENT 'Data classification and distribution restriction level assigned to the market research report. Controls access permissions and sharing protocols in accordance with GDPR and internal data governance policies.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the market research record was first created in the data platform. Supports audit trail, data lineage, and SOX compliance requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to all monetary metrics reported in the research study (e.g., USD, GBP, EUR). Ensures consistent financial interpretation across multi-market research assets.. Valid values are `^[A-Z]{3}$`',
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

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`competitor_property` (
    `competitor_property_id` BIGINT COMMENT 'Unique surrogate identifier for the competitor property record in the marketing competitive intelligence dataset.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to property.asset. Business justification: Competitive analysis maps each tracked competitor property to the owned subject asset it benchmarks against. Asset managers use this link to generate competitive positioning reports and rent gap analy',
    `building_class_id` BIGINT COMMENT 'Foreign key linking to reference.building_class. Business justification: Competitive analysis in CRE tracks building class (Class A/B/C) of competing properties. Normalizing to reference.building_class enables comparison of competitor rent benchmarks against reference clas',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Competitive property tracking for international real estate portfolios requires country-level context (property law, foreign ownership, valuation standards). Normalizing country_code enables cross-bor',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Competitive set analysis in real estate is organized by submarket. Normalizing competitor_property submarket to geographic_hierarchy enables distance-to-subject calculations and submarket-level compet',
    `listing_id` BIGINT COMMENT 'The unique listing identifier assigned by LoopNet for this competitor property, enabling direct cross-reference to the LoopNet commercial real estate marketplace.',
    `market_research_id` BIGINT COMMENT 'Foreign key linking to marketing.market_research. Business justification: competitor_property records are tracked as part of competitive market intelligence, which is the primary input to market_research studies. Linking competitor_property to market_research identifies whi',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Competitive set analysis in real estate is organized by property type. Normalizing competitor_property.property_type to reference enables filtering competitive benchmarks against owned portfolio by as',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: Competitive analysis in CRE tracks the lease structure offered by competing properties (NNN vs. gross). Normalizing enables comparison of competitor lease terms against owned portfolio lease structure',
    `sustainability_rating_id` BIGINT COMMENT 'Foreign key linking to reference.sustainability_rating. Business justification: Competitive analysis tracks green certifications (LEED, BREEAM, Energy Star) of competing properties. Normalizing to reference.sustainability_rating enables ESG benchmarking and premium rent uplift an',
    `replaced_competitor_property_id` BIGINT COMMENT 'Self-referencing FK on competitor_property (replaced_competitor_property_id)',
    `address_line1` STRING COMMENT 'Primary street address of the competitor property used for geographic identification and submarket mapping.',
    `address_line2` STRING COMMENT 'Secondary address line (suite, floor, unit) for the competitor property.',
    `amenities_description` STRING COMMENT 'Free-text description of key amenities and features offered at the competitor property (e.g., fitness center, rooftop terrace, covered parking, LEED certification, on-site management). Used for qualitative competitive positioning.',
    `asking_price` DECIMAL(18,2) COMMENT 'The listed asking sale price for the competitor property if it is offered for sale, used for investment benchmarking and Comparative Market Analysis (CMA).',
    `asking_rent_psf` DECIMAL(18,2) COMMENT 'The advertised or quoted annual asking rent per square foot (PSF) for the competitor property, used for pricing benchmarking and competitive rent analysis.',
    `avg_unit_size_sqft` DECIMAL(18,2) COMMENT 'Average size of a leasable unit or suite in square feet (SQF) at the competitor property. Applicable to multifamily and multi-tenant commercial properties for unit-level benchmarking.',
    `cap_rate` DECIMAL(18,2) COMMENT 'The estimated or reported capitalization rate (CAP Rate) for the competitor property, expressed as a percentage. Used for investment yield benchmarking and portfolio valuation context.',
    `city` STRING COMMENT 'City in which the competitor property is located, used for geographic segmentation and submarket analysis.',
    `competitive_tier` STRING COMMENT 'Classification of the competitor property within the competitive set hierarchy (Primary — direct competitor, Secondary — indirect competitor, Tertiary — peripheral market participant). Used to prioritize monitoring effort.. Valid values are `Primary|Secondary|Tertiary`',
    `concession_notes` STRING COMMENT 'Free-text notes describing known leasing concessions offered by the competitor (e.g., free rent periods, Tenant Improvement (TI) allowances, reduced CAM charges). Used for competitive deal structuring intelligence.',
    `costar_property_code` STRING COMMENT 'The unique property identifier assigned by CoStar Suite, used to cross-reference and retrieve updated market intelligence from the CoStar platform.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the asking rent and asking price fields (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'The primary source from which this competitor property record was obtained or verified (e.g., CoStar, LoopNet, MLS, Field Survey, Broker Intel, Public Record). Used for data lineage and confidence scoring.. Valid values are `CoStar|LoopNet|MLS|Field Survey|Broker Intel|Public Record`',
    `distance_to_subject_miles` DECIMAL(18,2) COMMENT 'Straight-line distance in miles from this competitor property to the subject (own) property being benchmarked, used for proximity-based competitive set definition.',
    `last_verified_date` DATE COMMENT 'The most recent date on which the competitor property data was verified or refreshed from the data source. Used to assess data currency and trigger re-verification workflows.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the competitor property in decimal degrees, used for Geographic Information System (GIS) mapping and proximity analysis.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the competitor property in decimal degrees, used for Geographic Information System (GIS) mapping and proximity analysis.',
    `marketing_channels` STRING COMMENT 'Comma-separated list of marketing channels used by the competitor to advertise this property (e.g., CoStar, LoopNet, MLS, broker network, direct email, social media). Used to benchmark marketing channel strategy.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next competitive intelligence review or data refresh for this competitor property record.',
    `number_of_floors` STRING COMMENT 'Total number of above-grade floors in the competitor property building, used for structural classification and competitive positioning.',
    `number_of_units` STRING COMMENT 'Total number of leasable units or suites within the competitor property. Applicable primarily to multifamily, retail, and mixed-use properties for unit-level competitive comparison.',
    `occupancy_rate` DECIMAL(18,2) COMMENT 'The percentage of total rentable area currently occupied by tenants at the competitor property, expressed as a decimal percentage (e.g., 92.50 = 92.5%). Used for vacancy benchmarking and competitive set analysis.',
    `owner_operator_name` STRING COMMENT 'Name of the company or individual that owns or operates the competitor property, used for competitive intelligence on ownership concentration and operator strategy.',
    `parking_ratio` DECIMAL(18,2) COMMENT 'The number of parking spaces available per 1,000 square feet of rentable area at the competitor property, used as a competitive amenity metric in office and retail market analysis.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the competitor property location, used for geographic clustering and submarket boundary analysis.. Valid values are `^[0-9A-Z- ]{3,10}$`',
    `property_name` STRING COMMENT 'The marketing or trade name of the competitor property as publicly known or listed in market data sources such as CoStar or LoopNet.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this competitor property record was first created in the marketing competitive intelligence dataset. Used for audit trail and data lineage.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this competitor property record was most recently updated in the marketing competitive intelligence dataset. Used for change tracking and data freshness monitoring.',
    `state_province` STRING COMMENT 'State or province in which the competitor property is located, used for regulatory jurisdiction and market segmentation.',
    `total_rentable_area_sqft` DECIMAL(18,2) COMMENT 'Total rentable area of the competitor property measured in square feet (SQF), representing the gross leasable area (GLA) available for tenant occupancy. Used for size-based competitive benchmarking.',
    `tracking_status` STRING COMMENT 'Current lifecycle status of this competitor property record within the competitive intelligence monitoring program (e.g., Active — currently monitored, Inactive — no longer tracked, Archived — historical record).. Valid values are `Active|Inactive|Archived|Under Review`',
    `verified_by` STRING COMMENT 'Name or identifier of the analyst, broker, or team member who last verified the accuracy of this competitor property record.',
    `website_url` STRING COMMENT 'Public website URL for the competitor property or its marketing page, used for ongoing monitoring of competitor marketing messaging and digital presence.. Valid values are `^https?://.+$`',
    `year_built` STRING COMMENT 'The calendar year in which the competitor property was originally constructed, used for age-based quality benchmarking and capital expenditure (CAPEX) assessment.',
    `year_renovated` STRING COMMENT 'The calendar year of the most recent major renovation or capital improvement to the competitor property, used to assess competitive positioning relative to asset quality.',
    CONSTRAINT pk_competitor_property PRIMARY KEY(`competitor_property_id`)
) COMMENT 'Master record for competitor properties tracked as part of competitive market intelligence — comparable properties in the same submarket used for competitive positioning, pricing benchmarking, and marketing strategy. Captures competitor property name, address, owner or operator name, property type, building class, total rentable area, number of units, asking rent or price, occupancy rate, amenities, marketing channels used, last verified date, and data source (CoStar, LoopNet, field survey, broker intel). Enables competitive set monitoring.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`market_survey` (
    `market_survey_id` BIGINT COMMENT 'Unique system-generated identifier for each market survey record. Primary key for the market_survey data product.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to property.asset. Business justification: Market surveys are commissioned for specific assets to support leasing strategy, rent setting, and investment committee reporting. Linking surveys to the subject asset enables asset-level market intel',
    `building_class_id` BIGINT COMMENT 'Foreign key linking to reference.building_class. Business justification: Market surveys in CRE report rent and vacancy by building class. Normalizing property_class to reference.building_class enables joining survey data with reference class benchmarks for investment under',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Market surveys for international real estate require country context for measurement standards, currency, and regulatory reporting. Normalizing country_code enables joining survey data with country-le',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Market surveys are scoped to specific submarkets or MSAs. Normalizing submarket_name and submarket_code to geographic_hierarchy enables time-series market trend analysis and comparison across geograph',
    `market_research_id` BIGINT COMMENT 'Foreign key linking to marketing.market_research. Business justification: market_survey is a periodic point-in-time competitive data collection event that feeds into formal market_research studies. Linking market_survey to market_research enables aggregation of survey data ',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Market surveys (rent, vacancy, absorption) are scoped to a property type. Normalizing enables joining survey data with reference benchmarks (ti_allowance_benchmark_psf, cap_rate_benchmark_pct) for inv',
    `prior_market_survey_id` BIGINT COMMENT 'Self-referencing FK on market_survey (prior_market_survey_id)',
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
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all monetary survey values (rents, concessions) are denominated (e.g., USD, CAD, GBP). Required for multi-currency portfolio reporting.. Valid values are `^[A-Z]{3}$`',
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

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`marketing_budget` (
    `marketing_budget_id` BIGINT COMMENT 'Unique system-generated identifier for the marketing budget record. Primary key for the marketing_budget data product.',
    `asset_id` BIGINT COMMENT 'Reference to the specific property this marketing budget is allocated for. Null when the budget is at portfolio or enterprise level rather than a single property.',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Marketing budgets for multi-building campuses are allocated at the building level. Property managers track leasing marketing spend per building for NOI reporting and budget variance analysis. marketin',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign this budget record funds. Null when the budget is a general property or portfolio-level allocation not tied to a specific campaign.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: marketing_budget.channel_type is a STRING denoting the channel category for budget allocation. Normalizing to channel_id FK links the budget record to the authoritative channel master, enabling retrie',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Marketing budget lines are mapped to GL accounts for financial reporting and budget-vs-actual variance analysis. marketing_budget.gl_account_code is a denormalized string reference. A FK to chart_of_a',
    `cost_center_id` BIGINT COMMENT 'Reference to the General Ledger (GL) cost center to which this marketing spend is charged, enabling financial consolidation and OPEX tracking.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Marketing budget financial reporting for international real estate portfolios requires normalized currency references. Normalizing enables FX-adjusted budget variance reporting and consolidated approv',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Marketing budgets are allocated per development project for pre-sales and lease-up campaigns. marketing_budget has asset_id and portfolio_id but no dev_project_id. Tracking marketing spend by developm',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Real estate marketing budgets must reconcile against the corporate finance budget for the same property/fiscal year. Controllers require this link for budget-vs-actual reporting and period-close sign-',
    `fund_id` BIGINT COMMENT 'Foreign key linking to investment.fund. Business justification: Marketing budgets in real estate are allocated at the fund level for LP outreach, fund launch, and investor relations spend. Fund-level marketing expense reporting requires linking budget records to t',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Marketing budget planning and variance reporting in real estate is managed at the org unit level (regional division, property management group). Budget approval workflows and divisional spend accounta',
    `owner_id` BIGINT COMMENT 'Foreign key linking to owner.owner. Business justification: Marketing budgets in real estate are frequently funded and approved by property owners under management agreements. Owner-level budget tracking is required for owner statements, reimbursement workflow',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment or property portfolio this marketing budget is allocated for. Null when the budget is scoped to a single property or campaign.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or team member who owns and is accountable for this marketing budget allocation.',
    `sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: Marketing budget approval processes at public REITs are governed by SOX controls on financial reporting and authorization. Linking marketing_budget to the relevant SOX control enables SOX testers to v',
    `revised_marketing_budget_id` BIGINT COMMENT 'Self-referencing FK on marketing_budget (revised_marketing_budget_id)',
    `actual_spend` DECIMAL(18,2) COMMENT 'Total marketing expenditure actually incurred and recorded against this budget to date, sourced from Accounts Payable (AP) and General Ledger (GL) postings in Yardi Voyager or SAP S/4HANA.',
    `approval_date` DATE COMMENT 'The date on which this marketing budget was formally approved by the authorized approver. Null if the budget is still in draft or pending approval status.',
    `approved_amount` DECIMAL(18,2) COMMENT 'The formally approved total marketing spend allocation for this budget record and period. Represents the baseline authorized Capital Expenditure (CAPEX) or Operating Expenditure (OPEX) for marketing activities.',
    `budget_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this marketing budget record, used for cross-system reference and reporting (e.g., MKT-2024-Q1-CRE-001). Sourced from SAP S/4HANA or Yardi Voyager budget module.. Valid values are `^MKT-[A-Z0-9]{4,20}$`',
    `budget_name` STRING COMMENT 'Human-readable descriptive name for this marketing budget record (e.g., Q1 2024 Downtown Office Tower Digital Campaign Budget). Used for display and reporting purposes.',
    `budget_scope` STRING COMMENT 'Defines the organizational scope of this budget allocation: property-level (single asset), portfolio-level (group of assets), campaign-level (specific marketing campaign), channel-level (specific marketing channel), or enterprise-wide.. Valid values are `property|portfolio|campaign|channel|enterprise`',
    `budget_status` STRING COMMENT 'Current lifecycle state of the marketing budget record. Tracks progression from initial draft through approval, active spend, and final closure. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|on_hold|closed|cancelled — promote to reference product]',
    `budget_type` STRING COMMENT 'Classification of the budget record: original (initial approved budget), revised (formally amended budget), supplemental (additional allocation added mid-period), or contingency (reserve held for unplanned spend).. Valid values are `original|revised|supplemental|contingency`',
    `committed_amount` DECIMAL(18,2) COMMENT 'Total marketing spend that has been contractually committed or purchase-ordered but not yet invoiced or paid. Represents encumbered budget that reduces available balance.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this marketing budget record was first created in the system. Supports audit trail and data lineage requirements.',
    `fiscal_month` STRING COMMENT 'The fiscal month (1–12) within the fiscal year to which this budget applies. Null for annual or quarterly budgets. Enables monthly budget-to-actual variance reporting.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter (1–4) within the fiscal year to which this budget applies. Null for annual or campaign-period budgets that span multiple quarters.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this marketing budget applies (e.g., 2024). Aligns with the enterprise financial calendar as defined in SAP S/4HANA and Yardi Voyager.',
    `last_revised_date` DATE COMMENT 'The date on which the most recent formal revision to this budget was made. Null if no revision has occurred since initial approval.',
    `notes` STRING COMMENT 'Free-text field for budget owner or approver commentary, including rationale for budget amounts, revision justifications, or special conditions attached to the budget approval.',
    `opex_capex_flag` STRING COMMENT 'Indicates whether this marketing budget is classified as Operating Expenditure (OPEX) — recurring operational spend — or Capital Expenditure (CAPEX) — investment in long-term marketing assets such as brand development or major campaign infrastructure.. Valid values are `OPEX|CAPEX`',
    `period_end_date` DATE COMMENT 'The last date of the budget period during which marketing spend is authorized. Defines the effective end of the budget allocation window.',
    `period_start_date` DATE COMMENT 'The first date of the budget period during which marketing spend is authorized. Defines the effective start of the budget allocation window.',
    `period_type` STRING COMMENT 'Granularity of the budget period: annual (full fiscal year), quarterly (three-month period), monthly (single calendar month), or campaign (tied to a specific campaign duration regardless of calendar period).. Valid values are `annual|quarterly|monthly|campaign`',
    `property_class` STRING COMMENT 'Classification of the property type this marketing budget targets, enabling segmentation of marketing spend across Commercial Real Estate (CRE), residential, mixed-use, industrial, or land portfolios.. Valid values are `commercial|residential|mixed_use|industrial|land`',
    `revised_amount` DECIMAL(18,2) COMMENT 'The most recently revised or amended approved budget amount, reflecting any formal budget adjustments made after initial approval. Null if no revision has been made.',
    `source_budget_ref` STRING COMMENT 'The native identifier or reference number of this budget record in the originating source system (e.g., Yardi Voyager budget ID, SAP internal order number). Enables cross-system reconciliation.',
    `source_system` STRING COMMENT 'The operational system of record from which this marketing budget record originated (e.g., Yardi Voyager, SAP S/4HANA, Salesforce CRM, or manually entered). Supports data lineage and reconciliation.. Valid values are `Yardi Voyager|SAP S/4HANA|Salesforce CRM|Manual`',
    `submission_date` DATE COMMENT 'The date on which this marketing budget was formally submitted for approval. Supports audit trail and approval cycle time analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this marketing budget record was most recently modified. Supports change tracking, audit trail, and incremental data pipeline processing.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between the approved (or revised) budget amount and actual spend to date. Positive value indicates underspend; negative value indicates overspend. Supports budget performance monitoring and financial reporting.',
    `version` STRING COMMENT 'Sequential version number of this budget record, incremented each time a formal revision is approved. Version 1 represents the original approved budget. Supports budget revision history tracking.',
    CONSTRAINT pk_marketing_budget PRIMARY KEY(`marketing_budget_id`)
) COMMENT 'Marketing-domain budget record defining the approved marketing spend allocation by campaign, channel, property, portfolio, or fiscal period. Captures budget name, fiscal year, budget period (annual, quarterly, monthly), property or portfolio reference, campaign reference, channel type, approved budget amount, revised budget amount, committed spend, actual spend to date, variance, budget owner, approval date, and approval status. Distinct from finance.budget (enterprise GL budget) — this is the marketing operational spend plan.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`ad_spend` (
    `ad_spend_id` BIGINT COMMENT 'Unique system-generated identifier for each advertising expenditure record. Primary key for the ad_spend data product.',
    `asset_id` BIGINT COMMENT 'Reference to the specific property or asset being marketed by this spend event. Enables property-level marketing spend analysis and Return on Investment (ROI) attribution.',
    `campaign_flight_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_flight. Business justification: ad_spend.campaign_flight_ref is a STRING reference to the campaign flight. Normalizing to campaign_flight_id FK enables precise spend attribution at the flight level (flight budget vs. actual spend re',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign under which this advertising spend was incurred. Links the spend event to a campaign flight for attribution and budget reconciliation.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: ad_spend.channel is a STRING. Normalizing to channel_id FK links actual spend to the channel master record, enabling cost model validation, benchmark CPM/CPC comparisons, and channel-level ROI reporti',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Ad spend must be coded to specific GL accounts (marketing opex, leasing commissions, advertising expense) for NOI statement preparation and FASB/IFRS compliance. ad_spend.gl_account_code is a denormal',
    `cost_center_id` BIGINT COMMENT 'Reference to the organizational cost center responsible for this advertising expenditure. Used for General Ledger (GL) allocation and financial reporting.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Ad spend financial reporting and AP processing for international real estate marketing requires normalized currency. Normalizing enables FX-adjusted spend reporting and GL posting with correct currenc',
    `finance_budget_id` BIGINT COMMENT 'Reference to the marketing budget line against which this spend is charged. Enables budget-vs-actual reconciliation at the campaign or portfolio level.',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio or property portfolio to which this advertising spend is attributed. Enables portfolio-level marketing spend analysis and Assets Under Management (AUM) reporting.',
    `sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: For publicly traded REITs, marketing ad spend authorization is subject to SOX controls on financial reporting. Linking ad_spend to the governing SOX control enables auditors to verify that spend appro',
    `vendor_id` BIGINT COMMENT 'System identifier for the vendor or advertising platform in the Accounts Payable (AP) or procurement system. Enables vendor-level spend aggregation and supplier management.',
    `reversed_ad_spend_id` BIGINT COMMENT 'Self-referencing FK on ad_spend (reversed_ad_spend_id)',
    `approval_status` STRING COMMENT 'Internal approval workflow status for this advertising spend. Tracks whether the spend has been submitted, approved by the budget owner, or rejected. Supports SOX financial controls.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the budget owner or manager who approved this advertising spend. Required for SOX financial controls and internal audit trail.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this advertising spend was formally approved by the budget owner. Distinct lifecycle event from record creation; required for SOX audit trail.',
    `contract_ref` STRING COMMENT 'Reference to the master service agreement or media contract with the vendor or agency under which this spend was incurred. Used for contract compliance and spend-against-commitment tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this advertising spend record was first captured in the system. Used for audit trail and data lineage tracking.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount or credit applied to this advertising spend by the vendor or platform (e.g., volume discount, early payment discount, promotional credit). Reduces the gross spend_amount to arrive at net_amount.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign currency exchange rate applied to convert the transaction currency amount to the functional reporting currency at the time of the spend. Required for multi-currency portfolio consolidation.',
    `fiscal_period` STRING COMMENT 'Fiscal year and month (YYYY-MM) to which this advertising spend is attributed for financial reporting and budget reconciliation. May differ from spend_date when accruals are applied.. Valid values are `^d{4}-(0[1-9]|1[0-2])$`',
    `invoice_date` DATE COMMENT 'Date on which the vendor or platform issued the invoice for this advertising spend. May differ from spend_date due to billing cycles or post-period invoicing.',
    `is_accrual` BOOLEAN COMMENT 'Indicates whether this spend record represents an accrued expense (True) rather than an actual cash payment (False). Accruals are posted when the service has been received but the invoice has not yet been processed.',
    `is_capitalized` BOOLEAN COMMENT 'Indicates whether this advertising spend is classified as Capital Expenditure (CAPEX) (True) rather than Operating Expenditure (OPEX) (False). Relevant for development-phase marketing costs that may be capitalized under FASB ASC 340.',
    `listing_type` STRING COMMENT 'Indicates whether the advertising spend supports a property for sale, for lease, or both. Used to align spend with transaction type for brokerage and leasing performance attribution.. Valid values are `sale|lease|both`',
    `net_amount` DECIMAL(18,2) COMMENT 'Net total amount of this advertising spend after applying any discounts, credits, or adjustments. Represents the final financial obligation for this spend event. Part of the monetary triplet with spend_amount and tax_amount.',
    `notes` STRING COMMENT 'Free-text field for additional context, justification, or commentary on this advertising spend record. May include campaign rationale, vendor negotiation notes, or reconciliation remarks.',
    `payment_date` DATE COMMENT 'Date on which payment was remitted to the vendor or platform for this advertising spend. Used for cash flow reporting and Accounts Payable (AP) aging analysis.',
    `payment_status` STRING COMMENT 'Current payment lifecycle state of this advertising spend record. Tracks whether the spend has been approved, paid to the vendor or platform, disputed, or cancelled.. Valid values are `pending|approved|paid|disputed|cancelled|voided`',
    `platform_name` STRING COMMENT 'Specific digital platform or media outlet where the advertisement was placed (e.g., Zillow, LoopNet, CoStar, Google Ads, Facebook Ads, Instagram, LinkedIn, MLS portal). More granular than channel.',
    `po_number` STRING COMMENT 'Purchase Order number issued to the vendor or agency for this advertising spend. Links the spend event to the procurement workflow and enables three-way matching with invoice and receipt.',
    `property_type` STRING COMMENT 'Classification of the property type being marketed by this spend. Enables segmentation of advertising spend between commercial and residential portfolios for portfolio-level reporting.. Valid values are `commercial|residential|mixed_use|industrial|land`',
    `region_code` STRING COMMENT 'Geographic region or market code where the advertising spend was deployed (e.g., US-NY, US-CA, EMEA-UK). Enables regional marketing spend analysis and market-level budget allocation reporting.',
    `reporting_amount` DECIMAL(18,2) COMMENT 'Net spend amount converted to the functional reporting currency (e.g., USD) using the exchange_rate. Enables consistent cross-portfolio spend aggregation and financial consolidation reporting.',
    `source_record_code` STRING COMMENT 'Unique identifier of this spend record in the originating source system (e.g., Salesforce campaign expense ID, Yardi AP transaction ID). Enables traceability and deduplication during ETL.',
    `source_system` STRING COMMENT 'Operational system of record from which this advertising spend record originated (e.g., Salesforce CRM, Yardi Voyager, SAP S/4HANA, manual entry). Used for data lineage and reconciliation.. Valid values are `salesforce|yardi|sap|manual|costar|other`',
    `spend_amount` DECIMAL(18,2) COMMENT 'Gross amount of the advertising expenditure as billed by the vendor or platform, in the transaction currency. This is the base monetary amount before any adjustments, discounts, or taxes.',
    `spend_category` STRING COMMENT 'Classification of the type of advertising expenditure. Segments spend into operational categories for budget allocation and Capital Expenditure (CAPEX) vs Operating Expenditure (OPEX) classification. [ENUM-REF-CANDIDATE: media_placement|creative_production|agency_fee|event_cost|print|digital_listing|signage|photography|video_production — promote to reference product]. Valid values are `media_placement|creative_production|agency_fee|event_cost|print|digital_listing`',
    `spend_date` DATE COMMENT 'The calendar date on which the advertising expenditure was incurred or the media buy was executed. This is the principal business event date used for period-level spend reporting and budget reconciliation.',
    `spend_ref` STRING COMMENT 'Externally-known business identifier for this spend transaction, such as a purchase order number, media buy reference, or agency booking reference. Used for cross-system reconciliation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to this advertising spend transaction (e.g., sales tax, VAT, GST). Captured separately from the base spend amount for tax reporting and recoverability analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this advertising spend record was last modified. Used for change tracking, audit compliance, and incremental data pipeline processing.',
    CONSTRAINT pk_ad_spend PRIMARY KEY(`ad_spend_id`)
) COMMENT 'Transactional record of actual advertising expenditure events — individual media buys, platform charges, agency invoices, and production costs incurred against a campaign flight or marketing budget. Captures spend date, vendor or platform name, campaign flight reference, marketing budget reference, spend category (media placement, creative production, agency fee, event cost, print), invoice reference, amount, currency, payment status, and cost center. Enables granular spend tracking and budget reconciliation.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`event` (
    `event_id` BIGINT COMMENT 'Unique surrogate identifier for the marketing event record in the lakehouse silver layer. Primary key for this entity.',
    `asset_id` BIGINT COMMENT 'Reference to the specific property being featured or promoted at this event (e.g., open house, property launch). Nullable when the event is portfolio-level or brand-level.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: marketing_event.target_audience is a STRING. Marketing events (open houses, investor briefings, tenant appreciation events) are designed for specific audience segments. Normalizing to audience_segment',
    `building_class_id` BIGINT COMMENT 'Foreign key linking to reference.building_class. Business justification: Marketing events in CRE (open houses, broker tours) are targeted at specific building classes. Normalizing property_class enables event ROI reporting by asset quality tier and audience targeting by bu',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Property tours, broker open houses, and tenant events are held at specific buildings. Building-level event tracking enables access coordination, amenity booking, and post-event lead attribution by bui',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign under which this event is organized. Links event-level activity to campaign-level spend and performance tracking.',
    `certificate_of_insurance_id` BIGINT COMMENT 'Foreign key linking to insurance.certificate_of_insurance. Business justification: Real estate marketing events (open houses, broker tours, property showcases) require a Certificate of Insurance naming the property owner as additional insured before the event is approved. Event comp',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Marketing events (open houses, broker events, investor days) incur costs posted to property cost centers for NOI and opex reporting. marketing_event has cost_center_code as a plain string — a denormal',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Groundbreaking ceremonies, hard-hat tours, pre-sales launch events, and grand openings are marketing events directly tied to a specific development project. marketing_event has asset_id but not dev_pr',
    `employee_id` BIGINT COMMENT 'Reference to the internal employee or team member responsible for planning, executing, and reporting on this marketing event.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to investment.fund. Business justification: Fund roadshows, LP annual meetings, and investor days are marketing events tied to a specific fund. Fund managers track event attendance and LP engagement per fund for investor relations reporting and',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Open houses, investor days, and broker events are organized by specific org units (regional offices, property divisions). Event ROI and cost reporting by division is a standard real estate marketing m',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment or property portfolio associated with this event when the event spans multiple properties (e.g., investor day, portfolio roadshow). Nullable for single-property events.',
    `related_event_id` BIGINT COMMENT 'Self-referencing FK on event (related_event_id)',
    `actual_attendance` STRING COMMENT 'Confirmed number of individuals who physically or virtually attended the event. Populated post-event. Used to calculate attendance rate and measure event effectiveness.',
    `budgeted_cost` DECIMAL(18,2) COMMENT 'Planned budget allocated for the marketing event at the time of event approval. Compared against total_event_cost for variance analysis and OPEX management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this marketing event record was first created in the system. Used for audit trail, data lineage, and SLA compliance tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this event record (e.g., USD, CAD, GBP). Supports multi-currency portfolio reporting.. Valid values are `^[A-Z]{3}$`',
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
    `venue_city` STRING COMMENT 'City where the event venue is located. Supports geographic segmentation and market-level event performance reporting.',
    `venue_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the event venue (e.g., USA, CAN, GBR). Supports international portfolio event tracking.. Valid values are `^[A-Z]{3}$`',
    `venue_name` STRING COMMENT 'Name of the physical or virtual venue where the event is held (e.g., property address, hotel conference room, Zoom webinar). Used for logistics coordination and attendee communications.',
    `venue_state` STRING COMMENT 'Two-letter US state code (or equivalent province code) for the event venue. Supports regulatory compliance and geographic market reporting.. Valid values are `^[A-Z]{2}$`',
    `virtual_event_url` STRING COMMENT 'Registration or join link for virtual events. Distributed to registrants and used for attendance tracking. Nullable for in-person events.. Valid values are `^https?://.+`',
    `virtual_platform` STRING COMMENT 'Technology platform used to host the virtual event when is_virtual is True (e.g., Zoom, Microsoft Teams, Webex). Nullable for in-person events.. Valid values are `zoom|teams|webex|gotowebinar|youtube_live|other`',
    CONSTRAINT pk_event PRIMARY KEY(`event_id`)
) COMMENT 'Master record for marketing events organized or sponsored by the real estate enterprise — open houses, broker previews, investor days, property launch events, community outreach events, trade show participations, and webinars. Captures event name, event type, property or portfolio reference, venue, event date and time, target audience, expected attendance, actual attendance, registration count, event status, event owner, associated campaign reference, and total event cost. Enables event-driven lead generation tracking.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`event_registration` (
    `event_registration_id` BIGINT COMMENT 'Unique surrogate identifier for each event registration record in the marketing domain. Primary key for the event_registration data product.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that drove or is associated with this event registration, enabling campaign-level ROI attribution and lead source tracking.',
    `event_id` BIGINT COMMENT 'Reference to the parent marketing event (e.g., property showcase, investor briefing, broker open house, tenant networking event) for which this registration was created.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Post-event lead follow-up assignment is a named sales process in real estate — each event registrant is assigned to a specific agent for follow-up. follow_up_owner plain text is a denormalized emplo',
    `investor_id` BIGINT COMMENT 'Foreign key linking to investment.investor. Business justification: When an existing LP/investor registers for a fund event (annual meeting, roadshow, investor day), linking event_registration to investor enables LP engagement tracking and relationship management — a ',
    `lead_id` BIGINT COMMENT 'Reference to the CRM lead record if this registrant has been converted to or matched with an existing lead, enabling post-event pipeline attribution and deal tracking.',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Event registrants in real estate express interest in specific transaction types (purchase, lease, 1031 exchange). Normalizing enables post-event lead routing to the correct broker team and pipeline re',
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
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the registration fee amount (e.g., USD, EUR, GBP). Supports multi-currency event management for international portfolios.. Valid values are `^[A-Z]{3}$`',
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
    `preferred_market` STRING COMMENT 'Geographic market or submarket the registrant has indicated interest in (e.g., Manhattan Midtown, Austin CBD, Los Angeles Industrial Corridor). Supports geographic lead routing and market intelligence.',
    `property_interest` STRING COMMENT 'The real estate asset class or property type the registrant has expressed interest in. Enables targeted post-event follow-up and property matching by leasing or investment advisory teams. [ENUM-REF-CANDIDATE: office|retail|industrial|multifamily|mixed_use|land|hospitality|data_center|healthcare|other — promote to reference product]',
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

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`brand` (
    `brand_id` BIGINT COMMENT 'Unique system-generated identifier for the brand master record. Primary key for the brand entity within the real estate enterprise.',
    `cost_center_id` BIGINT COMMENT 'Reference to the finance cost center responsible for brand-related expenditures including design, marketing, and brand management activities. Supports General Ledger (GL) allocation and Operating Expenditure (OPEX) tracking.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Brand annual budget financial reporting for international real estate firms requires normalized currency. Normalizing annual_brand_budget currency enables consolidated brand investment reporting acros',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Brand governance in real estate requires a named employee accountable for each brands compliance, refresh decisions, and co-branding agreements. The brand management process assigns ownership to a sp',
    `owner_id` BIGINT COMMENT 'Reference to the internal employee or team responsible for governing and maintaining this brand identity. The brand owner approves usage, manages guidelines, and oversees brand compliance.',
    `parent_brand_id` BIGINT COMMENT 'Reference to the parent brand record in the brand hierarchy. Null for top-level corporate brands. Enables multi-level brand architecture (corporate → portfolio → property-level brands).',
    `accent_color_hex` STRING COMMENT 'Hexadecimal color code for the accent or tertiary brand color used for highlights, calls-to-action, and decorative elements in marketing materials.. Valid values are `^#[0-9A-Fa-f]{6}$`',
    `annual_brand_budget` DECIMAL(18,2) COMMENT 'Approved annual budget allocated for brand management, development, and marketing activities associated with this brand. Expressed in the enterprises functional currency. Supports Capital Expenditure (CAPEX) and Operating Expenditure (OPEX) planning.',
    `brand_code` STRING COMMENT 'Externally-known, human-readable unique code assigned to the brand for use in marketing materials, system integrations, and cross-platform references (e.g., CORP-MAIN, RES-HARBOR, COM-METRO). Serves as the business identifier across operational systems.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `brand_description` STRING COMMENT 'Narrative description of the brands identity, positioning, target audience, and value proposition. Used for internal brand governance documentation and onboarding of marketing teams.',
    `brand_name` STRING COMMENT 'Official full name of the brand as it appears in marketing materials, signage, and public-facing communications (e.g., Harbor Residential, Metro Commercial Park, Pinnacle Real Estate Group).',
    `brand_status` STRING COMMENT 'Current lifecycle state of the brand. active = brand is in use across marketing channels; retired = brand has been decommissioned; in_development = brand is being created or redesigned; suspended = brand use is temporarily halted; archived = brand is preserved for historical reference only.. Valid values are `active|retired|in_development|suspended|archived`',
    `brand_tier` STRING COMMENT 'Hierarchical classification of the brand within the enterprise brand architecture. corporate = enterprise-level master brand; portfolio = brand covering a specific property portfolio or fund; property = brand for an individual property or community; co-brand = jointly managed brand with an external partner; sub-brand = derivative brand under a parent brand.. Valid values are `corporate|portfolio|property|co-brand|sub-brand`',
    `brand_type` STRING COMMENT 'Classification of the brand by the property sector it represents. Aligns with the asset class focus of the brand identity (e.g., residential community brand, commercial park brand, mixed-use development brand).. Valid values are `residential|commercial|mixed-use|industrial|hospitality|corporate`',
    `co_brand_agreement_ref` STRING COMMENT 'Reference number or identifier for the co-branding agreement or contract governing the joint brand usage. Links to the contract lifecycle management system (DocuSign CLM) for legal documentation.',
    `co_brand_partner_name` STRING COMMENT 'Name of the external partner organization in a co-branding arrangement (e.g., a hospitality operator, retail anchor, or financial institution). Null for wholly-owned brands. Relevant for mixed-use developments and REIT joint ventures.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this brand record was first created in the data platform. Supports audit trail, data lineage, and record lifecycle management.',
    `digital_presence_url` STRING COMMENT 'Primary website or microsite URL for this brand (e.g., the brands dedicated landing page, community website, or portfolio site). Used for digital marketing attribution and campaign tracking.. Valid values are `^https?://.+`',
    `esg_aligned` BOOLEAN COMMENT 'Indicates whether this brand has been formally designated as aligned with the enterprises Environmental, Social, and Governance (ESG) strategy and sustainability commitments. True = ESG-aligned brand with documented sustainability positioning.',
    `geographic_markets` STRING COMMENT 'Comma-separated list of geographic markets or regions where this brand is actively deployed (e.g., New York, Los Angeles, Chicago). Supports market-level brand performance analysis and campaign targeting.',
    `guidelines_url` STRING COMMENT 'URL pointing to the official brand guidelines document or portal (e.g., hosted on SharePoint, Brandfolder, or a DAM system). Contains approved usage rules for logo, color, typography, and tone of voice.. Valid values are `^https?://.+`',
    `last_refresh_date` DATE COMMENT 'The date of the most recent brand refresh or redesign (e.g., logo update, color palette change, typography overhaul). Tracks brand evolution and supports version management.',
    `launch_date` DATE COMMENT 'The date on which the brand was officially launched and made active for public-facing use. Marks the start of the brands operational lifecycle.',
    `leed_certified` BOOLEAN COMMENT 'Indicates whether the brand is associated with Leadership in Energy and Environmental Design (LEED) certified properties, enabling green marketing positioning and ESG reporting.',
    `logo_asset_url` STRING COMMENT 'URL reference to the primary logo asset file stored in the digital asset management (DAM) system or cloud storage. Points to the master logo file in approved formats (SVG, PNG, EPS).. Valid values are `^https?://.+`',
    `logo_dark_asset_url` STRING COMMENT 'URL reference to the dark/reversed variant of the brand logo for use on dark backgrounds. Stored in the digital asset management system alongside the primary logo.. Valid values are `^https?://.+`',
    `notes` STRING COMMENT 'Free-text field for additional context, governance decisions, brand history, or operational notes relevant to this brand record. Not intended for structured data.',
    `positioning` STRING COMMENT 'Market positioning tier of the brand relative to competitive offerings. Drives pricing strategy, marketing channel selection, and target audience segmentation for campaigns.. Valid values are `luxury|premium|mid-market|affordable|value`',
    `primary_color_hex` STRING COMMENT 'Hexadecimal color code for the primary brand color as defined in the brand guidelines (e.g., #1A3C5E). Used to enforce visual consistency across marketing materials, digital listings, and signage.. Valid values are `^#[0-9A-Fa-f]{6}$`',
    `primary_font_family` STRING COMMENT 'Name of the primary typeface/font family specified in the brand typography standards (e.g., Helvetica Neue, Proxima Nova, Garamond). Governs typography usage across all brand touchpoints.',
    `retirement_date` DATE COMMENT 'The date on which the brand was officially retired or decommissioned. Null if the brand is still active or in development. Used for brand lifecycle reporting and historical analysis.',
    `secondary_color_hex` STRING COMMENT 'Hexadecimal color code for the secondary brand color as defined in the brand guidelines. Complements the primary color in marketing collateral and digital assets.. Valid values are `^#[0-9A-Fa-f]{6}$`',
    `secondary_font_family` STRING COMMENT 'Name of the secondary or body typeface/font family specified in the brand typography standards. Used for body copy, captions, and supporting text in marketing materials.',
    `social_media_handle` STRING COMMENT 'Primary social media handle or username associated with this brand across platforms (e.g., @HarborResidential). Used for social media campaign tracking and digital marketing attribution.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this brand record originates or is primarily managed (e.g., salesforce for Salesforce CRM, yardi for Yardi Voyager). Supports data lineage and integration governance.. Valid values are `salesforce|yardi|mri|sap|manual|other`',
    `source_system_brand_code` STRING COMMENT 'The native identifier for this brand record in the originating operational system of record (e.g., Salesforce CRM record ID, SAP brand object ID). Enables cross-system reconciliation and data lineage tracing.',
    `tagline` STRING COMMENT 'The official marketing tagline or slogan associated with the brand, used in advertising, signage, and digital campaigns (e.g., Live Where You Belong, Where Business Thrives).',
    `target_audience_segment` STRING COMMENT 'Primary audience segment this brand is designed to attract (e.g., young professionals, institutional investors, family renters, Fortune 500 tenants). Informs campaign strategy and creative direction.',
    `target_property_types` STRING COMMENT 'Comma-separated list of property types this brand is associated with (e.g., multifamily, office, retail). Aligns the brand with specific asset classes within the portfolio for marketing targeting and campaign attribution.',
    `trademark_jurisdiction` STRING COMMENT 'Country or jurisdiction in which the trademark is registered, using ISO 3166-1 alpha-3 country codes (e.g., USA, GBR, CAN). Supports multi-market brand protection tracking.',
    `trademark_registered` BOOLEAN COMMENT 'Indicates whether the brand name and/or logo is formally registered as a trademark with the relevant intellectual property authority. True = trademark registration is in place; False = not registered.',
    `trademark_registration_number` STRING COMMENT 'Official trademark registration number issued by the intellectual property authority (e.g., USPTO registration number). Null if trademark is not registered. Supports legal compliance and brand protection.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this brand record was most recently modified in the data platform. Supports change tracking, audit compliance, and incremental data processing in the Databricks Lakehouse Silver Layer.',
    CONSTRAINT pk_brand PRIMARY KEY(`brand_id`)
) COMMENT 'Master record for brand identities managed within the real estate enterprise — corporate brand, sub-brands for specific property portfolios, residential community brands, commercial park brands, and co-branded partnerships. Captures brand name, brand tier (corporate, portfolio, property-level), brand guidelines URL, logo asset reference, color palette, typography standards, brand owner, brand launch date, brand status (active, retired, in development), and associated markets or property types. SSOT for brand identity governance.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`channel` (
    `channel_id` BIGINT COMMENT 'Unique system-generated identifier for a marketing channel record. Primary key for the channel reference master. [REFERENCE_LOOKUP role — canonical_skip_reason: This entity is a reference master / taxonomy table defining standardized marketing channel types; per-role minimums for REFERENCE_LOOKUP are exempt, but full attribute coverage is still applied for business completeness.]',
    `vendor_id` BIGINT COMMENT 'The enterprises account or publisher ID assigned by the platform vendor (e.g., Google Ads Customer ID, Facebook Ad Account ID, CoStar Advertiser ID). Used for API integrations, spend reconciliation, and vendor billing verification.',
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

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`audience_segment` (
    `audience_segment_id` BIGINT COMMENT 'Unique system-generated identifier for the audience segment master record. Primary key for the audience_segment entity.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Audience segments for international real estate marketing are scoped by country for GDPR compliance, foreign ownership restrictions, and market activation. Normalizing country_code enables compliance-',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Audience segments in real estate are defined by geographic market preference (e.g., Sun Belt multifamily investors, NYC office tenants). Normalizing enables segment activation by market and geographic',
    `industry_classification_id` BIGINT COMMENT 'Foreign key linking to reference.industry_classification. Business justification: B2B audience segments in commercial real estate target specific tenant industries (tech, healthcare, retail). Normalizing target_industry_sector to reference.industry_classification enables tenant mix',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to reference.market_segment. Business justification: Investor audience segments in real estate are defined by investment strategy (core, value-add, opportunistic). Linking to reference.market_segment enables targeting investors by risk profile, target I',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `primary_audience_employee_id` BIGINT COMMENT 'Identifier of the internal employee or team responsible for maintaining and governing this audience segment definition. The segment owner approves changes, validates criteria, and ensures alignment with campaign strategy.',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Audience segments in real estate are defined by property type interest (multifamily investors, office tenants, industrial occupiers). Normalizing enables segment activation and campaign targeting by a',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: B2B audience segments for commercial real estate are defined by preferred lease structure (NNN, gross, modified gross). Normalizing enables targeted campaigns for specific lease type preferences and t',
    `parent_audience_segment_id` BIGINT COMMENT 'Self-referencing FK on audience_segment (parent_audience_segment_id)',
    `accredited_investor_flag` BOOLEAN COMMENT 'Indicates whether this segment is defined as comprising accredited investors per SEC Regulation D criteria (net worth > $1M excluding primary residence, or income > $200K/$300K joint). Governs eligibility for private placement and REIT investment marketing materials.',
    `activation_end_date` DATE COMMENT 'Date after which this audience segment is no longer eligible for new campaign activations. Null indicates the segment is open-ended with no expiry. Supports time-limited promotional segments and regulatory sunset requirements.',
    `activation_start_date` DATE COMMENT 'Date from which this audience segment becomes eligible for use in campaign targeting and activation. Segments cannot be used in campaigns before this date. Supports seasonal and time-bound segment strategies.',
    `age_band_max` STRING COMMENT 'Maximum age (in years) of individuals within this demographic segment. Null indicates no upper age cap. Used in conjunction with age_band_min to define the age bracket for demographic targeting.',
    `age_band_min` STRING COMMENT 'Minimum age (in years) of individuals within this demographic segment. Used for demographic targeting in residential campaigns — e.g., first-time buyer segments may target ages 25–40, while empty nester segments may target 55+.',
    `audience_segment_status` STRING COMMENT 'Current lifecycle state of the audience segment record. Active segments are eligible for campaign targeting; draft segments are under construction; archived segments are retained for historical reference but not used in new campaigns.. Valid values are `active|inactive|draft|archived|under_review`',
    `b2b_segment_flag` BOOLEAN COMMENT 'Indicates whether this is a B2B (firmographic) segment targeting corporate entities, institutional investors, or commercial tenants rather than individual consumers. When true, firmographic attributes (company size, industry sector) are the primary segmentation criteria.',
    `channel_affinity` STRING COMMENT 'Primary marketing channel through which this segment is most effectively reached. Informs channel mix decisions in campaign planning — e.g., institutional investor segments may prefer direct outreach and events, while residential buyer segments respond to digital and social media.. Valid values are `digital|email|social_media|direct_mail|events|broker_referral`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audience segment record was first created in the system. Supports audit trail, data lineage, and record lifecycle tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the income and net worth band values defined for this segment (e.g., USD, GBP, EUR). Ensures consistent financial comparisons across multi-market portfolios.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'Primary data source used to define and populate this audience segment. Indicates provenance for data quality and compliance purposes. Examples: Salesforce CRM (tenant/prospect data), CoStar Suite (market intelligence), MLS (listing activity), third-party data providers, or internal market research.. Valid values are `salesforce_crm|costar|mls|third_party|internal_crm|market_research`',
    `esg_preference_flag` BOOLEAN COMMENT 'Indicates whether this segment has a stated preference for ESG-aligned, LEED-certified, or BREEAM-rated properties. Enables targeted campaigns for green-certified assets and supports ESG-driven investor and tenant marketing strategies.',
    `fair_housing_compliant_flag` BOOLEAN COMMENT 'Indicates that the segment definition and targeting criteria have been reviewed and confirmed compliant with the Fair Housing Act. Segments must not discriminate based on race, color, national origin, religion, sex, familial status, or disability. Required for all residential marketing campaigns.',
    `gdpr_applicable_flag` BOOLEAN COMMENT 'Indicates whether GDPR data privacy regulations apply to the individuals in this segment (i.e., segment includes EU/EEA residents). When true, all campaign activations using this segment must comply with GDPR consent and data processing requirements.',
    `geographic_preference` STRING COMMENT 'Descriptive label of the geographic market or submarket preference for this segment (e.g., Greater Boston Metro, Sun Belt — Phoenix/Dallas/Austin, Manhattan CBD). Used to align segment targeting with property inventory in specific markets. Complements geographic_market_code for human-readable display.',
    `income_band_max` DECIMAL(18,2) COMMENT 'Upper bound of the annual household income range (in local currency) defining this segment. Null indicates no upper cap (e.g., ultra-high-net-worth segments). Used alongside income_band_min to define the income bracket for targeting.',
    `income_band_min` DECIMAL(18,2) COMMENT 'Lower bound of the annual household income range (in local currency) defining this segment. Used for demographic targeting and affordability-based campaign filtering. For B2B/CRE firmographic segments, this may represent minimum annual revenue of the target firm.',
    `investment_profile` STRING COMMENT 'Risk-return investment strategy profile applicable to investor segments. Aligns with standard CRE investment classifications: core (low risk, stabilized assets), core-plus, value-add (repositioning), opportunistic (high risk/return), or speculative (development/land). Used to match investor segments with appropriate property offerings and fund products.. Valid values are `core|core_plus|value_add|opportunistic|speculative`',
    `life_stage` STRING COMMENT 'Buyer or tenant life stage classification used for personalization and message relevance. Common values include: first-time buyer, move-up buyer, empty nester, downsizer, institutional investor, family formation, retiree, corporate relocatee. [ENUM-REF-CANDIDATE: first_time_buyer|move_up_buyer|empty_nester|downsizer|institutional_investor|family_formation|retiree|corporate_relocatee — promote to reference product]',
    `max_sqft_requirement` STRING COMMENT 'Maximum space requirement in square feet (SQF) for this segment. Null indicates no upper size constraint. Used alongside min_sqft_requirement to define the space size range for property matching and campaign targeting.',
    `min_sqft_requirement` STRING COMMENT 'Minimum space requirement in square feet (SQF) for this segment. Used to match segment members with appropriately sized property listings in campaign targeting and lead qualification workflows.',
    `net_worth_band_max` DECIMAL(18,2) COMMENT 'Upper bound of the estimated net worth range for individuals in this segment. Null indicates no upper cap. Used in conjunction with net_worth_band_min to define wealth tiers for investment advisory and luxury property campaigns.',
    `net_worth_band_min` DECIMAL(18,2) COMMENT 'Lower bound of the estimated net worth range for individuals in this segment. Particularly relevant for investor and luxury buyer segments where net worth is a stronger qualifier than income. Used to align segment with investment product thresholds (e.g., accredited investor qualification).',
    `persona_type` STRING COMMENT 'The primary real estate role or persona this segment represents. Determines the nature of the marketing message and the relevant product offerings — e.g., buyer personas receive property listing campaigns, investor personas receive portfolio and IRR-focused content. [ENUM-REF-CANDIDATE: buyer|tenant|investor|owner|developer|broker|lender — 7 candidates stripped; promote to reference product]',
    `refresh_frequency` STRING COMMENT 'How frequently the segment membership criteria and size estimate are recalculated and refreshed from source systems. Determines the operational cadence for segment maintenance and ensures targeting accuracy over time.. Valid values are `daily|weekly|monthly|quarterly|on_demand`',
    `segment_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the segment, used in campaign targeting configurations, CRM integrations, and marketing platform references (e.g., Salesforce CRM segment codes).. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `segment_description` STRING COMMENT 'Detailed narrative description of the audience segment, including the defining characteristics, behavioral patterns, real estate needs, and strategic rationale for targeting. Used by campaign managers and creative teams to develop relevant messaging and content.',
    `segment_name` STRING COMMENT 'Human-readable name of the audience segment used for display in campaign management tools, dashboards, and marketing reports (e.g., Institutional Multifamily Investors, First-Time Homebuyers — Metro South).',
    `segment_size_estimate` BIGINT COMMENT 'Estimated number of individuals or organizations that belong to this audience segment based on the defining criteria. Used for campaign reach planning, budget allocation, and media buying decisions. Sourced from CRM data, market research, or third-party data providers.',
    `segment_type` STRING COMMENT 'Classification of the segmentation methodology applied: demographic (age, income, household size), behavioral (search activity, prior transactions), psychographic (lifestyle, values), firmographic (company size, industry — for B2B/CRE), or geographic (market area, submarket). Drives targeting logic in campaign platforms.. Valid values are `demographic|behavioral|psychographic|firmographic|geographic`',
    `size_estimate_date` DATE COMMENT 'Date on which the segment size estimate was last calculated or refreshed. Indicates the currency of the estimate and triggers re-evaluation workflows when the estimate becomes stale.',
    `source_system` STRING COMMENT 'Operational system of record from which this audience segment definition originates or is primarily managed. Supports data lineage tracking and cross-system synchronization. Salesforce CRM is the primary system of record for tenant and prospect segments.. Valid values are `salesforce_crm|costar|mri_software|yardi_voyager|internal`',
    `source_system_segment_code` STRING COMMENT 'The native identifier of this audience segment in the originating source system (e.g., Salesforce CRM Campaign Member Segment ID, CoStar segment reference). Enables bidirectional reconciliation between the lakehouse silver layer and operational systems.',
    `target_company_size` STRING COMMENT 'For B2B/firmographic segments, the size classification of the target corporate entity. Relevant for commercial leasing and CRE investment segments — e.g., enterprise tenants (Fortune 500) require different space and lease structures than small businesses.. Valid values are `small|mid_market|large|enterprise|institutional`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this audience segment record was last modified. Used for change detection, incremental data processing in the Databricks Lakehouse Silver Layer, and audit compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_audience_segment PRIMARY KEY(`audience_segment_id`)
) COMMENT 'Master record defining target audience segments used for campaign targeting and personalization — buyer personas, investor profiles, tenant segments, and demographic cohorts relevant to real estate marketing. Captures segment name, segment type (demographic, behavioral, psychographic, firmographic for B2B), target property type, income or net worth band, geographic preference, life stage (first-time buyer, move-up buyer, empty nester, institutional investor), segment size estimate, data source, and segment owner. Enables precision targeting across campaigns.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`email_campaign` (
    `email_campaign_id` BIGINT COMMENT 'Unique surrogate identifier for the email campaign execution record in the Silver Layer lakehouse. Primary key for this transactional entity.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to property.asset. Business justification: Email campaigns in RE are frequently property-specific: lease-up drip campaigns, tenant retention campaigns, open house invitations for a specific asset. Linking email campaigns to assets enables asse',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: email_campaign.audience_segment is a STRING. Email campaigns are sent to a defined audience segment. Normalizing to audience_segment_id FK links the email campaign to the authoritative segment master,',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign under which this email campaign execution is organized. Links the email send to the broader campaign strategy, budget, and objectives.',
    `compliance_program_id` BIGINT COMMENT 'Foreign key linking to compliance.program. Business justification: Email campaigns must comply with specific programs (GDPR, CAN-SPAM, Fair Housing). Linking to the governing compliance program enables program managers to track email campaign compliance status, flag ',
    `cost_center_id` BIGINT COMMENT 'Reference to the finance cost center responsible for the marketing spend associated with this email campaign. Enables budget allocation and OPEX reporting in SAP S/4HANA and Yardi Voyager GL.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to marketing.marketing_vendor. Business justification: email_campaign.esp_id is a BIGINT representing the Email Service Provider (ESP) — a marketing vendor. Formalizing as esp_marketing_vendor_id FK (ending with marketing_vendor_id per naming rules) links',
    `fund_id` BIGINT COMMENT 'Foreign key linking to investment.fund. Business justification: Investor relations email campaigns (fund updates, distribution notices, capital call notices, LP newsletters) are sent for a specific fund. Fund-level email engagement reporting is standard in real es',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Email campaigns in real estate are geo-targeted to specific markets. Normalizing enables market-level email performance reporting and comparison of open/click rates across geographic markets for budge',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: CAN-SPAM and fair housing compliance require identifying the employee responsible for each email campaign. In real estate, email campaigns for listings and investor communications must have a named ow',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Email campaigns in real estate are targeted by property type. CAN-SPAM and fair housing compliance reviews and performance reporting require knowing which property type each email campaign targets.',
    `source_system_campaign_id` BIGINT COMMENT 'The native primary key or identifier for this email campaign record in the originating source system (e.g., Salesforce Marketing Cloud Job ID, HubSpot Email ID, Mailchimp Campaign ID). Used for cross-system reconciliation and audit.',
    `resent_email_campaign_id` BIGINT COMMENT 'Self-referencing FK on email_campaign (resent_email_campaign_id)',
    `ab_test_variant` STRING COMMENT 'Identifies the A/B or multivariate test variant for this email campaign send (e.g., A, B, C, or control). Enables subject line, content, and send-time optimization analysis across variants.. Valid values are `A|B|C|control`',
    `actual_send_timestamp` TIMESTAMP COMMENT 'The actual date and time at which the email campaign send was initiated by the ESP. The principal business event timestamp for this transactional record. Used for deliverability analysis and SLA tracking.',
    `campaign_spend` DECIMAL(18,2) COMMENT 'The actual monetary spend attributed to this email campaign execution, including ESP send costs, list acquisition, and creative production costs. Expressed in the currency defined by currency_code.',
    `can_spam_compliant_flag` BOOLEAN COMMENT 'Indicates whether this email campaign was verified as compliant with the CAN-SPAM Act requirements, including accurate sender identification, non-deceptive subject lines, physical address inclusion, and opt-out mechanism.',
    `click_count` STRING COMMENT 'The number of unique clicks on tracked links within the email body for this campaign. Primary engagement metric for measuring content effectiveness and lead intent signals.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this email campaign record was first created in the system. Audit trail field for data governance and lineage tracking in the Databricks Silver Layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the campaign spend amount (e.g., USD, EUR, GBP). Supports multi-currency portfolio environments.. Valid values are `^[A-Z]{3}$`',
    `delivered_count` STRING COMMENT 'The number of emails successfully delivered to recipient inboxes (total recipients minus hard and soft bounces). Core deliverability metric for ESP performance evaluation.',
    `esp_campaign_ref` STRING COMMENT 'The native campaign or send identifier assigned by the email service provider (Mailchimp, HubSpot, or Salesforce Marketing Cloud). Used for cross-system reconciliation and ESP-level reporting.',
    `fair_housing_compliant_flag` BOOLEAN COMMENT 'Indicates whether the email campaign content was reviewed and confirmed compliant with the Fair Housing Act, ensuring no discriminatory language, imagery, or targeting based on protected class characteristics.',
    `gdpr_compliant_flag` BOOLEAN COMMENT 'Indicates whether this email campaign was verified as compliant with GDPR requirements, including lawful basis for processing, consent verification, unsubscribe mechanism, and sender identification.',
    `hard_bounce_count` STRING COMMENT 'The number of emails that permanently failed delivery due to invalid or non-existent email addresses. Hard bounces must be suppressed from future sends per ESP best practices and GDPR data accuracy requirements.',
    `landing_page_url` STRING COMMENT 'The primary destination URL to which email recipients are directed upon clicking the main call-to-action. Used for conversion tracking and property listing page performance analysis.. Valid values are `^https?://.+`',
    `lead_count` STRING COMMENT 'The number of qualified leads generated as a direct attribution of this email campaign, based on click-through actions resulting in form submissions, inquiry calls, or CRM lead creation in Salesforce CRM.',
    `open_count` STRING COMMENT 'The number of unique email opens recorded for this campaign. Measures recipient engagement with the subject line and preview text. Note: impacted by Apple Mail Privacy Protection (MPP) since iOS 15.',
    `personalization_flag` BOOLEAN COMMENT 'Indicates whether this email campaign used dynamic content personalization (e.g., recipient name merge fields, personalized property recommendations, or dynamic listing content). Used to measure personalization impact on engagement.',
    `preview_text` STRING COMMENT 'Pre-header or preview text displayed alongside the subject line in email clients. Complements the subject line to improve open rates and is tracked for A/B testing effectiveness.',
    `reply_to_email` STRING COMMENT 'The email address to which recipient replies are directed, which may differ from the sender address. Required for CAN-SPAM compliance and tenant/investor response management.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `scheduled_send_timestamp` TIMESTAMP COMMENT 'The date and time at which the email campaign was scheduled to be sent to the target audience. Used for send-time optimization analysis and operational scheduling.',
    `send_completed_timestamp` TIMESTAMP COMMENT 'The date and time at which the ESP confirmed completion of the full send to all recipients. Marks the end of the active sending lifecycle phase and is used for throughput and performance window calculations.',
    `sender_email` STRING COMMENT 'The FROM email address used to send this campaign. Must be a verified domain address per CAN-SPAM and GDPR requirements. Used for deliverability tracking and compliance auditing.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sender_name` STRING COMMENT 'The display name shown as the sender in the recipients email client (e.g., Acme Realty Investor Relations, Downtown Leasing Team). Affects deliverability and brand recognition.',
    `soft_bounce_count` STRING COMMENT 'The number of emails that temporarily failed delivery due to recipient mailbox full, server unavailable, or message size issues. Soft bounces are retried and monitored for conversion to hard bounces.',
    `source_system` STRING COMMENT 'The operational system of record from which this email campaign record originated (Salesforce Marketing Cloud, HubSpot, Mailchimp, or manual entry). Supports data lineage and reconciliation in the Silver Layer.. Valid values are `salesforce_marketing_cloud|hubspot|mailchimp|manual`',
    `spam_complaint_count` STRING COMMENT 'The number of recipients who marked this email as spam or junk. High complaint rates damage sender reputation and ESP deliverability scores. Monitored for CAN-SPAM and GDPR compliance.',
    `subject_line` STRING COMMENT 'The subject line text displayed to recipients in their email inbox. Critical for open rate analysis, A/B testing, and compliance with CAN-SPAM and GDPR subject line transparency requirements.',
    `template_code` BIGINT COMMENT 'Reference to the email template used for this campaign execution, governing layout, branding, and base content. Enables template performance benchmarking across sends.',
    `total_recipients` STRING COMMENT 'The total number of email addresses included in the send list for this campaign before any suppression or filtering. Represents the gross audience size.',
    `unsubscribe_count` STRING COMMENT 'The number of recipients who opted out of future email communications via the unsubscribe link in this campaign. Critical for CAN-SPAM and GDPR compliance monitoring and list health management.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this email campaign record was last modified. Supports incremental data loading, change data capture, and audit trail requirements in the Silver Layer.',
    `utm_campaign` STRING COMMENT 'The UTM campaign parameter appended to tracked links, typically matching the campaign_code or campaign_name. Enables campaign-level traffic attribution in web analytics.',
    `utm_medium` STRING COMMENT 'The UTM medium parameter appended to tracked links in this email campaign, identifying the marketing channel (e.g., email). Used for multi-channel attribution analysis.',
    `utm_source` STRING COMMENT 'The UTM source parameter appended to tracked links in this email campaign, identifying the traffic source (e.g., mailchimp, hubspot, sfmc). Enables attribution in web analytics platforms.',
    CONSTRAINT pk_email_campaign PRIMARY KEY(`email_campaign_id`)
) COMMENT 'Transactional record for email marketing campaign executions — property newsletters, listing alerts, market update emails, drip nurture sequences, and investor communications. Captures email campaign name, parent campaign reference, email template reference, subject line, sender name and address, target audience segment, send date and time, total recipients, delivered count, open count, click count, unsubscribe count, bounce count, and email service provider reference (Mailchimp, HubSpot, Salesforce Marketing Cloud). Enables email channel performance tracking.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`seo_keyword` (
    `seo_keyword_id` BIGINT COMMENT 'Unique surrogate identifier for each SEO/SEM keyword record in the digital marketing master. Primary key for the seo_keyword product.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to property.asset. Business justification: SEO keywords in RE are often property-specific (address-based searches, building name keywords). Linking keywords to assets enables asset-level organic search performance reporting and supports digita',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign this keyword is associated with for paid search (SEM) or organic tracking purposes.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: seo_keyword.search_channel is a STRING (e.g., Google Search, Bing, Organic). Normalizing to channel_id FK links the SEO/SEM keyword to the authoritative channel master, enabling channel-level ke',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: SEO keyword strategy in international real estate is country-specific (language, search engine, regulations). Normalizing country_code to reference.country enables country-level keyword performance re',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: SEO keywords in real estate are geo-targeted (e.g., office space Chicago Loop). Normalizing geographic_market to geographic_hierarchy enables keyword performance analysis by submarket and MSA-level ',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: SEO keyword strategy in real estate is organized by property type (e.g., office space for lease vs. industrial warehouse). Normalizing enables keyword performance reporting by asset class and budg',
    `parent_seo_keyword_id` BIGINT COMMENT 'Self-referencing FK on seo_keyword (parent_seo_keyword_id)',
    `ad_group_name` STRING COMMENT 'Name of the ad group within the paid search campaign to which this keyword belongs (e.g., Downtown Office Space, Luxury Apartments NYC). Ad groups organize keywords by theme for relevance and Quality Score optimization.',
    `bid_amount` DECIMAL(18,2) COMMENT 'The maximum cost-per-click (CPC) bid amount set for this keyword in paid search campaigns, expressed in the applicable currency. Drives ad auction participation and budget allocation for SEM activities.',
    `click_through_rate` DECIMAL(18,2) COMMENT 'Ratio of clicks to impressions for this keyword expressed as a decimal (e.g., 0.0350 = 3.50% CTR). Measures ad or organic listing engagement effectiveness for this keyword.',
    `competition_level` STRING COMMENT 'Categorical assessment of advertiser competition for this keyword in paid search auctions: low, medium, or high. Sourced from keyword research platforms and used to inform bid strategy and budget allocation.. Valid values are `low|medium|high`',
    `competition_score` DECIMAL(18,2) COMMENT 'Numeric competition index for this keyword on a 0.0000 to 1.0000 scale, where 1.0000 represents maximum advertiser competition. Provides granular competitive intensity data beyond the categorical competition_level field.',
    `conversion_rate` DECIMAL(18,2) COMMENT 'Ratio of conversions (lead form submissions, property inquiry clicks, tour bookings) to total clicks for this keyword, expressed as a decimal. Measures the keywords effectiveness in generating qualified real estate leads.',
    `cost_per_click` DECIMAL(18,2) COMMENT 'Average actual cost incurred per click for this keyword in paid search campaigns. Distinct from the bid_amount (maximum bid); this reflects the actual average spend per click based on auction outcomes.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this SEO/SEM keyword record was first created in the system. Provides audit trail for record provenance and data lineage tracking in the Silver Layer lakehouse.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the bid amount and cost-per-click values (e.g., USD, GBP, EUR). Supports multi-currency portfolio management.. Valid values are `^[A-Z]{3}$`',
    `current_ranking_position` STRING COMMENT 'Current organic search engine results page (SERP) ranking position for this keyword phrase (e.g., position 1 = top result). Tracked periodically to measure SEO performance and progress toward target ranking.',
    `device_target` STRING COMMENT 'Target device type for paid search bid adjustments: all (no device restriction), desktop, mobile, or tablet. Mobile targeting is critical for local property search behavior in real estate.. Valid values are `all|desktop|mobile|tablet`',
    `fair_housing_compliant` BOOLEAN COMMENT 'Indicates whether this keyword and its associated ad copy have been reviewed and confirmed compliant with the Fair Housing Act, which prohibits discriminatory advertising based on race, color, religion, sex, national origin, disability, or familial status.',
    `impression_share` DECIMAL(18,2) COMMENT 'Percentage of total eligible impressions this keyword received in paid search auctions, expressed as a decimal (e.g., 0.6500 = 65%). Indicates market visibility and budget sufficiency for this keyword.',
    `keyword_code` STRING COMMENT 'Externally-known unique business identifier code assigned to this keyword record for cross-system reference and reporting (e.g., KW-COM001234). Used as the business key in campaign management platforms.. Valid values are `^KW-[A-Z0-9]{6,12}$`',
    `keyword_difficulty_score` DECIMAL(18,2) COMMENT 'SEO difficulty score (0-100) indicating how hard it is to rank organically for this keyword based on the authority of competing pages. Higher scores require greater content investment and link-building effort.',
    `keyword_phrase` STRING COMMENT 'The exact search keyword or phrase being tracked or bid upon (e.g., commercial office space downtown Chicago, apartments for rent near me). This is the primary identity label of the keyword record.',
    `keyword_status` STRING COMMENT 'Current lifecycle status of the keyword record indicating whether it is actively tracked/bid upon, paused, archived, or pending review. Drives inclusion in active campaign reporting and bid management workflows.. Valid values are `active|paused|archived|under_review|pending`',
    `keyword_type` STRING COMMENT 'Classification of the keyword by strategic intent: branded (includes company/brand name), non_branded (generic property terms), long_tail (highly specific multi-word phrases), local (geo-specific), competitor (competitor brand terms), generic (broad category terms). [ENUM-REF-CANDIDATE: branded|non_branded|long_tail|local|competitor|generic — promote to reference product]. Valid values are `branded|non_branded|long_tail|local|competitor|generic`',
    `landing_page_url` STRING COMMENT 'The URL of the landing page associated with this keyword for both organic ranking and paid search ad destination. Typically a property listing page, market-specific search results page, or campaign-specific landing page.. Valid values are `^https?://.+`',
    `language_code` STRING COMMENT 'IETF BCP 47 language code for the keyword phrase (e.g., en-US, es-MX, fr-CA). Supports multilingual SEO/SEM strategies for diverse tenant and buyer markets.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_ranking_check_date` DATE COMMENT 'The date on which the organic ranking position for this keyword was last verified or refreshed from a ranking tracking tool. Indicates data freshness for the current_ranking_position field.',
    `last_updated_date` DATE COMMENT 'The date on which this keyword record was last updated, including changes to bid amount, match type, status, or performance metrics. Used for data freshness monitoring and audit purposes.',
    `match_type` STRING COMMENT 'Paid search match type controlling how closely the search query must match the keyword to trigger an ad: broad (widest reach), phrase (query contains phrase), exact (query matches exactly), broad_modified (must include modified terms). Applies to SEM/paid search keywords.. Valid values are `broad|phrase|exact|broad_modified`',
    `monthly_search_volume` STRING COMMENT 'Estimated average number of searches per month for this keyword phrase in the target geographic market, as sourced from keyword research tools (e.g., Google Keyword Planner, SEMrush). Principal quantitative measure of keyword demand.',
    `negative_keyword_flag` BOOLEAN COMMENT 'Indicates whether this keyword is designated as a negative keyword (True) to exclude irrelevant traffic from paid search campaigns, or a positive/target keyword (False). Negative keywords prevent ad spend waste on non-property-related queries.',
    `notes` STRING COMMENT 'Free-text field for digital marketing team annotations, strategic rationale, optimization observations, or special instructions related to this keyword (e.g., Pause during Q4 budget freeze, High-value keyword for luxury residential campaign).',
    `peak_season` STRING COMMENT 'The quarter or season during which this keyword experiences peak search volume, used to plan seasonal bid adjustments and campaign budget pacing for property marketing. [ENUM-REF-CANDIDATE: Q1|Q2|Q3|Q4|spring|summer|fall|winter — 8 candidates stripped; promote to reference product]',
    `priority_tier` STRING COMMENT 'Strategic priority classification assigned by the digital marketing team: tier_1 (highest priority, core business keywords), tier_2 (secondary importance), tier_3 (long-tail or experimental). Drives resource allocation and reporting focus.. Valid values are `tier_1|tier_2|tier_3`',
    `quality_score` STRING COMMENT 'Google Ads or Microsoft Advertising quality score for this keyword on a 1-10 scale, reflecting the relevance of the keyword, ad copy, and landing page experience. Higher scores reduce cost-per-click and improve ad placement.',
    `ranking_url` STRING COMMENT 'The actual URL currently ranking organically for this keyword in search engine results, which may differ from the intended landing_page_url. Used to identify ranking page mismatches and cannibalization issues.. Valid values are `^https?://.+`',
    `search_intent` STRING COMMENT 'Classification of the users likely intent behind this keyword search: informational (researching market/property), navigational (looking for specific brand/site), transactional (ready to buy/lease), commercial_investigation (comparing options). Guides content and ad strategy alignment.. Valid values are `informational|navigational|transactional|commercial_investigation`',
    `seasonality_flag` BOOLEAN COMMENT 'Indicates whether this keyword exhibits significant seasonal search volume variation (True), requiring bid and budget adjustments aligned with real estate market cycles (e.g., spring buying season, year-end commercial lease renewals).',
    `source_keyword_code` STRING COMMENT 'The native keyword identifier assigned by the source platform (e.g., Google Ads keyword ID, Microsoft Ads keyword ID). Enables bidirectional reconciliation between the lakehouse master record and the operational ad platform.',
    `source_platform` STRING COMMENT 'The platform or tool from which this keyword data was sourced or is being managed: google_ads, microsoft_ads, google_search_console, semrush, moz, ahrefs, or manual entry. [ENUM-REF-CANDIDATE: google_ads|microsoft_ads|google_search_console|semrush|moz|ahrefs|manual — promote to reference product]',
    `target_ranking_position` STRING COMMENT 'Desired organic SERP ranking position goal for this keyword phrase as set by the digital marketing team (e.g., target position 1-3 for high-priority keywords). Used to measure SEO campaign effectiveness against objectives.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this SEO/SEM keyword record was last modified. Supports incremental data pipeline processing, change data capture, and audit trail requirements.',
    `utm_term` STRING COMMENT 'The UTM term parameter value used in tracking URLs for this keyword to identify paid search traffic in web analytics platforms (e.g., Google Analytics). Enables keyword-level attribution of website sessions and lead conversions.',
    CONSTRAINT pk_seo_keyword PRIMARY KEY(`seo_keyword_id`)
) COMMENT 'Master record for SEO and SEM keywords tracked and managed as part of the digital marketing strategy for property listings and brand visibility. Captures keyword phrase, keyword type (branded, non-branded, long-tail, local), target property type, target geographic market, search volume, competition level, current ranking position, target ranking position, associated landing page URL, bid amount for paid search, quality score, and last updated date. Enables organic and paid search optimization for property marketing.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`social_post` (
    `social_post_id` BIGINT COMMENT 'Unique system-generated identifier for each individual social media post record in the marketing domain.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Fair housing compliance audit and social media governance in real estate require a traceable FK to the approving employee for each social post. The approved_by plain text field is a denormalized emp',
    `asset_id` BIGINT COMMENT 'Reference to the specific property being featured or promoted in this post. Enables property-level social performance attribution and integration with Yardi Voyager property records.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: social_post.target_audience_segment is a STRING. Social posts are targeted to specific audience segments (e.g., luxury buyers, commercial tenants, investors). Normalizing to audience_segment_id FK lin',
    `brand_id` BIGINT COMMENT 'FK to marketing.brand',
    `campaign_flight_id` BIGINT COMMENT 'Reference to the specific campaign flight (channel-level execution window) that funded or scheduled this post, enabling spend attribution at the flight level.',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign under which this social post was published. Null for purely organic posts not tied to a paid campaign.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: social_post.platform is a STRING (e.g., Facebook, Instagram, LinkedIn). Each social platform maps to a channel in the channel master (channel.platform_name). Normalizing to channel_id FK links t',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Social media posts in real estate are geo-targeted to specific markets. Normalizing enables reach and engagement reporting by geographic market for content strategy optimization across submarkets.',
    `listing_id` BIGINT COMMENT 'Reference to the active property listing (MLS or internal) being promoted by this post. Links social engagement data back to the listing pipeline for lead attribution and days-on-market analysis.',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Social media content in real estate is targeted by property type. Marketing teams report engagement and reach by property type to optimize content strategy across residential, commercial, and industri',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: Residential RE social media features specific available units (virtual tours, unit spotlights, move-in specials). Linking social posts to units enables unit-level social performance tracking and suppo',
    `reposted_social_post_id` BIGINT COMMENT 'Self-referencing FK on social_post (reposted_social_post_id)',
    `approval_status` STRING COMMENT 'Content approval workflow status for the post. Ensures brand compliance, fair housing review, and legal sign-off before publication, particularly for paid and boosted posts.. Valid values are `pending|approved|rejected|not_required`',
    `comments` STRING COMMENT 'Number of comments posted by users on this social post. High comment volume may indicate strong audience interest or require moderation review per NAR fair housing guidelines.',
    `content_category` STRING COMMENT 'Business classification of the posts subject matter. Enables content-mix analysis across the portfolio — e.g., tracking ratio of property listing posts vs. investor content vs. community highlights. [ENUM-REF-CANDIDATE: property_listing|market_update|community_highlight|investor_content|brand_awareness|event_promotion|testimonial — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this social post record was first created in the data platform. Audit trail field for data lineage, SOX compliance, and Silver layer ingestion tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the spend amount (e.g., USD, EUR, GBP). Required for multi-currency portfolio reporting and financial consolidation in SAP S/4HANA.. Valid values are `^[A-Z]{3}$`',
    `esg_aligned` BOOLEAN COMMENT 'Indicates whether this post is part of the firms ESG communications strategy, promoting sustainability initiatives, LEED-certified properties, BREEAM ratings, or green building credentials.',
    `fair_housing_compliant` BOOLEAN COMMENT 'Indicates whether the post content has been reviewed and confirmed compliant with the Fair Housing Act (FHA), prohibiting discriminatory language in property advertising. Mandatory compliance flag for all residential property posts.',
    `gdpr_compliant` BOOLEAN COMMENT 'Indicates whether the post and any associated audience targeting data collection practices comply with GDPR requirements, including lawful basis for processing and data subject rights. Applicable for posts targeting EU audiences.',
    `hashtags` STRING COMMENT 'Comma-separated list of hashtags included in the post (e.g., #CRE,#RealEstate,#REIT,#PropertyInvestment). Supports hashtag performance analysis and brand consistency auditing.',
    `headline` STRING COMMENT 'Short headline or title associated with the post, particularly relevant for LinkedIn articles, Facebook link previews, and YouTube video titles. Distinct from post body copy.',
    `impressions` STRING COMMENT 'Total number of times the post was displayed on screen, including repeat views by the same user. Used for CPM (Cost Per Mille) calculation and brand awareness measurement.',
    `likes` STRING COMMENT 'Number of likes (or equivalent positive reactions: LinkedIn reactions, Facebook likes/loves) received on the post. Component of total engagement count.',
    `link_clicks` STRING COMMENT 'Number of clicks on the URL link embedded in the post, driving traffic to property listings, landing pages, or investor portals. Primary conversion signal for lead generation attribution.',
    `link_url` STRING COMMENT 'The destination URL included in the post (e.g., property listing page, landing page, investor relations page). Used for click-through attribution and UTM parameter tracking.',
    `media_asset_ref` STRING COMMENT 'Reference identifier or URL pointing to the primary media asset (image, video, carousel, reel) attached to the post, stored in the Digital Asset Management (DAM) system or cloud storage. Enables creative performance attribution.',
    `media_type` STRING COMMENT 'Format classification of the media asset attached to the post. Drives platform-specific rendering rules and creative performance benchmarking by format. [ENUM-REF-CANDIDATE: image|video|carousel|reel|story|document|text_only — 7 candidates stripped; promote to reference product]',
    `metrics_last_refreshed_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent pull of engagement metrics (reach, impressions, likes, comments, shares, link clicks, video views) from the platform API. Indicates data freshness for reporting and analytics consumers.',
    `platform_page_code` STRING COMMENT 'The native identifier of the company page or account on the social platform from which the post was published (e.g., LinkedIn Company Page ID, Facebook Page ID). Supports multi-brand and multi-portfolio page management.',
    `platform_post_code` STRING COMMENT 'The native post identifier assigned by the social media platform (e.g., LinkedIn post URN, Facebook post ID, Instagram media ID). Used for API-based metrics retrieval and cross-system reconciliation.',
    `post_code` STRING COMMENT 'Human-readable, externally referenceable business identifier for the post (e.g., SP-LI20240315). Used in campaign reporting, creative briefs, and cross-system reconciliation with Salesforce CRM and social platform dashboards.. Valid values are `^SP-[A-Z0-9]{6,12}$`',
    `post_status` STRING COMMENT 'Current lifecycle state of the social post. Tracks the post from authoring (draft) through scheduling, live publication, and potential removal or failure, supporting workflow management and audit trails.. Valid values are `draft|scheduled|published|paused|removed|failed`',
    `post_text` STRING COMMENT 'The full body copy of the social media post as published on the platform, including hashtags, mentions, and emojis. Primary content field for creative performance analysis and fair housing compliance review.',
    `post_type` STRING COMMENT 'Classification of the post by funding and distribution mechanism: organic (unpaid, standard reach), paid (fully sponsored ad), boosted (organic post amplified with budget), sponsored (partner/influencer), or dark_post (targeted ad not visible on page timeline). Determines cost attribution and reporting treatment.. Valid values are `organic|paid|boosted|sponsored|dark_post`',
    `publish_timestamp` TIMESTAMP COMMENT 'The exact date and time (ISO 8601 with timezone offset) at which the post went live on the platform. This is the principal real-world business event timestamp for the post lifecycle, distinct from record creation audit timestamps.',
    `reach` STRING COMMENT 'The total number of unique accounts that saw this post on the platform, as reported by the platforms analytics API. Distinct from impressions (which count repeat views). Core social performance KPI.',
    `scheduled_publish_timestamp` TIMESTAMP COMMENT 'The date and time the post was originally scheduled to be published, prior to actual publication. Enables variance analysis between planned and actual publish times for campaign flight management.',
    `shares` STRING COMMENT 'Number of times the post was shared, reposted, or retweeted by other users. Shares amplify organic reach beyond the original audience and are a high-value engagement signal.',
    `spend_amount` DECIMAL(18,2) COMMENT 'Actual advertising spend attributed to this specific post for paid, boosted, or sponsored post types. Expressed in the campaign currency. Null for organic posts. Used for post-level Return on Investment (ROI) and Cost Per Click (CPC) analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this social post record was last modified in the data platform, including metrics refresh updates. Supports change data capture (CDC) patterns in the Databricks Lakehouse Silver layer.',
    `utm_campaign` STRING COMMENT 'Urchin Tracking Module (UTM) campaign parameter appended to the post link URL, identifying the specific campaign (e.g., q1-2024-office-leasing). Links web traffic back to the originating campaign for multi-touch attribution.',
    `utm_source` STRING COMMENT 'Urchin Tracking Module (UTM) source parameter appended to the post link URL, identifying the originating platform (e.g., linkedin, facebook, instagram). Enables web analytics attribution back to social posts.',
    `video_views` STRING COMMENT 'Number of times the video content in this post was viewed (platform-defined threshold, typically 3 seconds). Applicable only to video and reel post types. Null for non-video posts.',
    CONSTRAINT pk_social_post PRIMARY KEY(`social_post_id`)
) COMMENT 'Transactional record for individual social media posts published as part of marketing campaigns or organic brand presence — property listings, market updates, community highlights, and investor content across LinkedIn, Instagram, Facebook, X (Twitter), and YouTube. Captures platform, post type (organic, paid, boosted), post content text, media asset references, publish date and time, campaign flight reference, target audience, reach, impressions, engagements (likes, comments, shares), link clicks, and post status. Enables social channel performance tracking.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`content_calendar` (
    `content_calendar_id` BIGINT COMMENT 'Unique surrogate identifier for the marketing content calendar record. Primary key for the content_calendar data product in the Silver Layer.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to property.asset. Business justification: Content calendars in RE are built around asset milestones: grand openings, renovation completions, lease-up phases, LEED certification announcements. Linking content calendars to assets enables asset ',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: content_calendar.brand_name is a STRING. Content calendars are organized under a brand identity. Normalizing to brand_id FK links the calendar to the authoritative brand master, enabling retrieval of ',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign this content calendar is associated with, enabling campaign-level coordination of content activities.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: content_calendar.primary_channel is a STRING. Normalizing to channel_id FK links the content calendar to the authoritative channel master for the primary distribution channel. channel_mix (multi-value',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Content calendars carry total_content_budget and content_spend_to_date tracked against property cost centers. content_calendar.cost_center_code is a denormalized string. A FK to finance.cost_center en',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Content calendars in development marketing are built around project milestones: groundbreaking, topping out, pre-sales launch, and grand opening. Linking content_calendar to dev_project allows marketi',
    `fund_id` BIGINT COMMENT 'Foreign key linking to investment.fund. Business justification: Content calendars for fund marketing (LP communications, fund launch content, distribution announcements) are planned around fund milestones. IR and marketing teams plan content calendars per fund; li',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Content calendars in real estate are planned by geographic market to align with local market cycles, lease-up milestones, and property launches. Normalizing enables market-level content planning and b',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Content calendars are planned at the divisional level (regional marketing team, property management division) for resource allocation and budget planning. Divisional content planning reports require l',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Content calendar ownership and approval workflows in real estate marketing require a specific employee accountable for the planning period. The content planning process assigns ownership to a marketin',
    `owner_id` BIGINT COMMENT 'Reference to the employee or marketing team member responsible for owning, maintaining, and executing this content calendar. Supports accountability and workflow routing.',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Content planning in real estate is organized by property type. Marketing directors allocate content budgets and plan launch campaigns by asset class, requiring a normalized property type reference.',
    `prior_content_calendar_id` BIGINT COMMENT 'Self-referencing FK on content_calendar (prior_content_calendar_id)',
    `approval_date` DATE COMMENT 'Date on which the content calendar received final approval for execution. Used for compliance audit trails and workflow SLA tracking.',
    `approval_status` STRING COMMENT 'Current workflow approval state of the content calendar. Controls whether the calendar is actionable for content execution teams.. Valid values are `draft|pending_review|approved|rejected|archived`',
    `approved_by` STRING COMMENT 'Name or identifier of the marketing director or senior stakeholder who approved this content calendar for execution. Supports SOX marketing spend controls and audit trails.',
    `calendar_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the content calendar, used in cross-team communications, reporting, and system integrations (e.g., CC-2024Q3COM).. Valid values are `^CC-[A-Z0-9]{4,12}$`',
    `calendar_name` STRING COMMENT 'Human-readable name of the content calendar describing its scope and period (e.g., Q3 2024 Commercial Leasing Content Calendar — Downtown Portfolio).',
    `channel_mix` STRING COMMENT 'Comma-separated list of marketing channels included in this content calendar (e.g., email,social_media,paid_search,mls,website). Reflects the multi-channel distribution strategy planned for the period.',
    `content_spend_to_date` DECIMAL(18,2) COMMENT 'Actual marketing spend incurred against this content calendar to date. Enables budget variance tracking and CAPEX/OPEX reporting for marketing leadership.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this content calendar record was first created in the system. Supports audit trail, data lineage, and SOX compliance requirements.',
    `creative_theme` STRING COMMENT 'Overarching creative or messaging theme for the content calendar period (e.g., Urban Living 2024, Sustainability & ESG, Lease-Up Launch). Guides content tone, imagery, and copy direction.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary values in this content calendar record (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `digital_platform` STRING COMMENT 'Primary digital platform or CMS (Content Management System) used to publish and manage content items in this calendar (e.g., WordPress, HubSpot, Salesforce Marketing Cloud). Supports system-of-record traceability.',
    `esg_aligned` BOOLEAN COMMENT 'Indicates whether the content calendar includes ESG (Environmental, Social, and Governance) aligned content items, such as LEED certification announcements, sustainability reports, or green building promotions.',
    `fair_housing_compliant` BOOLEAN COMMENT 'Indicates whether all content items planned in this calendar have been reviewed and confirmed compliant with the Fair Housing Act and HUD advertising guidelines. Mandatory for residential marketing.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter within the fiscal year to which this content calendar primarily belongs (Q1–Q4). Used for quarterly marketing planning cycles.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this content calendar belongs, used for budget alignment and financial reporting (e.g., 2024).',
    `gdpr_compliant` BOOLEAN COMMENT 'Indicates whether the content calendar and associated digital marketing activities comply with GDPR data privacy requirements, including consent management for email and digital campaigns.',
    `key_property_launch_date` DATE COMMENT 'Date of the most significant property launch or go-to-market event within this calendar period. Anchors the content schedule around the primary business milestone.',
    `lease_up_milestone_date` DATE COMMENT 'Target date for a key lease-up milestone (e.g., 50% occupancy, stabilization) that content activities are designed to support. Aligns marketing execution with asset management objectives.',
    `market_event_date` DATE COMMENT 'Date of a significant external market event (e.g., industry conference, NAR convention, local market report release) that the content calendar is designed to leverage or respond to.',
    `mls_syndication_included` BOOLEAN COMMENT 'Indicates whether MLS listing syndication activities are included as part of this content calendars planned content items. Supports coordination with the listing_syndication product.',
    `notes` STRING COMMENT 'Free-text field for additional context, editorial guidance, stakeholder instructions, or special considerations relevant to this content calendar period.',
    `period_end_date` DATE COMMENT 'Last date of the planning period covered by this content calendar. Defines the effective end of scheduled content activities.',
    `period_start_date` DATE COMMENT 'First date of the planning period covered by this content calendar. Defines the effective start of scheduled content activities.',
    `planned_campaign_launch_count` STRING COMMENT 'Number of distinct marketing campaigns scheduled to launch within this content calendar period. Enables marketing leadership to assess workload and resource requirements.',
    `planned_content_item_count` STRING COMMENT 'Total number of individual content items (posts, emails, listings, ads, articles) planned for publication within this calendar period. Used for capacity planning and editorial governance.',
    `planned_listing_launch_count` STRING COMMENT 'Number of new property listing launches scheduled within this content calendar period. Supports coordination between brokerage, marketing, and MLS syndication teams.',
    `planning_period_type` STRING COMMENT 'Granularity of the planning horizon covered by this content calendar — monthly, quarterly, annual, or a custom date range.. Valid values are `monthly|quarterly|annual|custom`',
    `portfolio_scope` STRING COMMENT 'Name or identifier of the property portfolio or sub-portfolio this content calendar covers (e.g., Downtown Commercial Portfolio, Southeast Residential). Enables portfolio-level marketing coordination.',
    `source_system` STRING COMMENT 'Operational system of record from which this content calendar record originated or is primarily managed (e.g., Salesforce CRM, Yardi Voyager, manual entry).. Valid values are `salesforce|yardi|mri|manual|other`',
    `source_system_calendar_code` STRING COMMENT 'Native identifier of this content calendar record in the originating operational system (e.g., Salesforce Campaign ID, Yardi internal reference). Enables lineage tracing and reconciliation.',
    `total_content_budget` DECIMAL(18,2) COMMENT 'Total approved marketing budget allocated to content activities within this calendar period, expressed in the operating currency. Supports OPEX (Operating Expenditure) tracking and marketing spend governance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this content calendar record was most recently modified. Used for change tracking, incremental data loads, and audit compliance.',
    CONSTRAINT pk_content_calendar PRIMARY KEY(`content_calendar_id`)
) COMMENT 'Master record for the marketing content calendar — the planned schedule of content publications, campaign launches, listing promotions, and marketing activities across all channels for a defined period. Captures calendar name, planning period (month, quarter), property or portfolio scope, planned content items count, channel mix, key dates (property launches, lease-up milestones, market events), calendar owner, approval status, and last updated date. Enables coordinated multi-channel marketing execution planning.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique surrogate identifier for the marketing vendor record in the Silver Layer lakehouse. Primary key for the marketing_vendor master entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Vendor relationship management in real estate marketing requires a named internal employee accountable for each vendor contract and performance review. The vendor management process assigns an account',
    `cost_center_id` BIGINT COMMENT 'Reference to the finance cost center responsible for marketing vendor spend. Used for GL (General Ledger) coding of vendor invoices and budget allocation reporting in SAP S/4HANA and Yardi Voyager.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Marketing vendor contracts for international real estate firms are denominated in various currencies. Normalizing retainer_amount currency to reference.currency_code enables AP processing and vendor s',
    `parent_vendor_id` BIGINT COMMENT 'Self-referencing FK on vendor (parent_vendor_id)',
    `contract_end_date` DATE COMMENT 'Expiry date of the current master service agreement or engagement contract with the marketing vendor. Null indicates an open-ended or evergreen arrangement. Used for contract renewal alerts and vendor eligibility checks.',
    `contract_reference` STRING COMMENT 'Reference number or identifier of the executed master service agreement (MSA) or statement of work (SOW) with this marketing vendor, as recorded in DocuSign CLM or SAP S/4HANA contract management. Links the vendor record to the formal contractual instrument.',
    `contract_start_date` DATE COMMENT 'Effective start date of the current master service agreement or engagement contract with the marketing vendor. Determines the period during which the vendor is authorized to provide services and receive payment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the marketing vendor record was first created in the Silver Layer data product. Provides audit trail for record provenance and supports SOX compliance for financial data governance.',
    `digital_platform_specialization` STRING COMMENT 'Comma-separated list or description of digital advertising platforms, MLS syndication networks, or marketing technology tools in which this vendor has demonstrated expertise (e.g., Google Ads, Meta, CoStar, Zillow, LoopNet, programmatic DSPs). Supports channel-specific vendor selection.',
    `engagement_end_date` DATE COMMENT 'Date on which the marketing vendor engagement was formally concluded or is scheduled to conclude. Null for ongoing engagements. Distinct from contract_end_date, which reflects the contractual term; this field reflects the operational end of the working relationship.',
    `engagement_start_date` DATE COMMENT 'Date on which the marketing team first engaged this vendor for services, which may predate the current contract start date if the relationship spans multiple contract periods. Used for WALT (Weighted Average Lease Term) analogy calculations on vendor tenure.',
    `esg_certified_flag` BOOLEAN COMMENT 'Indicates whether this marketing vendor holds recognized ESG, sustainability, or diversity certifications (e.g., B Corp, minority-owned, women-owned, LEED-aligned practices). Supports ESG reporting requirements and responsible procurement policies for publicly traded REITs.',
    `fee_structure_type` STRING COMMENT 'Classification of the commercial fee arrangement with the marketing vendor. Retainer indicates a fixed monthly fee; project-based is per-engagement; commission is a percentage of media spend; hourly is time-and-materials; media markup is a percentage added to media buys; hybrid combines multiple models.. Valid values are `retainer|project_based|commission|hourly|media_markup|hybrid`',
    `gdpr_dpa_executed_flag` BOOLEAN COMMENT 'Indicates whether a GDPR-compliant Data Processing Agreement (DPA) has been executed with this marketing vendor. Mandatory for vendors who process personal data of EU-based tenants, prospects, or contacts on behalf of the real estate organization.',
    `geographic_coverage` STRING COMMENT 'Description of the geographic markets or regions in which this marketing vendor operates and can deliver services. May reference metropolitan statistical areas (MSAs), states, countries, or GIS-defined market areas. Supports vendor selection for geographically targeted campaigns.',
    `insurance_certificate_ref` STRING COMMENT 'Reference number or document identifier for the vendors current certificate of insurance (COI), including general liability and errors & omissions coverage. Required for vendor onboarding compliance and maintained in the document management system.',
    `insurance_expiry_date` DATE COMMENT 'Expiry date of the marketing vendors current certificate of insurance. Triggers renewal alerts to ensure continuous coverage compliance. Vendors with expired insurance are flagged for suspension pending renewal.',
    `last_performance_review_date` DATE COMMENT 'Date on which the most recent formal performance review of this marketing vendor was completed. Used to schedule upcoming reviews and ensure compliance with vendor management policy cadence.',
    `nda_executed_flag` BOOLEAN COMMENT 'Indicates whether a Non-Disclosure Agreement (NDA) has been fully executed with this marketing vendor. Required before sharing proprietary property data, tenant information, or competitive market intelligence with the vendor. Tracked in DocuSign CLM.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, special instructions, relationship history, or qualitative observations about the marketing vendor that are not captured in structured fields. Used by marketing managers and procurement teams.',
    `onboarding_date` DATE COMMENT 'Date on which the marketing vendor completed the formal onboarding process, including submission of W-9, insurance certificate, NDA, and vendor qualification review. Marks the vendor as eligible for campaign assignment and purchase order issuance.',
    `payment_terms` STRING COMMENT 'Agreed payment terms for invoices submitted by this marketing vendor, as defined in the master service agreement. Drives AP payment scheduling in Yardi Voyager and SAP S/4HANA. Net_30 is the most common standard in commercial real estate vendor contracts.. Valid values are `net_15|net_30|net_45|net_60|due_on_receipt|milestone_based`',
    `performance_rating` DECIMAL(18,2) COMMENT 'Numeric performance rating assigned to the marketing vendor based on periodic evaluation of service quality, campaign delivery, responsiveness, and ROI contribution. Typically scored on a 1.0–5.0 scale. Drives preferred vendor status decisions and contract renewal recommendations.',
    `portfolio_scope` STRING COMMENT 'Indicates the property portfolio segment(s) this marketing vendor is authorized or specialized to serve. Supports campaign assignment logic and vendor capability matching across commercial real estate (CRE), residential, industrial, and retail portfolios.. Valid values are `commercial|residential|mixed|industrial|retail|all`',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether this marketing vendor holds preferred vendor status within the real estate organizations approved vendor program. Preferred vendors receive priority consideration for new campaign assignments and may benefit from streamlined procurement approvals.',
    `primary_contact_email` STRING COMMENT 'Business email address of the primary contact at the marketing vendor. Used for campaign briefs, invoice correspondence, and contract communications. Classified as confidential PII per GDPR Article 4.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary account manager or relationship contact at the marketing vendor organization. Used for day-to-day campaign coordination and escalation.',
    `primary_contact_phone` STRING COMMENT 'Business phone number of the primary contact at the marketing vendor. Used for urgent campaign coordination and escalation. Classified as confidential PII per GDPR Article 4.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `rate_card_reference` STRING COMMENT 'Reference identifier or document name for the vendors approved rate card or fee schedule, as stored in DocuSign CLM or the marketing teams document repository. Provides a pointer to the detailed pricing schedule for hourly, project, or media markup engagements.',
    `retainer_amount` DECIMAL(18,2) COMMENT 'Fixed monthly retainer fee payable to the marketing vendor under a retainer-based fee structure. Null if the vendor operates on a project-based, commission, or hourly model. Used for budget forecasting and AP accruals in Yardi Voyager and SAP S/4HANA.',
    `services_provided` STRING COMMENT 'Free-text or structured description of the specific marketing services this vendor delivers, such as SEO/SEM, social media advertising, property photography, 3D virtual tours, print collateral, media planning, public relations, or competitive market intelligence. Supports capability matching during campaign planning.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this marketing vendor record was originated or is primarily maintained. Supports data lineage tracking and reconciliation across Salesforce CRM, SAP S/4HANA, and Yardi Voyager.. Valid values are `salesforce_crm|sap_s4hana|yardi_voyager|manual|docusign_clm`',
    `source_system_vendor_code` STRING COMMENT 'The native vendor identifier as assigned in the originating source system (e.g., Salesforce Account ID, SAP Vendor Number, Yardi Vendor Code). Enables bi-directional reconciliation and deduplication across operational systems.',
    `tax_identification_number` STRING COMMENT 'Federal Employer Identification Number (EIN) or equivalent tax identification number for the marketing vendor. Required for IRS 1099 reporting and AP payment processing. Stored as confidential business data.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the marketing vendor record was most recently modified in the Silver Layer data product. Used for incremental data pipeline processing, change detection, and audit trail maintenance.',
    `vendor_code` STRING COMMENT 'Externally-known alphanumeric business identifier assigned to the marketing vendor, used for cross-system reference in procurement, AP, and campaign management workflows. Sourced from SAP S/4HANA vendor master or Salesforce CRM vendor record.. Valid values are `^MKT-VND-[A-Z0-9]{4,12}$`',
    `vendor_name` STRING COMMENT 'Full legal or trading name of the external marketing vendor, agency, or service provider as registered in the vendor master. Used for contract identification, invoice matching, and reporting.',
    `vendor_status` STRING COMMENT 'Current lifecycle status of the marketing vendor engagement. Controls whether the vendor is eligible for new campaign assignments and purchase order issuance. Active vendors are approved for spend; suspended or blacklisted vendors are blocked from new engagements.. Valid values are `active|inactive|pending_approval|suspended|blacklisted|under_review`',
    `vendor_tier` STRING COMMENT 'Strategic tier classification of the marketing vendor based on spend volume, relationship depth, and strategic importance. Tier 1 vendors are strategic partners with enterprise-level agreements; Tier 2 are preferred vendors with established relationships; Tier 3 are transactional or project-based vendors.. Valid values are `tier_1|tier_2|tier_3`',
    `vendor_type` STRING COMMENT 'Categorical classification of the marketing vendor by the primary nature of services provided. Drives routing, approval workflows, and spend analytics by vendor category. [ENUM-REF-CANDIDATE: advertising_agency|digital_marketing_firm|photography_studio|virtual_tour_provider|print_vendor|media_buying_agency|pr_firm|market_research_company — promote to reference product]',
    `w9_on_file_flag` BOOLEAN COMMENT 'Indicates whether a valid IRS Form W-9 (or equivalent tax identification document for non-US vendors) has been received and is on file for this marketing vendor. Required for AP payment processing and 1099 reporting compliance.',
    `website` STRING COMMENT 'Public website URL of the marketing vendor. Used for vendor due diligence, capability research, and portfolio review during vendor selection.. Valid values are `^https?://[^s/$.?#].[^s]*$`',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master record for external marketing vendors, agencies, and service providers engaged by the marketing team — advertising agencies, digital marketing firms, photography studios, virtual tour providers, print vendors, media buying agencies, PR firms, and market research companies. Captures vendor name, vendor type, services provided, contract reference, primary contact, engagement start and end dates, rate card or fee structure, preferred vendor status, performance rating, and vendor status. Distinct from general procurement — this is the marketing-domain vendor registry.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`press_release` (
    `press_release_id` BIGINT COMMENT 'Unique system-generated identifier for each press release record in the real estate enterprises public relations repository.',
    `asset_id` BIGINT COMMENT 'Reference to the specific property record associated with this press release (e.g., a property acquisition announcement, lease signing, or development groundbreaking). Null if the release is not property-specific.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Press releases are issued under a specific brand identity (corporate brand, sub-brand, or property brand). Linking press_release to brand enables brand-level PR tracking, ensures brand guideline compl',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Press releases announce building-specific milestones: LEED certifications, grand openings, major renovations, anchor tenant signings. In multi-building campuses, building-level attribution is required',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign with which this press release is associated, enabling attribution of media coverage to specific brand or property marketing initiatives.',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to maintenance.capex_project. Business justification: Real estate PR process: major capital projects (building renovations, new amenity construction) generate press releases announcing project completion or groundbreaking. Linking press_release to capex_',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Press releases are routinely issued for groundbreakings, construction milestones, entitlement approvals, and project completions. Linking press_release to dev_project enables PR teams to track all com',
    `employee_id` BIGINT COMMENT 'Reference to the internal workforce record of the employee who authored the press release. Links to the HR/workforce system for accountability and audit.',
    `event_id` BIGINT COMMENT 'Foreign key linking to marketing.marketing_event. Business justification: Press releases are frequently issued to announce or follow up on marketing events (open house announcements, grand opening press releases, investor event summaries). Linking press_release to marketing',
    `fund_id` BIGINT COMMENT 'Foreign key linking to investment.fund. Business justification: Press releases announcing fund closes, fund launches, or fund milestones are directly tied to a specific fund. IR teams track fund-level communications history; a real estate fund manager expects ever',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Press releases in real estate are scoped to geographic markets (e.g., XYZ REIT acquires industrial portfolio in Dallas-Fort Worth). Normalizing enables IR reporting of press coverage by market and i',
    `investment_deal_id` BIGINT COMMENT 'Foreign key linking to investment.investment_deal. Business justification: Press releases announcing acquisitions, dispositions, or joint ventures are tied to a specific investment deal. IR and PR teams track which deal a press release relates to for deal-level communication',
    `lease_agreement_id` BIGINT COMMENT 'Foreign key linking to lease.agreement. Business justification: Press releases announcing significant lease signings (anchor tenants, large commercial deals) must reference the specific executed agreement. Standard commercial real estate communications practice. P',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Press releases announcing acquisitions, development milestones, or leasing achievements are issued by specific org units. IR/PR attribution reporting and brand governance require knowing which divisio',
    `owner_id` BIGINT COMMENT 'Foreign key linking to owner.owner. Business justification: Press releases in real estate are issued on behalf of property owners announcing acquisitions, dispositions, or developments. Owner attribution is required for investor relations compliance, PR attrib',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio or asset portfolio that this press release pertains to, used for portfolio-level brand management and investor communications.',
    `property_sale_id` BIGINT COMMENT 'Foreign key linking to transaction.property_sale. Business justification: Press releases in real estate are frequently issued to announce property acquisitions, dispositions, and closings — all of which are recorded as property_sale records in the transaction domain. The pr',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Press releases in real estate are categorized by property type (industrial acquisition, multifamily development). IR and communications teams filter press coverage by asset class for investor reportin',
    `superseded_press_release_id` BIGINT COMMENT 'Self-referencing FK on press_release (superseded_press_release_id)',
    `approval_status` STRING COMMENT 'Current workflow state of the press release through the editorial and legal approval lifecycle: draft, pending_review, approved, published, retracted, or archived.. Valid values are `draft|pending_review|approved|published|retracted|archived`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time at which the press release received final editorial and legal approval for distribution. Distinct from the published_timestamp; supports compliance audit trails.',
    `approved_by` STRING COMMENT 'Full name of the executive or communications director who granted final approval for publication. Required for SOX compliance and investor relations governance.',
    `author_name` STRING COMMENT 'Full name of the internal employee or communications professional who authored the press release. Used for editorial accountability and workflow routing.',
    `body_text` STRING COMMENT 'Full narrative body content of the press release including all paragraphs, boilerplate, and supporting detail. Stored as plain text or lightly formatted string for search and analytics.',
    `boilerplate_text` STRING COMMENT 'Standard About the Company boilerplate paragraph appended to press releases describing the enterprises business, portfolio, and brand positioning. Versioned separately from body content.',
    `contact_email` STRING COMMENT 'Email address of the designated media contact listed in the press release for journalist and media inquiries. Classified as confidential PII per GDPR.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Full name of the designated media contact person listed in the press release for journalist inquiries. Typically a communications manager or PR agency representative.',
    `contact_phone` STRING COMMENT 'Phone number of the designated media contact listed in the press release. Classified as confidential PII per GDPR.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the press release record was first created in the system. Serves as the audit creation timestamp for data lineage and compliance tracking.',
    `embargo_date` DATE COMMENT 'Date before which the press release content must not be published or disclosed publicly. Null indicates no embargo restriction. Critical for coordinating simultaneous media releases.',
    `embargo_time` TIMESTAMP COMMENT 'Precise date and time (with timezone) at which the embargo lifts and the press release may be published. Provides time-zone-aware precision beyond the embargo_date for coordinated global releases.',
    `esg_aligned` BOOLEAN COMMENT 'Indicates whether the press release content relates to or supports the enterprises ESG (Environmental, Social, and Governance) reporting, sustainability initiatives, LEED certifications, or green building announcements.',
    `estimated_reach` BIGINT COMMENT 'Estimated total audience reach (number of individuals) across all media outlets that published or referenced the press release. Sourced from wire service analytics or media monitoring tools.',
    `headline` STRING COMMENT 'Primary headline or title of the press release as it appears in the published communication. Used for media indexing, brand management, and investor relations reporting.',
    `ir_relevant` BOOLEAN COMMENT 'Indicates whether the press release is material to investor relations communications, such as financial results, REIT disclosures, or significant portfolio transactions. Triggers additional SEC review workflows.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code (optionally with ISO 3166-1 country subtag) indicating the language in which the press release is written (e.g., en, en-US, es, fr). Supports multilingual distribution.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `legal_reviewed` BOOLEAN COMMENT 'Indicates whether the press release has been reviewed and cleared by the legal department prior to publication. Mandatory for releases referencing transactions, financial results, or regulatory matters.',
    `media_pickup_count` STRING COMMENT 'Number of distinct media outlets, publications, or online sources that picked up and published or referenced the press release. Key performance indicator for PR campaign effectiveness and brand reach.',
    `notes` STRING COMMENT 'Free-text internal notes or editorial comments associated with the press release record. Not published externally; used for internal communications team coordination.',
    `published_timestamp` TIMESTAMP COMMENT 'Exact date and time the press release was officially published and made available to the public or distributed via wire service. Used for compliance audit trails and media pickup tracking.',
    `published_url` STRING COMMENT 'Canonical public URL where the press release is hosted and accessible online, either on the company website or the wire service landing page. Supports brand management and investor relations linking.',
    `release_date` DATE COMMENT 'The official date on which the press release is authorized for public distribution. Represents the principal business event date for the communication.',
    `release_number` STRING COMMENT 'Externally-known alphanumeric reference code assigned to the press release for tracking across distribution channels, wire services, and media archives (e.g., PR-2024-00123).. Valid values are `^PR-[0-9]{4}-[0-9]{5}$`',
    `release_type` STRING COMMENT 'Classification of the press release by business event category. Drives routing, template selection, and analytics segmentation. [ENUM-REF-CANDIDATE: acquisition|disposition|lease_signing|development_groundbreaking|award_recognition|executive_appointment|market_commentary|financial_results|partnership|other — promote to reference product]',
    `retraction_reason` STRING COMMENT 'Explanation of why the press release was retracted or withdrawn after publication. Populated only when approval_status is retracted. Required for compliance and brand management audit trails.',
    `source_system` STRING COMMENT 'Name of the operational system of record from which this press release record originated or was ingested (e.g., Salesforce CRM for deal-linked releases, DocuSign CLM for contract announcement releases, or manual entry).. Valid values are `Salesforce CRM|DocuSign CLM|manual|other`',
    `source_system_ref` STRING COMMENT 'Unique identifier of the press release record in the originating source system (e.g., Salesforce record ID, DocuSign envelope ID). Enables traceability and reconciliation with upstream systems.',
    `subheadline` STRING COMMENT 'Secondary supporting headline or deck copy that provides additional context beneath the primary headline, commonly used in wire service distributions.',
    `target_media_outlets` STRING COMMENT 'Comma-separated list or descriptive text identifying the specific media outlets, journalists, or publication categories targeted for this press release distribution (e.g., WSJ, Bloomberg, CoStar News, local business journals).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the press release record was last modified in the system. Used for change tracking, data freshness monitoring, and audit compliance.',
    `version_number` STRING COMMENT 'Sequential version number of the press release, incremented each time the content is materially revised prior to or after publication. Supports editorial version control and audit history.',
    `wire_service` STRING COMMENT 'Name of the press release distribution wire service used to disseminate the release to media outlets (e.g., PR Newswire, BusinessWire, GlobeNewswire). Null or none if distributed through proprietary channels only.. Valid values are `PR Newswire|BusinessWire|GlobeNewswire|Accesswire|none`',
    `wire_service_ref` STRING COMMENT 'Unique reference or confirmation number assigned by the wire service upon successful submission and distribution of the press release. Used for reconciliation and tracking.',
    CONSTRAINT pk_press_release PRIMARY KEY(`press_release_id`)
) COMMENT 'Master record for press releases and public relations communications issued by the real estate enterprise — property acquisition announcements, development groundbreakings, lease signings, award recognitions, executive appointments, and market commentary. Captures headline, release date, embargo date, distribution wire service (PR Newswire, BusinessWire), target media outlets, property or transaction reference, author, approval status, published URL, and media pickup count. Supports brand management and investor relations communications.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`campaign_property` (
    `campaign_property_id` BIGINT COMMENT 'Unique surrogate identifier for the campaign-property association record. Primary key for this junction entity linking a marketing campaign to a specific property asset.',
    `asset_id` BIGINT COMMENT 'Reference to the property or portfolio asset being promoted within the campaign. Identifies the specific real estate asset included in this campaign association.',
    `building_class_id` BIGINT COMMENT 'Foreign key linking to reference.building_class. Business justification: Campaign property targeting and performance reporting in CRE is segmented by building class. Normalizing enables marketing spend analysis by Class A/B/C and comparison against class-level rent benchma',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Multi-building campus assets require building-level campaign scoping. Leasing campaigns for a specific tower within a mixed-use campus are tracked at building level. This enables building-level market',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign under which this property is being promoted. Links to the campaign master record.',
    `lease_agreement_id` BIGINT COMMENT 'Foreign key linking to lease.agreement. Business justification: Links a specific campaign-property marketing effort to the resulting executed lease, enabling per-property marketing ROI calculation. Asset managers and marketing directors need to know which campaign',
    `listing_id` BIGINT COMMENT 'Reference to the active property listing record associated with this campaign-property inclusion. Links campaign promotion to the specific listing version active during the campaign period.',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio or property portfolio to which this property belongs, when the campaign is promoting a portfolio of assets. Supports portfolio-level campaign attribution and AUM reporting.',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Campaign property inclusion decisions and marketing spend allocation are reported by property type. Normalizing enables campaign ROI analysis segmented by asset class for portfolio marketing decisions',
    `sustainability_rating_id` BIGINT COMMENT 'Foreign key linking to reference.sustainability_rating. Business justification: ESG-aligned marketing campaigns highlight sustainability certifications as a key selling point. Normalizing green_certification_code to reference.sustainability_rating enables ESG marketing reporting ',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Properties are marketed for specific transaction types (for sale, for lease, for investment). Campaign property records must reference the transaction type to ensure correct messaging, pricing display',
    `replaced_campaign_property_id` BIGINT COMMENT 'Self-referencing FK on campaign_property (replaced_campaign_property_id)',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'Actual marketing expenditure incurred for promoting this specific property within the campaign to date. Used for budget variance analysis and property-level OPEX tracking.',
    `approval_date` DATE COMMENT 'The date on which the inclusion of this property in the campaign was formally approved by the authorized marketing or asset management stakeholder.',
    `approved_by` STRING COMMENT 'Name or identifier of the marketing manager or asset manager who approved the inclusion of this property in the campaign. Supports governance, audit trail, and SOX compliance for marketing spend authorization.',
    `asking_price` DECIMAL(18,2) COMMENT 'The listed asking price for the property at the time of campaign inclusion, applicable for sale transactions. Used in campaign creative and lead qualification. Expressed in the campaigns operating currency.',
    `asking_rent_psf` DECIMAL(18,2) COMMENT 'The advertised asking rent expressed on a per-square-foot (PSF) basis for lease transactions. Key metric used in campaign materials and competitive positioning for commercial leasing campaigns.',
    `available_sqft` DECIMAL(18,2) COMMENT 'The total available square footage (SQF) of the property being marketed in this campaign. Used in campaign listings, lead qualification, and size-based audience targeting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this campaign-property association record was first created in the system. Supports audit trail, data lineage, and Silver Layer ingestion tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to all monetary amounts on this record (property_budget_amount, actual_spend_amount). Defaults to the campaigns operating currency.. Valid values are `^[A-Z]{3}$`',
    `days_on_market` STRING COMMENT 'Number of days this property has been actively marketed as of the campaign association record. A key real estate performance indicator used to assess campaign urgency, pricing competitiveness, and market demand.',
    `esg_aligned` BOOLEAN COMMENT 'Indicates whether the propertys campaign promotion highlights ESG credentials such as LEED certification, BREEAM rating, or other sustainability attributes as part of the campaign messaging strategy.',
    `fair_housing_compliant` BOOLEAN COMMENT 'Indicates whether the campaign materials and promotional content for this property have been reviewed and confirmed compliant with the Fair Housing Act and applicable anti-discrimination regulations.',
    `geographic_market` STRING COMMENT 'The geographic market or submarket designation for this property within the campaign (e.g., Manhattan Midtown, Austin CBD, Los Angeles Westside). Used for market-level campaign performance segmentation and CoStar submarket alignment.',
    `inclusion_end_date` DATE COMMENT 'The date on which this propertys promotion within the campaign is scheduled to end or was actually removed. Nullable for open-ended inclusions that run through the campaigns full duration.',
    `inclusion_start_date` DATE COMMENT 'The date on which this property began being actively promoted within the campaign. May differ from the campaign start date if the property was added mid-campaign.',
    `inclusion_status` STRING COMMENT 'Current lifecycle status of this propertys inclusion within the campaign. active means the property is currently being promoted; paused means promotion is temporarily suspended; pending means inclusion is approved but not yet live; removed means the property has been withdrawn from the campaign; completed means the campaign period for this property has ended.. Valid values are `active|paused|pending|removed|completed`',
    `is_featured` BOOLEAN COMMENT 'Indicates whether this property is designated as the featured or hero property in the campaign, receiving premium placement in campaign materials, digital ads, and listing portals.',
    `listing_url` STRING COMMENT 'The specific listing URL used to promote this property within the campaign. May be a campaign-specific landing page URL distinct from the standard MLS or portal listing URL, enabling campaign-level click tracking and attribution.. Valid values are `^https?://.+`',
    `mls_number` STRING COMMENT 'The MLS listing number associated with this property as used in the campaign. Enables cross-referencing with MLS syndication records and tracking of campaign-driven MLS activity.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, special instructions, or qualitative observations about this propertys inclusion in the campaign (e.g., negotiated placement terms, special promotional conditions, asset manager directives).',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the relative promotional priority of this property within the campaign. Lower values indicate higher priority. Used to determine placement order in multi-property campaign materials and digital listings.',
    `property_budget_amount` DECIMAL(18,2) COMMENT 'The portion of the overall campaign budget specifically allocated to promote this individual property. Enables property-level marketing spend tracking and ROI analysis. Expressed in the campaigns operating currency.',
    `property_lead_count` STRING COMMENT 'Number of qualified leads directly attributed to this propertys promotion within the campaign. Supports property-level lead attribution and campaign effectiveness measurement.',
    `property_role` STRING COMMENT 'Defines the strategic role this property plays within the campaign. featured indicates the property is the primary promotional focus; portfolio_showcase indicates it is part of a multi-asset portfolio presentation; comparable_reference indicates it is used as a market comparable; anchor indicates it is the lead asset driving campaign identity; supporting indicates a secondary promotional role.. Valid values are `featured|portfolio_showcase|comparable_reference|anchor|supporting`',
    `removal_reason` STRING COMMENT 'Reason code explaining why this property was removed or excluded from the campaign before its scheduled end date. Populated only when inclusion_status is removed. Supports campaign post-mortem analysis and portfolio management. [ENUM-REF-CANDIDATE: sold|leased|withdrawn|budget_exhausted|strategy_change|duplicate|other — promote to reference product]',
    `source_system` STRING COMMENT 'The operational system of record from which this campaign-property association record originated (e.g., Salesforce CRM, Yardi Voyager, MRI Software). Supports data lineage and reconciliation in the Silver Layer.. Valid values are `Salesforce|Yardi|MRI|CoStar|Manual|Other`',
    `source_system_ref` STRING COMMENT 'The native identifier or record key for this campaign-property association in the originating source system. Enables traceability and reconciliation between the lakehouse Silver Layer and the operational system of record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this campaign-property association record was last modified. Supports change tracking, incremental data loads, and audit compliance in the Databricks Silver Layer.',
    `utm_campaign` STRING COMMENT 'The UTM campaign tracking parameter appended to the propertys listing URL for this campaign association. Enables digital attribution of web traffic and leads to this specific campaign-property combination.',
    `utm_medium` STRING COMMENT 'The UTM medium tracking parameter identifying the marketing medium used for this propertys campaign promotion (e.g., cpc, email, display, organic). Supports multi-channel attribution reporting.',
    `utm_source` STRING COMMENT 'The UTM source tracking parameter identifying the originating platform or channel for this propertys campaign promotion (e.g., costar, loopnet, zillow, google). Supports channel-level attribution analysis.',
    CONSTRAINT pk_campaign_property PRIMARY KEY(`campaign_property_id`)
) COMMENT 'Association entity linking a marketing campaign to the specific properties or portfolio assets being promoted within that campaign. Captures campaign reference, property asset reference, property role in campaign (featured property, portfolio showcase, comparable reference), inclusion start and end dates, property-specific budget allocation, property-specific lead count, and listing URL used in campaign. Enables property-level campaign attribution and multi-property campaign management.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`campaign_unit_inclusion` (
    `campaign_unit_inclusion_id` BIGINT COMMENT 'Unique surrogate identifier for this campaign-unit inclusion record. Primary key for the association.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the marketing campaign in which this unit is featured',
    `unit_id` BIGINT COMMENT 'Foreign key linking to the specific leasable or saleable unit included in this campaign',
    `asking_rent_at_inclusion` DECIMAL(18,2) COMMENT 'The asking rent per square foot (PSF) for this unit at the time it was included in the campaign. Captured as a point-in-time snapshot because asking rent may change during the campaign lifecycle, and marketing needs to track what rent was advertised.',
    `campaign_unit_budget` DECIMAL(18,2) COMMENT 'The portion of the total campaign budget allocated specifically to promoting this unit. Used in multi-unit campaigns to track spend per unit and calculate cost-per-lead and cost-per-lease at the unit level.',
    `inclusion_end_date` DATE COMMENT 'The date on which this unit was removed from the campaign or the campaign concluded. Used to calculate total days featured and measure time-to-lease for campaign-driven leads.',
    `inclusion_start_date` DATE COMMENT 'The date on which this unit was added to the campaign and began being featured in marketing materials. Used to calculate exposure duration and align with campaign flight dates.',
    `is_featured` BOOLEAN COMMENT 'Indicates whether this unit is designated as a featured or hero unit within the campaign, receiving premium placement in creative assets and higher budget allocation.',
    `priority_rank` STRING COMMENT 'The priority ranking of this unit within the campaign (1 = highest priority). Determines placement in digital ads, email sequences, and listing order on landing pages. Used by marketing to feature premium or high-vacancy units more prominently.',
    CONSTRAINT pk_campaign_unit_inclusion PRIMARY KEY(`campaign_unit_inclusion_id`)
) COMMENT 'This association product represents the inclusion of a specific unit in a marketing campaign. It captures the operational relationship between property inventory and marketing activities. Each record links one unit to one campaign with attributes that track when the unit was featured, at what asking rent, with what priority level, and what budget was allocated to promote that specific unit within the campaign.. Existence Justification: In real estate marketing operations, a single unit can be simultaneously featured across multiple campaigns (e.g., a vacant unit appears in a lease-up campaign, a seasonal promotion, and a referral incentive campaign at the same time), and a single campaign typically promotes multiple units (e.g., a building lease-up campaign features 20+ available units). Marketing teams actively manage these inclusions, adjusting which units are featured, at what priority, and with what budget allocation as vacancy and market conditions change.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`marketing`.`campaign_contribution` (
    `campaign_contribution_id` BIGINT COMMENT 'Unique surrogate identifier for each employee-campaign contribution record. Primary key for the association.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the marketing campaign receiving the contribution',
    `employee_id` BIGINT COMMENT 'Foreign key to workforce.employee identifying the contributing employee',
    `actual_hours` DECIMAL(18,2) COMMENT 'The actual total hours the employee contributed to this campaign, as recorded in time tracking systems. Used for performance analysis, cost reconciliation, and future estimation calibration.',
    `allocation_pct` DECIMAL(18,2) COMMENT 'The percentage of the employees working time allocated to this campaign during the contribution period. Used for workload balancing, capacity planning, and cost allocation. Values range from 0.01 to 100.00.',
    `assignment_status` STRING COMMENT 'Current lifecycle state of this employees assignment to the campaign. Values: Planned (scheduled but not started), Active (currently contributing), On Hold (temporarily paused), Completed (contribution finished), Cancelled (assignment removed before completion). Drives active resource reporting.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether this employees time on this campaign is billable to a client or property owner (true) or is internal overhead (false). Relevant for brokerage campaigns where marketing costs may be passed through to sellers.',
    `contribution_type` STRING COMMENT 'High-level categorization of the nature of the employees contribution to the campaign. Values: Creative (content creation, design), Execution (campaign deployment, coordination), Strategy (planning, targeting), Analysis (performance measurement), Support (administrative, logistics). Used for team composition analysis.',
    `created_at` TIMESTAMP COMMENT 'System timestamp indicating when this contribution record was created in the data product.',
    `end_date` DATE COMMENT 'The date on which the employees contribution to this campaign concluded. Null if the employee is still actively contributing. Used to calculate actual contribution duration and close out resource assignments.',
    `estimated_hours` DECIMAL(18,2) COMMENT 'The estimated total hours the employee is expected to contribute to this campaign over the contribution period. Used for resource planning and budget estimation.',
    `is_primary_owner` BOOLEAN COMMENT 'Indicates whether this employee is the primary owner or lead for the campaign. Typically only one employee per campaign has this flag set to true. Used to identify accountability and primary contact.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context about this employees contribution to the campaign, such as specific deliverables, special circumstances, or handoff notes.',
    `role_on_campaign` STRING COMMENT 'The specific functional role the employee performs on this campaign. Examples: Lead Agent (primary listing agent), Supporting Agent, Marketing Coordinator, Photographer, Copywriter, Graphic Designer, Social Media Manager, Campaign Manager, Analyst. Drives responsibility assignment and performance attribution.',
    `start_date` DATE COMMENT 'The date on which the employee began contributing to this campaign. Used to track contribution duration and align with campaign phases.',
    `updated_at` TIMESTAMP COMMENT 'System timestamp indicating when this contribution record was last modified.',
    CONSTRAINT pk_campaign_contribution PRIMARY KEY(`campaign_contribution_id`)
) COMMENT 'This association product represents the participation of real estate workforce personnel in marketing campaigns. It captures the specific role, time allocation, and contribution period for each employee working on each campaign. Each record links one employee to one campaign with attributes that exist only in the context of this working relationship, enabling tracking of multi-disciplinary campaign teams and individual workload allocation across concurrent campaigns.. Existence Justification: In real estate marketing operations, campaigns require multi-disciplinary teams where a single employee (e.g., a listing agent) works across multiple concurrent campaigns, and each campaign engages multiple employees in different roles (photographer, copywriter, marketing coordinator, lead agent). The business actively manages these assignments with specific role definitions, time allocation percentages, and contribution periods that are tracked, updated, and reported on as operational data.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `real_estate_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `real_estate_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_prior_campaign_id` FOREIGN KEY (`prior_campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_ad_creative_id` FOREIGN KEY (`ad_creative_id`) REFERENCES `real_estate_ecm`.`marketing`.`ad_creative`(`ad_creative_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `real_estate_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `real_estate_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `real_estate_ecm`.`marketing`.`vendor`(`vendor_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_prior_campaign_flight_id` FOREIGN KEY (`prior_campaign_flight_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign_flight`(`campaign_flight_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `real_estate_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `real_estate_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_derived_ad_creative_id` FOREIGN KEY (`derived_ad_creative_id`) REFERENCES `real_estate_ecm`.`marketing`.`ad_creative`(`ad_creative_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `real_estate_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_digital_listing_id` FOREIGN KEY (`digital_listing_id`) REFERENCES `real_estate_ecm`.`marketing`.`digital_listing`(`digital_listing_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_superseded_listing_syndication_id` FOREIGN KEY (`superseded_listing_syndication_id`) REFERENCES `real_estate_ecm`.`marketing`.`listing_syndication`(`listing_syndication_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `real_estate_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_digital_listing_id` FOREIGN KEY (`digital_listing_id`) REFERENCES `real_estate_ecm`.`marketing`.`digital_listing`(`digital_listing_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_master_lead_id` FOREIGN KEY (`master_lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_duplicate_lead_id` FOREIGN KEY (`duplicate_lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_campaign_flight_id` FOREIGN KEY (`campaign_flight_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign_flight`(`campaign_flight_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `real_estate_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_digital_listing_id` FOREIGN KEY (`digital_listing_id`) REFERENCES `real_estate_ecm`.`marketing`.`digital_listing`(`digital_listing_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_parent_lead_activity_id` FOREIGN KEY (`parent_lead_activity_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead_activity`(`lead_activity_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ADD CONSTRAINT `fk_marketing_lead_attribution_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ADD CONSTRAINT `fk_marketing_lead_attribution_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `real_estate_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ADD CONSTRAINT `fk_marketing_lead_attribution_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ADD CONSTRAINT `fk_marketing_lead_attribution_prior_lead_attribution_id` FOREIGN KEY (`prior_lead_attribution_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead_attribution`(`lead_attribution_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ADD CONSTRAINT `fk_marketing_digital_listing_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ADD CONSTRAINT `fk_marketing_digital_listing_superseded_digital_listing_id` FOREIGN KEY (`superseded_digital_listing_id`) REFERENCES `real_estate_ecm`.`marketing`.`digital_listing`(`digital_listing_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_superseded_by_market_research_id` FOREIGN KEY (`superseded_by_market_research_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_research`(`market_research_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_prior_market_research_id` FOREIGN KEY (`prior_market_research_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_research`(`market_research_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ADD CONSTRAINT `fk_marketing_competitor_property_market_research_id` FOREIGN KEY (`market_research_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_research`(`market_research_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ADD CONSTRAINT `fk_marketing_competitor_property_replaced_competitor_property_id` FOREIGN KEY (`replaced_competitor_property_id`) REFERENCES `real_estate_ecm`.`marketing`.`competitor_property`(`competitor_property_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ADD CONSTRAINT `fk_marketing_market_survey_market_research_id` FOREIGN KEY (`market_research_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_research`(`market_research_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ADD CONSTRAINT `fk_marketing_market_survey_prior_market_survey_id` FOREIGN KEY (`prior_market_survey_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_survey`(`market_survey_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `real_estate_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_revised_marketing_budget_id` FOREIGN KEY (`revised_marketing_budget_id`) REFERENCES `real_estate_ecm`.`marketing`.`marketing_budget`(`marketing_budget_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ADD CONSTRAINT `fk_marketing_ad_spend_campaign_flight_id` FOREIGN KEY (`campaign_flight_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign_flight`(`campaign_flight_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ADD CONSTRAINT `fk_marketing_ad_spend_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ADD CONSTRAINT `fk_marketing_ad_spend_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `real_estate_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ADD CONSTRAINT `fk_marketing_ad_spend_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `real_estate_ecm`.`marketing`.`vendor`(`vendor_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ADD CONSTRAINT `fk_marketing_ad_spend_reversed_ad_spend_id` FOREIGN KEY (`reversed_ad_spend_id`) REFERENCES `real_estate_ecm`.`marketing`.`ad_spend`(`ad_spend_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `real_estate_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_related_event_id` FOREIGN KEY (`related_event_id`) REFERENCES `real_estate_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ADD CONSTRAINT `fk_marketing_event_registration_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ADD CONSTRAINT `fk_marketing_event_registration_event_id` FOREIGN KEY (`event_id`) REFERENCES `real_estate_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ADD CONSTRAINT `fk_marketing_event_registration_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ADD CONSTRAINT `fk_marketing_event_registration_transferred_event_registration_id` FOREIGN KEY (`transferred_event_registration_id`) REFERENCES `real_estate_ecm`.`marketing`.`event_registration`(`event_registration_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ADD CONSTRAINT `fk_marketing_brand_parent_brand_id` FOREIGN KEY (`parent_brand_id`) REFERENCES `real_estate_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ADD CONSTRAINT `fk_marketing_channel_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `real_estate_ecm`.`marketing`.`vendor`(`vendor_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ADD CONSTRAINT `fk_marketing_channel_parent_channel_id` FOREIGN KEY (`parent_channel_id`) REFERENCES `real_estate_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ADD CONSTRAINT `fk_marketing_audience_segment_parent_audience_segment_id` FOREIGN KEY (`parent_audience_segment_id`) REFERENCES `real_estate_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `real_estate_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `real_estate_ecm`.`marketing`.`vendor`(`vendor_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_source_system_campaign_id` FOREIGN KEY (`source_system_campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_resent_email_campaign_id` FOREIGN KEY (`resent_email_campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`email_campaign`(`email_campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ADD CONSTRAINT `fk_marketing_seo_keyword_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ADD CONSTRAINT `fk_marketing_seo_keyword_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `real_estate_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ADD CONSTRAINT `fk_marketing_seo_keyword_parent_seo_keyword_id` FOREIGN KEY (`parent_seo_keyword_id`) REFERENCES `real_estate_ecm`.`marketing`.`seo_keyword`(`seo_keyword_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `real_estate_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `real_estate_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_campaign_flight_id` FOREIGN KEY (`campaign_flight_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign_flight`(`campaign_flight_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `real_estate_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_reposted_social_post_id` FOREIGN KEY (`reposted_social_post_id`) REFERENCES `real_estate_ecm`.`marketing`.`social_post`(`social_post_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ADD CONSTRAINT `fk_marketing_content_calendar_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `real_estate_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ADD CONSTRAINT `fk_marketing_content_calendar_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ADD CONSTRAINT `fk_marketing_content_calendar_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `real_estate_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ADD CONSTRAINT `fk_marketing_content_calendar_prior_content_calendar_id` FOREIGN KEY (`prior_content_calendar_id`) REFERENCES `real_estate_ecm`.`marketing`.`content_calendar`(`content_calendar_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ADD CONSTRAINT `fk_marketing_vendor_parent_vendor_id` FOREIGN KEY (`parent_vendor_id`) REFERENCES `real_estate_ecm`.`marketing`.`vendor`(`vendor_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ADD CONSTRAINT `fk_marketing_press_release_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `real_estate_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ADD CONSTRAINT `fk_marketing_press_release_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ADD CONSTRAINT `fk_marketing_press_release_event_id` FOREIGN KEY (`event_id`) REFERENCES `real_estate_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ADD CONSTRAINT `fk_marketing_press_release_superseded_press_release_id` FOREIGN KEY (`superseded_press_release_id`) REFERENCES `real_estate_ecm`.`marketing`.`press_release`(`press_release_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ADD CONSTRAINT `fk_marketing_campaign_property_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ADD CONSTRAINT `fk_marketing_campaign_property_replaced_campaign_property_id` FOREIGN KEY (`replaced_campaign_property_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign_property`(`campaign_property_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_unit_inclusion` ADD CONSTRAINT `fk_marketing_campaign_unit_inclusion_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_contribution` ADD CONSTRAINT `fk_marketing_campaign_contribution_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= TAGS =========
ALTER SCHEMA `real_estate_ecm`.`marketing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `real_estate_ecm`.`marketing` SET TAGS ('dbx_domain' = 'marketing');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `brand_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `green_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Green Certification Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `prior_campaign_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ALTER COLUMN `primary_channel` SET TAGS ('dbx_business_glossary_term' = 'Primary Marketing Channel');
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
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `vendor_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `prior_campaign_flight_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `derived_ad_creative_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `accessibility_compliant` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Compliance Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Creative Agency Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `alt_text` SET TAGS ('dbx_business_glossary_term' = 'Creative Alt Text');
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
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `building_class_id` SET TAGS ('dbx_business_glossary_term' = 'Building Class Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `digital_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Listing Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Property Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `superseded_listing_syndication_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `asking_price` SET TAGS ('dbx_business_glossary_term' = 'Asking Price');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `asking_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `asking_rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Asking Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `asking_rent_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `available_sqft` SET TAGS ('dbx_business_glossary_term' = 'Available Square Footage (SQF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `click_count` SET TAGS ('dbx_business_glossary_term' = 'Click Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `compliance_verified` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verified Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `listing_type` SET TAGS ('dbx_business_glossary_term' = 'Listing Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ALTER COLUMN `listing_type` SET TAGS ('dbx_value_regex' = 'sale|lease|sublease|auction');
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
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `investor_id` SET TAGS ('dbx_business_glossary_term' = 'Converted Investor Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `digital_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Listing Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Agent ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `master_lead_id` SET TAGS ('dbx_business_glossary_term' = 'Master Lead ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Property Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ALTER COLUMN `duplicate_lead_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `campaign_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `digital_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Listing Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Lead ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ALTER COLUMN `parent_lead_activity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` SET TAGS ('dbx_subdomain' = 'lead_management');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `lead_attribution_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Attribution ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Attributed Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `brokerage_prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `building_class_id` SET TAGS ('dbx_business_glossary_term' = 'Building Class Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Lead ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Property Sale Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `prior_lead_attribution_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `attributed_deal_value` SET TAGS ('dbx_business_glossary_term' = 'Attributed Deal Value');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `attributed_deal_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `attribution_calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Attribution Calculation Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `attribution_model` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `attribution_model` SET TAGS ('dbx_value_regex' = 'first_touch|last_touch|linear|time_decay|data_driven|position_based');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `attribution_model_version` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model Version');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `attribution_model_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `attribution_ref` SET TAGS ('dbx_business_glossary_term' = 'Attribution Reference Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `attribution_ref` SET TAGS ('dbx_value_regex' = '^ATT-[0-9]{8,12}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `attribution_status` SET TAGS ('dbx_business_glossary_term' = 'Attribution Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `attribution_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|disputed|voided|superseded');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `attribution_weight` SET TAGS ('dbx_business_glossary_term' = 'Attribution Weight');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `campaign_cost_attributed` SET TAGS ('dbx_business_glossary_term' = 'Attributed Campaign Cost');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `campaign_cost_attributed` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `conversion_event_type` SET TAGS ('dbx_business_glossary_term' = 'Conversion Event Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `conversion_event_type` SET TAGS ('dbx_value_regex' = 'lease_signed|purchase_agreement|showing_booked|loi_submitted|application_submitted|tour_completed');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `conversion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conversion Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `crm_campaign_ref` SET TAGS ('dbx_business_glossary_term' = 'CRM (Customer Relationship Management) Campaign Reference');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `days_to_conversion` SET TAGS ('dbx_business_glossary_term' = 'Days to Conversion');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `first_touch_date` SET TAGS ('dbx_business_glossary_term' = 'First Touch Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `is_cross_channel` SET TAGS ('dbx_business_glossary_term' = 'Cross-Channel Attribution Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `is_primary_attribution` SET TAGS ('dbx_business_glossary_term' = 'Primary Attribution Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `last_touch_date` SET TAGS ('dbx_business_glossary_term' = 'Last Touch Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Attribution Notes');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|yardi_voyager|mri_software|costar|argus|manual');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `touch_count` SET TAGS ('dbx_business_glossary_term' = 'Touch Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `weighted_attributed_value` SET TAGS ('dbx_business_glossary_term' = 'Weighted Attributed Deal Value');
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ALTER COLUMN `weighted_attributed_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `digital_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Listing ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Agent ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `building_class_id` SET TAGS ('dbx_business_glossary_term' = 'Building Class Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `green_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Green Certification Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Content Approved By Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Property Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `superseded_digital_listing_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `asking_price` SET TAGS ('dbx_business_glossary_term' = 'Asking Price');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `asking_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `asking_rent_max` SET TAGS ('dbx_business_glossary_term' = 'Asking Rent Maximum');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `asking_rent_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `asking_rent_min` SET TAGS ('dbx_business_glossary_term' = 'Asking Rent Minimum');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `asking_rent_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `asking_rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Asking Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `asking_rent_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `available_from_date` SET TAGS ('dbx_business_glossary_term' = 'Available From Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `available_sqft` SET TAGS ('dbx_business_glossary_term' = 'Available Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `available_sqm` SET TAGS ('dbx_business_glossary_term' = 'Available Square Meters (SQM)');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `bathroom_count` SET TAGS ('dbx_business_glossary_term' = 'Bathroom Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `bedroom_count` SET TAGS ('dbx_business_glossary_term' = 'Bedroom Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `content_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Content Approved Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `exclusive_listing` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Listing Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Listing Expiry Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `fair_housing_compliant` SET TAGS ('dbx_business_glossary_term' = 'Fair Housing Compliance Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `featured_listing` SET TAGS ('dbx_business_glossary_term' = 'Featured Listing Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `floor_count` SET TAGS ('dbx_business_glossary_term' = 'Floor Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `floor_plan_url` SET TAGS ('dbx_business_glossary_term' = 'Floor Plan URL');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `floor_plan_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `key_selling_points` SET TAGS ('dbx_business_glossary_term' = 'Key Selling Points');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `listing_code` SET TAGS ('dbx_business_glossary_term' = 'Digital Listing Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `listing_code` SET TAGS ('dbx_value_regex' = '^MKT-[A-Z0-9]{4,20}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `listing_headline` SET TAGS ('dbx_business_glossary_term' = 'Listing Headline');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `listing_status` SET TAGS ('dbx_business_glossary_term' = 'Digital Listing Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `listing_status` SET TAGS ('dbx_value_regex' = 'draft|active|under_offer|leased|sold|archived');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `listing_type` SET TAGS ('dbx_business_glossary_term' = 'Listing Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `listing_type` SET TAGS ('dbx_value_regex' = 'for_sale|for_lease|for_sale_or_lease|auction');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `marketing_description` SET TAGS ('dbx_business_glossary_term' = 'Marketing Description');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `parking_spaces` SET TAGS ('dbx_business_glossary_term' = 'Parking Spaces');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `photo_count` SET TAGS ('dbx_business_glossary_term' = 'Photo Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `photo_gallery_url` SET TAGS ('dbx_business_glossary_term' = 'Photo Gallery URL');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `photo_gallery_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `publish_date` SET TAGS ('dbx_business_glossary_term' = 'Publish Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `seo_keywords` SET TAGS ('dbx_business_glossary_term' = 'SEO Keywords');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `seo_meta_description` SET TAGS ('dbx_business_glossary_term' = 'SEO Meta Description');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `seo_slug` SET TAGS ('dbx_business_glossary_term' = 'SEO URL Slug');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `seo_slug` SET TAGS ('dbx_value_regex' = '^[a-z0-9-]+$');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `seo_title` SET TAGS ('dbx_business_glossary_term' = 'SEO Title');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce|yardi|mri|manual|api');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `video_url` SET TAGS ('dbx_business_glossary_term' = 'Video URL');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `video_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `virtual_tour_url` SET TAGS ('dbx_business_glossary_term' = 'Virtual Tour URL');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `virtual_tour_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ALTER COLUMN `year_built` SET TAGS ('dbx_business_glossary_term' = 'Year Built');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` SET TAGS ('dbx_subdomain' = 'market_intelligence');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `market_research_id` SET TAGS ('dbx_business_glossary_term' = 'Market Research ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Analyst Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `superseded_by_market_research_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Market Research ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `prior_market_research_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `avg_asking_rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Average Asking Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `cap_rate` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Rate (CAP Rate)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `commission_cost` SET TAGS ('dbx_business_glossary_term' = 'Research Commission Cost');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `commission_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `competitive_set_count` SET TAGS ('dbx_business_glossary_term' = 'Competitive Set Property Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` SET TAGS ('dbx_subdomain' = 'market_intelligence');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `competitor_property_id` SET TAGS ('dbx_business_glossary_term' = 'Competitor Property ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `building_class_id` SET TAGS ('dbx_business_glossary_term' = 'Building Class Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'LoopNet Listing ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `market_research_id` SET TAGS ('dbx_business_glossary_term' = 'Market Research Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `sustainability_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Rating Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `replaced_competitor_property_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Property Street Address Line 1');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Property Street Address Line 2');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `amenities_description` SET TAGS ('dbx_business_glossary_term' = 'Amenities Description');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `asking_price` SET TAGS ('dbx_business_glossary_term' = 'Asking Sale Price');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `asking_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `asking_rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Asking Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `asking_rent_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `avg_unit_size_sqft` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Size (Square Feet)');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `cap_rate` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Rate (CAP Rate)');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `cap_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Property City');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `competitive_tier` SET TAGS ('dbx_business_glossary_term' = 'Competitive Tier');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `competitive_tier` SET TAGS ('dbx_value_regex' = 'Primary|Secondary|Tertiary');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `concession_notes` SET TAGS ('dbx_business_glossary_term' = 'Concession Notes');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `concession_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `costar_property_code` SET TAGS ('dbx_business_glossary_term' = 'CoStar Property ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'CoStar|LoopNet|MLS|Field Survey|Broker Intel|Public Record');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `distance_to_subject_miles` SET TAGS ('dbx_business_glossary_term' = 'Distance to Subject Property (Miles)');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Property Latitude Coordinate');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Property Longitude Coordinate');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `marketing_channels` SET TAGS ('dbx_business_glossary_term' = 'Competitor Marketing Channels');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `number_of_floors` SET TAGS ('dbx_business_glossary_term' = 'Number of Floors');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `number_of_units` SET TAGS ('dbx_business_glossary_term' = 'Number of Units');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `occupancy_rate` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Rate');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `occupancy_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `owner_operator_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Owner or Operator Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `owner_operator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `parking_ratio` SET TAGS ('dbx_business_glossary_term' = 'Parking Ratio (Spaces per 1,000 SQF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Property Postal Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9A-Z- ]{3,10}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `property_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Property Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Property State or Province');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `total_rentable_area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Total Rentable Area (Square Feet)');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `tracking_status` SET TAGS ('dbx_business_glossary_term' = 'Competitor Property Tracking Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `tracking_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Archived|Under Review');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Competitor Property Website URL');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://.+$');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `year_built` SET TAGS ('dbx_business_glossary_term' = 'Year Built');
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ALTER COLUMN `year_renovated` SET TAGS ('dbx_business_glossary_term' = 'Year Last Renovated');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` SET TAGS ('dbx_subdomain' = 'market_intelligence');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `market_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Market Survey ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `building_class_id` SET TAGS ('dbx_business_glossary_term' = 'Building Class Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `market_research_id` SET TAGS ('dbx_business_glossary_term' = 'Market Research Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `prior_market_survey_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `marketing_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Budget ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `revised_marketing_budget_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend to Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `actual_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `approved_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Budget Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_value_regex' = '^MKT-[A-Z0-9]{4,20}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Marketing Budget Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `budget_scope` SET TAGS ('dbx_business_glossary_term' = 'Marketing Budget Scope');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `budget_scope` SET TAGS ('dbx_value_regex' = 'property|portfolio|campaign|channel|enterprise');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Marketing Budget Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Marketing Budget Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'original|revised|supplemental|contingency');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Spend Amount');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `fiscal_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Month');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `last_revised_date` SET TAGS ('dbx_business_glossary_term' = 'Last Revised Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `opex_capex_flag` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure / Capital Expenditure (OPEX/CAPEX) Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `opex_capex_flag` SET TAGS ('dbx_value_regex' = 'OPEX|CAPEX');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|campaign');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `property_class` SET TAGS ('dbx_business_glossary_term' = 'Property Class');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `property_class` SET TAGS ('dbx_value_regex' = 'commercial|residential|mixed_use|industrial|land');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `revised_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budget Amount');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `revised_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `source_budget_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Budget Reference');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Yardi Voyager|SAP S/4HANA|Salesforce CRM|Manual');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Submission Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `ad_spend_id` SET TAGS ('dbx_business_glossary_term' = 'Advertising (Ad) Spend ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `campaign_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center (CC) ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Budget ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `reversed_ad_spend_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `contract_ref` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Reference');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^d{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `is_accrual` SET TAGS ('dbx_business_glossary_term' = 'Accrual Indicator');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `is_capitalized` SET TAGS ('dbx_business_glossary_term' = 'Capitalized Expenditure Indicator');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `listing_type` SET TAGS ('dbx_business_glossary_term' = 'Listing Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `listing_type` SET TAGS ('dbx_value_regex' = 'sale|lease|both');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Advertising Spend Amount');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Spend Notes');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|paid|disputed|cancelled|voided');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `platform_name` SET TAGS ('dbx_business_glossary_term' = 'Advertising Platform Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `property_type` SET TAGS ('dbx_business_glossary_term' = 'Property Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `property_type` SET TAGS ('dbx_value_regex' = 'commercial|residential|mixed_use|industrial|land');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `reporting_amount` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Amount');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `reporting_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce|yardi|sap|manual|costar|other');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Advertising Spend Amount');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `spend_category` SET TAGS ('dbx_business_glossary_term' = 'Advertising Spend Category');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `spend_category` SET TAGS ('dbx_value_regex' = 'media_placement|creative_production|agency_fee|event_cost|print|digital_listing');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `spend_date` SET TAGS ('dbx_business_glossary_term' = 'Spend Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `spend_ref` SET TAGS ('dbx_business_glossary_term' = 'Advertising Spend Reference Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` SET TAGS ('dbx_subdomain' = 'lead_management');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `building_class_id` SET TAGS ('dbx_business_glossary_term' = 'Building Class Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `certificate_of_insurance_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Insurance Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Event Owner ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `related_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `actual_attendance` SET TAGS ('dbx_business_glossary_term' = 'Actual Attendance');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `budgeted_cost` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Event Cost');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `budgeted_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `venue_city` SET TAGS ('dbx_business_glossary_term' = 'Event Venue City');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `venue_country` SET TAGS ('dbx_business_glossary_term' = 'Event Venue Country');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `venue_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `venue_name` SET TAGS ('dbx_business_glossary_term' = 'Event Venue Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `venue_state` SET TAGS ('dbx_business_glossary_term' = 'Event Venue State');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `venue_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `virtual_event_url` SET TAGS ('dbx_business_glossary_term' = 'Virtual Event URL');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `virtual_event_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `virtual_platform` SET TAGS ('dbx_business_glossary_term' = 'Virtual Event Platform');
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ALTER COLUMN `virtual_platform` SET TAGS ('dbx_value_regex' = 'zoom|teams|webex|gotowebinar|youtube_live|other');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` SET TAGS ('dbx_subdomain' = 'lead_management');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `event_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Event Registration ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Owner Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `investor_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Lead ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
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
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `preferred_market` SET TAGS ('dbx_business_glossary_term' = 'Preferred Market or Submarket');
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ALTER COLUMN `property_interest` SET TAGS ('dbx_business_glossary_term' = 'Property Interest Type');
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
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` SET TAGS ('dbx_subdomain' = 'brand_strategy');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Manager Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Owner ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `parent_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Brand ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `accent_color_hex` SET TAGS ('dbx_business_glossary_term' = 'Accent Brand Color Hex Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `accent_color_hex` SET TAGS ('dbx_value_regex' = '^#[0-9A-Fa-f]{6}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `annual_brand_budget` SET TAGS ('dbx_business_glossary_term' = 'Annual Brand Budget');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `annual_brand_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `brand_description` SET TAGS ('dbx_business_glossary_term' = 'Brand Description');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `brand_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `brand_status` SET TAGS ('dbx_value_regex' = 'active|retired|in_development|suspended|archived');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `brand_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Tier');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `brand_tier` SET TAGS ('dbx_value_regex' = 'corporate|portfolio|property|co-brand|sub-brand');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `brand_type` SET TAGS ('dbx_business_glossary_term' = 'Brand Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `brand_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|mixed-use|industrial|hospitality|corporate');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `co_brand_agreement_ref` SET TAGS ('dbx_business_glossary_term' = 'Co-Brand Agreement Reference');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `co_brand_agreement_ref` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `co_brand_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Co-Brand Partner Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `digital_presence_url` SET TAGS ('dbx_business_glossary_term' = 'Brand Digital Presence URL');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `digital_presence_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `esg_aligned` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Aligned Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `geographic_markets` SET TAGS ('dbx_business_glossary_term' = 'Brand Geographic Markets');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `guidelines_url` SET TAGS ('dbx_business_glossary_term' = 'Brand Guidelines URL');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `guidelines_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `last_refresh_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Last Refresh Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Launch Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `leed_certified` SET TAGS ('dbx_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Certified Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `logo_asset_url` SET TAGS ('dbx_business_glossary_term' = 'Logo Asset URL');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `logo_asset_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `logo_dark_asset_url` SET TAGS ('dbx_business_glossary_term' = 'Logo Dark Variant Asset URL');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `logo_dark_asset_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Brand Notes');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `positioning` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `positioning` SET TAGS ('dbx_value_regex' = 'luxury|premium|mid-market|affordable|value');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `primary_color_hex` SET TAGS ('dbx_business_glossary_term' = 'Primary Brand Color Hex Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `primary_color_hex` SET TAGS ('dbx_value_regex' = '^#[0-9A-Fa-f]{6}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `primary_font_family` SET TAGS ('dbx_business_glossary_term' = 'Primary Brand Font Family');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Retirement Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `secondary_color_hex` SET TAGS ('dbx_business_glossary_term' = 'Secondary Brand Color Hex Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `secondary_color_hex` SET TAGS ('dbx_value_regex' = '^#[0-9A-Fa-f]{6}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `secondary_font_family` SET TAGS ('dbx_business_glossary_term' = 'Secondary Brand Font Family');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `social_media_handle` SET TAGS ('dbx_business_glossary_term' = 'Brand Social Media Handle');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce|yardi|mri|sap|manual|other');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `source_system_brand_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Brand ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `tagline` SET TAGS ('dbx_business_glossary_term' = 'Brand Tagline');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `target_audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Brand Target Audience Segment');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `target_property_types` SET TAGS ('dbx_business_glossary_term' = 'Target Property Types');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `trademark_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Trademark Jurisdiction');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `trademark_registered` SET TAGS ('dbx_business_glossary_term' = 'Trademark Registered Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `trademark_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Trademark Registration Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `trademark_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` SET TAGS ('dbx_subdomain' = 'brand_strategy');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Vendor Account ID');
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
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` SET TAGS ('dbx_subdomain' = 'brand_strategy');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `industry_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Classification Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `primary_audience_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Owner ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `primary_audience_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `primary_audience_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `parent_audience_segment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `accredited_investor_flag` SET TAGS ('dbx_business_glossary_term' = 'Accredited Investor Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `activation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Activation End Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `activation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Activation Start Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `age_band_max` SET TAGS ('dbx_business_glossary_term' = 'Age Band Maximum');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `age_band_min` SET TAGS ('dbx_business_glossary_term' = 'Age Band Minimum');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_status` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|under_review');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `b2b_segment_flag` SET TAGS ('dbx_business_glossary_term' = 'Business-to-Business (B2B) Segment Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `channel_affinity` SET TAGS ('dbx_business_glossary_term' = 'Channel Affinity');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `channel_affinity` SET TAGS ('dbx_value_regex' = 'digital|email|social_media|direct_mail|events|broker_referral');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Segment Data Source');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'salesforce_crm|costar|mls|third_party|internal_crm|market_research');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `esg_preference_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Preference Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `fair_housing_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Housing Compliant Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `gdpr_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Applicable Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `geographic_preference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Preference');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `income_band_max` SET TAGS ('dbx_business_glossary_term' = 'Income Band Maximum');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `income_band_min` SET TAGS ('dbx_business_glossary_term' = 'Income Band Minimum');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `investment_profile` SET TAGS ('dbx_business_glossary_term' = 'Investment Profile');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `investment_profile` SET TAGS ('dbx_value_regex' = 'core|core_plus|value_add|opportunistic|speculative');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `life_stage` SET TAGS ('dbx_business_glossary_term' = 'Life Stage');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `max_sqft_requirement` SET TAGS ('dbx_business_glossary_term' = 'Maximum Square Footage (SQF) Requirement');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `min_sqft_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Square Footage (SQF) Requirement');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `net_worth_band_max` SET TAGS ('dbx_business_glossary_term' = 'Net Worth Band Maximum');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `net_worth_band_min` SET TAGS ('dbx_business_glossary_term' = 'Net Worth Band Minimum');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `persona_type` SET TAGS ('dbx_business_glossary_term' = 'Persona Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_business_glossary_term' = 'Segment Refresh Frequency');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|on_demand');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Description');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `segment_size_estimate` SET TAGS ('dbx_business_glossary_term' = 'Segment Size Estimate');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'demographic|behavioral|psychographic|firmographic|geographic');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `size_estimate_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Size Estimate Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|costar|mri_software|yardi_voyager|internal');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `source_system_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Segment ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `target_company_size` SET TAGS ('dbx_business_glossary_term' = 'Target Company Size');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `target_company_size` SET TAGS ('dbx_value_regex' = 'small|mid_market|large|enterprise|institutional');
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `email_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Email Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `email_campaign_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `email_campaign_id` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Esp Marketing Vendor Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `source_system_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Source System Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `resent_email_campaign_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_value_regex' = 'A|B|C|control');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `actual_send_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Send Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `campaign_spend` SET TAGS ('dbx_business_glossary_term' = 'Email Campaign Spend');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `campaign_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `can_spam_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'CAN-SPAM Compliant Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `click_count` SET TAGS ('dbx_business_glossary_term' = 'Click Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `delivered_count` SET TAGS ('dbx_business_glossary_term' = 'Delivered Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `esp_campaign_ref` SET TAGS ('dbx_business_glossary_term' = 'Email Service Provider (ESP) Campaign Reference');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `fair_housing_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Housing Compliant Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `gdpr_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `hard_bounce_count` SET TAGS ('dbx_business_glossary_term' = 'Hard Bounce Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `landing_page_url` SET TAGS ('dbx_business_glossary_term' = 'Landing Page URL');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `landing_page_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `lead_count` SET TAGS ('dbx_business_glossary_term' = 'Lead Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `open_count` SET TAGS ('dbx_business_glossary_term' = 'Open Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `personalization_flag` SET TAGS ('dbx_business_glossary_term' = 'Personalization Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `preview_text` SET TAGS ('dbx_business_glossary_term' = 'Email Preview Text');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `reply_to_email` SET TAGS ('dbx_business_glossary_term' = 'Reply-To Email Address');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `reply_to_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `reply_to_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `reply_to_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `scheduled_send_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Send Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `send_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Send Completed Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `sender_email` SET TAGS ('dbx_business_glossary_term' = 'Sender Email Address');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `sender_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `sender_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `sender_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `sender_name` SET TAGS ('dbx_business_glossary_term' = 'Sender Display Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `soft_bounce_count` SET TAGS ('dbx_business_glossary_term' = 'Soft Bounce Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_marketing_cloud|hubspot|mailchimp|manual');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `spam_complaint_count` SET TAGS ('dbx_business_glossary_term' = 'Spam Complaint Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `subject_line` SET TAGS ('dbx_business_glossary_term' = 'Email Subject Line');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Email Template ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `total_recipients` SET TAGS ('dbx_business_glossary_term' = 'Total Recipients Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `unsubscribe_count` SET TAGS ('dbx_business_glossary_term' = 'Unsubscribe Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'UTM Campaign');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'UTM Medium');
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'UTM Source');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` SET TAGS ('dbx_subdomain' = 'market_intelligence');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `seo_keyword_id` SET TAGS ('dbx_business_glossary_term' = 'Search Engine Optimization (SEO) Keyword ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `parent_seo_keyword_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `ad_group_name` SET TAGS ('dbx_business_glossary_term' = 'Ad Group Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `bid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Search Bid Amount');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `click_through_rate` SET TAGS ('dbx_business_glossary_term' = 'Click-Through Rate (CTR)');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `competition_level` SET TAGS ('dbx_business_glossary_term' = 'Competition Level');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `competition_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `competition_score` SET TAGS ('dbx_business_glossary_term' = 'Competition Score');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Keyword Conversion Rate');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `cost_per_click` SET TAGS ('dbx_business_glossary_term' = 'Average Cost Per Click (CPC)');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `current_ranking_position` SET TAGS ('dbx_business_glossary_term' = 'Current Organic Ranking Position');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `device_target` SET TAGS ('dbx_business_glossary_term' = 'Device Target');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `device_target` SET TAGS ('dbx_value_regex' = 'all|desktop|mobile|tablet');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `fair_housing_compliant` SET TAGS ('dbx_business_glossary_term' = 'Fair Housing Compliance Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `impression_share` SET TAGS ('dbx_business_glossary_term' = 'Impression Share');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `keyword_code` SET TAGS ('dbx_business_glossary_term' = 'Keyword Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `keyword_code` SET TAGS ('dbx_value_regex' = '^KW-[A-Z0-9]{6,12}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `keyword_difficulty_score` SET TAGS ('dbx_business_glossary_term' = 'Keyword Difficulty Score');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `keyword_phrase` SET TAGS ('dbx_business_glossary_term' = 'Keyword Phrase');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `keyword_status` SET TAGS ('dbx_business_glossary_term' = 'Keyword Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `keyword_status` SET TAGS ('dbx_value_regex' = 'active|paused|archived|under_review|pending');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `keyword_type` SET TAGS ('dbx_business_glossary_term' = 'Keyword Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `keyword_type` SET TAGS ('dbx_value_regex' = 'branded|non_branded|long_tail|local|competitor|generic');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `landing_page_url` SET TAGS ('dbx_business_glossary_term' = 'Associated Landing Page URL');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `landing_page_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `last_ranking_check_date` SET TAGS ('dbx_business_glossary_term' = 'Last Ranking Check Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `match_type` SET TAGS ('dbx_business_glossary_term' = 'Keyword Match Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `match_type` SET TAGS ('dbx_value_regex' = 'broad|phrase|exact|broad_modified');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `monthly_search_volume` SET TAGS ('dbx_business_glossary_term' = 'Monthly Search Volume');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `negative_keyword_flag` SET TAGS ('dbx_business_glossary_term' = 'Negative Keyword Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Keyword Notes');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `peak_season` SET TAGS ('dbx_business_glossary_term' = 'Peak Search Season');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Keyword Priority Tier');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `priority_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Paid Search Quality Score');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `ranking_url` SET TAGS ('dbx_business_glossary_term' = 'Ranking Page URL');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `ranking_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `search_intent` SET TAGS ('dbx_business_glossary_term' = 'Search Intent Classification');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `search_intent` SET TAGS ('dbx_value_regex' = 'informational|navigational|transactional|commercial_investigation');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `seasonality_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonality Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `source_keyword_code` SET TAGS ('dbx_business_glossary_term' = 'Source Platform Keyword ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `source_platform` SET TAGS ('dbx_business_glossary_term' = 'Source Platform');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `target_ranking_position` SET TAGS ('dbx_business_glossary_term' = 'Target Organic Ranking Position');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ALTER COLUMN `utm_term` SET TAGS ('dbx_business_glossary_term' = 'UTM Term Parameter');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `social_post_id` SET TAGS ('dbx_business_glossary_term' = 'Social Post ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `brand_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `campaign_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `reposted_social_post_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Post Comments');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `content_category` SET TAGS ('dbx_business_glossary_term' = 'Content Category');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `esg_aligned` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Aligned Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `fair_housing_compliant` SET TAGS ('dbx_business_glossary_term' = 'Fair Housing Compliant Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `gdpr_compliant` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `hashtags` SET TAGS ('dbx_business_glossary_term' = 'Post Hashtags');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `headline` SET TAGS ('dbx_business_glossary_term' = 'Post Headline');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `impressions` SET TAGS ('dbx_business_glossary_term' = 'Post Impressions');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `likes` SET TAGS ('dbx_business_glossary_term' = 'Post Likes');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `link_clicks` SET TAGS ('dbx_business_glossary_term' = 'Post Link Clicks');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `link_url` SET TAGS ('dbx_business_glossary_term' = 'Post Link URL');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `media_asset_ref` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Reference');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `media_type` SET TAGS ('dbx_business_glossary_term' = 'Media Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `metrics_last_refreshed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Metrics Last Refreshed Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `platform_page_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Page ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `platform_post_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Post ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `post_code` SET TAGS ('dbx_business_glossary_term' = 'Social Post Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `post_code` SET TAGS ('dbx_value_regex' = '^SP-[A-Z0-9]{6,12}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `post_status` SET TAGS ('dbx_business_glossary_term' = 'Post Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `post_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|published|paused|removed|failed');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `post_text` SET TAGS ('dbx_business_glossary_term' = 'Post Text Content');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `post_type` SET TAGS ('dbx_business_glossary_term' = 'Post Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `post_type` SET TAGS ('dbx_value_regex' = 'organic|paid|boosted|sponsored|dark_post');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `publish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Publish Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `reach` SET TAGS ('dbx_business_glossary_term' = 'Post Reach');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `scheduled_publish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Publish Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `shares` SET TAGS ('dbx_business_glossary_term' = 'Post Shares');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Post Spend Amount');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'UTM Campaign');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'UTM Source');
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ALTER COLUMN `video_views` SET TAGS ('dbx_business_glossary_term' = 'Video Views');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `content_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Content Calendar ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Calendar Owner ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `prior_content_calendar_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|archived');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `calendar_code` SET TAGS ('dbx_business_glossary_term' = 'Content Calendar Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `calendar_code` SET TAGS ('dbx_value_regex' = '^CC-[A-Z0-9]{4,12}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `calendar_name` SET TAGS ('dbx_business_glossary_term' = 'Content Calendar Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `channel_mix` SET TAGS ('dbx_business_glossary_term' = 'Channel Mix');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `content_spend_to_date` SET TAGS ('dbx_business_glossary_term' = 'Content Spend to Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `content_spend_to_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `creative_theme` SET TAGS ('dbx_business_glossary_term' = 'Creative Theme');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `digital_platform` SET TAGS ('dbx_business_glossary_term' = 'Digital Platform');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `esg_aligned` SET TAGS ('dbx_business_glossary_term' = 'ESG (Environmental Social and Governance) Aligned Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `fair_housing_compliant` SET TAGS ('dbx_business_glossary_term' = 'Fair Housing Compliant Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `gdpr_compliant` SET TAGS ('dbx_business_glossary_term' = 'GDPR (General Data Protection Regulation) Compliant Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `key_property_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Key Property Launch Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `lease_up_milestone_date` SET TAGS ('dbx_business_glossary_term' = 'Lease-Up Milestone Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `market_event_date` SET TAGS ('dbx_business_glossary_term' = 'Market Event Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `mls_syndication_included` SET TAGS ('dbx_business_glossary_term' = 'MLS (Multiple Listing Service) Syndication Included Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Calendar Notes');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `planned_campaign_launch_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Campaign Launch Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `planned_content_item_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Content Item Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `planned_listing_launch_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Listing Launch Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `planning_period_type` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `planning_period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|custom');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `portfolio_scope` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Scope');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce|yardi|mri|manual|other');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `source_system_calendar_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Calendar ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `total_content_budget` SET TAGS ('dbx_business_glossary_term' = 'Total Content Budget');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `total_content_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` SET TAGS ('dbx_subdomain' = 'brand_strategy');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Vendor ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `parent_vendor_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract End Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Reference Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `contract_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Start Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `digital_platform_specialization` SET TAGS ('dbx_business_glossary_term' = 'Vendor Digital Platform Specialization');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Engagement End Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Engagement Start Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `esg_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Certified Vendor Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `fee_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Fee Structure Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `fee_structure_type` SET TAGS ('dbx_value_regex' = 'retainer|project_based|commission|hourly|media_markup|hybrid');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `gdpr_dpa_executed_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Data Processing Agreement (DPA) Executed Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Vendor Geographic Coverage');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `insurance_certificate_ref` SET TAGS ('dbx_business_glossary_term' = 'Vendor Insurance Certificate Reference');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Insurance Expiry Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Vendor Performance Review Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `nda_executed_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) Executed Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Vendor Notes');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Onboarding Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Vendor Payment Terms');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_15|net_30|net_45|net_60|due_on_receipt|milestone_based');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance Rating');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `portfolio_scope` SET TAGS ('dbx_business_glossary_term' = 'Vendor Portfolio Scope');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `portfolio_scope` SET TAGS ('dbx_value_regex' = 'commercial|residential|mixed|industrial|retail|all');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Vendor Primary Contact Email Address');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Primary Contact Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Vendor Primary Contact Phone Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `rate_card_reference` SET TAGS ('dbx_business_glossary_term' = 'Vendor Rate Card Reference');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `rate_card_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `retainer_amount` SET TAGS ('dbx_business_glossary_term' = 'Vendor Monthly Retainer Amount');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `retainer_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `services_provided` SET TAGS ('dbx_business_glossary_term' = 'Marketing Services Provided');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Record');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|sap_s4hana|yardi_voyager|manual|docusign_clm');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `source_system_vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Vendor Identifier');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Tax Identification Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Vendor Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `vendor_code` SET TAGS ('dbx_value_regex' = '^MKT-VND-[A-Z0-9]{4,12}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Marketing Vendor Legal Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Marketing Vendor Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|suspended|blacklisted|under_review');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `vendor_tier` SET TAGS ('dbx_business_glossary_term' = 'Vendor Tier Classification');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `vendor_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Marketing Vendor Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `w9_on_file_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor W-9 On File Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `website` SET TAGS ('dbx_business_glossary_term' = 'Vendor Website URL');
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ALTER COLUMN `website` SET TAGS ('dbx_value_regex' = '^https?://[^s/$.?#].[^s]*$');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` SET TAGS ('dbx_subdomain' = 'brand_strategy');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `press_release_id` SET TAGS ('dbx_business_glossary_term' = 'Press Release ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Press Release Author ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `investment_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Deal Pipeline Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Property Sale Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `superseded_press_release_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Press Release Approval Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|published|retracted|archived');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Press Release Approval Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Press Release Approved By');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Press Release Author Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `author_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `body_text` SET TAGS ('dbx_business_glossary_term' = 'Press Release Body Text');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `boilerplate_text` SET TAGS ('dbx_business_glossary_term' = 'Press Release Boilerplate Text');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Media Contact Email Address');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Media Contact Name');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Media Contact Phone Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `embargo_date` SET TAGS ('dbx_business_glossary_term' = 'Press Release Embargo Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `embargo_time` SET TAGS ('dbx_business_glossary_term' = 'Press Release Embargo Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `esg_aligned` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Aligned Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_business_glossary_term' = 'Estimated Media Reach');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `headline` SET TAGS ('dbx_business_glossary_term' = 'Press Release Headline');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `ir_relevant` SET TAGS ('dbx_business_glossary_term' = 'Investor Relations (IR) Relevant Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `legal_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completed Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `media_pickup_count` SET TAGS ('dbx_business_glossary_term' = 'Media Pickup Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Press Release Notes');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Press Release Published Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `published_url` SET TAGS ('dbx_business_glossary_term' = 'Published Press Release URL');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Press Release Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `release_number` SET TAGS ('dbx_business_glossary_term' = 'Press Release Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `release_number` SET TAGS ('dbx_value_regex' = '^PR-[0-9]{4}-[0-9]{5}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `release_type` SET TAGS ('dbx_business_glossary_term' = 'Press Release Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `retraction_reason` SET TAGS ('dbx_business_glossary_term' = 'Press Release Retraction Reason');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Salesforce CRM|DocuSign CLM|manual|other');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `subheadline` SET TAGS ('dbx_business_glossary_term' = 'Press Release Subheadline');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `target_media_outlets` SET TAGS ('dbx_business_glossary_term' = 'Target Media Outlets');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Press Release Version Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `wire_service` SET TAGS ('dbx_business_glossary_term' = 'Wire Service Distribution Channel');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `wire_service` SET TAGS ('dbx_value_regex' = 'PR Newswire|BusinessWire|GlobeNewswire|Accesswire|none');
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ALTER COLUMN `wire_service_ref` SET TAGS ('dbx_business_glossary_term' = 'Wire Service Reference Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `campaign_property_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Property ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `building_class_id` SET TAGS ('dbx_business_glossary_term' = 'Building Class Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `sustainability_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Rating Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `replaced_campaign_property_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Property-Level Actual Spend Amount');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `asking_price` SET TAGS ('dbx_business_glossary_term' = 'Asking Price');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `asking_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `asking_rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Asking Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `asking_rent_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `available_sqft` SET TAGS ('dbx_business_glossary_term' = 'Available Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `days_on_market` SET TAGS ('dbx_business_glossary_term' = 'Days on Market (DOM)');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `esg_aligned` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Aligned Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `fair_housing_compliant` SET TAGS ('dbx_business_glossary_term' = 'Fair Housing Compliant Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `inclusion_end_date` SET TAGS ('dbx_business_glossary_term' = 'Property Inclusion End Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `inclusion_start_date` SET TAGS ('dbx_business_glossary_term' = 'Property Inclusion Start Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `inclusion_status` SET TAGS ('dbx_business_glossary_term' = 'Property Inclusion Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `inclusion_status` SET TAGS ('dbx_value_regex' = 'active|paused|pending|removed|completed');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `is_featured` SET TAGS ('dbx_business_glossary_term' = 'Is Featured Property Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `listing_url` SET TAGS ('dbx_business_glossary_term' = 'Campaign Listing URL');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `listing_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `mls_number` SET TAGS ('dbx_business_glossary_term' = 'Multiple Listing Service (MLS) Number');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Campaign Property Notes');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Property Priority Rank');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `property_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Property-Level Campaign Budget Amount');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `property_lead_count` SET TAGS ('dbx_business_glossary_term' = 'Property-Level Lead Count');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `property_role` SET TAGS ('dbx_business_glossary_term' = 'Property Role in Campaign');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `property_role` SET TAGS ('dbx_value_regex' = 'featured|portfolio_showcase|comparable_reference|anchor|supporting');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `removal_reason` SET TAGS ('dbx_business_glossary_term' = 'Property Removal Reason');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Salesforce|Yardi|MRI|CoStar|Manual|Other');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'UTM Campaign Parameter');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'UTM Medium Parameter');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'UTM Source Parameter');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_unit_inclusion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_unit_inclusion` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_unit_inclusion` SET TAGS ('dbx_association_edges' = 'property.unit,marketing.campaign');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_unit_inclusion` ALTER COLUMN `campaign_unit_inclusion_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Unit Inclusion ID');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_unit_inclusion` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Unit Inclusion - Campaign Id');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_unit_inclusion` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Unit Inclusion - Unit Id');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_unit_inclusion` ALTER COLUMN `asking_rent_at_inclusion` SET TAGS ('dbx_business_glossary_term' = 'Asking Rent at Inclusion');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_unit_inclusion` ALTER COLUMN `campaign_unit_budget` SET TAGS ('dbx_business_glossary_term' = 'Campaign Unit Budget');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_unit_inclusion` ALTER COLUMN `inclusion_end_date` SET TAGS ('dbx_business_glossary_term' = 'Inclusion End Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_unit_inclusion` ALTER COLUMN `inclusion_start_date` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Start Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_unit_inclusion` ALTER COLUMN `is_featured` SET TAGS ('dbx_business_glossary_term' = 'Is Featured Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_unit_inclusion` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_contribution` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_contribution` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_contribution` SET TAGS ('dbx_association_edges' = 'workforce.employee,marketing.campaign');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_contribution` ALTER COLUMN `campaign_contribution_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Contribution Identifier');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_contribution` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Contribution - Campaign Id');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_contribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_contribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_contribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_contribution` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Contribution Hours');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_contribution` ALTER COLUMN `allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Time Allocation Percentage');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_contribution` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_contribution` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Contribution Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_contribution` ALTER COLUMN `contribution_type` SET TAGS ('dbx_business_glossary_term' = 'Contribution Type');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_contribution` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_contribution` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Contribution End Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_contribution` ALTER COLUMN `estimated_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Contribution Hours');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_contribution` ALTER COLUMN `is_primary_owner` SET TAGS ('dbx_business_glossary_term' = 'Primary Owner Flag');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_contribution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contribution Notes');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_contribution` ALTER COLUMN `role_on_campaign` SET TAGS ('dbx_business_glossary_term' = 'Campaign Role');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_contribution` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Contribution Start Date');
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_contribution` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
