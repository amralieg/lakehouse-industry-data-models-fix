-- Schema for Domain: client | Business: Advertising | Version: v1_ecm
-- Generated on: 2026-05-08 02:28:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `advertising_ecm`.`client` COMMENT 'Authoritative SSOT for all advertiser identity, account hierarchy, and relationship data. Manages client profiles, brand portfolios, account teams, contact information, business segments, relationship history, and CRM records for both direct advertisers and agency-managed accounts. Supports Account Management and Client Services.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`advertiser` (
    `advertiser_id` BIGINT COMMENT 'Unique surrogate identifier for the advertiser record in the Silver Layer lakehouse. Primary key for the advertiser master data product. Role: MASTER_PARTY.',
    `client_segment_id` BIGINT COMMENT 'Foreign key linking to client.client_segment. Business justification: Advertisers are classified into strategic business segments. The advertiser table currently has business_segment as a STRING field, which should be normalized to a FK reference to the client_segment',
    `account_status` STRING COMMENT 'Current lifecycle status of the advertiser account. Drives workflow routing, reporting segmentation, and CRM pipeline management. prospect = pre-contract; active = live campaigns; dormant = no recent activity; churned = relationship ended; suspended = temporarily on hold.. Valid values are `prospect|active|dormant|churned|suspended`',
    `account_tier` STRING COMMENT 'Commercial tier classification of the advertiser based on revenue contribution, strategic importance, and engagement level. Determines service level, dedicated account team assignment, and reporting cadence. Aligns with agency tiering models used in account management.. Valid values are `platinum|gold|silver|bronze`',
    `address_validation_status` STRING COMMENT 'Indicates the validation status of the advertisers billing address against a postal address verification service. validated = confirmed deliverable; unvalidated = not yet checked; failed = address could not be verified; pending = verification in progress. Used in SAP S/4HANA and Mediaocean Prisma billing workflows.. Valid values are `validated|unvalidated|failed|pending`',
    `approval_workflow_type` STRING COMMENT 'Defines the creative and campaign approval workflow configuration for this advertiser. single_approver = one designated approver; multi_approver = sequential or parallel approval chain; auto_approve = pre-authorized for specific asset types. Configured in Workfront proofing module.. Valid values are `single_approver|multi_approver|auto_approve`',
    `ccpa_consent_flag` BOOLEAN COMMENT 'Indicates whether the advertiser has opted in to data sharing under CCPA regulations. True = data sharing permitted; False = opt-out or not applicable. Applicable for California-based advertisers and campaigns targeting California consumers. Drives NAI and TAG compliance controls.',
    `churn_date` DATE COMMENT 'The date on which the advertisers account was marked as churned (relationship ended). Populated only when account_status = churned. Used for churn analysis, win-back campaign targeting, and P&L impact reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the advertiser master record was first created in the Silver Layer lakehouse. Represents the audit trail creation event. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for data lineage, audit compliance, and record lifecycle tracking.',
    `credit_terms` STRING COMMENT 'The agreed payment credit terms for this advertiser, defining the number of days after invoice date by which payment is due. Configured in SAP S/4HANA AR and Mediaocean Prisma for billing workflows. Drives cash flow forecasting and P&L management.. Valid values are `net_15|net_30|net_45|net_60|prepaid`',
    `crm_account_code` STRING COMMENT 'The unique account identifier assigned to this advertiser in Salesforce CRM (Sales Cloud). Serves as the cross-system join key between the lakehouse Silver Layer and the CRM system of record for account management and client services.',
    `ein` STRING COMMENT 'The US federal Employer Identification Number (EIN) assigned by the IRS to the advertiser. Used for US tax reporting, W-9 compliance, and financial reconciliation in SAP S/4HANA. Applicable for US-incorporated entities.. Valid values are `^d{2}-d{7}$`',
    `erp_customer_number` STRING COMMENT 'The customer master number assigned to this advertiser in SAP S/4HANA (FI/AR module). Used for billing, accounts receivable, and financial reconciliation processes. Links advertiser identity to financial transactions.',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Indicates whether the advertiser has provided explicit consent for data sharing and processing under GDPR. True = consent granted; False = consent not granted or withdrawn. Mandatory for EU-based advertisers and any data processing involving EU data subjects. Drives data governance controls.',
    `holding_company_name` STRING COMMENT 'The name of the parent holding company or corporate group to which this advertiser belongs (e.g., WPP, Publicis, Omnicom client-side equivalent). Used for consolidated billing, conflict-of-interest checks, and group-level revenue reporting.',
    `iab_industry_vertical` STRING COMMENT 'The advertisers primary industry vertical classified using the IAB Content Taxonomy. Used for audience targeting, competitive analysis, Share of Voice (SOV) reporting, and media planning segmentation. Examples: Automotive, Financial Services, Consumer Packaged Goods. [ENUM-REF-CANDIDATE: promote to reference product aligned to IAB Content Taxonomy v3.0]',
    `incorporation_jurisdiction` STRING COMMENT 'ISO 3166-1 alpha-2 or alpha-3 country code of the jurisdiction in which the advertisers legal entity is incorporated. Used for regulatory compliance, tax treatment, and contract law determination. Examples: US, GB, DEU.. Valid values are `^[A-Z]{2,3}$`',
    `invoice_delivery_method` STRING COMMENT 'The preferred method by which invoices are delivered to the advertiser. Drives automated invoice dispatch workflows in SAP S/4HANA and Mediaocean Prisma. edi = Electronic Data Interchange for enterprise clients with automated AP systems.. Valid values are `email|portal|mail|edi`',
    `is_agency_managed` BOOLEAN COMMENT 'Indicates whether this advertiser is managed through an intermediary agency relationship (True) or is a direct client of the agency (False). Determines billing structure, IO (Insertion Order) routing, and account team assignment in Mediaocean Prisma and Salesforce CRM.',
    `language_preference` STRING COMMENT 'The advertisers preferred language for communications, reports, and invoices, expressed as an IETF BCP 47 language tag (e.g., en-US, fr-FR, de-DE). Drives localization in Salesforce Marketing Cloud and report generation workflows.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `legal_entity_name` STRING COMMENT 'The full registered legal name of the advertiser as recorded with the relevant incorporation authority. Used for contracts, invoices, and regulatory filings. Maps to Salesforce CRM Account Name (legal) and SAP S/4HANA customer master legal name.',
    `managing_agency_name` STRING COMMENT 'Name of the intermediary agency managing this advertisers account, if is_agency_managed is True. Used for IO routing, commission calculations, and agency-of-record (AOR) tracking in Mediaocean Prisma and Salesforce CRM.',
    `onboarding_date` DATE COMMENT 'The date on which the advertiser was formally onboarded as a client of the agency. Marks the start of the commercial relationship. Used for tenure calculations, anniversary-based QBR scheduling, and cohort analysis in analytics workflows.',
    `payment_terms` STRING COMMENT 'The agreed payment method/instrument for this advertisers invoices. Distinct from credit_terms (which defines timing); this defines the payment channel/instrument. Configured in SAP S/4HANA and Mediaocean Prisma for financial reconciliation.. Valid values are `bank_transfer|check|ach|wire|credit_card`',
    `preferred_comm_channel` STRING COMMENT 'The advertisers preferred channel for day-to-day account communications and notifications. Used to route alerts, campaign updates, and approval requests in Salesforce CRM and Workfront project management workflows.. Valid values are `email|phone|portal|slack|teams`',
    `preferred_currency` STRING COMMENT 'The ISO 4217 three-letter currency code representing the advertisers preferred billing and reporting currency (e.g., USD, EUR, GBP). Used in Mediaocean Prisma for media billing and SAP S/4HANA for invoicing and financial reconciliation.. Valid values are `^[A-Z]{3}$`',
    `primary_contact_email` STRING COMMENT 'The primary email address of the advertisers main point of contact at the client organization. Used for campaign communications, reporting delivery, and account management correspondence. Sourced from Salesforce CRM Contact object.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the advertisers primary point of contact at the client organization. Used in account management, QBR preparation, and client services workflows. Sourced from Salesforce CRM Contact object.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the advertisers main point of contact. Used for urgent campaign communications and account management. Stored in E.164 international format. Sourced from Salesforce CRM Contact object.',
    `registered_office_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country where the advertisers registered office is located. May differ from billing address country. Used for regulatory compliance, GDPR/CCPA applicability determination, and legal jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `reporting_cadence` STRING COMMENT 'The agreed frequency at which performance reports and analytics dashboards are delivered to the advertiser. Drives automated report scheduling in Google Campaign Manager 360 and analytics workflows. Aligns with QBR (Quarterly Business Review) planning.. Valid values are `daily|weekly|bi-weekly|monthly|quarterly`',
    `time_zone` STRING COMMENT 'The advertisers primary operational time zone expressed as an IANA Time Zone Database identifier (e.g., America/New_York, Europe/London). Used for scheduling campaign flights, reporting cadence, and meeting coordination in Workfront and Salesforce CRM.',
    `trading_name` STRING COMMENT 'The brand or doing business as (DBA) name under which the advertiser operates commercially. May differ from the legal entity name. Used in campaign documentation, media plans, and client-facing materials.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the advertiser master record was most recently modified in the Silver Layer lakehouse. Used for incremental ETL processing, change data capture (CDC), and audit trail compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `vat_number` STRING COMMENT 'The advertisers Value Added Tax (VAT) registration number issued by the relevant tax authority. Required for EU/UK invoicing compliance and cross-border tax treatment. Stored for financial reconciliation in SAP S/4HANA FI module.',
    CONSTRAINT pk_advertiser PRIMARY KEY(`advertiser_id`)
) COMMENT 'Master record for every advertiser (direct client or agency-managed brand) that the agency serves. Captures authoritative identity including legal entity name, trading name, industry vertical (IAB taxonomy), business segment, holding company affiliation, CRM account ID (Salesforce), ERP customer number (SAP), tax identifiers (VAT/EIN), incorporation jurisdiction, credit terms, payment terms, preferred currency, account status (prospect, active, dormant, churned), account tier, and all engagement preferences (preferred communication channels, reporting cadence, invoice delivery method, language preference, time zone, approval workflow preferences, GDPR/CCPA data sharing consent flags). Also stores structured address records (registered office, billing address, shipping address, regional offices) with address type, full postal details, country (ISO 3166), geocoordinates, and validation status. This is the SSOT for advertiser identity, commercial configuration, engagement preferences, and physical/mailing addresses across the entire data model.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` (
    `advertiser_hierarchy_id` BIGINT COMMENT 'Unique surrogate identifier for each advertiser hierarchy relationship record in the silver layer. Serves as the primary key for this entity.',
    `advertiser_id` BIGINT COMMENT 'Identifier of the child advertiser entity in the hierarchy (e.g., subsidiary, brand, or sub-brand). References the advertiser entity that sits one level below the parent in the corporate tree.',
    `parent_advertiser_id` BIGINT COMMENT 'Identifier of the parent advertiser entity in the hierarchy (e.g., holding company or parent subsidiary). References the advertiser entity that sits one level above the child in the corporate tree.',
    `primary_root_advertiser_id` BIGINT COMMENT 'Identifier of the ultimate holding company or top-level entity in the advertiser corporate tree. Enables direct roll-up to the conglomerate level for consolidated billing, SOV analysis, and enterprise reporting without traversing the full hierarchy path.',
    `agency_commission_rate` DECIMAL(18,2) COMMENT 'The negotiated agency commission rate (expressed as a decimal, e.g., 0.1500 for 15%) applicable to media buys placed on behalf of the child entity within this hierarchy. Stored at the hierarchy level to support tiered commission structures for holding company clients in Mediaocean Prisma.',
    `approved_by` STRING COMMENT 'Name or identifier of the account management or finance authority who approved the establishment or modification of this hierarchy relationship. Required for governance and SOW compliance in client services workflows.',
    `approved_date` DATE COMMENT 'The date on which this hierarchy relationship was formally approved by the designated account management or finance authority. Distinct from the effective start date — approval may precede the operational effective date.',
    `billing_consolidation_flag` BOOLEAN COMMENT 'Indicates whether invoices and media spend for the child entity are consolidated and billed through the parent entity. Distinct from the general consolidation flag — specifically governs Mediaocean Prisma billing workflows and Insertion Order (IO) aggregation.',
    `change_reason` STRING COMMENT 'Categorized reason code explaining why this hierarchy relationship record was created or last modified. Supports audit trail requirements and change management reporting for account management teams during corporate restructuring events. [ENUM-REF-CANDIDATE: acquisition|divestiture|rebranding|restructuring|correction|initial_setup|other — 7 candidates stripped; promote to reference product]',
    `consolidation_flag` BOOLEAN COMMENT 'Indicates whether the child entitys spend, impressions, and campaign performance metrics should be financially consolidated into the parent entitys reporting and P&L. Critical for holding company clients where subsidiary budgets roll up to a master account in SAP S/4HANA CO.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the primary operating jurisdiction for this hierarchy relationship. Used to apply correct regulatory reporting requirements (GDPR, CCPA, FTC), tax treatment in SAP S/4HANA, and local media buying rules.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this advertiser hierarchy relationship record was first created in the system. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides the audit trail creation anchor for data governance and compliance reporting.',
    `crm_hierarchy_code` STRING COMMENT 'The native account hierarchy relationship identifier from Salesforce CRM Sales Cloud. Enables bi-directional synchronization between the lakehouse silver layer and the CRM system of record for account management and client services workflows.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the billing and financial consolidation currency applicable to this hierarchy relationship (e.g., USD, EUR, GBP). Governs how media spend and agency fees are consolidated in Mediaocean Prisma and SAP S/4HANA FI.. Valid values are `^[A-Z]{3}$`',
    `data_sharing_consent_flag` BOOLEAN COMMENT 'Indicates whether the child advertiser entity has provided consent for audience data and campaign performance data to be shared with the parent entity in this hierarchy. Critical for GDPR and CCPA compliance when consolidating audience insights across corporate structures.',
    `effective_end_date` DATE COMMENT 'The date on which this parent-child hierarchy relationship ceases to be operationally effective. Nullable for open-ended relationships. Supports temporal hierarchy versioning when corporate structures change due to divestitures or rebranding.',
    `effective_start_date` DATE COMMENT 'The date on which this parent-child hierarchy relationship became or becomes operationally effective. Used to enforce temporally accurate billing roll-ups and campaign attribution when corporate structures change (e.g., acquisition effective date).',
    `hierarchy_code` STRING COMMENT 'Externally-known alphanumeric business code uniquely identifying this parent-child hierarchy relationship. Used in Mediaocean Prisma and Salesforce CRM for cross-system reconciliation and billing roll-up references.. Valid values are `^AH-[A-Z0-9]{6,12}$`',
    `hierarchy_description` STRING COMMENT 'Free-text narrative describing the business context, rationale, or special conditions of this parent-child hierarchy relationship. Captures nuances such as regional carve-outs, brand licensing arrangements, or joint venture structures not fully expressed by the type and role fields.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of the child advertiser entity within the corporate account tree, where level 1 represents the ultimate holding company. Enables multi-level roll-up queries for consolidated P&L and campaign reporting across conglomerates such as WPP or Publicis.',
    `hierarchy_name` STRING COMMENT 'Human-readable label describing this specific parent-child hierarchy relationship (e.g., Unilever > Dove Brand Portfolio). Used in account management dashboards, QBR presentations, and client services reporting for clear identification of the relationship.',
    `hierarchy_path` STRING COMMENT 'Materialized slash-delimited path string representing the full ancestry chain from the root holding company to the current child node (e.g., /HoldCo/SubsidiaryA/BrandX). Supports efficient subtree queries and lineage tracing in Databricks without recursive CTEs.',
    `hierarchy_status` STRING COMMENT 'Current lifecycle state of the parent-child hierarchy relationship. Drives whether the relationship is used for active campaign attribution, billing consolidation, and reporting roll-ups in Mediaocean Prisma and Google Campaign Manager 360.. Valid values are `active|inactive|pending|terminated|suspended`',
    `hierarchy_type` STRING COMMENT 'Classifies the nature of the parent-child relationship within the advertiser corporate structure. Determines how billing, reporting, and campaign attribution roll up through the account tree. [ENUM-REF-CANDIDATE: holding_company|subsidiary|brand_portfolio|brand|sub_brand|division — promote to reference product]. Valid values are `holding_company|subsidiary|brand_portfolio|brand|sub_brand|division`',
    `industry_sector` STRING COMMENT 'The IAB Content Taxonomy industry sector classification of the child advertiser entity within this hierarchy (e.g., Consumer Packaged Goods, Automotive, Financial Services). Supports audience segmentation, competitive SOV analysis, and Nielsen Ad Intel competitive monitoring.',
    `is_primary_hierarchy` BOOLEAN COMMENT 'Indicates whether this relationship represents the primary (canonical) hierarchy path for the child advertiser entity. When an entity belongs to multiple hierarchy trees (e.g., matrix structures), this flag identifies the authoritative roll-up path for billing and consolidated reporting.',
    `market_region` STRING COMMENT 'The geographic market region in which this hierarchy relationship is operationally active (e.g., North America, EMEA, APAC). Determines applicable regulatory frameworks (GDPR, CCPA), media buying practices, and regional account team assignments. [ENUM-REF-CANDIDATE: North America|EMEA|APAC|LATAM|MEA|Global — promote to reference product]',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'The percentage of ownership the parent entity holds in the child entity (0.00–100.00). Used to determine proportional financial consolidation thresholds and to classify the relationship as majority-owned, minority-owned, or affiliated for P&L reporting in SAP S/4HANA.',
    `prisma_hierarchy_code` STRING COMMENT 'The native account hierarchy identifier from Mediaocean Prisma used for media planning, buying, and billing roll-up. Supports reconciliation between the lakehouse and Prisma for consolidated media spend reporting across the advertiser corporate tree.',
    `relationship_role` STRING COMMENT 'Describes the commercial or legal role of the child entity relative to the parent within the hierarchy (e.g., wholly-owned subsidiary vs. franchise vs. joint venture). Informs contract and billing treatment in SAP S/4HANA and Mediaocean Prisma.. Valid values are `owner|licensee|franchisee|joint_venture|affiliate|managed_entity`',
    `reporting_consolidation_flag` BOOLEAN COMMENT 'Indicates whether campaign performance data (impressions, clicks, CTR, ROAS) for the child entity rolls up into the parent entitys consolidated reporting dashboards in Google Campaign Manager 360 and The Trade Desk. May differ from billing consolidation in matrix account structures.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this hierarchy relationship record was originally sourced or is mastered. Supports data lineage tracking and conflict resolution when the same hierarchy is maintained across multiple systems.. Valid values are `salesforce_crm|mediaocean_prisma|campaign_manager_360|the_trade_desk|manual`',
    `sov_rollup_flag` BOOLEAN COMMENT 'Indicates whether the child entitys media spend and impressions should be included in the parent entitys Share of Voice (SOV) calculations for competitive analysis in Nielsen Ad Intel and Comscore. Enables accurate conglomerate-level SOV reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this advertiser hierarchy relationship record was most recently modified. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for incremental ETL processing, change data capture, and audit trail maintenance in the Databricks silver layer.',
    `version_number` STRING COMMENT 'Monotonically incrementing version counter for this hierarchy relationship record. Incremented each time the hierarchy definition is modified (e.g., ownership percentage change, status update). Supports optimistic concurrency control and audit trail reconstruction.',
    CONSTRAINT pk_advertiser_hierarchy PRIMARY KEY(`advertiser_hierarchy_id`)
) COMMENT 'Defines the parent-child organizational hierarchy among advertiser entities — holding company, subsidiary, brand, and sub-brand relationships. Supports multi-level account trees for large conglomerates (e.g., WPP, Publicis clients) where billing, reporting, and campaign attribution must roll up through corporate structures. Tracks hierarchy type (holding, subsidiary, brand portfolio), effective dates, and consolidation flags.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`client_brand` (
    `client_brand_id` BIGINT COMMENT 'Self-referencing identifier for the parent brand when this brand is a sub-brand or brand extension (e.g., Dove Men+Care is a sub-brand of Dove). Enables brand hierarchy navigation for portfolio reporting and consolidated media planning.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Links clients brand entity to master brand profile for centralized brand guidelines, positioning, tone, visual identity, and compliance rules. Essential for campaign planning, creative briefing, and ',
    `advertiser_id` BIGINT COMMENT 'Reference to the parent advertiser (client) who owns this brand. A single advertiser may own multiple brands (e.g., Unilever owns Dove, Axe, Lipton).',
    `client_brand_campaign_manager_advertiser_id` BIGINT COMMENT 'The advertiser/brand identifier assigned within Google Campaign Manager 360 for ad serving, trafficking, and reporting. Required for reconciling impression delivery data and click-through reporting back to the brand.',
    `worker_id` BIGINT COMMENT 'Reference to the internal employee designated as the primary account manager responsible for this brand relationship. Sourced from Workday HCM and Salesforce CRM Service Cloud.',
    `annual_media_budget` DECIMAL(18,2) COMMENT 'The total approved annual media spend budget allocated to this brand in the base currency. Used for budget pacing, media plan authorization, and Profit & Loss (P&L) reporting in SAP S/4HANA.',
    `brand_category` STRING COMMENT 'Primary product or service category the brand competes in (e.g., Personal Care, Food & Beverage, Automotive, Financial Services). Aligns with IAB Content Taxonomy for audience targeting and competitive analysis. [ENUM-REF-CANDIDATE: Personal Care|Food & Beverage|Automotive|Financial Services|Technology|Retail|Healthcare|Entertainment|Travel|Other — promote to reference product]',
    `brand_code` STRING COMMENT 'Externally-known alphanumeric short code uniquely identifying the brand across operational systems including Google Campaign Manager 360, Mediaocean Prisma, and The Trade Desk. Used for trafficking, billing, and reconciliation.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `brand_description` STRING COMMENT 'Free-text narrative describing the brands identity, value proposition, target audience, and key differentiators. Used by account teams, creative teams, and media planners to ensure brand-consistent execution.',
    `brand_name` STRING COMMENT 'The official commercial name of the brand as recognized in the market (e.g., Dove, Axe, Lipton). Used as the primary human-readable identifier across campaigns, creative assets, and media plans.',
    `brand_status` STRING COMMENT 'Current lifecycle status of the brand record. Controls whether the brand is eligible for campaign assignment, media planning, and creative production. pending_launch indicates a brand approved but not yet publicly launched.. Valid values are `active|inactive|suspended|archived|pending_launch`',
    `brand_tier` STRING COMMENT 'Strategic positioning tier of the brand within the advertisers portfolio, indicating relative market positioning and investment priority. Drives media budget allocation, creative production standards, and account team resourcing.. Valid values are `premium|mainstream|value|luxury|challenger`',
    `budget_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the brands annual media budget (e.g., USD, EUR, GBP). Required for multi-currency financial reconciliation in SAP S/4HANA and Mediaocean Prisma.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the brand record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides audit trail for data governance and lineage tracking.',
    `crm_brand_code` STRING COMMENT 'The brands unique identifier in Salesforce CRM (Sales Cloud / Marketing Cloud). Enables cross-system reconciliation between the lakehouse Silver Layer and the operational CRM system of record.',
    `dam_folder_code` STRING COMMENT 'The folder or collection identifier in Workfront DAM (Digital Asset Management) where all creative assets for this brand are stored. Enables direct navigation from brand record to associated creative library.',
    `data_privacy_classification` STRING COMMENT 'Privacy classification governing data collection and audience targeting practices for this brand. children applies COPPA/GDPR-K restrictions. sensitive applies enhanced consent requirements under GDPR Article 9 and CCPA. Drives audience data usage policies in the DMP/CDP.. Valid values are `standard|sensitive|restricted|children`',
    `digital_advertising_enabled` BOOLEAN COMMENT 'Indicates whether the brand is approved and configured for digital advertising including programmatic, paid search (PPC/SEM), and social media. Controls eligibility for The Trade Desk DSP activation and Google Campaign Manager 360 trafficking.',
    `discontinuation_date` DATE COMMENT 'The date on which the brand was officially discontinued or retired from the market. Null for active brands. Used to enforce data governance rules preventing new campaign assignments to discontinued brands.',
    `guidelines_url` STRING COMMENT 'URL pointing to the brands official style guide and creative guidelines document stored in Workfront DAM or Adobe Creative Cloud. Used by creative teams to ensure brand-consistent asset production.. Valid values are `^https?://[^s/$.?#].[^s]*$`',
    `iab_category_code` STRING COMMENT 'The IAB Content Taxonomy category code assigned to the brand (e.g., IAB1, IAB7-25). Used for programmatic audience targeting on The Trade Desk, brand safety controls, and contextual advertising alignment.. Valid values are `^IAB[0-9]{1,3}(-[0-9]{1,3})?$`',
    `is_house_brand` BOOLEAN COMMENT 'Indicates whether this brand is an agency house brand or proprietary brand (True) versus a client-owned advertiser brand (False). Affects revenue recognition, conflict-of-interest checks, and P&L attribution in SAP S/4HANA.',
    `launch_date` DATE COMMENT 'The date on which the brand was officially launched in the market. Used for brand age calculations, anniversary campaign planning, and historical performance benchmarking.',
    `nielsen_brand_code` STRING COMMENT 'The brand identifier assigned by Nielsen Ad Intel for competitive monitoring, audience measurement, and Gross Rating Point (GRP) tracking. Enables competitive spend benchmarking and Share of Voice (SOV) analysis.',
    `operating_markets` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes representing all markets where the brand is actively sold and advertised. Used for multi-market campaign planning, regulatory compliance scoping, and global media buying via The Trade Desk.',
    `portfolio_rank` STRING COMMENT 'Numeric rank of the brand within the advertisers portfolio based on strategic importance and revenue contribution (1 = highest priority). Used for resource allocation, account team staffing, and Quarterly Business Review (QBR) prioritization.',
    `primary_channel` STRING COMMENT 'The primary media channel through which the brand predominantly advertises. Drives default media planning templates in Mediaocean Prisma and channel-specific KPI frameworks. OOH = Out-of-Home.. Valid values are `digital|television|ooh|print|radio|integrated`',
    `primary_market_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the brands primary operating market (e.g., USA, GBR, DEU). Drives regulatory compliance requirements (GDPR, CCPA), media planning geography, and reporting currency selection.. Valid values are `^[A-Z]{3}$`',
    `prisma_brand_code` STRING COMMENT 'The brand identifier used in Mediaocean Prisma for media planning, buying, billing, and financial reconciliation. Ensures accurate budget allocation and invoice matching at the brand level.',
    `programmatic_eligible` BOOLEAN COMMENT 'Indicates whether the brand is approved for Real-Time Bidding (RTB) and programmatic media buying via Demand-Side Platforms (DSPs) such as The Trade Desk. Brands may be excluded due to regulatory restrictions, brand safety policies, or client preference.',
    `regulatory_restrictions` STRING COMMENT 'Free-text description of any regulatory or legal advertising restrictions applicable to the brand (e.g., alcohol advertising watershed rules, pharmaceutical fair balance requirements, gambling advertising restrictions). Informs creative compliance review and media placement approvals.',
    `safety_level` STRING COMMENT 'The brand safety classification tier governing content adjacency restrictions for programmatic and digital media buying. Determines keyword blocklists, content category exclusions, and inventory quality thresholds applied in The Trade Desk and Google Campaign Manager 360.. Valid values are `standard|strict|custom|unrestricted`',
    `sov_target_pct` DECIMAL(18,2) COMMENT 'The client-agreed target Share of Voice (SOV) percentage for this brand within its competitive category. Used as a KPI benchmark for media planning, campaign performance evaluation, and Nielsen Ad Intel competitive monitoring.',
    `sub_category` STRING COMMENT 'Secondary classification within the brand category providing finer segmentation (e.g., within Personal Care: Skin Care, Hair Care, Deodorants). Supports audience insights, competitive benchmarking via Nielsen Ad Intel, and media planning.',
    `tagline` STRING COMMENT 'The official marketing tagline or slogan associated with the brand (e.g., Just Do It, Real Beauty). Stored as a reference for creative consistency checks and brand compliance reviews.',
    `target_demographic` STRING COMMENT 'Textual description of the brands primary target audience demographic (e.g., Adults 25-54, HHI $75K+, Urban). Informs audience targeting strategies in The Trade Desk, Nielsen audience measurement, and Comscore cross-platform analytics.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the brand record was last modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for incremental ETL processing, change data capture, and audit compliance.',
    `website_url` STRING COMMENT 'The official public-facing website URL for the brand. Used for digital campaign trafficking, click-through destination validation in Google Campaign Manager 360, and SEO/SEM performance tracking.. Valid values are `^https?://[^s/$.?#].[^s]*$`',
    CONSTRAINT pk_client_brand PRIMARY KEY(`client_brand_id`)
) COMMENT 'Represents an individual brand owned by an advertiser. A single advertiser may manage multiple brands (e.g., Unilever owns Dove, Axe, Lipton). Captures brand name, brand code, category, sub-category, brand tier, launch date, brand status, and the owning advertiser. Serves as the SSOT for brand identity referenced by campaigns, creative assets, and media plans. Distinct from the brand domains brand strategy and positioning entities.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`client_contact` (
    `client_contact_id` BIGINT COMMENT 'Unique surrogate identifier for each client contact record in the Silver Layer lakehouse. Primary key for the client_contact data product. Role: MASTER_PARTY.',
    `advertiser_id` BIGINT COMMENT 'Foreign key linking to client.advertiser. Business justification: Client contacts are individuals associated with advertiser organizations. Every contact must belong to an advertiser (the client organization they represent). This is a critical missing relationship -',
    `account_role` STRING COMMENT 'The contacts strategic role in the client account relationship as classified by the account management team. Used for stakeholder mapping, Account-Based Marketing (ABM) targeting, and relationship health scoring.. Valid values are `decision_maker|influencer|approver|end_user|champion`',
    `ccpa_opt_out_flag` BOOLEAN COMMENT 'Indicates whether the contact has exercised their CCPA right to opt out of the sale or sharing of their personal information. True = opted out. Mandatory for contacts in California. Drives data sharing suppression.',
    `city` STRING COMMENT 'City where the contact is primarily based or where their office is located. Used for regional segmentation, event invitations, and on-site meeting logistics.',
    `contact_source` STRING COMMENT 'The originating channel or method through which this contact was first acquired or entered into the CRM system. Used for relationship provenance tracking and business development analytics.. Valid values are `crm|referral|event|inbound|outbound|partner`',
    `contact_status` STRING COMMENT 'Current lifecycle status of the contact record. Indicates whether the contact is actively engaged, temporarily unavailable, or has left the client organisation. Drives CRM hygiene and suppression logic.. Valid values are `active|inactive|on_leave|departed`',
    `contact_type` STRING COMMENT 'Functional classification of the contacts role in the client relationship (e.g., primary day-to-day contact, billing approver, legal signatory, technical integration contact). Drives workflow routing for insertion orders, statements of work, and campaign approvals.. Valid values are `primary|secondary|billing|legal|technical`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country where the contact is primarily based. Used for regulatory jurisdiction determination (GDPR, CCPA), tax treatment, and regional account assignment.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this client contact record was first created in the Silver Layer lakehouse. Serves as the RECORD_AUDIT_CREATED marker for data lineage, compliance audit trails, and SLA tracking.',
    `crm_contact_code` STRING COMMENT 'Source system identifier for this contact record in Salesforce CRM (Sales Cloud / Service Cloud). Used for lineage tracing and cross-system reconciliation with the operational system of record.',
    `data_subject_request_flag` BOOLEAN COMMENT 'Indicates whether an active data subject request (e.g., right of access, right to erasure, right to rectification) has been submitted by or on behalf of this contact. True = active DSR in progress. Triggers data handling restrictions.',
    `departed_date` DATE COMMENT 'Date on which the contact left their role at the client organisation or was otherwise deactivated. Null for active contacts. Used to manage record lifecycle, suppress communications, and trigger successor identification workflows.',
    `department` STRING COMMENT 'Business department or functional unit the contact belongs to within their organisation (e.g., Marketing, Procurement, Legal, Finance). Used to segment contacts for targeted communications and account planning.',
    `email` STRING COMMENT 'Primary business email address of the contact. Used for campaign briefings, insertion order delivery, reporting distribution, and all formal client communications. SSOT sourced from Salesforce CRM.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_name` STRING COMMENT 'Given (first) name of the client-side contact individual as recorded in Salesforce CRM. Used for personalised communications, salutations, and account team relationship management.',
    `full_name` STRING COMMENT 'Full display name of the contact (typically first_name + last_name) as stored in Salesforce CRM. Used as the canonical human-readable label for the contact across reporting, dashboards, and client-facing documents.',
    `gdpr_consent_date` DATE COMMENT 'Date on which the contact granted or last updated their GDPR consent. Required for audit and compliance demonstration under GDPR Article 7(1). Null if consent has not been collected or is not applicable.',
    `gdpr_consent_status` STRING COMMENT 'Current GDPR consent status for processing this contacts personal data for marketing and communications purposes. Mandatory for contacts in EU/EEA jurisdictions. Drives suppression and opt-in logic.. Valid values are `granted|withdrawn|pending|not_applicable`',
    `is_billing_contact` BOOLEAN COMMENT 'Indicates whether this contact is authorised to receive and approve invoices, purchase orders, and financial reconciliation documents. True = billing contact. Used by finance teams for invoice routing and payment approval workflows.',
    `is_legal_signatory` BOOLEAN COMMENT 'Indicates whether this contact has authority to sign contracts, statements of work (SOW), insertion orders (IO), and other legally binding documents on behalf of the client organisation.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this contact is the designated primary point of contact for the client account. True = primary contact. Only one contact per account should hold this designation at any time. Drives default routing for briefs and reports.',
    `job_title` STRING COMMENT 'Official job title of the contact at their organisation (e.g., Marketing Director, Brand Manager, Procurement Lead, Finance Approver). Drives routing logic for proposals, insertion orders, and campaign approvals.',
    `language` STRING COMMENT 'ISO 639-1 language code (optionally with ISO 3166-1 country subtag) representing the contacts preferred language for communications and documents (e.g., en-US, fr-FR, de-DE). Drives localisation of reports and correspondence.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_interaction_date` DATE COMMENT 'Date of the most recent recorded interaction (call, email, meeting, or campaign review) between the agency and this contact. Used to identify at-risk relationships and trigger re-engagement workflows.',
    `last_name` STRING COMMENT 'Family (last) name of the client-side contact individual as recorded in Salesforce CRM. Combined with first_name to form the full display name for reporting and correspondence.',
    `linkedin_profile_url` STRING COMMENT 'URL of the contacts LinkedIn professional profile. Used by account management and business development teams for relationship intelligence, stakeholder mapping, and pre-meeting research.. Valid values are `^https://(www.)?linkedin.com/in/[a-zA-Z0-9-_%]+/?$`',
    `marketing_opt_out_flag` BOOLEAN COMMENT 'Indicates whether the contact has opted out of receiving marketing and promotional communications from the agency. True = opted out. Applies globally across all channels and overrides channel-specific preferences.',
    `mobile_phone` STRING COMMENT 'Mobile phone number for the contact in E.164 international format. Supports SMS-based communications, two-factor authentication for portal access, and urgent out-of-hours escalations.. Valid values are `^+?[1-9]d{1,14}$`',
    `notes` STRING COMMENT 'Free-text field for account managers to record qualitative relationship context, communication preferences, personal interests, or other relevant notes about the contact. Supports personalised relationship management.',
    `nps_score` STRING COMMENT 'Most recently recorded Net Promoter Score (NPS) provided by this contact in a client satisfaction survey. Integer value from 0 to 10. Used to measure relationship health and identify promoters, passives, and detractors.',
    `nps_survey_date` DATE COMMENT 'Date on which the most recent NPS survey response was collected from this contact. Used to determine the currency of the NPS score and schedule the next survey cycle.',
    `phone` STRING COMMENT 'Primary business phone number for the contact in E.164 international format. Used for urgent campaign escalations, account management calls, and QBR scheduling.. Valid values are `^+?[1-9]d{1,14}$`',
    `preferred_communication_channel` STRING COMMENT 'The contacts stated preferred channel for receiving communications from the agency. Drives outreach strategy for account managers and ensures client satisfaction by respecting communication preferences.. Valid values are `email|phone|mobile|linkedin|video_call`',
    `relationship_start_date` DATE COMMENT 'Date on which the agencys relationship with this contact was formally established or the contact was first recorded in the CRM. Used for relationship tenure analysis and loyalty recognition in QBRs.',
    `secondary_email` STRING COMMENT 'Alternate or personal business email address for the contact. Used as a fallback communication channel when the primary email is undeliverable or the contact is out of office.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `seniority_level` STRING COMMENT 'Seniority classification of the contact within their organisations hierarchy. Informs escalation paths, approval authority, and relationship investment strategy for account management teams.. Valid values are `C-Suite|VP|Director|Manager|Specialist|Coordinator`',
    `timezone` STRING COMMENT 'IANA time zone identifier for the contacts primary working location (e.g., America/New_York, Europe/London). Used to schedule calls, QBRs, and campaign review meetings at appropriate local times.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this client contact record in the Silver Layer lakehouse. Used for change detection, incremental ETL processing, and audit trail completeness.',
    CONSTRAINT pk_client_contact PRIMARY KEY(`client_contact_id`)
) COMMENT 'Individual person associated with an advertiser or agency-managed account — including marketing directors, brand managers, procurement leads, legal contacts, and finance approvers. Captures full name, job title, department, seniority level, email, phone, preferred communication channel, LinkedIn profile, GDPR/CCPA consent status, and opt-out flags. Sourced from Salesforce CRM Contact object. SSOT for all client-side human contacts.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`account_team` (
    `account_team_id` BIGINT COMMENT 'Unique surrogate identifier for each account team assignment record in the advertising agency. Serves as the primary key for this entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser or agency-managed client account to which this team member is assigned. Anchors the assignment within the client domain hierarchy.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Account team members are assigned to cost centers for overhead allocation, utilization tracking, and P&L reporting. Essential for agency financial management to track labor costs by client account and',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Account team members often have vendor relationship management responsibilities—e.g., media buyer assigned to manage Google/Meta relationships for specific clients. Tracks vendor stewardship assignmen',
    `worker_id` BIGINT COMMENT 'Reference to the agency-side personnel record (account director, strategist, planner, media buyer, creative) assigned to this account. Links to the talent domain employee master.',
    `tertiary_account_approved_by_employee_worker_id` BIGINT COMMENT 'Reference to the agency employee (typically a Managing Director or Group Account Director) who approved this team assignment. Supports governance, audit trails, and staffing approval workflows.',
    `account_access_level` STRING COMMENT 'The level of access this team member has to the client account record in Salesforce CRM (read, edit, or all). Mirrors the Salesforce AccountTeamMember AccountAccessLevel field and governs data visibility for compliance and conflict-of-interest checks.. Valid values are `read|edit|all`',
    `approval_date` DATE COMMENT 'The date on which this account team assignment was formally approved by the designated approver. Used for governance audit trails and staffing compliance reporting.',
    `assignment_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this account team assignment, used in Workfront project management and Salesforce CRM for cross-system reference and QBR (Quarterly Business Review) reporting.. Valid values are `^AT-[A-Z0-9]{6,12}$`',
    `assignment_notes` STRING COMMENT 'Free-text field capturing additional context about the team members assignment, such as special responsibilities, client preferences, transition notes, or coverage arrangements. Supports account management continuity.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the team members assignment to the account. active indicates currently serving; on_leave indicates temporary absence with backup coverage; transitioning indicates handover in progress; inactive indicates assignment ended; pending indicates assignment approved but not yet started.. Valid values are `active|on_leave|transitioning|inactive|pending`',
    `assignment_type` STRING COMMENT 'Classifies the nature of the team members assignment to the account: dedicated = exclusively assigned; shared = split across multiple accounts; project_based = assigned for a specific campaign or project; interim = temporary coverage assignment.. Valid values are `dedicated|shared|project_based|interim`',
    `billing_rate_type` STRING COMMENT 'Specifies the time unit basis for the billing rate applied to this team members account assignment (hourly, daily, monthly, or fixed fee). Determines how FTE allocation and time tracking translate to client invoicing.. Valid values are `hourly|daily|monthly|fixed`',
    `billing_rate_usd` DECIMAL(18,2) COMMENT 'The hourly or daily billing rate in USD applied to this team members time on the client account, as defined in the Statement of Work (SOW) or Master Service Agreement. Used for financial reconciliation and P&L reporting in SAP S/4HANA.',
    `client_facing_flag` BOOLEAN COMMENT 'Indicates whether this team member has direct client-facing responsibilities and appears on the client-facing org chart. True = client-facing; False = internal/support role only. Governs inclusion in client communications and org chart generation.',
    `conflict_of_interest_flag` BOOLEAN COMMENT 'Indicates whether a potential conflict of interest has been identified for this team members assignment to the account (e.g., simultaneous assignment to a competing advertiser). True = conflict identified; False = no conflict. Triggers compliance review workflow.',
    `conflict_review_date` DATE COMMENT 'The date on which the most recent conflict-of-interest review was conducted for this team members account assignment. Supports compliance audit trails and periodic review scheduling.',
    `conflict_review_outcome` STRING COMMENT 'The outcome of the most recent conflict-of-interest review for this assignment. cleared = no conflict found; waived = conflict acknowledged and waived by client; escalated = referred to senior management; pending = review in progress.. Valid values are `cleared|waived|escalated|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this account team assignment record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides the audit trail creation anchor for data lineage and compliance reporting.',
    `end_date` DATE COMMENT 'The date on which the agency personnel members assignment to this client account is scheduled to end or actually ended. Null for open-ended assignments. Used for resource planning and transition management.',
    `fte_allocation_pct` DECIMAL(18,2) COMMENT 'The percentage of the team members full-time equivalent (FTE) capacity allocated to this specific client account, expressed as a decimal percentage (e.g., 50.00 = 50%). Supports resource utilization tracking, capacity planning, and P&L cost allocation.',
    `is_backup_contact` BOOLEAN COMMENT 'Indicates whether this team member serves as the backup coverage contact for the client account when the primary contact is unavailable. True = designated backup; False = not a backup. Supports continuity planning and leave coverage.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this team member is the designated primary point of contact for the client account. True = primary contact; False = supporting team member. Used for client-facing org chart generation and escalation routing.',
    `last_review_date` DATE COMMENT 'The date of the most recent formal review of this team members account assignment, typically conducted during QBR cycles or annual staffing reviews. Supports proactive account management and client satisfaction monitoring.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next formal review of this team members account assignment. Enables proactive scheduling of staffing reviews and QBR preparation cycles.',
    `org_chart_display_order` STRING COMMENT 'Numeric sequence controlling the display order of this team member within the client-facing org chart for the account. Lower values appear first. Enables structured presentation of the account team hierarchy to clients.',
    `planned_hours_per_month` DECIMAL(18,2) COMMENT 'The planned number of hours per month this team member is expected to dedicate to this client account, as agreed in the Statement of Work (SOW) or resource plan. Used for utilization tracking and capacity planning in Workfront.',
    `qbr_presenter_flag` BOOLEAN COMMENT 'Indicates whether this team member is designated to present at the clients Quarterly Business Review (QBR). True = QBR presenter; False = not a QBR presenter. Used for QBR preparation and client-facing agenda planning.',
    `role` STRING COMMENT 'The functional role this agency personnel member holds on the client account (e.g., Account Director, Strategic Planner, Media Lead, Creative Director, Account Manager, Media Buyer). Drives org chart generation and responsibility mapping. [ENUM-REF-CANDIDATE: Account Director|Strategic Planner|Media Lead|Creative Director|Account Manager|Media Buyer|Digital Strategist|Data Analyst|PR Lead|Brand Strategist — promote to reference product]. Valid values are `Account Director|Strategic Planner|Media Lead|Creative Director|Account Manager|Media Buyer`',
    `salesforce_team_member_code` STRING COMMENT 'The unique identifier of the corresponding AccountTeamMember record in Salesforce CRM Sales Cloud. Supports CRM synchronization, client relationship management, and QBR preparation workflows.',
    `seniority_level` STRING COMMENT 'The seniority classification of the team member within their assigned role on this account (e.g., junior, mid, senior, lead, executive). Used for billing rate determination, resource planning, and QBR staffing reviews.. Valid values are `junior|mid|senior|lead|executive`',
    `start_date` DATE COMMENT 'The date on which the agency personnel member formally began their assignment to this client account. Used for tenure tracking, utilization reporting, and conflict-of-interest checks.',
    `team_function` STRING COMMENT 'The agency functional discipline this team member represents on the account (account management, media, creative, strategy, analytics, or PR). Enables cross-functional team composition reporting and resource planning by discipline.. Valid values are `account_management|media|creative|strategy|analytics|pr`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this account team assignment record was most recently modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports change tracking, data lineage, and Silver layer incremental processing.',
    CONSTRAINT pk_account_team PRIMARY KEY(`account_team_id`)
) COMMENT 'Maps agency-side personnel (account directors, strategists, planners, media buyers, creatives) to specific advertiser accounts. Captures assigned team member reference, role on account (Account Director, Strategic Planner, Media Lead, Creative Director), assignment start and end dates, FTE allocation percentage, primary contact flag, backup coverage, and team status. Enables resource planning, utilization tracking, conflict-of-interest checks, QBR preparation, and client-facing org chart generation.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`address` (
    `address_id` BIGINT COMMENT 'Unique surrogate identifier for each client address record in the advertising agencys client management system. Primary key for the client_address data product.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser or agency client account to which this address belongs. Links the address record to the parent client entity in the client domain.',
    `client_contact_id` BIGINT COMMENT 'Reference to the individual contact person associated with this address, when the address belongs to a specific contact rather than the account-level entity. Nullable for account-level addresses.',
    `address_status` STRING COMMENT 'Current lifecycle status of the address record. Active addresses are used for current correspondence and billing; unverified addresses have not yet passed validation; invalid addresses failed validation checks; archived addresses are retained for historical reference only.. Valid values are `active|inactive|unverified|invalid|archived`',
    `address_type` STRING COMMENT 'Classification of the address by its business purpose. Billing addresses are used for invoice delivery and financial correspondence; registered_office is the legal domicile; regional_office supports geo-based audience targeting alignment; mailing is for general correspondence. [ENUM-REF-CANDIDATE: billing|shipping|registered_office|regional_office|mailing|legal — promote to reference product if additional types are needed]. Valid values are `billing|shipping|registered_office|regional_office|mailing`',
    `attention_line` STRING COMMENT 'Specific person, department, or role name to whom correspondence at this address should be directed (e.g., Attn: Accounts Payable, Attn: Marketing Director). Used for invoice delivery and legal correspondence routing within large advertiser organizations.',
    `city` STRING COMMENT 'City or municipality name of the address. Used for geo-based audience targeting alignment, regional media planning, and Out-of-Home (OOH) and Digital Out-of-Home (DOOH) campaign geo-targeting.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the address (e.g., USA, GBR, DEU). Determines applicable regulatory frameworks (GDPR for EU countries, CCPA for USA), currency for billing, and international media planning jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this address record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail requirements, data lineage tracking, and compliance with GDPR Article 5 accountability obligations.',
    `crm_address_code` STRING COMMENT 'External identifier for this address record in the Salesforce CRM system (Sales Cloud or Service Cloud). Enables cross-system reconciliation between the lakehouse Silver layer and the operational CRM system of record for client address data.',
    `data_source` STRING COMMENT 'Identifies the originating system or method through which this address record was captured. Supports data lineage tracking, ETL (Extract Transform Load) audit trails, and data quality governance across the advertising agencys operational systems of record.. Valid values are `salesforce_crm|sap_s4hana|mediaocean_prisma|manual_entry|client_portal|import`',
    `deliverability_score` DECIMAL(18,2) COMMENT 'Numeric score (0.00–100.00) representing the confidence level that mail or deliveries sent to this address will be successfully received. Derived from postal validation services. Supports data quality governance and prioritization of address re-validation efforts.',
    `dma_code` STRING COMMENT 'Nielsen Designated Market Area (DMA) code associated with the address geography. Used for television and radio media planning, Gross Rating Point (GRP) and Target Rating Point (TRP) calculations, and audience measurement alignment with Nielsen Ad Intel reporting.. Valid values are `^[0-9]{3}$`',
    `effective_from` DATE COMMENT 'Date from which this address record is considered valid and active for business use. Supports bi-temporal data management, enabling accurate historical reporting of client address data for audit, legal correspondence, and campaign geo-targeting alignment.',
    `effective_until` DATE COMMENT 'Date after which this address record is no longer valid for active business use. Nullable for currently active addresses. Supports address history management, enabling accurate point-in-time queries for invoice delivery, legal correspondence, and regulatory compliance.',
    `erp_address_code` STRING COMMENT 'External identifier for this address record in SAP S/4HANA (FI module - Business Partner). Used for financial reconciliation, invoice routing, and cross-system data lineage between the lakehouse and the ERP system of record.',
    `format_type` STRING COMMENT 'Indicates the structural format of the address for correct postal formatting and routing. Domestic addresses follow national postal standards; international addresses follow UPU standards; military addresses use APO/FPO/DPO formats; po_box addresses use PO Box routing.. Valid values are `domestic|international|military|po_box`',
    `gdpr_lawful_basis` STRING COMMENT 'The legal basis under GDPR Article 6 for processing this address data. Required for EU/EEA client addresses to demonstrate compliance with GDPR data processing requirements. Applicable when country_code corresponds to an EU/EEA member state.. Valid values are `consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests`',
    `geocoding_accuracy` STRING COMMENT 'Precision level of the geocoordinates assigned to this address. Rooftop indicates exact building-level precision; range_interpolated is street-level; geometric_center is centroid of a region; approximate is low-precision. Informs the reliability of geo-based audience targeting and OOH/DOOH proximity analysis.. Valid values are `rooftop|range_interpolated|geometric_center|approximate`',
    `is_billing_default` BOOLEAN COMMENT 'Indicates whether this address is the default destination for invoice and billing document delivery. Used by Mediaocean Prisma and SAP S/4HANA FI to route financial documents including Insertion Orders (IOs) and billing statements.',
    `is_do_not_mail` BOOLEAN COMMENT 'Indicates whether this address has been flagged to suppress physical mail correspondence, in compliance with client preferences or regulatory opt-out requirements. Supports compliance with direct mail suppression lists and client communication preferences.',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this is the primary address for the client or contact. Only one address per client per address_type should be flagged as primary. Used to determine the default address for invoice delivery and legal correspondence.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the address in decimal degrees (WGS 84 datum), ranging from -90 to +90. Enables geo-based audience targeting alignment, proximity analysis for Out-of-Home (OOH) and Digital Out-of-Home (DOOH) media planning, and regional campaign delivery optimization.',
    `line_1` STRING COMMENT 'Primary street address line including building number, street name, and suite or unit number. Used for invoice delivery, legal correspondence, and geo-based audience targeting alignment in campaign planning.',
    `line_2` STRING COMMENT 'Secondary address line for additional location details such as floor number, building name, department, or attention line. Supplements address_line_1 for complete physical location identification.',
    `line_3` STRING COMMENT 'Tertiary address line used for international addresses requiring additional locality or district information, or for extended address details not captured in lines 1 and 2.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the address in decimal degrees (WGS 84 datum), ranging from -180 to +180. Used in conjunction with latitude for geo-based audience targeting, Designated Market Area (DMA) mapping, and programmatic campaign geo-fencing via Demand-Side Platforms (DSPs).',
    `notes` STRING COMMENT 'Free-text field for additional context or instructions related to this address, such as delivery access instructions, seasonal address changes, or account management notes relevant to correspondence routing.',
    `po_box` STRING COMMENT 'Post Office Box number for clients who receive mail via PO Box rather than a physical street address. Used for mailing and billing correspondence when a physical address is not applicable or preferred by the client.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the address. Used for invoice routing, direct mail campaign targeting, geo-based audience segmentation, and Designated Market Area (DMA) alignment in media planning.',
    `state_province` STRING COMMENT 'State, province, or administrative region of the address using ISO 3166-2 subdivision codes (e.g., US-CA, GB-ENG). Supports regional media buying, regulatory compliance (CCPA for California), and geo-targeted campaign delivery.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the address location (e.g., America/New_York, Europe/London). Used for scheduling campaign flights, coordinating media buys across time zones, and ensuring accurate campaign delivery timing for programmatic and broadcast media.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this address record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture (CDC), ETL incremental loads, and audit trail compliance.',
    `validation_date` DATE COMMENT 'Date on which the address was last validated against postal authority databases. Used to determine whether re-validation is required based on data freshness policies and to support audit trails for compliance with GDPR and CCPA data accuracy requirements.',
    `validation_source` STRING COMMENT 'Name of the address validation service or system used to verify the address (e.g., USPS CASS, SmartyStreets, Loqate, Google Maps API). Supports audit trails and data quality governance for address accuracy.',
    `validation_status` STRING COMMENT 'Result of the most recent address validation check against postal authority databases. Validated addresses have been confirmed as deliverable; failed addresses contain errors; pending addresses are queued for validation. Supports data quality management for invoice delivery and legal correspondence.. Valid values are `validated|failed|pending|not_attempted`',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Physical and mailing addresses associated with advertiser accounts and contacts — including registered office, billing address, shipping address, and regional office locations. Captures address type, street lines, city, state/province, postal code, country (ISO 3166), geocoordinates, address validation status, and effective dates. Supports invoice delivery, legal correspondence, and geo-based audience targeting alignment.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`agency_relationship` (
    `agency_relationship_id` BIGINT COMMENT 'Unique surrogate identifier for the agency-advertiser relationship record. Primary key for this entity. Role classification: MASTER_AGREEMENT — represents a long-running formal binding relationship between the agency and an advertiser.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser or client organisation that is party to this agency relationship. Links to the client master record in the client domain.',
    `agreement_id` BIGINT COMMENT 'Reference to the governing contract or Statement of Work (SOW) that formalises the terms of this agency relationship. Links to the contract master record.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Agency contracts often specify which audience segments the agency is authorized to target or access (e.g., first-party data segments, geographic restrictions). Contractual and data governance requirem',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Agency relationships often designate primary media suppliers or tech platforms used for that client account. Tracks which DSPs, SSPs, or publishers are approved/preferred under specific agency-client ',
    `annual_fee_amount` DECIMAL(18,2) COMMENT 'The contracted annual agency fee or retainer amount in the agreed currency for this relationship. Used for P&L reporting, budget management, and financial reconciliation. Applicable for retainer and project-fee structures.',
    `aor_designation` STRING COMMENT 'Specifies the specific Agency of Record (AOR) designation held by the agency for this client, if applicable. Distinguishes between full-service AOR and discipline-specific AOR designations (media, creative, digital, PR, social). Used for AOR tracking and executive relationship reporting. [ENUM-REF-CANDIDATE: full_service_aor|media_aor|creative_aor|digital_aor|pr_aor|social_aor|none — 7 candidates stripped; promote to reference product]',
    `brand_scope` STRING COMMENT 'Comma-delimited list of the clients brand names or brand portfolio segments covered under this agency relationship. Distinguishes relationships that cover the full client portfolio from those scoped to specific brands or sub-brands.',
    `client_contact_email` STRING COMMENT 'The business email address of the primary client contact for this relationship. Used for direct communication, meeting scheduling, and CRM record maintenance. Subject to GDPR and CCPA data protection requirements.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `commission_rate_pct` DECIMAL(18,2) COMMENT 'The agreed agency commission rate expressed as a percentage of gross media spend, applicable when the fee structure type is commission_based or hybrid. Used for financial reconciliation in Mediaocean Prisma and SAP S/4HANA.',
    `competitive_conflict_flag` BOOLEAN COMMENT 'Indicates whether this agency-client relationship involves a known competitive conflict with another client in the agencys portfolio (i.e., the agency serves two competing advertisers in the same category). Critical for conflict management and new business governance.',
    `conflict_category` STRING COMMENT 'The product or industry category in which a competitive conflict exists, if the competitive conflict flag is true (e.g., Automotive, Financial Services, FMCG — Beverages). Used for conflict management reporting and new business screening.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp at which this agency relationship record was first created in the system. Serves as the RECORD_AUDIT_CREATED field for this MASTER_AGREEMENT entity. Used for data lineage, audit trail, and compliance reporting.',
    `crm_opportunity_code` STRING COMMENT 'The external identifier of the corresponding Salesforce CRM Opportunity record that originated or tracks this agency-client relationship. Enables bi-directional traceability between the data lakehouse and the CRM system of record.',
    `current_event_type` STRING COMMENT 'The type of the most recent state-change event recorded against this relationship. Supports AOR win/loss tracking, scope change management, and executive relationship lifecycle reporting. Full event history is stored as effective-dated event records within this product. [ENUM-REF-CANDIDATE: aor_win|aor_loss|scope_expansion|scope_reduction|renewal|escalation|status_transition|termination|suspension|reinstatement|pitch_initiated — promote to reference product]',
    `effective_end_date` DATE COMMENT 'The date on which the agency-client relationship is scheduled to end or was terminated. Nullable for open-ended relationships. Used for AOR tracking, renewal management, and competitive conflict management. Serves as EFFECTIVE_UNTIL for this MASTER_AGREEMENT entity.',
    `effective_start_date` DATE COMMENT 'The date on which the agency-client relationship formally commenced and became binding. Used for AOR tracking, tenure calculations, and relationship lifecycle reporting. Serves as EFFECTIVE_FROM for this MASTER_AGREEMENT entity.',
    `estimated_annual_billings` DECIMAL(18,2) COMMENT 'The estimated total annual media billings or revenue associated with this agency-client relationship, in the fee currency. Used for revenue forecasting, P&L reporting, and strategic account prioritisation. Distinct from the contracted annual fee amount.',
    `event_effective_date` DATE COMMENT 'The business-effective date of the most recent state-change event (e.g., the date an AOR win took effect, the date a scope expansion was agreed). Distinct from the record audit timestamp; used for effective-dated relationship lifecycle reporting.',
    `event_notes` STRING COMMENT 'Free-text narrative notes providing additional context for the most recent relationship state-change event. Captures qualitative detail such as client rationale, negotiation outcomes, or escalation context. Supports audit trail and executive relationship lifecycle reporting.',
    `event_trigger` STRING COMMENT 'A brief description of the business event or circumstance that triggered the most recent relationship state change (e.g., Client initiated competitive review, Scope expanded to include social media, Contract renewed for FY2025). Supports narrative audit trail and executive reporting.',
    `fee_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the annual fee amount and any financial values associated with this relationship (e.g., USD, GBP, EUR). Supports multi-currency financial reconciliation.. Valid values are `^[A-Z]{3}$`',
    `fee_structure_type` STRING COMMENT 'The commercial fee model governing agency compensation under this relationship. Retainer_fee is a fixed recurring payment; commission_based is a percentage of media spend; project_fee is a one-time scoped payment; performance_based ties compensation to KPI outcomes; hybrid combines multiple models.. Valid values are `retainer_fee|commission_based|project_fee|performance_based|hybrid`',
    `geographic_scope` STRING COMMENT 'The geographic markets or territories covered by this agency-client relationship (e.g., USA, GBR,DEU,FRA, Global). Uses ISO 3166-1 alpha-3 country codes where applicable. Supports multi-market AOR tracking and competitive conflict management.',
    `incumbent_agency_name` STRING COMMENT 'The name of the previous incumbent agency that held the account prior to this relationship being established, if applicable. Used for competitive intelligence, pitch history analysis, and AOR win/loss reporting.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the agency holds an exclusive mandate for the defined scope of services with this advertiser, preventing the client from engaging competing agencies for the same services. Critical for competitive conflict management and AOR governance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp at which this agency relationship record was most recently updated. Used for change tracking, data synchronisation with Salesforce CRM, and audit trail compliance.',
    `lead_account_director` STRING COMMENT 'The name of the senior agency account director who holds primary responsibility for managing this client relationship. Used for account team assignment, escalation routing, and executive relationship reporting.',
    `mediaocean_client_code` STRING COMMENT 'The client code assigned to this advertiser in Mediaocean Prisma, the media planning and buying system of record. Used for reconciliation of media plans, insertion orders (IOs), and billing records against this relationship.. Valid values are `^[A-Z0-9-]{2,20}$`',
    `next_review_date` DATE COMMENT 'The scheduled date of the next formal relationship review or Quarterly Business Review (QBR). Used for proactive account management, renewal planning, and executive calendar management.',
    `notice_period_days` STRING COMMENT 'The number of calendar days of advance written notice required by either party to terminate or materially modify this agency-client relationship, as specified in the governing contract or Statement of Work (SOW).',
    `pitch_type` STRING COMMENT 'The type of pitch or selection process through which this agency-client relationship was established. Competitive_review is a formal multi-agency pitch; direct_award is a non-competitive appointment; incumbent_retention is a renewal without a formal pitch; rfi_rfp is a formal Request for Information (RFI) or Request for Proposal (RFP) process.. Valid values are `competitive_review|direct_award|incumbent_retention|rfi_rfp`',
    `pitch_win_date` DATE COMMENT 'The date on which the agency formally won the pitch or competitive review that established this relationship. Used for pitch history tracking, new business reporting, and AOR win/loss analytics.',
    `previous_relationship_status` STRING COMMENT 'The relationship status immediately prior to the most recent state-change event. Stored alongside the current status to support audit trail requirements and state-transition reporting without requiring a separate history table.. Valid values are `active|pending|suspended|terminated|under_review`',
    `primary_client_contact` STRING COMMENT 'The name of the primary contact person on the client/advertiser side for this relationship (e.g., CMO, Marketing Director, Brand Manager). Used for account management, communication routing, and CRM record maintenance.',
    `relationship_code` STRING COMMENT 'Externally-known alphanumeric business identifier for this agency-client relationship, used in Salesforce CRM, Mediaocean Prisma, and client-facing correspondence (e.g., REL-2024-00123). Serves as the BUSINESS_IDENTIFIER for this MASTER_AGREEMENT entity.. Valid values are `^[A-Z0-9-]{3,30}$`',
    `relationship_status` STRING COMMENT 'Current lifecycle state of the agency-client relationship. Active indicates a live, operational engagement; pending indicates a relationship that has been agreed but not yet commenced; suspended indicates a temporary hold; terminated indicates the relationship has ended; under_review indicates a formal review or pitch process is underway. Serves as LIFECYCLE_STATUS for this MASTER_AGREEMENT entity.. Valid values are `active|pending|suspended|terminated|under_review`',
    `relationship_tier` STRING COMMENT 'The strategic importance tier assigned to this agency-client relationship based on revenue, strategic value, and growth potential. Strategic denotes top-tier accounts receiving dedicated senior resources; key_account denotes significant accounts; standard denotes routine engagements; emerging denotes new or high-growth potential accounts.. Valid values are `strategic|key_account|standard|emerging`',
    `relationship_type` STRING COMMENT 'Classification of the formal relationship structure between the agency and the advertiser. AOR (Agency of Record) denotes full-service exclusive mandate; project_based is scoped to a single campaign or deliverable; retainer is an ongoing fee-based engagement; roster_agency is a non-exclusive approved supplier; preferred_vendor is a qualified but non-exclusive partner. Serves as CLASSIFICATION_OR_TYPE for this MASTER_AGREEMENT entity.. Valid values are `aor|project_based|retainer|roster_agency|preferred_vendor`',
    `renewal_date` DATE COMMENT 'The date on which the agency-client relationship contract is due for renewal or renegotiation. Distinct from the effective end date; used for proactive renewal pipeline management and AOR retention tracking.',
    `review_cycle` STRING COMMENT 'The agreed frequency at which the agency-client relationship is formally reviewed, including performance evaluation, scope assessment, and fee renegotiation. Supports Quarterly Business Review (QBR) scheduling and executive relationship lifecycle reporting.. Valid values are `annual|biannual|quarterly|ad_hoc`',
    `scope_of_services` STRING COMMENT 'Comma-delimited list of service disciplines covered under this relationship (e.g., media, creative, pr, digital, social, ooh, programmatic, sem, seo). Defines the breadth of the agency mandate and is used for competitive conflict management and scope expansion tracking. [ENUM-REF-CANDIDATE: media|creative|pr|digital|social|ooh|programmatic|sem|seo|analytics|content|influencer — promote to reference product]',
    CONSTRAINT pk_agency_relationship PRIMARY KEY(`agency_relationship_id`)
) COMMENT 'Captures the formal relationship between the agency and an advertiser, including relationship type (AOR — Agency of Record, project-based, retainer, roster agency), relationship status, scope of services (media, creative, PR, digital, social), start and end dates, exclusivity flags, governing contract reference, and full relationship state-change history stored as effective-dated event records (AOR wins/losses, scope expansions, renewals, escalations, status transitions with effective dates, triggering events, previous state, new state, and narrative notes). This is the SSOT for both current relationship state and historical relationship lifecycle — no separate history table exists. Supports AOR tracking, pitch history, competitive conflict management, audit trail, and executive relationship lifecycle reporting.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`client_segment` (
    `client_segment_id` BIGINT COMMENT 'Unique surrogate identifier for each client segment record in the Databricks Silver Layer. Primary key for the client_segment data product.',
    `abm_eligible` BOOLEAN COMMENT 'Indicates whether advertisers in this segment are eligible for Account-Based Marketing (ABM) programs. ABM-eligible segments receive dedicated content personalization, targeted outreach, and bespoke pitch strategies. Drives campaign targeting logic in Salesforce Marketing Cloud.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp (ISO 8601 with timezone offset) when this segment record was first created in the system. Provides the audit trail creation marker required for data lineage, GDPR compliance, and Silver Layer data quality monitoring.',
    `crm_segment_code` STRING COMMENT 'External identifier for this segment as recorded in Salesforce CRM Sales Cloud. Enables bidirectional synchronization between the Databricks Silver Layer and the CRM system of record for account assignment and pipeline reporting.',
    `data_privacy_tier` STRING COMMENT 'Privacy compliance tier applied to data handling for advertisers in this segment. Standard applies baseline CCPA/GDPR controls; Enhanced applies additional consent management; Strict applies maximum data minimization and opt-in requirements for regulated industries (e.g., healthcare, finance).. Valid values are `standard|enhanced|strict`',
    `dedicated_account_team_required` BOOLEAN COMMENT 'Indicates whether advertisers in this segment require a dedicated account management team (as opposed to a pooled or shared service model). Drives FTE (Full-Time Equivalent) resource planning in Workday HCM and Workfront capacity management.',
    `effective_end_date` DATE COMMENT 'The date on which this segment definition expires or is superseded. Nullable for open-ended segments. Enables point-in-time segment reconstruction for historical reporting and regulatory compliance.',
    `effective_start_date` DATE COMMENT 'The date from which this segment definition becomes active and applicable for advertiser classification. Used for temporal validity tracking and historical segment analysis in QBRs and revenue forecasting.',
    `geographic_market` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the primary geographic market scope of this segment (e.g., USA, GBR, DEU). Used for regional resource allocation, media planning alignment, and compliance with jurisdiction-specific regulations (GDPR, CCPA).. Valid values are `^[A-Z]{3}$`',
    `geographic_region` STRING COMMENT 'Broader geographic region grouping for the segment (e.g., North America, EMEA, APAC, LATAM). Supports regional portfolio reporting, executive dashboards, and cross-market resource planning in Workfront and SAP S/4HANA.',
    `iab_industry_vertical_code` STRING COMMENT 'IAB Content Taxonomy category code representing the industry vertical classification of advertisers within this segment (e.g., IAB3 for Business, IAB19 for Technology). Used for competitive analysis, audience targeting alignment, and industry benchmarking via Nielsen Ad Intel and Comscore.. Valid values are `^IAB[0-9]{1,3}(-[0-9]{1,3})?$`',
    `iab_industry_vertical_name` STRING COMMENT 'Human-readable label corresponding to the IAB industry vertical code assigned to this segment (e.g., Automotive, Financial Services, Retail). Supports executive reporting, pitch targeting, and ABM (Account-Based Marketing) strategy alignment.',
    `is_primary_segment` BOOLEAN COMMENT 'Indicates whether this segment record represents the primary (active) segment assignment for an advertiser at a given point in time. Enforces the business rule that each advertiser is assigned to exactly one primary segment at any point in time. Used in deduplication logic and point-in-time reporting.',
    `last_review_date` DATE COMMENT 'Date on which the most recent formal review of this segments criteria, thresholds, and advertiser assignments was completed. Used to track review compliance and trigger overdue review alerts.',
    `min_annual_spend_usd` DECIMAL(18,2) COMMENT 'Minimum annual media and campaign spend (in USD) expected from advertisers assigned to this segment. Used in revenue forecasting, P&L (Profit and Loss) planning, and EBITDA (Earnings Before Interest, Taxes, Depreciation, and Amortization) modeling in SAP S/4HANA.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of this segment definition. Calculated from last_review_date and review_cadence. Used by Workfront project management to schedule QBR preparation tasks and notify segment owners.',
    `owner_email` STRING COMMENT 'Corporate email address of the segment owner used for automated review notifications, QBR scheduling, and escalation workflows. Classified as confidential as it identifies an internal employee.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `owner_name` STRING COMMENT 'Full name of the internal business owner (typically a Group Account Director or VP of Client Services) responsible for the segment definition, criteria governance, and periodic review. Referenced in Salesforce CRM and Workfront for accountability tracking.',
    `primary_channel_mix` STRING COMMENT 'Comma-separated list of primary advertising channels typically utilized by advertisers in this segment (e.g., CTV, DOOH, PPC, OTT, SEM). Informs media planning defaults in Mediaocean Prisma and programmatic buying strategies in The Trade Desk.',
    `programmatic_buying_eligible` BOOLEAN COMMENT 'Indicates whether advertisers in this segment are eligible for programmatic media buying via DSP (Demand-Side Platform) channels such as The Trade Desk. Drives RTB (Real-Time Bidding) activation and audience targeting configuration.',
    `revenue_threshold_max_usd` DECIMAL(18,2) COMMENT 'Maximum annual advertiser revenue (in USD) for assignment to this segment. Defines the upper bound of the revenue tier. Null for the highest tier (Enterprise) where no upper cap applies. Used in conjunction with revenue_threshold_min_usd for tier boundary enforcement.',
    `revenue_threshold_min_usd` DECIMAL(18,2) COMMENT 'Minimum annual advertiser revenue (in USD) required for assignment to this segment. Defines the lower bound of the revenue tier used in segmentation scoring methodology. Used in SAP S/4HANA financial reconciliation and revenue forecasting models.',
    `review_cadence` STRING COMMENT 'Frequency at which the segment definition, criteria, and advertiser assignments are formally reviewed and validated. Quarterly cadence aligns with QBR (Quarterly Business Review) cycles. Drives automated review scheduling in Workfront.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `scoring_methodology` STRING COMMENT 'Description of the scoring model or criteria used to classify advertisers into this segment (e.g., RFM scoring, revenue-only threshold, composite score including spend velocity, strategic fit, and growth potential). Documents the business rules applied during segment assignment for auditability and QBR review.',
    `scoring_weight_growth_potential` DECIMAL(18,2) COMMENT 'Percentage weight (0.00–100.00) assigned to the growth potential dimension in the composite segmentation scoring model. Reflects the advertisers projected spend trajectory, market expansion signals, and new product adoption likelihood.',
    `scoring_weight_revenue` DECIMAL(18,2) COMMENT 'Percentage weight (0.00–100.00) assigned to the revenue dimension in the composite segmentation scoring model. Reflects the relative importance of advertiser revenue versus other scoring dimensions (strategic fit, growth potential). Used to calibrate segment assignment consistency.',
    `scoring_weight_strategic_fit` DECIMAL(18,2) COMMENT 'Percentage weight (0.00–100.00) assigned to the strategic fit dimension in the composite segmentation scoring model. Captures alignment with agency growth priorities, brand portfolio synergies, and ABM (Account-Based Marketing) target profiles.',
    `segment_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the segment, used in Salesforce CRM, Mediaocean Prisma, and cross-system reporting (e.g., ENT-001, MID-002, SMB-003). Serves as the human-readable unique code referenced in Account-Based Marketing (ABM) campaigns and Quarterly Business Reviews (QBRs).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `segment_description` STRING COMMENT 'Detailed narrative description of the segments purpose, target advertiser profile, strategic rationale, and key differentiators from adjacent segments. Used in new business pitch materials, RFP (Request for Proposal) responses, and internal onboarding documentation.',
    `segment_name` STRING COMMENT 'Human-readable name of the advertiser segment used for account prioritization and tiered service delivery (e.g., Enterprise, Mid-Market, SMB, Strategic Growth). Displayed in executive portfolio reports, QBRs, and new business pitch targeting materials.',
    `segment_status` STRING COMMENT 'Current lifecycle state of the segment definition. Active segments are in use for account assignment; under_review segments are being evaluated for criteria changes; deprecated segments have been superseded by updated definitions.. Valid values are `active|inactive|under_review|deprecated`',
    `segment_tier` STRING COMMENT 'Revenue-based tier classification of the advertiser segment used for resource allocation, service level assignment, and account prioritization. Enterprise represents the highest-value accounts; SMB (Small and Medium Business) represents the lowest revenue tier. Strategic Growth identifies high-potential accounts regardless of current revenue.. Valid values are `enterprise|mid_market|smb|strategic_growth`',
    `segment_type` STRING COMMENT 'Classification of the segmentation approach used to define this segment. Indicates whether the segment is defined by revenue tier, industry vertical, geographic market, strategic priority, or behavioral attributes. Drives which scoring methodology and criteria apply.. Valid values are `revenue_tier|industry_vertical|geographic_market|strategic|behavioral`',
    `service_tier_level` STRING COMMENT 'Tiered service delivery level assigned to this segment, determining the scope of dedicated account management resources, response SLAs, and value-added services. Platinum represents the highest service commitment; Bronze represents standard self-serve support.. Valid values are `platinum|gold|silver|bronze`',
    `target_roas_benchmark` DECIMAL(18,2) COMMENT 'Benchmark ROAS (Return on Ad Spend) target established for advertisers in this segment, expressed as a ratio (e.g., 4.0000 = $4 revenue per $1 spent). Used to set performance expectations in campaign strategy, KPI (Key Performance Indicator) frameworks, and QBR reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp (ISO 8601 with timezone offset) of the most recent modification to this segment record. Used for incremental ETL (Extract, Transform, Load) processing, change data capture, and audit trail maintenance in the Databricks Silver Layer.',
    `version_number` STRING COMMENT 'Monotonically incrementing version number for the segment definition. Incremented each time segment criteria, thresholds, or scoring methodology are formally revised. Supports historical segment reconstruction and audit trail requirements.',
    CONSTRAINT pk_client_segment PRIMARY KEY(`client_segment_id`)
) COMMENT 'Classification of advertisers into strategic business segments used for account prioritization, resource allocation, revenue forecasting, and tiered service delivery. Captures segment name (Enterprise, Mid-Market, SMB, Strategic Growth), segmentation criteria and scoring methodology, revenue tier thresholds, industry vertical classification (IAB taxonomy), geographic market, segment owner, review cadence, and segment effective dates. Supports ABM (Account-Based Marketing) strategies, quarterly business reviews, executive portfolio reporting, and new business pitch targeting. Each advertiser is assigned to exactly one primary segment at any point in time.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`client_brief` (
    `client_brief_id` BIGINT COMMENT 'Unique system-generated identifier for the client brief record. Primary key for the client_brief data product.',
    `advertiser_id` BIGINT COMMENT 'Identifier of the client (advertiser or agency) who submitted this brief. Links to the client master record.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Campaign briefs specify target audience segments for media planning and activation. This is the primary mechanism linking client requirements to targetable audiences in advertising operations. Essenti',
    `brand_profile_id` BIGINT COMMENT 'Identifier of the specific brand within the client portfolio for which this brief is submitted. Supports multi-brand client accounts.',
    `client_contact_id` BIGINT COMMENT 'Identifier of the client-side contact who submitted or is the primary owner of this brief. Maps to the CRM contact record.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Client briefs initiate projects/initiatives that are tracked in project management systems. Currently workfront_project_id is stored as an unlinked string. Normalizing to initiative_id FK enables join',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: Client briefs require agency ownership assignment for accountability, workload management, and brief-to-execution handoff tracking. The contact_id tracks client submitter; brief_owner_worker_id tracks',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Briefs frequently specify preferred suppliers/publishers for campaign execution. Media planners reference approved vendor lists when briefing campaigns. Essential for RFP routing and vendor selection ',
    `persona_id` BIGINT COMMENT 'Foreign key linking to audience.persona. Business justification: Briefs reference personas to guide creative strategy, messaging, and channel selection. Standard practice in advertising where personas inform campaign development beyond just segment targeting. Suppo',
    `approval_date` DATE COMMENT 'Calendar date on which the brief was formally approved by the agency account team and accepted for execution. Null if not yet approved.',
    `brand_guidelines_version` STRING COMMENT 'Version identifier of the client brand guidelines document that must be adhered to for all creative executions under this brief (e.g., v3.2, 2024-Q1). Ensures creative compliance with current brand standards.',
    `brief_number` STRING COMMENT 'Externally-visible, human-readable reference number assigned to the brief at submission (e.g., BRF-2024-000123). Used in client communications, Workfront project creation, and Mediaocean Prisma work orders.. Valid values are `^BRF-[0-9]{4}-[0-9]{6}$`',
    `brief_status` STRING COMMENT 'Current lifecycle state of the client brief. Drives workflow routing: draft (being authored), submitted (awaiting review), approved (accepted for execution), in_progress (active work underway), on_hold (paused), closed (completed or cancelled).. Valid values are `draft|submitted|approved|in_progress|on_hold|closed`',
    `brief_type` STRING COMMENT 'Classification of the brief by the type of work being requested. Determines the downstream workflow and team assignment. [ENUM-REF-CANDIDATE: campaign|creative|media|pr|digital|brand_strategy — promote to reference product]. Valid values are `campaign|creative|media|pr|digital|brand_strategy`',
    `budget_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the budget indication amount (e.g., USD, GBP, EUR). Supports multi-currency client engagements.. Valid values are `^[A-Z]{3}$`',
    `budget_indication_amount` DECIMAL(18,2) COMMENT 'Client-indicated total budget for the campaign or project described in this brief, expressed in the operating currency. This is a directional figure provided at brief stage, not a committed spend. Used for resource planning and scoping.',
    `campaign_end_date` DATE COMMENT 'Client-requested end date for the campaign or deliverable described in the brief. Defines the desired flight window.',
    `campaign_objective` STRING COMMENT 'Primary marketing objective the client wants to achieve with this campaign or project. Drives KPI selection and channel strategy. [ENUM-REF-CANDIDATE: brand_awareness|lead_generation|sales_conversion|retention|consideration|reach|engagement|app_install — promote to reference product]',
    `campaign_start_date` DATE COMMENT 'Client-requested start date for the campaign or deliverable described in the brief. Represents the desired go-live date as specified by the client.',
    `channel_requirements` STRING COMMENT 'Client-specified media channels or platforms required or preferred for this campaign (e.g., CTV, DOOH, OTT, social, search, OOH, programmatic). Free-text to capture complex multi-channel requirements.',
    `closed_date` DATE COMMENT 'Date on which the brief was formally closed, either upon successful completion of all deliverables or cancellation. Null if the brief is still active. Supports lifecycle reporting and pipeline analytics.',
    `closure_reason` STRING COMMENT 'Reason code explaining why the brief was closed. Populated when brief_status transitions to closed. Supports win/loss analysis and client relationship management.. Valid values are `completed|cancelled_by_client|cancelled_by_agency|merged|superseded`',
    `competitive_context` STRING COMMENT 'Client-provided description of the competitive landscape relevant to this campaign, including key competitors, market positioning, and Share of Voice (SOV) considerations. Confidential business intelligence.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the client brief record was first created in the data platform. Audit trail field aligned with Silver Layer ingestion standards.',
    `creative_format_requirements` STRING COMMENT 'Specific creative formats, sizes, or specifications required by the client (e.g., IAB standard banner sizes, VAST video specs, print dimensions). Informs creative production scope.',
    `deliverable_due_date` DATE COMMENT 'Client-specified deadline by which the primary deliverable (creative, media plan, strategy deck, etc.) must be completed and delivered. May differ from campaign start date.',
    `geographic_scope` STRING COMMENT 'Description of the geographic markets or regions targeted by this campaign (e.g., national, specific DMAs, countries). Free-text to support complex geo-targeting requirements.',
    `is_agency_managed` BOOLEAN COMMENT 'Indicates whether this brief is submitted through an intermediary agency on behalf of the end advertiser (True) or directly by the advertiser (False). Affects billing, reporting, and account team assignment.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the client has designated this brief as confidential, restricting access to named account team members only. Drives data access controls and document handling procedures.',
    `key_message` STRING COMMENT 'The primary communication message or value proposition the client wants to convey to the target audience. Core creative direction provided in the brief.',
    `mandatory_exclusions` STRING COMMENT 'Client-specified elements, themes, competitors, or content that must NOT appear in any deliverable. Includes brand safety restrictions and competitive separation requirements.',
    `mandatory_inclusions` STRING COMMENT 'Client-specified elements that must appear in all creative executions or deliverables (e.g., legal disclaimers, brand taglines, product claims, regulatory copy, logo usage requirements).',
    `primary_kpi` STRING COMMENT 'The single most important Key Performance Indicator (KPI) the client will use to measure campaign success. Drives optimization strategy and reporting requirements. [ENUM-REF-CANDIDATE: ctr|cpm|cpc|cpa|roas|vtr|grp|trp|reach|frequency|engagement_rate|conversion_rate — promote to reference product]',
    `primary_kpi_target_value` DECIMAL(18,2) COMMENT 'Numeric target value the client expects to achieve for the primary KPI (e.g., a CTR of 0.0250 means 2.5%, a CPM of 5.00 means $5.00 per thousand impressions). Precision to 4 decimal places supports rate-based KPIs.',
    `priority_level` STRING COMMENT 'Client or account team-assigned priority level for this brief, used to triage work intake and allocate agency resources. Drives scheduling in Workfront project management.. Valid values are `low|medium|high|urgent`',
    `regulatory_compliance_notes` STRING COMMENT 'Client-specified regulatory, legal, or compliance requirements that must be observed in all deliverables (e.g., GDPR consent requirements, CCPA disclosures, FTC endorsement guidelines, industry-specific advertising restrictions).',
    `revision_reason` STRING COMMENT 'Narrative explanation of why the brief was revised from a prior version. Populated when brief_version > 1. Supports change management and audit trail.',
    `salesforce_opportunity_code` STRING COMMENT 'Reference identifier of the associated Salesforce CRM Opportunity record, linking the brief to the revenue pipeline and account management context.',
    `secondary_kpi` STRING COMMENT 'Secondary KPI used to provide additional performance context beyond the primary KPI. Free-text to accommodate custom client KPI definitions not covered by standard enumerations.',
    `submission_date` DATE COMMENT 'Calendar date on which the client formally submitted the brief to the agency. The principal business event date for this record.',
    `title` STRING COMMENT 'Short, descriptive title of the client brief as provided by the requesting client contact (e.g., Q3 2024 Summer Campaign Launch Brief).',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the client brief record was most recently modified. Used for change detection, incremental ETL processing, and audit compliance.',
    `version` STRING COMMENT 'Incrementing version number of the brief document, starting at 1. Incremented each time the client submits a revised brief. Supports brief revision history and change management.',
    CONSTRAINT pk_client_brief PRIMARY KEY(`client_brief_id`)
) COMMENT 'Formal creative or campaign brief submitted by the client to initiate a new campaign, project, or creative deliverable. Captures brief title, brief type (campaign, creative, media, PR), submission date, requesting contact, target audience description, key message, mandatory inclusions, budget indication, desired KPIs, timeline requirements, and brief status (draft, approved, in-progress, closed). The SSOT for client-originated work requests.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`interaction` (
    `interaction_id` BIGINT COMMENT 'Unique surrogate identifier for each client interaction record in the Silver layer. Primary key for the client_interaction data product.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser or agency-managed client account that is the subject of this interaction. Links to the client master record.',
    `agreement_id` BIGINT COMMENT 'Reference to the Statement of Work (SOW), Insertion Order (IO), or master contract discussed or referenced during this interaction.',
    `brand_profile_id` BIGINT COMMENT 'Reference to the specific client brand discussed during this interaction, where the client manages a portfolio of brands and the interaction pertains to a specific brand.',
    `campaign_id` BIGINT COMMENT 'Reference to the active advertising campaign linked to this interaction, if the discussion pertains to an in-flight or planned campaign.',
    `client_contact_id` BIGINT COMMENT 'Reference to the specific client-side contact person who participated in this interaction. Links to the client contact master record.',
    `creative_brief_id` BIGINT COMMENT 'Foreign key linking to creative.creative_brief. Business justification: Client interactions (meetings, QBRs, calls) frequently discuss specific creative briefs—reviewing concepts, providing feedback, approving directions. Account teams need to track which briefs were disc',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Client interactions (meetings, QBRs, escalations) are frequently tied to specific projects/initiatives for context tracking, follow-up actions, and project-specific relationship management. Essential ',
    `worker_id` BIGINT COMMENT 'Reference to the agency staff member responsible for completing the follow-up actions arising from this interaction.',
    `interaction_worker_id` BIGINT COMMENT 'Reference to the primary agency-side account manager or relationship owner who led or logged this interaction.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Client meetings frequently discuss specific vendor performance, rate negotiations, publisher selection, or tech platform issues. QBRs review vendor scorecards. Essential for tracking vendor-related cl',
    `agency_attendees` STRING COMMENT 'Comma-separated list of agency staff names or employee IDs who participated in the interaction. Captures the full agency-side attendance roster beyond the primary account manager.',
    `agenda` STRING COMMENT 'Pre-interaction agenda or discussion topics as prepared by the account team. Supports meeting preparation, QBR structuring, and relationship planning.',
    `business_topic` STRING COMMENT 'Primary business topic or purpose of the interaction. Categorises the interaction by its strategic business function to support analytics and relationship health reporting. [ENUM-REF-CANDIDATE: campaign_review|media_planning|creative_review|budget_discussion|contract_renewal|new_business|reporting|escalation|onboarding|strategy|compliance — promote to reference product]',
    `channel` STRING COMMENT 'The communication medium through which the interaction was conducted. Distinct from interaction_type (which describes the business purpose); this field describes the delivery channel (e.g., in-person, video conference, phone call).. Valid values are `in_person|video|phone|email|instant_message`',
    `client_attendees` STRING COMMENT 'Comma-separated list of client-side participant names or contact IDs who attended the interaction. Captures the full client attendance roster beyond the primary contact.',
    `client_sentiment` STRING COMMENT 'Account managers qualitative assessment of client sentiment observed during the interaction. Supports relationship health monitoring, NPS tracking, and early warning of at-risk accounts.. Valid values are `positive|neutral|negative|at_risk`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this interaction record was first created in the source Salesforce CRM system. Supports audit trail, data lineage, and SLA compliance reporting.',
    `crm_activity_code` STRING COMMENT 'Source system identifier from Salesforce CRM Activity or Task object. Used for lineage tracing and reconciliation with the operational system of record.',
    `data_region` STRING COMMENT 'Geographic data residency region for this interaction record, used for GDPR, CCPA, and cross-border data transfer compliance. Determines applicable regulatory framework.. Valid values are `AMER|EMEA|APAC|LATAM`',
    `direction` STRING COMMENT 'Indicates whether the interaction was initiated by the client (inbound) or by the agency (outbound). Used for relationship health analysis and proactive engagement tracking.. Valid values are `inbound|outbound`',
    `duration_minutes` STRING COMMENT 'Actual or estimated duration of the interaction in minutes, as logged by the account manager. Supports relationship effort analysis and resource planning.',
    `end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the interaction concluded. Used in conjunction with interaction_start_timestamp to compute interaction duration.',
    `follow_up_actions` STRING COMMENT 'Documented next steps, action items, or commitments arising from the interaction. Supports task management, accountability tracking, and client relationship continuity.',
    `follow_up_due_date` DATE COMMENT 'Target date by which the follow-up actions from this interaction must be completed. Used for SLA monitoring and account team accountability.',
    `gdpr_consent_obtained` BOOLEAN COMMENT 'Indicates whether explicit consent was obtained from client contacts for recording, data processing, or follow-up communications arising from this interaction, as required under GDPR.',
    `interaction_date` DATE COMMENT 'The calendar date on which the interaction occurred or is scheduled to occur. Used for day-level reporting, relationship cadence analysis, and NPS tracking timelines.',
    `interaction_status` STRING COMMENT 'Current lifecycle status of the interaction record. Indicates whether the interaction has been completed, is upcoming, was cancelled, or the client did not attend.. Valid values are `scheduled|completed|cancelled|rescheduled|no_show`',
    `interaction_type` STRING COMMENT 'Classification of the business interaction format. Covers the primary interaction modalities used in agency-client relationship management. Quarterly Business Review (QBR) is a formal structured review. [ENUM-REF-CANDIDATE: meeting|call|email|presentation|qbr|site_visit|workshop|webinar — promote to reference product if additional types are needed]. Valid values are `meeting|call|email|presentation|qbr|site_visit`',
    `is_escalation` BOOLEAN COMMENT 'Indicates whether this interaction was triggered by or resulted in a client escalation. Used for relationship risk monitoring and account health dashboards.',
    `is_qbr` BOOLEAN COMMENT 'Indicates whether this interaction is a formal Quarterly Business Review (QBR) session. QBRs are structured strategic reviews between agency leadership and senior client stakeholders.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this interaction record was last updated in the source Salesforce CRM system. Supports incremental data loading, change detection, and audit compliance.',
    `location` STRING COMMENT 'Physical or virtual location of the interaction. For in-person meetings, this is the venue or office address. For virtual meetings, this may be the video conference URL or platform name (e.g., Zoom, Teams).',
    `nps_score` STRING COMMENT 'Net Promoter Score captured during or following this interaction, on a 0–10 scale. Applicable when the interaction includes a formal NPS survey or feedback collection. Null if not collected.',
    `opportunity_code` BIGINT COMMENT 'Reference to the Salesforce CRM Opportunity linked to this interaction, if the interaction is associated with an active pitch, proposal, or new business pursuit.',
    `outcome_summary` STRING COMMENT 'Narrative summary of the interaction outcome, key discussion points, decisions made, and client sentiment as recorded by the account manager post-interaction. Sourced from Salesforce CRM Activity Description/Comments field.',
    `presentation_url` STRING COMMENT 'URL or DAM (Digital Asset Management) link to the presentation deck or materials shared during the interaction. Supports knowledge management and account continuity.',
    `priority` STRING COMMENT 'Priority level assigned to the interaction or its follow-up actions, as set in Salesforce CRM. Supports triage and account team workload management.. Valid values are `high|medium|low`',
    `recording_url` STRING COMMENT 'URL link to the recorded video or audio of the interaction (e.g., Zoom, Teams recording). Applicable for virtual meetings where recording consent was obtained. Confidential as it may contain sensitive business discussions.',
    `start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the interaction began. Provides sub-day precision for scheduling, duration calculation, and time-zone-aware reporting.',
    `subject` STRING COMMENT 'Short descriptive title or subject line of the interaction, as recorded in Salesforce CRM. Equivalent to the Subject field on the Salesforce Activity/Task object.',
    CONSTRAINT pk_interaction PRIMARY KEY(`interaction_id`)
) COMMENT 'Log of all significant business interactions between agency staff and client contacts — including meetings, calls, QBRs, presentations, email threads, and site visits. Captures interaction type, date and time, participants (agency and client side), interaction channel (in-person, video, phone), subject, outcome summary, follow-up actions, and linked opportunity or campaign. Sourced from Salesforce CRM Activity/Task objects. Supports relationship health monitoring and NPS tracking.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`nps_response` (
    `nps_response_id` BIGINT COMMENT 'Unique system-generated identifier for each NPS survey response record. Primary key for the nps_response data product within the client domain.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser or agency-managed client account associated with this NPS response. Links to the client master record in the client domain.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: NPS surveys often target specific audience segments to measure satisfaction by demographic or behavioral cohort. Enables segmented satisfaction analysis and identifies at-risk audience groups. Common ',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign that triggered this NPS survey, applicable for post-campaign survey types. Null for periodic (quarterly/annual) surveys not tied to a specific campaign.',
    `client_contact_id` BIGINT COMMENT 'Reference to the specific client contact (respondent) who submitted this NPS survey response. Links to the contact record in the client domain.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: NPS surveys often reference specific project delivery to measure client satisfaction on that work. Critical for project retrospectives, team performance evaluation, and identifying delivery issues tie',
    `worker_id` BIGINT COMMENT 'Reference to the internal account manager or client services lead responsible for the client relationship at the time of survey collection. Used for relationship health attribution.',
    `survey_wave_id` BIGINT COMMENT 'Reference to the survey wave or batch under which this NPS response was collected (e.g., Q1 2024 Post-Campaign Wave, Annual Relationship Survey). Links to the survey wave definition record.',
    `anonymized_flag` BOOLEAN COMMENT 'Indicates whether the respondents personal identifiers have been anonymized or pseudonymized in this record (True) in response to a data subject erasure or anonymization request under GDPR/CCPA. When True, contact_id and respondent-identifying fields are nullified.',
    `at_risk_flag` BOOLEAN COMMENT 'Indicates whether this NPS response has triggered an at-risk account designation for the associated client (True) or not (False). Set based on score thresholds, trend deterioration, or critical verbatim feedback. Feeds into account health dashboards and retention workflows.',
    `business_segment` STRING COMMENT 'The client business segment classification at the time of survey collection (e.g., enterprise, mid_market, smb, agency, direct). Captured as a snapshot to support segment-level NPS benchmarking and trend analysis.. Valid values are `enterprise|mid_market|smb|agency|direct`',
    `client_tenure_months` STRING COMMENT 'The number of months the client has been an active account at the time of survey collection. Captured at survey time to enable cohort analysis of NPS trends by client maturity and relationship longevity.',
    `consent_given` BOOLEAN COMMENT 'Indicates whether the respondent provided explicit consent for their survey response data (including verbatim feedback) to be stored, processed, and used for relationship management and analytics purposes (True = consent given, False = not given or withdrawn). Required for GDPR and CCPA compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time this NPS response record was first created in the data platform (Silver Layer ingestion timestamp). Serves as the audit trail creation marker and supports data lineage tracking.',
    `crm_survey_record_code` STRING COMMENT 'The native record identifier from Salesforce CRM (Marketing Cloud or Service Cloud Survey module) for this NPS response. Enables bidirectional traceability between the lakehouse silver layer and the operational system of record.',
    `data_processing_basis` STRING COMMENT 'The legal basis under GDPR Article 6 for processing the personal data contained in this NPS response (e.g., consent, legitimate_interest, contract, legal_obligation). Required for regulatory compliance documentation and data subject rights management.. Valid values are `consent|legitimate_interest|contract|legal_obligation`',
    `follow_up_date` DATE COMMENT 'The date on which the follow-up action with the client contact was completed or is scheduled. Used to measure response time to detractor/passive feedback and track SLA compliance for client recovery actions.',
    `follow_up_notes` STRING COMMENT 'Free-text notes recorded by the account team following the client follow-up conversation. Documents the outcome of the recovery or reinforcement discussion, commitments made, and next steps agreed with the client.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether this NPS response requires a follow-up action by the account team (True) or not (False). Typically set to True for detractors and passives with critical verbatim feedback. Drives the follow-up workflow in Salesforce CRM.',
    `follow_up_status` STRING COMMENT 'Current status of the follow-up action triggered by this NPS response: pending (action required but not started), in_progress (account team engaged), completed (follow-up conversation concluded), not_required (no action needed), escalated (escalated to senior leadership or executive sponsor).. Valid values are `pending|in_progress|completed|not_required|escalated`',
    `improvement_suggestion` STRING COMMENT 'Open-text field capturing the respondents specific suggestions for service or relationship improvement, collected as a secondary open-ended question in the NPS survey. Distinct from verbatim_feedback which explains the score.',
    `industry_vertical` STRING COMMENT 'The clients industry vertical classification at the time of survey (e.g., Automotive, CPG, Financial Services, Retail, Technology, Healthcare). Enables vertical-level NPS benchmarking against industry norms and competitive positioning.',
    `nps_score` STRING COMMENT 'The raw NPS rating provided by the respondent on a 0-10 scale: 0-6 = Detractor, 7-8 = Passive, 9-10 = Promoter. This is the principal quantitative outcome of the survey and the core metric for client satisfaction trending and relationship health scoring.',
    `qbr_linked_flag` BOOLEAN COMMENT 'Indicates whether this NPS response has been formally linked to and presented in a Quarterly Business Review (QBR) session with the client (True) or not (False). Supports QBR preparation workflows and tracks which responses have been actioned in formal client review meetings.',
    `relationship_aspect` STRING COMMENT 'The specific dimension of the client-agency relationship being rated in the secondary question (e.g., strategic_counsel, creative_quality, responsiveness, reporting, media_execution, overall_value). Enables multi-dimensional satisfaction analysis.. Valid values are `strategic_counsel|creative_quality|responsiveness|reporting|media_execution|overall_value`',
    `relationship_aspect_rating` STRING COMMENT 'Secondary rating (1-5 scale) capturing the respondents satisfaction with a specific relationship dimension (e.g., strategic counsel, creative quality, responsiveness, reporting transparency) as defined by the survey wave. Complements the primary NPS score with dimensional insight.',
    `reminder_count` STRING COMMENT 'The number of reminder communications sent to the respondent before they submitted (or declined) the survey. Used to assess survey fatigue, optimize reminder cadence, and contextualize response quality.',
    `respondent_category` STRING COMMENT 'Classification of the respondent based on their NPS score: promoter (score 9-10), passive (score 7-8), detractor (score 0-6). Derived classification stored for operational use in segmentation, at-risk identification, and follow-up routing without requiring score recalculation.. Valid values are `promoter|passive|detractor`',
    `respondent_role` STRING COMMENT 'The functional role of the survey respondent within the client organization (e.g., decision_maker, day_to_day, executive_sponsor, procurement, finance). Enables role-stratified NPS analysis to identify satisfaction gaps across stakeholder levels.. Valid values are `decision_maker|day_to_day|executive_sponsor|procurement|finance`',
    `response_status` STRING COMMENT 'Current lifecycle state of the NPS survey response: submitted (complete response received), partial (respondent started but did not complete), declined (respondent explicitly opted out), expired (survey link expired before completion), invalidated (response flagged as invalid for data quality reasons).. Valid values are `submitted|partial|declined|expired|invalidated`',
    `response_timestamp` TIMESTAMP COMMENT 'The precise date and time (ISO 8601 with timezone offset) at which the respondent submitted the NPS survey response. Used for response latency analysis and audit trail.',
    `survey_channel` STRING COMMENT 'The delivery channel through which the NPS survey was administered to the respondent (e.g., email link, web portal, phone interview, in-person QBR, SMS). Supports channel effectiveness analysis.. Valid values are `email|web|phone|in_person|sms`',
    `survey_date` DATE COMMENT 'The calendar date on which the NPS survey was sent or administered to the respondent. Used as the principal business event date for trend analysis and wave alignment.',
    `survey_expiry_date` DATE COMMENT 'The date after which the survey link or invitation is no longer valid for response submission. Used to manage response windows, flag expired non-responses, and calculate response rate denominators.',
    `survey_invitation_sent_timestamp` TIMESTAMP COMMENT 'The precise date and time the NPS survey invitation was dispatched to the respondent. Used to calculate response latency (time from invitation to submission) and to manage survey expiry windows.',
    `survey_language` STRING COMMENT 'The ISO 639-1 language code (optionally with ISO 3166-1 alpha-2 region code) in which the survey was presented and the response was collected (e.g., en, en-US, fr-FR, de-DE). Supports multilingual client portfolio management.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `survey_response_code` STRING COMMENT 'Externally-known alphanumeric business identifier for this NPS response, used in client communications, follow-up tracking, and CRM cross-referencing (e.g., NPS-2024Q1-001234). Distinct from the internal surrogate key.. Valid values are `^NPS-[A-Z0-9]{6,12}$`',
    `survey_type` STRING COMMENT 'Classification of the NPS survey by its trigger or cadence: post_campaign (collected after campaign completion), quarterly (scheduled quarterly relationship check), annual (annual relationship review), ad_hoc (unscheduled), onboarding (new client), offboarding (departing client). [ENUM-REF-CANDIDATE: post_campaign|quarterly|annual|ad_hoc|onboarding|offboarding — promote to reference product]. Valid values are `post_campaign|quarterly|annual|ad_hoc|onboarding|offboarding`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time this NPS response record was last modified in the data platform, including follow-up status updates, anonymization actions, or data corrections. Supports audit trail and change tracking.',
    `verbatim_feedback` STRING COMMENT 'The open-text qualitative feedback provided by the respondent explaining their NPS score. Captures the why behind the rating and is used for sentiment analysis, theme identification, and account team coaching. May contain client-sensitive commentary.',
    CONSTRAINT pk_nps_response PRIMARY KEY(`nps_response_id`)
) COMMENT 'Captures Net Promoter Score (NPS) survey responses collected from client contacts at scheduled intervals (post-campaign, quarterly, annual). Records respondent contact, survey date, NPS score (0-10), promoter/passive/detractor classification, verbatim feedback, survey wave identifier, and follow-up action status. Enables client satisfaction trending, at-risk account identification, and relationship health scoring.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`preference` (
    `preference_id` BIGINT COMMENT 'Unique surrogate identifier for each client preference record in the Databricks Silver Layer. Serves as the primary key for the client_preference data product.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser or agency-managed client account for whom these preferences are defined. Links to the master client record in the client domain.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Advertisers specify excluded audience segments in account preferences (e.g., competitor employees, sensitive demographics, brand safety exclusions). Operational requirement for respecting client targe',
    `client_contact_id` BIGINT COMMENT 'Reference to the specific client contact person for whom contact-level preferences are recorded. Nullable when preferences apply at the account level rather than an individual contact.',
    `approval_turnaround_days` STRING COMMENT 'Number of business days the client requires to review and approve submitted materials (creative, media plans, insertion orders). Used to set SLA expectations and project timelines in Workfront.',
    `approval_workflow_type` STRING COMMENT 'Defines the clients required approval workflow structure for creative assets, media plans, and campaign changes. Drives routing logic in Workfront project management and proofing modules.. Valid values are `single_approver|sequential|parallel|no_approval_required`',
    `audience_data_usage_allowed` BOOLEAN COMMENT 'Indicates whether the client permits the agency to use their first-party audience data for targeting, lookalike modelling, or cross-campaign analytics. Governs use of client data in DMP/CDP platforms.',
    `brand_safety_tier` STRING COMMENT 'Clients required brand safety classification level governing which content categories and environments are permissible for ad placement. strict applies the most restrictive exclusion lists; custom uses a client-defined inclusion/exclusion list. Configured in The Trade Desk and Google Campaign Manager 360.. Valid values are `standard|strict|custom`',
    `budget_alert_threshold_pct` DECIMAL(18,2) COMMENT 'Percentage of campaign budget consumption at which the agency should proactively alert the client. For example, a value of 80.00 means the client is notified when 80% of the approved budget has been spent.',
    `competitive_reporting_allowed` BOOLEAN COMMENT 'Indicates whether the client permits the agency to include their campaign data in aggregated competitive intelligence reports (e.g., Share of Voice analysis using Nielsen Ad Intel). Some clients restrict inclusion in benchmarking studies.',
    `consent_capture_timestamp` TIMESTAMP COMMENT 'The date and time at which the clients data sharing consent (GDPR/CCPA) was formally captured or last updated. Required for regulatory audit trails demonstrating lawful basis for data processing.',
    `consent_version` STRING COMMENT 'Version identifier of the consent notice or privacy policy under which the clients data sharing consent was obtained. Enables tracking of consent against specific policy versions for GDPR and CCPA compliance audits.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this client preference record was first created in the system. Provides the audit trail entry point for the record lifecycle.',
    `creative_approval_required` BOOLEAN COMMENT 'Indicates whether the client requires formal approval of all creative assets before trafficking and delivery. When true, creative assets must pass through the client approval workflow in Workfront before being trafficked in Google Campaign Manager 360.',
    `crm_record_code` STRING COMMENT 'The unique identifier of the corresponding client preference or contact record in Salesforce CRM (Sales Cloud or Service Cloud). Enables bidirectional synchronisation between the lakehouse Silver Layer and the operational CRM system.',
    `data_sharing_consent_ccpa` BOOLEAN COMMENT 'Indicates whether the client has opted in or out of data sharing under CCPA regulations. A value of false indicates the client has exercised their right to opt out of the sale or sharing of personal information.',
    `data_sharing_consent_gdpr` BOOLEAN COMMENT 'Indicates whether the client has provided consent for the agency to share their data with third-party partners and platforms under GDPR requirements. Must be captured and honoured for all clients operating in EU/EEA jurisdictions.',
    `effective_from` DATE COMMENT 'The date from which this preference record becomes active and should be applied to client engagement workflows. Supports temporal versioning of client preferences when preferences change over time.',
    `effective_until` DATE COMMENT 'The date on which this preference record expires or is superseded. Nullable for open-ended preferences. When populated, the system should apply the next active preference record after this date.',
    `fraud_verification_required` BOOLEAN COMMENT 'Indicates whether the client mandates third-party ad fraud verification (e.g., IAS, DoubleVerify, MOAT) on all programmatic and digital campaigns. When true, fraud verification tags must be applied in Google Campaign Manager 360 trafficking.',
    `invoice_delivery_method` STRING COMMENT 'Clients preferred method for receiving invoices and billing statements. Drives invoice dispatch workflows in SAP S/4HANA FI and Mediaocean Prisma billing modules.. Valid values are `email|postal|portal|edi`',
    `invoice_format` STRING COMMENT 'Preferred electronic or physical format for invoice documents. Supports structured e-invoicing standards (EDI X12, UBL) as well as traditional PDF and CSV formats per client procurement requirements.. Valid values are `pdf|xml|csv|edi_x12|ubl`',
    `io_approval_required` BOOLEAN COMMENT 'Indicates whether the client requires explicit approval of each Insertion Order (IO) before media commitments are finalized. Governs the IO sign-off workflow in Mediaocean Prisma.',
    `media_plan_approval_required` BOOLEAN COMMENT 'Indicates whether the client requires formal sign-off on media plans before buying activity commences. When true, media plans must be approved before Insertion Orders (IOs) are executed in Mediaocean Prisma.',
    `notes` STRING COMMENT 'Free-text field for account managers to capture nuanced client engagement preferences, special instructions, or contextual notes that cannot be expressed through structured fields (e.g., CEO prefers no calls before 10am, Client requires all reports in French regardless of campaign market).',
    `pacing_alert_enabled` BOOLEAN COMMENT 'Indicates whether the client has opted in to receive automated campaign pacing alerts when delivery is tracking significantly above or below the planned schedule. Drives alert configuration in The Trade Desk and Google Campaign Manager 360.',
    `preference_scope` STRING COMMENT 'Indicates whether this preference record applies at the advertiser account level or at an individual contact level. Drives how the preference is applied during client engagement workflows.. Valid values are `account|contact`',
    `preference_status` STRING COMMENT 'Current lifecycle status of this preference record. active means the preference is in force; superseded means a newer record has replaced it; pending_review means awaiting client confirmation.. Valid values are `active|inactive|pending_review|superseded`',
    `preferred_communication_channel` STRING COMMENT 'The clients preferred channel for day-to-day agency communications, including status updates, approvals, and general correspondence. Used by account management teams to route outreach appropriately.. Valid values are `email|phone|video_call|in_person|portal|slack`',
    `preferred_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code representing the clients preferred billing and reporting currency (e.g., USD, EUR, GBP). Used in SAP S/4HANA FI and Mediaocean Prisma for invoice generation and budget reporting.. Valid values are `^[A-Z]{3}$`',
    `preferred_dsp` STRING COMMENT 'The clients preferred or mandated Demand-Side Platform (DSP) for programmatic media buying (e.g., The Trade Desk, DV360, Amazon DSP). Governs platform selection during media planning in Mediaocean Prisma.',
    `preferred_kpi_set` STRING COMMENT 'Comma-separated list or named KPI template identifying the clients primary campaign performance metrics for reporting (e.g., CTR,CPA,ROAS,VTR). Drives default dashboard configuration and report templates. [ENUM-REF-CANDIDATE: CTR|CPA|ROAS|VTR|CPM|CPC|GRP|TRP|SOV|ROI — promote to reference product]',
    `preferred_language_code` STRING COMMENT 'IETF BCP 47 language tag representing the clients preferred language for all agency communications, reports, and documents (e.g., en-US, fr-FR, de-DE). Enables localized service delivery.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `preferred_meeting_format` STRING COMMENT 'Clients preferred format for scheduled meetings such as Quarterly Business Reviews (QBRs), campaign briefings, and creative reviews. Informs account team logistics planning.. Valid values are `in_person|virtual|hybrid`',
    `preferred_timezone` STRING COMMENT 'IANA time zone identifier representing the clients local time zone (e.g., America/New_York, Europe/London). Used to schedule meetings, report delivery, and campaign flight times in the clients local context.',
    `report_delivery_channel` STRING COMMENT 'The channel through which campaign performance reports and analytics outputs are delivered to the client. Supports automated distribution via email, client portal, API push, or SFTP file transfer.. Valid values are `email|portal|api|sftp`',
    `report_format` STRING COMMENT 'Preferred file or presentation format for campaign performance reports delivered to the client. Ensures reports are produced in the format the clients team can consume most efficiently.. Valid values are `pdf|excel|csv|dashboard_link|pptx`',
    `reporting_cadence` STRING COMMENT 'Frequency at which the client expects to receive campaign performance reports and analytics dashboards. Drives automated report scheduling in Google Campaign Manager 360 and internal analytics platforms.. Valid values are `daily|weekly|bi_weekly|monthly|quarterly`',
    `third_party_data_sharing_allowed` BOOLEAN COMMENT 'Indicates whether the client permits the agency to share campaign data, audience segments, or performance data with third-party vendors such as DSPs, DMPs, or CDPs. Governs data flows to platforms like The Trade Desk.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this client preference record was most recently modified. Used for change tracking, synchronisation with Salesforce CRM, and audit compliance.',
    `viewability_standard` STRING COMMENT 'The viewability measurement standard the client requires for campaign reporting and buying guarantees. mrc applies MRC viewability definitions; groupm applies GroupMs elevated viewability thresholds; custom uses client-negotiated thresholds.. Valid values are `mrc|groupm|custom`',
    CONSTRAINT pk_preference PRIMARY KEY(`preference_id`)
) COMMENT 'Stores advertiser-level and contact-level preferences governing how the agency engages with the client — including preferred communication channels, reporting cadence, invoice delivery method, language preference, currency preference, time zone, approval workflow preferences, and data sharing consent flags (GDPR/CCPA). Enables personalized service delivery and compliance with client-specific engagement protocols.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`competitive_conflict` (
    `competitive_conflict_id` BIGINT COMMENT 'Unique system-generated identifier for each competitive conflict declaration record. Primary key for the competitive_conflict data product.',
    `advertiser_id` BIGINT COMMENT 'Reference to the first advertiser (incumbent client) in the competitive conflict pair. Typically the existing Agency of Record (AOR) client whose category exclusivity may be at risk.',
    `worker_id` BIGINT COMMENT 'Reference to the account director responsible for managing and resolving this competitive conflict. This individual is accountable for client communications, resolution implementation, and board-level escalation as required.',
    `task_id` BIGINT COMMENT 'Reference to the Workfront project management task or work item tracking the resolution activities for this competitive conflict. Links conflict management to the agencys project management and resource planning workflows.',
    `aor_contract_clause` STRING COMMENT 'Reference to the specific clause(s) in the Agency of Record (AOR) contract(s) that govern competitive conflict obligations for this declaration. Used by legal and account management teams to assess contractual exposure and resolution requirements.',
    `board_approval_reference` STRING COMMENT 'Reference number or identifier for the board-level or senior leadership approval document authorizing the selected resolution approach. Required for critical severity conflicts and account resignations. Links to governance documentation in the agencys document management system.',
    `client_a_notification_date` DATE COMMENT 'The date on which Advertiser A (the incumbent client) was formally notified of the competitive conflict declaration. Required for AOR compliance and contractual notification obligations.',
    `client_a_waiver_date` DATE COMMENT 'The date on which Advertiser A formally granted a written waiver accepting the agencys representation of the competing Advertiser B. Null if no waiver was granted or if resolution_approach is not client_waiver.',
    `client_b_notification_date` DATE COMMENT 'The date on which Advertiser B (the challenger or prospective client) was formally notified of the competitive conflict declaration. Required for new business pitch eligibility screening and AOR compliance.',
    `client_b_waiver_date` DATE COMMENT 'The date on which Advertiser B formally granted a written waiver accepting the agencys representation of the competing Advertiser A. Null if no waiver was granted or if resolution_approach is not client_waiver.',
    `conflict_description` STRING COMMENT 'Detailed narrative description of the competitive conflict, including the specific products, services, or campaigns that create the conflict, the business rationale for the conflict classification, and any relevant context for resolution decision-making. Classified as confidential due to sensitive client business information.',
    `conflict_reference_code` STRING COMMENT 'Externally-known alphanumeric reference code assigned to this conflict declaration, used in correspondence with clients, legal counsel, and board-level approval documentation. Format: CC-{YYYY}-{NNNNNN}.. Valid values are `^CC-[0-9]{4}-[0-9]{6}$`',
    `conflict_severity` STRING COMMENT 'Business-assessed severity level of the competitive conflict, used to prioritize resolution actions and escalation paths. critical typically requires board-level approval or account resignation; high requires senior leadership review; medium may be resolved via information barriers; low may be managed with standard team separation.. Valid values are `critical|high|medium|low`',
    `conflict_status` STRING COMMENT 'Current lifecycle status of the competitive conflict declaration. declared indicates newly identified conflict; under_review indicates active assessment in progress; resolved indicates a resolution approach has been implemented; waived indicates client has granted a formal waiver; escalated indicates board-level or legal escalation; expired indicates the conflict review period has lapsed without resolution.. Valid values are `declared|under_review|resolved|waived|escalated|expired`',
    `conflict_type` STRING COMMENT 'Classification of the nature of the competitive conflict between the two advertiser accounts. direct_competitor indicates brands competing for the same customers in the same category; indirect_adjacent indicates brands in adjacent categories with overlapping audiences; category_overlap indicates partial product category overlap; channel_overlap indicates conflict limited to specific media channels; geographic_overlap indicates conflict limited to specific geographic markets. [ENUM-REF-CANDIDATE: direct_competitor|indirect_adjacent|category_overlap|channel_overlap|geographic_overlap — promote to reference product]. Valid values are `direct_competitor|indirect_adjacent|category_overlap|channel_overlap|geographic_overlap`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this competitive conflict record was first created in the system. Provides the audit trail entry point for the conflict declaration lifecycle.',
    `crm_record_code` STRING COMMENT 'The unique record identifier from Salesforce CRM (Sales Cloud) where this competitive conflict is tracked as part of the account management and client services workflow. Enables traceability between the lakehouse silver layer and the operational system of record.',
    `declaration_date` DATE COMMENT 'The date on which the competitive conflict was formally declared and entered into the agencys conflict management system. Serves as the start of the conflict review clock for AOR compliance and E&O insurance purposes.',
    `declaring_party` STRING COMMENT 'The party who formally identified and declared the competitive conflict. agency indicates internal agency conflict screening; client_a or client_b indicates the conflict was raised by one of the affected advertisers; legal_counsel indicates identification by agency legal team; new_business_team indicates identification during pitch eligibility screening.. Valid values are `agency|client_a|client_b|legal_counsel|new_business_team`',
    `eo_insurance_notified` BOOLEAN COMMENT 'Indicates whether the agencys Errors and Omissions (E&O) insurance carrier has been formally notified of this competitive conflict declaration. Required for high and critical severity conflicts to preserve insurance coverage.',
    `geographic_markets` STRING COMMENT 'Comma-separated list of specific country codes (ISO 3166-1 alpha-3) or market identifiers where the competitive conflict applies when geographic_scope is regional, national, or local. Example: USA,CAN,GBR. Null when geographic_scope is global.',
    `geographic_scope` STRING COMMENT 'The geographic extent of the competitive conflict. global indicates the conflict applies across all markets; regional indicates conflict is limited to a multi-country region; national indicates conflict is limited to a single country; local indicates conflict is limited to specific cities or DMAs (Designated Market Areas).. Valid values are `global|regional|national|local`',
    `iab_category_code` STRING COMMENT 'Product category code from the IAB Content Taxonomy (e.g., IAB2 for Automotive, IAB9-30 for Video Games) that defines the competitive product category in which the conflict exists. Enables standardized category-level conflict screening across the agency portfolio.. Valid values are `^IAB[0-9]{1,2}(-[0-9]{1,3})?$`',
    `iab_category_name` STRING COMMENT 'Human-readable name of the IAB content taxonomy category corresponding to iab_category_code (e.g., Automotive, Consumer Electronics). Provides business-friendly label for reporting and conflict screening dashboards.',
    `information_barrier_implemented` BOOLEAN COMMENT 'Indicates whether a formal information barrier (Chinese wall) has been implemented between the account teams serving the two conflicting advertisers. True when system access controls, physical separation, and data governance protocols are in place per the resolution approach.',
    `legal_review_date` DATE COMMENT 'The date on which the agencys legal counsel completed their formal review of the competitive conflict and provided a written opinion or clearance. Null if legal_review_required is False or review is still in progress.',
    `legal_review_required` BOOLEAN COMMENT 'Indicates whether this competitive conflict requires formal review by the agencys legal counsel before a resolution approach can be approved. Typically set to True for critical severity conflicts, account resignations, or conflicts involving active litigation.',
    `next_review_date` DATE COMMENT 'The date on which this competitive conflict declaration is next scheduled for formal review by the account director and relevant stakeholders. Supports ongoing monitoring of resolved conflicts and ensures timely renewal or closure of conflict records.',
    `pitch_eligibility_blocked` BOOLEAN COMMENT 'Indicates whether this active competitive conflict blocks the agency from participating in new business pitches involving either of the conflicting advertiser categories. True when the conflict is unresolved and pitch participation would violate AOR obligations or client contracts.',
    `resolution_approach` STRING COMMENT 'The approved method selected to manage or resolve the competitive conflict. chinese_wall (information barrier) restricts data and personnel access between account teams; client_waiver indicates the affected client has formally waived the conflict; account_resignation indicates the agency will resign one of the conflicting accounts; category_carve_out limits the agencys scope for one client to exclude the conflicting category; team_separation establishes dedicated, non-overlapping account teams.. Valid values are `chinese_wall|client_waiver|account_resignation|category_carve_out|team_separation`',
    `resolution_date` DATE COMMENT 'The date on which the competitive conflict was formally resolved, a waiver was granted, or an account resignation was executed. Null if the conflict is still under review or declared but unresolved.',
    `resolution_notes` STRING COMMENT 'Free-text notes documenting the resolution process, key decisions, client communications, and any conditions or limitations attached to the approved resolution approach. Classified as confidential due to sensitive client and legal information.',
    `review_expiry_date` DATE COMMENT 'The date by which the conflict declaration must be reviewed, renewed, or formally closed. Used to trigger automated review reminders and ensure ongoing AOR compliance. Typically set 12 months from declaration_date or per client contract terms.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this competitive conflict record was most recently modified. Tracks the latest update to any field in the conflict declaration, supporting audit trail and data lineage requirements.',
    CONSTRAINT pk_competitive_conflict PRIMARY KEY(`competitive_conflict_id`)
) COMMENT 'Tracks competitive conflict declarations between advertiser accounts — identifying situations where the agency serves competing brands in the same product category or market. Captures conflicting advertiser pair (both advertiser references), product category (using IAB content taxonomy), conflict type (direct competitor, indirect/adjacent, category overlap), geographic scope of conflict, declaration date, declaring party, resolution approach (Chinese wall/information barrier, client waiver, account resignation, category carve-out, team separation), resolution status, responsible account director, board-level approval reference, and review/expiry date. Critical for AOR compliance, new business pitch eligibility screening, ethical account management, and agency E&O insurance requirements.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`revenue_target` (
    `revenue_target_id` BIGINT COMMENT 'Unique surrogate identifier for each client revenue target record in the silver layer lakehouse. Primary key for this entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser account for which this revenue target is set. Links to the client.advertiser master record.',
    `worker_id` BIGINT COMMENT 'Reference to the employee (typically a Managing Director or Finance Business Partner) who approved this revenue target. Supports audit trail and governance requirements for P&L sign-off.',
    `client_brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Revenue targets in advertising agencies are frequently set at brand level within advertiser accounts, not just advertiser-level. Enables brand-specific revenue forecasting, pipeline management, accoun',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Revenue targets drive budget allocation decisions and resource planning. Account directors set client revenue targets that inform budget approvals, headcount planning, and investment decisions for cli',
    `primary_revenue_worker_id` BIGINT COMMENT 'Reference to the account director or senior account manager who owns and is accountable for achieving this revenue target. Used for performance management, QBR accountability, and Workday HCM talent performance review alignment.',
    `account_growth_rate_pct` DECIMAL(18,2) COMMENT 'The year-over-year or period-over-period percentage growth rate embedded in this target relative to the prior comparable periods target. Expressed as a decimal (e.g., 0.1500 = 15%). Used in account growth planning and QBR target-setting rationale.',
    `approval_date` DATE COMMENT 'The date on which the revenue target was formally approved by the designated approver. Marks the transition from pending_approval to approved status and is used in audit trails for P&L governance.',
    `confidence_level` STRING COMMENT 'Account teams assessed confidence in achieving this revenue target: high (strong pipeline, contracted SOW coverage), medium (pipeline in progress, partial SOW coverage), low (speculative, dependent on new business wins). Used in risk-adjusted P&L forecasting.. Valid values are `high|medium|low`',
    `contracted_sow_coverage_pct` DECIMAL(18,2) COMMENT 'The proportion of the revenue target already covered by signed Statements of Work (SOW) or Insertion Orders (IO) at the time of target setting or last update. Expressed as a decimal (e.g., 0.6500 = 65%). Supports pipeline risk assessment and P&L confidence scoring.',
    `cost_centre_code` STRING COMMENT 'SAP S/4HANA CO cost centre code to which this revenue target is allocated for internal P&L management and financial reporting. Enables drill-down from agency-level P&L to individual account team cost centres.. Valid values are `^CC-[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this revenue target record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides the audit trail creation anchor for data lineage and governance.',
    `crm_opportunity_code` STRING COMMENT 'The Salesforce CRM Sales Cloud Opportunity record ID linked to this revenue target, where the target originates from or is tracked against a specific sales opportunity. Enables traceability from target to pipeline to closed-won revenue.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the target_amount is denominated (e.g., USD, GBP, EUR). Supports multi-currency advertiser portfolios and cross-market P&L consolidation.. Valid values are `^[A-Z]{3}$`',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter to which this target applies (Q1–Q4). Populated when target_period_type is quarterly; null for annual targets. Used in QBR preparation and quarterly pacing analysis.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'The four-digit fiscal year to which this revenue target applies (e.g., 2025). Aligns with the SAP S/4HANA FI fiscal year calendar for P&L management and budget reconciliation.',
    `fx_rate_applied` DECIMAL(18,2) COMMENT 'The exchange rate used to convert target_amount to target_amount_usd at the time of target creation or last revision. Stored for auditability and variance analysis when FX rates fluctuate during the target period.',
    `is_stretch_target` BOOLEAN COMMENT 'Indicates whether this target is designated as a stretch (aspirational) target above the base committed target. True = stretch target used for incentive compensation modelling; False = base committed target used for P&L planning. Supports Workday HCM talent performance review and bonus calculation.',
    `notes` STRING COMMENT 'Free-text field for account team commentary on the revenue target, including assumptions, dependencies, client commitments, or QBR talking points. Not used for structured data; supports qualitative context in account growth planning.',
    `original_target_amount` DECIMAL(18,2) COMMENT 'The initial revenue target amount set at the start of the period before any revisions. Preserved for variance analysis comparing original plan vs. revised plan vs. actual billed revenue. Populated only when revision_number > 0.',
    `period_end_date` DATE COMMENT 'The calendar date on which the revenue target period ends. Defines the boundary for target attainment measurement and QBR reporting cycles.',
    `period_start_date` DATE COMMENT 'The calendar date on which the revenue target period begins. Used to align target pacing with actual billed revenue from the finance domain and to support time-series analytics.',
    `pipeline_amount` DECIMAL(18,2) COMMENT 'The total value of identified but not yet contracted revenue opportunities in the Salesforce CRM pipeline that are expected to contribute to this target. Distinct from target_amount (the committed plan) and actual billed revenue. Supports gap-to-target analysis.',
    `profit_centre_code` STRING COMMENT 'SAP S/4HANA CO profit centre code associated with this revenue target, enabling segment-level P&L reporting by business unit, geography, or service line. Supports EBITDA reporting and management accounting.. Valid values are `^PC-[A-Z0-9]{4,10}$`',
    `revision_number` STRING COMMENT 'Sequential integer indicating how many times this revenue target has been revised (0 = original). Enables version tracking of target changes throughout the fiscal period, supporting variance analysis between original and revised targets.',
    `revision_reason` STRING COMMENT 'Free-text explanation for why the revenue target was revised (e.g., client budget reduction, scope expansion, new service line added, market conditions). Supports QBR narrative and P&L variance commentary.',
    `roas_target` DECIMAL(18,2) COMMENT 'The target Return on Ad Spend (ROAS) ratio associated with this revenue target, where applicable (primarily for performance-based media service lines). Expressed as a multiplier (e.g., 4.0000 = $4 revenue per $1 ad spend). Used in digital performance optimization and KPI alignment with The Trade Desk programmatic buying.',
    `service_line` STRING COMMENT 'The agency service line to which this revenue target is attributed: media (Media Planning and Buying), creative (Creative Development and Production), digital (Digital Marketing and Performance Optimization), pr (Public Relations and Communications), analytics (Data Analytics and Audience Insights), strategy (Brand Strategy and Positioning). Enables service-line-level P&L reporting.. Valid values are `media|creative|digital|pr|analytics|strategy`',
    `target_amount` DECIMAL(18,2) COMMENT 'The gross or net revenue target value set for the advertiser account for the specified period and service line, expressed in the currency defined by currency_code. This is the planned figure; actual billed revenue is owned by the finance domain. Core input for P&L management and account growth planning.',
    `target_amount_usd` DECIMAL(18,2) COMMENT 'The revenue target amount converted to US Dollars (USD) using the exchange rate applied at the time of target setting. Enables cross-currency portfolio aggregation and global P&L reporting without requiring runtime FX conversion.',
    `target_code` STRING COMMENT 'Externally-known alphanumeric business identifier for this revenue target record, used in Quarterly Business Review (QBR) reporting, P&L management, and cross-system reconciliation with SAP S/4HANA CO module.. Valid values are `^RT-[A-Z0-9]{4,12}$`',
    `target_name` STRING COMMENT 'Human-readable label for this revenue target, typically combining the advertiser name, service line, and target period (e.g., Acme Corp — Media — FY2025 Q1). Used in QBR decks and account growth planning documents.',
    `target_owner_name` STRING COMMENT 'Display name of the account director or account manager who owns this revenue target. Stored denormalized for reporting convenience in QBR decks and P&L dashboards without requiring a join to the talent domain.',
    `target_period_type` STRING COMMENT 'Granularity of the target period: annual (full fiscal year), quarterly (fiscal quarter), or monthly (calendar month). Determines how the target_amount is interpreted and how actuals are paced against it in QBR reporting.. Valid values are `annual|quarterly|monthly`',
    `target_setting_method` STRING COMMENT 'The methodology used to derive this revenue target: top_down (allocated from agency-level P&L plan), bottom_up (built from individual campaign and SOW estimates), negotiated (agreed bilaterally with client), market_indexed (benchmarked against market growth indices such as Nielsen Ad Intel competitive data).. Valid values are `top_down|bottom_up|negotiated|market_indexed`',
    `target_status` STRING COMMENT 'Current lifecycle state of the revenue target record. draft: being authored; pending_approval: submitted for sign-off; approved: signed off by account director and finance; active: in-period and being tracked; revised: superseded by a revised target; closed: period ended; cancelled: target withdrawn. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|revised|closed|cancelled — promote to reference product]',
    `target_type` STRING COMMENT 'Classification of the revenue target by income recognition method: gross_revenue (total billings before agency commission deduction), net_revenue (billings net of media costs), fee_income (project or retainer fees), commission_income (media commission earned), retainer_fee (recurring fixed-fee arrangement). Drives P&L line allocation in SAP S/4HANA FI.. Valid values are `gross_revenue|net_revenue|fee_income|commission_income|retainer_fee`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent modification to this revenue target record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change detection in ETL pipelines and audit trail completeness.',
    CONSTRAINT pk_revenue_target PRIMARY KEY(`revenue_target_id`)
) COMMENT 'Annual and quarterly revenue targets set for each advertiser account, broken down by service line (media, creative, digital, PR). Captures target period, target amount, currency, service line, target type (gross revenue, net revenue, fee income), target owner (account director), and target status. Supports P&L management, QBR preparation, and account growth planning. Distinct from actual billed revenue owned by the finance domain.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`client_consent_record` (
    `client_consent_record_id` BIGINT COMMENT 'Unique surrogate identifier for each client consent record in the advertising platform. Primary key for the client_consent_record data product.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser organisation whose consent record this is. Links to the client.advertiser master entity.',
    `client_contact_id` BIGINT COMMENT 'Reference to the individual contact (person) at the advertiser organisation who provided or withdrew consent. Supports GDPR data subject rights management.',
    `ccpa_applicable` BOOLEAN COMMENT 'Indicates whether CCPA/CPRA applies to this consent record based on the data subjects California residency or the processing context. True if CCPA obligations apply; False otherwise. Drives CCPA-specific opt-out and data deletion workflows.',
    `consent_basis` STRING COMMENT 'The legal basis under which consent or data processing is justified. Maps to GDPR Article 6 lawful bases (consent, legitimate interest, contract performance) or CCPA opt-out/opt-in mechanisms, or CAN-SPAM compliance. Drives regulatory reporting and audit obligations.. Valid values are `gdpr_art6_consent|gdpr_art6_legitimate_interest|gdpr_art6_contract|ccpa_opt_out|ccpa_opt_in|can_spam`',
    `consent_channel` STRING COMMENT 'The channel or interface through which consent was captured or recorded. Supports audit trail requirements and channel-specific compliance obligations (e.g., GDPR Article 7 demonstrability). [ENUM-REF-CANDIDATE: web_form|email|crm_portal|paper|api|phone|in_person — promote to reference product if additional channels are required]',
    `consent_date` TIMESTAMP COMMENT 'The precise date and time (with timezone offset) at which the data subject provided consent or the consent record was first captured. This is the principal business event timestamp for the consent lifecycle. Required for GDPR Article 7 demonstrability.',
    `consent_proof_reference` STRING COMMENT 'Reference identifier or URL pointing to the stored evidence of consent (e.g., screenshot of consent form, signed document ID in DAM, email confirmation message ID, API request log ID). Required for GDPR Article 7(1) demonstrability. May reference a Workfront DAM asset or document management system record.',
    `consent_reference_number` STRING COMMENT 'Externally-visible alphanumeric reference number assigned to this consent record, used in regulatory correspondence, audit trails, and data subject access requests. Format: CNS- followed by 8–16 alphanumeric characters.. Valid values are `^CNS-[A-Z0-9]{8,16}$`',
    `consent_status` STRING COMMENT 'Current lifecycle state of the consent record. Active indicates valid consent in force; withdrawn indicates the data subject has revoked consent; expired indicates the consent has passed its expiry date; pending indicates awaiting confirmation; refused indicates the data subject explicitly declined.. Valid values are `active|withdrawn|expired|pending|refused`',
    `consent_type` STRING COMMENT 'Classification of the specific consent category captured. Distinguishes between marketing communications consent, data processing consent, third-party data sharing consent, profiling, retargeting, and analytics use. [ENUM-REF-CANDIDATE: marketing_communications|data_processing|third_party_sharing|profiling|retargeting|analytics — promote to reference product if additional types are required]. Valid values are `marketing_communications|data_processing|third_party_sharing|profiling|retargeting|analytics`',
    `consent_version` STRING COMMENT 'Version identifier of the privacy notice, consent form, or cookie banner under which this consent was obtained (e.g., v1.0, v2.3). Enables tracking of consent obtained under different notice versions for regulatory audit and re-consent workflows when notices are updated.. Valid values are `^v[0-9]+.[0-9]+$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this consent record was first created in the system. Audit field supporting data lineage, regulatory demonstrability, and GDPR Article 7 record-keeping obligations.',
    `crm_consent_record_code` STRING COMMENT 'The native record identifier for this consent record in Salesforce CRM (Marketing Cloud or Service Cloud). Enables bi-directional synchronisation between the lakehouse silver layer and the operational CRM system of record for consent management.',
    `data_categories_covered` STRING COMMENT 'Comma-separated list or structured description of the personal data categories covered by this consent record (e.g., email address, browsing behaviour, device identifiers, location data). Required for GDPR Article 13/14 transparency and maps to IAB TCF data category definitions.',
    `data_subject_jurisdiction` STRING COMMENT 'ISO 3166-1 alpha-2 or alpha-3 country code representing the jurisdiction of the data subject at the time consent was captured. Determines which regulatory framework (GDPR, CCPA, LGPD, PIPEDA, etc.) governs this consent record and associated data processing obligations.. Valid values are `^[A-Z]{2,3}$`',
    `double_opt_in_confirmed` BOOLEAN COMMENT 'Indicates whether the consent was confirmed via a double opt-in mechanism (e.g., email confirmation link clicked). True if double opt-in confirmation was received. Provides stronger demonstrability of consent under GDPR Article 7 and is required for certain marketing communication channels.',
    `double_opt_in_date` TIMESTAMP COMMENT 'The precise date and time at which the double opt-in confirmation was received (e.g., confirmation link clicked). Null if double opt-in was not used or not yet confirmed. Supports audit trail for GDPR Article 7 demonstrability.',
    `effective_from` DATE COMMENT 'The date from which this consent record becomes operationally effective and data processing under this consent may commence. May differ from consent_date if there is a confirmation or cooling-off period.',
    `expiry_date` DATE COMMENT 'The date on which this consent record expires and must be renewed or re-confirmed. Null indicates open-ended consent with no defined expiry. Supports periodic consent refresh workflows mandated by GDPR best practice and IAB TCF guidelines.',
    `gdpr_applicable` BOOLEAN COMMENT 'Indicates whether GDPR applies to this consent record based on the data subjects jurisdiction or the processing context. True if GDPR obligations apply; False otherwise. Drives GDPR-specific processing rules and data subject rights workflows.',
    `iab_tcf_consent_string` STRING COMMENT 'The encoded IAB TCF v2.2 consent string representing the data subjects vendor and purpose consent selections. Used by DSPs, SSPs, and DMPs to enforce consent downstream in programmatic advertising supply chains. Null for non-digital or non-programmatic consent records.',
    `iab_tcf_version` STRING COMMENT 'Version of the IAB Transparency and Consent Framework under which the TCF consent string was generated. Required for correct decoding and downstream enforcement of the consent string in programmatic advertising systems.. Valid values are `1.1|2.0|2.1|2.2`',
    `ip_address` STRING COMMENT 'IP address of the device from which consent was captured (for digital channels). Used as part of the consent audit trail to demonstrate the origin of consent. Classified as confidential PII as IP addresses may identify individuals in certain jurisdictions under GDPR.',
    `notes` STRING COMMENT 'Free-text field for additional context, annotations, or operational notes related to this consent record. May include details of regulatory correspondence, data subject access request references, or account management observations. Not used for structured data.',
    `opt_in_flag` BOOLEAN COMMENT 'Indicates whether the consent record represents an affirmative opt-in (True) or an opt-out election (False). Distinguishes between opt-in consent models (GDPR default) and opt-out models (CCPA default). Critical for determining permissible data processing activities.',
    `privacy_notice_url` STRING COMMENT 'URL of the privacy notice or consent form presented to the data subject at the time consent was captured. Provides an auditable link to the exact notice version shown, supporting GDPR Article 13/14 transparency and demonstrability requirements.. Valid values are `^https?://.+`',
    `processing_purpose` STRING COMMENT 'Specific, granular description of the data processing activity for which consent was obtained, as required by GDPR Article 13/14 transparency obligations. Examples include: Delivery of targeted programmatic advertising via DSP, Audience segmentation for lookalike modelling, Cross-channel attribution reporting. Free-text field aligned to the IAB TCF purpose taxonomy.',
    `renewal_reminder_sent_date` DATE COMMENT 'Date on which the most recent consent renewal reminder communication was sent to the data subject. Supports consent lifecycle management workflows and prevents inadvertent processing of expired consent.',
    `renewal_required` BOOLEAN COMMENT 'Indicates whether this consent record requires active renewal before the expiry_date. True triggers automated re-consent workflow in Salesforce Marketing Cloud. Supports proactive consent lifecycle management to prevent lapses in permissible data processing.',
    `suppression_list_flag` BOOLEAN COMMENT 'Indicates whether this contact/advertiser is currently on a marketing suppression list as a result of this consent record (e.g., following opt-out or withdrawal). True means the contact must be excluded from all marketing communications. Enforced in Salesforce Marketing Cloud and campaign execution systems.',
    `third_party_vendor_name` STRING COMMENT 'Name of the third-party vendor or partner organisation with whom data may be shared under this consent record (applicable when consent_type is third_party_sharing). Supports IAB TCF vendor list alignment and GDPR Article 28 data processor obligations.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this consent record was most recently modified. Supports audit trail requirements and change detection for downstream consent enforcement systems.',
    `user_agent` STRING COMMENT 'Browser or application user-agent string recorded at the time of digital consent capture. Supports audit trail completeness and fraud detection for consent records. Null for non-digital consent channels.',
    `withdrawal_date` DATE COMMENT 'The date on which the data subject withdrew or revoked their consent. Null if consent has not been withdrawn. When populated, downstream data processing activities must cease within the regulatory timeframe. Required for GDPR Article 7(3) compliance.',
    `withdrawal_reason` STRING COMMENT 'Categorised reason for the withdrawal of consent. Supports root-cause analysis of consent churn, regulatory reporting, and CRM-driven re-engagement eligibility assessments.. Valid values are `data_subject_request|regulatory_order|account_closure|preference_change|unsubscribe|other`',
    CONSTRAINT pk_client_consent_record PRIMARY KEY(`client_consent_record_id`)
) COMMENT 'Authoritative record of data privacy consents and opt-in/opt-out elections captured from client contacts and advertiser organizations. Tracks consent type (marketing communications, data processing, third-party sharing), consent basis (GDPR Article 6, CCPA opt-out), consent date, expiry date, consent channel, withdrawal date, and the specific data processing purpose. Ensures regulatory compliance with GDPR, CCPA, and applicable advertising privacy standards.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`relationship_history` (
    `relationship_history_id` BIGINT COMMENT 'Unique surrogate identifier for each immutable relationship history event record. Primary key of this append-only audit log.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser (client) whose agency-client relationship this event pertains to. Links to the client.advertiser master record.',
    `agency_relationship_id` BIGINT COMMENT 'Foreign key linking to client.agency_relationship. Business justification: relationship_history is described as Immutable historical log of significant changes to the agency-client relationship — including AOR wins, scope changes, status transitions. These events directly ',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Relationship events (pitch wins, escalations, AOR reviews, contract renewals) often reference the specific project/initiative that triggered them. Essential for understanding project impact on client ',
    `worker_id` BIGINT COMMENT 'The system user identifier (Salesforce CRM user ID or Workfront user ID) of the individual who initiated or recorded this relationship event. Provides accountability and audit trail for relationship lifecycle changes.',
    `account_team_lead_name` STRING COMMENT 'Full name of the lead account director or client partner at the time of this event. Stored for human-readable reporting and QBR documentation without requiring a join to talent systems.',
    `aor_scope` STRING COMMENT 'Describes the specific channels, disciplines, or service lines covered by the Agency of Record (AOR) mandate at the time of this event (e.g., Digital, Social, OOH). Relevant for AOR win, loss, expansion, and reduction event types.',
    `client_contact_name` STRING COMMENT 'Full name of the primary client-side contact involved in or notified of this relationship event (e.g., the CMO who signed off on an AOR award). Supports relationship continuity tracking when client-side personnel change.',
    `client_contact_title` STRING COMMENT 'Job title of the primary client-side contact involved in this relationship event (e.g., Chief Marketing Officer, VP of Marketing). Provides seniority context for relationship event significance assessment.',
    `competing_agency_name` STRING COMMENT 'Name of the competing agency involved in a pitch or competitive review associated with this relationship event. Populated when competitive_review_flag is True. Supports competitive intelligence and win/loss analysis.',
    `competitive_review_flag` BOOLEAN COMMENT 'Indicates whether this relationship event is associated with a formal competitive agency review or pitch process (True). Enables tracking of accounts under competitive threat and supports win/loss analysis.',
    `contract_reference` STRING COMMENT 'The contract or Statement of Work (SOW) reference number associated with this relationship event. Links the history record to the formal contractual instrument in SAP S/4HANA or Mediaocean Prisma.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this relationship history record was first created in the data platform. Immutable audit field — this record is append-only and this timestamp never changes after initial insert.',
    `crm_opportunity_code` STRING COMMENT 'Salesforce CRM Opportunity record identifier associated with this relationship event, such as an Agency of Record (AOR) win or pitch outcome. Enables traceability back to the originating CRM pipeline record.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this relationship event represents or was triggered by a formal client escalation (True) or is a routine relationship update (False). Enables rapid filtering of escalation events for executive review and risk management.',
    `escalation_severity` STRING COMMENT 'Severity classification of the escalation when escalation_flag is True. Drives prioritisation of executive response and account recovery actions. Null when escalation_flag is False.. Valid values are `low|medium|high|critical`',
    `estimated_revenue_impact` DECIMAL(18,2) COMMENT 'The estimated annual revenue impact (positive or negative) on the agency resulting from this relationship event, expressed in the clients preferred currency. Used for P&L forecasting and executive pipeline reporting. Positive values indicate revenue gain; negative values indicate revenue loss.',
    `event_date` DATE COMMENT 'The business date on which the relationship event occurred or was formally recognised (e.g., the date an AOR contract was signed, the date a scope change was approved). Distinct from the record creation timestamp.',
    `event_narrative` STRING COMMENT 'Detailed free-text notes authored by the account team or executive sponsor describing the circumstances, rationale, and business context of the relationship event. Supports Quarterly Business Review (QBR) documentation and institutional knowledge retention.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time (with timezone offset) at which the relationship event was recorded in the system. Supports audit trail requirements and event sequencing within the same calendar day.',
    `event_type` STRING COMMENT 'Categorises the nature of the significant relationship event being recorded. Drives downstream reporting and executive dashboards. [ENUM-REF-CANDIDATE: aor_win|aor_loss|scope_expansion|scope_reduction|contract_renewal|account_team_change|escalation|relationship_status_change — promote to reference product]',
    `io_reference` STRING COMMENT 'The Insertion Order (IO) number associated with this relationship event where the event is linked to a specific media buy or campaign commitment. Relevant for scope change and contract renewal events.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether this relationship history event is classified as confidential and should be restricted to senior leadership only (True). Supports row-level security enforcement for sensitive events such as AOR losses or executive escalations.',
    `new_state_description` STRING COMMENT 'Free-text narrative describing the new state of the relationship, scope, team composition, or contract terms after this event. Provides the post-event context for executive reporting and QBR preparation.',
    `new_status` STRING COMMENT 'The relationship status of the client account immediately after this event was applied. Together with previous_status, provides a complete state transition record for lifecycle management.. Valid values are `prospect|active|at_risk|on_hold|churned|inactive`',
    `nps_score` STRING COMMENT 'The Net Promoter Score (NPS) recorded from the client at or near the time of this relationship event, on the standard -100 to +100 scale. Provides a quantitative client satisfaction signal to complement the qualitative event narrative.',
    `previous_state_description` STRING COMMENT 'Free-text narrative describing the prior state of the relationship, scope, team composition, or contract terms before this event. Captures contextual detail beyond the structured status field (e.g., AOR for digital and social channels only).',
    `previous_status` STRING COMMENT 'The relationship status of the client account immediately before this event was triggered. Enables before/after state comparison for lifecycle analysis and executive reporting.. Valid values are `prospect|active|at_risk|on_hold|churned|inactive`',
    `relationship_health_score` STRING COMMENT 'A numeric score (typically 1–10) representing the assessed health of the client relationship at the time of this event, as recorded by the account team. Supports at-risk client identification and proactive retention strategies. Not a calculated metric — this is the human-assessed score captured at event time.',
    `resolution_date` DATE COMMENT 'The date on which an escalation or at-risk relationship event was formally resolved or closed. Null for non-escalation events or unresolved escalations. Enables measurement of escalation resolution cycle time.',
    `resolution_notes` STRING COMMENT 'Free-text description of the actions taken and outcome achieved to resolve an escalation or relationship risk event. Populated when resolution_date is set. Supports institutional learning and account recovery playbook development.',
    `revenue_impact_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the estimated_revenue_impact amount (e.g., USD, GBP, EUR). Ensures correct financial interpretation in multi-currency agency environments.. Valid values are `^[A-Z]{3}$`',
    `source_record_reference` STRING COMMENT 'The native record identifier from the originating source system (e.g., Salesforce CRM Account History ID, Workfront task ID). Enables traceability and deduplication during ETL processing.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this relationship history event originated (e.g., Salesforce CRM, Workfront, Mediaocean Prisma). Supports data lineage and reconciliation in the Silver Layer lakehouse.. Valid values are `salesforce_crm|workfront|mediaocean_prisma|sap_s4hana|manual_entry`',
    `triggered_by_name` STRING COMMENT 'Full name of the agency staff member or executive who initiated or recorded this relationship event. Stored for human-readable audit trail and executive reporting without requiring a join to HR systems.',
    `triggered_by_role` STRING COMMENT 'The business role or title of the individual who triggered this relationship event. Enables analysis of which organisational levels are driving relationship changes and escalations. [ENUM-REF-CANDIDATE: account_director|account_manager|ceo|cso|client_partner|business_development|finance_director — promote to reference product]',
    CONSTRAINT pk_relationship_history PRIMARY KEY(`relationship_history_id`)
) COMMENT 'Immutable historical log of significant changes to the agency-client relationship — including AOR wins and losses, scope expansions and reductions, account team changes, contract renewals, escalations, and relationship status transitions. Captures event type, event date, previous state, new state, triggered by (user), and narrative notes. Provides a full audit trail for relationship lifecycle management and executive reporting.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`client_onboarding` (
    `client_onboarding_id` BIGINT COMMENT 'Unique identifier for the client onboarding record. Primary key for tracking the formal onboarding lifecycle from signed contract through operational readiness.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser account being onboarded. Links to the authoritative client master record.',
    `agreement_id` BIGINT COMMENT 'Reference to the signed contract or Master Service Agreement (MSA) that triggered this onboarding process.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Onboarding activities (setup, training, integration) incur labor and system costs that are allocated to specific cost centers for internal cost recovery and profitability analysis of new client acquis',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Client onboarding is a structured project with tasks, milestones, deliverables, and resource assignments tracked in project management systems. Links onboarding workflow to project execution framework',
    `worker_id` BIGINT COMMENT 'Reference to the employee responsible for coordinating and managing the onboarding process end-to-end.',
    `workfront_project_initiative_id` BIGINT COMMENT 'Unique identifier for the onboarding project in Workfront, used to track tasks, milestones, and resource allocation.',
    `restarted_from_client_onboarding_id` BIGINT COMMENT 'Self-referencing FK on client_onboarding (restarted_from_client_onboarding_id)',
    `actual_completion_date` DATE COMMENT 'Actual date when all onboarding milestones were completed and the client was declared operationally ready.',
    `analytics_dashboard_created_flag` BOOLEAN COMMENT 'Indicates whether the client-specific analytics dashboard has been created in Google Analytics or other reporting platforms for campaign performance tracking.',
    `analytics_dashboard_creation_date` DATE COMMENT 'Date when the analytics dashboard was configured and made accessible to the client and account team.',
    `billing_code_created_flag` BOOLEAN COMMENT 'Indicates whether the client billing code has been successfully created in SAP S/4HANA FI module for invoicing and revenue recognition.',
    `billing_code_creation_date` DATE COMMENT 'Date when the billing code was created in the ERP system, enabling financial transactions for this client.',
    `blocker_resolution_date` DATE COMMENT 'Date when identified blockers were resolved, allowing the onboarding process to resume normal progression.',
    `blockers_description` STRING COMMENT 'Detailed description of any impediments, delays, or issues preventing progression of the onboarding process.',
    `brand_guidelines_received_flag` BOOLEAN COMMENT 'Indicates whether the client has provided comprehensive brand guidelines including logos, color palettes, typography, and usage rules.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the onboarding process was cancelled or terminated before completion, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this onboarding record was first created in the system, marking the start of tracking.',
    `credit_application_received_flag` BOOLEAN COMMENT 'Indicates whether the credit application has been submitted and approved, establishing payment terms and credit limits.',
    `crm_account_code` STRING COMMENT 'Salesforce CRM account identifier linking this onboarding record to the source opportunity and account record.. Valid values are `^[A-Z0-9]{15,18}$`',
    `dam_access_provisioned_date` DATE COMMENT 'Date when DAM access credentials and folder structure were established for the client.',
    `dam_access_provisioned_flag` BOOLEAN COMMENT 'Indicates whether client access to the Digital Asset Management system has been configured for brand asset storage and retrieval.',
    `go_live_date` DATE COMMENT 'Date when the first campaign was activated or the client relationship became operationally active post-onboarding.',
    `handoff_from_sales_date` DATE COMMENT 'Date when the account was formally transitioned from the sales team to the account management and onboarding team.',
    `kickoff_date` DATE COMMENT 'Date when the formal onboarding process was initiated, typically following contract signature and sales handoff.',
    `media_authorization_received_flag` BOOLEAN COMMENT 'Indicates whether media buying authorization forms have been received, granting permission to place media on behalf of the client.',
    `msa_signed_flag` BOOLEAN COMMENT 'Indicates whether the Master Service Agreement has been fully executed by both parties, establishing the legal framework for services.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, special requirements, escalations, or observations during the onboarding lifecycle.',
    `onboarding_status` STRING COMMENT 'Current lifecycle status of the onboarding process. Tracks progression from initiation through operational readiness.. Valid values are `initiated|in_progress|blocked|completed|cancelled|on_hold`',
    `onboarding_type` STRING COMMENT 'Classification of the onboarding engagement based on the nature of the client relationship being established.. Valid values are `new_client|agency_transfer|brand_expansion|reactivation`',
    `post_onboarding_satisfaction_score` STRING COMMENT 'Client satisfaction rating collected after onboarding completion, typically on a scale of 1-10, measuring the onboarding experience quality.',
    `post_onboarding_survey_date` DATE COMMENT 'Date when the post-onboarding satisfaction survey was completed by the client or primary contact.',
    `project_management_setup_date` DATE COMMENT 'Date when the project management workspace was configured and made available to the account team.',
    `project_management_setup_flag` BOOLEAN COMMENT 'Indicates whether the client workspace has been provisioned in Workfront or Monday.com for campaign project management and collaboration.',
    `reference_number` STRING COMMENT 'Business-facing unique reference code for this onboarding engagement, used in communications and tracking.. Valid values are `^ONB-[0-9]{6,10}$`',
    `service_tier` STRING COMMENT 'Service level tier assigned to this client, determining resource allocation, response times, and support levels during and post-onboarding.. Valid values are `enterprise|premium|standard|basic`',
    `sla_target_days` STRING COMMENT 'Number of business days allocated for completing the onboarding process per service level agreement commitments.',
    `target_completion_date` DATE COMMENT 'Planned date by which all onboarding activities should be completed and the client is operationally ready for campaign activation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this onboarding record, supporting audit trail and change tracking.',
    `w9_w8ben_received_flag` BOOLEAN COMMENT 'Indicates whether the required IRS tax form (W-9 for US entities or W-8BEN for foreign entities) has been received and validated.',
    CONSTRAINT pk_client_onboarding PRIMARY KEY(`client_onboarding_id`)
) COMMENT 'Tracks the formal onboarding lifecycle for new advertiser accounts — from signed contract through operational readiness. Captures onboarding status (initiated, in-progress, blocked, completed), kickoff date, system provisioning milestones (billing code creation in SAP, project management setup in Workfront/Monday, DAM access provisioning, analytics dashboard creation), assigned onboarding lead, required documentation checklist (W-9/W-8BEN, credit application, signed MSA receipt, brand guidelines receipt, media authorization forms), SLA target days, actual completion date, go-live confirmation, and post-onboarding satisfaction check. Ensures no new client falls through operational cracks between sales handoff and first campaign activation.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`client_engagement` (
    `client_engagement_id` BIGINT COMMENT 'Primary key for client_engagement',
    `advertiser_id` BIGINT COMMENT 'Foreign key linking to the advertiser (client) who is engaging the talent for campaign work',
    `talent_engagement_id` BIGINT COMMENT 'Unique surrogate identifier for this engagement record in the Silver Layer lakehouse',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to the talent profile being engaged for the advertisers campaign work',
    `agreed_rate` DECIMAL(18,2) COMMENT 'The negotiated billing rate for this specific advertiser-talent engagement, which may differ from the talents standard day_rate_usd due to volume discounts, retainer terms, or client-specific pricing. Used for project costing and invoice generation.',
    `approved_by` STRING COMMENT 'User ID or email of the approver (typically talent director, finance controller, or account director) who authorized this engagement. Used for audit trail and approval workflow compliance.',
    `approved_date` TIMESTAMP COMMENT 'Timestamp when this engagement was approved and moved to active status. Used for SLA tracking and engagement velocity reporting.',
    `client_engagement_status` STRING COMMENT 'Current lifecycle state of the engagement. Active engagements are eligible for campaign assignment and time tracking. Drives workflow routing and capacity planning visibility.',
    `contract_reference` STRING COMMENT 'The external contract or purchase order reference number from the legal or procurement system (e.g., Salesforce CPQ, DocuSign, SAP Ariba) that governs this engagement. Used for audit trail and legal compliance.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this engagement record was first created in the system. Used for audit trail and engagement velocity analytics.',
    `end_date` DATE COMMENT 'The contracted end date or expiry date of the engagement. Used for renewal workflows, capacity forecasting, and contract expiration alerts. Null for open-ended retainer engagements.',
    `engagement_type` STRING COMMENT 'The contractual nature of the engagement, determining billing structure, legal terms, and workflow routing. Drives rate card application and contract template selection.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this engagement includes exclusivity restrictions preventing the talent from working with competing advertisers or brands during the engagement period. Used for conflict checking and compliance monitoring.',
    `exclusivity_scope` STRING COMMENT 'Defines the scope of exclusivity restrictions when exclusivity_flag is true (e.g., category exclusive - automotive, brand exclusive - competitor brands only, full exclusive - all brands). Used for conflict checking workflows.',
    `rate_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the agreed_rate (e.g., USD, GBP, EUR). Must align with advertiser preferred_currency or be explicitly agreed in contract terms.',
    `role_title` STRING COMMENT 'The specific role or job title under which the talent is engaged for this advertiser (e.g., Senior Art Director, Brand Ambassador, CTV Media Specialist). May differ from the talents primary_discipline to reflect client-specific role assignments.',
    `start_date` DATE COMMENT 'The effective start date of the engagement contract. Used for capacity planning, availability calculations, and contract compliance reporting.',
    `usage_rights_included` STRING COMMENT 'Textual description or structured enumeration of the media usage rights granted under this engagement (e.g., digital only, global all media 12 months, social media perpetual). Critical for influencer and creative talent engagements to ensure compliance with usage restrictions.',
    `created_by` STRING COMMENT 'User ID or email of the talent manager, account manager, or procurement specialist who created this engagement record. Used for audit trail and workflow accountability.',
    CONSTRAINT pk_client_engagement PRIMARY KEY(`client_engagement_id`)
) COMMENT 'This association product represents the contractual engagement between an advertiser and a talent profile. It captures the commercial terms, usage rights, exclusivity constraints, and performance metadata for each advertiser-talent relationship. Each record links one advertiser to one talent profile with attributes that exist only in the context of this specific engagement, including negotiated rates, role assignments, contract duration, and usage rights that vary by advertiser-talent combination.. Existence Justification: In advertising agency operations, advertisers engage multiple talent profiles across different campaigns, roles, and time periods (e.g., a CPG brand may engage 5 influencers for a product launch, 3 art directors for seasonal campaigns, and 2 media specialists on retainer). Conversely, talent profiles work with multiple advertisers throughout their career and often simultaneously (e.g., a freelance art director may have active engagements with 3 different advertisers, an influencer may partner with 5 non-competing brands). Each engagement is a distinct contractual relationship with its own negotiated rate, usage rights, exclusivity terms, role assignment, and contract duration.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`preferred_vendor` (
    `preferred_vendor_id` BIGINT COMMENT 'Unique surrogate identifier for this preferred vendor relationship record',
    `advertiser_id` BIGINT COMMENT 'Foreign key linking to the advertiser who has established this preferred vendor relationship',
    `vendor_rate_card_id` BIGINT COMMENT 'Reference to the negotiated rate card or pricing agreement specific to this advertiser-supplier relationship, capturing custom pricing terms',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to the supplier who is on the advertisers preferred vendor list',
    `approval_status` STRING COMMENT 'Current approval workflow status for this advertiser-supplier relationship, driving whether the supplier can be selected for campaigns',
    `brand_safety_rating` STRING COMMENT 'The advertisers own brand safety assessment of this supplier, which may differ from the suppliers general brand_safety_tier based on advertiser-specific content policies and risk tolerance',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this preferred vendor relationship record was first created in the system',
    `effective_from_date` DATE COMMENT 'The date from which this preferred vendor relationship became active and the supplier was approved for use by this advertiser',
    `effective_until_date` DATE COMMENT 'The date until which this preferred vendor relationship remains valid; null indicates ongoing relationship with no defined end date',
    `minimum_spend_commitment` DECIMAL(18,2) COMMENT 'The minimum spend amount (in advertisers preferred currency) that the advertiser has committed to with this supplier over the contract period',
    `onboarding_completed` BOOLEAN COMMENT 'Indicates whether the supplier has completed all advertiser-specific onboarding requirements (brand guidelines, creative specs, reporting setup, API integration) for this relationship',
    `tier` STRING COMMENT 'Strategic tier classification for this advertiser-supplier relationship indicating priority level, volume commitment, and preferential treatment (platinum = highest priority, approved = baseline)',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this preferred vendor relationship record was last modified',
    CONSTRAINT pk_preferred_vendor PRIMARY KEY(`preferred_vendor_id`)
) COMMENT 'This association product represents the strategic vendor preference and commercial agreement between an advertiser and a supplier. It captures the advertisers approved vendor list with negotiated terms, performance tiers, spend commitments, and brand safety approvals. Each record links one advertiser to one supplier with relationship-specific attributes including tier classification, rate cards, minimum spend commitments, approval workflow status, onboarding completion, and brand safety ratings that exist only in the context of this advertiser-supplier partnership.. Existence Justification: In advertising operations, advertisers maintain approved vendor lists (preferred vendor lists) with multiple suppliers across different categories (publishers, DSPs, tech platforms), and each supplier serves multiple advertiser clients. The relationship itself carries critical business data including negotiated tier levels, rate cards, spend commitments, approval status, and advertiser-specific brand safety ratings that cannot be stored on either the advertiser or supplier entity alone. This is an actively managed business relationship with its own lifecycle.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`advertiser_segment_license` (
    `advertiser_segment_license_id` BIGINT COMMENT 'Unique surrogate identifier for this advertiser-segment license relationship. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Foreign key linking to the advertiser who has licensed or owns access to this segment',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to the audience segment being licensed or accessed',
    `access_level` STRING COMMENT 'Defines the scope of permissions the advertiser has for this segment: full_access (can view, activate, and export), read_only (can view segment definition and size), activation_only (can target but not view underlying data), reporting_only (can see performance metrics only), restricted (limited by contract terms). Enforced by DSP and DMP access control systems.',
    `activation_status` STRING COMMENT 'Current operational status of this advertiser-segment license: active (segment is available for targeting in campaigns), inactive (license exists but segment not pushed to DSPs), pending_approval (awaiting legal/compliance review), suspended (temporarily disabled due to contract issue or data quality concern), expired (license term ended). Drives segment availability in campaign planning tools.',
    `contract_reference_code` STRING COMMENT 'Reference identifier for the legal contract or data partnership agreement governing this license. Links to contract management system (e.g., DocuSign envelope ID, SAP Ariba contract number). Used for compliance audits and renewal tracking.',
    `cost_allocation_pct` DECIMAL(18,2) COMMENT 'Percentage of segment licensing or data acquisition costs allocated to this advertiser, expressed as decimal (0.00 to 100.00). Used for shared segments where multiple advertisers split costs (e.g., co-op segments, agency-negotiated bulk licenses). Null for first-party owned segments with no external cost.',
    `created_timestamp` TIMESTAMP COMMENT 'UTC timestamp when this license record was created in the system.',
    `data_provider_name` STRING COMMENT 'Name of the third-party data provider or partner who supplies this segment (e.g., Nielsen, Experian, LiveRamp, Acxiom). Null for first-party owned segments. Used for vendor management, contract tracking, and data lineage.',
    `effective_end_date` DATE COMMENT 'Date when this advertiser-segment license expires or is terminated. Null for perpetual licenses (e.g., first-party owned segments). Used to enforce contract terms, auto-deactivate expired third-party data, and trigger renewal workflows.',
    `effective_start_date` DATE COMMENT 'Date when this advertiser-segment license becomes active and the segment becomes available for targeting by this advertiser. Used for contract start dates, data partnership go-live dates, and segment release schedules.',
    `last_modified_by` STRING COMMENT 'User ID or email of the person who last modified this license record. Used for audit trail.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'UTC timestamp when this license record was last modified.',
    `license_cost_amount` DECIMAL(18,2) COMMENT 'Total cost amount for this advertiser to license or access this segment, in the currency specified by license_cost_currency. Null for first-party owned segments. Used for cost attribution, budget tracking, and ROI analysis.',
    `license_cost_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the license cost amount (e.g., USD, EUR, GBP). Null if license_cost_amount is null.',
    `license_cost_model` STRING COMMENT 'Pricing model for this segment license: flat_fee (fixed annual or monthly cost), cpm (cost per thousand impressions), per_activation (cost per campaign activation), revenue_share (percentage of media spend), no_cost (first-party owned or complimentary access).',
    `ownership_type` STRING COMMENT 'Classification of the relationship between advertiser and segment: first_party_owned (advertiser owns the underlying data), second_party_licensed (direct data partnership), third_party_licensed (purchased from data vendor), co_op_shared (industry consortium segment), lookalike_derived (modeled from advertiser seed data). Drives cost allocation and data governance policies.',
    `created_by` STRING COMMENT 'User ID or email of the person who created this advertiser-segment license record. Used for audit trail and accountability.',
    CONSTRAINT pk_advertiser_segment_license PRIMARY KEY(`advertiser_segment_license_id`)
) COMMENT 'This association product represents the licensing and access relationship between advertisers and audience segments. It captures the commercial and operational terms under which an advertiser has rights to use a specific segment for targeting. Each record links one advertiser to one segment with attributes that define ownership type (owned first-party, licensed third-party, co-op shared), access permissions, cost allocation, activation status, and effective date ranges. This is the SSOT for segment entitlements, usage rights, and cost attribution in the audience data management platform.. Existence Justification: In advertising operations, advertisers routinely license and activate multiple audience segments simultaneously (first-party owned, third-party purchased, co-op shared, lookalike modeled), and segments are shared across multiple advertisers with different access rights and cost terms. The business actively manages these licenses as operational entities with distinct ownership types, access levels, cost allocation percentages, activation permissions, and contract terms that vary by advertiser-segment combination. This is not an analytical correlation but a core operational relationship in audience data management platforms.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`brand_supplier_approval` (
    `brand_supplier_approval_id` BIGINT COMMENT 'Unique surrogate identifier for the brand-supplier approval record. Primary key.',
    `brand_client_brand_id` BIGINT COMMENT 'Foreign key linking to the client brand that has approved this supplier relationship',
    `client_brand_id` BIGINT COMMENT 'Foreign key to client.client_brand.client_brand_id',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to the approved supplier for this brand',
    `annual_spend_commitment` DECIMAL(18,2) COMMENT 'The committed annual media spend from this brand to this supplier, as negotiated in the commercial agreement. Used for volume-based rate negotiations and supplier relationship management.',
    `approval_date` DATE COMMENT 'The date on which this supplier was approved for this brand. Used for tracking approval history and contract lifecycle.',
    `approval_status` STRING COMMENT 'Current lifecycle status of the brand-supplier approval. Controls whether the supplier is eligible for media buys on behalf of this brand.',
    `approved_channels` STRING COMMENT 'Comma-separated list of media channels approved for this brand-supplier relationship (e.g., display, video, social, CTV). A supplier may be approved for different channels for different brands.',
    `brand_safety_tier` STRING COMMENT 'Brand-specific safety tier rating for this supplier. Overrides the suppliers default brand_safety_tier when serving this brand. Different brands within the same advertiser may have different safety requirements for the same supplier.',
    `commitment_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the annual spend commitment (e.g., USD, EUR, GBP).',
    `contract_end_date` DATE COMMENT 'The expiration date of the commercial agreement between this brand and supplier. Used for contract renewal tracking.',
    `contract_start_date` DATE COMMENT 'The effective start date of the commercial agreement between this brand and supplier.',
    `exclusion_list` STRING COMMENT 'Brand-specific content exclusion keywords or categories for this supplier relationship. Defines content adjacency restrictions beyond the suppliers default brand safety tier.',
    `notes` STRING COMMENT 'Free-text notes about this brand-supplier relationship, including special terms, restrictions, or historical context.',
    `preferred_formats` STRING COMMENT 'Comma-separated list of preferred ad formats for this brand-supplier relationship (e.g., 300x250, 728x90, video_15s, native). Format preferences may vary by brand even for the same supplier.',
    `primary_account_manager` STRING COMMENT 'Name or identifier of the agency account manager responsible for this brand-supplier relationship.',
    `rate_negotiation_status` STRING COMMENT 'Status of commercial rate negotiation between this brand and supplier. Indicates whether brand-specific rates have been negotiated or standard rates apply.',
    CONSTRAINT pk_brand_supplier_approval PRIMARY KEY(`brand_supplier_approval_id`)
) COMMENT 'This association product represents the approved vendor relationship between a client brand and a supplier in the advertising ecosystem. It captures brand-specific vendor approvals, negotiated commercial terms, brand safety requirements, and approved media channels. Each record links one client brand to one supplier with attributes that exist only in the context of this brand-supplier partnership, enabling brands within the same advertiser to maintain distinct vendor relationships, rates, and safety requirements.. Existence Justification: In advertising operations, brands within the same advertiser maintain distinct vendor relationships with different approved suppliers, negotiated rates, brand safety requirements, and approved media channels. A luxury brand and a mass-market brand owned by the same advertiser will have different approved publisher lists and safety tiers. Each brand works with multiple suppliers (for reach and redundancy), and each supplier serves multiple brands (across multiple advertisers). The relationship itself carries brand-specific commercial terms, approval status, spend commitments, and content restrictions that belong to neither the brand nor the supplier alone.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` (
    `advertiser_cost_center_allocation_id` BIGINT COMMENT 'Primary key for advertiser_cost_center_allocation',
    `advertiser_id` BIGINT COMMENT 'Foreign key linking to the advertiser master record. Identifies which client account this cost allocation applies to.',
    `allocation_id` BIGINT COMMENT 'Unique surrogate identifier for this advertiser-cost center allocation record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to the cost center master record. Identifies which organizational cost center is allocated to this advertiser.',
    `allocation_basis` STRING COMMENT 'The driver or methodology used to determine the allocation percentage. Examples: headcount, revenue, square footage, FTE hours, transaction volume. Provides transparency for allocation logic.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the cost centers expenses allocated to this advertiser. Used for proportional cost distribution in shared service scenarios. Values range from 0.00 to 100.00.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of this allocation record. Active allocations are operational. Pending allocations are approved but not yet effective. Suspended allocations are temporarily inactive. Closed allocations are historical.',
    `allocation_type` STRING COMMENT 'Classification of the allocation method. Direct allocations are costs incurred specifically for the advertiser. Indirect allocations are shared costs distributed based on allocation drivers. Overhead allocations are general agency costs. Shared service allocations are for centralized functions.',
    `billing_arrangement` STRING COMMENT 'Defines how costs from this cost center are billed to the advertiser. Billable costs are invoiced directly. Non-billable costs are absorbed by the agency. Pass-through costs are billed at cost. Markup costs are billed with an agency margin.',
    `budget_allocation_amount` DECIMAL(18,2) COMMENT 'The budgeted amount allocated from this cost center to this advertiser for the effective period. Used for budget-vs-actual variance analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this allocation record was first created in the system.',
    `effective_end_date` DATE COMMENT 'The date on which this cost center allocation to the advertiser ceases to be effective. Null indicates the allocation is currently active.',
    `effective_start_date` DATE COMMENT 'The date on which this cost center allocation to the advertiser becomes effective. Supports temporal tracking of allocation changes over fiscal periods.',
    `last_modified_by` STRING COMMENT 'The user ID or email of the individual who last modified this allocation record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this allocation record was last updated.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'The percentage markup applied to costs when billing_arrangement is markup. Null for other billing arrangements.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or business justification for this allocation arrangement.',
    `sap_allocation_reference` STRING COMMENT 'Reference identifier for the corresponding allocation record in SAP S/4HANA CO module. Enables reconciliation between the data lake and ERP system.',
    `created_by` STRING COMMENT 'The user ID or email of the individual who created this allocation record. Supports audit trail and accountability.',
    CONSTRAINT pk_advertiser_cost_center_allocation PRIMARY KEY(`advertiser_cost_center_allocation_id`)
) COMMENT 'This association product represents the allocation relationship between advertisers and cost centers in agency financial management. It captures how agency costs are distributed across client accounts and internal organizational units for P&L reporting, profitability analysis, and management accounting. Each record links one advertiser to one cost center with allocation percentages, effective dates, and billing arrangements that exist only in the context of this specific advertiser-cost center pairing.. Existence Justification: In agency operations, large advertisers (clients) typically have costs allocated across multiple cost centers representing different service lines (creative, media buying, strategy, production, account management), and each cost center serves multiple client accounts simultaneously. The finance function actively manages these allocation relationships to track profitability by client, allocate shared service costs, and support accurate P&L reporting and client billing.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`brief_approver` (
    `brief_approver_id` BIGINT COMMENT 'Unique surrogate identifier for each brief approver record. Primary key.',
    `client_contact_id` BIGINT COMMENT 'Foreign key linking to the client contact who is an approver in this approval relationship',
    `creative_brief_id` BIGINT COMMENT 'Foreign key linking to the creative brief being approved',
    `approval_chain` STRING COMMENT 'Ordered list of stakeholders and roles who must review and approve the creative brief and resulting assets, including sequence and approval authority. [Moved from creative_brief: The approval_chain attribute in creative_brief is a denormalized representation of the approval workflow. The proper normalized model stores each approver as a separate record in the brief_approver association with their role, sequence, and status. This allows for operational management of individual approvals rather than storing a static string.]',
    `approval_role` STRING COMMENT 'The functional role this contact plays in the approval process for this specific brief. Defines their approval authority and perspective (e.g., Brand Manager, Legal Reviewer, Finance Approver). Sourced from detection phase relationship data.',
    `approval_sequence` BIGINT COMMENT 'The position of this approver in the approval chain workflow. Defines the order in which approvals must be obtained (e.g., 1 = first approver, 2 = second approver). Sourced from detection phase relationship data.',
    `approval_status` STRING COMMENT 'Current status of this specific approvers review of the brief. Tracks whether they have approved, rejected, or are still pending review. Sourced from detection phase relationship data.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this approver provided their approval decision. Null if still pending. Sourced from detection phase relationship data.',
    `due_date` DATE COMMENT 'Target date by which this approver should complete their review. Used to manage approval workflow timing and escalations.',
    `feedback_provided` STRING COMMENT 'Comments, feedback, or conditions provided by this approver during their review. Captures approval notes, requested changes, or rejection reasons. Sourced from detection phase relationship data.',
    `is_required_approver` BOOLEAN COMMENT 'Indicates whether this approvers approval is mandatory for the brief to proceed to production, or if they are an optional/advisory reviewer.',
    `notified_date` DATE COMMENT 'Date when this approver was notified that the brief is ready for their review. Used to track approval cycle time and SLA compliance.',
    CONSTRAINT pk_brief_approver PRIMARY KEY(`brief_approver_id`)
) COMMENT 'This association product represents the approval relationship between client contacts and creative briefs. It captures the multi-stakeholder approval workflow that is core to creative development governance. Each record links one client contact to one creative brief with attributes that define their role in the approval chain, sequence position, approval status, timing, and feedback provided.. Existence Justification: Creative briefs in advertising require multi-stakeholder approval from client-side contacts before creative production can proceed. A single brief requires approval from multiple contacts (brand manager, legal, finance, marketing director) in a defined sequence, and each contact approves multiple briefs across different campaigns over time. The approval workflow is an operational business process actively managed by creative teams, with relationship-specific data including approval role, sequence order, status, timestamp, and feedback.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`io_authorization` (
    `io_authorization_id` BIGINT COMMENT 'Unique surrogate identifier for each IO authorization record',
    `client_contact_id` BIGINT COMMENT 'Foreign key linking to the client contact who authorized this insertion order',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to the media insertion order being authorized',
    `authorization_date` DATE COMMENT 'Date on which the authorizing party formally approved this IO. Establishes the legal effective date of the contractual commitment. [Moved from media_insertion_order: This attribute currently stores a single authorization date on the IO record, but in reality multiple contacts sign at different times. This should be removed from media_insertion_order and replaced by signature_date in the io_authorization association, which tracks the specific timestamp for each signatory.]',
    `authorization_level` STRING COMMENT 'The level or tier of authorization this signature represents (e.g., primary approver, secondary approver, conditional approval). Explicitly identified in detection reasoning.',
    `authorization_method` STRING COMMENT 'Method by which the IO was authorized by the client or agency. Supports legal audit trails and e-signature compliance under applicable regulations. [Moved from media_insertion_order: This attribute currently stores a single authorization method on the IO record, but different signatories may use different methods (e.g., legal uses DocuSign, finance uses email approval). This should be removed from media_insertion_order and replaced by signature_method in the io_authorization association, which tracks the method used by each specific signatory.]. Valid values are `wet_signature|electronic_signature|email_approval|verbal_confirmed`',
    `authorization_notes` STRING COMMENT 'Free-text notes or conditions attached to this authorization by the signatory (e.g., Approved pending legal review, Conditional on budget availability).',
    `authorization_status` STRING COMMENT 'Current status of this specific authorization record. Tracks whether the signature is still valid or has been revoked/expired.',
    `authorizing_party_name` STRING COMMENT 'Full name of the individual (client or agency representative) who authorized and signed off on this IO. Required for legal enforceability and audit compliance. [Moved from media_insertion_order: This attribute currently stores a single authorizing party name on the IO record, but in reality multiple contacts authorize each IO in different roles. This attribute should be removed from media_insertion_order and replaced by the io_authorization association, which properly models the many-to-many relationship and captures which specific contact authorized in which role.]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this authorization record was first created in the system (may differ from signature_date if authorization was recorded retroactively).',
    `ip_address` STRING COMMENT 'IP address from which the electronic signature was submitted. Audit data for legal compliance and fraud detection. Explicitly identified in detection reasoning.',
    `signatory_role` STRING COMMENT 'The functional role in which this contact authorized the IO. Multiple contacts may sign the same IO in different capacities (e.g., legal signatory, budget approver). Explicitly identified in detection reasoning.',
    `signature_date` TIMESTAMP COMMENT 'Precise timestamp when this contact completed their signature or authorization action for this IO. Explicitly identified in detection reasoning.',
    `signature_method` STRING COMMENT 'The mechanism used to capture this contacts authorization (e.g., DocuSign, wet signature, email approval). Supports legal audit requirements. Explicitly identified in detection reasoning.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this authorization record was last modified (e.g., status change, notes added).',
    CONSTRAINT pk_io_authorization PRIMARY KEY(`io_authorization_id`)
) COMMENT 'This association product represents the Authorization event between client_contact and media_insertion_order. It captures the formal approval and signature process required to execute media insertion orders. Each record links one client_contact to one media_insertion_order with attributes that exist only in the context of this authorization relationship, including signatory role, signature timestamp, authorization level, signature method, and audit data.. Existence Justification: In advertising agency operations, insertion orders require formal authorization from multiple client-side stakeholders before execution. A single IO typically requires signatures from legal signatories (for contract terms), budget approvers (for spend authorization), brand leads (for creative approval), and sometimes procurement and finance contacts. Each contact signs multiple IOs across different campaigns and time periods. The authorization process is a managed business workflow with specific roles, timestamps, methods (DocuSign vs wet signature), and audit requirements.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`survey_wave` (
    `survey_wave_id` BIGINT COMMENT 'Primary key for survey_wave',
    `advertiser_id` BIGINT COMMENT 'Reference to the client or advertiser for whom this survey wave is being conducted.',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign being measured or evaluated by this survey wave, if applicable.',
    `supplier_id` BIGINT COMMENT 'Reference to the external research vendor or panel provider executing the fieldwork for this wave, if applicable.',
    `survey_id` BIGINT COMMENT 'Reference to the parent survey program or study to which this wave belongs.',
    `previous_survey_wave_id` BIGINT COMMENT 'Self-referencing FK on survey_wave (previous_survey_wave_id)',
    `actual_sample_size` STRING COMMENT 'Actual number of completed survey responses collected during this wave.',
    `average_completion_time_minutes` DECIMAL(18,2) COMMENT 'Mean time in minutes required for respondents to complete the survey in this wave.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for conducting this survey wave, including fieldwork, incentives, and vendor fees.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the wave cost amount.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this survey wave record was first created in the system.',
    `data_collection_method` STRING COMMENT 'Primary mode or channel through which survey responses are collected.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Composite quality score (0-100) assessing the reliability and validity of data collected in this wave, based on metrics such as completion rates, straight-lining, and speeders.',
    `field_end_date` DATE COMMENT 'Date when data collection for this survey wave ends or is scheduled to end.',
    `field_start_date` DATE COMMENT 'Date when data collection for this survey wave begins or began.',
    `geographic_scope` STRING COMMENT 'Geographic coverage or market(s) included in this survey wave (e.g., USA National, UK London Metro, Global 15 Markets).',
    `incentive_description` STRING COMMENT 'Description of the incentive or compensation offered to respondents (e.g., $10 gift card, 500 loyalty points).',
    `incentive_offered` BOOLEAN COMMENT 'Indicates whether respondents were offered compensation or incentives for completing the survey.',
    `incidence_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of screened respondents who qualify for the survey based on targeting criteria.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this survey wave record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text field for additional comments, observations, or contextual information about this survey wave.',
    `questionnaire_version` STRING COMMENT 'Version identifier of the survey questionnaire instrument used in this wave.',
    `response_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of invited or contacted respondents who completed the survey, calculated as (completes / contacts) * 100.',
    `sampling_method` STRING COMMENT 'Statistical sampling methodology used to select respondents for this survey wave.',
    `target_audience` STRING COMMENT 'Description of the demographic or psychographic profile of respondents targeted for this survey wave.',
    `target_sample_size` STRING COMMENT 'Planned number of completed survey responses to be collected during this wave.',
    `wave_name` STRING COMMENT 'Human-readable name or label for the survey wave (e.g., Q1 2024 Brand Tracker, Post-Campaign Pulse).',
    `wave_number` STRING COMMENT 'Sequential number identifying the wave within a survey series (e.g., Wave 1, Wave 2, Wave 3).',
    `wave_status` STRING COMMENT 'Current lifecycle status of the survey wave indicating its operational state.',
    `wave_type` STRING COMMENT 'Classification of the survey wave based on its timing and purpose within the research program.',
    `weighting_applied` BOOLEAN COMMENT 'Indicates whether statistical weighting has been applied to the survey data to correct for sampling bias.',
    `weighting_methodology` STRING COMMENT 'Description of the statistical weighting approach and variables used to adjust survey results.',
    CONSTRAINT pk_survey_wave PRIMARY KEY(`survey_wave_id`)
) COMMENT 'Master reference table for survey_wave. Referenced by survey_wave_id.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`survey` (
    `survey_id` BIGINT COMMENT 'Primary key for survey',
    `derived_from_survey_id` BIGINT COMMENT 'Self-referencing FK on survey (derived_from_survey_id)',
    `approved_by` STRING COMMENT 'The username or identifier of the person who approved the survey for launch.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the survey was approved for distribution to respondents.',
    `brand_id` BIGINT COMMENT 'Reference to the specific brand being evaluated or measured in this survey.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The allocated budget for conducting the survey, including vendor fees, incentives, and operational costs.',
    `budget_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the survey budget amount.',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign associated with this survey, if applicable.',
    `client_id` BIGINT COMMENT 'Reference to the client or advertiser who commissioned or owns this survey.',
    `close_date` DATE COMMENT 'The date when the survey was closed to new responses and data collection ended.',
    `completion_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of started surveys that were fully completed, calculated as (completed / started) * 100.',
    `confidentiality_level` STRING COMMENT 'The level of respondent anonymity or confidentiality guaranteed for survey responses.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the survey record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'A calculated score (0.00 to 1.00) representing the overall quality and reliability of survey data based on validation checks.',
    `estimated_duration_minutes` STRING COMMENT 'The expected time in minutes required for a respondent to complete the survey.',
    `geographic_scope` STRING COMMENT 'The geographic region or market coverage for survey distribution (e.g., national, regional, global).',
    `incentive_description` STRING COMMENT 'Details of the incentive or compensation offered to survey respondents, if applicable.',
    `incentive_offered` BOOLEAN COMMENT 'Indicates whether respondents were offered compensation or incentives for completing the survey.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the survey is currently active and available for responses or data collection.',
    `language` STRING COMMENT 'The primary language in which the survey was administered to respondents.',
    `launch_date` DATE COMMENT 'The date when the survey was made available to respondents and data collection began.',
    `methodology` STRING COMMENT 'The data collection method or approach used to administer the survey.',
    `modified_by` STRING COMMENT 'The username or identifier of the person who last modified the survey record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the survey record was last updated or modified in the system.',
    `notes` STRING COMMENT 'Additional free-form notes, comments, or observations about the survey for internal reference.',
    `question_count` STRING COMMENT 'The total number of questions included in the survey instrument.',
    `response_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of invited respondents who completed the survey, calculated as (completed / invited) * 100.',
    `sample_size_actual` STRING COMMENT 'The actual number of completed survey responses received.',
    `sample_size_target` STRING COMMENT 'The planned or target number of survey responses to be collected for statistical validity.',
    `survey_code` STRING COMMENT 'The externally-known unique code or reference number assigned to the survey for tracking and integration purposes.',
    `survey_description` STRING COMMENT 'Detailed description of the survey objectives, scope, and methodology for internal reference and reporting.',
    `survey_name` STRING COMMENT 'The official name or title of the survey used for identification and reporting purposes.',
    `survey_status` STRING COMMENT 'Current lifecycle state of the survey indicating its operational status and availability for responses.',
    `survey_type` STRING COMMENT 'The category or classification of the survey indicating its primary purpose and methodology.',
    `survey_url` STRING COMMENT 'The web address or link where the online survey can be accessed by respondents.',
    `survey_vendor` STRING COMMENT 'Name of the third-party research firm or vendor conducting the survey, if applicable.',
    `target_audience` STRING COMMENT 'Description of the intended respondent demographic or segment for this survey.',
    `created_by` STRING COMMENT 'The username or identifier of the person who created the survey record in the system.',
    CONSTRAINT pk_survey PRIMARY KEY(`survey_id`)
) COMMENT 'Master reference table for survey. Referenced by survey_id.';

CREATE OR REPLACE TABLE `advertising_ecm`.`client`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Primary key for legal_entity',
    `agency_network_affiliation` STRING COMMENT 'Name of the holding company or agency network to which this entity belongs (e.g., WPP, Omnicom, Publicis, IPG, Dentsu).',
    `annual_revenue_amount` DECIMAL(18,2) COMMENT 'Most recent annual revenue reported by the legal entity, used for credit assessment and relationship sizing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this legal entity record was first created in the system.',
    `credit_rating` STRING COMMENT 'External credit rating assigned by a rating agency (e.g., Moodys, S&P, Fitch) for creditworthiness assessment.',
    `data_protection_registration_number` STRING COMMENT 'Registration number with data protection authorities (e.g., ICO in UK, CNIL in France) for entities processing personal data.',
    `dissolution_date` DATE COMMENT 'Date on which the legal entity was officially dissolved, merged, or ceased operations, if applicable.',
    `doing_business_as_name` STRING COMMENT 'Trade name or fictitious business name under which the legal entity operates, if different from the legal name.',
    `duns_number` STRING COMMENT 'Nine-digit Dun & Bradstreet identifier used for business credit and identity verification.',
    `employee_count` STRING COMMENT 'Approximate number of employees working for the legal entity, used for sizing and segmentation.',
    `entity_status` STRING COMMENT 'Current operational and legal status of the entity in its lifecycle.',
    `headquarters_address_line_1` STRING COMMENT 'Primary street address line for the legal entitys headquarters or principal place of business.',
    `headquarters_address_line_2` STRING COMMENT 'Secondary address line for suite, floor, or building information for the headquarters location.',
    `headquarters_city` STRING COMMENT 'City or municipality where the legal entitys headquarters is located.',
    `headquarters_country_code` STRING COMMENT 'Three-letter ISO country code for the country where headquarters is located.',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code for the headquarters address.',
    `headquarters_state_province` STRING COMMENT 'State, province, or region where the legal entitys headquarters is located.',
    `incorporation_country_code` STRING COMMENT 'Three-letter ISO country code representing the country of incorporation.',
    `incorporation_date` DATE COMMENT 'The date on which the legal entity was officially incorporated or registered with the governing authority.',
    `incorporation_jurisdiction` STRING COMMENT 'The country, state, or province where the legal entity is incorporated or registered.',
    `industry_classification_code` STRING COMMENT 'Standard industry classification code representing the entitys primary business activity (e.g., NAICS, SIC, ISIC).',
    `industry_classification_description` STRING COMMENT 'Human-readable description of the industry classification code.',
    `is_agency` BOOLEAN COMMENT 'Indicates whether this legal entity operates as an advertising or marketing agency (as opposed to a direct advertiser).',
    `is_publicly_traded` BOOLEAN COMMENT 'Indicates whether the legal entity is publicly traded on a stock exchange.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this legal entity record was last updated.',
    `legal_entity_type` STRING COMMENT 'The legal structure and organizational form of the entity (e.g., corporation, LLC, partnership).',
    `legal_name` STRING COMMENT 'The official registered legal name of the entity as it appears on incorporation documents and legal contracts.',
    `lei_code` STRING COMMENT '20-character ISO 17442 Legal Entity Identifier code for entities engaged in financial transactions.',
    `parent_legal_entity_id` BIGINT COMMENT 'Reference to the parent legal entity if this entity is a subsidiary or part of a larger corporate structure.',
    `primary_email_address` STRING COMMENT 'Main business email address for official correspondence with the legal entity.',
    `primary_phone_number` STRING COMMENT 'Main business telephone number for contacting the legal entity.',
    `registration_number` STRING COMMENT 'Official government-issued registration or incorporation number assigned to the legal entity by the jurisdiction of incorporation.',
    `regulatory_status` STRING COMMENT 'Current compliance status with applicable advertising and marketing regulations (e.g., FTC, ASA, GDPR).',
    `revenue_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the annual revenue amount.',
    `stock_exchange_code` STRING COMMENT 'ISO 10383 Market Identifier Code (MIC) for the primary stock exchange where the entity is listed.',
    `stock_exchange_symbol` STRING COMMENT 'Ticker symbol under which the entitys shares are traded on a stock exchange, if publicly traded.',
    `tax_identification_number` STRING COMMENT 'Tax identifier assigned by the tax authority in the entitys primary jurisdiction (e.g., EIN in USA, VAT number in EU).',
    `ultimate_parent_legal_entity_id` BIGINT COMMENT 'Reference to the top-level parent entity in the corporate hierarchy (ultimate beneficial owner entity).',
    `website_url` STRING COMMENT 'Official website URL for the legal entity.',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Master reference table for legal_entity. Referenced by legal_entity_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ADD CONSTRAINT `fk_client_advertiser_client_segment_id` FOREIGN KEY (`client_segment_id`) REFERENCES `advertising_ecm`.`client`.`client_segment`(`client_segment_id`);
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ADD CONSTRAINT `fk_client_advertiser_hierarchy_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ADD CONSTRAINT `fk_client_advertiser_hierarchy_parent_advertiser_id` FOREIGN KEY (`parent_advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ADD CONSTRAINT `fk_client_advertiser_hierarchy_primary_root_advertiser_id` FOREIGN KEY (`primary_root_advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ADD CONSTRAINT `fk_client_client_brand_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ADD CONSTRAINT `fk_client_client_brand_client_brand_campaign_manager_advertiser_id` FOREIGN KEY (`client_brand_campaign_manager_advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ADD CONSTRAINT `fk_client_client_contact_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`client`.`account_team` ADD CONSTRAINT `fk_client_account_team_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`client`.`address` ADD CONSTRAINT `fk_client_address_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`client`.`address` ADD CONSTRAINT `fk_client_address_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `advertising_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ADD CONSTRAINT `fk_client_agency_relationship_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ADD CONSTRAINT `fk_client_client_brief_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ADD CONSTRAINT `fk_client_client_brief_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `advertising_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `advertising_ecm`.`client`.`interaction` ADD CONSTRAINT `fk_client_interaction_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`client`.`interaction` ADD CONSTRAINT `fk_client_interaction_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `advertising_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ADD CONSTRAINT `fk_client_nps_response_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ADD CONSTRAINT `fk_client_nps_response_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `advertising_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ADD CONSTRAINT `fk_client_nps_response_survey_wave_id` FOREIGN KEY (`survey_wave_id`) REFERENCES `advertising_ecm`.`client`.`survey_wave`(`survey_wave_id`);
ALTER TABLE `advertising_ecm`.`client`.`preference` ADD CONSTRAINT `fk_client_preference_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`client`.`preference` ADD CONSTRAINT `fk_client_preference_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `advertising_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ADD CONSTRAINT `fk_client_competitive_conflict_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ADD CONSTRAINT `fk_client_revenue_target_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ADD CONSTRAINT `fk_client_revenue_target_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ADD CONSTRAINT `fk_client_client_consent_record_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ADD CONSTRAINT `fk_client_client_consent_record_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `advertising_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ADD CONSTRAINT `fk_client_relationship_history_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ADD CONSTRAINT `fk_client_relationship_history_agency_relationship_id` FOREIGN KEY (`agency_relationship_id`) REFERENCES `advertising_ecm`.`client`.`agency_relationship`(`agency_relationship_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ADD CONSTRAINT `fk_client_client_onboarding_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ADD CONSTRAINT `fk_client_client_onboarding_restarted_from_client_onboarding_id` FOREIGN KEY (`restarted_from_client_onboarding_id`) REFERENCES `advertising_ecm`.`client`.`client_onboarding`(`client_onboarding_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` ADD CONSTRAINT `fk_client_client_engagement_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`client`.`preferred_vendor` ADD CONSTRAINT `fk_client_preferred_vendor_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`client`.`advertiser_segment_license` ADD CONSTRAINT `fk_client_advertiser_segment_license_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`client`.`brand_supplier_approval` ADD CONSTRAINT `fk_client_brand_supplier_approval_brand_client_brand_id` FOREIGN KEY (`brand_client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`client`.`brand_supplier_approval` ADD CONSTRAINT `fk_client_brand_supplier_approval_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` ADD CONSTRAINT `fk_client_advertiser_cost_center_allocation_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`client`.`brief_approver` ADD CONSTRAINT `fk_client_brief_approver_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `advertising_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `advertising_ecm`.`client`.`io_authorization` ADD CONSTRAINT `fk_client_io_authorization_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `advertising_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `advertising_ecm`.`client`.`survey_wave` ADD CONSTRAINT `fk_client_survey_wave_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`client`.`survey_wave` ADD CONSTRAINT `fk_client_survey_wave_survey_id` FOREIGN KEY (`survey_id`) REFERENCES `advertising_ecm`.`client`.`survey`(`survey_id`);
ALTER TABLE `advertising_ecm`.`client`.`survey_wave` ADD CONSTRAINT `fk_client_survey_wave_previous_survey_wave_id` FOREIGN KEY (`previous_survey_wave_id`) REFERENCES `advertising_ecm`.`client`.`survey_wave`(`survey_wave_id`);
ALTER TABLE `advertising_ecm`.`client`.`survey` ADD CONSTRAINT `fk_client_survey_derived_from_survey_id` FOREIGN KEY (`derived_from_survey_id`) REFERENCES `advertising_ecm`.`client`.`survey`(`survey_id`);

-- ========= TAGS =========
ALTER SCHEMA `advertising_ecm`.`client` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `advertising_ecm`.`client` SET TAGS ('dbx_domain' = 'client');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `client_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Client Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'prospect|active|dormant|churned|suspended');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `account_tier` SET TAGS ('dbx_business_glossary_term' = 'Account Tier');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `account_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|failed|pending');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `approval_workflow_type` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Type');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `approval_workflow_type` SET TAGS ('dbx_value_regex' = 'single_approver|multi_approver|auto_approve');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `ccpa_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Data Sharing Consent Flag');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `ccpa_consent_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `churn_date` SET TAGS ('dbx_business_glossary_term' = 'Churn Date');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `credit_terms` SET TAGS ('dbx_business_glossary_term' = 'Credit Terms');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `credit_terms` SET TAGS ('dbx_value_regex' = 'net_15|net_30|net_45|net_60|prepaid');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `credit_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `crm_account_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Account ID');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `ein` SET TAGS ('dbx_business_glossary_term' = 'Employer Identification Number (EIN)');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `ein` SET TAGS ('dbx_value_regex' = '^d{2}-d{7}$');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `ein` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `erp_customer_number` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Customer Number');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Data Sharing Consent Flag');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `holding_company_name` SET TAGS ('dbx_business_glossary_term' = 'Holding Company Name');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `iab_industry_vertical` SET TAGS ('dbx_business_glossary_term' = 'Interactive Advertising Bureau (IAB) Industry Vertical');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `incorporation_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Jurisdiction');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `incorporation_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Invoice Delivery Method');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_value_regex' = 'email|portal|mail|edi');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `is_agency_managed` SET TAGS ('dbx_business_glossary_term' = 'Agency Managed Flag');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `managing_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Managing Agency Name');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'bank_transfer|check|ach|wire|credit_card');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `preferred_comm_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `preferred_comm_channel` SET TAGS ('dbx_value_regex' = 'email|phone|portal|slack|teams');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Full Name');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `registered_office_country` SET TAGS ('dbx_business_glossary_term' = 'Registered Office Country');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `registered_office_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `reporting_cadence` SET TAGS ('dbx_business_glossary_term' = 'Reporting Cadence');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `reporting_cadence` SET TAGS ('dbx_value_regex' = 'daily|weekly|bi-weekly|monthly|quarterly');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `trading_name` SET TAGS ('dbx_business_glossary_term' = 'Trading Name (DBA)');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `vat_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Number');
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ALTER COLUMN `vat_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `advertiser_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Hierarchy ID');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Child Advertiser ID');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `parent_advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Advertiser ID');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `primary_root_advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Root Advertiser ID');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `agency_commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission Rate');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `agency_commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `billing_consolidation_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Consolidation Flag');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Change Reason');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `consolidation_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Flag');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `crm_hierarchy_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Hierarchy ID');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `data_sharing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Consent Flag');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `hierarchy_code` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Hierarchy Code');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `hierarchy_code` SET TAGS ('dbx_value_regex' = '^AH-[A-Z0-9]{6,12}$');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `hierarchy_description` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Relationship Description');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `hierarchy_name` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Relationship Name');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `hierarchy_status` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Status');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `hierarchy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated|suspended');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Type');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_value_regex' = 'holding_company|subsidiary|brand_portfolio|brand|sub_brand|division');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `industry_sector` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `is_primary_hierarchy` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Hierarchy Flag');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `market_region` SET TAGS ('dbx_business_glossary_term' = 'Market Region');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `prisma_hierarchy_code` SET TAGS ('dbx_business_glossary_term' = 'Mediaocean Prisma Hierarchy ID');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `relationship_role` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Relationship Role');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `relationship_role` SET TAGS ('dbx_value_regex' = 'owner|licensee|franchisee|joint_venture|affiliate|managed_entity');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `reporting_consolidation_flag` SET TAGS ('dbx_business_glossary_term' = 'Reporting Consolidation Flag');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|mediaocean_prisma|campaign_manager_360|the_trade_desk|manual');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `sov_rollup_flag` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Roll-Up Flag');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Brand ID');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `client_brand_campaign_manager_advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Google Campaign Manager 360 Advertiser ID');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Account Manager ID');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `annual_media_budget` SET TAGS ('dbx_business_glossary_term' = 'Annual Media Budget');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `annual_media_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `brand_category` SET TAGS ('dbx_business_glossary_term' = 'Brand Category');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `brand_description` SET TAGS ('dbx_business_glossary_term' = 'Brand Description');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `brand_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `brand_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Status');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `brand_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|archived|pending_launch');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `brand_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Tier');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `brand_tier` SET TAGS ('dbx_value_regex' = 'premium|mainstream|value|luxury|challenger');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `brand_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `budget_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `crm_brand_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Brand ID');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `dam_folder_code` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Management (DAM) Folder ID');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `data_privacy_classification` SET TAGS ('dbx_business_glossary_term' = 'Brand Data Privacy Classification');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `data_privacy_classification` SET TAGS ('dbx_value_regex' = 'standard|sensitive|restricted|children');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `digital_advertising_enabled` SET TAGS ('dbx_business_glossary_term' = 'Digital Advertising Enabled Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Discontinuation Date');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `guidelines_url` SET TAGS ('dbx_business_glossary_term' = 'Brand Guidelines URL');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `guidelines_url` SET TAGS ('dbx_value_regex' = '^https?://[^s/$.?#].[^s]*$');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `guidelines_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `iab_category_code` SET TAGS ('dbx_business_glossary_term' = 'Interactive Advertising Bureau (IAB) Category Code');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `iab_category_code` SET TAGS ('dbx_value_regex' = '^IAB[0-9]{1,3}(-[0-9]{1,3})?$');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `is_house_brand` SET TAGS ('dbx_business_glossary_term' = 'House Brand Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Launch Date');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `nielsen_brand_code` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Ad Intel Brand Code');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `operating_markets` SET TAGS ('dbx_business_glossary_term' = 'Brand Operating Markets');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `portfolio_rank` SET TAGS ('dbx_business_glossary_term' = 'Brand Portfolio Rank');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `primary_channel` SET TAGS ('dbx_business_glossary_term' = 'Primary Advertising Channel');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `primary_channel` SET TAGS ('dbx_value_regex' = 'digital|television|ooh|print|radio|integrated');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `primary_market_country` SET TAGS ('dbx_business_glossary_term' = 'Primary Market Country');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `primary_market_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `prisma_brand_code` SET TAGS ('dbx_business_glossary_term' = 'Mediaocean Prisma Brand Code');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `programmatic_eligible` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Advertising Eligible Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `regulatory_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Brand Regulatory Restrictions');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `safety_level` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Level');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `safety_level` SET TAGS ('dbx_value_regex' = 'standard|strict|custom|unrestricted');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `sov_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Target Percentage');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `sov_target_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `sub_category` SET TAGS ('dbx_business_glossary_term' = 'Brand Sub-Category');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `tagline` SET TAGS ('dbx_business_glossary_term' = 'Brand Tagline');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `tagline` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Brand Target Demographic');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Brand Website URL');
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://[^s/$.?#].[^s]*$');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact ID');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `account_role` SET TAGS ('dbx_business_glossary_term' = 'Contact Account Role');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `account_role` SET TAGS ('dbx_value_regex' = 'decision_maker|influencer|approver|end_user|champion');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `ccpa_opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Opt-Out Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Contact City');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `contact_source` SET TAGS ('dbx_business_glossary_term' = 'Contact Source');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `contact_source` SET TAGS ('dbx_value_regex' = 'crm|referral|event|inbound|outbound|partner');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|departed');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|billing|legal|technical');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Contact Country Code');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `crm_contact_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Contact ID');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `data_subject_request_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request (DSR) Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `departed_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Departed Date');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Contact Department');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Contact Primary Email Address');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `gdpr_consent_date` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Date');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `gdpr_consent_status` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Status');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `gdpr_consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|pending|not_applicable');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `is_billing_contact` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Indicator');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `is_legal_signatory` SET TAGS ('dbx_business_glossary_term' = 'Legal Signatory Indicator');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Indicator');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Contact Job Title');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Contact Preferred Language');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `last_interaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Interaction Date');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `linkedin_profile_url` SET TAGS ('dbx_business_glossary_term' = 'Contact LinkedIn Profile URL');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `linkedin_profile_url` SET TAGS ('dbx_value_regex' = '^https://(www.)?linkedin.com/in/[a-zA-Z0-9-_%]+/?$');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `linkedin_profile_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `linkedin_profile_url` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `marketing_opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Communications Opt-Out Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Mobile Phone Number');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `nps_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Date');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Primary Phone Number');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|linkedin|video_call');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Relationship Start Date');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `secondary_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Secondary Email Address');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `secondary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `secondary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `secondary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `seniority_level` SET TAGS ('dbx_business_glossary_term' = 'Contact Seniority Level');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `seniority_level` SET TAGS ('dbx_value_regex' = 'C-Suite|VP|Director|Manager|Specialist|Coordinator');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Contact Time Zone');
ALTER TABLE `advertising_ecm`.`client`.`client_contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`account_team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`client`.`account_team` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `account_team_id` SET TAGS ('dbx_business_glossary_term' = 'Account Team ID');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `tertiary_account_approved_by_employee_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `account_access_level` SET TAGS ('dbx_business_glossary_term' = 'Account Access Level');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `account_access_level` SET TAGS ('dbx_value_regex' = 'read|edit|all');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Approval Date');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `assignment_code` SET TAGS ('dbx_business_glossary_term' = 'Assignment Code');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `assignment_code` SET TAGS ('dbx_value_regex' = '^AT-[A-Z0-9]{6,12}$');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|transitioning|inactive|pending');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'dedicated|shared|project_based|interim');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `billing_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Type');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `billing_rate_type` SET TAGS ('dbx_value_regex' = 'hourly|daily|monthly|fixed');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `billing_rate_usd` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate (USD)');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `billing_rate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `client_facing_flag` SET TAGS ('dbx_business_glossary_term' = 'Client-Facing Flag');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `conflict_of_interest_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest Flag');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `conflict_review_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest Review Date');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `conflict_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest Review Outcome');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `conflict_review_outcome` SET TAGS ('dbx_value_regex' = 'cleared|waived|escalated|pending');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `fte_allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation Percentage');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `is_backup_contact` SET TAGS ('dbx_business_glossary_term' = 'Backup Contact Flag');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assignment Review Date');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assignment Review Date');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `org_chart_display_order` SET TAGS ('dbx_business_glossary_term' = 'Org Chart Display Order');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `planned_hours_per_month` SET TAGS ('dbx_business_glossary_term' = 'Planned Hours Per Month');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `qbr_presenter_flag` SET TAGS ('dbx_business_glossary_term' = 'Quarterly Business Review (QBR) Presenter Flag');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `role` SET TAGS ('dbx_business_glossary_term' = 'Account Team Role');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `role` SET TAGS ('dbx_value_regex' = 'Account Director|Strategic Planner|Media Lead|Creative Director|Account Manager|Media Buyer');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `salesforce_team_member_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Account Team Member ID');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `salesforce_team_member_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `salesforce_team_member_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `seniority_level` SET TAGS ('dbx_business_glossary_term' = 'Seniority Level');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `seniority_level` SET TAGS ('dbx_value_regex' = 'junior|mid|senior|lead|executive');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `team_function` SET TAGS ('dbx_business_glossary_term' = 'Team Function');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `team_function` SET TAGS ('dbx_value_regex' = 'account_management|media|creative|strategy|analytics|pr');
ALTER TABLE `advertising_ecm`.`client`.`account_team` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`client`.`address` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Client Address ID');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact ID');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|unverified|invalid|archived');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'billing|shipping|registered_office|regional_office|mailing');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `attention_line` SET TAGS ('dbx_business_glossary_term' = 'Attention Line');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `crm_address_code` SET TAGS ('dbx_business_glossary_term' = 'CRM (Customer Relationship Management) Address ID');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `crm_address_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `crm_address_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'salesforce_crm|sap_s4hana|mediaocean_prisma|manual_entry|client_portal|import');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `deliverability_score` SET TAGS ('dbx_business_glossary_term' = 'Address Deliverability Score');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA) Code');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `dma_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Address Effective From Date');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Address Effective Until Date');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `erp_address_code` SET TAGS ('dbx_business_glossary_term' = 'ERP Address ID');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `erp_address_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `erp_address_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `format_type` SET TAGS ('dbx_business_glossary_term' = 'Address Format Type');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `format_type` SET TAGS ('dbx_value_regex' = 'domestic|international|military|po_box');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `gdpr_lawful_basis` SET TAGS ('dbx_business_glossary_term' = 'GDPR Lawful Basis for Processing');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `gdpr_lawful_basis` SET TAGS ('dbx_value_regex' = 'consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `geocoding_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Geocoding Accuracy Level');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `geocoding_accuracy` SET TAGS ('dbx_value_regex' = 'rooftop|range_interpolated|geometric_center|approximate');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `is_billing_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Billing Address Flag');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `is_do_not_mail` SET TAGS ('dbx_business_glossary_term' = 'Do Not Mail Flag');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Address Flag');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Geocoordinate)');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_business_glossary_term' = 'Address Line 3');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Geocoordinate)');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Address Notes');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `po_box` SET TAGS ('dbx_business_glossary_term' = 'Post Office (PO) Box');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `po_box` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `po_box` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Date');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `validation_source` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Source');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `advertising_ecm`.`client`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|failed|pending|not_attempted');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `agency_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Relationship ID');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `annual_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Fee Amount');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `annual_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `aor_designation` SET TAGS ('dbx_business_glossary_term' = 'Agency of Record (AOR) Designation');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `brand_scope` SET TAGS ('dbx_business_glossary_term' = 'Brand Scope');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `client_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Client Contact Email Address');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `client_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `client_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `client_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `commission_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `commission_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `competitive_conflict_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Conflict Flag');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `conflict_category` SET TAGS ('dbx_business_glossary_term' = 'Competitive Conflict Category');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `crm_opportunity_code` SET TAGS ('dbx_business_glossary_term' = 'CRM (Customer Relationship Management) Opportunity ID');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `current_event_type` SET TAGS ('dbx_business_glossary_term' = 'Current Relationship Event Type');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Effective End Date');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Effective Start Date');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `estimated_annual_billings` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Billings');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `estimated_annual_billings` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `event_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Event Effective Date');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `event_notes` SET TAGS ('dbx_business_glossary_term' = 'Relationship Event Notes');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `event_trigger` SET TAGS ('dbx_business_glossary_term' = 'Relationship Event Trigger');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `fee_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Structure Type');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `fee_structure_type` SET TAGS ('dbx_value_regex' = 'retainer_fee|commission_based|project_fee|performance_based|hybrid');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `incumbent_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Incumbent Agency Name');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `lead_account_director` SET TAGS ('dbx_business_glossary_term' = 'Lead Account Director');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `mediaocean_client_code` SET TAGS ('dbx_business_glossary_term' = 'Mediaocean Prisma Client Code');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `mediaocean_client_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{2,20}$');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Relationship Review Date');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Contractual Notice Period (Days)');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `pitch_type` SET TAGS ('dbx_business_glossary_term' = 'Pitch Type');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `pitch_type` SET TAGS ('dbx_value_regex' = 'competitive_review|direct_award|incumbent_retention|rfi_rfp');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `pitch_win_date` SET TAGS ('dbx_business_glossary_term' = 'Pitch Win Date');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `previous_relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Relationship Status');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `previous_relationship_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|terminated|under_review');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `primary_client_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Client Contact Name');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `primary_client_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `relationship_code` SET TAGS ('dbx_business_glossary_term' = 'Agency Relationship Code');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `relationship_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,30}$');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Agency Relationship Status');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|terminated|under_review');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `relationship_tier` SET TAGS ('dbx_business_glossary_term' = 'Relationship Tier');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `relationship_tier` SET TAGS ('dbx_value_regex' = 'strategic|key_account|standard|emerging');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Agency Relationship Type');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'aor|project_based|retainer|roster_agency|preferred_vendor');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Renewal Date');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Relationship Review Cycle');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'annual|biannual|quarterly|ad_hoc');
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ALTER COLUMN `scope_of_services` SET TAGS ('dbx_business_glossary_term' = 'Scope of Services');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `client_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Client Segment ID');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `abm_eligible` SET TAGS ('dbx_business_glossary_term' = 'Account-Based Marketing (ABM) Eligible Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `crm_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Segment ID');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `data_privacy_tier` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Tier');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `data_privacy_tier` SET TAGS ('dbx_value_regex' = 'standard|enhanced|strict');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `dedicated_account_team_required` SET TAGS ('dbx_business_glossary_term' = 'Dedicated Account Team Required Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Effective End Date');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Effective Start Date');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `geographic_market` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `iab_industry_vertical_code` SET TAGS ('dbx_business_glossary_term' = 'Interactive Advertising Bureau (IAB) Industry Vertical Code');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `iab_industry_vertical_code` SET TAGS ('dbx_value_regex' = '^IAB[0-9]{1,3}(-[0-9]{1,3})?$');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `iab_industry_vertical_name` SET TAGS ('dbx_business_glossary_term' = 'Interactive Advertising Bureau (IAB) Industry Vertical Name');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `is_primary_segment` SET TAGS ('dbx_business_glossary_term' = 'Primary Segment Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Segment Review Date');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `min_annual_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Minimum Annual Spend (USD)');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `min_annual_spend_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Segment Review Date');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `owner_email` SET TAGS ('dbx_business_glossary_term' = 'Segment Owner Email Address');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Owner Name');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `primary_channel_mix` SET TAGS ('dbx_business_glossary_term' = 'Primary Channel Mix');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `programmatic_buying_eligible` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Buying Eligible Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `revenue_threshold_max_usd` SET TAGS ('dbx_business_glossary_term' = 'Maximum Revenue Threshold (USD)');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `revenue_threshold_max_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `revenue_threshold_min_usd` SET TAGS ('dbx_business_glossary_term' = 'Minimum Revenue Threshold (USD)');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `revenue_threshold_min_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `review_cadence` SET TAGS ('dbx_business_glossary_term' = 'Segment Review Cadence');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `review_cadence` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `scoring_methodology` SET TAGS ('dbx_business_glossary_term' = 'Segmentation Scoring Methodology');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `scoring_weight_growth_potential` SET TAGS ('dbx_business_glossary_term' = 'Growth Potential Scoring Weight');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `scoring_weight_growth_potential` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `scoring_weight_revenue` SET TAGS ('dbx_business_glossary_term' = 'Revenue Scoring Weight');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `scoring_weight_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `scoring_weight_strategic_fit` SET TAGS ('dbx_business_glossary_term' = 'Strategic Fit Scoring Weight');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `scoring_weight_strategic_fit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Client Segment Code');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Client Segment Description');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Client Segment Name');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Client Segment Status');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|deprecated');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `segment_tier` SET TAGS ('dbx_business_glossary_term' = 'Client Segment Tier');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `segment_tier` SET TAGS ('dbx_value_regex' = 'enterprise|mid_market|smb|strategic_growth');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Client Segment Type');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'revenue_tier|industry_vertical|geographic_market|strategic|behavioral');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `service_tier_level` SET TAGS ('dbx_business_glossary_term' = 'Service Tier Level');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `service_tier_level` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `target_roas_benchmark` SET TAGS ('dbx_business_glossary_term' = 'Target Return on Ad Spend (ROAS) Benchmark');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`client_segment` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Segment Version Number');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `client_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brief ID');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Contact ID');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Brief Owner Worker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `persona_id` SET TAGS ('dbx_business_glossary_term' = 'Target Persona Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Brief Approval Date');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `brand_guidelines_version` SET TAGS ('dbx_business_glossary_term' = 'Brand Guidelines Version');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `brief_number` SET TAGS ('dbx_business_glossary_term' = 'Brief Reference Number');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `brief_number` SET TAGS ('dbx_value_regex' = '^BRF-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `brief_status` SET TAGS ('dbx_business_glossary_term' = 'Brief Status');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `brief_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|in_progress|on_hold|closed');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `brief_type` SET TAGS ('dbx_business_glossary_term' = 'Brief Type');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `brief_type` SET TAGS ('dbx_value_regex' = 'campaign|creative|media|pr|digital|brand_strategy');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `budget_indication_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Indication Amount');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `budget_indication_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `campaign_end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `campaign_objective` SET TAGS ('dbx_business_glossary_term' = 'Campaign Objective');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `campaign_start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `channel_requirements` SET TAGS ('dbx_business_glossary_term' = 'Channel Requirements');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Brief Closed Date');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Brief Closure Reason');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `closure_reason` SET TAGS ('dbx_value_regex' = 'completed|cancelled_by_client|cancelled_by_agency|merged|superseded');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `competitive_context` SET TAGS ('dbx_business_glossary_term' = 'Competitive Context');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `competitive_context` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `creative_format_requirements` SET TAGS ('dbx_business_glossary_term' = 'Creative Format Requirements');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `deliverable_due_date` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Due Date');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `is_agency_managed` SET TAGS ('dbx_business_glossary_term' = 'Agency Managed Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Brief Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `key_message` SET TAGS ('dbx_business_glossary_term' = 'Key Message');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `mandatory_exclusions` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Exclusions');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `mandatory_inclusions` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Inclusions');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `primary_kpi` SET TAGS ('dbx_business_glossary_term' = 'Primary Key Performance Indicator (KPI)');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `primary_kpi_target_value` SET TAGS ('dbx_business_glossary_term' = 'Primary KPI Target Value');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Brief Priority Level');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Brief Revision Reason');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `salesforce_opportunity_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Opportunity ID');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `secondary_kpi` SET TAGS ('dbx_business_glossary_term' = 'Secondary Key Performance Indicator (KPI)');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Brief Submission Date');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Brief Title');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Brief Version Number');
ALTER TABLE `advertising_ecm`.`client`.`interaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`client`.`interaction` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Client Interaction ID');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact ID');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `creative_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Owner ID');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `interaction_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager ID');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `agency_attendees` SET TAGS ('dbx_business_glossary_term' = 'Agency Attendees');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `agenda` SET TAGS ('dbx_business_glossary_term' = 'Interaction Agenda');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `business_topic` SET TAGS ('dbx_business_glossary_term' = 'Business Topic');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Interaction Channel');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'in_person|video|phone|email|instant_message');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `client_attendees` SET TAGS ('dbx_business_glossary_term' = 'Client Attendees');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `client_attendees` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `client_sentiment` SET TAGS ('dbx_business_glossary_term' = 'Client Sentiment');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `client_sentiment` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|at_risk');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `crm_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Activity ID');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `data_region` SET TAGS ('dbx_business_glossary_term' = 'Data Region');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `data_region` SET TAGS ('dbx_value_regex' = 'AMER|EMEA|APAC|LATAM');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Interaction Direction');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interaction Duration (Minutes)');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interaction End Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `follow_up_actions` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Actions');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `gdpr_consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Obtained Flag');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `interaction_date` SET TAGS ('dbx_business_glossary_term' = 'Interaction Date');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_business_glossary_term' = 'Interaction Status');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_value_regex' = 'scheduled|completed|cancelled|rescheduled|no_show');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_business_glossary_term' = 'Interaction Type');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_value_regex' = 'meeting|call|email|presentation|qbr|site_visit');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `is_escalation` SET TAGS ('dbx_business_glossary_term' = 'Is Escalation Flag');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `is_qbr` SET TAGS ('dbx_business_glossary_term' = 'Is Quarterly Business Review (QBR) Flag');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Interaction Location');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `opportunity_code` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `outcome_summary` SET TAGS ('dbx_business_glossary_term' = 'Interaction Outcome Summary');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `presentation_url` SET TAGS ('dbx_business_glossary_term' = 'Presentation URL');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Interaction Priority');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `recording_url` SET TAGS ('dbx_business_glossary_term' = 'Interaction Recording URL');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `recording_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interaction Start Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`interaction` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Interaction Subject');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `nps_response_id` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Response ID');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Respondent Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact ID');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager ID');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `survey_wave_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Wave ID');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `anonymized_flag` SET TAGS ('dbx_business_glossary_term' = 'Anonymized Flag');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `at_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'At-Risk Account Flag');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `business_segment` SET TAGS ('dbx_business_glossary_term' = 'Business Segment');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `business_segment` SET TAGS ('dbx_value_regex' = 'enterprise|mid_market|smb|agency|direct');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `client_tenure_months` SET TAGS ('dbx_business_glossary_term' = 'Client Tenure (Months)');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Consent Given Flag');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `crm_survey_record_code` SET TAGS ('dbx_business_glossary_term' = 'CRM Survey Record ID');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `data_processing_basis` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Basis');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `data_processing_basis` SET TAGS ('dbx_value_regex' = 'consent|legitimate_interest|contract|legal_obligation');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `follow_up_notes` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Notes');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `follow_up_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `follow_up_status` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Status');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `follow_up_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|not_required|escalated');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `improvement_suggestion` SET TAGS ('dbx_business_glossary_term' = 'Improvement Suggestion');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `improvement_suggestion` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `industry_vertical` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Score');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `nps_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `qbr_linked_flag` SET TAGS ('dbx_business_glossary_term' = 'Quarterly Business Review (QBR) Linked Flag');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `relationship_aspect` SET TAGS ('dbx_business_glossary_term' = 'Relationship Aspect');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `relationship_aspect` SET TAGS ('dbx_value_regex' = 'strategic_counsel|creative_quality|responsiveness|reporting|media_execution|overall_value');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `relationship_aspect_rating` SET TAGS ('dbx_business_glossary_term' = 'Relationship Aspect Rating');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `reminder_count` SET TAGS ('dbx_business_glossary_term' = 'Reminder Count');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `respondent_category` SET TAGS ('dbx_business_glossary_term' = 'Respondent Category');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `respondent_category` SET TAGS ('dbx_value_regex' = 'promoter|passive|detractor');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `respondent_role` SET TAGS ('dbx_business_glossary_term' = 'Respondent Role');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `respondent_role` SET TAGS ('dbx_value_regex' = 'decision_maker|day_to_day|executive_sponsor|procurement|finance');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'submitted|partial|declined|expired|invalidated');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `survey_channel` SET TAGS ('dbx_business_glossary_term' = 'Survey Channel');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `survey_channel` SET TAGS ('dbx_value_regex' = 'email|web|phone|in_person|sms');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Date');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `survey_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Expiry Date');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `survey_invitation_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Survey Invitation Sent Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `survey_language` SET TAGS ('dbx_business_glossary_term' = 'Survey Language');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `survey_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `survey_response_code` SET TAGS ('dbx_business_glossary_term' = 'Survey Response Code');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `survey_response_code` SET TAGS ('dbx_value_regex' = '^NPS-[A-Z0-9]{6,12}$');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'post_campaign|quarterly|annual|ad_hoc|onboarding|offboarding');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `verbatim_feedback` SET TAGS ('dbx_business_glossary_term' = 'Verbatim Feedback');
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ALTER COLUMN `verbatim_feedback` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`preference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`client`.`preference` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `preference_id` SET TAGS ('dbx_business_glossary_term' = 'Client Preference ID');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Excluded Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact ID');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `approval_turnaround_days` SET TAGS ('dbx_business_glossary_term' = 'Approval Turnaround Days');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `approval_workflow_type` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Type');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `approval_workflow_type` SET TAGS ('dbx_value_regex' = 'single_approver|sequential|parallel|no_approval_required');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `audience_data_usage_allowed` SET TAGS ('dbx_business_glossary_term' = 'Audience Data Usage Allowed Flag');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `audience_data_usage_allowed` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Tier');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_value_regex' = 'standard|strict|custom');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `budget_alert_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Budget Alert Threshold Percentage');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `competitive_reporting_allowed` SET TAGS ('dbx_business_glossary_term' = 'Competitive Reporting Allowed Flag');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `consent_capture_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Capture Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `consent_capture_timestamp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `consent_version` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `creative_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Creative Approval Required Flag');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `crm_record_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Record ID');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `data_sharing_consent_ccpa` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Data Sharing Consent Flag');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `data_sharing_consent_ccpa` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `data_sharing_consent_gdpr` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Data Sharing Consent Flag');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `data_sharing_consent_gdpr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `fraud_verification_required` SET TAGS ('dbx_business_glossary_term' = 'Ad Fraud Verification Required Flag');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Invoice Delivery Method');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_value_regex' = 'email|postal|portal|edi');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `invoice_format` SET TAGS ('dbx_business_glossary_term' = 'Invoice Format');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `invoice_format` SET TAGS ('dbx_value_regex' = 'pdf|xml|csv|edi_x12|ubl');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `io_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) Approval Required Flag');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `media_plan_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Approval Required Flag');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Preference Notes');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `pacing_alert_enabled` SET TAGS ('dbx_business_glossary_term' = 'Pacing Alert Enabled Flag');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `preference_scope` SET TAGS ('dbx_business_glossary_term' = 'Preference Scope');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `preference_scope` SET TAGS ('dbx_value_regex' = 'account|contact');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_business_glossary_term' = 'Preference Status');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_review|superseded');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|video_call|in_person|portal|slack');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `preferred_dsp` SET TAGS ('dbx_business_glossary_term' = 'Preferred Demand-Side Platform (DSP)');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `preferred_kpi_set` SET TAGS ('dbx_business_glossary_term' = 'Preferred Key Performance Indicator (KPI) Set');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language Code');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `preferred_meeting_format` SET TAGS ('dbx_business_glossary_term' = 'Preferred Meeting Format');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `preferred_meeting_format` SET TAGS ('dbx_value_regex' = 'in_person|virtual|hybrid');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `preferred_timezone` SET TAGS ('dbx_business_glossary_term' = 'Preferred Time Zone');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `report_delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Report Delivery Channel');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `report_delivery_channel` SET TAGS ('dbx_value_regex' = 'email|portal|api|sftp');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `report_format` SET TAGS ('dbx_business_glossary_term' = 'Report Format');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `report_format` SET TAGS ('dbx_value_regex' = 'pdf|excel|csv|dashboard_link|pptx');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `reporting_cadence` SET TAGS ('dbx_business_glossary_term' = 'Reporting Cadence');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `reporting_cadence` SET TAGS ('dbx_value_regex' = 'daily|weekly|bi_weekly|monthly|quarterly');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `third_party_data_sharing_allowed` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Data Sharing Allowed Flag');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `third_party_data_sharing_allowed` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `viewability_standard` SET TAGS ('dbx_business_glossary_term' = 'Viewability Standard');
ALTER TABLE `advertising_ecm`.`client`.`preference` ALTER COLUMN `viewability_standard` SET TAGS ('dbx_value_regex' = 'mrc|groupm|custom');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `competitive_conflict_id` SET TAGS ('dbx_business_glossary_term' = 'Competitive Conflict ID');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser A ID');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Account Director ID');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `task_id` SET TAGS ('dbx_business_glossary_term' = 'Workfront Task ID');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `aor_contract_clause` SET TAGS ('dbx_business_glossary_term' = 'Agency of Record (AOR) Contract Clause Reference');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `aor_contract_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `board_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Board-Level Approval Reference');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `board_approval_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `client_a_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Client A Conflict Notification Date');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `client_a_waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Client A Waiver Date');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `client_b_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Client B Conflict Notification Date');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `client_b_waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Client B Waiver Date');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `conflict_description` SET TAGS ('dbx_business_glossary_term' = 'Competitive Conflict Description');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `conflict_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `conflict_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Competitive Conflict Reference Code');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `conflict_reference_code` SET TAGS ('dbx_value_regex' = '^CC-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `conflict_severity` SET TAGS ('dbx_business_glossary_term' = 'Competitive Conflict Severity');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `conflict_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `conflict_status` SET TAGS ('dbx_business_glossary_term' = 'Competitive Conflict Resolution Status');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `conflict_status` SET TAGS ('dbx_value_regex' = 'declared|under_review|resolved|waived|escalated|expired');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `conflict_type` SET TAGS ('dbx_business_glossary_term' = 'Competitive Conflict Type');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `conflict_type` SET TAGS ('dbx_value_regex' = 'direct_competitor|indirect_adjacent|category_overlap|channel_overlap|geographic_overlap');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `crm_record_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM Record ID');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `declaration_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict Declaration Date');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `declaring_party` SET TAGS ('dbx_business_glossary_term' = 'Conflict Declaring Party');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `declaring_party` SET TAGS ('dbx_value_regex' = 'agency|client_a|client_b|legal_counsel|new_business_team');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `eo_insurance_notified` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Insurance Notified Flag');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `geographic_markets` SET TAGS ('dbx_business_glossary_term' = 'Conflict Geographic Markets');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Conflict Geographic Scope');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|national|local');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `iab_category_code` SET TAGS ('dbx_business_glossary_term' = 'Interactive Advertising Bureau (IAB) Content Category Code');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `iab_category_code` SET TAGS ('dbx_value_regex' = '^IAB[0-9]{1,2}(-[0-9]{1,3})?$');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `iab_category_name` SET TAGS ('dbx_business_glossary_term' = 'Interactive Advertising Bureau (IAB) Content Category Name');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `information_barrier_implemented` SET TAGS ('dbx_business_glossary_term' = 'Information Barrier (Chinese Wall) Implemented Flag');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completion Date');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `legal_review_required` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `pitch_eligibility_blocked` SET TAGS ('dbx_business_glossary_term' = 'New Business Pitch Eligibility Blocked Flag');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `resolution_approach` SET TAGS ('dbx_business_glossary_term' = 'Conflict Resolution Approach');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `resolution_approach` SET TAGS ('dbx_value_regex' = 'chinese_wall|client_waiver|account_resignation|category_carve_out|team_separation');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict Resolution Date');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Conflict Resolution Notes');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `review_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict Review Expiry Date');
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `revenue_target_id` SET TAGS ('dbx_business_glossary_term' = 'Client Revenue Target ID');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `primary_revenue_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Target Owner Employee ID');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `account_growth_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Account Growth Rate Percentage');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `account_growth_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Target Approval Date');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Target Confidence Level');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `contracted_sow_coverage_pct` SET TAGS ('dbx_business_glossary_term' = 'Contracted Statement of Work (SOW) Coverage Percentage');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `contracted_sow_coverage_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `cost_centre_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Code');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `cost_centre_code` SET TAGS ('dbx_value_regex' = '^CC-[A-Z0-9]{4,10}$');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `crm_opportunity_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Opportunity ID');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `fx_rate_applied` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate Applied');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `is_stretch_target` SET TAGS ('dbx_business_glossary_term' = 'Is Stretch Target Flag');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Target Notes');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `original_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Revenue Target Amount');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `original_target_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Target Period End Date');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Period Start Date');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `pipeline_amount` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Revenue Amount');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `pipeline_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `profit_centre_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Code');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `profit_centre_code` SET TAGS ('dbx_value_regex' = '^PC-[A-Z0-9]{4,10}$');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Target Revision Number');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Target Revision Reason');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `roas_target` SET TAGS ('dbx_business_glossary_term' = 'Return on Ad Spend (ROAS) Target');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `service_line` SET TAGS ('dbx_value_regex' = 'media|creative|digital|pr|analytics|strategy');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `target_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Target Amount');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `target_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `target_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Revenue Target Amount (USD)');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `target_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `target_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Target Code');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `target_code` SET TAGS ('dbx_value_regex' = '^RT-[A-Z0-9]{4,12}$');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `target_name` SET TAGS ('dbx_business_glossary_term' = 'Revenue Target Name');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `target_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Target Owner Name');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `target_period_type` SET TAGS ('dbx_business_glossary_term' = 'Target Period Type');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `target_period_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `target_setting_method` SET TAGS ('dbx_business_glossary_term' = 'Target Setting Method');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `target_setting_method` SET TAGS ('dbx_value_regex' = 'top_down|bottom_up|negotiated|market_indexed');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `target_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Target Status');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `target_type` SET TAGS ('dbx_business_glossary_term' = 'Revenue Target Type');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `target_type` SET TAGS ('dbx_value_regex' = 'gross_revenue|net_revenue|fee_income|commission_income|retainer_fee');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `target_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `client_consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Client Consent Record ID');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact ID');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `ccpa_applicable` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Applicable Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `consent_basis` SET TAGS ('dbx_business_glossary_term' = 'Consent Legal Basis');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `consent_basis` SET TAGS ('dbx_value_regex' = 'gdpr_art6_consent|gdpr_art6_legitimate_interest|gdpr_art6_contract|ccpa_opt_out|ccpa_opt_in|can_spam');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `consent_channel` SET TAGS ('dbx_business_glossary_term' = 'Consent Capture Channel');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Capture Date and Time');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `consent_proof_reference` SET TAGS ('dbx_business_glossary_term' = 'Consent Proof Reference');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `consent_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Reference Number');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `consent_reference_number` SET TAGS ('dbx_value_regex' = '^CNS-[A-Z0-9]{8,16}$');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'active|withdrawn|expired|pending|refused');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'marketing_communications|data_processing|third_party_sharing|profiling|retargeting|analytics');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Notice Version');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `consent_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `crm_consent_record_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Consent Record ID');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `data_categories_covered` SET TAGS ('dbx_business_glossary_term' = 'Data Categories Covered by Consent');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `data_subject_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Jurisdiction');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `data_subject_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `double_opt_in_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Double Opt-In Confirmed Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `double_opt_in_date` SET TAGS ('dbx_business_glossary_term' = 'Double Opt-In Confirmation Date and Time');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Consent Effective From Date');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Applicable Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `iab_tcf_consent_string` SET TAGS ('dbx_business_glossary_term' = 'IAB Transparency and Consent Framework (TCF) Consent String');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `iab_tcf_version` SET TAGS ('dbx_business_glossary_term' = 'IAB Transparency and Consent Framework (TCF) Version');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `iab_tcf_version` SET TAGS ('dbx_value_regex' = '1.1|2.0|2.1|2.2');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Consent Capture IP Address');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Notes');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `privacy_notice_url` SET TAGS ('dbx_business_glossary_term' = 'Privacy Notice URL');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `privacy_notice_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `processing_purpose` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Purpose');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `renewal_reminder_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Renewal Reminder Sent Date');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Consent Renewal Required Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `suppression_list_flag` SET TAGS ('dbx_business_glossary_term' = 'Suppression List Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `third_party_vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Vendor Name');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'Consent Capture User Agent');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Date');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Reason');
ALTER TABLE `advertising_ecm`.`client`.`client_consent_record` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_value_regex' = 'data_subject_request|regulatory_order|account_closure|preference_change|unsubscribe|other');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `relationship_history_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship History ID');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `agency_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Relationship Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Triggered By User ID');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `worker_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `account_team_lead_name` SET TAGS ('dbx_business_glossary_term' = 'Account Team Lead Name');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `account_team_lead_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `aor_scope` SET TAGS ('dbx_business_glossary_term' = 'Agency of Record (AOR) Scope');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `client_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Name');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `client_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `client_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Title');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `competing_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Competing Agency Name');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `competing_agency_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `competitive_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Review Flag');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `crm_opportunity_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Opportunity ID');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `escalation_severity` SET TAGS ('dbx_business_glossary_term' = 'Escalation Severity Level');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `escalation_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `estimated_revenue_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue Impact');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `estimated_revenue_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Event Date');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `event_narrative` SET TAGS ('dbx_business_glossary_term' = 'Relationship Event Narrative');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Relationship Event Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Event Type');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `io_reference` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) Reference');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Event Flag');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `is_confidential` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `new_state_description` SET TAGS ('dbx_business_glossary_term' = 'New State Description');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Relationship Status');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `new_status` SET TAGS ('dbx_value_regex' = 'prospect|active|at_risk|on_hold|churned|inactive');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `previous_state_description` SET TAGS ('dbx_business_glossary_term' = 'Previous State Description');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Relationship Status');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `previous_status` SET TAGS ('dbx_value_regex' = 'prospect|active|at_risk|on_hold|churned|inactive');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `relationship_health_score` SET TAGS ('dbx_business_glossary_term' = 'Relationship Health Score');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `relationship_health_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `relationship_health_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `revenue_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Revenue Impact Currency Code');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `revenue_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|workfront|mediaocean_prisma|sap_s4hana|manual_entry');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `triggered_by_name` SET TAGS ('dbx_business_glossary_term' = 'Triggered By Name');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `triggered_by_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ALTER COLUMN `triggered_by_role` SET TAGS ('dbx_business_glossary_term' = 'Triggered By Role');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `client_onboarding_id` SET TAGS ('dbx_business_glossary_term' = 'Client Onboarding ID');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Lead Employee ID');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `workfront_project_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Workfront Project ID');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `restarted_from_client_onboarding_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `analytics_dashboard_created_flag` SET TAGS ('dbx_business_glossary_term' = 'Analytics Dashboard Created Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `analytics_dashboard_creation_date` SET TAGS ('dbx_business_glossary_term' = 'Analytics Dashboard Creation Date');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `billing_code_created_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Code Created Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `billing_code_creation_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Code Creation Date');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `blocker_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Blocker Resolution Date');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `blockers_description` SET TAGS ('dbx_business_glossary_term' = 'Blockers Description');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `brand_guidelines_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Brand Guidelines Received Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `credit_application_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Application Received Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `crm_account_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Account ID');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `crm_account_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{15,18}$');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `dam_access_provisioned_date` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Management (DAM) Access Provisioned Date');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `dam_access_provisioned_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Management (DAM) Access Provisioned Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `handoff_from_sales_date` SET TAGS ('dbx_business_glossary_term' = 'Handoff From Sales Date');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `kickoff_date` SET TAGS ('dbx_business_glossary_term' = 'Kickoff Date');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `media_authorization_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Media Authorization Forms Received Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `msa_signed_flag` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) Signed Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Notes');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'initiated|in_progress|blocked|completed|cancelled|on_hold');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `onboarding_type` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Type');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `onboarding_type` SET TAGS ('dbx_value_regex' = 'new_client|agency_transfer|brand_expansion|reactivation');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `post_onboarding_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Post-Onboarding Satisfaction Score');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `post_onboarding_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Onboarding Survey Date');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `project_management_setup_date` SET TAGS ('dbx_business_glossary_term' = 'Project Management Setup Date');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `project_management_setup_flag` SET TAGS ('dbx_business_glossary_term' = 'Project Management Setup Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Reference Number');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^ONB-[0-9]{6,10}$');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `service_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Tier');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `service_tier` SET TAGS ('dbx_value_regex' = 'enterprise|premium|standard|basic');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `sla_target_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Days');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ALTER COLUMN `w9_w8ben_received_flag` SET TAGS ('dbx_business_glossary_term' = 'W-9 or W-8BEN Received Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` SET TAGS ('dbx_association_edges' = 'client.advertiser,talent.talent_profile');
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` ALTER COLUMN `client_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'client_engagement Identifier');
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement - Advertiser Id');
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` ALTER COLUMN `talent_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Identifier');
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement - Talent Profile Id');
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` ALTER COLUMN `agreed_rate` SET TAGS ('dbx_business_glossary_term' = 'Agreed Rate');
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Engagement Approved By');
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Approved Date');
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` ALTER COLUMN `client_engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Status');
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Created Date');
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` ALTER COLUMN `engagement_type` SET TAGS ('dbx_business_glossary_term' = 'Engagement Type');
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` ALTER COLUMN `rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency');
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` ALTER COLUMN `role_title` SET TAGS ('dbx_business_glossary_term' = 'Engagement Role Title');
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` ALTER COLUMN `usage_rights_included` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Included');
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Engagement Created By');
ALTER TABLE `advertising_ecm`.`client`.`preferred_vendor` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`client`.`preferred_vendor` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `advertising_ecm`.`client`.`preferred_vendor` SET TAGS ('dbx_association_edges' = 'client.advertiser,vendor.supplier');
ALTER TABLE `advertising_ecm`.`client`.`preferred_vendor` ALTER COLUMN `preferred_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Identifier');
ALTER TABLE `advertising_ecm`.`client`.`preferred_vendor` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor - Advertiser Id');
ALTER TABLE `advertising_ecm`.`client`.`preferred_vendor` ALTER COLUMN `vendor_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Rate Card Identifier');
ALTER TABLE `advertising_ecm`.`client`.`preferred_vendor` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor - Supplier Id');
ALTER TABLE `advertising_ecm`.`client`.`preferred_vendor` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Approval Status');
ALTER TABLE `advertising_ecm`.`client`.`preferred_vendor` ALTER COLUMN `brand_safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Advertiser-Specific Brand Safety Rating');
ALTER TABLE `advertising_ecm`.`client`.`preferred_vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`preferred_vendor` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Effective From Date');
ALTER TABLE `advertising_ecm`.`client`.`preferred_vendor` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Effective Until Date');
ALTER TABLE `advertising_ecm`.`client`.`preferred_vendor` ALTER COLUMN `minimum_spend_commitment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Spend Commitment Amount');
ALTER TABLE `advertising_ecm`.`client`.`preferred_vendor` ALTER COLUMN `onboarding_completed` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Completion Flag');
ALTER TABLE `advertising_ecm`.`client`.`preferred_vendor` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Tier');
ALTER TABLE `advertising_ecm`.`client`.`preferred_vendor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_segment_license` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_segment_license` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_segment_license` SET TAGS ('dbx_association_edges' = 'client.advertiser,audience.segment');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_segment_license` ALTER COLUMN `advertiser_segment_license_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Segment License ID');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_segment_license` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Segment License - Advertiser Id');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_segment_license` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Segment License - Segment Id');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_segment_license` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_segment_license` ALTER COLUMN `activation_status` SET TAGS ('dbx_business_glossary_term' = 'Activation Status');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_segment_license` ALTER COLUMN `contract_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference ID');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_segment_license` ALTER COLUMN `cost_allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Percentage');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_segment_license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_segment_license` ALTER COLUMN `data_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Data Provider Name');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_segment_license` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_segment_license` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_segment_license` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_segment_license` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_segment_license` ALTER COLUMN `license_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'License Cost Amount');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_segment_license` ALTER COLUMN `license_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'License Cost Currency');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_segment_license` ALTER COLUMN `license_cost_model` SET TAGS ('dbx_business_glossary_term' = 'License Cost Model');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_segment_license` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_segment_license` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `advertising_ecm`.`client`.`brand_supplier_approval` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`client`.`brand_supplier_approval` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `advertising_ecm`.`client`.`brand_supplier_approval` SET TAGS ('dbx_association_edges' = 'client.client_brand,vendor.supplier');
ALTER TABLE `advertising_ecm`.`client`.`brand_supplier_approval` ALTER COLUMN `brand_supplier_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Supplier Approval ID');
ALTER TABLE `advertising_ecm`.`client`.`brand_supplier_approval` ALTER COLUMN `brand_client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Supplier Approval - Client Brand Id');
ALTER TABLE `advertising_ecm`.`client`.`brand_supplier_approval` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand ID');
ALTER TABLE `advertising_ecm`.`client`.`brand_supplier_approval` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Supplier Approval - Supplier Id');
ALTER TABLE `advertising_ecm`.`client`.`brand_supplier_approval` ALTER COLUMN `annual_spend_commitment` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Commitment');
ALTER TABLE `advertising_ecm`.`client`.`brand_supplier_approval` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`client`.`brand_supplier_approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`client`.`brand_supplier_approval` ALTER COLUMN `approved_channels` SET TAGS ('dbx_business_glossary_term' = 'Approved Media Channels');
ALTER TABLE `advertising_ecm`.`client`.`brand_supplier_approval` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Tier');
ALTER TABLE `advertising_ecm`.`client`.`brand_supplier_approval` ALTER COLUMN `commitment_currency` SET TAGS ('dbx_business_glossary_term' = 'Commitment Currency');
ALTER TABLE `advertising_ecm`.`client`.`brand_supplier_approval` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `advertising_ecm`.`client`.`brand_supplier_approval` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `advertising_ecm`.`client`.`brand_supplier_approval` ALTER COLUMN `exclusion_list` SET TAGS ('dbx_business_glossary_term' = 'Content Exclusion List');
ALTER TABLE `advertising_ecm`.`client`.`brand_supplier_approval` ALTER COLUMN `exclusion_list` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`brand_supplier_approval` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Relationship Notes');
ALTER TABLE `advertising_ecm`.`client`.`brand_supplier_approval` ALTER COLUMN `preferred_formats` SET TAGS ('dbx_business_glossary_term' = 'Preferred Ad Formats');
ALTER TABLE `advertising_ecm`.`client`.`brand_supplier_approval` ALTER COLUMN `primary_account_manager` SET TAGS ('dbx_business_glossary_term' = 'Primary Account Manager');
ALTER TABLE `advertising_ecm`.`client`.`brand_supplier_approval` ALTER COLUMN `rate_negotiation_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Negotiation Status');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` SET TAGS ('dbx_association_edges' = 'client.advertiser,finance.cost_center');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` ALTER COLUMN `advertiser_cost_center_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'advertiser_cost_center_allocation Identifier');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Cost Center Allocation - Advertiser Id');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` ALTER COLUMN `allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Identifier');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Cost Center Allocation - Cost Center Id');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` ALTER COLUMN `billing_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Billing Arrangement');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` ALTER COLUMN `budget_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Amount');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective End Date');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective Start Date');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` ALTER COLUMN `sap_allocation_reference` SET TAGS ('dbx_business_glossary_term' = 'SAP Allocation Reference');
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `advertising_ecm`.`client`.`brief_approver` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`client`.`brief_approver` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `advertising_ecm`.`client`.`brief_approver` SET TAGS ('dbx_association_edges' = 'client.client_contact,creative.creative_brief');
ALTER TABLE `advertising_ecm`.`client`.`brief_approver` ALTER COLUMN `brief_approver_id` SET TAGS ('dbx_business_glossary_term' = 'Brief Approver ID');
ALTER TABLE `advertising_ecm`.`client`.`brief_approver` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Brief Approver - Client Contact Id');
ALTER TABLE `advertising_ecm`.`client`.`brief_approver` ALTER COLUMN `creative_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Brief Approver - Creative Brief Id');
ALTER TABLE `advertising_ecm`.`client`.`brief_approver` ALTER COLUMN `approval_chain` SET TAGS ('dbx_business_glossary_term' = 'Approval Chain');
ALTER TABLE `advertising_ecm`.`client`.`brief_approver` ALTER COLUMN `approval_role` SET TAGS ('dbx_business_glossary_term' = 'Approval Role');
ALTER TABLE `advertising_ecm`.`client`.`brief_approver` ALTER COLUMN `approval_sequence` SET TAGS ('dbx_business_glossary_term' = 'Approval Sequence');
ALTER TABLE `advertising_ecm`.`client`.`brief_approver` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`client`.`brief_approver` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`brief_approver` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Due Date');
ALTER TABLE `advertising_ecm`.`client`.`brief_approver` ALTER COLUMN `feedback_provided` SET TAGS ('dbx_business_glossary_term' = 'Feedback Provided');
ALTER TABLE `advertising_ecm`.`client`.`brief_approver` ALTER COLUMN `is_required_approver` SET TAGS ('dbx_business_glossary_term' = 'Is Required Approver');
ALTER TABLE `advertising_ecm`.`client`.`brief_approver` ALTER COLUMN `notified_date` SET TAGS ('dbx_business_glossary_term' = 'Notified Date');
ALTER TABLE `advertising_ecm`.`client`.`io_authorization` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`client`.`io_authorization` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `advertising_ecm`.`client`.`io_authorization` SET TAGS ('dbx_association_edges' = 'client.client_contact,media.media_insertion_order');
ALTER TABLE `advertising_ecm`.`client`.`io_authorization` ALTER COLUMN `io_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'IO Authorization Identifier');
ALTER TABLE `advertising_ecm`.`client`.`io_authorization` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Io Authorization - Client Contact Id');
ALTER TABLE `advertising_ecm`.`client`.`io_authorization` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Io Authorization - Media Insertion Order Id');
ALTER TABLE `advertising_ecm`.`client`.`io_authorization` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'IO Authorization Date');
ALTER TABLE `advertising_ecm`.`client`.`io_authorization` ALTER COLUMN `authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Authorization Level');
ALTER TABLE `advertising_ecm`.`client`.`io_authorization` ALTER COLUMN `authorization_method` SET TAGS ('dbx_business_glossary_term' = 'IO Authorization Method');
ALTER TABLE `advertising_ecm`.`client`.`io_authorization` ALTER COLUMN `authorization_method` SET TAGS ('dbx_value_regex' = 'wet_signature|electronic_signature|email_approval|verbal_confirmed');
ALTER TABLE `advertising_ecm`.`client`.`io_authorization` ALTER COLUMN `authorization_notes` SET TAGS ('dbx_business_glossary_term' = 'Authorization Notes');
ALTER TABLE `advertising_ecm`.`client`.`io_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `advertising_ecm`.`client`.`io_authorization` ALTER COLUMN `authorizing_party_name` SET TAGS ('dbx_business_glossary_term' = 'IO Authorizing Party Name');
ALTER TABLE `advertising_ecm`.`client`.`io_authorization` ALTER COLUMN `authorizing_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`io_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`io_authorization` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Signature IP Address');
ALTER TABLE `advertising_ecm`.`client`.`io_authorization` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`io_authorization` ALTER COLUMN `signatory_role` SET TAGS ('dbx_business_glossary_term' = 'Signatory Role');
ALTER TABLE `advertising_ecm`.`client`.`io_authorization` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Signature Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`io_authorization` ALTER COLUMN `signature_method` SET TAGS ('dbx_business_glossary_term' = 'Signature Method');
ALTER TABLE `advertising_ecm`.`client`.`io_authorization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `advertising_ecm`.`client`.`survey_wave` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`client`.`survey_wave` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `advertising_ecm`.`client`.`survey_wave` ALTER COLUMN `survey_wave_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Wave Identifier');
ALTER TABLE `advertising_ecm`.`client`.`survey_wave` ALTER COLUMN `previous_survey_wave_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`survey_wave` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`survey` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`client`.`survey` SET TAGS ('dbx_subdomain' = 'engagement_operations');
ALTER TABLE `advertising_ecm`.`client`.`survey` ALTER COLUMN `survey_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Identifier');
ALTER TABLE `advertising_ecm`.`client`.`survey` ALTER COLUMN `derived_from_survey_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`survey` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`client`.`legal_entity` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `advertising_ecm`.`client`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `advertising_ecm`.`client`.`legal_entity` ALTER COLUMN `annual_revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`legal_entity` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`legal_entity` ALTER COLUMN `employee_count` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`legal_entity` ALTER COLUMN `headquarters_address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`legal_entity` ALTER COLUMN `headquarters_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`legal_entity` ALTER COLUMN `headquarters_address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`legal_entity` ALTER COLUMN `headquarters_address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`legal_entity` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`legal_entity` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`legal_entity` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`legal_entity` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`legal_entity` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`legal_entity` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`legal_entity` ALTER COLUMN `primary_email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`legal_entity` ALTER COLUMN `primary_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`legal_entity` ALTER COLUMN `primary_phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`legal_entity` ALTER COLUMN `primary_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`client`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
