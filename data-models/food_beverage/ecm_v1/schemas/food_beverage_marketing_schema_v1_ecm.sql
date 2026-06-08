-- Schema for Domain: marketing | Business: Food Beverage | Version: v1_ecm
-- Generated on: 2026-05-05 21:26:24

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `food_beverage_ecm`.`marketing` COMMENT 'Brand management, consumer engagement, campaigns, advertising spend, marketing claims (FTC compliance), digital and shopper marketing, social media, influencer partnerships, market research, Nielsen/IRI/SPINS syndicated data, consumer insights, private label program data, and brand equity tracking. Supports Salesforce Marketing Cloud execution.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `food_beverage_ecm`.`marketing`.`brand` (
    `brand_id` BIGINT COMMENT 'Unique surrogate identifier for each brand record in the Food Beverage portfolio. Primary key for the brand master data product. Serves as the enterprise-wide SSOT reference for brand identity across PLM, ERP, CRM, and marketing systems.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Brand manager assignment is tracked for brand strategy decisions; linking to employee enables Brand Manager performance reports.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: Capacity planning and brand‑level supply chain reporting need a primary plant reference for each brand.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Brand performance is aggregated in profit centers for P&L reporting; FK enables profit‑center level analysis.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.customer_segment. Business justification: Brand strategy defines a target consumer segment; FK replaces the denormalized segment name, enabling segment‑based budgeting and compliance reporting.',
    `allergen_free_claims` STRING COMMENT 'Comma-separated list of allergen-free claims associated with the brand (e.g., gluten-free, nut-free, dairy-free). Derived from the allergen matrix managed in TraceGains. Must comply with FDA FALCPA (Food Allergen Labeling and Consumer Protection Act) and FSMA requirements. Used in consumer marketing and retail planogram placement.',
    `annual_marketing_budget` DECIMAL(18,2) COMMENT 'Total approved annual marketing investment budget allocated to the brand, expressed in the functional currency. Includes above-the-line (ATL) advertising, below-the-line (BTL) shopper marketing, digital, and trade promotion spend. Confidential financial data managed in Oracle Cloud ERP Financials and SAP CO cost centers.',
    `architecture_type` STRING COMMENT 'Classification of the brand within the corporate brand architecture hierarchy. masterbrand = umbrella brand covering multiple product lines; sub_brand = brand operating under a masterbrand; endorsed = independent brand with parent brand endorsement; standalone = fully independent brand; private_label = retailer-owned brand manufactured by Food Beverage under co-packing or toll manufacturing arrangements.. Valid values are `masterbrand|sub_brand|endorsed|standalone|private_label`',
    `awareness_pct` DECIMAL(18,2) COMMENT 'Unaided or total brand awareness percentage among the target consumer segment, expressed as a value between 0.00 and 100.00. Sourced from Nielsen/IRI consumer panel studies or commissioned brand health tracking research. Key input to brand equity score calculation and marketing investment justification.',
    `brand_category` STRING COMMENT 'Primary consumer product category to which the brand belongs (e.g., Snacks, Beverages, Dairy, Packaged Foods, RTD Coffee, RTE Cereals). Aligns with Nielsen/IRI/SPINS syndicated data category taxonomy for market tracking and ACV/TDP reporting. [ENUM-REF-CANDIDATE: snacks|beverages|dairy|packaged_foods|rte_cereals|rtd_beverages|condiments|frozen_foods|confectionery|other — promote to reference product]',
    `brand_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the brand, used across SAP S/4HANA, Oracle ERP, and trade systems. Serves as the natural key for cross-system integration and EDI transactions. Example: SNKBR-001, BEV-RTD-02.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `brand_name` STRING COMMENT 'Official commercial name of the brand as registered and used in consumer-facing marketing, packaging, and trade communications. This is the primary human-readable identifier for the brand (e.g., SunCrisp, HydraFlow). Must align with FTC-approved marketing claims and FDA labeling requirements.',
    `budget_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the annual marketing budget (e.g., USD, EUR, GBP). Ensures correct financial reporting and multi-currency consolidation in Oracle Cloud ERP and SAP S/4HANA FI.. Valid values are `^[A-Z]{3}$`',
    `clean_label_certified` BOOLEAN COMMENT 'Indicates whether the brand carries a clean label certification or commitment (no artificial colors, flavors, preservatives, or GMO ingredients). Drives consumer marketing claims, shelf placement in natural/organic sections, and SPINS natural channel data eligibility. Must be substantiated per FTC claim guidelines.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the brand record was first created in the enterprise data platform (Databricks Silver Layer). Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for data lineage, audit trail, and record lifecycle management.',
    `crm_brand_code` STRING COMMENT 'Brand identifier as recorded in Salesforce CRM (Sales Cloud / Marketing Cloud). Used for cross-system reconciliation between the lakehouse brand master and Salesforce campaign and consumer engagement records. Enables brand-level marketing performance attribution.',
    `digital_presence_url` STRING COMMENT 'Primary website URL for the brands consumer-facing digital presence (e.g., https://www.suncrisp.com). Used in Salesforce Marketing Cloud digital campaign management, SEO tracking, and consumer engagement analytics.. Valid values are `^https?://[^s/$.?#].[^s]*$`',
    `discontinuation_date` DATE COMMENT 'Calendar date on which the brand was officially discontinued or withdrawn from the market. Null if the brand is currently active. Used for portfolio rationalization analysis, regulatory deregistration, and historical reporting in Nielsen/IRI market tracking.',
    `distribution_channel` STRING COMMENT 'Primary route-to-market channel through which the brands products are sold. retail = traditional grocery/mass/drug; foodservice = restaurants/institutions; dsd = Direct Store Delivery; dtc = Direct-to-Consumer; ecommerce = online retail; club = club/warehouse channel. Drives trade promotion strategy (TPM/TPO) and supply chain configuration.. Valid values are `retail|foodservice|dsd|dtc|ecommerce|club`',
    `equity_score` DECIMAL(18,2) COMMENT 'Composite brand equity score derived from consumer research inputs including awareness, consideration, preference, and loyalty metrics. Scored on a 0-100 scale. Sourced from Nielsen/IRI brand health tracking studies and internal NPS panel data. Confidential strategic metric used in portfolio investment decisions and brand valuation.',
    `erp_brand_code` STRING COMMENT 'Brand identifier as recorded in the source ERP system (SAP S/4HANA or Oracle Cloud ERP). Used for cross-system reconciliation between the lakehouse silver layer brand master and operational ERP brand records. Supports data lineage and audit trail requirements.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `gfsi_certification` STRING COMMENT 'GFSI-benchmarked food safety certification scheme applicable to the brands manufacturing operations. sqf = Safe Quality Food (SQF); brc = British Retail Consortium Global Standard; fssc_22000 = Food Safety System Certification 22000; ifs = International Featured Standards; global_gap = GlobalG.A.P.; none = no GFSI certification. Tracked in Veeva Vault and TraceGains supplier compliance.. Valid values are `sqf|brc|fssc_22000|ifs|global_gap|none`',
    `haccp_plan_reference` STRING COMMENT 'Reference identifier for the HACCP plan document associated with the brands manufacturing process, stored in Veeva Vault Document Control. HACCP (Hazard Analysis Critical Control Points) is a mandatory food safety management system under FDA FSMA and USDA FSIS regulations. Used for audit traceability and regulatory compliance reporting.',
    `launch_date` DATE COMMENT 'Calendar date on which the brand was first commercially launched and made available to consumers in its primary market. Used for brand age calculations, anniversary marketing campaigns, and PLM lifecycle tracking. Aligns with SAP PLM product launch milestones.',
    `legal_name` STRING COMMENT 'Legally registered name of the brand as filed with trademark authorities (USPTO, EUIPO, etc.). May differ from the commercial brand name. Used for regulatory filings, contract management, and IP protection tracking.',
    `lifecycle_status` STRING COMMENT 'Current state of the brand within its commercial lifecycle. active = currently marketed and sold; discontinued = no longer produced or sold; pipeline = in NPD/R&D phase, not yet launched; divested = sold or transferred to another entity; archived = historical record retained for compliance. Drives PLM alignment and portfolio management decisions.. Valid values are `active|discontinued|pipeline|divested|archived`',
    `logo_asset_url` STRING COMMENT 'URL pointing to the master brand logo asset stored in the digital asset management (DAM) system. Used by Salesforce Marketing Cloud, packaging design teams, and agency partners for consistent brand identity application across all consumer touchpoints.. Valid values are `^https?://[^s/$.?#].[^s]*$`',
    `nps_score` DECIMAL(18,2) COMMENT 'Net Promoter Score (NPS) for the brand, measuring consumer likelihood to recommend on a -100 to +100 scale. Sourced from consumer panel surveys and Salesforce Marketing Cloud feedback programs. Used as a leading indicator of brand health and consumer loyalty in brand equity tracking.',
    `organic_certified` BOOLEAN COMMENT 'Indicates whether the brand holds USDA National Organic Program (NOP) certification or equivalent international organic certification (e.g., EU Organic). Enables organic marketing claims on packaging and in trade communications. Tracked in TraceGains supplier compliance and Veeva Vault document control.',
    `owner_division` STRING COMMENT 'Internal business division or operating unit that owns and manages the brand (e.g., North America Snacks, Global Beverages, International Dairy). Used for P&L attribution, marketing budget allocation, and organizational reporting in SAP CO and Oracle Financials.',
    `plm_product_line_code` STRING COMMENT 'Reference code linking the brand to its associated product line in the PLM system (SAP PLM or equivalent). Enables traceability between brand master data and the SKU/product hierarchy managed in PLM. Used for NPD pipeline tracking and BOM management.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `positioning_statement` STRING COMMENT 'Internal strategic statement articulating the brands unique value proposition, competitive differentiation, and reason-to-believe for the target consumer segment. Confidential business strategy document used in brand planning, NPD briefs, and agency briefings. Not for external distribution.',
    `primary_color_hex` STRING COMMENT 'Hexadecimal color code for the brands primary brand color as defined in the brand identity guidelines (e.g., #FF6B35). Used for consistent visual identity application across digital marketing, packaging, and trade materials in Salesforce Marketing Cloud and design systems.. Valid values are `^#[0-9A-Fa-f]{6}$`',
    `primary_market` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the brands primary commercial market (e.g., USA, GBR, DEU). Determines applicable regulatory frameworks (FDA, EFSA, USDA), labeling requirements, and market data sourcing (Nielsen/IRI for USA, SPINS for natural channel).. Valid values are `^[A-Z]{3}$`',
    `promise` STRING COMMENT 'Consumer-facing articulation of the core benefit or commitment the brand makes to its consumers (e.g., Real ingredients, real taste). Used in marketing communications, packaging copy, and Salesforce Marketing Cloud campaign messaging. Must comply with FTC advertising claim substantiation requirements.',
    `regulatory_approval_status` STRING COMMENT 'Current status of regulatory approval for the brands product claims and labeling across applicable jurisdictions. approved = all required regulatory approvals obtained; pending = applications submitted, awaiting decision; under_review = regulatory authority review in progress; rejected = approval denied, remediation required; not_required = no regulatory approval needed for this brand type. Managed in Veeva Vault Quality Management.. Valid values are `approved|pending|under_review|rejected|not_required`',
    `segment` STRING COMMENT 'Sub-category or segment within the broader product category (e.g., Salty Snacks, Energy Drinks, Greek Yogurt, Plant-Based). Used for granular market share analysis via IRI/SPINS syndicated data and for internal portfolio segmentation reporting.',
    `social_media_handle` STRING COMMENT 'Primary social media handle or username for the brands official social media presence (e.g., @SunCrispSnacks). Used for social media monitoring, influencer partnership management, and Salesforce Marketing Cloud social engagement tracking.',
    `sustainability_claim` STRING COMMENT 'Sustainability or environmental claim associated with the brand (e.g., Carbon Neutral, Rainforest Alliance Certified, B Corp Certified, Recyclable Packaging). Must be substantiated per FTC Green Guides (16 CFR Part 260) and EPA environmental compliance standards. Supports ESG reporting and consumer engagement.',
    `tier` STRING COMMENT 'Commercial positioning tier of the brand within the portfolio pricing and consumer value ladder. super_premium = ultra-high-end, limited distribution; premium = above-mainstream RSP positioning; mainstream = mass-market EDLP positioning; value = price-entry or economy positioning. Drives RSP strategy, trade promotion investment, and retail planogram placement.. Valid values are `premium|mainstream|value|super_premium`',
    `trademark_expiry_date` DATE COMMENT 'Date on which the brands trademark registration expires and must be renewed to maintain legal protection. Used for IP lifecycle management and legal compliance tracking. Triggers renewal workflows in legal management systems.',
    `trademark_registration_number` STRING COMMENT 'Official trademark registration number issued by the relevant intellectual property authority (e.g., USPTO, EUIPO, WIPO). Used for IP management, legal protection, and brand licensing agreements. Confidential business identifier managed in legal systems.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the brand record in the enterprise data platform. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture (CDC), data freshness monitoring, and audit compliance.',
    CONSTRAINT pk_brand PRIMARY KEY(`brand_id`)
) COMMENT 'Master record for each brand in the F&B portfolio — captures brand identity, positioning, tier (premium, mainstream, value), brand architecture (masterbrand, sub-brand, endorsed), target consumer segment, brand equity score inputs, launch date, and lifecycle status. SSOT for brand identity across the enterprise. Supports brand equity tracking and PLM alignment.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`marketing`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Unique surrogate identifier for each marketing campaign record in the lakehouse silver layer. Primary key.',
    `agency_id` BIGINT COMMENT 'FK to marketing.agency',
    `brand_id` BIGINT COMMENT 'Reference to the owning brand under which this campaign is executed. Links to the brand master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Campaign budgets are charged to cost centers; linking enables budget vs. actual financial analysis.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Campaign financial transactions need a GL account for posting; creates traceable accounting entries.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Campaign manager ownership is required for campaign budgeting and ROI analysis; FK supports Campaign Manager accountability reports.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Campaign planning uses a primary SKU for messaging and budgeting; the Primary SKU field drives the Campaign Brief and media allocation.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Campaign planning aligns with a specific R&D project to synchronize messaging with product availability.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.customer_segment. Business justification: Campaign planning uses defined customer segments for targeting; linking enables segment‑level ROI reporting and compliance with marketing segmentation policies.',
    `target_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_target. Business justification: Marketing campaigns are aligned to sustainability targets (e.g., low‑carbon product launch); linking enables target‑aligned spend tracking.',
    `actual_spend_usd` DECIMAL(18,2) COMMENT 'Total actual expenditure incurred for the campaign in US dollars as of the latest financial close. Compared against planned_budget_usd to track budget utilization and variance.',
    `acv_target_pct` DECIMAL(18,2) COMMENT 'Target percentage of All Commodity Volume (ACV) distribution coverage for the campaigns featured products. ACV % is a standard food and beverage industry metric for measuring retail distribution breadth.',
    `approval_status` STRING COMMENT 'Workflow approval state of the campaign record: pending (awaiting review), approved (cleared for execution), rejected (not approved), or under_review (in active review). Supports governance and compliance workflows.. Valid values are `pending|approved|rejected|under_review`',
    `approved_date` DATE COMMENT 'Date on which the campaign received final business approval to proceed. Used for governance audit trails and time-to-market measurement.',
    `campaign_code` STRING COMMENT 'Alphanumeric business identifier for the campaign used in ERP cost tracking, trade promotion management (TPM), and cross-system reconciliation. Follows internal naming convention (e.g., CAMP-2024-BEV-001).. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `campaign_description` STRING COMMENT 'Detailed narrative description of the campaign, including creative concept, key messages, promotional mechanics, and strategic rationale. Used for stakeholder briefings and campaign documentation.',
    `campaign_name` STRING COMMENT 'Human-readable name of the marketing campaign (e.g., Summer Refresh 2024 — National TV Burst). Used in reporting, dashboards, and stakeholder communications.',
    `campaign_status` STRING COMMENT 'Current lifecycle state of the campaign: draft (in development), planned (approved, not yet live), active (currently running), paused (temporarily halted), completed (finished), or cancelled (terminated before completion).. Valid values are `draft|planned|active|paused|completed|cancelled`',
    `campaign_type` STRING COMMENT 'Classification of the campaign by its primary marketing objective: awareness (brand building), trial (new consumer acquisition), loyalty (retention), trade (retailer/channel incentive), shopper (in-store activation), or influencer (creator-led). [ENUM-REF-CANDIDATE: awareness|trial|loyalty|trade|shopper|influencer|sponsorship|sampling|digital|event — promote to reference product]. Valid values are `awareness|trial|loyalty|trade|shopper|influencer`',
    `channel` STRING COMMENT 'Primary media or activation channel through which the campaign is executed (e.g., tv, digital, shopper, social, influencer, in_store). Drives channel-level spend and performance reporting. [ENUM-REF-CANDIDATE: tv|digital|shopper|social|influencer|in_store|radio|print|out_of_home|email|event — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign record was first created in the system of record. Supports audit trail, data lineage, and governance requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this campaign record (e.g., USD, EUR, GBP). Supports multi-currency reporting for global campaigns.. Valid values are `^[A-Z]{3}$`',
    `end_date` DATE COMMENT 'Calendar date on which the campaign officially concludes and all media/activation ceases. Nullable for always-on campaigns. Used for budget reconciliation and post-campaign analysis.',
    `fda_claims_compliant` BOOLEAN COMMENT 'Indicates whether all product claims featured in the campaign (e.g., health claims, nutrient content claims, clean label statements) comply with FDA regulations. True = compliant; False = non-compliant or under review.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month number within the fiscal year, 1–13) in which the campaign is primarily budgeted. Used for period-level financial reporting and budget pacing in SAP S/4HANA CO.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the campaign budget is allocated and financial performance is reported (e.g., 2024). Aligns with SAP S/4HANA CO fiscal year for cost center and internal order reporting.',
    `ftc_claims_reviewed` BOOLEAN COMMENT 'Indicates whether all marketing claims in this campaign have been reviewed for compliance with FTC guidelines on advertising and marketing claims (e.g., substantiation of health/nutrition claims). True = reviewed and cleared; False = not yet reviewed.',
    `influencer_partnership` BOOLEAN COMMENT 'Indicates whether this campaign includes a paid influencer or creator partnership component. True = influencer partnership present; False = no influencer component. Supports FTC disclosure compliance tracking.',
    `internal_order_number` STRING COMMENT 'SAP S/4HANA CO internal order number used to collect and settle campaign costs. Provides granular cost tracking at the campaign level within the ERP system.',
    `media_impressions_target` BIGINT COMMENT 'Planned number of media impressions (total ad exposures) targeted for the campaign across all channels. Used as a key performance indicator (KPI) for reach planning and post-campaign evaluation against Nielsen/IRI data.',
    `objective` STRING COMMENT 'Free-text description of the primary business objective for the campaign (e.g., Drive 10% household penetration increase for RTD line in Q3). Supports brand marketing and consumer engagement planning.',
    `planned_budget_usd` DECIMAL(18,2) COMMENT 'Total approved budget allocated to the campaign in US dollars at the time of planning. Used for financial planning, trade promotion management (TPM), and return on investment (ROI) analysis.',
    `private_label_flag` BOOLEAN COMMENT 'Indicates whether this campaign supports a private label product program rather than a branded product. True = private label campaign; False = branded campaign. Relevant for retailer co-marketing and private label program data.',
    `product_category` STRING COMMENT 'The product category or portfolio segment being promoted by this campaign (e.g., RTD Beverages, Salty Snacks, Dairy). Aligns with Nielsen/IRI category definitions for syndicated data benchmarking.',
    `reach_target_households` BIGINT COMMENT 'Planned number of unique households targeted for campaign reach. Aligns with Nielsen household panel measurement methodology for consumer packaged goods (CPG) reach reporting.',
    `sfmc_campaign_code` STRING COMMENT 'External campaign identifier assigned by Salesforce Marketing Cloud (SFMC). Used to correlate lakehouse records with SFMC execution records for digital and email channel campaigns.',
    `shopper_marketing_flag` BOOLEAN COMMENT 'Indicates whether this campaign includes a shopper marketing activation (e.g., in-store display, planogram feature, digital coupon at point of sale). True = shopper marketing component present.',
    `sku_scope` STRING COMMENT 'Comma-separated list or description of the specific SKUs (Stock Keeping Units) included in the campaign. Supports product-level performance attribution and trade promotion management (TPM) analysis.',
    `start_date` DATE COMMENT 'Calendar date on which the campaign officially launches and media/activation begins. Used for scheduling, budget pacing, and performance window calculations.',
    `target_geography` STRING COMMENT 'Geographic scope of the campaign (e.g., National US, Northeast Region, California DMA). Used for media buying, distribution alignment, and regional performance reporting.',
    `tdp_target` STRING COMMENT 'Target Total Distribution Points (TDP) for the campaigns featured SKUs. TDP is a standard food and beverage metric combining distribution breadth and depth across retail accounts.',
    `trade_promotion_flag` BOOLEAN COMMENT 'Indicates whether this campaign includes a trade promotion component (e.g., retailer co-op, slotting fee, off-invoice discount). True = trade promotion included. Supports Trade Promotion Management (TPM) and Trade Promotion Optimization (TPO) workflows.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign record was last modified in the system of record. Used for incremental data loading, change detection, and audit trail maintenance in the Databricks lakehouse silver layer.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Master record for each marketing campaign executed across channels — TV, digital, shopper, social, influencer, in-store. Captures campaign name, type (awareness, trial, loyalty, trade), objective, target audience, start/end dates, budget, status, owning brand, and Salesforce Marketing Cloud campaign ID. Supports Brand Marketing and Consumer Engagement process.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` (
    `campaign_execution_id` BIGINT COMMENT 'Unique surrogate identifier for each campaign execution record. Represents a single activation of a campaign flight across a specific channel, geography, and time period. Role: TRANSACTION_HEADER — primary key.',
    `account_id` BIGINT COMMENT 'Reference to the retail account or trade customer targeted by this execution (e.g., Walmart, Kroger). Supports shopper marketing and trade promotion alignment. PARTY_REFERENCE per TRANSACTION_HEADER role.',
    `brand_id` BIGINT COMMENT 'Reference to the brand being promoted or advertised in this campaign execution. Supports brand equity tracking and spend attribution by brand.',
    `campaign_id` BIGINT COMMENT 'Reference to the parent campaign that this execution record belongs to. One campaign may have multiple execution records across channels and time periods.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Execution spend (media buying, agency fees) is allocated to cost centers for cost tracking and variance analysis.',
    `digital_asset_id` BIGINT COMMENT 'Reference to the specific creative asset version deployed in this execution. Enables creative performance analysis and FTC compliance tracking for marketing claims.',
    `formulation_version_id` BIGINT COMMENT 'Foreign key linking to research.formulation_version. Business justification: Execution details reference the exact formulation version being promoted for accurate compliance and claim support.',
    `nutrition_label_id` BIGINT COMMENT 'Foreign key linking to regulatory.nutrition_label. Business justification: Campaign Execution Compliance: execution must reference the nutrition label of the SKU to ensure advertised claims match label information.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Campaign execution references a specific SKU; FK replaces free-text SKU and aligns marketing spend with product master.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Financial reconciliation of campaign execution spend uses the PO that funded the media buy, needed for audit and ROI reporting.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Required for In‑Store Promotion Execution: links each campaign execution to the specific stock position allocated for that execution, enabling inventory drawdown tracking and ROI analysis.',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'The actual media spend incurred for this execution flight as billed by the media vendor or agency. Used for ROI calculation and budget reconciliation.',
    `ad_format` STRING COMMENT 'The format of the advertisement deployed in this execution (e.g., banner, video, carousel, sponsored product). Supports format-level performance and creative strategy analysis. [ENUM-REF-CANDIDATE: banner|video|carousel|native|sponsored_product|story|interstitial|rich_media — promote to reference product]',
    `agency_name` STRING COMMENT 'Name of the media agency or buying partner responsible for executing this campaign flight. Used for agency performance tracking and invoice reconciliation.',
    `buying_type` STRING COMMENT 'The media buying model used for this execution (e.g., CPM — Cost Per Thousand, CPC — Cost Per Click, CPA — Cost Per Acquisition, CPV — Cost Per View, flat fee, programmatic). Drives cost structure and performance benchmarking.. Valid values are `cpm|cpc|cpa|cpv|flat_fee|programmatic`',
    `channel_platform` STRING COMMENT 'Specific platform or publisher within the channel type where the execution runs (e.g., Facebook, Google, Instacart, Kroger Precision Marketing, YouTube). Enables platform-level performance benchmarking.',
    `channel_type` STRING COMMENT 'The marketing channel through which this execution is activated (e.g., digital, social, shopper, television). Drives channel-level spend and performance reporting. [ENUM-REF-CANDIDATE: digital|social|display|search|email|shopper|out_of_home|television|radio|print — promote to reference product]',
    `claim_compliance_status` STRING COMMENT 'Regulatory compliance review status for marketing claims contained in this execution. Required when marketing_claim_flag is True. Supports FTC and FDA compliance audit trails.. Valid values are `pending_review|approved|rejected|conditionally_approved`',
    `clicks_delivered` BIGINT COMMENT 'Total number of clicks recorded on the ad during this execution flight. Used to calculate click-through rate (CTR) and assess consumer engagement.',
    `cost_per_thousand_impressions` DECIMAL(18,2) COMMENT 'The cost per one thousand ad impressions for this execution, as negotiated with the media vendor. Standard media buying metric used for cross-channel efficiency benchmarking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign execution record was first created in the system. RECORD_AUDIT_CREATED per TRANSACTION_HEADER role.',
    `creative_version` STRING COMMENT 'Version label of the creative asset deployed in this execution (e.g., v1.0, v2.3). Tracks which creative iteration was live during the flight for A/B testing and compliance audit.. Valid values are `^v[0-9]+.[0-9]+$`',
    `execution_number` STRING COMMENT 'Externally-known business identifier for this execution record, used in agency briefings, media plans, and vendor invoices. Format: CE-YYYY-NNNNNN. BUSINESS_IDENTIFIER per TRANSACTION_HEADER role.. Valid values are `^CE-[0-9]{4}-[0-9]{6}$`',
    `execution_status` STRING COMMENT 'Current lifecycle state of this campaign execution record. Tracks workflow from planning through completion. LIFECYCLE_STATUS per TRANSACTION_HEADER role.. Valid values are `draft|scheduled|active|paused|completed|cancelled`',
    `flight_end_date` DATE COMMENT 'The date on which this campaign execution flight is scheduled to stop running in-market. Used for pacing, budget management, and post-campaign analysis.',
    `flight_start_date` DATE COMMENT 'The date on which this campaign execution flight begins running in-market. Represents the real-world activation date. BUSINESS_EVENT_TIMESTAMP per TRANSACTION_HEADER role.',
    `frequency` DECIMAL(18,2) COMMENT 'Average number of times a unique individual was exposed to the ad during this execution flight. Calculated as impressions divided by reach. Used to manage ad fatigue and optimize media plans.',
    `impressions_delivered` BIGINT COMMENT 'Total number of ad impressions delivered during this execution flight. A core digital media performance metric used for reach and frequency analysis. QUANTITATIVE_RESULT per TRANSACTION_HEADER role.',
    `influencer_partnership_flag` BOOLEAN COMMENT 'Indicates whether this execution involves a paid influencer or brand ambassador partnership. Triggers FTC endorsement disclosure compliance requirements.',
    `marketing_claim_flag` BOOLEAN COMMENT 'Indicates whether this execution contains a regulated marketing claim (e.g., health claim, nutrient content claim, environmental claim). Triggers FTC and FDA compliance review workflow.',
    `nielsen_market_code` STRING COMMENT 'Nielsen-defined market or DMA (Designated Market Area) code associated with the geographic target of this execution. Enables alignment with Nielsen/IRI syndicated market data for sales lift analysis.',
    `placement_name` STRING COMMENT 'The specific ad placement or ad unit name within the platform (e.g., Facebook News Feed, Google Search Top, Instacart Sponsored Product). Supports granular placement-level performance analysis.',
    `planned_spend_amount` DECIMAL(18,2) COMMENT 'The budgeted media spend allocated to this execution flight in the media plan. Used for budget pacing and variance analysis against actual spend.',
    `reach` BIGINT COMMENT 'Total number of unique individuals exposed to the ad during this execution flight. Distinct from impressions (which counts total exposures including repeat). Key metric for brand awareness campaigns.',
    `salesforce_activity_code` STRING COMMENT 'The native activity or journey step identifier from Salesforce Marketing Cloud corresponding to this execution record. Enables direct traceability back to the source system of record.',
    `spend_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the planned and actual spend amounts (e.g., USD, EUR, GBP). Required for multi-market campaign financial reporting.. Valid values are `^[A-Z]{3}$`',
    `target_audience_segment` STRING COMMENT 'The consumer audience segment targeted by this execution (e.g., Millennial Moms, Health-Conscious Shoppers, Snack Enthusiasts). Derived from consumer insights and CRM segmentation.',
    `target_geography_code` STRING COMMENT 'ISO 3166-1 alpha-2 or alpha-3 country code representing the primary geographic market targeted by this execution. Supports geo-level spend and performance reporting.. Valid values are `^[A-Z]{2,3}$`',
    `target_region` STRING COMMENT 'Sub-national region or market area targeted by this execution (e.g., Northeast US, California, EMEA). Supports regional marketing performance analysis and distribution center alignment.',
    `target_retailer_name` STRING COMMENT 'Name of the specific retailer or trade account targeted by this shopper marketing or retail media execution (e.g., Walmart, Kroger, Target). Supports trade promotion and shopper marketing alignment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign execution record was last modified. Supports change tracking and data lineage in the Silver layer. RECORD_AUDIT_UPDATED per TRANSACTION_HEADER role.',
    `utm_campaign` STRING COMMENT 'Urchin Tracking Module (UTM) campaign parameter appended to campaign URLs for this execution. Links digital traffic back to the specific campaign for attribution reporting.',
    `utm_medium` STRING COMMENT 'Urchin Tracking Module (UTM) medium parameter appended to campaign URLs for this execution (e.g., cpc, email, social). Supports digital attribution and channel performance analysis.',
    `utm_source` STRING COMMENT 'Urchin Tracking Module (UTM) source parameter appended to campaign URLs for this execution. Used for digital attribution and web analytics tracking in Google Analytics and Salesforce Marketing Cloud.',
    `vendor_order_number` STRING COMMENT 'The media vendors or publishers order or insertion order (IO) number associated with this execution. Used for invoice matching and vendor reconciliation.',
    `video_completion_rate` DECIMAL(18,2) COMMENT 'Proportion of video ad views that were completed to 100% of the video duration. Expressed as a decimal (e.g., 0.65 = 65%). Key metric for video creative effectiveness.',
    `video_views` BIGINT COMMENT 'Total number of video views recorded for video ad formats during this execution flight. Applicable when ad_format is video. Supports video completion rate analysis.',
    CONSTRAINT pk_campaign_execution PRIMARY KEY(`campaign_execution_id`)
) COMMENT 'Transactional record capturing the actual execution of a campaign flight — channel activation, flight dates, creative asset version deployed, placement details, targeted geography, targeted retailer/account, impressions delivered, clicks, reach, frequency, and execution status. One campaign may have multiple execution records across channels and time periods.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`marketing`.`media_spend` (
    `media_spend_id` BIGINT COMMENT 'Unique surrogate identifier for each media spend transaction record in the Silver Layer lakehouse. Primary key for this entity.',
    `agency_id` BIGINT COMMENT 'FK to marketing.agency',
    `brand_id` BIGINT COMMENT 'Reference to the brand portfolio entity associated with this media spend. Enables brand-level advertising investment analysis and brand equity tracking.',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign under which this media spend was incurred. Links spend to campaign objectives, budgets, and performance tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Media spend must be posted to cost centers for financial reporting; allocation uses cost_center_id instead of denormalized code.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Each media spend transaction is recorded in a GL account for accounting; FK replaces the plain code.',
    `market_id` BIGINT COMMENT 'Reference to the geographic market or territory where the media was placed. Supports regional spend analysis and market-level ROI reporting.',
    `media_plan_id` BIGINT COMMENT 'Foreign key linking to marketing.media_plan. Business justification: Links each spend record to its media plan for budgeting alignment.',
    `supplier_id` BIGINT COMMENT 'Reference to the media partner or vendor (e.g., Google, Meta, NBC, Clear Channel) who delivered the media placement. Used for vendor performance and spend reconciliation.',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'Actual media spend amount incurred for this record in the transaction currency. Represents confirmed expenditure as invoiced or settled with the media vendor.',
    `agency_fee_amount` DECIMAL(18,2) COMMENT 'Media agency commission or service fee associated with this spend record, separate from the net media cost. Enables total cost of advertising (working vs. non-working spend) analysis.',
    `buying_type` STRING COMMENT 'Method by which the media inventory was purchased (e.g., upfront commitment, scatter market, programmatic auction, direct buy, sponsorship). Impacts pricing, flexibility, and spend governance.. Valid values are `upfront|scatter|programmatic|direct|sponsorship`',
    `claim_type` STRING COMMENT 'Classification of the primary marketing claim featured in the media creative associated with this spend (e.g., health, nutrition, sustainability, taste, price, brand). Supports FTC compliance monitoring and claim substantiation tracking.. Valid values are `health|nutrition|sustainability|taste|price|brand`',
    `clicks` BIGINT COMMENT 'Total number of user clicks on the digital advertisement during the spend period. Primary engagement metric for digital and paid search media types.',
    `committed_spend_amount` DECIMAL(18,2) COMMENT 'Media spend amount that has been contractually committed to the vendor but not yet invoiced or paid. Represents open purchase order value for accrual and cash flow forecasting.',
    `cpc` DECIMAL(18,2) COMMENT 'Cost Per Click — the realized cost for each user click on the digital advertisement in the transaction currency. Primary efficiency metric for paid search and performance-based digital media.',
    `cpm` DECIMAL(18,2) COMMENT 'Cost Per Mille (thousand impressions) — the negotiated or realized cost per 1,000 ad impressions in the transaction currency. Standard media efficiency metric for comparing cross-channel investment value.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this media spend record was first captured in the Silver Layer lakehouse. Supports audit trail, data lineage, and SLA monitoring for data pipeline freshness.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this record (e.g., USD, EUR, GBP). Required for multi-currency consolidation and FX reporting.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'System or source from which this media spend record was ingested (e.g., SAP S/4HANA, agency billing platform, media platform API, Nielsen, IRI, manual entry). Supports data lineage and reconciliation.. Valid values are `SAP|agency_billing|media_platform|Nielsen|IRI|manual`',
    `dma_code` STRING COMMENT 'Nielsen Designated Market Area code identifying the specific US television market where the media aired. Standard geographic unit for US broadcast media planning and spend reporting.',
    `fiscal_period` STRING COMMENT 'Company fiscal period in which this media spend is recognized (format: YYYY-P##, e.g., 2024-P06). Aligns spend to internal financial reporting periods which may differ from calendar months.. Valid values are `^[0-9]{4}-P(0[1-9]|1[0-3])$`',
    `flight_end_date` DATE COMMENT 'The date on which the media flight or campaign burst concludes. Used with flight_start_date to define the media window for pacing and delivery analysis.',
    `flight_start_date` DATE COMMENT 'The date on which the media flight or campaign burst begins airing or serving impressions. A media flight is a discrete scheduled period of advertising activity.',
    `ftc_compliant` BOOLEAN COMMENT 'Indicates whether the associated advertising creative and claims for this media spend have been reviewed and confirmed compliant with FTC endorsement, disclosure, and advertising substantiation guidelines. Critical for regulatory audit and legal risk management.',
    `geo_market_code` STRING COMMENT 'ISO 3166-1 alpha-2 or alpha-3 country code identifying the geographic market where the media ran. Supports multi-market spend consolidation and regional budget governance.. Valid values are `^[A-Z]{2,3}$`',
    `grp` DECIMAL(18,2) COMMENT 'Gross Rating Points representing the total weight of a media schedule, calculated as reach multiplied by average frequency. Standard TV and broadcast media planning metric used to measure advertising pressure.',
    `impressions` BIGINT COMMENT 'Total number of times the advertisement was served or displayed to an audience during the spend period. Primary reach metric for evaluating media delivery against contracted guarantees.',
    `invoice_number` STRING COMMENT 'Vendor invoice reference number associated with this media spend record. Used for accounts payable matching, audit trails, and FTC compliance documentation.',
    `media_channel` STRING COMMENT 'Specific media channel or platform within the media type (e.g., YouTube, Instagram, Google Search, NBC Primetime, Spotify, Times Square Billboard). Provides granular channel-level spend visibility beyond the media type classification.',
    `media_format` STRING COMMENT 'Creative format of the media placement (e.g., video, banner, native, audio, sponsorship, influencer, search text). Used for creative performance analysis and format-level spend allocation. [ENUM-REF-CANDIDATE: video|banner|native|audio|sponsorship|influencer|search_text|connected_tv — promote to reference product]',
    `media_type` STRING COMMENT 'Classification of the advertising medium used for this spend record (e.g., TV, digital display, paid search, out-of-home, social, streaming). Drives channel-mix analysis and media planning optimization. [ENUM-REF-CANDIDATE: TV|digital_display|paid_search|OOH|social|streaming|print|radio — promote to reference product]',
    `planned_spend_amount` DECIMAL(18,2) COMMENT 'Budgeted or planned media spend amount for this record in the transaction currency. Represents the approved budget allocation prior to actual execution. Used for planned vs. actual variance analysis.',
    `purchase_order_number` STRING COMMENT 'SAP purchase order number issued to the media vendor for this spend commitment. Enables three-way match (PO, goods receipt, invoice) in accounts payable.',
    `reach` BIGINT COMMENT 'Estimated number of unique individuals exposed to the advertisement during the flight period. Distinct from impressions (which counts total exposures including duplicates). Used for audience coverage planning.',
    `roi_index` DECIMAL(18,2) COMMENT 'Media ROI index score derived from marketing mix modeling or attribution analysis, representing the revenue return per unit of media spend. Sourced from Nielsen/IRI MMM outputs. Not a calculated aggregate — represents a point-in-time modeled index value assigned to this spend record.',
    `shopper_marketing_flag` BOOLEAN COMMENT 'Indicates whether this media spend is classified as shopper marketing (in-store, retailer co-op, or path-to-purchase media) as distinct from brand or consumer advertising. Drives working media classification and trade vs. marketing budget allocation.',
    `spend_date` DATE COMMENT 'The principal real-world business event date on which the media spend was incurred or the media ran. Used as the primary time dimension for spend reporting and period-over-period analysis.',
    `spend_reference_number` STRING COMMENT 'Externally-known business identifier for this media spend transaction, typically sourced from the media buying platform, agency, or SAP FI document number. Used for reconciliation with invoices and agency billing statements.',
    `spend_status` STRING COMMENT 'Current lifecycle state of the media spend record, tracking progression from planned budget through commitment, invoicing, and payment. Supports spend governance and budget control.. Valid values are `planned|committed|invoiced|paid|cancelled`',
    `target_audience` STRING COMMENT 'Defined audience segment or demographic target for this media placement (e.g., Adults 18-49, Millennial Moms, Health-Conscious Shoppers). Used for audience alignment reporting and media planning.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this media spend record was last modified in the Silver Layer lakehouse. Used for change data capture, incremental processing, and audit trail maintenance.',
    `wbs_element` STRING COMMENT 'SAP Project System WBS element code for project-based media spend tracking. Used when advertising spend is managed under a specific marketing project or new product launch initiative.',
    `working_media_flag` BOOLEAN COMMENT 'Indicates whether this spend record represents working media (dollars directly purchasing audience exposure) as opposed to non-working spend (agency fees, production costs, research). Standard industry classification for advertising efficiency benchmarking.',
    CONSTRAINT pk_media_spend PRIMARY KEY(`media_spend_id`)
) COMMENT 'Transactional record of advertising and media spend by campaign, channel, market, and time period. Captures planned vs. actual spend, media type (TV, digital display, paid search, OOH, social, streaming), vendor/media partner, invoice reference, cost-per-thousand (CPM), cost-per-click (CPC), and ROI metrics. Supports advertising spend governance and FTC compliance.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`marketing`.`media_plan` (
    `media_plan_id` BIGINT COMMENT 'Unique surrogate identifier for the media plan record. Primary key for the media_plan data product in the Silver Layer lakehouse.',
    `agency_id` BIGINT COMMENT 'Reference to the media agency or creative agency assigned to execute this media plan. Supports agency performance tracking and fee reconciliation.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Media plan approval requires sign‑off by a marketing employee; FK supports audit trail for budget authority and compliance.',
    `brand_id` BIGINT COMMENT 'Reference to the brand for which this media plan is created. Supports brand-level investment tracking and A&P budget governance.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign associated with this media plan. Links media investment to specific campaign objectives and execution.',
    `cost_center_id` BIGINT COMMENT 'Reference to the finance cost center that owns the A&P budget for this media plan. Enables GL-level reconciliation between marketing-owned working budget and finance records.',
    `promotion_plan_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_plan. Business justification: Media planning is built around promotion plans; linking enables plan‑level media budgeting.',
    `purchase_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_contract. Business justification: Media plans are executed under a media purchase contract; linking enables contract compliance and spend tracking.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Regional Media Planning: links media plans to storage locations (distribution centers) to attribute media spend to inventory availability in each region, aiding budget optimization and supply‑demand a',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'The actual invoiced and posted spend against this media plan to date. Used for planned-vs-actual variance analysis and marketing finance controls reconciliation.',
    `agency_fee_amount` DECIMAL(18,2) COMMENT 'The non-working media portion of the budget allocated to agency fees (retainer, commission, or project-based fees) for this media plan. Supports agency cost governance and working vs. non-working media analysis.',
    `approval_date` DATE COMMENT 'The date on which the media plan budget received final authorization from the budget owner. Required for SOX audit trail and marketing finance controls documentation.',
    `approval_status` STRING COMMENT 'The current approval status of the media plan budget within the marketing finance controls workflow. Distinct from plan_status — captures the budget authorization state specifically.. Valid values are `pending|approved|rejected|revision_required`',
    `approved_budget_amount` DECIMAL(18,2) COMMENT 'The total approved Advertising & Promotion (A&P) budget allocated to this media plan in the plan currency. This is the marketing-owned working budget — the single source of truth (SSOT) distinct from the finance General Ledger (GL). Supports brand investment governance and EBITDA impact tracking.',
    `budget_owner` STRING COMMENT 'Name or employee identifier of the marketing manager or brand director who owns and is accountable for this media plan budget. The primary point of contact for budget governance.',
    `budget_variance_amount` DECIMAL(18,2) COMMENT 'The difference between the approved budget and actual spend (approved_budget_amount minus actual_spend_amount). A positive value indicates underspend; negative indicates overspend. Supports marketing finance controls and budget reallocation decisions.',
    `committed_spend_amount` DECIMAL(18,2) COMMENT 'The portion of the approved budget that has been formally committed via purchase orders, agency contracts, or media buys. Represents legally or contractually obligated spend within the plan period.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this media plan record was first created in the system. Supports audit trail, data lineage, and Silver Layer ingestion tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this media plan (e.g., USD, EUR, GBP). Enables multi-currency consolidation for global brand investment reporting.. Valid values are `^[A-Z]{3}$`',
    `digital_budget_amount` DECIMAL(18,2) COMMENT 'Budget allocated to digital media channels (display, search, programmatic, video) within this plan. Supports digital investment tracking and Return on Investment (ROI) analysis.',
    `fda_claims_compliant` BOOLEAN COMMENT 'Indicates whether all health, nutrient content, and structure/function claims in this media plan comply with FDA food labeling and advertising regulations. Critical for food and beverage marketing compliance.',
    `fiscal_period` STRING COMMENT 'The fiscal quarter (Q1–Q4) or fiscal period (P01–P13) within the fiscal year to which this media plan is scoped. Supports sub-annual budget pacing and planned-vs-actual reconciliation.. Valid values are `^(Q[1-4]|P(0[1-9]|1[0-3]))$`',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this media plans budget and spend are attributed (e.g., 2025). Aligns with the companys fiscal calendar for A&P budget governance and EBITDA reporting.',
    `ftc_claims_reviewed` BOOLEAN COMMENT 'Indicates whether all marketing claims included in this media plan have been reviewed for compliance with FTC advertising standards and substantiation requirements. Required for regulated food and beverage marketing claims.',
    `geographic_scope` STRING COMMENT 'The geographic market scope of this media plan (e.g., National, Northeast Region, Top 10 DMAs). Supports market-level investment analysis and regional brand equity tracking.',
    `media_mix_strategy` STRING COMMENT 'Narrative description of the media mix strategy for this plan, including rationale for channel weighting, sequencing, and integration approach. Supports brand investment decision documentation.',
    `nielsen_market_code` STRING COMMENT 'The Nielsen market or Designated Market Area (DMA) code associated with the geographic scope of this media plan. Enables linkage to Nielsen syndicated market tracking data for planned-vs-actual audience delivery measurement.',
    `ooh_budget_amount` DECIMAL(18,2) COMMENT 'Budget allocated to Out-of-Home (OOH) media (billboards, transit, digital OOH) within this plan. Supports channel-level investment tracking and media mix reporting.',
    `plan_end_date` DATE COMMENT 'The calendar date on which media activity under this plan is scheduled to conclude. Defines the flight window for budget commitment and agency delivery.',
    `plan_name` STRING COMMENT 'Human-readable descriptive name for the media plan (e.g., FY25 Q1 Snacks National TV + Digital). Used in dashboards, approval workflows, and stakeholder communications.',
    `plan_number` STRING COMMENT 'Externally-known alphanumeric business identifier for the media plan, used in agency briefs, purchase orders, and finance reconciliation. Format: MP- followed by 4–20 alphanumeric characters.. Valid values are `^MP-[A-Z0-9]{4,20}$`',
    `plan_start_date` DATE COMMENT 'The calendar date on which media activity under this plan is scheduled to begin. Used for flight scheduling, agency briefing timelines, and budget pacing.',
    `plan_status` STRING COMMENT 'Current lifecycle state of the media plan within the approval and execution workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|paused|cancelled|closed — promote to reference product]',
    `plan_type` STRING COMMENT 'Classification of the media plan by strategic purpose. Distinguishes brand-building investment from Trade Promotion Management (TPM) spend, New Product Development (NPD) launches, and shopper marketing activations. [ENUM-REF-CANDIDATE: brand_building|trade_promotion|shopper_marketing|new_product_launch|seasonal|always_on — promote to reference product]. Valid values are `brand_building|trade_promotion|shopper_marketing|new_product_launch|seasonal|always_on`',
    `planned_frequency` DECIMAL(18,2) COMMENT 'The planned average number of times a member of the target audience is expected to be exposed to the media during the flight period. Used with reach to calculate GRPs and assess media weight sufficiency.',
    `planned_grp` DECIMAL(18,2) COMMENT 'The total planned Gross Rating Points (GRPs) targeted for this media plan. GRP = Reach % × Frequency. A standard media weight metric used to evaluate TV and broadcast investment effectiveness.',
    `planned_reach_pct` DECIMAL(18,2) COMMENT 'The planned percentage of the target audience expected to be exposed to the media at least once during the flight period. A key media effectiveness metric alongside frequency.',
    `primary_channel` STRING COMMENT 'The dominant media channel for this plan (e.g., TV, digital, social, shopper, Out-of-Home (OOH), streaming). Drives media mix strategy reporting and channel-level budget allocation analytics. [ENUM-REF-CANDIDATE: TV|digital|social|shopper|OOH|streaming|print|radio — promote to reference product]',
    `production_cost_amount` DECIMAL(18,2) COMMENT 'Budget allocated to creative production costs (TV commercial production, digital asset creation, photography) within this plan. Part of non-working media spend.',
    `salesforce_campaign_code` STRING COMMENT 'The campaign identifier from Salesforce Marketing Cloud used to link this media plan to digital campaign execution, email journeys, and consumer engagement tracking. Supports cross-channel attribution.',
    `shopper_budget_amount` DECIMAL(18,2) COMMENT 'Budget allocated to shopper marketing activations (in-store, retailer co-op, Point of Sale (POS) materials) within this plan. Supports trade and shopper investment governance.',
    `social_budget_amount` DECIMAL(18,2) COMMENT 'Budget allocated to social media channels (paid social, influencer partnerships) within this plan. Supports social investment tracking and FTC endorsement compliance monitoring.',
    `streaming_budget_amount` DECIMAL(18,2) COMMENT 'Budget allocated to streaming media platforms (audio streaming, video-on-demand, podcast) within this plan. Supports emerging channel investment tracking.',
    `target_audience` STRING COMMENT 'Descriptive definition of the primary consumer target audience for this media plan (e.g., Adults 25–54, HHI $50K+, Snack Purchasers). Aligns with Nielsen/IRI panel demographic segmentation and brand strategy.',
    `tv_budget_amount` DECIMAL(18,2) COMMENT 'Budget allocated to television media (linear TV, connected TV) within this plan. Supports channel-level investment tracking and media mix optimization.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this media plan record was most recently modified. Used for change detection, incremental processing in the Databricks Silver Layer, and audit trail.',
    `version_number` STRING COMMENT 'Sequential version number of the media plan, incremented each time the plan is revised and resubmitted for approval. Supports plan revision history tracking and audit trail.',
    `working_media_pct` DECIMAL(18,2) COMMENT 'The percentage of the total approved budget allocated to working media (direct media placement costs) versus non-working media (agency fees, production costs). Industry benchmark for media efficiency.',
    CONSTRAINT pk_media_plan PRIMARY KEY(`media_plan_id`)
) COMMENT 'Master record for marketing investment planning and budget governance by brand, campaign, channel, and fiscal period. Captures approved A&P budget, channel allocation (TV, digital, social, shopper, OOH, streaming), planned GRPs, reach/frequency targets, media mix strategy, agency assignments, committed vs. actual spend, variance, budget owner, and approval status. SSOT for marketing-owned working budget — distinct from finance GL. Supports brand investment decisions, planned-vs-actual reconciliation, and marketing finance controls.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` (
    `consumer_insight_id` BIGINT COMMENT 'Unique surrogate identifier for each consumer research study or derived insight record. Primary key for the consumer_insight data product in the Silver Layer lakehouse.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Associates insight with the specific brand; brand_scope string replaced by FK.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Insight studies are commissioned by specific employees; linking enables Insight Commissioning cost allocation and performance tracking.',
    `promotion_plan_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_plan. Business justification: Consumer insights drive promotion‑plan creation; this FK ties insights to the plan they inform.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Insight studies are commissioned for specific R&D projects, linking insights to project outcomes.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Insight studies are conducted on specific SKUs; linking enables the Insight‑SKU Impact report used in NPD decisions.',
    `actual_spend_usd` DECIMAL(18,2) COMMENT 'Actual amount invoiced and paid to the research vendor in US Dollars (USD). Compared against study_budget_usd for budget variance analysis and marketing ROI reporting.',
    `allergen_relevance` BOOLEAN COMMENT 'Indicates whether the study includes consumer insights related to allergen awareness, labeling preferences, or allergen-free product demand (True). Supports allergen matrix management and FDA FSMA compliance for labeling decisions.',
    `category_scope` STRING COMMENT 'The food and beverage product category or categories covered by the study (e.g., Salty Snacks, RTD Beverages, Dairy, Packaged Foods). Aligns with Nielsen/IRI category taxonomy and internal PLM category hierarchy.',
    `clean_label_relevance` BOOLEAN COMMENT 'Indicates whether the study includes findings relevant to clean label consumer preferences (True) — e.g., natural ingredients, no artificial additives, transparency. Supports the clean label product development pipeline and marketing claims strategy.',
    `concept_test_score` DECIMAL(18,2) COMMENT 'Top-2-box purchase intent or overall concept appeal score from concept testing studies (e.g., 72.50 = 72.5% top-2-box). Null for non-concept-test study types. Key NPD go/no-go gate metric used in the innovation funnel.',
    `confidence_level_pct` DECIMAL(18,2) COMMENT 'The statistical confidence level (%) at which quantitative findings are reported (e.g., 90.00, 95.00, 99.00). Null for qualitative studies. Supports data quality assessment and decision-making thresholds for NPD go/no-go gates.',
    `cost_center_code` STRING COMMENT 'SAP or Oracle cost center code to which the research study expenditure is allocated. Enables financial reporting, budget tracking, and P&L attribution by brand, category, or business unit.',
    `data_source_system` STRING COMMENT 'Operational system of record from which this consumer insight record originated or was ingested (e.g., Salesforce Marketing Cloud, Nielsen/IRI Syndicated Data, SPINS, Veeva Vault, TraceGains, internal survey platform). Supports data lineage and Silver Layer provenance tracking. [ENUM-REF-CANDIDATE: salesforce_marketing_cloud|nielsen_iri|spins|veeva_vault|tracegains|internal_survey|external_agency|other — 8 candidates stripped; promote to reference product]',
    `deliverable_date` DATE COMMENT 'The date on which the final research deliverable (report, topline, data file) was received from the vendor or published internally. Used for insight freshness tracking and NPD pipeline milestone management.',
    `deliverable_reference` STRING COMMENT 'Document reference, URL, or Veeva Vault document ID pointing to the primary research deliverable (final report, topline deck, data file). Enables direct access to source documentation for audit, compliance, and deeper analysis.',
    `fielding_end_date` DATE COMMENT 'The date on which data collection (fielding) concluded for the study. Together with fielding_start_date, defines the fieldwork window for temporal validity assessment of insights.',
    `fielding_start_date` DATE COMMENT 'The date on which data collection (fielding) commenced for the study. Used for timeline tracking, seasonal context analysis, and compliance with ESOMAR fieldwork documentation requirements.',
    `geography_scope` STRING COMMENT 'Geographic coverage of the study, expressed as country codes (ISO 3166-1 alpha-3), regions, or named markets (e.g., USA, USA|CAN|MEX, EMEA, National US). Supports market-level filtering and cross-market insight comparison.',
    `insight_action` STRING COMMENT 'The recommended business action or strategic implication derived from the key finding (e.g., Reformulate product X to reduce sodium, Reposition Brand Y toward health-conscious millennials). Bridges research output to commercial decision-making.',
    `insight_category` STRING COMMENT 'Business domain classification of the primary insight derived from the study. Enables routing of insights to the correct brand, innovation, or commercial team. [ENUM-REF-CANDIDATE: brand_equity|product_innovation|packaging|pricing|consumer_segmentation|category_dynamics|shopper_behavior|advertising_effectiveness|sustainability|competitive_intelligence — promote to reference product]',
    `insight_expiry_date` DATE COMMENT 'The date after which the insight is considered stale or no longer actionable due to market changes, product reformulation, or elapsed time. Supports insight lifecycle management and prevents outdated research from influencing current strategy.',
    `insight_priority` STRING COMMENT 'Business priority rating assigned to the insight by the commissioning team, indicating urgency and strategic importance for action. Drives triage and resource allocation in the innovation funnel and brand planning cycle.. Valid values are `critical|high|medium|low`',
    `key_finding_summary` STRING COMMENT 'Concise narrative summary of the primary actionable insight or finding derived from the study (max ~2000 characters). This is the SSOT for the headline insight used in brand strategy decks, NPD briefs, and innovation funnel reviews.',
    `npd_pipeline_flag` BOOLEAN COMMENT 'Indicates whether the insight is actively linked to or informing a New Product Development (NPD) initiative in the innovation pipeline (True). Enables filtering of insights that are driving active R&D and NPD gate decisions.',
    `nps_score` DECIMAL(18,2) COMMENT 'Net Promoter Score (NPS) result from the study, ranging from -100 to +100. Applicable only to NPS survey studies. Measures consumer likelihood to recommend the brand or product. Null for non-NPS study types.',
    `private_label_relevance` BOOLEAN COMMENT 'Indicates whether the study includes competitive analysis or consumer perception data related to private label products (True). Supports trade strategy, pricing, and brand differentiation decisions against private label competition.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this consumer insight record was first created in the Silver Layer lakehouse. Audit trail field for data lineage, compliance, and record provenance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this consumer insight record was last modified in the Silver Layer lakehouse. Supports change tracking, data freshness monitoring, and audit compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `regulatory_claim_flag` BOOLEAN COMMENT 'Indicates whether the research study was conducted to substantiate a marketing or labeling claim (True) or is general consumer research (False). Critical for FTC compliance — claim substantiation studies require specific documentation and retention per FTC guidelines.',
    `research_methodology` STRING COMMENT 'Specific research technique employed in the study (e.g., focus group, in-depth interview, online survey, sensory panel, organoleptic evaluation, ethnography, concept test, conjoint analysis, segmentation, U&A study, packaging test, pricing research, NPS survey). [ENUM-REF-CANDIDATE: focus_group|in_depth_interview|online_survey|sensory_panel|organoleptic_evaluation|concept_test|conjoint_analysis|segmentation|usage_and_attitude|packaging_test|pricing_research|nps_survey|ethnography|competitive_landscape — promote to reference product]',
    `research_vendor` STRING COMMENT 'Name of the external research agency, syndicated data provider, or consultancy that conducted or supplied the study (e.g., Nielsen, IRI, SPINS, Ipsos, Kantar, Mintel, Numerator). Used for vendor performance tracking and contract management alignment.',
    `sample_size` STRING COMMENT 'Total number of respondents or participants included in the study (n). Critical for assessing statistical significance, confidence intervals, and the reliability of quantitative findings. For qualitative studies, represents the number of participants.',
    `sensory_score` DECIMAL(18,2) COMMENT 'Composite sensory or organoleptic evaluation score from sensory panel studies (e.g., overall liking score on a 9-point hedonic scale). Applicable to sensory panel and organoleptic evaluation study types. Null for non-sensory studies. Supports product reformulation and quality assurance decisions.',
    `sku_scope` STRING COMMENT 'Specific SKU(s) evaluated in the study, if applicable (e.g., for concept tests, packaging tests, or sensory panels). References the SKU identifier from the product master. Null for broad category or brand-level studies.',
    `source_record_code` STRING COMMENT 'The native record identifier from the originating source system (e.g., Salesforce Campaign ID, Nielsen Study ID, Veeva Document ID). Enables traceability back to the system of record for reconciliation and audit.',
    `study_budget_usd` DECIMAL(18,2) COMMENT 'Total approved budget for the research study in US Dollars (USD). Confidential financial data used for marketing spend tracking, COGS allocation, and ROI measurement of consumer insights investment.',
    `study_code` STRING COMMENT 'Externally-known alphanumeric code assigned to the research study by the commissioning team or research vendor (e.g., CI-2024-001234). Serves as the BUSINESS_IDENTIFIER for cross-system reference and vendor invoicing alignment.. Valid values are `^[A-Z]{2,6}-[0-9]{4}-[0-9]{4,6}$`',
    `study_name` STRING COMMENT 'Full descriptive name of the consumer research study or insight initiative (e.g., Q3 2024 Snack Category Usage & Attitude Study — North America). Human-readable IDENTITY_LABEL used in reporting, presentations, and stakeholder communications.',
    `study_status` STRING COMMENT 'Current lifecycle state of the research study: planned (scoped, not yet fielded), fielding (data collection in progress), analysis (data collected, insights being synthesized), completed (final deliverable issued), cancelled, or on_hold. LIFECYCLE_STATUS for the consumer_insight entity.. Valid values are `planned|fielding|analysis|completed|cancelled|on_hold`',
    `study_type` STRING COMMENT 'High-level classification of the research methodology: qualitative (focus groups, ethnography), quantitative (surveys, panels), mixed_method, syndicated (Nielsen/IRI/SPINS subscriptions), or proprietary commissioned research. Drives analytical approach and data governance treatment.. Valid values are `qualitative|quantitative|mixed_method|syndicated|proprietary`',
    `sustainability_relevance` BOOLEAN COMMENT 'Indicates whether the study captures consumer attitudes or behaviors related to sustainability, environmental impact, packaging recyclability, or ESG-related purchasing drivers (True). Supports sustainability reporting and EPA compliance communications.',
    `target_segment` STRING COMMENT 'The consumer segment or audience profile that the study was designed to understand (e.g., Millennial Health-Conscious Snackers, Hispanic Families 25-44, Gen Z RTD Beverage Consumers). Aligns with brand segmentation frameworks and supports NPD pipeline targeting.',
    `vendor_project_code` STRING COMMENT 'The research vendors own project or study reference number. Enables cross-referencing with vendor invoices, deliverable portals, and data feeds for reconciliation and audit purposes.',
    CONSTRAINT pk_consumer_insight PRIMARY KEY(`consumer_insight_id`)
) COMMENT 'Master record for all consumer research studies and their derived insights — encompasses qualitative and quantitative studies (focus groups, sensory panels, organoleptic evaluations, NPS surveys, concept tests, U&A studies, segmentation, packaging tests, pricing research, competitive landscape studies). Captures study metadata (study name, research vendor, methodology, sample size, geography, category scope, fielding dates, status, key deliverable reference), key findings, insight category, target segment, and source system. SSOT for all commissioned/subscribed research and the actionable insights derived from them. Supports NPD pipeline, brand strategy, and innovation funnel.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` (
    `syndicated_market_data_id` BIGINT COMMENT 'Unique surrogate primary key for each syndicated market data record ingested from Nielsen, IRI, or SPINS data feeds.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Enables linking market data to brand entity; brand_name replaced by FK.',
    `acv_distribution_pct` DECIMAL(18,2) COMMENT 'The percentage of All Commodity Volume (ACV) in stores carrying the SKU. ACV-weighted distribution measures the quality of distribution by weighting store presence by store sales volume, not just store count. Key distribution health metric.',
    `avg_base_price` DECIMAL(18,2) COMMENT 'Average non-promoted (everyday) retail price per unit for the SKU, excluding promotional price reductions. Used to separate base demand from incremental lift driven by trade promotions in TPM/TPO analysis.',
    `avg_selling_price` DECIMAL(18,2) COMMENT 'Average retail selling price per unit (dollar sales divided by unit sales) for the SKU in the specified market and period. Used for price positioning analysis, price elasticity modeling, and RSP (Recommended Selling Price) compliance monitoring.',
    `category_name` STRING COMMENT 'The product category as defined by the syndicated data provider (e.g., Carbonated Soft Drinks, Salty Snacks, Yogurt). Aligns with the category management hierarchy used in planogram and shelf space decisions.',
    `data_aggregation_level` STRING COMMENT 'Indicates the level of product hierarchy at which this syndicated data record is aggregated. Records may be at SKU/UPC level, brand level, subcategory, category, or manufacturer level depending on the data pull configuration.. Valid values are `SKU|Brand|Subcategory|Category|Manufacturer`',
    `data_load_timestamp` TIMESTAMP COMMENT 'The timestamp when this syndicated market data record was ingested into the Databricks Silver Layer. Used for data freshness monitoring, pipeline auditing, and identifying the most recent data refresh from each syndicated data provider.',
    `data_vintage_date` DATE COMMENT 'The date on which the syndicated data provider published or released this data extract. Distinct from the period_end_date (what was measured) and data_load_timestamp (when ingested). Used to track data latency and manage version conflicts when providers restate historical data.',
    `display_pct` DECIMAL(18,2) COMMENT 'Percentage of ACV where the SKU had incremental in-store display (off-shelf, end-cap, secondary placement) during the period. Measures the breadth of display support and is a key input to trade promotion optimization (TPO) models.',
    `dollar_sales` DECIMAL(18,2) COMMENT 'Total retail dollar sales (in USD) for the SKU/brand/category in the specified market and period as measured by the syndicated data provider. The primary revenue performance metric used in brand and category management reviews.',
    `dollar_sales_change_pct` DECIMAL(18,2) COMMENT 'Year-over-year percentage change in dollar sales for the SKU/brand in the specified market and period as reported by the syndicated data provider. Used for trend analysis and brand performance reporting in category reviews.',
    `dollar_share_pct` DECIMAL(18,2) COMMENT 'The percentage share of total category dollar sales captured by this brand/SKU in the specified market and period. Core brand equity and competitive performance KPI reported in category management reviews.',
    `equivalent_unit_sales` DECIMAL(18,2) COMMENT 'Unit sales normalized to a standard equivalent unit (e.g., single-serve equivalent, ounce-equivalent) to enable cross-pack-size volume comparisons. Used in volume share and velocity benchmarking across different pack configurations.',
    `feature_pct` DECIMAL(18,2) COMMENT 'Percentage of ACV where the SKU was featured in retailer advertising (circular, digital ad) during the period. Measures the breadth of feature support and is a key input to trade promotion optimization (TPO) models.',
    `gtin` STRING COMMENT 'The 14-digit Global Trade Item Number (GTIN) for the product SKU, conforming to GS1 standards. Used for international market data alignment and cross-market product matching beyond the US UPC standard.. Valid values are `^[0-9]{14}$`',
    `is_own_brand` BOOLEAN COMMENT 'Indicates whether this record represents a Food Beverage owned brand (True) or a competitor brand (False). Enables filtering of internal versus competitive data in brand performance dashboards and market share reports.',
    `is_private_label` BOOLEAN COMMENT 'Indicates whether this record represents a private label (store brand) product (True) or a branded product (False). Used to track private label competitive pressure and category penetration in brand strategy analysis.',
    `manufacturer_name` STRING COMMENT 'The name of the manufacturer or parent company associated with the brand as reported by the syndicated data provider. Used for competitive manufacturer-level share analysis and M&A impact tracking.',
    `market_name` STRING COMMENT 'The named geographic or retail market as defined by the syndicated data provider (e.g., Total US, New York Metro, Walmart National, MULO+C). Represents the geographic or account-level scope of the measurement.',
    `market_type` STRING COMMENT 'Classification of the market geography scope: Total US (national aggregate), Regional (geographic sub-market), Account-Specific (retailer-level market), or Channel (e.g., grocery, mass, drug, club, natural). Drives market share calculation methodology.. Valid values are `Total US|Regional|Account-Specific|Channel`',
    `numeric_distribution_pct` DECIMAL(18,2) COMMENT 'Percentage of total stores in the market carrying the SKU (stores_selling / total_stores_in_market × 100). Unweighted distribution measure used alongside ACV distribution to assess distribution breadth versus quality.',
    `pack_size` STRING COMMENT 'The consumer-facing pack size descriptor for the SKU as reported by the syndicated data provider (e.g., 12oz, 2L, 6-Pack, 24-Count). Used for price-per-unit normalization and pack-size mix analysis.',
    `period_end_date` DATE COMMENT 'The last calendar date of the reporting period covered by this syndicated data record. Used as the primary time dimension for trend analysis, period-over-period comparisons, and alignment with internal sales data.',
    `period_start_date` DATE COMMENT 'The first calendar date of the reporting period covered by this syndicated data record. Combined with period_end_date to define the exact measurement window.',
    `price_reduction_pct` DECIMAL(18,2) COMMENT 'Percentage of ACV where the SKU was sold at a temporary price reduction (TPR) without feature or display support. Used to isolate the impact of price-only promotions on volume lift in trade promotion analysis.',
    `promoted_dollar_sales` DECIMAL(18,2) COMMENT 'Dollar sales generated while the SKU was on promotion (feature, display, price reduction, or combination). Used to calculate promotional lift and evaluate trade promotion effectiveness in TPM analysis.',
    `promoted_unit_sales` DECIMAL(18,2) COMMENT 'Unit sales generated while the SKU was on promotion. Combined with promoted_dollar_sales to calculate promotional price per unit and assess volume lift from trade promotion activities.',
    `reporting_period_type` STRING COMMENT 'The aggregation period granularity of the syndicated data record as defined by the data provider. Common periods include 4-Week, 12-Week, and 52-Week rolling windows used in category management and brand performance reviews.. Valid values are `4-Week|12-Week|52-Week|Weekly|Monthly|Quarterly`',
    `retail_channel` STRING COMMENT 'The retail trade channel in which sales were measured (e.g., Grocery, Mass Merchandise, Drug, Club, Dollar, Convenience, Natural/Specialty, E-Commerce). Used for channel-level performance benchmarking and distribution strategy. [ENUM-REF-CANDIDATE: Grocery|Mass|Drug|Club|Dollar|Convenience|Natural|E-Commerce|Foodservice — promote to reference product]',
    `segment_name` STRING COMMENT 'The product segment within the subcategory hierarchy (e.g., Flavored Water within the Water subcategory). Represents the third level of the syndicated data category hierarchy used for competitive benchmarking.',
    `sku_description` STRING COMMENT 'The human-readable product description for the SKU as reported by the syndicated data provider (e.g., Brand X Cola 12oz Can 12-Pack). Used for product identification in reports and dashboards when internal product master data is unavailable.',
    `source_record_code` STRING COMMENT 'The native record or row identifier assigned by the originating syndicated data provider (Nielsen, IRI, or SPINS). Used for lineage tracing, deduplication, and re-ingestion reconciliation.',
    `source_system` STRING COMMENT 'Identifies the syndicated data provider that supplied this record. Nielsen and IRI cover conventional retail channels; SPINS (Specialty Product Intelligence) covers natural and specialty channels. Critical for reconciling overlapping market coverage and avoiding double-counting.. Valid values are `Nielsen|IRI|SPINS`',
    `stores_selling` STRING COMMENT 'The count of retail stores in the market that recorded at least one unit sale of the SKU during the reporting period. Used to assess numeric distribution and identify distribution gaps versus total stores in the market.',
    `subcategory_name` STRING COMMENT 'The product subcategory within the broader category hierarchy as defined by the syndicated data provider (e.g., Regular CSD, Diet CSD within Carbonated Soft Drinks). Supports granular category management analysis.',
    `tdp` DECIMAL(18,2) COMMENT 'Total Distribution Points (TDP) — the sum of ACV distribution percentages across all items in a brand or category. Measures the breadth of a brands distribution footprint. Used in distribution gap analysis and new item launch tracking.',
    `total_stores_in_market` STRING COMMENT 'The total number of retail stores in the defined market universe as reported by the syndicated data provider. Used as the denominator for numeric distribution calculations and store-count-based share metrics.',
    `unit_sales` DECIMAL(18,2) COMMENT 'Total consumer units sold for the SKU/brand/category in the specified market and period. Used for volume performance tracking, velocity calculations, and distribution efficiency analysis.',
    `unit_sales_change_pct` DECIMAL(18,2) COMMENT 'Year-over-year percentage change in unit sales for the SKU/brand in the specified market and period as reported by the syndicated data provider. Complements dollar sales change to reveal volume versus pricing dynamics.',
    `unit_share_pct` DECIMAL(18,2) COMMENT 'The percentage share of total category unit sales captured by this brand/SKU in the specified market and period. Complements dollar share to reveal pricing and mix dynamics versus competitors.',
    `upc_code` STRING COMMENT 'The 12-digit Universal Product Code (UPC) identifying the specific SKU measured in this record. Primary product identifier used to link syndicated data to internal product master data in SAP S/4HANA MM.. Valid values are `^[0-9]{12}$`',
    `velocity_per_store_per_week` DECIMAL(18,2) COMMENT 'Average dollar or unit sales per store selling per week (SPSW). Measures the rate of sale for a SKU in stores where it is distributed. Critical for evaluating item productivity and justifying shelf space in planogram negotiations.',
    CONSTRAINT pk_syndicated_market_data PRIMARY KEY(`syndicated_market_data_id`)
) COMMENT 'Transactional record ingesting Nielsen/IRI/SPINS syndicated market data — captures period, market/geography, category, brand, SKU/UPC, dollar sales, unit sales, ACV (All Commodity Volume), TDP (Total Distribution Points), velocity, market share, and price per unit. Source system tagged (Nielsen, IRI, SPINS). Supports category management and brand performance tracking.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` (
    `brand_equity_tracker_id` BIGINT COMMENT 'Unique surrogate identifier for each brand equity measurement record in the tracker. Primary key for the brand_equity_tracker data product.',
    `brand_id` BIGINT COMMENT 'Reference to the brand being measured in this equity tracking record. Links to the brand master data entity.',
    `segment_id` BIGINT COMMENT 'Reference to the consumer segment (e.g., millennials, health-conscious, heavy users) for which brand equity metrics are reported. Enables segment-level brand health analysis.',
    `market_id` BIGINT COMMENT 'Reference to the geographic market or region in which brand equity is being measured (e.g., US, UK, Germany). Supports multi-market brand health comparison.',
    `advertising_recall_pct` DECIMAL(18,2) COMMENT 'Percentage of surveyed consumers who recall seeing or hearing advertising for the brand in the measurement period. Measures advertising effectiveness and media investment impact on brand awareness. Expressed as a percentage (0.00–100.00).',
    `aided_awareness_pct` DECIMAL(18,2) COMMENT 'Percentage of surveyed consumers who recognize the brand when shown or told the brand name. Measures total brand recognition in the target market. Expressed as a percentage (0.00–100.00).',
    `brand_equity_status` STRING COMMENT 'Lifecycle status of this brand equity measurement record. preliminary indicates data is not yet finalized; final indicates validated and approved data; restated indicates a correction to a previously published record; archived indicates superseded records.. Valid values are `active|archived|preliminary|final|restated`',
    `brand_health_index` DECIMAL(18,2) COMMENT 'Composite index score aggregating multiple brand equity dimensions (awareness, consideration, trial, repeat, love, NPS) into a single brand health measure. Methodology and weighting defined by the tracking study. Used for executive-level brand performance monitoring.',
    `brand_love_score` DECIMAL(18,2) COMMENT 'Composite score measuring the emotional affinity and loyalty consumers have toward the brand. Typically derived from survey questions on emotional connection, advocacy, and preference. Scale defined by the tracking study methodology.',
    `brand_preference_pct` DECIMAL(18,2) COMMENT 'Percentage of surveyed consumers who prefer the brand over competitive alternatives in the category. Measures competitive brand positioning and differentiation. Expressed as a percentage (0.00–100.00).',
    `brand_quality_perception_score` DECIMAL(18,2) COMMENT 'Score measuring consumer perception of the brands product quality, including taste, freshness, ingredients, and overall product experience. Critical for food and beverage brand positioning and premium pricing strategy.',
    `brand_trust_score` DECIMAL(18,2) COMMENT 'Score measuring consumer trust in the brand, typically derived from survey questions on reliability, safety, and quality perceptions. Particularly relevant for food and beverage brands given food safety and clean label consumer expectations.',
    `brand_value_perception_score` DECIMAL(18,2) COMMENT 'Score measuring consumer perception of the brands value for money relative to its price point. Supports Revenue Management and Pricing Strategy (RSP/EDLP) decisions and trade promotion effectiveness analysis.',
    `category_name` STRING COMMENT 'The product category in which the brand competes and is being measured (e.g., Carbonated Soft Drinks, Salty Snacks, Dairy Beverages, Ready-to-Eat Cereals). Enables category-level brand equity benchmarking.',
    `clean_label_perception_score` DECIMAL(18,2) COMMENT 'Score measuring consumer perception of the brands commitment to clean label attributes (natural ingredients, no artificial additives, transparent labeling). Highly relevant in the food and beverage industry given growing consumer demand for clean label products.',
    `competitive_set_label` STRING COMMENT 'Label identifying the defined set of competitor brands included in the tracking study for benchmarking purposes (e.g., Core 5 Competitors, Total Category Set). Ensures consistent competitive context across measurement waves.',
    `confidence_interval_pct` DECIMAL(18,2) COMMENT 'The margin of error (confidence interval) expressed as a percentage for the reported brand equity metrics, based on the sample size and study methodology. Typically ±2% to ±5%. Used to assess statistical significance of period-over-period changes.',
    `consideration_pct` DECIMAL(18,2) COMMENT 'Percentage of surveyed consumers who would consider purchasing the brand the next time they are in the market for the category. Measures brand relevance and purchase funnel progression. Expressed as a percentage (0.00–100.00).',
    `data_collection_method` STRING COMMENT 'The primary methodology used to collect consumer survey data for this measurement wave (e.g., online panel, telephone interview, in-person interview, mobile survey). Affects comparability across waves and markets.. Valid values are `online_panel|telephone|in_person|mobile|mixed_method`',
    `detractor_pct` DECIMAL(18,2) COMMENT 'Percentage of surveyed consumers classified as detractors (NPS score 0-6) who are unlikely to recommend the brand and may actively discourage others. Component of the NPS calculation. Expressed as a percentage (0.00–100.00).',
    `market_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the market in which brand equity is measured (e.g., USA, GBR, DEU). Enables standardized cross-market reporting.. Valid values are `^[A-Z]{3}$`',
    `measurement_period_end_date` DATE COMMENT 'The last date of the measurement period covered by this brand equity record. Together with measurement_period_start_date, defines the tracking wave window.',
    `measurement_period_start_date` DATE COMMENT 'The first date of the measurement period covered by this brand equity record. Used to define the temporal window of the tracking wave (e.g., Q1 start, monthly wave start).',
    `nps_score` DECIMAL(18,2) COMMENT 'Net Promoter Score (NPS) for the brand, calculated as the percentage of promoters minus the percentage of detractors among surveyed consumers. Ranges from -100 to +100. Measures consumer advocacy and brand loyalty.',
    `period_over_period_change_flag` BOOLEAN COMMENT 'Indicates whether the brand health index change from the prior measurement period is statistically significant based on the confidence interval. True = statistically significant change detected; False = change within margin of error. Supports brand performance alerting.',
    `promoter_pct` DECIMAL(18,2) COMMENT 'Percentage of surveyed consumers classified as promoters (NPS score 9-10) who are highly likely to recommend the brand. Component of the NPS calculation. Expressed as a percentage (0.00–100.00).',
    `purchase_intent_pct` DECIMAL(18,2) COMMENT 'Percentage of surveyed consumers who indicate they intend to purchase the brand in the near future (typically next 30 days). A leading indicator of short-term sales performance. Expressed as a percentage (0.00–100.00).',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this brand equity tracker record was first created in the data platform. Used for audit trail, data lineage, and Silver Layer ingestion tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this brand equity tracker record was last modified in the data platform. Used for change tracking, incremental processing, and audit trail in the Databricks Silver Layer. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `repeat_purchase_pct` DECIMAL(18,2) COMMENT 'Percentage of consumers who have tried the brand and subsequently purchased it again. Measures brand loyalty and consumer retention. Expressed as a percentage (0.00–100.00).',
    `research_vendor_name` STRING COMMENT 'Name of the third-party market research vendor or syndicated data provider that conducted the tracking study (e.g., Nielsen, IRI, SPINS, Kantar, Ipsos). Used for data lineage, vendor management, and methodology comparability.',
    `sample_size` STRING COMMENT 'Number of consumers surveyed in this measurement wave for the specified brand, market, and consumer segment combination. Used to assess statistical reliability and confidence of the reported brand equity metrics.',
    `social_media_sentiment_score` DECIMAL(18,2) COMMENT 'Composite score reflecting the overall sentiment (positive, neutral, negative) of consumer conversations about the brand on social media platforms during the measurement period. Sourced from social listening tools integrated with Salesforce Marketing Cloud.',
    `source_system_code` STRING COMMENT 'Code identifying the originating system or data provider for this brand equity measurement record. Supports data lineage tracking and multi-source reconciliation in the Databricks Silver Layer. [ENUM-REF-CANDIDATE: NIELSEN|IRI|SPINS|KANTAR|IPSOS|INTERNAL|OTHER — 7 candidates stripped; promote to reference product]',
    `sustainability_perception_score` DECIMAL(18,2) COMMENT 'Score measuring consumer perception of the brands sustainability credentials, including environmental responsibility, ethical sourcing, and packaging sustainability. Supports the Sustainability data domain and ESG reporting.',
    `tracking_study_code` BIGINT COMMENT 'Reference to the brand tracking study or research program that generated this measurement record. Links to the study design, methodology, and vendor details.',
    `trial_pct` DECIMAL(18,2) COMMENT 'Percentage of surveyed consumers who have ever purchased or tried the brand at least once. Measures brand penetration and new consumer acquisition effectiveness. Expressed as a percentage (0.00–100.00).',
    `unaided_awareness_pct` DECIMAL(18,2) COMMENT 'Percentage of surveyed consumers who spontaneously mention the brand when asked about brands in the category, without any prompting. A key top-of-mind brand health metric. Expressed as a percentage (0.00–100.00).',
    `wave_label` STRING COMMENT 'Human-readable label identifying the measurement wave (e.g., Q1 2024, Wave 3 2024, Jan 2024). Used for reporting and trend analysis across tracking periods.',
    `wave_type` STRING COMMENT 'Frequency classification of the measurement wave. Indicates whether the tracking study is conducted monthly, quarterly, bi-annually, annually, or on an ad hoc basis.. Valid values are `monthly|quarterly|bi-annual|annual|ad_hoc`',
    CONSTRAINT pk_brand_equity_tracker PRIMARY KEY(`brand_equity_tracker_id`)
) COMMENT 'Periodic measurement record of brand equity KPIs — awareness (aided/unaided), consideration, trial, repeat purchase, brand love score, NPS, purchase intent, and brand health index. Captured by brand, market, consumer segment, and measurement period. Sourced from tracking studies and panel data. Supports brand equity monitoring over time.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`marketing`.`claim` (
    `claim_id` BIGINT COMMENT 'Unique surrogate identifier for each marketing claim record. Primary key for the marketing_claim data product. Role: MASTER_RESOURCE — this entity represents a managed business resource (a claim definition) with its own identity, lifecycle, and traceability requirements.',
    `brand_id` BIGINT COMMENT 'Reference to the brand under which this marketing claim is managed. Claims may be brand-specific (e.g., a Clean Label claim owned by a specific brand) or cross-brand. Supports brand equity tracking and brand-level claim portfolio management.',
    `formulation_version_id` BIGINT COMMENT 'Foreign key linking to research.formulation_version. Business justification: Claims are substantiated against a particular formulation version, ensuring regulatory compliance.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Claim Management: each marketing claim must be tied to the product registration to verify regulatory compliance.',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU (Stock Keeping Unit) to which this marketing claim applies. Enables claim-to-SKU traceability as the SSOT for which claims appear on which products. A single claim definition may be linked to multiple SKUs; this field captures the SKU-level applicability.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Claims about ingredient origin require a supplier reference to verify certifications and regulatory compliance.',
    `allergen_related_flag` BOOLEAN COMMENT 'Indicates whether this claim is related to allergen absence or management (True = allergen-related, e.g., Gluten-Free, Peanut-Free, Dairy-Free; False = not allergen-related). Triggers additional substantiation and HACCP review requirements per FSMA and FDA allergen labeling rules.',
    `approval_date` DATE COMMENT 'Date on which the marketing claim received final internal approval (legal, regulatory, and marketing sign-off) to be used on packaging or in advertising. Distinct from effective_start_date which governs when the claim goes live in market.',
    `certification_expiry_date` DATE COMMENT 'Date on which the third-party certification supporting this claim expires and must be renewed. Triggers renewal workflow to prevent lapse in claim validity. Null for claims without external certification.',
    `certification_number` STRING COMMENT 'Official certificate or license number issued by the certifying body for this claim. Used for regulatory audit trails and label compliance verification. Null for non-certified claims.',
    `certifying_body` STRING COMMENT 'Name of the third-party organization that issued the certification supporting this claim, where applicable (e.g., Non-GMO Project, NSF International, USDA Organic, Rainforest Alliance, Kosher Certification Agency). Null for claims not backed by external certification.',
    `channel_applicability` STRING COMMENT 'Marketing channel(s) on which this claim is approved for use: packaging = on-pack label; digital = website, social media, e-commerce; advertising = TV, print, radio; in_store = shelf talkers, POS displays; foodservice = menu boards, distributor materials; all = approved for all channels. Drives Salesforce Marketing Cloud campaign governance and FTC compliance.. Valid values are `packaging|digital|advertising|all|in_store|foodservice`',
    `claim_code` STRING COMMENT 'Externally-known, human-readable unique code assigned to the marketing claim (e.g., CLM-NONGMO001). Used as the business identifier across PLM, TraceGains, and Veeva Vault systems for cross-system traceability. Aligns with BUSINESS_IDENTIFIER category for MASTER_RESOURCE role.. Valid values are `^CLM-[A-Z0-9]{4,12}$`',
    `claim_name` STRING COMMENT 'Short, human-readable label for the marketing claim as it appears in internal systems and reporting (e.g., Non-GMO, Gluten-Free, Heart Healthy). Serves as the IDENTITY_LABEL for the claim resource.',
    `claim_status` STRING COMMENT 'Current lifecycle state of the marketing claim record. Controls whether the claim may be applied to SKUs and used in marketing materials. Aligns with LIFECYCLE_STATUS category for MASTER_RESOURCE role. draft = under development; pending_review = submitted for legal/regulatory review; approved = cleared for use; active = currently in use on packaging or advertising; suspended = temporarily halted pending investigation; expired = past effective end date; withdrawn = permanently retired. [ENUM-REF-CANDIDATE: draft|pending_review|approved|active|suspended|expired|withdrawn — 7 candidates stripped; promote to reference product]',
    `claim_text` STRING COMMENT 'Full verbatim text of the claim as it appears on packaging, advertising, or digital channels (e.g., Made with No Artificial Colors or Flavors). This is the exact consumer-facing language subject to FTC and FDA review.',
    `claim_type` STRING COMMENT 'Categorical classification of the claim by its primary business purpose: nutritional (e.g., low sodium, high fiber), environmental (e.g., sustainably sourced, recyclable packaging), lifestyle (e.g., keto-friendly, vegan), ingredient (e.g., no artificial colors), process (e.g., cold-pressed, small-batch), certification (e.g., USDA Organic, Non-GMO Project Verified). Aligns with CLASSIFICATION_OR_TYPE category.. Valid values are `nutritional|environmental|lifestyle|ingredient|process|certification`',
    `clean_label_flag` BOOLEAN COMMENT 'Indicates whether this claim is part of the companys clean label strategy (True = clean label claim; False = standard marketing claim). Clean label claims include No Artificial Ingredients, Simple Ingredients, Non-GMO, etc. Supports clean label portfolio reporting and NPD strategy.',
    `competitor_parity_flag` BOOLEAN COMMENT 'Indicates whether this claim is being made primarily to achieve competitive parity with market competitors (True = parity claim driven by competitive intelligence; False = differentiation or proprietary claim). Supports trade marketing and category captain strategy analysis.',
    `consumer_research_ref` STRING COMMENT 'Reference identifier for consumer research study (e.g., sensory panel, NPS survey, focus group) that validated consumer understanding and purchase intent impact of this claim. Supports FTC reasonable consumer substantiation standard and NPD claim strategy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this marketing claim record was first created in the data platform. Aligns with RECORD_AUDIT_CREATED category for MASTER_RESOURCE role. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `effective_end_date` DATE COMMENT 'Date after which the marketing claim is no longer valid for use. Nullable for open-ended claims with no planned expiry. Aligns with EFFECTIVE_UNTIL category. Triggers claim expiry workflow and packaging update notifications.',
    `effective_start_date` DATE COMMENT 'Date from which the marketing claim is valid and may appear on packaging, advertising, or digital channels. Aligns with EFFECTIVE_FROM category. Used for claim-to-SKU applicability windows and regulatory audit trails.',
    `environmental_claim_flag` BOOLEAN COMMENT 'Indicates whether this claim makes an environmental or sustainability assertion (True = environmental claim subject to FTC Green Guides, e.g., Recyclable, Carbon Neutral, Sustainably Sourced; False = non-environmental claim). Environmental claims require specific substantiation per FTC 16 CFR Part 260.',
    `last_reviewed_date` DATE COMMENT 'Date on which the most recent periodic review of this claims substantiation and regulatory compliance was completed. Used to calculate next_review_date and to demonstrate ongoing due diligence in regulatory audits.',
    `legal_review_status` STRING COMMENT 'Status of the legal departments review of this marketing claim for FTC compliance, IP considerations, and competitive claim accuracy. Distinct from regulatory approval — legal review focuses on advertising law, substantiation adequacy, and litigation risk.. Valid values are `not_required|pending|approved|rejected|escalated`',
    `legal_reviewer` STRING COMMENT 'Name or employee identifier of the legal counsel who reviewed and approved or rejected this marketing claim. Provides accountability trail for FTC compliance and internal governance.',
    `market_region` STRING COMMENT 'Geographic market or region where this claim is approved for use, expressed as ISO 3166-1 alpha-3 country code or regional grouping (e.g., USA, CAN, GBR, DEU). Claims may have different regulatory approval status across markets. Supports multi-market labeling compliance.',
    `marketing_owner` STRING COMMENT 'Name or employee identifier of the marketing team member responsible for managing this claims lifecycle, including renewal, substantiation updates, and channel deployment. Primary business owner for claim governance.',
    `next_review_date` DATE COMMENT 'Date on which the next mandatory periodic review of this claims substantiation and regulatory compliance is due. Calculated from last review date plus review_frequency_days. Triggers review workflow in Veeva Vault and notifies marketing owner and regulatory reviewer.',
    `notes` STRING COMMENT 'Free-text field for additional context, caveats, or operational notes related to this marketing claim (e.g., Claim valid only for products manufactured at Facility X, Pending re-certification renewal Q3 2025, FTC inquiry resolved 2024-01-15). Not used for structured data.',
    `organic_claim_flag` BOOLEAN COMMENT 'Indicates whether this claim involves an organic assertion (True = organic claim subject to USDA National Organic Program or equivalent; False = non-organic claim). Organic claims require USDA NOP certification and are subject to strict regulatory oversight.',
    `packaging_version` STRING COMMENT 'Specific version or revision of the packaging artwork on which this claim appears (e.g., v3.2, PV-2024-A). Critical for traceability when packaging artwork is updated — ensures the claim is only associated with the correct packaging iteration. Aligns with PLM packaging version control.',
    `priority` STRING COMMENT 'Business priority tier assigned to this claim for packaging real estate and advertising emphasis decisions: tier_1 = hero claim (front-of-pack, primary advertising message); tier_2 = supporting claim (back-of-pack, secondary messaging); tier_3 = supplementary claim (website, digital only). Supports planogram and packaging design decisions.. Valid values are `tier_1|tier_2|tier_3`',
    `product_category` STRING COMMENT 'The product category to which this claim is applicable (e.g., Snacks, Beverages, Dairy, Packaged Foods). Used for claim portfolio analysis by category and to support category captain and planogram strategies.',
    `regulatory_approval_ref` STRING COMMENT 'Reference number or identifier for the regulatory approval, filing, or notification associated with this claim in a specific market (e.g., FDA GRAS notification number, USDA organic certificate number, EFSA health claim authorization reference). Supports regulatory audit and labeling compliance verification.',
    `regulatory_basis` STRING COMMENT 'Primary regulatory authority or standard that governs the permissibility and substantiation requirements of this claim (e.g., FDA for nutrient content claims, FTC for environmental marketing claims, USDA for organic claims). Drives compliance workflow routing and substantiation documentation requirements. [ENUM-REF-CANDIDATE: FDA|FTC|USDA|EFSA|Codex|EPA|ISO|GFSI|None — 9 candidates stripped; promote to reference product]',
    `regulatory_reviewer` STRING COMMENT 'Name or employee identifier of the regulatory affairs professional who reviewed this claim for compliance with FDA, USDA, EFSA, or other applicable regulations. Provides accountability trail for regulatory audit purposes.',
    `review_frequency_days` STRING COMMENT 'Number of days between mandatory periodic reviews of this claims substantiation and regulatory compliance. Drives automated review scheduling in Veeva Vault. Typical values: 365 (annual), 730 (biennial). Ensures claims remain substantiated and compliant over time.',
    `source_system` STRING COMMENT 'Operational system of record from which this marketing claim record originated or is mastered: TraceGains (specification and supplier compliance management), Veeva_Vault (quality and document control), SAP_S4HANA (material master and labeling), Salesforce_MC (marketing campaign execution), Manual (entered directly into the data platform).. Valid values are `TraceGains|Veeva_Vault|SAP_S4HANA|Salesforce_MC|Manual`',
    `source_system_claim_code` STRING COMMENT 'The native identifier for this claim record in the originating operational system (e.g., TraceGains document ID, Veeva Vault record ID, SAP material specification number). Enables bidirectional traceability between the Silver Layer data product and the system of record.',
    `substantiation_doc_ref` STRING COMMENT 'Reference identifier for the substantiation document stored in Veeva Vault or TraceGains that provides the scientific, regulatory, or third-party evidence supporting the claim (e.g., lab test results, certification body certificate, clinical study reference, supplier attestation). Required for FTC substantiation standard compliance.',
    `substantiation_type` STRING COMMENT 'Type of evidence used to substantiate the marketing claim. Determines the rigor and auditability of the claims support: lab_test = analytical laboratory results; third_party_cert = certification body verification (e.g., Non-GMO Project, NSF); clinical_study = peer-reviewed or commissioned research; supplier_attestation = supplier-provided declaration; regulatory_filing = FDA/USDA submission; internal_audit = internal quality audit.. Valid values are `lab_test|third_party_cert|clinical_study|supplier_attestation|regulatory_filing|internal_audit`',
    `subtype` STRING COMMENT 'Secondary classification providing finer granularity within the claim type (e.g., within nutritional: health claim, nutrient content claim, structure/function claim; within environmental: packaging, sourcing, carbon). Supports detailed regulatory mapping and clean label strategy analytics. [ENUM-REF-CANDIDATE: health_claim|nutrient_content_claim|structure_function_claim|allergen_free|organic|non_gmo|fair_trade|carbon_neutral|recyclable — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this marketing claim record was most recently modified in the data platform. Supports audit trail, change detection, and incremental data pipeline processing. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_claim PRIMARY KEY(`claim_id`)
) COMMENT 'Master record for all marketing and labeling claims made on packaging, advertising, and digital channels — e.g., No Artificial Colors, Non-GMO, Gluten-Free, Heart Healthy, Clean Label. Captures claim text, claim type (nutritional, environmental, lifestyle), regulatory basis (FDA, FTC, USDA), substantiation document reference, approval status, effective/expiry dates, and SKU-level applicability including which claims appear on which packaging versions in which markets (SKU identifier, packaging version, market/region, regulatory approval reference). SSOT for both claim definition and claim-to-SKU traceability. Supports FTC/FDA labeling compliance and clean label strategy.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` (
    `claim_substantiation_id` BIGINT COMMENT 'Unique surrogate identifier for each claim substantiation record. Primary key for the claim_substantiation data product in the Databricks Silver Layer.',
    `brand_id` BIGINT COMMENT 'FK to marketing.brand',
    `claim_id` BIGINT COMMENT 'Reference to the parent marketing claim that this substantiation record supports. One claim may have multiple substantiation records across its lifecycle.',
    `label_approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.label_approval. Business justification: Label Approval Reference: claim substantiation documents require a link to the label approval record that validates the claim.',
    `employee_id` BIGINT COMMENT 'System user identifier of the individual who created this substantiation record. Supports electronic signature and audit trail requirements under FDA 21 CFR Part 11 and Veeva Vault Document Control.',
    `specification_id` BIGINT COMMENT 'Specification identifier in TraceGains Supplier Compliance and Specification Management system, linking this substantiation to the relevant product or ingredient specification that supports the claim.',
    `superseded_by_claim_substantiation_id` BIGINT COMMENT 'Reference to the newer claim_substantiation_id that replaces this record upon renewal or revision. Null if this is the current active version. Enables full substantiation lineage tracing across the claim lifecycle.',
    `allergen_claim_flag` BOOLEAN COMMENT 'Indicates whether the substantiated claim relates to allergen content (e.g., gluten-free, nut-free). True triggers additional FSMA and FDA allergen labeling compliance review.',
    `approval_date` DATE COMMENT 'Calendar date on which the substantiation record received final approval, authorizing the associated marketing claim for consumer-facing use. Key compliance milestone for FTC and FDA audit trails.',
    `approving_authority_name` STRING COMMENT 'Name or title of the individual, committee, or regulatory body that granted final approval for this substantiation record. Supports audit trail requirements for FTC and FDA compliance.',
    `approving_authority_role` STRING COMMENT 'Functional role of the approving authority within the organization or regulatory body. Ensures the correct level of authority has signed off on the substantiation per internal governance policy.. Valid values are `regulatory_affairs|legal_counsel|scientific_committee|quality_director|external_auditor`',
    `channel_scope` STRING COMMENT 'Distribution or marketing channel(s) for which this substantiation is valid. Claim usage may be restricted to specific channels (e.g., a claim approved for retail packaging may not be approved for digital advertising).. Valid values are `retail|foodservice|direct_to_consumer|digital|all_channels`',
    `claim_category` STRING COMMENT 'Regulatory classification of the claim type, determining the applicable substantiation standard and governing body oversight. Health claims require FDA pre-authorization; environmental claims are subject to FTC Green Guides. [ENUM-REF-CANDIDATE: health_claim|nutrient_content_claim|structure_function_claim|environmental_claim|organic_claim|clean_label_claim — promote to reference product]. Valid values are `health_claim|nutrient_content_claim|structure_function_claim|environmental_claim|organic_claim|clean_label_claim`',
    `claim_text` STRING COMMENT 'Verbatim consumer-facing claim statement that this substantiation record supports, as it appears on packaging, advertising, or digital media. Captured for FTC and FDA compliance audit trail.',
    `conditions_of_use` STRING COMMENT 'Specific conditions, disclaimers, or usage restrictions that must accompany the claim when used in consumer-facing communications. Examples include serving size qualifications or population-specific restrictions per FDA health claim regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this substantiation record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail requirements for FDA 21 CFR Part 11 electronic records compliance.',
    `effective_from_date` DATE COMMENT 'Date from which this substantiation record is valid and the associated claim may be used in consumer-facing communications. Aligns with campaign launch dates managed in Salesforce Marketing Cloud.',
    `expiry_date` DATE COMMENT 'Date on which this substantiation record expires and the associated claim must cease consumer-facing use unless renewed. Drives automated compliance alerts for re-substantiation workflows.',
    `ftc_challenge_risk` STRING COMMENT 'Internal risk assessment of the likelihood that the FTC would challenge this claim substantiation. Assigned by the Regulatory Affairs team. Classified confidential as it reflects internal legal risk posture.. Valid values are `low|medium|high|critical`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this substantiation record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Required for change tracking and audit trail under FDA 21 CFR Part 11.',
    `legal_review_outcome` STRING COMMENT 'Outcome of the legal department review of the claim substantiation package. Approved with conditions may require claim text modification before consumer-facing use. Classified confidential due to legal privilege.. Valid values are `approved|approved_with_conditions|rejected|pending`',
    `legal_review_reference` STRING COMMENT 'Internal legal department reference number for the legal review record associated with this substantiation. Links to the legal opinion or counsel sign-off document stored in Veeva Vault Document Control. Classified confidential due to attorney-client privilege considerations.',
    `market_geography` STRING COMMENT 'Three-letter ISO 3166-1 Alpha-3 country code identifying the market geography in which this substantiation is valid. Substantiation requirements vary by jurisdiction (e.g., FDA for USA, EFSA for EU member states).. Valid values are `^[A-Z]{3}$`',
    `media_type_scope` STRING COMMENT 'Media format(s) for which this substantiation authorizes claim usage. Ensures that claim deployment in Salesforce Marketing Cloud campaigns is restricted to approved media types.. Valid values are `packaging|print|digital|broadcast|social_media|all_media`',
    `organic_certification_flag` BOOLEAN COMMENT 'Indicates whether this substantiation supports an organic marketing claim requiring USDA National Organic Program certification. True requires a valid organic certificate to be linked in TraceGains.',
    `product_sku` STRING COMMENT 'Stock Keeping Unit identifier of the product(s) to which this substantiated claim applies. Links the substantiation to the specific SKU in SAP S/4HANA MM for packaging and labeling compliance.',
    `regulatory_authority` STRING COMMENT 'Primary regulatory body whose standards govern the substantiation requirements for this claim. Determines the applicable evidentiary threshold and filing obligations.. Valid values are `FDA|USDA|EFSA|FTC|EPA|Codex`',
    `regulatory_filing_number` STRING COMMENT 'Official filing or docket number assigned by a regulatory authority (FDA, USDA, EFSA) for any pre-authorization, notification, or petition associated with this claim substantiation. Null if no regulatory filing is required.',
    `renewal_due_date` DATE COMMENT 'Target date by which the re-substantiation process must be completed to avoid a compliance gap. Populated only when renewal_required is True. Supports proactive compliance management.',
    `renewal_required` BOOLEAN COMMENT 'Indicates whether this substantiation record requires periodic renewal before the expiry date. True triggers a re-substantiation workflow in Veeva Vault Quality Management.',
    `study_publication_date` DATE COMMENT 'Date on which the supporting scientific study or research was formally published or finalized. Used to assess currency and relevance of the evidentiary basis per FTC competent and reliable scientific evidence standards.',
    `study_reference_code` STRING COMMENT 'External identifier for the supporting study, such as a PubMed ID, ClinicalTrials.gov NCT number, or internal R&D study code. Enables traceability to the source evidence document.',
    `substantiation_notes` STRING COMMENT 'Free-text field for Regulatory Affairs or Legal teams to document conditions, limitations, or caveats associated with this substantiation record. Classified confidential as notes may contain privileged legal commentary.',
    `substantiation_number` STRING COMMENT 'Externally-known business identifier for this substantiation record, used in regulatory filings, legal correspondence, and Veeva Vault document management. Format: SUB-YYYY-NNNNNN.. Valid values are `^SUB-[0-9]{4}-[0-9]{6}$`',
    `substantiation_status` STRING COMMENT 'Current lifecycle state of the substantiation record within the approval workflow. Drives FTC and FDA compliance gating for consumer-facing claim activation. [ENUM-REF-CANDIDATE: draft|under_review|approved|rejected|expired|withdrawn — promote to reference product if additional states are needed]. Valid values are `draft|under_review|approved|rejected|expired|withdrawn`',
    `substantiation_type` STRING COMMENT 'Classification of the evidence type underpinning this substantiation record. Determines the evidentiary standard applied during legal and regulatory review per FTC competent and reliable scientific evidence requirements. [ENUM-REF-CANDIDATE: scientific_study|clinical_trial|meta_analysis|regulatory_filing|expert_opinion|consumer_survey — promote to reference product if additional types are needed]. Valid values are `scientific_study|clinical_trial|meta_analysis|regulatory_filing|expert_opinion|consumer_survey`',
    `supporting_study_title` STRING COMMENT 'Title of the primary scientific study, clinical trial, or research publication that provides the evidentiary basis for the claim. Stored as the human-readable reference for legal and regulatory review teams.',
    `third_party_verified` BOOLEAN COMMENT 'Indicates whether the substantiation evidence has been independently verified by a third-party organization (e.g., NSF International, GFSI-recognized body, or accredited laboratory). Enhances credibility and reduces FTC challenge risk.',
    `third_party_verifier_name` STRING COMMENT 'Name of the independent organization that verified the substantiation evidence. Populated only when third_party_verified is True. Examples include NSF International, SGS, Bureau Veritas, or a GFSI-recognized certification body.',
    `veeva_document_code` STRING COMMENT 'Document identifier in Veeva Vault Document Control for the substantiation package, including study reports, legal opinions, and regulatory filings. Enables direct navigation to the source document from the Silver Layer.',
    `version_number` STRING COMMENT 'Sequential version number of this substantiation record, incremented each time the substantiation is renewed or materially updated. Supports lifecycle tracking across multiple substantiation cycles for a single claim.',
    CONSTRAINT pk_claim_substantiation PRIMARY KEY(`claim_substantiation_id`)
) COMMENT 'Transactional record documenting the evidence and approval workflow supporting each marketing claim — links claim to supporting scientific studies, regulatory filings, legal review records, approval date, approving authority, and expiry of substantiation. Ensures FTC and FDA compliance for all consumer-facing claims. One claim may have multiple substantiation records over its lifecycle.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`marketing`.`influencer` (
    `influencer_id` BIGINT COMMENT 'Unique system-generated identifier for the influencer or brand ambassador record. Primary key for the influencer master data product.',
    `brand_id` BIGINT COMMENT 'Reference to the Food Beverage brand assigned to this influencer partnership (e.g., a specific snack, beverage, or dairy brand). Supports brand-level influencer program management and spend attribution.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign this influencer is currently associated with. Supports campaign-level performance tracking and budget allocation in Salesforce Marketing Cloud.',
    `agency_name` STRING COMMENT 'Name of the talent management agency or influencer marketing agency representing the influencer. Used for contract negotiations, payment routing, and campaign coordination.',
    `allergen_claim_approved` BOOLEAN COMMENT 'Indicates whether the influencer has been briefed and approved to make allergen-related claims about Food Beverage products in their content. Prevents unauthorized health or allergen claims that could violate FDA labeling regulations.',
    `audience_age_group` STRING COMMENT 'Dominant age demographic of the influencers audience based on platform analytics. Used to align influencer selection with target consumer segments for Food Beverage product lines.. Valid values are `13-17|18-24|25-34|35-44|45-54|55+`',
    `audience_authenticity_score` DECIMAL(18,2) COMMENT 'Score (0.00–100.00) estimating the proportion of genuine (non-bot) followers in the influencers audience, sourced from third-party fraud detection tools. Used to validate influencer quality and protect marketing ROI.',
    `audience_gender_split_pct` DECIMAL(18,2) COMMENT 'Percentage of the influencers audience that identifies as female, based on platform-reported demographics (0.00–100.00). Used for gender-targeted campaign planning and consumer segment alignment.',
    `avg_post_reach` BIGINT COMMENT 'Average number of unique accounts reached per post on the influencers primary platform, based on the most recent 90-day rolling period. Used for media value estimation and campaign ROI forecasting.',
    `brand_safety_score` DECIMAL(18,2) COMMENT 'Numeric score (0.00–100.00) assessing the influencers content alignment with Food Beverage brand values and safety standards, based on content audits and third-party brand safety tools. Used in influencer vetting and renewal decisions.',
    `content_category` STRING COMMENT 'Primary content niche or category the influencer creates content in. Used to match influencers to relevant Food Beverage product lines and target consumer segments. [ENUM-REF-CANDIDATE: food|lifestyle|fitness|parenting|beauty|travel|cooking|wellness|entertainment — promote to reference product]. Valid values are `food|lifestyle|fitness|parenting|beauty|travel`',
    `contract_end_date` DATE COMMENT 'Date on which the influencer partnership contract expires or is scheduled to terminate. Nullable for open-ended agreements. Triggers renewal workflow when approaching expiry.',
    `contract_start_date` DATE COMMENT 'Date on which the influencer partnership contract becomes effective and binding. Used for contract lifecycle management and campaign eligibility validation.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the influencers contractual relationship with Food Beverage. Drives eligibility for campaign activation, payment processing, and compliance checks.. Valid values are `active|pending|expired|terminated|on_hold`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the influencers primary country of residence and content creation market (e.g., USA, GBR, CAN). Used for regional campaign targeting and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the influencers contracted fee currency (e.g., USD, EUR, GBP). Required for multi-currency financial reporting and COGS allocation.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'Identifies the originating system or channel from which this influencer record was created or last updated (e.g., Salesforce Marketing Cloud, manual entry, agency portal, Nielsen/SPINS syndicated data). Supports data lineage and Silver layer provenance tracking.. Valid values are `salesforce_mc|manual|agency_portal|nielsen|spins`',
    `email` STRING COMMENT 'Primary business email address for the influencer or their management agency. Used for contract communications, campaign briefs, and payment notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `engagement_rate` DECIMAL(18,2) COMMENT 'Ratio of total engagements (likes, comments, shares, saves) to total followers expressed as a decimal (e.g., 0.0325 = 3.25%). Primary quality metric for evaluating influencer audience authenticity and content resonance.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the influencer is contractually prohibited from promoting competing food and beverage brands during the contract period. Critical for competitive brand protection and FTC compliance.',
    `exclusivity_scope` STRING COMMENT 'Defines the scope of the exclusivity restriction: category-level (e.g., no competing beverages), brand-level, specific product, platform-specific, or full exclusivity across all channels. Applicable only when exclusivity_flag is True.. Valid values are `category|brand|product|platform|full`',
    `fee_per_post` DECIMAL(18,2) COMMENT 'Agreed contractual fee in USD charged by the influencer per sponsored post or content deliverable. Used for campaign budget planning, Trade Promotion Management (TPM), and marketing spend tracking.',
    `follower_count` BIGINT COMMENT 'Total number of followers or subscribers on the influencers primary platform at the time of last data refresh. Key metric for reach estimation and tier classification.',
    `ftc_disclosure_compliant` BOOLEAN COMMENT 'Indicates whether the influencers published content consistently includes required FTC-mandated sponsorship disclosures (e.g., #ad, #sponsored). Critical for regulatory compliance and brand legal risk management.',
    `full_name` STRING COMMENT 'Legal full name of the influencer or brand ambassador as recorded in the contract. Used for legal, compliance, and payment processing purposes.',
    `handle` STRING COMMENT 'Primary social media username or handle of the influencer on their principal platform (e.g., @foodiequeen on Instagram). Used for content tracking, tagging, and campaign attribution.. Valid values are `^@?[A-Za-z0-9_.]{1,64}$`',
    `health_claim_approved` BOOLEAN COMMENT 'Indicates whether the influencer is authorized to make FDA-regulated health or nutrient content claims about Food Beverage products in sponsored content. Prevents unauthorized claims that could trigger FDA or FTC enforcement.',
    `last_post_date` DATE COMMENT 'Date of the most recent sponsored content post published by the influencer for a Food Beverage brand. Used to monitor influencer activity levels and identify dormant partnerships.',
    `onboarding_date` DATE COMMENT 'Date on which the influencer completed the onboarding process including contract signing, brand briefing, and compliance training. Marks the start of the active partnership lifecycle.',
    `past_brand_partnerships` STRING COMMENT 'Free-text or comma-delimited list of notable prior brand partnerships disclosed by the influencer during onboarding. Used for competitive conflict screening and partnership history context.',
    `phone` STRING COMMENT 'Primary contact phone number for the influencer or their talent management representative. Used for urgent campaign coordination and contract discussions.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `platform` STRING COMMENT 'Primary social media platform on which the influencer creates and publishes content for Food Beverage brand partnerships. Drives platform-specific content strategy and performance benchmarking.. Valid values are `Instagram|TikTok|YouTube|Pinterest|Facebook|X`',
    `posts_delivered` STRING COMMENT 'Cumulative count of sponsored content posts actually published by the influencer against the current contract. Used to track delivery progress and trigger payment milestones.',
    `preferred_content_format` STRING COMMENT 'The influencers primary content format used for brand collaborations (e.g., static post, reel, story, long-form video, live stream, blog). Used for creative brief development and platform-specific campaign planning.. Valid values are `static_post|reel|story|video|live|blog`',
    `primary_language` STRING COMMENT 'ISO 639-1/639-2 language code for the primary language in which the influencer creates content (e.g., en, es, fr). Used for audience targeting and localization strategy.. Valid values are `^[a-z]{2,3}$`',
    `product_gifting_flag` BOOLEAN COMMENT 'Indicates whether the influencer receives Food Beverage product samples or gifts as part of the partnership arrangement (in addition to or instead of monetary compensation). Relevant for FTC disclosure requirements and COGS tracking.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the influencer record was first created in the system. Supports audit trail, data lineage, and Silver layer ingestion tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the influencer record was most recently modified. Used for change data capture (CDC), Silver layer incremental processing, and audit compliance.',
    `renewal_eligible_flag` BOOLEAN COMMENT 'Indicates whether the influencer is eligible for contract renewal based on performance metrics, compliance history, and brand safety scores. Supports automated renewal workflow triggers.',
    `tier` STRING COMMENT 'Classification of the influencer by audience size tier: nano (<10K followers), micro (10K–100K), macro (100K–1M), mega (>1M). Determines fee benchmarks, campaign eligibility, and reach expectations.. Valid values are `nano|micro|macro|mega`',
    `total_contracted_posts` STRING COMMENT 'Total number of sponsored content posts or deliverables committed by the influencer under the current contract term. Used for campaign delivery tracking and contract compliance monitoring.',
    CONSTRAINT pk_influencer PRIMARY KEY(`influencer_id`)
) COMMENT 'Master record for influencer and brand ambassador partnerships — captures influencer name, handle, platform (Instagram, TikTok, YouTube, Pinterest), follower count, engagement rate, content category (food, lifestyle, fitness, parenting), tier (nano, micro, macro, mega), contract status, exclusivity flag, and assigned brand. Supports influencer marketing program management.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` (
    `influencer_engagement_id` BIGINT COMMENT 'Unique surrogate identifier for each influencer content activation record in the Silver Layer lakehouse. Primary key for this transactional entity. Role: TRANSACTION_HEADER.',
    `brand_id` BIGINT COMMENT 'Reference to the Food Beverage brand being promoted in this influencer activation. Enables brand-level aggregation of influencer spend, reach, and earned media value (EMV).',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign under which this influencer activation was executed. Links the engagement to campaign budget, objectives, and brand strategy.',
    `purchase_contract_id` BIGINT COMMENT 'Reference to the influencer partnership contract that governs the deliverables, payment terms, usage rights, and FTC compliance obligations for this engagement.',
    `influencer_id` BIGINT COMMENT 'Reference to the influencer (creator/partner) master record who produced this content activation. Links to the influencer profile including audience demographics and tier classification.',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_event. Business justification: Influencer activities are coordinated with promotion events; this FK supports influencer‑event performance reporting.',
    `activation_reference_number` STRING COMMENT 'Externally-known business identifier for this influencer content activation, used in agency briefs, purchase orders, and payment reconciliation. Format: INF-YYYY-NNNNNN.. Valid values are `^INF-[0-9]{4}-[0-9]{6}$`',
    `actual_deliverable_count` STRING COMMENT 'Number of content pieces actually published by the influencer for this engagement. Compared against contracted_deliverable_count to assess fulfillment and trigger payment milestones.',
    `agency_managed_flag` BOOLEAN COMMENT 'Indicates whether this influencer engagement was sourced and managed through a third-party influencer marketing agency rather than directly by the Food Beverage marketing team. Affects cost accounting and agency fee allocation.',
    `audience_size` BIGINT COMMENT 'Total follower or subscriber count of the influencer on the specified platform at the time of content publication. Captured as a point-in-time snapshot for performance normalization and tier validation.',
    `content_approval_date` DATE COMMENT 'Date on which the brand/legal team formally approved the influencer content for publication or confirmed post-publication compliance. Used for audit trail and payment milestone triggering.',
    `content_approval_status` STRING COMMENT 'Status of the brand and legal review of the influencer content prior to or post publication. Ensures brand guidelines, nutritional claim accuracy, and FTC compliance are verified before payment release.. Valid values are `pending|approved|rejected|revision_requested`',
    `content_caption` STRING COMMENT 'The text caption or description accompanying the influencer post. Captured for FTC disclosure verification, brand claim compliance review, and consumer sentiment analysis.',
    `content_rights_expiry_date` DATE COMMENT 'Date on which the brands licensed rights to repurpose or amplify the influencer-created content expire. Critical for paid media amplification planning and legal compliance with content usage agreements.',
    `content_type` STRING COMMENT 'Format classification of the influencer content deliverable (e.g., story, reel, static post, long-form video). Determines performance benchmarks, content rights, and contracted deliverable matching.. Valid values are `story|reel|post|video|live|blog`',
    `content_url` STRING COMMENT 'Direct URL to the published influencer content on the social media platform. Used for compliance review, content archiving, FTC disclosure verification, and performance data pull.. Valid values are `^https?://.+`',
    `contracted_deliverable_count` STRING COMMENT 'Total number of content pieces (posts, stories, reels, videos) contractually obligated for this influencer engagement. Used to track fulfillment rate against contract terms.',
    `contracted_fee` DECIMAL(18,2) COMMENT 'Gross monetary fee agreed in the influencer contract for this engagement, before any deductions or bonuses. Used for budget tracking, COGS allocation, and payment milestone management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this influencer engagement record was first created in the Silver Layer lakehouse. Audit trail field for data lineage and record provenance tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this engagement record (contracted_fee, performance_bonus, earned_media_value). Supports multi-currency global influencer programs.. Valid values are `^[A-Z]{3}$`',
    `earned_media_value` DECIMAL(18,2) COMMENT 'Estimated monetary value of the organic reach and engagement generated by the influencer content, calculated using platform-specific CPM/CPE benchmarks. Key metric for Return on Investment (ROI) reporting and brand equity tracking. Expressed in the contract currency.',
    `engagement_rate` DECIMAL(18,2) COMMENT 'Ratio of total engagements to total impressions or reach, expressed as a decimal (e.g., 0.0425 = 4.25%). Key performance indicator for content resonance and influencer audience quality benchmarking.',
    `engagement_status` STRING COMMENT 'Current lifecycle state of the influencer content activation. Tracks workflow from initial brief through contract execution, content go-live, completion, and payment closure. [ENUM-REF-CANDIDATE: draft|contracted|live|completed|cancelled|disputed — promote to reference product if additional states are needed]. Valid values are `draft|contracted|live|completed|cancelled|disputed`',
    `engagements` BIGINT COMMENT 'Total count of all user interactions with the influencer content including likes, comments, shares, saves, and reactions. Core performance metric for consumer engagement analytics.',
    `exclusivity_end_date` DATE COMMENT 'Date through which the influencer is contractually prohibited from promoting competing food and beverage brands or products. Null if no exclusivity clause is in effect. Used for competitive conflict monitoring.',
    `ftc_disclosure_status` STRING COMMENT 'Compliance status indicating whether the influencer post includes the required FTC-mandated paid partnership or #ad disclosure. Critical for regulatory compliance and brand legal risk management.. Valid values are `compliant|non_compliant|pending_review|waived`',
    `ftc_disclosure_tag` STRING COMMENT 'The specific disclosure label used in the post (e.g., #ad, #sponsored, #paidpartnership, platform-native Paid Partnership label). Captured verbatim for FTC audit evidence.',
    `hashtags` STRING COMMENT 'Comma-separated list of hashtags included in the influencer post. Used to verify required campaign hashtags (e.g., #ad, #sponsored) and to track branded hashtag performance.',
    `impressions` BIGINT COMMENT 'Total number of times the influencer content was displayed to users on the platform, including repeat views by the same user. Primary reach metric for awareness-stage campaign measurement.',
    `link_clicks` BIGINT COMMENT 'Number of times users clicked on a trackable link (e.g., swipe-up, bio link, UTM-tagged URL) within the influencer content. Measures direct traffic and conversion intent driven by the activation.',
    `paid_amplification_flag` BOOLEAN COMMENT 'Indicates whether the organic influencer content was additionally boosted through paid media spend (e.g., Instagram Branded Content Ads, TikTok Spark Ads). Affects total media investment reporting and FTC disclosure requirements.',
    `payment_date` DATE COMMENT 'Date on which payment was issued to the influencer for this engagement. Populated upon payment confirmation from Oracle Cloud ERP. Null if payment has not yet been processed.',
    `payment_milestone_status` STRING COMMENT 'Current status of the payment milestone associated with this influencer engagement. Tracks the accounts payable workflow from deliverable approval through payment execution in Oracle Cloud ERP.. Valid values are `pending|approved|paid|on_hold|disputed`',
    `performance_bonus` DECIMAL(18,2) COMMENT 'Additional monetary bonus payable to the influencer upon achieving contractually defined performance thresholds (e.g., impressions floor, engagement rate target). Nullable if no bonus clause exists.',
    `platform` STRING COMMENT 'The social media or digital platform on which the influencer content was published (e.g., Instagram, TikTok, YouTube). Drives platform-specific performance benchmarking and media mix analysis.. Valid values are `Instagram|TikTok|YouTube|Facebook|Pinterest|X`',
    `post_date` DATE COMMENT 'The calendar date on which the influencer published the content to their social media platform. This is the principal real-world business event date for this activation record.',
    `post_timestamp` TIMESTAMP COMMENT 'Precise date and time (with timezone offset) when the influencer content was published on the platform. Used for time-of-day analytics, algorithm optimization, and audit trail.',
    `product_claim_type` STRING COMMENT 'Classification of any product-related marketing claim made in the influencer content (e.g., health claim, nutrient content claim, structure/function claim). Critical for FDA and FTC regulatory compliance review of food and beverage advertising.. Valid values are `health_claim|nutrient_content|structure_function|no_claim|taste_preference`',
    `reach` BIGINT COMMENT 'Number of unique users who were exposed to the influencer content at least once. Distinct from impressions; used to measure unduplicated audience size for brand awareness reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this influencer engagement record in the Silver Layer lakehouse. Used for incremental data processing, change detection, and audit trail maintenance.',
    `utm_campaign_code` STRING COMMENT 'UTM campaign parameter appended to trackable links in the influencer content for attribution in web analytics platforms. Enables direct traffic, conversion, and Return on Investment (ROI) measurement from influencer-driven clicks.',
    `video_views` BIGINT COMMENT 'Number of times the video content was viewed, applicable for video, reel, and story content types. Platform-specific view thresholds apply (e.g., 3-second view on Facebook/Instagram, 30-second on YouTube).',
    CONSTRAINT pk_influencer_engagement PRIMARY KEY(`influencer_engagement_id`)
) COMMENT 'Transactional record of individual influencer content activations — captures post date, platform, content type (story, reel, post, video), campaign linkage, contracted deliverables, actual deliverables, impressions, engagements, reach, earned media value (EMV), compliance status (FTC #ad disclosure), and payment milestone status.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`marketing`.`digital_asset` (
    `digital_asset_id` BIGINT COMMENT 'Unique system-generated surrogate key identifying each digital asset master record in the Digital Asset Management (DAM) system. Primary key for the digital_asset product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Asset approval must be signed off by a marketing employee; FK enables audit of asset approvals for regulatory compliance.',
    `brand_id` BIGINT COMMENT 'Reference to the brand master record that this digital asset is associated with. Enables brand equity tracking, brand guideline compliance enforcement, and brand-level asset portfolio reporting.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign master record that this digital asset supports. Links creative assets to campaign performance analytics, advertising spend attribution, and Trade Promotion Management (TPM) reporting.',
    `parent_asset_digital_asset_id` BIGINT COMMENT 'Reference to the parent digital asset record from which this asset was derived or adapted (e.g., a localized variant references its master asset). Enables asset lineage tracking and derivative management within the DAM hierarchy.',
    `promotion_line_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_line. Business justification: Digital assets (e.g., shelf‑talkers) are assigned to specific promotion lines for asset‑to‑promotion tracking.',
    `sku_id` BIGINT COMMENT 'Stock Keeping Unit (SKU) code of the product this digital asset depicts or supports (e.g., packaging artwork, product photography). Links the asset to the product master for PLM and omnichannel content syndication. May be null for brand-level or campaign-level assets not tied to a specific SKU.',
    `allergen_claim_present` BOOLEAN COMMENT 'Indicates whether this digital asset (e.g., packaging artwork, nutritional panel, label) contains allergen declarations or claims. Triggers mandatory regulatory review workflow under FDA FSMA, USDA, and EFSA allergen labeling requirements before approval.',
    `approval_status` STRING COMMENT 'Current lifecycle state of the digital asset within the creative approval workflow. Controls whether the asset is eligible for deployment across marketing channels. approved assets are cleared for use; expired assets must not be deployed.. Valid values are `draft|in_review|approved|rejected|archived|expired`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this digital asset received final approval for deployment. Provides regulatory audit trail for FDA, FTC, and EFSA compliance. Distinct from created_timestamp and last_modified_timestamp as it marks the specific approval lifecycle event.',
    `asset_description` STRING COMMENT 'Detailed free-text description of the digital assets content, purpose, and intended use (e.g., Hero banner for Q3 Summer Refresh campaign featuring the new Oat Milk Smoothie SKU, designed for homepage placement and social media). Supports asset discovery and briefing documentation.',
    `asset_name` STRING COMMENT 'Human-readable title or name of the digital asset as defined by the marketing or creative team (e.g., Summer Refresh Campaign Hero Banner, Oat Milk Packaging Front Panel v3). Used for search and discovery in the DAM system.',
    `asset_subtype` STRING COMMENT 'Granular classification within the asset type (e.g., hero_banner, product_photography, tv_spot, radio_jingle, shelf_talker, nutritional_panel_artwork, copy_deck). Supports detailed taxonomy and omnichannel content routing. [ENUM-REF-CANDIDATE: hero_banner|product_photography|tv_spot|radio_jingle|shelf_talker|nutritional_panel_artwork|copy_deck|social_post|email_template|print_ad — promote to reference product]',
    `asset_type` STRING COMMENT 'High-level classification of the digital asset by media type. Drives workflow routing, storage tier, and rendering requirements. [ENUM-REF-CANDIDATE: image|video|audio|document|template|brand_guideline|copy_deck|packaging_artwork|infographic|presentation — promote to reference product]. Valid values are `image|video|audio|document|template|brand_guideline`',
    `channel` STRING COMMENT 'Primary marketing channel for which this digital asset is intended for deployment (e.g., digital, print, broadcast, social_media, ecommerce, in_store, out_of_home). Drives channel-specific compliance checks and content routing in Salesforce Marketing Cloud. [ENUM-REF-CANDIDATE: digital|print|broadcast|social_media|ecommerce|in_store|out_of_home|direct_mail|foodservice — promote to reference product]',
    `clean_label_compliant` BOOLEAN COMMENT 'Indicates whether this digital asset (particularly packaging artwork and labeling) meets the brands clean label standards — free from artificial colors, flavors, preservatives, and non-consumer-friendly ingredients. Supports consumer transparency and brand positioning.',
    `color_profile` STRING COMMENT 'Color space or color profile of the digital asset (e.g., sRGB for digital/web, CMYK for print, Pantone for brand color-matched packaging). Critical for print production quality, packaging artwork compliance, and brand color consistency.. Valid values are `sRGB|CMYK|Adobe_RGB|Pantone|Grayscale`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the primary market or country for which this digital asset is approved for use (e.g., USA, CAN, GBR, DEU). Supports geo-specific regulatory compliance (FDA, EFSA, USDA, Codex Alimentarius) and rights management.. Valid values are `^[A-Z]{3}$`',
    `created_by_user` STRING COMMENT 'Username or employee identifier of the individual who created this digital asset record in the DAM or marketing system. Supports audit trail requirements and creative ownership tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this digital asset record was first created in the system. Provides audit trail for asset lifecycle management, version history, and regulatory compliance documentation.',
    `dam_asset_code` STRING COMMENT 'Externally-known unique business identifier assigned by the Digital Asset Management (DAM) system (e.g., Bynder, Widen, Canto) to this asset. Used for cross-system referencing and asset retrieval across omnichannel platforms.. Valid values are `^DAM-[A-Z0-9]{4,20}$`',
    `dam_system_reference` STRING COMMENT 'External reference identifier or URL path within the source Digital Asset Management (DAM) system (e.g., Bynder asset URL, Widen asset ID, Canto folder path). Enables direct deep-linking to the asset in the originating DAM platform for retrieval and governance.',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Playback duration of the digital asset in seconds. Applicable to video and audio asset types (e.g., TV spots, radio jingles, digital video ads). Used for media buying, broadcast compliance, and platform upload validation.',
    `effective_end_date` DATE COMMENT 'Date after which this digital asset is no longer authorized for active deployment. Supports campaign lifecycle management, seasonal content rotation, and regulatory label change compliance (e.g., FDA nutritional panel updates).',
    `effective_start_date` DATE COMMENT 'Date from which this digital asset is approved and authorized for active deployment across marketing channels. Aligns with campaign launch dates, seasonal promotions, and product launch timelines.',
    `file_format` STRING COMMENT 'Technical file format or extension of the digital asset (e.g., JPEG, PNG, MP4, PDF, AI, PSD, EPS, TIFF, MOV, WAV). Determines compatibility with downstream publishing and rendering systems.. Valid values are `^[A-Z0-9]{2,10}$`',
    `file_size_kb` DECIMAL(18,2) COMMENT 'Physical storage size of the digital asset file expressed in kilobytes (KB). Used for storage capacity planning, CDN bandwidth management, and upload/download performance optimization.',
    `height_px` STRING COMMENT 'Vertical dimension of the digital asset in pixels. Used alongside width_px for aspect ratio validation and channel-specific dimension compliance (e.g., social media, e-commerce product imagery, digital shelf).',
    `influencer_content` BOOLEAN COMMENT 'Indicates whether this digital asset was created by or in partnership with an influencer or brand ambassador. Triggers mandatory FTC endorsement disclosure requirements (e.g., #ad, #sponsored) and influencer contract rights verification before deployment.',
    `is_master_asset` BOOLEAN COMMENT 'Indicates whether this record represents the master/original version of the asset (True) or a derivative/localized variant (False). Master assets serve as the source of truth for all downstream adaptations and channel-specific renditions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this digital asset record was most recently updated. Used for change tracking, cache invalidation in CDN delivery, and audit compliance. Distinct from approved_timestamp which marks the approval event.',
    `license_expiry_date` DATE COMMENT 'Date on which the usage license or rights agreement for this digital asset expires. Assets must be retired from active deployment on or before this date to avoid IP infringement. Triggers automated expiry workflows in the DAM system.',
    `locale_code` STRING COMMENT 'IETF BCP 47 locale code indicating the language and regional market for which this asset is localized (e.g., en_US, fr_CA, es_MX). Supports multilingual content management and regulatory labeling compliance across jurisdictions (FDA, EFSA, USDA).. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `nutrition_claim_present` BOOLEAN COMMENT 'Indicates whether this digital asset contains nutritional or health claims (e.g., Low Fat, High Protein, No Added Sugar). Triggers FTC and FDA regulatory compliance review to ensure claims meet substantiation requirements under 21 CFR Part 101.',
    `regulatory_review_status` STRING COMMENT 'Status of the regulatory compliance review for this digital asset, particularly for packaging artwork, nutritional panels, and health/allergen claims. Ensures assets meet FDA, USDA, EFSA, FTC, and Codex Alimentarius requirements before market deployment.. Valid values are `not_required|pending|cleared|rejected`',
    `resolution_dpi` STRING COMMENT 'Image or print resolution of the asset expressed in dots per inch (DPI). Critical for determining suitability for print vs. digital use. Standard print requires 300 DPI; digital display typically uses 72–96 DPI. Applies to image and document asset types.',
    `rights_holder` STRING COMMENT 'Name of the individual, agency, or organization that holds the intellectual property rights to this digital asset (e.g., photography agency, influencer, creative studio). Required for rights clearance, licensing compliance, and FTC disclosure obligations.',
    `rights_type` STRING COMMENT 'Classification of the intellectual property rights and usage licensing model governing this digital asset (e.g., royalty_free, rights_managed, creative_commons, proprietary, licensed). Determines permissible usage scope and commercial deployment eligibility.. Valid values are `royalty_free|rights_managed|creative_commons|proprietary|licensed`',
    `storage_location_url` STRING COMMENT 'Fully qualified URL or cloud storage path where the digital asset file is physically stored (e.g., Azure Blob Storage URI, AWS S3 path, CDN endpoint). Used for asset retrieval, CDN delivery, and omnichannel content syndication.',
    `tags_keywords` STRING COMMENT 'Comma-separated list of searchable tags and keywords associated with this digital asset (e.g., summer,refresh,oat-milk,dairy-free,snack,packaging). Enables full-text search, content discovery, and AI-driven asset recommendation within the DAM system and Salesforce Marketing Cloud.',
    `thumbnail_url` STRING COMMENT 'URL of the low-resolution preview or thumbnail image for this digital asset. Used for visual browsing and search results in the DAM system, e-commerce product pages, and marketing portals without requiring full asset download.',
    `usage_restrictions` STRING COMMENT 'Free-text description of any specific restrictions on how this digital asset may be used (e.g., Not for use in alcoholic beverage promotions, Digital use only — no print, North America markets only, Influencer exclusivity period ends 2025-12-31). Supports FTC compliance and brand governance.',
    `version_number` STRING COMMENT 'Semantic version identifier of the digital asset (e.g., v1.0, v2.3, v3.0.1). Tracks creative iterations and revision history. Ensures the correct approved version is deployed across channels and prevents use of superseded artwork.. Valid values are `^vd+.d+(.d+)?$`',
    `width_px` STRING COMMENT 'Horizontal dimension of the digital asset in pixels. Used for responsive design validation, planogram compliance, and channel-specific dimension requirements (e.g., social media platform specs, retail display specs).',
    CONSTRAINT pk_digital_asset PRIMARY KEY(`digital_asset_id`)
) COMMENT 'Master record for all marketing digital assets — creative files, packaging artwork, photography, video, copy decks, and brand guidelines. Captures asset name, type, format, resolution, brand association, campaign association, version number, approval status, rights/usage restrictions, expiry date, and DAM (Digital Asset Management) system reference. Supports omnichannel content deployment.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`marketing`.`shopper_program` (
    `shopper_program_id` BIGINT COMMENT 'Unique surrogate identifier for the shopper marketing program record in the Silver Layer lakehouse. Primary key. Entity role: TRANSACTION_HEADER — a discrete, lifecycle-managed shopper marketing activation event with budget, execution, and measurement attributes.',
    `agency_id` BIGINT COMMENT 'Reference to the external shopper marketing agency or creative agency engaged to develop and execute program materials (displays, FSIs, digital assets). Links to the vendor/supplier master in SAP S/4HANA MM or Oracle Cloud Procurement.',
    `brand_id` BIGINT COMMENT 'Reference to the brand featured in the shopper marketing program (e.g., a specific snack or beverage brand). Links to the brand master in the Product domain. Supports brand equity tracking and cross-brand spend analysis.',
    `employee_id` BIGINT COMMENT 'Reference to the internal employee responsible for planning and executing this shopper marketing program. Links to the workforce/employee master in Workday HCM. Used for accountability tracking and program ownership reporting.',
    `hierarchy_id` BIGINT COMMENT 'Reference to the product category (e.g., salty snacks, carbonated beverages, dairy) targeted by the shopper program. Used for category captain reporting, planogram alignment, and Nielsen/IRI syndicated data linkage.',
    `promotion_event_id` BIGINT COMMENT 'Reference to the parent Trade Promotion Management (TPM) event or promotion plan that this shopper program is aligned to. Enables TPO (Trade Promotion Optimization) linkage and integrated spend reporting across trade and shopper budgets.',
    `account_id` BIGINT COMMENT 'Reference to the retailer account (e.g., Walmart, Kroger, Target) where the shopper program is executed. Links to the customer/account master in Salesforce CRM Sales Cloud or SAP S/4HANA SD customer master. Serves as the PARTY_REFERENCE for this transaction.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Shopper programs target individual SKUs for promotions; the SKU FK supports the Program Effectiveness dashboard.',
    `actual_spend_usd` DECIMAL(18,2) COMMENT 'Actual dollars spent against the shopper marketing program budget as of the most recent financial close. Compared against total_budget_usd to compute budget utilization and variance. Currency: USD (ISO 4217).',
    `acv_weighted_pct` DECIMAL(18,2) COMMENT 'ACV (All Commodity Volume) weighted distribution percentage representing the share of total retail sales volume covered by the stores participating in this shopper program. A standard Nielsen/IRI distribution metric used to assess program reach quality.',
    `baseline_sales_usd` DECIMAL(18,2) COMMENT 'Estimated dollar sales volume that would have occurred without the shopper marketing program, derived from Nielsen/IRI syndicated data or internal POS baselines. Used as the denominator for incremental lift calculation. Currency: USD (ISO 4217).',
    `coupon_redemption_rate` DECIMAL(18,2) COMMENT 'Ratio of coupons or digital offers redeemed to total coupons distributed or issued for FSI (Free Standing Insert) or digital coupon program types. Expressed as a decimal (e.g., 0.0250 = 2.50%). Applicable when program_type is fsi or digital_coupon.',
    `coupons_distributed` BIGINT COMMENT 'Total number of coupons or digital offers distributed to shoppers as part of an FSI or digital coupon program. Used with coupons_redeemed to compute coupon_redemption_rate. Applicable when program_type is fsi or digital_coupon.',
    `coupons_redeemed` BIGINT COMMENT 'Total number of coupons or digital offers actually redeemed by shoppers during the program period. Used with coupons_distributed to compute coupon_redemption_rate. Sourced from retailer loyalty or clearinghouse data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shopper program record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Serves as the RECORD_AUDIT_CREATED field for this transaction header. Sourced from Salesforce Marketing Cloud or SAP S/4HANA.',
    `display_compliance_rate` DECIMAL(18,2) COMMENT 'Percentage of planned retail store locations where the display or program tactic was confirmed as correctly executed (actual_store_count / planned_store_count × 100). A key shopper marketing execution KPI. Expressed as a percentage (0.00–100.00).',
    `dsd_program_flag` BOOLEAN COMMENT 'Indicates whether this shopper program is executed through a DSD (Direct Store Delivery) distribution model, where the manufacturers sales representative directly manages in-store execution. DSD programs have distinct compliance and display audit workflows.',
    `end_date` DATE COMMENT 'The calendar date on which the shopper marketing program concludes at retail. Defines the measurement window close for post-event evaluation (PEE). Nullable for open-ended programs. Represents the EFFECTIVE_UNTIL for this program.',
    `facing_count` STRING COMMENT 'Number of product facings (shelf-facing units visible to the shopper) allocated to the brand or SKU as part of the shopper program planogram agreement. A standard planogram metric in Food and Beverage retail. Applicable for endcap and in-store display program types.',
    `fda_label_compliant` BOOLEAN COMMENT 'Indicates whether all product labeling and nutritional claims featured in the shopper program materials comply with FDA (Food and Drug Administration) labeling regulations (21 CFR). Critical for programs featuring health, nutrient content, or structure/function claims.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter number) within the fiscal year in which the shopper program is primarily executed and budgeted. Used for period-level spend tracking and demand planning alignment with SAP IBP.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the shopper marketing program budget is allocated and financial results are reported. Used for annual shopper marketing spend planning and EBITDA impact reporting. Aligns with the companys fiscal calendar in SAP S/4HANA CO.',
    `ftc_claims_reviewed` BOOLEAN COMMENT 'Indicates whether all marketing claims included in the shopper program materials (e.g., health claims, comparative claims, promotional offers) have been reviewed for compliance with FTC (Federal Trade Commission) advertising guidelines. True = reviewed and approved; False = pending review.',
    `incremental_lift_pct` DECIMAL(18,2) COMMENT 'Percentage increase in sales attributable to the shopper marketing program above the baseline, calculated as ((promoted_sales_usd - baseline_sales_usd) / baseline_sales_usd) × 100. Primary effectiveness KPI for post-event evaluation (PEE). Expressed as a percentage.',
    `planned_duration_days` STRING COMMENT 'The planned number of calendar days the shopper program is scheduled to run at retail. Used for display compliance tracking, retailer SLA management, and program efficiency benchmarking.',
    `post_event_eval_status` STRING COMMENT 'Status of the post-event evaluation (PEE) process for this shopper program. PEE captures incremental lift, ROI, display compliance, and learnings to inform future program investment. Drives TPO feedback loop in JDA/Blue Yonder.. Valid values are `not_started|in_progress|completed|waived`',
    `private_label_flag` BOOLEAN COMMENT 'Indicates whether this shopper program supports a private label product line rather than a branded product. Private label programs have distinct compliance, margin, and measurement considerations in Food and Beverage retail.',
    `program_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the shopper marketing program, used in Trade Promotion Management (TPM) systems, retailer communications, and cross-functional reporting. Sourced from Salesforce Marketing Cloud or SAP S/4HANA SD module. Format: SHP- followed by 4–12 alphanumeric characters.. Valid values are `^SHP-[A-Z0-9]{4,12}$`',
    `program_name` STRING COMMENT 'Human-readable name of the shopper marketing program (e.g., Summer Snack Endcap Q3 2024 — Walmart). Used in planning documents, retailer presentations, and effectiveness reporting.',
    `program_objective` STRING COMMENT 'Primary business objective driving the shopper marketing program. Determines KPI selection for post-event evaluation and TPO alignment. [ENUM-REF-CANDIDATE: trial_generation|repeat_purchase|basket_building|brand_awareness|competitive_defense|new_item_launch|seasonal_activation — promote to reference product]',
    `program_status` STRING COMMENT 'Current lifecycle state of the shopper marketing program. Drives workflow routing in TPM and reporting inclusion logic. Values: draft (initial creation), planned (approved, not yet live), active (currently executing at retail), completed (post-event evaluation phase), cancelled (terminated before execution).. Valid values are `draft|planned|active|completed|cancelled`',
    `program_type` STRING COMMENT 'Classification of the shopper marketing tactic executed at retail. Determines measurement methodology and reporting template. [ENUM-REF-CANDIDATE: endcap|fsi|digital_coupon|loyalty_tie_in|in_store_display|retailer_activation|sampling|demo — promote to reference product]',
    `promoted_sales_usd` DECIMAL(18,2) COMMENT 'Actual dollar sales volume recorded during the shopper program execution period, sourced from POS data or Nielsen/IRI syndicated data. Used alongside baseline_sales_usd to compute incremental lift. Currency: USD (ISO 4217).',
    `retailer_channel` STRING COMMENT 'The retail trade channel in which the shopper program is executed. Used for channel-specific effectiveness benchmarking and ACV (All Commodity Volume) weighting in lift analysis. [ENUM-REF-CANDIDATE: mass|grocery|club|drug|convenience|dollar|natural|online|foodservice — promote to reference product]',
    `roi_pct` DECIMAL(18,2) COMMENT 'Return on Investment (ROI) for the shopper marketing program, expressed as a percentage. Calculated as ((incremental gross profit - total program spend) / total program spend) × 100. Core metric for TPO alignment and future program investment decisions.',
    `sku_scope` STRING COMMENT 'Defines the breadth of SKU (Stock Keeping Unit) coverage included in the shopper program. Indicates whether the program targets a single SKU, multiple SKUs, the full brand portfolio, or the entire category. Detailed SKU-level linkage is managed in the shopper_program_sku association table.. Valid values are `single_sku|multi_sku|full_brand|category_wide`',
    `slotting_fee_usd` DECIMAL(18,2) COMMENT 'Dollar amount paid to the retailer as a slotting fee for securing shelf placement, endcap, or display space as part of this shopper program. A standard cost component in Food and Beverage retail trade. Currency: USD (ISO 4217).',
    `start_date` DATE COMMENT 'The calendar date on which the shopper marketing program begins execution at retail. Used for FEFO-aligned inventory planning, display compliance scheduling, and lift measurement window definition. Represents the EFFECTIVE_FROM for this program.',
    `store_count_actual` STRING COMMENT 'Number of retail store locations where the shopper program was confirmed to have executed, as verified through display compliance audits or retailer POS data. Compared against store_count_planned to compute display compliance rate.',
    `store_count_planned` STRING COMMENT 'Number of retail store locations where the shopper program is planned to execute. Used for display compliance rate calculation (actual vs. planned stores) and TDP (Total Distribution Points) impact assessment.',
    `syndicated_data_source` STRING COMMENT 'Identifies the primary syndicated or POS data source used to measure program lift and effectiveness. Determines the measurement methodology and data quality confidence level for reported KPIs.. Valid values are `nielsen|iri|spins|pos_direct|panel|none`',
    `tdp_impact` STRING COMMENT 'Change in TDP (Total Distribution Points) attributable to the shopper program, measured as the net gain or loss in distribution points across participating retailers. TDP = number of items × ACV weighted distribution. Sourced from Nielsen/IRI syndicated data.',
    `total_budget_usd` DECIMAL(18,2) COMMENT 'Total approved budget allocated to the shopper marketing program in US dollars, inclusive of all tactic costs (display, FSI, digital, sampling). Used for spend tracking, ROI calculation, and annual shopper marketing budget management. Currency: USD (ISO 4217).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the shopper program record was most recently modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Serves as the RECORD_AUDIT_UPDATED field for this transaction header. Used for Silver Layer incremental load processing in Databricks.',
    CONSTRAINT pk_shopper_program PRIMARY KEY(`shopper_program_id`)
) COMMENT 'Master record for shopper marketing programs executed at retail — in-store displays, FSIs, digital coupons, loyalty tie-ins, endcap programs, and retailer-specific activations. Captures program name, retailer account, type, brand, SKU scope, dates, budget, objectives, and measured results (incremental lift, baseline vs. promoted sales, redemption rate, display compliance, ROI, post-event evaluation). Linked to POS and syndicated data for lift measurement. Supports shopper marketing planning, execution, effectiveness reporting, and TPO alignment.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` (
    `consumer_promotion_id` BIGINT COMMENT 'Unique system-generated identifier for the consumer-facing promotion record. Primary key for the consumer_promotion data product in the marketing domain.',
    `account_id` BIGINT COMMENT 'Reference to the retailer account when retailer_exclusivity is True. Identifies the specific retail partner for exclusive promotions. Used for retailer performance reporting and trade fund reconciliation.',
    `brand_id` BIGINT COMMENT 'Reference to the brand under which this consumer promotion is executed. Links the promotion to brand equity tracking, marketing spend allocation, and Nielsen/IRI brand performance reporting.',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign under which this consumer promotion is executed. Links to Salesforce Marketing Cloud campaign records for budget roll-up and performance attribution.',
    `employee_id` BIGINT COMMENT 'Reference to the internal employee or team responsible for managing this consumer promotion. Serves as the PARTY_REFERENCE for accountability and workflow routing in Salesforce Marketing Cloud and Workday HCM.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Consumer promotion targets a SKU; FK ensures accurate promotion attribution.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Promotion Allocation Process: ties each consumer promotion to the exact inventory stock position reserved for the promotion, supporting allocation, fulfillment, and post‑promotion inventory reconcilia',
    `actual_redemption_count` STRING COMMENT 'Running total of confirmed redemptions processed against this promotion to date. Updated via clearinghouse feeds or digital redemption platform. Used for budget burn tracking and fraud monitoring.',
    `actual_redemption_value` DECIMAL(18,2) COMMENT 'Total monetary value of all confirmed redemptions processed to date in currency_code. Represents the actual COGS impact of the promotion. Used for budget reconciliation and ROI calculation inputs.',
    `approval_status` STRING COMMENT 'Current state of the internal approval workflow for this promotion, covering marketing, legal, and finance sign-off. Must reach approved before promotion_status can transition to scheduled or active.. Valid values are `pending|approved|rejected|revision_required`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the promotion received final internal approval (marketing, legal, and finance). Represents a key lifecycle milestone. Null if not yet approved.',
    `clearinghouse_code` STRING COMMENT 'Identifier assigned by the coupon clearinghouse (e.g., Inmar, Quotient) for processing paper and digital coupon redemptions. Required for settlement and fraud detection. Null for non-coupon promotion types.. Valid values are `^[A-Z0-9]{4,20}$`',
    `cost_center_code` STRING COMMENT 'SAP CO cost center code to which the promotion budget and redemption costs are charged. Enables marketing spend allocation by brand, category, or business unit for EBITDA reporting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this consumer promotion record was first created in the system. Serves as RECORD_AUDIT_CREATED. Populated automatically on insert and never updated.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the offer value and budget amounts (e.g., USD, EUR, GBP, CAD). Required for multi-market promotions. Part of the MONETARY_TRIPLET.. Valid values are `^[A-Z]{3}$`',
    `distribution_channel` STRING COMMENT 'The channel through which the promotion offer is distributed to consumers. Distinct from redemption_mechanism (how it is redeemed). Used for marketing attribution and channel ROI analysis. [ENUM-REF-CANDIDATE: email|direct_mail|social_media|in_store|mobile_app|website|sunday_insert — promote to reference product]',
    `eligible_sku_scope` STRING COMMENT 'Defines the breadth of SKU eligibility for the promotion. specific_skus requires a linked SKU eligibility list. product_line applies to all SKUs within a product line. Used in redemption validation and planogram alignment.. Valid values are `all_skus|specific_skus|product_line|category`',
    `end_date` DATE COMMENT 'Calendar date on which the consumer promotion expires and is no longer eligible for redemption. Serves as EFFECTIVE_UNTIL for the promotion lifecycle. Null indicates open-ended promotions (rare; requires legal review).',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether this promotion has been flagged for suspected fraudulent redemption activity based on clearinghouse anomaly detection or internal audit rules. True triggers investigation workflow.',
    `fraud_review_status` STRING COMMENT 'Current status of the fraud investigation for this promotion. Only relevant when fraud_flag is True. Drives escalation and financial adjustment workflows.. Valid values are `not_reviewed|under_review|cleared|confirmed_fraud`',
    `ftc_compliant` BOOLEAN COMMENT 'Indicates whether this promotion has been reviewed and confirmed compliant with FTC guidelines on advertising, marketing claims, and promotional offers. Must be True before promotion_status can transition to active.',
    `internal_notes` STRING COMMENT 'Free-text field for internal marketing and finance team notes regarding promotion strategy, retailer negotiations, or execution considerations. Not consumer-facing. Confidential business information.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this consumer promotion record was most recently modified. Serves as RECORD_AUDIT_UPDATED. Updated on every write operation. Used for incremental data pipeline processing in Databricks Silver layer.',
    `legal_terms_version` STRING COMMENT 'Version identifier of the legal terms and conditions document governing this promotion (e.g., v1.0, v2.3). Links to the approved legal document in Veeva Vault. Required for FTC compliance and consumer dispute resolution.. Valid values are `^v[0-9]+.[0-9]+$`',
    `max_redemptions` STRING COMMENT 'Maximum total number of times this promotion may be redeemed across all consumers. Controls promotion liability exposure. Null indicates no cap. When reached, promotion_status transitions to expired.',
    `max_redemptions_per_consumer` STRING COMMENT 'Maximum number of times a single consumer household may redeem this promotion. Enforced at POS or digital redemption platform to prevent abuse. Null indicates no per-consumer limit.',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum consumer purchase value (in currency_code) required to qualify for the promotion offer. Zero or null indicates no minimum purchase threshold. Used in redemption validation logic.',
    `minimum_purchase_quantity` STRING COMMENT 'Minimum number of qualifying product units a consumer must purchase to redeem the promotion (e.g., buy 2 to get $1 off). Null or zero indicates no quantity threshold. Critical for BOGO and multi-buy mechanics.',
    `offer_description` STRING COMMENT 'Consumer-facing description of the promotion offer as it appears on the coupon, in-app notification, or marketing material (e.g., Save $1.00 on any two bags of Brand X Chips). Used for content management and legal review.',
    `offer_value` DECIMAL(18,2) COMMENT 'The face value of the promotion offer expressed as a monetary amount (e.g., $1.00 off, $5.00 rebate) or as a percentage discount depending on offer_value_type. Represents the consumer-facing benefit. Part of the MONETARY_TRIPLET for this promotion.',
    `offer_value_type` STRING COMMENT 'Indicates whether the offer_value is a fixed monetary amount, a percentage discount, a free product award, or loyalty points. Determines how the offer is applied at redemption.. Valid values are `fixed_amount|percentage|free_product|points`',
    `promotion_code` STRING COMMENT 'Externally-known alphanumeric code that uniquely identifies the promotion across systems (e.g., Salesforce Marketing Cloud, SAP SD, POS systems). Used on coupons, in-app offers, and EDI transactions. Serves as the BUSINESS_IDENTIFIER for this transaction header.. Valid values are `^[A-Z0-9_-]{4,30}$`',
    `promotion_name` STRING COMMENT 'Human-readable marketing name of the promotion as it appears in consumer-facing materials, campaign briefs, and internal planning documents (e.g., Summer Savings Coupon, Buy One Get One Free Chips). Serves as the IDENTITY_LABEL for this record.',
    `promotion_status` STRING COMMENT 'Current lifecycle state of the consumer promotion. Controls execution eligibility and budget commitment. Drives workflow in Salesforce Marketing Cloud and SAP SD condition records.. Valid values are `draft|scheduled|active|paused|expired|cancelled`',
    `promotion_type` STRING COMMENT 'Classification of the consumer promotion by offer mechanic. Determines redemption logic, legal requirements, and budget treatment. [ENUM-REF-CANDIDATE: coupon|rebate|sweepstakes|loyalty_reward|bogo|sampling|instant_win|cashback — promote to reference product]',
    `redemption_budget` DECIMAL(18,2) COMMENT 'Portion of total_budget allocated specifically to cover consumer redemption liability (face value of offers redeemed). Distinct from production and distribution budget components. Used for financial accrual and COGS impact tracking.',
    `redemption_mechanism` STRING COMMENT 'The channel or method through which the consumer redeems the promotion offer. Drives integration requirements with POS systems, Salesforce Marketing Cloud, and clearinghouse partners. [ENUM-REF-CANDIDATE: digital|paper|in_app|mail_in|loyalty_card|auto_apply — promote to reference product]. Valid values are `digital|paper|in_app|mail_in|loyalty_card|auto_apply`',
    `redemption_rate` DECIMAL(18,2) COMMENT 'Percentage of distributed promotion offers that have been redeemed (actual_redemption_count / total distributed units). Industry benchmark metric for promotion effectiveness. Expressed as a decimal (e.g., 0.0250 = 2.50%).',
    `retailer_exclusivity` BOOLEAN COMMENT 'Indicates whether this promotion is exclusive to a specific retailer or retail channel. When True, the promotion may only be redeemed at the designated retailer(s). Impacts trade relationship management and slotting negotiations.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this promotion record originated (e.g., SFMC = Salesforce Marketing Cloud, SAP_SD = SAP Sales and Distribution, INMAR = Inmar clearinghouse). Supports data lineage in the Databricks Silver layer.. Valid values are `SFMC|SAP_SD|MANUAL|INMAR|QUOTIENT`',
    `start_date` DATE COMMENT 'Calendar date on which the consumer promotion becomes active and eligible for redemption. Serves as EFFECTIVE_FROM for the promotion lifecycle. Used in planogram scheduling and retailer communication.',
    `state_registration_required` BOOLEAN COMMENT 'Indicates whether this promotion type (e.g., sweepstakes, contest) requires registration or bonding in specific US states (e.g., New York, Florida). Triggers compliance workflow for legal filing.',
    `target_market` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes identifying the geographic markets where this promotion is valid (e.g., USA, CAN, GBR). Drives regulatory compliance checks and retailer eligibility.. Valid values are `^[A-Z]{3}(,[A-Z]{3})*$`',
    `total_budget` DECIMAL(18,2) COMMENT 'Total approved budget allocated for this consumer promotion in currency_code. Covers offer redemption liability, production costs, and distribution costs. Used for budget reconciliation against actual spend. Part of the MONETARY_TRIPLET.',
    `upc_qualifier` STRING COMMENT 'The Universal Product Code (UPC) company prefix or specific product code used to qualify eligible products at POS redemption. Encoded in GS1 coupon barcodes for automated clearinghouse processing. Null when eligible_sku_scope is all_skus.. Valid values are `^[0-9]{1,12}$`',
    CONSTRAINT pk_consumer_promotion PRIMARY KEY(`consumer_promotion_id`)
) COMMENT 'Master record for consumer-facing promotions — coupons, rebates, sweepstakes, loyalty rewards, BOGO offers, and sampling programs. Captures promotion type, offer value, redemption mechanism (digital, paper, in-app), eligible SKUs, start/end dates, budget, legal terms, regulatory compliance flags, redemption results (rate by channel, retailer performance, aggregate value, fraud flags, ROI). Distinct from trade promotions (owned by trade domain). Supports promotion planning, execution, budget reconciliation, and consumer behavior analysis.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`marketing`.`brand_distribution_allocation` (
    `brand_distribution_allocation_id` BIGINT COMMENT 'Primary key for the brand_distribution_allocation association',
    `brand_id` BIGINT COMMENT 'Foreign key linking to brand',
    `center_id` BIGINT COMMENT 'Foreign key linking to distribution_center',
    `allocation_percent` DECIMAL(18,2) COMMENT 'Percentage of shelf space allocated to the brand at the center',
    `end_date` DATE COMMENT 'Date when the allocation expires or is superseded',
    `primary_stock_flag` BOOLEAN COMMENT 'Indicates if the brand is the primary stock for the center',
    `start_date` DATE COMMENT 'Date when the allocation becomes effective',
    CONSTRAINT pk_brand_distribution_allocation PRIMARY KEY(`brand_distribution_allocation_id`)
) COMMENT 'This association captures the contractual allocation of a brand to a distribution center, including the percentage of shelf space, primary stock designation, and the effective dates of the agreement. Each record links one distribution_center to one brand.. Existence Justification: Brands are actively allocated to distribution centers through formal stocking agreements. Each agreement records the allocation percentage, primary‑stock flag, and the effective start and end dates, and both a brand can be stocked in many centers and a center can carry many brands.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`marketing`.`campaign_inventory_allocation` (
    `campaign_inventory_allocation_id` BIGINT COMMENT 'Primary key for the campaign_inventory_allocation association',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the campaign',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to the stock position',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'Quantity of inventory allocated to the campaign',
    `allocation_date` DATE COMMENT 'Date when the allocation was created',
    `allocation_status` STRING COMMENT 'Current status of the allocation',
    CONSTRAINT pk_campaign_inventory_allocation PRIMARY KEY(`campaign_inventory_allocation_id`)
) COMMENT 'Represents the allocation of inventory (stock positions) to marketing campaigns. Each record links one campaign to one stock position and captures allocation-specific details such as quantity, date, and status.. Existence Justification: Marketing campaigns allocate inventory from one or more stock positions to support promotional activities, and a given stock position can be allocated to multiple campaigns over time. Each allocation is tracked with quantity, allocation date, and status, making the allocation itself a managed business entity.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`marketing`.`market` (
    `market_id` BIGINT COMMENT 'Primary key for market',
    `parent_market_id` BIGINT COMMENT 'Self-referencing FK on market (parent_market_id)',
    `continent` STRING COMMENT 'Continent on which the market is located (e.g., "North America", "Europe").',
    `country_code` STRING COMMENT 'Three‑letter ISO country code representing the primary country of the market. If multiple countries apply, the primary is listed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the market record was first created in the system.',
    `currency_code` STRING COMMENT 'Standard three‑letter currency code for financial reporting in this market.',
    `market_description` STRING COMMENT 'Free‑form text describing the markets characteristics, target consumer profile, and strategic importance.',
    `effective_end_date` DATE COMMENT 'Date when the market is retired or no longer used; null if still active.',
    `effective_start_date` DATE COMMENT 'Date when the market became active for reporting and planning.',
    `is_primary_market` BOOLEAN COMMENT 'Indicates whether this market is a primary focus for the companys marketing strategy.',
    `market_code` STRING COMMENT 'Short alphanumeric code used internally to reference the market (e.g., "NA", "EUW").',
    `market_name` STRING COMMENT 'Human‑readable name of the market (e.g., "North America", "Western Europe").',
    `market_segment` STRING COMMENT 'Business segment that the market primarily serves.',
    `market_size_estimate` DECIMAL(18,2) COMMENT 'Estimated total market size in US dollars, used for budgeting and forecasting.',
    `market_status` STRING COMMENT 'Current lifecycle status of the market.',
    `market_type` STRING COMMENT 'Classification of the market based on segmentation strategy.',
    `region_name` STRING COMMENT 'Higher‑level geographic region that the market belongs to (e.g., "EMEA", "APAC").',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the market record.',
    CONSTRAINT pk_market PRIMARY KEY(`market_id`)
) COMMENT 'Master reference table for market. Referenced by market_id.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`marketing`.`agency` (
    `agency_id` BIGINT COMMENT 'Primary key for agency',
    `parent_agency_id` BIGINT COMMENT 'Self-referencing FK on agency (parent_agency_id)',
    `address_line1` STRING COMMENT 'Primary street address of the agencys main office.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, floor, etc.).',
    `agency_name` STRING COMMENT 'Primary display name of the agency used in marketing and reporting.',
    `agency_rating` STRING COMMENT 'Internal rating of the agencys performance on a 1‑5 scale.',
    `agency_type` STRING COMMENT 'Category of services the agency provides.',
    `city` STRING COMMENT 'City where the agencys primary office is located.',
    `classification` STRING COMMENT 'Classification indicating internal, external, or partner status.',
    `compliance_status` STRING COMMENT 'Current compliance standing of the agency with FTC and internal policies.',
    `contract_end_date` DATE COMMENT 'Date the contractual relationship with the agency is scheduled to end.',
    `contract_start_date` DATE COMMENT 'Date the contractual relationship with the agency began.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the agencys primary location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the agency record was first created in the system.',
    `data_sharing_consent` BOOLEAN COMMENT 'Indicates whether the agency has consented to share data under privacy regulations.',
    `dba_name` STRING COMMENT 'Trade name under which the agency operates, if different from legal name.',
    `effective_from` DATE COMMENT 'Date when the agency agreement becomes effective.',
    `effective_until` DATE COMMENT 'Date when the agency agreement ends or is scheduled to expire; null if open-ended.',
    `industry_vertical` STRING COMMENT 'Primary industry focus of the agency.',
    `legal_name` STRING COMMENT 'Official legal name of the agency as registered with governmental authorities.',
    `notes` STRING COMMENT 'Free‑form notes about the agency relationship.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the agency.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the agencys primary address.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary agency contact for communications.',
    `primary_contact_name` STRING COMMENT 'Full name of the main point of contact at the agency.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary agency contact.',
    `social_media_handle` STRING COMMENT 'Primary social media identifier (e.g., Twitter handle) for the agency.',
    `state` STRING COMMENT 'State or province of the agencys primary office.',
    `agency_status` STRING COMMENT 'Current lifecycle status of the agency relationship.',
    `tax_number` STRING COMMENT 'Government‑issued tax identifier for the agency.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the agency record.',
    `website_url` STRING COMMENT 'Public website address of the agency.',
    CONSTRAINT pk_agency PRIMARY KEY(`agency_id`)
) COMMENT 'Master reference table for agency. Referenced by agency_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `food_beverage_ecm`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_digital_asset_id` FOREIGN KEY (`digital_asset_id`) REFERENCES `food_beverage_ecm`.`marketing`.`digital_asset`(`digital_asset_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `food_beverage_ecm`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_market_id` FOREIGN KEY (`market_id`) REFERENCES `food_beverage_ecm`.`marketing`.`market`(`market_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_media_plan_id` FOREIGN KEY (`media_plan_id`) REFERENCES `food_beverage_ecm`.`marketing`.`media_plan`(`media_plan_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `food_beverage_ecm`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ADD CONSTRAINT `fk_marketing_consumer_insight_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ADD CONSTRAINT `fk_marketing_syndicated_market_data_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ADD CONSTRAINT `fk_marketing_brand_equity_tracker_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ADD CONSTRAINT `fk_marketing_brand_equity_tracker_market_id` FOREIGN KEY (`market_id`) REFERENCES `food_beverage_ecm`.`marketing`.`market`(`market_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ADD CONSTRAINT `fk_marketing_claim_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ADD CONSTRAINT `fk_marketing_claim_substantiation_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ADD CONSTRAINT `fk_marketing_claim_substantiation_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `food_beverage_ecm`.`marketing`.`claim`(`claim_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ADD CONSTRAINT `fk_marketing_claim_substantiation_superseded_by_claim_substantiation_id` FOREIGN KEY (`superseded_by_claim_substantiation_id`) REFERENCES `food_beverage_ecm`.`marketing`.`claim_substantiation`(`claim_substantiation_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ADD CONSTRAINT `fk_marketing_influencer_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ADD CONSTRAINT `fk_marketing_influencer_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `food_beverage_ecm`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ADD CONSTRAINT `fk_marketing_digital_asset_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ADD CONSTRAINT `fk_marketing_digital_asset_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ADD CONSTRAINT `fk_marketing_digital_asset_parent_asset_digital_asset_id` FOREIGN KEY (`parent_asset_digital_asset_id`) REFERENCES `food_beverage_ecm`.`marketing`.`digital_asset`(`digital_asset_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ADD CONSTRAINT `fk_marketing_shopper_program_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `food_beverage_ecm`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ADD CONSTRAINT `fk_marketing_shopper_program_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ADD CONSTRAINT `fk_marketing_consumer_promotion_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ADD CONSTRAINT `fk_marketing_consumer_promotion_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_distribution_allocation` ADD CONSTRAINT `fk_marketing_brand_distribution_allocation_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_inventory_allocation` ADD CONSTRAINT `fk_marketing_campaign_inventory_allocation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`market` ADD CONSTRAINT `fk_marketing_market_parent_market_id` FOREIGN KEY (`parent_market_id`) REFERENCES `food_beverage_ecm`.`marketing`.`market`(`market_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`agency` ADD CONSTRAINT `fk_marketing_agency_parent_agency_id` FOREIGN KEY (`parent_agency_id`) REFERENCES `food_beverage_ecm`.`marketing`.`agency`(`agency_id`);

-- ========= TAGS =========
ALTER SCHEMA `food_beverage_ecm`.`marketing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `food_beverage_ecm`.`marketing` SET TAGS ('dbx_domain' = 'marketing');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` SET TAGS ('dbx_subdomain' = 'brand_management');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Manager Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Consumer Segment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `allergen_free_claims` SET TAGS ('dbx_business_glossary_term' = 'Allergen-Free Claims');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `annual_marketing_budget` SET TAGS ('dbx_business_glossary_term' = 'Annual Marketing Budget');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `annual_marketing_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `architecture_type` SET TAGS ('dbx_business_glossary_term' = 'Brand Architecture Type');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `architecture_type` SET TAGS ('dbx_value_regex' = 'masterbrand|sub_brand|endorsed|standalone|private_label');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `awareness_pct` SET TAGS ('dbx_business_glossary_term' = 'Brand Awareness Percentage');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `brand_category` SET TAGS ('dbx_business_glossary_term' = 'Brand Category');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `clean_label_certified` SET TAGS ('dbx_business_glossary_term' = 'Clean Label Certified Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `crm_brand_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Brand ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `digital_presence_url` SET TAGS ('dbx_business_glossary_term' = 'Brand Digital Presence URL');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `digital_presence_url` SET TAGS ('dbx_value_regex' = '^https?://[^s/$.?#].[^s]*$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Discontinuation Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = 'retail|foodservice|dsd|dtc|ecommerce|club');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `equity_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Equity Score');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `equity_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `erp_brand_code` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Brand Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `erp_brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `gfsi_certification` SET TAGS ('dbx_business_glossary_term' = 'Global Food Safety Initiative (GFSI) Certification Scheme');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `gfsi_certification` SET TAGS ('dbx_value_regex' = 'sqf|brc|fssc_22000|ifs|global_gap|none');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `haccp_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Plan Reference');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Launch Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Legal Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Lifecycle Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|discontinued|pipeline|divested|archived');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `logo_asset_url` SET TAGS ('dbx_business_glossary_term' = 'Brand Logo Asset URL');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `logo_asset_url` SET TAGS ('dbx_value_regex' = '^https?://[^s/$.?#].[^s]*$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `organic_certified` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `owner_division` SET TAGS ('dbx_business_glossary_term' = 'Brand Owner Division');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `plm_product_line_code` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Product Line Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `plm_product_line_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `positioning_statement` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning Statement');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `positioning_statement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `primary_color_hex` SET TAGS ('dbx_business_glossary_term' = 'Brand Primary Color Hex Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `primary_color_hex` SET TAGS ('dbx_value_regex' = '^#[0-9A-Fa-f]{6}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `primary_market` SET TAGS ('dbx_business_glossary_term' = 'Primary Market Country');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `primary_market` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `promise` SET TAGS ('dbx_business_glossary_term' = 'Brand Promise');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|under_review|rejected|not_required');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Brand Segment');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `social_media_handle` SET TAGS ('dbx_business_glossary_term' = 'Brand Social Media Handle');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `sustainability_claim` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Claim');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Tier');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `tier` SET TAGS ('dbx_value_regex' = 'premium|mainstream|value|super_premium');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `trademark_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Trademark Expiry Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `trademark_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Trademark Registration Number');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `trademark_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` SET TAGS ('dbx_subdomain' = 'campaign_operations');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `agency_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Manager Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Campaign Spend (USD)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `acv_target_pct` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Target Percentage');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Approval Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Approved Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_description` SET TAGS ('dbx_business_glossary_term' = 'Campaign Description');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_value_regex' = 'draft|planned|active|paused|completed|cancelled');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'awareness|trial|loyalty|trade|shopper|influencer');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Campaign Channel');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `fda_claims_compliant` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Claims Compliant Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `ftc_claims_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Federal Trade Commission (FTC) Claims Reviewed Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `influencer_partnership` SET TAGS ('dbx_business_glossary_term' = 'Influencer Partnership Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Internal Order Number');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `media_impressions_target` SET TAGS ('dbx_business_glossary_term' = 'Media Impressions Target');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Campaign Objective');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `planned_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Planned Campaign Budget (USD)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `planned_budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `private_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `reach_target_households` SET TAGS ('dbx_business_glossary_term' = 'Reach Target Households');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `sfmc_campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Marketing Cloud (SFMC) Campaign ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `shopper_marketing_flag` SET TAGS ('dbx_business_glossary_term' = 'Shopper Marketing Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `sku_scope` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Scope');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `target_geography` SET TAGS ('dbx_business_glossary_term' = 'Target Geography');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `tdp_target` SET TAGS ('dbx_business_glossary_term' = 'Total Distribution Points (TDP) Target');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `trade_promotion_flag` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` SET TAGS ('dbx_subdomain' = 'campaign_operations');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `campaign_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Execution ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `formulation_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Version Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `nutrition_label_id` SET TAGS ('dbx_business_glossary_term' = 'Nutrition Label Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `ad_format` SET TAGS ('dbx_business_glossary_term' = 'Ad Format');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Media Agency Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `buying_type` SET TAGS ('dbx_business_glossary_term' = 'Media Buying Type');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `buying_type` SET TAGS ('dbx_value_regex' = 'cpm|cpc|cpa|cpv|flat_fee|programmatic');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `channel_platform` SET TAGS ('dbx_business_glossary_term' = 'Channel Platform');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel Type');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `claim_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Marketing Claim Compliance Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `claim_compliance_status` SET TAGS ('dbx_value_regex' = 'pending_review|approved|rejected|conditionally_approved');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `clicks_delivered` SET TAGS ('dbx_business_glossary_term' = 'Clicks Delivered');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `cost_per_thousand_impressions` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Thousand Impressions (CPM)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `cost_per_thousand_impressions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `creative_version` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Version');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `creative_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_number` SET TAGS ('dbx_business_glossary_term' = 'Campaign Execution Number');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_number` SET TAGS ('dbx_value_regex' = '^CE-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Execution Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|paused|completed|cancelled');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight End Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Start Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Ad Frequency');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `impressions_delivered` SET TAGS ('dbx_business_glossary_term' = 'Impressions Delivered');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `influencer_partnership_flag` SET TAGS ('dbx_business_glossary_term' = 'Influencer Partnership Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `marketing_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Claim Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `nielsen_market_code` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Market Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `placement_name` SET TAGS ('dbx_business_glossary_term' = 'Ad Placement Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `planned_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Spend Amount');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `planned_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `reach` SET TAGS ('dbx_business_glossary_term' = 'Reach');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `salesforce_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Marketing Cloud Activity ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `spend_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Spend Currency Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `spend_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `target_audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `target_geography_code` SET TAGS ('dbx_business_glossary_term' = 'Target Geography Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `target_geography_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `target_region` SET TAGS ('dbx_business_glossary_term' = 'Target Region');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `target_retailer_name` SET TAGS ('dbx_business_glossary_term' = 'Target Retailer Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'UTM Campaign Parameter');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'UTM Medium Parameter');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'UTM Source Parameter');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `vendor_order_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Media Order Number');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `video_completion_rate` SET TAGS ('dbx_business_glossary_term' = 'Video Completion Rate');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `video_views` SET TAGS ('dbx_business_glossary_term' = 'Video Views');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` SET TAGS ('dbx_subdomain' = 'campaign_operations');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `media_spend_id` SET TAGS ('dbx_business_glossary_term' = 'Media Spend ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `agency_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `market_id` SET TAGS ('dbx_business_glossary_term' = 'Market ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `media_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Media Vendor ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `agency_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Agency Fee Amount');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `agency_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `buying_type` SET TAGS ('dbx_business_glossary_term' = 'Media Buying Type');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `buying_type` SET TAGS ('dbx_value_regex' = 'upfront|scatter|programmatic|direct|sponsorship');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Advertising Claim Type');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'health|nutrition|sustainability|taste|price|brand');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `clicks` SET TAGS ('dbx_business_glossary_term' = 'Clicks');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `committed_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Spend Amount');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `committed_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `cpc` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Click (CPC)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `cpc` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `cpm` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Thousand Impressions (CPM)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `cpm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'SAP|agency_billing|media_platform|Nielsen|IRI|manual');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA) Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-P(0[1-9]|1[0-3])$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `ftc_compliant` SET TAGS ('dbx_business_glossary_term' = 'Federal Trade Commission (FTC) Compliant Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `geo_market_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `geo_market_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `grp` SET TAGS ('dbx_business_glossary_term' = 'Gross Rating Points (GRP)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `impressions` SET TAGS ('dbx_business_glossary_term' = 'Impressions');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `media_channel` SET TAGS ('dbx_business_glossary_term' = 'Media Channel');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `media_format` SET TAGS ('dbx_business_glossary_term' = 'Media Format');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `media_type` SET TAGS ('dbx_business_glossary_term' = 'Media Type');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `planned_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Spend Amount');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `planned_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `reach` SET TAGS ('dbx_business_glossary_term' = 'Reach');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `roi_index` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Index');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `shopper_marketing_flag` SET TAGS ('dbx_business_glossary_term' = 'Shopper Marketing Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `spend_date` SET TAGS ('dbx_business_glossary_term' = 'Spend Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `spend_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Spend Reference Number');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `spend_status` SET TAGS ('dbx_business_glossary_term' = 'Spend Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `spend_status` SET TAGS ('dbx_value_regex' = 'planned|committed|invoiced|paid|cancelled');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ALTER COLUMN `working_media_flag` SET TAGS ('dbx_business_glossary_term' = 'Working Media Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` SET TAGS ('dbx_subdomain' = 'campaign_operations');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `media_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `promotion_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Media Contract Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `agency_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Agency Fee Amount');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `agency_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_required');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Advertising and Promotion (A&P) Budget Amount');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `budget_owner` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `budget_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `budget_variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `committed_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Spend Amount');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `committed_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `digital_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Digital Media Budget Amount');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `digital_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `fda_claims_compliant` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Advertising Claims Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^(Q[1-4]|P(0[1-9]|1[0-3]))$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `ftc_claims_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Federal Trade Commission (FTC) Marketing Claims Reviewed Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `media_mix_strategy` SET TAGS ('dbx_business_glossary_term' = 'Media Mix Strategy Description');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `nielsen_market_code` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Market Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `ooh_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Home (OOH) Budget Amount');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `ooh_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `plan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Media Plan End Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Number');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^MP-[A-Z0-9]{4,20}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `plan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Start Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Type');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'brand_building|trade_promotion|shopper_marketing|new_product_launch|seasonal|always_on');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `planned_frequency` SET TAGS ('dbx_business_glossary_term' = 'Planned Average Frequency');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `planned_grp` SET TAGS ('dbx_business_glossary_term' = 'Planned Gross Rating Points (GRP)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `planned_reach_pct` SET TAGS ('dbx_business_glossary_term' = 'Planned Reach Percentage');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `primary_channel` SET TAGS ('dbx_business_glossary_term' = 'Primary Media Channel');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `production_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Production Cost Amount');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `production_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `salesforce_campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Marketing Cloud Campaign Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `shopper_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Shopper Marketing Budget Amount');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `shopper_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `social_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Social Media Budget Amount');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `social_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `streaming_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Streaming Media Budget Amount');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `streaming_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Definition');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `tv_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Television (TV) Budget Amount');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `tv_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Version Number');
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ALTER COLUMN `working_media_pct` SET TAGS ('dbx_business_glossary_term' = 'Working Media Percentage');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` SET TAGS ('dbx_subdomain' = 'consumer_insights');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `consumer_insight_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Insight ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Commissioned By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `promotion_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Research Spend (USD)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `allergen_relevance` SET TAGS ('dbx_business_glossary_term' = 'Allergen Relevance Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `category_scope` SET TAGS ('dbx_business_glossary_term' = 'Category Scope');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `clean_label_relevance` SET TAGS ('dbx_business_glossary_term' = 'Clean Label Relevance Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `concept_test_score` SET TAGS ('dbx_business_glossary_term' = 'Concept Test Score');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `confidence_level_pct` SET TAGS ('dbx_business_glossary_term' = 'Statistical Confidence Level Percentage');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `deliverable_date` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `deliverable_reference` SET TAGS ('dbx_business_glossary_term' = 'Key Deliverable Reference');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `fielding_end_date` SET TAGS ('dbx_business_glossary_term' = 'Fielding End Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `fielding_start_date` SET TAGS ('dbx_business_glossary_term' = 'Fielding Start Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `geography_scope` SET TAGS ('dbx_business_glossary_term' = 'Geography Scope');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `insight_action` SET TAGS ('dbx_business_glossary_term' = 'Insight Action Recommendation');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `insight_category` SET TAGS ('dbx_business_glossary_term' = 'Insight Category');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `insight_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insight Expiry Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `insight_priority` SET TAGS ('dbx_business_glossary_term' = 'Insight Priority Level');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `insight_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `key_finding_summary` SET TAGS ('dbx_business_glossary_term' = 'Key Finding Summary');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `npd_pipeline_flag` SET TAGS ('dbx_business_glossary_term' = 'New Product Development (NPD) Pipeline Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `private_label_relevance` SET TAGS ('dbx_business_glossary_term' = 'Private Label Relevance Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `regulatory_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Claim Support Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `research_methodology` SET TAGS ('dbx_business_glossary_term' = 'Research Methodology');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `research_vendor` SET TAGS ('dbx_business_glossary_term' = 'Research Vendor Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size (n)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `sensory_score` SET TAGS ('dbx_business_glossary_term' = 'Sensory / Organoleptic Score');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `sku_scope` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Scope');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `study_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Research Study Budget (USD)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `study_budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `study_code` SET TAGS ('dbx_business_glossary_term' = 'Research Study Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `study_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}-[0-9]{4}-[0-9]{4,6}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `study_name` SET TAGS ('dbx_business_glossary_term' = 'Research Study Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Research Study Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `study_status` SET TAGS ('dbx_value_regex' = 'planned|fielding|analysis|completed|cancelled|on_hold');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Research Study Type');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'qualitative|quantitative|mixed_method|syndicated|proprietary');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `sustainability_relevance` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Relevance Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `target_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Consumer Segment');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ALTER COLUMN `vendor_project_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Project ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` SET TAGS ('dbx_subdomain' = 'consumer_insights');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `syndicated_market_data_id` SET TAGS ('dbx_business_glossary_term' = 'Syndicated Market Data ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `acv_distribution_pct` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Distribution Percentage');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `avg_base_price` SET TAGS ('dbx_business_glossary_term' = 'Average Base Price');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `avg_selling_price` SET TAGS ('dbx_business_glossary_term' = 'Average Selling Price');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Category Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `data_aggregation_level` SET TAGS ('dbx_business_glossary_term' = 'Data Aggregation Level');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `data_aggregation_level` SET TAGS ('dbx_value_regex' = 'SKU|Brand|Subcategory|Category|Manufacturer');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `data_load_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Load Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `data_vintage_date` SET TAGS ('dbx_business_glossary_term' = 'Data Vintage Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `display_pct` SET TAGS ('dbx_business_glossary_term' = 'Display Percentage (ACV)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `dollar_sales` SET TAGS ('dbx_business_glossary_term' = 'Dollar Sales');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `dollar_sales_change_pct` SET TAGS ('dbx_business_glossary_term' = 'Dollar Sales Change Percentage (Year-over-Year)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `dollar_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Dollar Market Share Percentage');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `equivalent_unit_sales` SET TAGS ('dbx_business_glossary_term' = 'Equivalent Unit Sales');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `feature_pct` SET TAGS ('dbx_business_glossary_term' = 'Feature Percentage (ACV)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{14}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `is_own_brand` SET TAGS ('dbx_business_glossary_term' = 'Is Own Brand Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `is_private_label` SET TAGS ('dbx_business_glossary_term' = 'Is Private Label Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `market_name` SET TAGS ('dbx_business_glossary_term' = 'Market Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'Total US|Regional|Account-Specific|Channel');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `numeric_distribution_pct` SET TAGS ('dbx_business_glossary_term' = 'Numeric Distribution Percentage');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `pack_size` SET TAGS ('dbx_business_glossary_term' = 'Pack Size');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `price_reduction_pct` SET TAGS ('dbx_business_glossary_term' = 'Price Reduction Percentage (ACV)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `promoted_dollar_sales` SET TAGS ('dbx_business_glossary_term' = 'Promoted Dollar Sales');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `promoted_unit_sales` SET TAGS ('dbx_business_glossary_term' = 'Promoted Unit Sales');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `reporting_period_type` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Type');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `reporting_period_type` SET TAGS ('dbx_value_regex' = '4-Week|12-Week|52-Week|Weekly|Monthly|Quarterly');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `retail_channel` SET TAGS ('dbx_business_glossary_term' = 'Retail Channel');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `sku_description` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Description');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Nielsen|IRI|SPINS');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `stores_selling` SET TAGS ('dbx_business_glossary_term' = 'Stores Selling');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `subcategory_name` SET TAGS ('dbx_business_glossary_term' = 'Subcategory Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `tdp` SET TAGS ('dbx_business_glossary_term' = 'Total Distribution Points (TDP)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `total_stores_in_market` SET TAGS ('dbx_business_glossary_term' = 'Total Stores in Market');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `unit_sales` SET TAGS ('dbx_business_glossary_term' = 'Unit Sales');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `unit_sales_change_pct` SET TAGS ('dbx_business_glossary_term' = 'Unit Sales Change Percentage (Year-over-Year)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `unit_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Unit Market Share Percentage');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `upc_code` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `upc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ALTER COLUMN `velocity_per_store_per_week` SET TAGS ('dbx_business_glossary_term' = 'Velocity Per Store Per Week');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` SET TAGS ('dbx_subdomain' = 'brand_management');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `brand_equity_tracker_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Equity Tracker ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `market_id` SET TAGS ('dbx_business_glossary_term' = 'Market ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `advertising_recall_pct` SET TAGS ('dbx_business_glossary_term' = 'Advertising Recall Percentage');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `aided_awareness_pct` SET TAGS ('dbx_business_glossary_term' = 'Aided Brand Awareness Percentage');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `brand_equity_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Equity Record Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `brand_equity_status` SET TAGS ('dbx_value_regex' = 'active|archived|preliminary|final|restated');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `brand_health_index` SET TAGS ('dbx_business_glossary_term' = 'Brand Health Index');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `brand_health_index` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `brand_health_index` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `brand_love_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Love Score');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `brand_preference_pct` SET TAGS ('dbx_business_glossary_term' = 'Brand Preference Percentage');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `brand_quality_perception_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Quality Perception Score');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `brand_trust_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Trust Score');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `brand_value_perception_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Value Perception Score');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Product Category Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `clean_label_perception_score` SET TAGS ('dbx_business_glossary_term' = 'Clean Label Perception Score');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `competitive_set_label` SET TAGS ('dbx_business_glossary_term' = 'Competitive Set Label');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `confidence_interval_pct` SET TAGS ('dbx_business_glossary_term' = 'Statistical Confidence Interval Percentage');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `consideration_pct` SET TAGS ('dbx_business_glossary_term' = 'Brand Consideration Percentage');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_value_regex' = 'online_panel|telephone|in_person|mobile|mixed_method');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `detractor_pct` SET TAGS ('dbx_business_glossary_term' = 'Detractor Percentage');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `market_country_code` SET TAGS ('dbx_business_glossary_term' = 'Market Country Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `market_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `measurement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `measurement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `period_over_period_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Period-Over-Period Statistically Significant Change Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `promoter_pct` SET TAGS ('dbx_business_glossary_term' = 'Promoter Percentage');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `purchase_intent_pct` SET TAGS ('dbx_business_glossary_term' = 'Purchase Intent Percentage');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `repeat_purchase_pct` SET TAGS ('dbx_business_glossary_term' = 'Repeat Purchase Percentage');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `research_vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Research Vendor Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Survey Sample Size');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `social_media_sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Social Media Sentiment Score');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `sustainability_perception_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Perception Score');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `tracking_study_code` SET TAGS ('dbx_business_glossary_term' = 'Tracking Study ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `trial_pct` SET TAGS ('dbx_business_glossary_term' = 'Brand Trial Percentage');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `unaided_awareness_pct` SET TAGS ('dbx_business_glossary_term' = 'Unaided Brand Awareness Percentage');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `wave_label` SET TAGS ('dbx_business_glossary_term' = 'Tracking Wave Label');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `wave_type` SET TAGS ('dbx_business_glossary_term' = 'Tracking Wave Type');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ALTER COLUMN `wave_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|bi-annual|annual|ad_hoc');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` SET TAGS ('dbx_subdomain' = 'brand_management');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Claim ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `formulation_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Version Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `allergen_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Related Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Approval Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Claim Channel Applicability');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_value_regex' = 'packaging|digital|advertising|all|in_store|foodservice');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `claim_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Claim Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `claim_code` SET TAGS ('dbx_value_regex' = '^CLM-[A-Z0-9]{4,12}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `claim_name` SET TAGS ('dbx_business_glossary_term' = 'Marketing Claim Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Marketing Claim Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `claim_text` SET TAGS ('dbx_business_glossary_term' = 'Marketing Claim Text');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Marketing Claim Type');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'nutritional|environmental|lifestyle|ingredient|process|certification');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `clean_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Clean Label Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `competitor_parity_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitor Parity Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `consumer_research_ref` SET TAGS ('dbx_business_glossary_term' = 'Consumer Research Reference');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Effective End Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `environmental_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Claim Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected|escalated');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `legal_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `market_region` SET TAGS ('dbx_business_glossary_term' = 'Market Region');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `marketing_owner` SET TAGS ('dbx_business_glossary_term' = 'Marketing Claim Owner');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Claim Notes');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `organic_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Claim Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `packaging_version` SET TAGS ('dbx_business_glossary_term' = 'Packaging Version');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Claim Priority Tier');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `regulatory_approval_ref` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `regulatory_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Affairs Reviewer Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Claim Review Frequency (Days)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'TraceGains|Veeva_Vault|SAP_S4HANA|Salesforce_MC|Manual');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `source_system_claim_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Claim ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `substantiation_doc_ref` SET TAGS ('dbx_business_glossary_term' = 'Claim Substantiation Document Reference');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `substantiation_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Substantiation Type');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `substantiation_type` SET TAGS ('dbx_value_regex' = 'lab_test|third_party_cert|clinical_study|supplier_attestation|regulatory_filing|internal_audit');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Marketing Claim Subtype');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` SET TAGS ('dbx_subdomain' = 'brand_management');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `claim_substantiation_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Substantiation ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `brand_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Claim ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `label_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Label Approval Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'TraceGains Specification ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `superseded_by_claim_substantiation_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Substantiation ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `allergen_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Claim Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Substantiation Approval Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `approving_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `approving_authority_role` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority Role');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `approving_authority_role` SET TAGS ('dbx_value_regex' = 'regulatory_affairs|legal_counsel|scientific_committee|quality_director|external_auditor');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `channel_scope` SET TAGS ('dbx_business_glossary_term' = 'Channel Scope');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `channel_scope` SET TAGS ('dbx_value_regex' = 'retail|foodservice|direct_to_consumer|digital|all_channels');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `claim_category` SET TAGS ('dbx_business_glossary_term' = 'Marketing Claim Category');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `claim_category` SET TAGS ('dbx_value_regex' = 'health_claim|nutrient_content_claim|structure_function_claim|environmental_claim|organic_claim|clean_label_claim');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `claim_text` SET TAGS ('dbx_business_glossary_term' = 'Marketing Claim Text');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `conditions_of_use` SET TAGS ('dbx_business_glossary_term' = 'Conditions of Use');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Substantiation Effective From Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Substantiation Expiry Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `ftc_challenge_risk` SET TAGS ('dbx_business_glossary_term' = 'FTC Challenge Risk Level');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `ftc_challenge_risk` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `ftc_challenge_risk` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `legal_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Outcome');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `legal_review_outcome` SET TAGS ('dbx_value_regex' = 'approved|approved_with_conditions|rejected|pending');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `legal_review_outcome` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `legal_review_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Reference Number');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `legal_review_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `market_geography` SET TAGS ('dbx_business_glossary_term' = 'Market Geography (ISO 3166-1 Alpha-3)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `market_geography` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `media_type_scope` SET TAGS ('dbx_business_glossary_term' = 'Media Type Scope');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `media_type_scope` SET TAGS ('dbx_value_regex' = 'packaging|print|digital|broadcast|social_media|all_media');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `organic_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certification Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `product_sku` SET TAGS ('dbx_business_glossary_term' = 'Product Stock Keeping Unit (SKU)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_value_regex' = 'FDA|USDA|EFSA|FTC|EPA|Codex');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `regulatory_filing_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Number');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `study_publication_date` SET TAGS ('dbx_business_glossary_term' = 'Study Publication Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `study_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Study Reference ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `substantiation_notes` SET TAGS ('dbx_business_glossary_term' = 'Substantiation Notes');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `substantiation_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `substantiation_number` SET TAGS ('dbx_business_glossary_term' = 'Substantiation Reference Number');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `substantiation_number` SET TAGS ('dbx_value_regex' = '^SUB-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `substantiation_status` SET TAGS ('dbx_business_glossary_term' = 'Substantiation Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `substantiation_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|rejected|expired|withdrawn');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `substantiation_type` SET TAGS ('dbx_business_glossary_term' = 'Substantiation Type');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `substantiation_type` SET TAGS ('dbx_value_regex' = 'scientific_study|clinical_trial|meta_analysis|regulatory_filing|expert_opinion|consumer_survey');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `supporting_study_title` SET TAGS ('dbx_business_glossary_term' = 'Supporting Scientific Study Title');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `third_party_verified` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Verified Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `third_party_verifier_name` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Verifier Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `veeva_document_code` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Substantiation Version Number');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` SET TAGS ('dbx_subdomain' = 'campaign_operations');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Talent Agency Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `allergen_claim_approved` SET TAGS ('dbx_business_glossary_term' = 'Allergen Claim Approved Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `audience_age_group` SET TAGS ('dbx_business_glossary_term' = 'Primary Audience Age Group');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `audience_age_group` SET TAGS ('dbx_value_regex' = '13-17|18-24|25-34|35-44|45-54|55+');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `audience_authenticity_score` SET TAGS ('dbx_business_glossary_term' = 'Audience Authenticity Score');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `audience_gender_split_pct` SET TAGS ('dbx_business_glossary_term' = 'Audience Female Gender Split Percentage');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `audience_gender_split_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `audience_gender_split_pct` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `avg_post_reach` SET TAGS ('dbx_business_glossary_term' = 'Average Post Reach');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `brand_safety_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Score');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `content_category` SET TAGS ('dbx_business_glossary_term' = 'Content Category');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `content_category` SET TAGS ('dbx_value_regex' = 'food|lifestyle|fitness|parenting|beauty|travel');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|terminated|on_hold');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'salesforce_mc|manual|agency_portal|nielsen|spins');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Influencer Email Address');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `engagement_rate` SET TAGS ('dbx_business_glossary_term' = 'Engagement Rate');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_value_regex' = 'category|brand|product|platform|full');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `fee_per_post` SET TAGS ('dbx_business_glossary_term' = 'Fee Per Post');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `fee_per_post` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `follower_count` SET TAGS ('dbx_business_glossary_term' = 'Follower Count');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `ftc_disclosure_compliant` SET TAGS ('dbx_business_glossary_term' = 'FTC Disclosure Compliant Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Influencer Full Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `handle` SET TAGS ('dbx_business_glossary_term' = 'Social Media Handle');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `handle` SET TAGS ('dbx_value_regex' = '^@?[A-Za-z0-9_.]{1,64}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `handle` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `health_claim_approved` SET TAGS ('dbx_business_glossary_term' = 'Health Claim Approved Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `health_claim_approved` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `health_claim_approved` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `last_post_date` SET TAGS ('dbx_business_glossary_term' = 'Last Post Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `past_brand_partnerships` SET TAGS ('dbx_business_glossary_term' = 'Past Brand Partnerships');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Influencer Phone Number');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Social Media Platform');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `platform` SET TAGS ('dbx_value_regex' = 'Instagram|TikTok|YouTube|Pinterest|Facebook|X');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `posts_delivered` SET TAGS ('dbx_business_glossary_term' = 'Posts Delivered');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `preferred_content_format` SET TAGS ('dbx_business_glossary_term' = 'Preferred Content Format');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `preferred_content_format` SET TAGS ('dbx_value_regex' = 'static_post|reel|story|video|live|blog');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Content Language');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `product_gifting_flag` SET TAGS ('dbx_business_glossary_term' = 'Product Gifting Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `renewal_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Eligible Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Influencer Tier');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `tier` SET TAGS ('dbx_value_regex' = 'nano|micro|macro|mega');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer` ALTER COLUMN `total_contracted_posts` SET TAGS ('dbx_business_glossary_term' = 'Total Contracted Posts');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` SET TAGS ('dbx_subdomain' = 'campaign_operations');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `influencer_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer Engagement ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `activation_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Influencer Activation Reference Number');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `activation_reference_number` SET TAGS ('dbx_value_regex' = '^INF-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `actual_deliverable_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Deliverable Count');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `agency_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Agency Managed Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `audience_size` SET TAGS ('dbx_business_glossary_term' = 'Audience Size');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `content_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Content Approval Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `content_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Content Approval Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `content_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_requested');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `content_caption` SET TAGS ('dbx_business_glossary_term' = 'Content Caption');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `content_rights_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Content Rights Expiry Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `content_type` SET TAGS ('dbx_value_regex' = 'story|reel|post|video|live|blog');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `content_url` SET TAGS ('dbx_business_glossary_term' = 'Content URL');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `content_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `contracted_deliverable_count` SET TAGS ('dbx_business_glossary_term' = 'Contracted Deliverable Count');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `contracted_fee` SET TAGS ('dbx_business_glossary_term' = 'Contracted Fee');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `contracted_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `contracted_fee` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `earned_media_value` SET TAGS ('dbx_business_glossary_term' = 'Earned Media Value (EMV)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `earned_media_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `engagement_rate` SET TAGS ('dbx_business_glossary_term' = 'Engagement Rate');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_value_regex' = 'draft|contracted|live|completed|cancelled|disputed');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `engagements` SET TAGS ('dbx_business_glossary_term' = 'Engagements');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `exclusivity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity End Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `ftc_disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Federal Trade Commission (FTC) Disclosure Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `ftc_disclosure_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|waived');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `ftc_disclosure_tag` SET TAGS ('dbx_business_glossary_term' = 'Federal Trade Commission (FTC) Disclosure Tag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `hashtags` SET TAGS ('dbx_business_glossary_term' = 'Hashtags');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `impressions` SET TAGS ('dbx_business_glossary_term' = 'Impressions');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `link_clicks` SET TAGS ('dbx_business_glossary_term' = 'Link Clicks');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `paid_amplification_flag` SET TAGS ('dbx_business_glossary_term' = 'Paid Amplification Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `payment_milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Milestone Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `payment_milestone_status` SET TAGS ('dbx_value_regex' = 'pending|approved|paid|on_hold|disputed');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `performance_bonus` SET TAGS ('dbx_business_glossary_term' = 'Performance Bonus');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `performance_bonus` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `performance_bonus` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Social Media Platform');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `platform` SET TAGS ('dbx_value_regex' = 'Instagram|TikTok|YouTube|Facebook|Pinterest|X');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `post_date` SET TAGS ('dbx_business_glossary_term' = 'Post Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `post_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Post Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `product_claim_type` SET TAGS ('dbx_business_glossary_term' = 'Product Claim Type');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `product_claim_type` SET TAGS ('dbx_value_regex' = 'health_claim|nutrient_content|structure_function|no_claim|taste_preference');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `reach` SET TAGS ('dbx_business_glossary_term' = 'Reach');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `utm_campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Campaign Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `video_views` SET TAGS ('dbx_business_glossary_term' = 'Video Views');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` SET TAGS ('dbx_subdomain' = 'brand_management');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `parent_asset_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `promotion_line_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Line Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Stock Keeping Unit (SKU)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `allergen_claim_present` SET TAGS ('dbx_business_glossary_term' = 'Allergen Claim Present Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|rejected|archived|expired');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `asset_subtype` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Subtype');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Type');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_value_regex' = 'image|video|audio|document|template|brand_guideline');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `clean_label_compliant` SET TAGS ('dbx_business_glossary_term' = 'Clean Label Compliant Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `color_profile` SET TAGS ('dbx_business_glossary_term' = 'Color Profile');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `color_profile` SET TAGS ('dbx_value_regex' = 'sRGB|CMYK|Adobe_RGB|Pantone|Grayscale');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `dam_asset_code` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Management (DAM) Asset Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `dam_asset_code` SET TAGS ('dbx_value_regex' = '^DAM-[A-Z0-9]{4,20}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `dam_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Management (DAM) System Reference');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration (Seconds)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'File Size (Kilobytes)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `height_px` SET TAGS ('dbx_business_glossary_term' = 'Height (Pixels)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `influencer_content` SET TAGS ('dbx_business_glossary_term' = 'Influencer Content Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `is_master_asset` SET TAGS ('dbx_business_glossary_term' = 'Is Master Asset Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiry Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `locale_code` SET TAGS ('dbx_business_glossary_term' = 'Locale Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `locale_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `nutrition_claim_present` SET TAGS ('dbx_business_glossary_term' = 'Nutrition Claim Present Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `regulatory_review_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Review Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `regulatory_review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|cleared|rejected');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `resolution_dpi` SET TAGS ('dbx_business_glossary_term' = 'Resolution (Dots Per Inch)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `rights_holder` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `rights_holder` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `rights_type` SET TAGS ('dbx_business_glossary_term' = 'Rights Type');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `rights_type` SET TAGS ('dbx_value_regex' = 'royalty_free|rights_managed|creative_commons|proprietary|licensed');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `storage_location_url` SET TAGS ('dbx_business_glossary_term' = 'Storage Location URL');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `tags_keywords` SET TAGS ('dbx_business_glossary_term' = 'Tags and Keywords');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail URL');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `usage_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Usage Restrictions');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^vd+.d+(.d+)?$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ALTER COLUMN `width_px` SET TAGS ('dbx_business_glossary_term' = 'Width (Pixels)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` SET TAGS ('dbx_subdomain' = 'campaign_operations');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `shopper_program_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper Program ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper Marketing Manager ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Management (TPM) Event ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Account ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Program Spend (USD)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `acv_weighted_pct` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Weighted Distribution (%)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `baseline_sales_usd` SET TAGS ('dbx_business_glossary_term' = 'Baseline Sales (USD)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `baseline_sales_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `coupon_redemption_rate` SET TAGS ('dbx_business_glossary_term' = 'Coupon Redemption Rate');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `coupons_distributed` SET TAGS ('dbx_business_glossary_term' = 'Coupons Distributed');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `coupons_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Coupons Redeemed');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `display_compliance_rate` SET TAGS ('dbx_business_glossary_term' = 'Display Compliance Rate');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `dsd_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Program Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `facing_count` SET TAGS ('dbx_business_glossary_term' = 'Facing Count');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `fda_label_compliant` SET TAGS ('dbx_business_glossary_term' = 'FDA Label Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `ftc_claims_reviewed` SET TAGS ('dbx_business_glossary_term' = 'FTC Marketing Claims Reviewed Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `incremental_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Incremental Sales Lift (%)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `planned_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Program Duration (Days)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `post_event_eval_status` SET TAGS ('dbx_business_glossary_term' = 'Post-Event Evaluation (PEE) Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `post_event_eval_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|waived');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `private_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Program Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Shopper Program Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^SHP-[A-Z0-9]{4,12}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Shopper Program Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `program_objective` SET TAGS ('dbx_business_glossary_term' = 'Shopper Program Objective');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Shopper Program Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'draft|planned|active|completed|cancelled');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Shopper Program Type');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `promoted_sales_usd` SET TAGS ('dbx_business_glossary_term' = 'Promoted Sales (USD)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `promoted_sales_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `retailer_channel` SET TAGS ('dbx_business_glossary_term' = 'Retailer Channel');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `roi_pct` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) (%)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `sku_scope` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Scope');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `sku_scope` SET TAGS ('dbx_value_regex' = 'single_sku|multi_sku|full_brand|category_wide');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `slotting_fee_usd` SET TAGS ('dbx_business_glossary_term' = 'Slotting Fee (USD)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `slotting_fee_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `store_count_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Store Count');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `store_count_planned` SET TAGS ('dbx_business_glossary_term' = 'Planned Store Count');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `syndicated_data_source` SET TAGS ('dbx_business_glossary_term' = 'Syndicated Data Source');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `syndicated_data_source` SET TAGS ('dbx_value_regex' = 'nielsen|iri|spins|pos_direct|panel|none');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `tdp_impact` SET TAGS ('dbx_business_glossary_term' = 'Total Distribution Points (TDP) Impact');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `total_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Program Budget (USD)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `total_budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` SET TAGS ('dbx_subdomain' = 'campaign_operations');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `consumer_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Promotion ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Owner ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `actual_redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Redemption Count');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `actual_redemption_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Redemption Value');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Promotion Approval Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_required');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Promotion Approved Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `clearinghouse_code` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse ID');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `clearinghouse_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Promotion Distribution Channel');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `eligible_sku_scope` SET TAGS ('dbx_business_glossary_term' = 'Eligible Stock Keeping Unit (SKU) Scope');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `eligible_sku_scope` SET TAGS ('dbx_value_regex' = 'all_skus|specific_skus|product_line|category');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion End Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `fraud_review_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Review Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `fraud_review_status` SET TAGS ('dbx_value_regex' = 'not_reviewed|under_review|cleared|confirmed_fraud');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `ftc_compliant` SET TAGS ('dbx_business_glossary_term' = 'Federal Trade Commission (FTC) Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Promotion Notes');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `legal_terms_version` SET TAGS ('dbx_business_glossary_term' = 'Legal Terms Version');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `legal_terms_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `max_redemptions` SET TAGS ('dbx_business_glossary_term' = 'Maximum Redemptions');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `max_redemptions_per_consumer` SET TAGS ('dbx_business_glossary_term' = 'Maximum Redemptions Per Consumer');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `minimum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Quantity');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `offer_description` SET TAGS ('dbx_business_glossary_term' = 'Offer Description');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `offer_value` SET TAGS ('dbx_business_glossary_term' = 'Offer Value');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `offer_value_type` SET TAGS ('dbx_business_glossary_term' = 'Offer Value Type');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `offer_value_type` SET TAGS ('dbx_value_regex' = 'fixed_amount|percentage|free_product|points');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Consumer Promotion Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `promotion_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,30}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `promotion_name` SET TAGS ('dbx_business_glossary_term' = 'Consumer Promotion Name');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `promotion_status` SET TAGS ('dbx_business_glossary_term' = 'Consumer Promotion Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `promotion_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|paused|expired|cancelled');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `promotion_type` SET TAGS ('dbx_business_glossary_term' = 'Consumer Promotion Type');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `redemption_budget` SET TAGS ('dbx_business_glossary_term' = 'Redemption Budget');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `redemption_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `redemption_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Redemption Mechanism');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `redemption_mechanism` SET TAGS ('dbx_value_regex' = 'digital|paper|in_app|mail_in|loyalty_card|auto_apply');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `redemption_rate` SET TAGS ('dbx_business_glossary_term' = 'Redemption Rate');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `retailer_exclusivity` SET TAGS ('dbx_business_glossary_term' = 'Retailer Exclusivity Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SFMC|SAP_SD|MANUAL|INMAR|QUOTIENT');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Start Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `state_registration_required` SET TAGS ('dbx_business_glossary_term' = 'State Registration Required Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `target_market` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}(,[A-Z]{3})*$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `total_budget` SET TAGS ('dbx_business_glossary_term' = 'Total Promotion Budget');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `total_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `upc_qualifier` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC) Qualifier');
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ALTER COLUMN `upc_qualifier` SET TAGS ('dbx_value_regex' = '^[0-9]{1,12}$');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_distribution_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_distribution_allocation` SET TAGS ('dbx_subdomain' = 'campaign_operations');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_distribution_allocation` SET TAGS ('dbx_association_edges' = 'distribution.distribution_center,marketing.brand');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `brand_distribution_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Distribution Allocation - Allocation Id');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Distribution Allocation - Brand Id');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Distribution Allocation - Distribution Center Id');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `primary_stock_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Stock Flag');
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_inventory_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_inventory_allocation` SET TAGS ('dbx_subdomain' = 'campaign_operations');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_inventory_allocation` SET TAGS ('dbx_association_edges' = 'marketing.campaign,inventory.stock_position');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `campaign_inventory_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Inventory Allocation - Allocation Id');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Inventory Allocation - Campaign Id');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Inventory Allocation - Stock Position Id');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `food_beverage_ecm`.`marketing`.`market` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`marketing`.`market` SET TAGS ('dbx_subdomain' = 'consumer_insights');
ALTER TABLE `food_beverage_ecm`.`marketing`.`market` ALTER COLUMN `market_id` SET TAGS ('dbx_business_glossary_term' = 'Market Identifier');
ALTER TABLE `food_beverage_ecm`.`marketing`.`market` ALTER COLUMN `parent_market_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`agency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`marketing`.`agency` SET TAGS ('dbx_subdomain' = 'brand_management');
ALTER TABLE `food_beverage_ecm`.`marketing`.`agency` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier');
ALTER TABLE `food_beverage_ecm`.`marketing`.`agency` ALTER COLUMN `parent_agency_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`agency` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`agency` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`agency` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`agency` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`agency` ALTER COLUMN `tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`marketing`.`agency` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
